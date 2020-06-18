param (
  $language = "all",
  $releaseFolder = "$PSScriptRoot\..\..\_data\releases\latest"
)

$releaseFolder = Resolve-Path $releaseFolder

$azuresdkdocs = "https://azuresdkdocs.blob.core.windows.net/`$web"

function GetVersionWebContent($language, $package, $versionType="latest-ga")
{
  $url = "$azuresdkdocs/$language/$package/versioning/$versionType"
  try {
    $response = Invoke-WebRequest -MaximumRetryCount 3 $url
    return [string]$response.Content
  }
  catch {
    Write-Warning "Couldn't get version info for $url"
    return $null
  }
}

function CheckLink($url)
{
  try
  {
    #Write-Host "Checking $url"
    Invoke-WebRequest -Uri $url
    return $true
  }
  catch
  {
    Write-Warning "Invalid link $url"
  }
  return $false
}
function UpdateDocLinks($lang, $pkg)
{
  $version = $pkg.VersionGA
  if ($version -eq "") { $version = $pkg.VersionPreview }

  $trimmedPackage = $pkg.Package -replace "@?azure[\.\-/]", ""
  $msdocvalid = CheckLink "https://docs.microsoft.com/${lang}/api/overview/azure/${trimmedPackage}-readme/"

  if ($msdocvalid) {
    $pkg.MSDocs = ""
  }
  else {
    if ($pkg.MSDocs -eq "" -or $pkg.MSDocs -eq "NA") {
      Write-Host "MSDoc link is not valid so marking as NA"
      $pkg.MSDocs = "NA"
    }
  }
  $ghformat = "{0}/{1}"
  if ($lang -eq "javascript") { $ghformat = "azure-${trimmedPackage}/{1}" }
  elseif ($lang -eq "dotnet") { $ghformat = "{0}/{1}/api" }
  $ghpath = $ghformat -f $pkg.Package, $version 
  $ghdocvalid = CheckLink "$azuresdkdocs/${lang}/${ghpath}/index.html"

  if ($ghdocvalid) {
    $pkg.GHDocs = ""
  }
  else {
    if ($pkg.GHDocs -eq "" -or $pkg.GHDocs -eq "NA") {
      Write-Host "GHDoc link is not valid so marking as NA"
      $pkg.GHDocs = "NA"
    }
  }
}
function Check-java-links($pkg, $version)
{
  $valid = $true;
  $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-java/tree/{0}_{1}/sdk/{2}/{0}/" -f $pkg.Package, $version, $pkg.RepoPath))
  $valid = $valid -and (CheckLink ("https://search.maven.org/artifact/{2}/{0}/{1}/jar/" -f $pkg.Package, $version, $pkg.GroupId))
  return $valid;
}

function Update-java-Packages($packageList)
{
  foreach ($pkg in $packageList)
  {
    $version = GetVersionWebContent "java" $pkg.Package "latest-ga"
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

    $version = GetVersionWebContent "java" $pkg.Package "latest-preview"
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
    UpdateDocLinks "java" $pkg
  }
}

function Check-js-links($pkg, $version)
{
  $trimmedPackage = $pkg.Package.Replace("@azure/", "")
  $valid = $true;
  $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-js/tree/{0}_{1}/sdk/{2}/{3}/" -f $pkg.Package, $version, $pkg.RepoPath, $trimmedPackage))
  $valid = $valid -and (CheckLink ("https://www.npmjs.com/package/{0}/v/{1}" -f $pkg.Package, $version))
  return $valid
}

function Update-js-Packages($packageList)
{
  foreach ($pkg in $packageList)
  {
    $trimmedPackage = $pkg.Package.Replace("@azure/", "")
    $version = GetVersionWebContent "javascript" "azure-${trimmedPackage}" "latest-ga"
    if ($version -eq "") {
      $pkg.VersionGA = "";
    }
    elseif (Check-js-links $pkg $version) {
      if ($pkg.VersionGA -ne $version) {
        Write-Host "Updating VersionGA $($pkg.Package) from $($pkg.VersionGA) to $version"
        $pkg.VersionGA = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionGA for $($pkg.Package) because at least one associated URL is not valid!"
    }

    $version = GetVersionWebContent "javascript" "azure-${trimmedPackage}" "latest-preview"
    if ($version -eq "") {
      $pkg.VersionPreview = "";
    }
    elseif (Check-js-links $pkg $version) {
      if ($pkg.VersionPreview -ne $version) {
        Write-Host "Updating VersionPreview $($pkg.Package) from $($pkg.VersionPreview) to $version"
        $pkg.VersionPreview = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionPreview for $($pkg.Package) because at least one associated URL is not valid!"
    }
    UpdateDocLinks "javascript" $pkg
  }
}

function Check-dotnet-links($pkg, $version)
{
    $valid = $true;
    $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-net/tree/{0}_{1}/sdk/{2}/{0}/" -f $pkg.Package, $version, $pkg.RepoPath))
    $valid = $valid -and (CheckLink ("https://www.nuget.org/packages/{0}/{1}" -f $pkg.Package, $version))
    return $valid
}

function Update-dotnet-Packages($packageList)
{
  foreach ($pkg in $packageList)
  {
    $version = GetVersionWebContent "dotnet" $pkg.Package "latest-ga"
    if ($version -eq "") {
      $pkg.VersionGA = ""
    }
    elseif (Check-dotnet-links $pkg $version) {
      if ($pkg.VersionGA -ne $version) {
        Write-Host "Updating VersionGA $($pkg.Package) from $($pkg.VersionGA) to $version"
        $pkg.VersionGA = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionGA for $($pkg.Package) because at least one associated URL is not valid!"
    }

    $version = GetVersionWebContent "dotnet" $pkg.Package "latest-preview"
    if ($version -eq "") {
      $pkg.VersionPreview = ""
    }
    elseif (Check-dotnet-links $pkg $version) {
      if ($pkg.VersionPreview -ne $version) {
        Write-Host "Updating VersionPreview $($pkg.Package) from $($pkg.VersionPreview) to $version"
        $pkg.VersionPreview = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionPreview for $($pkg.Package) because at least one associated URL is not valid!"
    }
    UpdateDocLinks "dotnet" $pkg
  }
}

function Check-python-links($pkg, $version) 
{
    $valid = $true;
    $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-python/tree/{0}_{1}/sdk/{2}/{0}/" -f $pkg.Package, $version, $pkg.RepoPath))
    $valid = $valid -and (CheckLink ("https://pypi.org/project/{0}/{1}" -f $pkg.Package, $version))
    return $valid
}
function Update-python-Packages($packageList)
{
  foreach ($pkg in $packageList)
  {
    $version = GetVersionWebContent "python" $pkg.Package "latest-ga"
    if ($version -eq "") {
      $pkg.VersionGA = ""
    }
    elseif (Check-python-links $pkg $version){
      if ($pkg.VersionGA -ne $version) {
        Write-Host "Updating VersionGA $($pkg.Package) from $($pkg.VersionGA) to $version"
        $pkg.VersionGA = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionGA for $($pkg.Package) because at least one associated URL is not valid!"
    }

    $version = GetVersionWebContent "python" $pkg.Package "latest-preview"
    if ($version -eq "") {
      $pkg.VersionPreview = ""
    }
    elseif (Check-python-links $pkg $version){
      if ($pkg.VersionPreview -ne $version) {
        Write-Host "Updating VersionPreview $($pkg.Package) from $($pkg.VersionPreview) to $version"
        $pkg.VersionPreview = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionPreview for $($pkg.Package) because at least one associated URL is not valid!"
    }
    UpdateDocLinks "python" $pkg
  }
}

function Output-Latest-Versions($lang)
{
  $packagelistFile = Join-Path $releaseFolder "$lang-packages.csv"
  $packageList = Get-Content $packagelistFile | ConvertFrom-Csv | Sort-Object DisplayName

  $LangFunction = "Update-$lang-Packages"
  &$LangFunction $packageList 

  Write-Host "Writing $packagelistFile"
  $packageList | ConvertTo-CSV -NoTypeInformation -UseQuotes Always | Out-File $packagelistFile -encoding ascii
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

