param (
  $language = "all",
  $releaseFolder = "$PSScriptRoot\..\..\_data\releases\latest"
)

$releaseFolder = Resolve-Path $releaseFolder

function GetExistingTags($apiUrl)
{
  try
  {
    return (Invoke-RestMethod -Method "GET" -Uri "$apiUrl/git/refs/tags"  ) | % { $_.ref.Replace("refs/tags/", "") }
  }
  catch
  {
    $statusCode = $_.Exception.Response.StatusCode.value__
    $statusDescription = $_.Exception.Response.StatusDescription

    Write-Host "Failed to retrieve tags from repository."
    Write-Host "StatusCode:" $statusCode
    Write-Host "StatusDescription:" $statusDescription
    exit(1)
  }
}

# Regex inspired but simplifie from https://semver.org/#is-there-a-suggested-regular-expression-regex-to-check-a-semver-string
$SEMVER_REGEX = "^(?<major>0|[1-9]\d*)\.(?<minor>0|[1-9]\d*)\.(?<patch>0|[1-9]\d*)(?:-?(?<prelabel>[a-zA-Z-]*)(?:\.?(?<prenumber>0|[1-9]\d*)))?$"

function ToSemVer($version){
  if ($version -match $SEMVER_REGEX)
  {
    if($matches['prelabel'] -eq $null) {
      # artifically provide these values for non-prereleases to enable easy sorting of them later than prereleases.
      $prelabel = "zzz"
      $prenumber = 999;
      $isPre = $false;
    }
    else {
      $prelabel = $matches["prelabel"]
      $prenumber = [int]$matches["prenumber"]
      $isPre = $true;
    }

    New-Object PSObject -Property @{
      Major = [int]$matches['major']
      Minor = [int]$matches['minor']
      Patch = [int]$matches['patch']
      PrereleaseLabel = $prelabel
      PrereleaseNumber = $prenumber
      IsPrerelease = $isPre
      RawVersion = $version
    }
  }
  else
  {
    return $null
  }
}

function SortSemVersions($versions) 
{
   return $versions | Sort -Property Major, Minor, Patch, PrereleaseLabel, PrereleaseNumber -Descending
}

function GetPackageVersions($apiUrl)
{
  $tags = GetExistingTags $apiUrl
  $packageVersions = @{ }
  $packageTags = $tags | % {
    $sp = $_.Split('_');
    if ($sp.Length -eq 2) {
      $package = $sp[0];
      $version = $sp[1];
      if (!$packageVersions.Contains($package)) {
        $packageVersions.Add($package, $(new-object PSObject -Property @{ Versions = @(); LatestGA = ""; LatestPreview = "" }));
      }
      $pv = $packageVersions[$package];
      $sv = ToSemVer $version

      if ($sv -ne $null) {
        $pv.Versions += $sv
      }
    }
  }

  $packageVersions.Keys | % { 
    $pv = $packageVersions[$_];
    if ($pv.Versions.Count -eq 0) { return }

    $versions = SortSemVersions $pv.Versions
    $pv.LatestPreview = $versions[0].RawVersion

    $gaVersions = $versions | ? { !$_.IsPrerelease }
    if ($gaVersions.Count -ne 0) {
      $pv.LatestGA = $gaVersions[0].RawVersion
      if ($pv.LatestGA -eq $pv.LatestPreview) {
        $pv.LatestPreview = ""
      }
    }
    $pv.Versions = $versions
  }
  return $packageVersions
}

function CheckLink($url)
{
  try
  {
    #Write-Host "Checking $url"
    $response = Invoke-WebRequest -Uri $url
    return $true
  }
  catch
  {
    Write-Warning "Invalid link $url"
  }
  return $false
}

function Check-java-links($pkg, $version)
{
  $valid = $true;
  $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-java/tree/{0}_{1}/sdk/{2}/{0}/" -f $pkg.Package, $version, $pkg.RepoPath))
  $valid = $valid -and (CheckLink ("https://search.maven.org/artifact/com.azure/{0}/{1}/jar/" -f $pkg.Package, $version))
  $valid = $valid -and (CheckLink ("https://azuresdkdocs.blob.core.windows.net/`$web/java/{0}/{1}/index.html" -f $pkg.Package, $version))
  return $valid;
}

function Update-java-Packages($packageList, $versions)
{
  foreach ($pkg in $packageList)
  {
    $version = $versions[$pkg.Package].LatestGA
    if ($version -eq "") { 
      $pkg.VersionGA = ""
    }
    elseif (Check-java-links $pkg $version) {
      if ($pkg.VersionGA -ne $version) {
        Write-Host "Updating VersionGA for $($pkg.Package) from $($pkg.VersionGA) to $version"
        $pkg.VersionGA = $version
      }
    }
    else {
      Write-Warning "Not updating VersionGA for $($pkg.Package) because at least one associated URL is not valid!"
    }

    $version = $versions[$pkg.Package].LatestPreview
    if ($version -eq "") {
      $pkg.VersionPreview = ""
    }
    elseif (Check-java-links $pkg $version) {
      if ($pkg.VersionPreview -ne $version) {
        Write-Host "Updating VersionPreview for $($pkg.Package) from $($pkg.VersionPreview) to $version"
        $pkg.VersionPreview = $version
      }
    }
    else {
      Write-Warning "Not updating VersionPreview for $($pkg.Package) because at least one associated URL is not valid!"
    }
  }
}

function Check-js-links($pkg, $version)
{
  $valid = $true;
  $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-js/tree/@azure/{0}_{1}/sdk/{2}/{0}/" -f $pkg.Package, $version, $pkg.RepoPath))
  $valid = $valid -and (CheckLink ("https://www.npmjs.com/package/@azure/{0}/v/{1}" -f $pkg.Package, $version))
  $valid = $valid -and (CheckLink ("https://azuresdkdocs.blob.core.windows.net/`$web/javascript/azure-{0}/{1}/index.html" -f $pkg.Package, $version))
  return $valid
}

function Update-js-Packages($packageList, $versions)
{
  foreach ($pkg in $packageList)
  {
    $version = $versions["@azure/$($pkg.Package)"].LatestGA;
    if ($version -eq "") {
      $pkg.VersionGA = "";
    }
    elseif (Check-js-links $pkg $version) {
      if ($pkg.VersionGA -ne $version) {
        Write-Host "Updating VersionGA $($pkg.Package) from $($pkg.Version) to $version"
        $pkg.VersionGA = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionGA for $($pkg.Package) because at least one associated URL is not valid!"
    }

    $version = $versions["@azure/$($pkg.Package)"].LatestPreview;
    if ($version -eq "") {
      $pkg.VersionPreview = "";
    }
    elseif (Check-js-links $pkg $version) {
      if ($pkg.VersionPreview -ne $version) {
        Write-Host "Updating VersionPreview $($pkg.Package) from $($pkg.Version) to $version"
        $pkg.VersionPreview = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionPreview for $($pkg.Package) because at least one associated URL is not valid!"
    }
  }
}

function Check-dotnet-links($pkg, $version)
{
    $valid = $true;
    $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-net/tree/{0}_{1}/sdk/{2}/{0}/" -f $pkg.Package, $version, $pkg.RepoPath))
    $valid = $valid -and (CheckLink ("https://www.nuget.org/packages/{0}/{1}" -f $pkg.Package, $version))
    $valid = $valid -and (CheckLink ("https://azuresdkdocs.blob.core.windows.net/`$web/dotnet/{0}/{1}/api/index.html" -f $pkg.Package, $version))
    return $valid
}

function Update-dotnet-Packages($packageList, $tf)
{
  foreach ($pkg in $packageList)
  {
    $version = $versions[$pkg.Package].LatestGA;
    if ($version -eq "") {
      $pkg.VersionGA = ""
    }
    elseif(Check-dotnet-links $pkg $version) {
      if ($pkg.VersionGA -ne $version) {
        Write-Host "Updating VersionGA $($pkg.Package) from $($pkg.Version) to $version"
        $pkg.VersionGA = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionGA for $($pkg.Package) because at least one associated URL is not valid!"
    }

    $version = $versions[$pkg.Package].LatestPreview;
    if ($version -eq "") {
      $pkg.VersionPreview = ""
    }
    elseif(Check-dotnet-links $pkg $version) {
      if ($pkg.VersionPreview -ne $version) {
        Write-Host "Updating VersionPreview $($pkg.Package) from $($pkg.Version) to $version"
        $pkg.VersionPreview = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionPreview for $($pkg.Package) because at least one associated URL is not valid!"
    }
  }
}

function Check-python-links($pkg, $version) 
{
    $valid = $true;
    $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-python/tree/{0}_{1}/sdk/{2}/{3}/" -f $pkg.Package, $version, $pkg.RepoPath, $pkg.Package))
    $valid = $valid -and (CheckLink ("https://pypi.org/project/{0}/{1}" -f $pkg.Package, $version))
    $valid = $valid -and (CheckLink ("https://azuresdkdocs.blob.core.windows.net/`$web/python/{0}/{1}/index.html" -f $pkg.Package, $version))
    return $valid
}
function Update-python-Packages($packageList, $tf)
{
  foreach ($pkg in $packageList)
  {
    $version = $versions[$pkg.Package].LatestGA;
    if ($version -eq "") {
      $pkg.VersionGA = ""
    }
    elseif (Check-python-links $pkg $version){
      if ($pkg.VersionGA -ne $version) {
        Write-Host "Updating VersionGA $($pkg.Package) from $($pkg.Version) to $version"
        $pkg.VersionGA = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionGA for $($pkg.Package) because at least one associated URL is not valid!"
    }

    $version = $versions[$pkg.Package].LatestPreview;
    if ($version -eq "") {
      $pkg.VersionPreview = ""
    }
    elseif (Check-python-links $pkg $version){
      if ($pkg.VersionPreview -ne $version) {
        Write-Host "Updating VersionPreview $($pkg.Package) from $($pkg.Version) to $version"
        $pkg.VersionPreview = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionPreview for $($pkg.Package) because at least one associated URL is not valid!"
    }
  }
}

function Output-Latest-Versions($lang)
{
  $packagelistFile = Join-Path $releaseFolder "$lang-packages.csv"
  $packageList = gc $packagelistFile | ConvertFrom-Csv | sort Service

  $apiUrl = "https://api.github.com/repos/azure/azure-sdk-for-$lang"
  if ($lang -eq "dotnet") { $apiUrl = "https://api.github.com/repos/azure/azure-sdk-for-net" }

  $versions = GetPackageVersions $apiUrl

  $LangFunction = "Update-$lang-Packages"
  &$LangFunction $packageList $versions

  Write-Host "Writing $packagelistFile"
  $packageList | ConvertTo-CSV -NoTypeInformation | out-file $packagelistFile -encoding ascii
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

