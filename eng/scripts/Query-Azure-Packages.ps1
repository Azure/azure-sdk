param (
  $language = "all",
  $folder =  "$PSScriptRoot\..\..\_data\allpackages"
)

function Query-java-Packages
{
  # Rest API docs https://search.maven.org/classic/#api
  $mavenQuery = Invoke-RestMethod "https://search.maven.org/solrsearch/select?q=g:com.microsoft.azure*%20OR%20g:com.azure*&rows=1000&wt=json"

  Write-Host "Found $($mavenQuery.response.numFound) maven packages"
  $packages = $mavenQuery.response.docs | Foreach-Object { [pscustomobject]@{ DisplayName = $_.a; Package = $_.a; GroupId = $_.g; Version = $_.latestVersion; } }
  return $packages
}

function Query-dotnet-Packages
{
  # Rest API docs
  # https://docs.microsoft.com/en-us/nuget/api/search-query-service-resource
  # https://docs.microsoft.com/en-us/nuget/consume-packages/finding-and-choosing-packages#search-syntax
  $nugetQuery = Invoke-RestMethod "https://azuresearch-usnc.nuget.org/query?q=owner:azure-sdk&prerelease=true&semVerLevel=2.0.0&take=1000"

  Write-Host "Found $($nugetQuery.totalHits) nuget packages"
  $packages = $nugetQuery.data | Foreach-Object { [pscustomobject]@{ DisplayName = $_.id; Package = $_.id; Version = $_.version } }
  return $packages
}

function Query-js-Packages
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
  $packages = $npmPackages | Foreach-Object { [pscustomobject]@{ DisplayName = $_.name; Package = $_.name; Version = $_.version } }
  return $packages
}

function Query-python-Packages
{
  $pythonQuery = "import xmlrpc.client; [print(pkg[1]) for pkg in xmlrpc.client.ServerProxy('https://pypi.org/pypi').user_packages('azure-sdk')]"
  $pythonPackagesNames = (python -c "$pythonQuery")

  $pythonPackages = $pythonPackagesNames | Foreach-Object { try { (Invoke-RestMethod "https://pypi.org/pypi/$_/json").info } catch { } }

  Write-Host "Found $($pythonPackages.Count) python packages"
  $packages = $pythonPackages | Foreach-Object { [pscustomobject]@{ DisplayName = $_.name; Package = $_.name; Version = $_.version } }
  return $packages
}

function Output-Latest-Versions($lang)
{
  $packagelistFile = Join-Path $folder "$lang-packages.csv"
  $packageList = Import-Csv $packagelistFile

  if ($null -eq $packageList) { $packageList = @() }

  $extraProperties = [ordered]@{
    Hide = ""
    Notes = ""
    Type = ""
  }
  $LangFunction = "Query-$lang-Packages"
  $packages= &$LangFunction

  foreach ($pkg in $packages)
  {
    $pkgEntries = $packageList | Where-Object { $_.Package -eq $pkg.Package -and $_.GroupId -eq $pkg.GroupId }

    if ($pkgEntries.Count -gt 1) {
      Write-Error "Found $($pkgEntry.Count) package entries for $pkg.Package"
    }
    elseif ($pkgEntries.Count -eq 0) {
      # Add package
      $pkg | Add-Member -NotePropertyMembers $extraProperties -Force
      $packageList += $pkg
    }
    else {
      # Update version of package
      $pkgEntries[0].Version = $pkg.Version
    }
  }

  Write-Host "Writing $packagelistFile"
  $packageList = $packageList | Sort-Object DisplayName, Package, GroupId
  $packageList | Export-Csv -NoTypeInformation $packagelistFile -UseQuotes Always
}

switch($language)
{
  "all" {
    Output-Latest-Versions "java"
    Output-Latest-Versions "js"
    Output-Latest-Versions "dotnet"
    Output-Latest-Versions "python"
    break
  }
  "java" {
    Output-Latest-Versions $language
    break
  }
  "js" {
    Output-Latest-Versions $language
    break
  }
  "dotnet" {
    Output-Latest-Versions $language
    break
  }
  "python" {
    Output-Latest-Versions $language
    break
  }
  default {
    Write-Host "Unrecognized Language: $language"
    exit(1)
  }
}

