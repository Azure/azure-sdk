[CmdletBinding()]
param (
  [string] $language = "all",
  [string] $github_pat = $env:GITHUB_PAT
)
Set-StrictMode -Version 3

. (Join-Path $PSScriptRoot PackageList-Helpers.ps1)
. (Join-Path $PSScriptRoot PackageVersion-Helpers.ps1)

function CreatePackage(
  [string]$package,
  [string]$version,
  [string]$groupId = ""
)
{
  $semVer = ToSemVer $version
  $versionGA = $versionPreview = ""

  $isGAVersion = $false

  if ($semVer) {
    $isGAVersion = !$semVer.IsPrerelease
  }
  else {
    # fallback for non semver compliant versions
    $isGAVersion = ($version -match "^[\d\.]+$" -and !$version.StartsWith("0"))
  }

  if ($isGAVersion) {
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
    PlannedVersions = ""
    FirstGADate = ""
    Support = ""
    Hide = ""
    Replace = ""
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

  $publishedPackages = $npmPackages | Where-Object { $_.publisher.username -eq "azure-sdk" }
  $otherPackages = $npmPackages | Where-Object { $_.publisher.username -ne "azure-sdk" }

  foreach ($otherPackage in $otherPackages) {
    Write-Verbose "Not updating package $($otherPackage.name) because the publisher is $($otherPackage.publisher.username) and not azure-sdk"
  }

  Write-Host "Found $($publishedPackages.Count) npm packages"
  $packages = $publishedPackages | Foreach-Object { CreatePackage $_.name $_.version }

  $repoTags = GetPackageVersions "js"

  foreach ($package in $packages)
  {
    # If package starts with arm- and we shipped it recently because it is in the last months repo tags
    # then treat it as a new mgmt library
    if ($package.Package.StartsWith("@azure/arm-") -and $repoTags.ContainsKey($package.Package))
    {
      $package.Type = "mgmt"
      $package.New = "true"
      Write-Host "Marked package $($package.Package) as new mgmt package"
    }
  }

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

function Get-cpp-Packages
{
  $packages = @()
  $repoTags = GetPackageVersions "cpp"

  Write-Host "Found $($repoTags.Count) recent tags in cpp repo"

  foreach ($tag in $repoTags.Keys)
  {
    $versions = [AzureEngSemanticVersion]::SortVersions($repoTags[$tag].Versions)
    $packages += CreatePackage $tag $versions[0]
  }

  return $packages
}

function Get-go-Packages
{
  $packages = @()
  $repoTags = GetPackageVersions "go"

  Write-Host "Found $($repoTags.Count) recent tags in go repo"

  foreach ($tag in $repoTags.Keys)
  {
    $versions = [AzureEngSemanticVersion]::SortVersions($repoTags[$tag].Versions)

    $package = CreatePackage $tag $versions[0]

    if ($package.Package -match "sdk/(?<repopath>(?<service>.*?)/(?<arm>arm)?(?<pkgname>.*))")
    {
      if ($matches["arm"])
      {
        $package.Type = "mgmt"
        $package.New = "true"
        $package.DisplayName = "Resource Management - $((Get-Culture).TextInfo.ToTitleCase($matches["pkgname"]))"
        Write-Host "Marked package $($package.Package) as new mgmt package"
      }
      $package.ServiceName = (Get-Culture).TextInfo.ToTitleCase($matches["service"])
      $package.RepoPath = $matches["repopath"]

      $packages += $package
    }
  }

  return $packages
}

function Write-Latest-Versions($lang)
{
  $packageList = Get-PackageListForLanguage $lang

  if ($null -eq $packageList) { $packageList = @() }

  $LangFunction = "Get-$lang-Packages"
  $packages = &$LangFunction

  $packageLookup = GetPackageLookup $packageList

  foreach ($pkg in $packages)
  {
    $pkgEntry = LookupMatchingPackage $pkg $packageLookup

    if (!$pkgEntry) {
      # alpha packages are not yet fully supported versions so skip adding them to the list yet.
      if ($pkg.VersionPreview -notmatch "-alpha") {
        # Add new package
        $packageList += $pkg
        Write-Host "Adding new package $($pkg.Package)"
      }
    }
    else {
      # For new packages let the Update-Release-Versions script update the versions
      if ($pkgEntry.New -eq "true") {
        continue
      }

      if ($pkg.Type -and $pkg.Type -ne $pkgEntry.Type) {
        $pkgEntry.Type = $pkg.Type
      }

      if ($pkg.New -ne "false" -and $pkg.New -ne $pkgEntry.New) {
        $pkgEntry.New = $pkg.New
      }

      if ($pkgEntry.VersionGA.StartsWith("0")) {
        $pkgEntry.VersionGA = ""
      }

      # Update version of package
      if ($pkg.VersionGA) {
        $pkgEntry.VersionGA = $pkg.VersionGA
        if ($pkgEntry.VersionGA -gt $pkgEntry.VersionPreview) {
          $pkgEntry.VersionPreview = ""
        }
      }
      else {
        $pkgEntry.VersionPreview = $pkg.VersionPreview
      }
    }
  }

  # Clean out packages that are no longer in the query we use for the package manager
  foreach ($pkg in $packageList)
  {
    # Skip the package entries that don't have a Package value as they are just placeholders
    if ($pkg.Package -eq "") { continue }

    $pkgEntry = LookupMatchingPackage $pkg $packageLookup

    if (!$pkgEntry) {
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
    Write-Latest-Versions "cpp"
    Write-Latest-Versions "go"
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
  "cpp" {
    Write-Latest-Versions $language
    break
  }
  "go" {
    Write-Latest-Versions $language
    break
  }
  default {
    Write-Host "Unrecognized Language: $language"
    exit 1
  }
}

