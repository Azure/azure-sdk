[CmdletBinding()]
param (
  [string] $github_pat = $env:GITHUB_PAT,
  # Use long names for languages so data explorer cached string searching is more performant
  [array] $languages = @("java", "dotnet", "python", "javascript", "golang", "cpp"),
  [int] $daysAgo = 730,
  [string] $outPath = "package-data.csv",
  [string] $table = 'PackageReleaseData',
  [switch] $clearTable,
  [switch] $updateDatabase
)

. "$PSScriptRoot\PackageVersion-Helpers.ps1"

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $true
$CachedKustoToken = $null

function Get-java-Packages($daysAgo)
{
  # Rest API docs https://search.maven.org/classic/#api
  $baseMavenQueryUrl = "https://search.maven.org/solrsearch/select?q=g:com.microsoft.azure*%20OR%20g:com.azure*&rows=100&wt=json"
  $mavenQuery = Invoke-RestMethod $baseMavenQueryUrl -MaximumRetryCount 3

  Write-Host "Found $($mavenQuery.response.numFound) java packages on maven packages"

  $packages = @()
  $count = 0
  while ($count -lt $mavenQuery.response.numFound)
  {
    $responsePackages = $mavenQuery.response.docs
    foreach ($pkg in $responsePackages) {
     if ($pkg.g -ne "com.azure.android") {
        $packages += @{ Name = $pkg.a; GroupId = $pkg.g }
      }
    }
    $count += $mavenQuery.response.docs.count

    $mavenQuery = Invoke-RestMethod ($baseMavenQueryUrl + "&start=$count") -MaximumRetryCount 3
  }

  $allPackageVersionList = @()

  $pkgNum = 0
  foreach ($pkg in $packages) {
    $pkgNum++
    $pkgName = $pkg.Name
    $versionsMavenQueryUrl = "https://search.maven.org/solrsearch/select?q=a:${pkgName}&core=gav&rows=1000&wt=json"
    $versionsQuery = Invoke-RestMethod $versionsMavenQueryUrl -MaximumRetryCount 3

    $count = 0
    while ($count -lt $versionsQuery.response.numFound)
    {
      Write-Host "$pkgNum - $count - Getting versions for $($pkg.GroupId):$($pkg.Name)"
      $versions = $versionsQuery.response.docs
      foreach ($ver in $versions) {
        $verDate = [datetimeoffset]::FromUnixTimeMilliseconds($ver.timestamp).DateTime
        $allPackageVersionList += ,(@($pkgName, $ver.v, $verDate))
      }
      $count += $versionsQuery.response.docs.count

      $versionsQuery = Invoke-RestMethod ($versionsMavenQueryUrl + "&start=$count") -MaximumRetryCount 3
    }
  }

  return $allPackageVersionList
}

function Get-dotnet-Packages($daysAgo)
{
  # Rest API docs
  # https://docs.microsoft.com/nuget/api/search-query-service-resource
  # https://docs.microsoft.com/nuget/consume-packages/finding-and-choosing-packages#search-syntax
  $nugetQuery = Invoke-RestMethod "https://azuresearch-usnc.nuget.org/query?q=owner:azure-sdk&prerelease=true&semVerLevel=2.0.0&take=1000" -MaximumRetryCount 3

  Write-Host "Found $($nugetQuery.totalHits) nuget packages"
  $packages = $nugetQuery.data
  $allPackageVersionList = @()

  $pkgNum = 0
  foreach ($pkg in $packages)
  {
    if ($pkg.title -notlike 'Azure.*' -and $pkg.title -notlike 'Microsoft.Azure.*')
    {
      Write-Host "Skipping $($pkg.title)"
      continue
    }
    Write-Host "$pkgNum - Getting versions for $($pkg.title)"
    $versionsQuery = Invoke-RestMethod $pkg.registration -MaximumRetryCount 3
    $versions = $versionsQuery.items
    foreach ($versionGroup in $versions)
    {
      foreach ($versionData in $versionGroup.items)
      {
        $version = ($versionData.packageContent -split '/')[5]
        $time = $versionData.catalogEntry.published
        $allPackageVersionList += ,(@($pkg.title, $version, $time))
      }
    }
    $pkgNum++
  }

  return $allPackageVersionList
}


function Get-javascript-Packages($daysAgo)
{
  $from = 0
  $npmPackages = @()

  do
  {
    # Rest API docs https://github.com/npm/registry/blob/master/docs/REGISTRY-API.md
    # max size returned is 250 so we have to do some basic paging.
    $npmQuery = Invoke-RestMethod "https://registry.npmjs.com/-/v1/search?text=maintainer:azure-sdk&size=250&from=$from" -MaximumRetryCount 3

    if ($npmQuery.objects.Count -ne 0) {
      $npmPackages += $npmQuery.objects.package
    }
    $from += $npmQuery.objects.Count
  } while ($npmQuery.objects.Count -ne 0);

  $publishedPackages = $npmPackages | Where-Object { $_.publisher.username -eq "azure-sdk" }

  Write-Host "Found $($publishedPackages.Count) npm packages"

  $allPackageVersionList = @()
  $pkgNum = 0

  foreach ($pkg in $publishedPackages)
  {
    Write-Host "$pkgNum - Getting versions for $($pkg.name)"
    $versions = npm show $pkg.name time --json | ConvertFrom-Json
    $releases = $versions.PSObject.Properties | Where-Object {
      $_ -notlike "*created*" -and $_ -notlike "*modified*" -and $_ -notlike '*-dev*' -and $_ -notlike '*-alpha*'
    }
    foreach ($release in $releases)
    {
      $allPackageVersionList += ,(@($pkg.name, $release.Name, $release.Value))
    }
    $pkgNum++
  }

  return $allPackageVersionList
}

function Get-python-Packages($daysAgo)
{
  $pythonQuery = "import xmlrpc.client; [print(pkg[1]) for pkg in xmlrpc.client.ServerProxy('https://pypi.org/pypi').user_packages('azure-sdk')]"
  $pythonPackagesNames = (python -c "$pythonQuery")

  $pythonPackages = $pythonPackagesNames | Foreach-Object { try { (Invoke-RestMethod "https://pypi.org/pypi/$_/json" -MaximumRetryCount 3) } catch { } }
  Write-Host "Found $($pythonPackages.Count) python packages"

  $releasesWithDate = @()
  $pkgNum = 0
  foreach ($package in $pythonPackages)
  {
    if ($package.info.name -notlike "azure-*") { Write-Host "Skipping $($package.info.name)"; continue }

    $packageReleases = @()
    foreach ($prop in $package.releases.PSObject.Properties)
    {
      $packageReleases += ,(@($package.info.name, $prop.Name, $prop.Value.upload_time?[0]))
    }
    Write-Host "$pkgNum - $($package.info.name)"
    $pkgNum++
    foreach ($pr in $packageReleases)
    {
      $releasesWithDate += ,($pr)
    }
  }

  return $releasesWithDate
}

function Get-cpp-Packages($daysAgo)
{
  $offset = [DateTimeOffset]::UtcNow.AddDays(-$daysAgo)
  $repoTags = GetPackageVersions -lang "cpp" -afterDate $offset

  Write-Host "Found $($repoTags.Count) recent tags in cpp repo"

  foreach ($tag in $repoTags.Keys)
  {
    foreach ($versionData in $repoTags[$tag].Versions)
    {
      $allPackageVersionList += ,(@($tag, $versionData.RawVersion, (Get-Date $versionData.Date)))
    }
  }

  return $allPackageVersionList
}

function Get-golang-Packages($daysAgo)
{
  $offset = [DateTimeOffset]::UtcNow.AddDays(-$daysAgo)
  $repoTags = GetPackageVersions -lang "go" -afterDate $offset

  Write-Host "Found $($repoTags.Count) recent tags in go repo"

  $allPackageVersionList = @()

  foreach ($tag in $repoTags.Keys)
  {
    # We should keep this regex in sync with what is in the go repo at https://github.com/Azure/azure-sdk-for-go/blob/main/eng/scripts/Language-Settings.ps1#L40
    if ($tag -match "(?<modPath>(sdk|profile)/(?<serviceDir>(.*?(?<serviceName>[^/]+)/)?(?<modName>[^/]+$)))")
    {
      foreach ($versionData in $repoTags[$tag].Versions)
      {
        $allPackageVersionList += ,(@($tag, $versionData.RawVersion, (Get-Date $versionData.Date)))
      }
    }
  }

  return $allPackageVersionList
}

function Set-Package-Data($languages, $daysAgo, $outPath)
{
  $allPackages = @()
  foreach ($lang in $languages)
  {
    $supportedLanguages = @("dotnet", "java", "javascript", "python", "golang", "cpp")
    if ($lang -notin $supportedLanguages)
    {
      throw "Unknown language $lang. Supported languages are $supportedLanguages"
    }
    $packages = Invoke-Expression "Get-$lang-Packages $daysAgo"
    foreach ($pkg in $packages)
    {
      if ($null -eq $pkg[2])
      {
        Write-Warning "No package date for $($pkg[0]) - $($pkg[1])"
        continue
      }
      $pkg += $lang
      if ((Get-Date $pkg[2]) -ge ((Get-Date).AddDays(-$daysAgo)))
      {
        $allPackages += ,@($pkg)
      }
    }
  }

  $allPackages `
    | Sort-Object { $_[2] } `  # Sort by date
    | ForEach-Object { [PSCustomObject]@{ "Date" = $_[2]; "Package" = $_[0]; "Version" = $_[1]; "Language" = $_[3] } } `
    | ConvertTo-Csv -UseQuotes Never `
    | Out-File $outPath
}

# Helper function to view quick package counts for a time period in csv format
function Get-Package-Buckets($languages, $daysAgo)
{
  $today = Get-Date
  $dayHash = @{}
  $datePos = 0
  while ($datePos -ge -$daysAgo)
  {
    # Zero value all dates so data explorer queries and charts are easier to normalize
    $day = Get-Date $today.AddDays($datePos) -Format "yyyy-MM-dd"
    $dayHash[$day] = @{}
    foreach ($lang in $languages)
    {
      $dayHash[$day][$lang] = 0
    }
    $datePos--
  }

  foreach ($lang in $languages)
  {
    $supportedLanguages = @("dotnet", "java", "javascript", "python", "golang", "cpp")
    if ($lang -notin $supportedLanguages)
    {
      throw "Unknown language $lang. Supported languages are $supportedLanguages"
    }
    $total = 0
    $packages = Invoke-Expression "Get-$lang-Packages $daysAgo"
    $recentPackages = $packages | Where-Object { $_[2] -ge $today.AddDays(-$daysAgo) }
    foreach ($pkg in $recentPackages)
    {
      $day = Get-Date $pkg[2] -Format "yyyy-MM-dd"
      $dayHash[$day][$lang] = $dayHash[$day][$lang] + 1
      $total++
    }

    Write-Host "Total packages for $lang - $total"
  }

  $header = @("DATE")
  foreach($lang in $languages)
  {
    $header += $lang.ToUpper()
  }
  Write-Host ($header -join ",")

  foreach ($day in $dayHash.Keys)
  {
    $line = @($day)
    foreach($lang in $languages)
    {
      $line += $dayHash[$day][$lang]
    }
    Write-Host ($line -join ",")
  }
}

function sendDataExplorerCommand([switch]$mgmt, [string]$query)
{
  $cluster = 'https://azsdkengsys.westus2.kusto.windows.net'
  if (!$CachedKustoToken)
  {
    $CachedKustoToken = az account get-access-token --resource $cluster --query accessToken --output tsv
  }
  $secureToken = ConvertTo-SecureString -String $CachedKustoToken -AsPlainText -Force
  $endpoint = if ($mgmt) { "$cluster/v1/rest/mgmt" } else { "$cluster/v2/rest/query" }

  $body = @{ db = 'Pipelines'; csl = $query } | ConvertTo-Json

  $resp = Invoke-RestMethod `
            -Method Post $endpoint `
            -Body $body `
            -Authentication Bearer `
            -Token $secureToken `
            -ContentType 'application/json' `
            -Headers @{ accept = 'application/json' }

  return $resp
}

function Set-DataExplorer([string]$table, [switch]$clearTable)
{
  $ErrorActionPreference = "Stop"

  $packageBlob = 'https://azsdkpackagereleasedata.blob.core.windows.net/data/package-data.csv'

  if ($clearTable)
  {
    Write-Host "Clearing table $table"
    $csl = ".clear table $table data"
    $resp = sendDataExplorerCommand -mgmt -query $csl
  }

  Write-Host "Sleeping 5 seconds to avoid throttling"
  Start-Sleep -Seconds 5

  Write-Host "Ingesting into table $table from $packageBlob"
  $csl = ".ingest into table $table '$packageBlob' with (ignoreFirstRecord=true)"
  try
  {
    $resp = sendDataExplorerCommand -mgmt -query $csl
  }
  catch
  {
    # Data Explorer ingest throttling seems to be 1+ minutes, so add a long wait here for pipeline usage
    Write-Warning "Sleeping 5 minutes before retrying ingest"
    Start-Sleep -Seconds 300
    $resp = sendDataExplorerCommand -mgmt -query $csl
  }

  Write-Host "Sleeping 5 seconds to avoid throttling"
  Start-Sleep -Seconds 5

  Write-Host "Table $table count"
  $csl = "$table | count"
  $resp = sendDataExplorerCommand -query $csl

  $columns = $resp[2].Columns
  $rows = $resp[2].Rows

  Write-Host $columns.ColumnName
  foreach ($row in $rows)
  {
    Write-Host $row
  }
}

# Get-Package-Buckets $Languages $daysAgo
Set-Package-Data $Languages $daysAgo $outPath
if ($updateDatabase)
{
  az storage blob upload -f $outPath --account-name azsdkpackagereleasedata --container-name data --overwrite
  Set-DataExplorer $table $clearTable
}
