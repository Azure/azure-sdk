[CmdletBinding()]
param (
  [string]$language = "all",
  [bool]$checkDocLinks = $true,
  [bool]$compareTagVsGHIOVersions = $false,
  [string] $github_pat = $env:GITHUB_PAT
)
Set-StrictMode -Version 3
$ProgressPreference = "SilentlyContinue"; # Disable invoke-webrequest progress dialog

. (Join-Path $PSScriptRoot PackageList-Helpers.ps1)
. (Join-Path $PSScriptRoot PackageVersion-Helpers.ps1)

function GetVersionWebContent($language, $package, $versionType="latest-ga")
{
  $url = "https://azuresdkdocs.blob.core.windows.net/`$web/$language/$package/versioning/$versionType"
  try {
    $response = Invoke-WebRequest -MaximumRetryCount 3 $url
    return [string]$response.Content
  }
  catch {
    #Write-Warning "Couldn't get version info for $url"
    return $null
  }
}

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

function GetTemplateValue($linkTemplates, $templateName, $packageName = $null, $version = $null, $repoPath = $null, $groupId = $null)
{
  $replacedString = $linkTemplates[$templateName]

  if ($packageName) {
    $packageTrim = $linkTemplates["package_trim"]
    $trimmedPackageName = $pkg.Package -replace "^$packageTrim", ""

    $replacedString = $replacedString -replace "item.Package", $packageName
    $replacedString = $replacedString -replace "item.TrimmedPackage", $trimmedPackageName
  }

  if ($version) {
    $replacedString = $replacedString -replace "item.Version", $version
  }

  if ($repoPath) {
    $replacedString = $replacedString -replace "item.RepoPath", $repoPath
  }

  if ($groupId) {
    $replacedString = $replacedString -replace "item.GroupId", $groupId
  }

  return $replacedString
 }

function CheckOptionalLinks($linkTemplates, $pkg, $skipIfNA = $false) 
{
  if (!$checkDocLinks) {
    return
  }
  if ($skipIfNA -and $pkg.MSDocs -eq "NA" -and $pkg.GHDocs -eq "NA") {
    return
  }

  $preSuffix = GetTemplateValue $linkTemplates "pre_suffix"
  $msdocLink = GetTemplateValue $linkTemplates "msdocs_url_template" $pkg.Package 

  if (!$pkg.VersionGA -and $pkg.VersionPreview -and $preSuffix) { 
    $msdocLink += $preSuffix 
  }

  $msdocvalid = CheckLink $msdocLink $false

  if ($msdocvalid) {
    $pkg.MSDocs = ""
  }
  else {
    if ($pkg.MSDocs -eq "" -or $pkg.MSDocs -eq "NA") {
      Write-Verbose "MSDoc link ($msdocLink) is not valid so marking as NA"
      $pkg.MSDocs = "NA"
    }
  }

  $ghdocvalid = ($pkg.VersionGA -or $pkg.VersionPreview)
  if ($pkg.VersionGA) {
    $ghlink = GetTemplateValue $linkTemplates "ghdocs_url_template" $pkg.Package $pkg.VersionGA
    $ghdocvalid = $ghdocvalid -and (CheckLink $ghlink $false)
  }
  if ($pkg.VersionPreview) {
    $ghlink = GetTemplateValue $linkTemplates "ghdocs_url_template" $pkg.Package $pkg.VersionPreview
    $ghdocvalid = $ghdocvalid -and (CheckLink $ghlink $false)
  }

  if ($ghdocvalid) {
    $pkg.GHDocs = ""
  }
  else {
    if ($pkg.GHDocs -eq "" -or $pkg.GHDocs -eq "NA") {
      Write-Verbose "GHDoc link ($ghlink) is not valid so marking as NA"
      $pkg.GHDocs = "NA"
    }
  }
}
function CheckRequiredLinks($linkTemplates, $pkg, $version) 
{
  $srcLink = GetTemplateValue $linkTemplates "source_url_template" $pkg.Package $version $pkg.RepoPath
  $valid = $true;
  if (!$pkg.RepoPath.StartsWith("http")) {
    $valid = $valid -and (CheckLink $srcLink)
  }

  # GroupId only exists for java so we need to test before we try and access
  $groupId = $null
  if ([bool]($pkg.PSobject.Properties.name -match "GroupId")) {
    $groupId = $pkg.GroupId
  }

  $pkgLink = GetTemplateValue $linkTemplates "package_url_template" $pkg.Package $version $pkg.RepoPath $groupId

  $valid = $valid -and (CheckLink $pkgLink)
  return $valid
}
function Update-Packages($lang, $packageList, $langVersions, $langLinkTemplates)
{
  foreach ($pkg in $packageList)
  {
    if ($langVersions.ContainsKey($pkg.Package)) {
      $pkgVersion = $langVersions[$pkg.Package]
    }
    elseif ($langVersions.ContainsKey("")) {
      # Some repos use the same version for all packages so fall back to that case
      $pkgVersion = $langVersions[""]
    }
    else {
      Write-Host "Skipping update for $($pkg.Package) as we don't have versiong info for it. "
      continue
    }

    $version = $pkgVersion.LatestGA

    if ($null -eq $pkgVersion) {
      Write-Host "Skipping update for $($pkg.Package) as we don't have versiong info for it. "
      continue;
    }

    if ($compareTagVsGHIOVersions) {
      $versionFromGH = GetVersionWebContent $lang $pkg.Package "latest-ga"
      if ($versionFromGH -and !$versionFromGH.StartsWith("0.") -and $version -ne $versionFromGH) {
        Write-Warning "Version mismatch for [$($pkg.Package)] GHVersion=[$versionFromGH] TagVersion=[$version]"
      }
    }

    if ($version -eq "") {
      $pkg.VersionGA = ""
    }
    elseif (CheckRequiredLinks $langLinkTemplates $pkg $version){
      if ($pkg.VersionGA -ne $version) {
        Write-Host "Updating VersionGA $($pkg.Package) from $($pkg.VersionGA) to $version"
        $pkg.VersionGA = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionGA for $($pkg.Package) because at least one associated URL is not valid!"
    }

    $version = $pkgVersion.LatestPreview

    if ($compareTagVsGHIOVersions) {
      $versionFromGH = GetVersionWebContent $lang $pkg.Package "latest-preview"
      if ($versionFromGH -and $version -ne $versionFromGH) {
        Write-Warning "Version mismatch for [$($pkg.Package)] GHVersion=[$versionFromGH] TagVersion=[$version]"
      }
    }
    if ($version -eq "") {
      $pkg.VersionPreview = ""
    }
    elseif (CheckRequiredlinks $langLinkTemplates $pkg $version){
      if ($pkg.VersionPreview -ne $version) {
        Write-Host "Updating VersionPreview $($pkg.Package) from $($pkg.VersionPreview) to $version"
        $pkg.VersionPreview = $version;
      }
    }
    else {
      Write-Warning "Not updating VersionPreview for $($pkg.Package) because at least one associated URL is not valid!"
    }
    CheckOptionalLinks $langLinkTemplates $pkg
  }
}

function OutputVersions($lang)
{
  Write-Host "Checking $lang for updates..."
  $clientPackages, $otherPackages = Get-PackageListForLanguageSplit $lang

  $langVersions = GetPackageVersions $lang
  $langLinkTemplates = @{ }

  $releaseVariableFolder = Resolve-Path "$PSScriptRoot\..\..\_includes\releases\variables\"
  $releaseVariableContent = Get-Content (Join-Path $releaseVariableFolder "$lang.md")
  $releaseVariableContent | ForEach-Object {
    if ($_ -match "{%\s*assign\s*(?<name>\S+)\s*=\s*`"(?<value>\S*)`"\s+%}") { 
      $langLinkTemplates[$matches["name"]] = $matches["value"]
      Write-Verbose ("" + $matches["name"] + " = [" + $matches["value"] + "]")
    }
  }

  Update-Packages $lang $clientPackages $langVersions $langLinkTemplates

  foreach($otherPackage in $otherPackages)
  {
    CheckOptionalLinks $langLinkTemplates $otherPackage -skipIfNA $true
  }

  Set-PackageListForLanguage $lang ($clientPackages + $otherPackages)
}

function OutputAll($langs)
{
  $langs = $langs | Sort-Object
  foreach ($lang in $langs)
  {
    OutputVersions $lang
  }
}

function CheckAll($langs)
{
  $foundIssues = $false
  $serviceNames = @()
  foreach ($lang in $langs) 
  {
    $clientPackages, $_ = Get-PackageListForLanguageSplit $lang
    $csvFile = Get-LangCsvFilePath $lang 

    foreach ($pkg in $clientPackages)
    {
      $serviceNames += [PSCustomObject][ordered]@{
        ServiceName = $pkg.ServiceName
        Lang = $lang
        PkgInfo = $pkg
      }

      if (!$pkg.RepoPath -or $pkg.RepoPath -eq "NA")
      {
        Write-Warning "No RepoPath set for package '$($pkg.Package)' in $csvFile."
        Write-Host "Please set it to the service directory name where it is located. (i.e. <repo>\sdk\*service-directory-name*)."
        $foundIssues = $true
      }

      if (!$pkg.ServiceName)
      {
        Write-Warning "No ServiceName for '$($pkg.Package)' in $csvFile."
        Write-Host "Please set the value to match the display name for the service that is use to align all the similar packages across languages."
        $foundIssues = $true
      }

      if (!$pkg.DisplayName)
      {
        Write-Warning "No DisplayName for '$($pkg.Package)' in $csvFile."
        Write-Host "Please set the value to match the display name for the package that is used to align all the similar packages across languages."
        $foundIssues = $true
      }
    }
  }

  $serviceGroups = $serviceNames | Sort-Object ServiceName | Group-Object ServiceName 
  Write-Host "Found $($serviceNames.Count) service name with $($serviceGroups.Count) unique names:"

  $serviceGroups | Format-Table @{Label="Service Name"; Expression={$_.Name}}, @{Label="Langugages"; Expression={$_.Group.Lang | Sort-Object -Unique}}, Count, @{Label="Packages"; Expression={$_.Group.PkgInfo.Package}}

  if ($foundIssues) {
    Write-Error "Found one or more issues with data in the CSV files see the warnings above and fix as appropriate."
    exit 1
  }
}

if ($language -eq 'check') {
  CheckAll $languageNameMapping.Keys
}
elseif ($language -eq 'all') {
  OutputAll $languageNameMapping.Keys
}
elseif ($languageNameMapping.ContainsKey($language)) {
    OutputVersions $language
}
else {
  Write-Error "Unrecognized Language: $language"
  exit 1
}