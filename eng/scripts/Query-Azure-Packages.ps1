param (
  $language = "all"
)
Set-StrictMode -Version 3

. (Join-Path $PSScriptRoot PackageList-Helpers.ps1)

function PackageEqual($pkg1, $pkg2) {
  if ($pkg1.Package -ne $pkg2.Package) {
    return $false
  }
  if ($pkg1.PSObject.Members.Name -contains "GroupId" -and
      $pkg2.PSObject.Members.Name -contains "GroupId") {
    if ($pkg1.GroupId -and $pkg2.GroupId -and $pkg1.GroupId -ne $pkg2.GroupId) {
      return $false
    }
  }
  return $true
}
function CreatePackage(
  [string]$package, 
  [string]$version,
  [string]$groupId = ""
)
{
  $versionGA = $versionPreview = ""
  if ($version -match "^[\d\.]+$") {
    $versionGA = $version
  }
  else {
    $versionPreview = $version
  }

  return [PSCustomObject][ordered]@{
    Package = $package
    GroupId = $groupId
    VersionGA = $versionGA
    VersionPreview = $versionPreview
    DisplayName = $package
    ServiceName = ""
    RepoPath = "NA"
    MSDocs = "NA"
    GHDocs = "NA"
    Type = ""
    New = "false"
    Hide = ""
    Notes = ""
  };
}
function Get-java-Packages
{
  # Rest API docs https://search.maven.org/classic/#api
  $mavenQuery = Invoke-RestMethod "https://search.maven.org/solrsearch/select?q=g:com.microsoft.azure*%20OR%20g:com.azure*&rows=1000&wt=json"

  Write-Host "Found $($mavenQuery.response.numFound) maven packages"
  $packages = $mavenQuery.response.docs | Foreach-Object { CreatePackage $_.a $_.latestVersion $_.g }
  return $packages
}

function Get-dotnet-Packages
{
  # Rest API docs
  # https://docs.microsoft.com/nuget/api/search-query-service-resource
  # https://docs.microsoft.com/nuget/consume-packages/finding-and-choosing-packages#search-syntax
  $nugetQuery = Invoke-RestMethod "https://azuresearch-usnc.nuget.org/query?q=owner:azure-sdk&prerelease=true&semVerLevel=2.0.0&take=1000"

  Write-Host "Found $($nugetQuery.totalHits) nuget packages"
  $packages = $nugetQuery.data | Foreach-Object { CreatePackage $_.id $_.version }
  return $packages
}

function Get-js-Packages
{
  $from = 0
  $npmPackages = @()

  do
  {
    # Rest API docs https://github.com/npm/registry/blob/master/docs/REGISTRY-API.md
    # max size returned is 250 so we have to do some basic paging.
    $npmQuery = Invoke-RestMethod "https://registry.npmjs.com/-/v1/search?text=maintainer:azure-sdk&size=250&from=$from"

    if ($npmQuery.objects.Count -ne 0) {
      $npmPackages += $npmQuery.objects.package
    }
    $from += $npmQuery.objects.Count
  } while ($npmQuery.objects.Count -ne 0);

  Write-Host "Found $($npmPackages.Count) npm packages"
  $packages = $npmPackages | Foreach-Object { CreatePackage $_.name $_.version }
  return $packages
}

function Get-python-Packages
{
  $pythonQuery = "import xmlrpc.client; [print(pkg[1]) for pkg in xmlrpc.client.ServerProxy('https://pypi.org/pypi').user_packages('azure-sdk')]"
  $pythonPackagesNames = (python -c "$pythonQuery")

  $pythonPackages = $pythonPackagesNames | Foreach-Object { try { (Invoke-RestMethod "https://pypi.org/pypi/$_/json").info } catch { } }

  Write-Host "Found $($pythonPackages.Count) python packages"
  $packages = $pythonPackages | Foreach-Object { CreatePackage $_.name $_.version }
  return $packages
}

function Write-Latest-Versions($lang)
{
  $packageList = Get-PackageListForLanguage $lang

  if ($null -eq $packageList) { $packageList = @() }

  $LangFunction = "Get-$lang-Packages"
  $packages = &$LangFunction

  foreach ($pkg in $packages)
  {
    $pkgEntries = $packageList.Where({ PackageEqual $_ $pkg })

    # If pkgEntries is greater then one filter out the hidden packages
    # as we have some cases were we have duplicates with the older one hidden
    # this to allow us to have entries for when sdk's switched to track 2
    if ($pkgEntries.Count -gt 1) {
      $pkgEntries = $pkgEntries.Where({ $_.Hide -ne "true" })
    }

    if ($pkgEntries.Count -eq 0) {
      # alpha packages are not yet fully supported versions so skip adding them to the list yet.
      if ($pkg.VersionPreview -notmatch "-alpha") {
        # Add new package
        $packageList += $pkg
      }
    } 
    elseif ($pkgEntries.Count -gt 1) {
      Write-Error "Found $($pkgEntries.Count) package entries for $($pkg.Package + $pkg.GroupId)"
    }
    else {
      # Update version of package
      if ($pkg.VersionGA) {
        $pkgEntries[0].VersionGA = $pkg.VersionGA
        if ($pkgEntries[0].VersionGA -gt $pkgEntries[0].VersionPreview) {
          $pkgEntries[0].VersionPreview = ""
        }
      }
      else {
        $pkgEntries[0].VersionPreview = $pkg.VersionPreview
      }
    }
  }

  # Clean out packages that are no longer in the query we use for the package manager
  foreach ($pkg in $packageList)
  {
    # Skip the package entries that don't have a Package value as they are just placeholders
    if ($pkg.Package -eq "") { continue }

    $pkgEntries = $packages.Where({ PackageEqual $_ $pkg })

    if ($pkgEntries.Count -ne 1) {
      Write-Verbose "Found package $($pkg.Package) in the CSV which could be removed"
    }
  }

  Set-PackageListForLanguage $lang $packageList
}

switch($language)
{
  "all" {
    Write-Latest-Versions "java"
    Write-Latest-Versions "js"
    Write-Latest-Versions "dotnet"
    Write-Latest-Versions "python"
    break
  }
  "java" {
    Write-Latest-Versions $language
    break
  }
  "js" {
    Write-Latest-Versions $language
    break
  }
  "dotnet" {
    Write-Latest-Versions $language
    break
  }
  "python" {
    Write-Latest-Versions $language
    break
  }
  default {
    Write-Host "Unrecognized Language: $language"
    exit 1
  }
}

