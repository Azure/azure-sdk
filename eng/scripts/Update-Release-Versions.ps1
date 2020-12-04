param (
  $language = "all",
  $releaseFolder = "$PSScriptRoot\..\..\_data\releases\latest",
  $checkDocLinks = $true
)
Set-StrictMode -Version 3

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

$ProgressPreference = "SilentlyContinue"; # Disable invoke-webrequest progress dialog
function CheckLink($url, $showWarningIfMissing=$true)
{
  try
  {
    #Write-Host "Checking $url"
    Invoke-WebRequest -Uri $url
    return $true
  }
  catch
  {
    if ($showWarningIfMissing) {
      Write-Warning "Invalid link $url"
    }
  }
  return $false
}

function UpdateDocLinks($lang, $pkg, $skipIfNA = $false)
{
  if (!$checkDocLinks) {
    return
  }
  if ($skipIfNA -and $pkg.MSDocs -eq "NA" -and $pkg.GHDocs -eq "NA") {
    return
  }

  if ($lang -eq "js") { $lang = "javascript" }

  $trimmedPackage = $pkg.Package -replace "@?azure[\.\-/]", ""

  $suffix = ""
  if (!$pkg.VersionGA -and $pkg.VersionPreview) { $suffix = "-pre" }

  $msdocLink = "https://docs.microsoft.com/${lang}/api/overview/azure/${trimmedPackage}-readme${suffix}/"
  $msdocvalid = CheckLink $msdocLink $false 

  if ($msdocvalid) {
    $pkg.MSDocs = ""
  }
  else {
    if ($pkg.MSDocs -eq "" -or $pkg.MSDocs -eq "NA") {
      Write-Host "MSDoc link ($msdocLink) is not valid so marking as NA"
      $pkg.MSDocs = "NA"
    }
  }
  $ghformat = "{0}/{1}"
  if ($lang -eq "javascript") { $ghformat = "azure-${trimmedPackage}/{1}" }
  elseif ($lang -eq "dotnet") { $ghformat = "{0}/{1}/api" }

  $ghLinkFormat = "$azuresdkdocs/${lang}/${ghformat}/index.html"

  $ghdocvalid = ($pkg.VersionGA -or $pkg.VersionPreview)
  if ($pkg.VersionGA) {
    $ghlink = $ghLinkFormat -f $pkg.Package, $pkg.VersionGA
    $ghdocvalid = $ghdocvalid -and (CheckLink $ghlink $false)
  }
  if ($pkg.VersionPreview) {
    $ghlink = $ghLinkFormat -f $pkg.Package, $pkg.VersionPreview
    $ghdocvalid = $ghdocvalid -and (CheckLink $ghlink $false)
  }

  if ($ghdocvalid) {
    $pkg.GHDocs = ""
  }
  else {
    if ($pkg.GHDocs -eq "" -or $pkg.GHDocs -eq "NA") {
      Write-Host "GHDoc link ($ghlink) is not valid so marking as NA"
      $pkg.GHDocs = "NA"
    }
  }
}
function Check-java-links($pkg, $version)
{
  $valid = $true;
  if (!$pkg.RepoPath.StartsWith("http")) {
    $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-java/tree/{0}_{1}/sdk/{2}/{0}/" -f $pkg.Package, $version, $pkg.RepoPath))
  }
  $valid = $valid -and (CheckLink ("https://search.maven.org/artifact/{2}/{0}/{1}/jar/" -f $pkg.Package, $version, $pkg.GroupId))
  return $valid;
}

function Update-java-Packages($packageList)
{
  foreach ($pkg in $packageList)
  {
    $version = GetVersionWebContent "java" $pkg.Package "latest-ga"

    if ($null -eq $version) {
      Write-Host "Skipping update for $($pkg.Package) as we don't have versiong info for it. "
      continue;
    }

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
  if (!$pkg.RepoPath.StartsWith("http")) {
    $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-js/tree/{0}_{1}/sdk/{2}/{3}/" -f $pkg.Package, $version, $pkg.RepoPath, $trimmedPackage))
  }
  $valid = $valid -and (CheckLink ("https://www.npmjs.com/package/{0}/v/{1}" -f $pkg.Package, $version))
  return $valid
}

function Update-js-Packages($packageList)
{
  foreach ($pkg in $packageList)
  {
    $trimmedPackage = $pkg.Package.Replace("@azure/", "")
    $version = GetVersionWebContent "javascript" "azure-${trimmedPackage}" "latest-ga"

    if ($null -eq $version) {
      Write-Host "Skipping update for $($pkg.Package) as we don't have versiong info for it. "
      continue;
    }

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
    if (!$pkg.RepoPath.StartsWith("http")) {
      $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-net/tree/{0}_{1}/sdk/{2}/{0}/" -f $pkg.Package, $version, $pkg.RepoPath))
    }
    $valid = $valid -and (CheckLink ("https://www.nuget.org/packages/{0}/{1}" -f $pkg.Package, $version))
    return $valid
}

function Update-dotnet-Packages($packageList)
{
  foreach ($pkg in $packageList)
  {
    $version = GetVersionWebContent "dotnet" $pkg.Package "latest-ga"
    if ($null -eq $version) {
      Write-Host "Skipping update for $($pkg.Package) as we don't have versiong info for it. "
      continue;
    }

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
    if (!$pkg.RepoPath.StartsWith("http")) {
      $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-python/tree/{0}_{1}/sdk/{2}/{0}/" -f $pkg.Package, $version, $pkg.RepoPath))
    }
    $valid = $valid -and (CheckLink ("https://pypi.org/project/{0}/{1}" -f $pkg.Package, $version))
    return $valid
}
function Update-python-Packages($packageList)
{
  foreach ($pkg in $packageList)
  {
    $version = GetVersionWebContent "python" $pkg.Package "latest-ga"
    if ($null -eq $version) {
      Write-Host "Skipping update for $($pkg.Package) as we don't have versiong info for it. "
      continue;
    }

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

function Check-c-links($pkg, $version) 
{
    $valid = $true;
    if (!$pkg.RepoPath.StartsWith("http")) {
      $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-c/tree/{0}/sdk/{1}" -f $version, $pkg.RepoPath))
    }
    $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-c/archive/{0}.zip" -f $version))
    return $valid
}
function Update-c-Packages($packageList)
{
  foreach ($pkg in $packageList)
  {
    $version = GetVersionWebContent "c" $pkg.Package "latest-ga"
    if ($null -eq $version) {
      Write-Host "Skipping update for $($pkg.Package) as we don't have versiong info for it. "
      continue;
    }

    if ($version -eq "") {
      $pkg.VersionGA = ""
    }
    elseif (Check-c-links $pkg $version){
      if ($pkg.VersionGA -ne $version) {
        Write-Host "Updating VersionGA $($pkg.Package) from $($pkg.VersionGA) to $version"
        $pkg.VersionGA = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionGA for $($pkg.Package) because at least one associated URL is not valid!"
    }

    $version = GetVersionWebContent "c" $pkg.Package "latest-preview"
    if ($version -eq "") {
      $pkg.VersionPreview = ""
    }
    elseif (Check-c-links $pkg $version){
      if ($pkg.VersionPreview -ne $version) {
        Write-Host "Updating VersionPreview $($pkg.Package) from $($pkg.VersionPreview) to $version"
        $pkg.VersionPreview = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionPreview for $($pkg.Package) because at least one associated URL is not valid!"
    }
    UpdateDocLinks "c" $pkg
  }
}

function Check-cpp-links($pkg, $version)
{
    $valid = $true;
    if (!$pkg.RepoPath.StartsWith("http")) {
      $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-cpp/tree/{0}_{1}/sdk/{2}/{0}" -f $pkg.Package, $version, $pkg.RepoPath))
    }
    $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-cpp/archive/{0}_{1}.zip" -f $pkg.Package, $version))
    return $valid
}
function Update-cpp-Packages($packageList)
{
  foreach ($pkg in $packageList)
  {
    $version = GetVersionWebContent "cpp" $pkg.Package "latest-ga"
    if ($null -eq $version) {
      Write-Host "Skipping update for $($pkg.Package) as we don't have versiong info for it. "
      continue;
    }

    if ($version -eq "") {
      $pkg.VersionGA = ""
    }
    elseif (Check-cpp-links $pkg $version){
      if ($pkg.VersionGA -ne $version) {
        Write-Host "Updating VersionGA $($pkg.Package) from $($pkg.VersionGA) to $version"
        $pkg.VersionGA = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionGA for $($pkg.Package) because at least one associated URL is not valid!"
    }

    $version = GetVersionWebContent "cpp" $pkg.Package "latest-preview"
    if ($version -eq "") {
      $pkg.VersionPreview = ""
    }
    elseif (Check-cpp-links $pkg $version){
      if ($pkg.VersionPreview -ne $version) {
        Write-Host "Updating VersionPreview $($pkg.Package) from $($pkg.VersionPreview) to $version"
        $pkg.VersionPreview = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionPreview for $($pkg.Package) because at least one associated URL is not valid!"
    }
    UpdateDocLinks "cpp" $pkg
  }
}

function Check-android-links($pkg, $version)
{
  $valid = $true;
  if (!$pkg.RepoPath.StartsWith("http")) {
    $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-android/tree/{0}_{1}/sdk/{2}/{0}/" -f $pkg.Package, $version, $pkg.RepoPath))
  }
  $valid = $valid -and (CheckLink ("https://search.maven.org/artifact/{2}/{0}/{1}/aar/" -f $pkg.Package, $version, $pkg.GroupId))
  return $valid;
}

function Update-android-Packages($packageList)
{
  foreach ($pkg in $packageList)
  {
    $version = GetVersionWebContent "android" $pkg.Package "latest-ga"

    if ($null -eq $version) {
      Write-Host "Skipping update for $($pkg.Package) as we don't have versiong info for it. "
      continue;
    }

    if ($version -eq "") {
      $pkg.VersionGA = ""
    }
    elseif (Check-android-links $pkg $version) {
      if ($pkg.VersionGA -ne $version) {
        Write-Host "Updating VersionGA for $($pkg.Package) from $($pkg.VersionGA) to $version"
        $pkg.VersionGA = $version
      }
    }
    else {
      Write-Warning "Not updating VersionGA for $($pkg.Package) because at least one associated URL is not valid!"
    }

    $version = GetVersionWebContent "android" $pkg.Package "latest-preview"
    if ($version -eq "") {
      $pkg.VersionPreview = ""
    }
    elseif (Check-android-links $pkg $version) {
      if ($pkg.VersionPreview -ne $version) {
        Write-Host "Updating VersionPreview for $($pkg.Package) from $($pkg.VersionPreview) to $version"
        $pkg.VersionPreview = $version
      }
    }
    else {
      Write-Warning "Not updating VersionPreview for $($pkg.Package) because at least one associated URL is not valid!"
    }
    UpdateDocLinks "android" $pkg
  }
}

function Check-ios-links($pkg, $version)
{
  $valid = $true;
  if (!$pkg.RepoPath.StartsWith("http")) {
    $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-ios/tree/{0}/sdk/{1}" -f $version, $pkg.RepoPath))
  }
  $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-ios/archive/{0}.zip" -f $version))
  return $valid
}
function Update-ios-Packages($packageList)
{
  foreach ($pkg in $packageList)
  {
    $version = GetVersionWebContent "ios" $pkg.Package "latest-ga"
    if ($null -eq $version) {
      Write-Host "Skipping update for $($pkg.Package) as we don't have versiong info for it. "
      continue;
    }

    if ($version -eq "") {
      $pkg.VersionGA = ""
    }
    elseif (Check-ios-links $pkg $version){
      if ($pkg.VersionGA -ne $version) {
        Write-Host "Updating VersionGA $($pkg.Package) from $($pkg.VersionGA) to $version"
        $pkg.VersionGA = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionGA for $($pkg.Package) because at least one associated URL is not valid!"
    }

    $version = GetVersionWebContent "ios" $pkg.Package "latest-preview"
    if ($version -eq "") {
      $pkg.VersionPreview = ""
    }
    elseif (Check-ios-links $pkg $version){
      if ($pkg.VersionPreview -ne $version) {
        Write-Host "Updating VersionPreview $($pkg.Package) from $($pkg.VersionPreview) to $version"
        $pkg.VersionPreview = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionPreview for $($pkg.Package) because at least one associated URL is not valid!"
    }
    UpdateDocLinks "ios" $pkg
  }
}

function Output-Latest-Versions($lang)
{
  $packagelistFile = Join-Path $releaseFolder "$lang-packages.csv"
  $packageList = Get-Content $packagelistFile | ConvertFrom-Csv | Sort-Object Type, DisplayName, Package, GroupId, ServiceName

  # Only update libraries that have a type
  $clientPackages = $packageList | Where-Object { $_.New -eq "true" -and $_.Type }
  $otherPackages = $packageList | Where-Object { $_.New -ne "true" -or !$_.Type }

  $LangFunction = "Update-$lang-Packages"
  &$LangFunction $clientPackages

  foreach($otherPackage in $otherPackages)
  {
    UpdateDocLinks $lang $otherPackage -skipIfNA $true
  }

  Write-Host "Writing $packagelistFile"
  $packageList = $clientPackages + $otherPackages
  $packageList | ConvertTo-CSV -NoTypeInformation -UseQuotes Always | Out-File $packagelistFile -encoding ascii
}
$langs = @("java", "js", "dotnet", "python", "c", "cpp", "ios", "android")
function CheckAll
{
  $serviceNames = @()
  foreach ($lang in $langs) 
  {
    $packagelistFile = Join-Path $releaseFolder "$lang-packages.csv"
    $packageList = Get-Content $packagelistFile | ConvertFrom-Csv | Sort-Object Type, DisplayName, Package, GroupId, ServiceName
    $clientPackages = $packageList | Where-Object { $_.New -eq "true" -and $_.Type }

    foreach ($pkg in $clientPackages)
    {
      $serviceNames += [PSCustomObject][ordered]@{
        ServiceName = $pkg.ServiceName
        Lang = $lang
        PkgInfo = $pkg
      }

      if ($pkg.RepoPath -and $pkg.RepoPath -eq "NA")
      {
        Write-Warning "[$lang] $($pkg.Package) RepoPath set to $($pkg.RepoPath)" 
      }

      if (!$pkg.ServiceName)
      {
        Write-Warning "No ServiceName for [$lang] $($pkg.Package)"
      }

      if (!$pkg.DisplayName)
      {
        Write-Warning "No DisplayName for [$lang] $($pkg.Package)"
      }
    }
  }

  $serviceGroups = $serviceNames | Sort-Object ServiceName | Group-Object ServiceName 
  Write-Host "Found $($serviceNames.Count) service name with $($serviceGroups.Count) unique names:"

  $serviceGroups | Select-Object Name, @{Label="Langugages"; Expression={$_.Group.Lang | Sort-Object -Unique}}, Count, @{Label="Packages"; Expression={$_.Group.PkgInfo.Package}}
}

switch($language)
{
  "check" {
    CheckAll
  }
  "all" {
    Output-Latest-Versions "java"
    Output-Latest-Versions "js"
    Output-Latest-Versions "dotnet"
    Output-Latest-Versions "python"
    Output-Latest-Versions "c"
    Output-Latest-Versions "cpp"
    # Output-Latest-Versions "android"
    # Output-Latest-Versions "ios"
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
  "c" {
    Output-Latest-Versions $language
    break
  }
  "cpp" {
    Output-Latest-Versions $language
    break
  }
  "android" {
    Output-Latest-Versions $language
    break
  }
  "ios" {
    Output-Latest-Versions $language
    break
  }
  default {
    Write-Host "Unrecognized Language: $language"
    exit 1
  }
}

