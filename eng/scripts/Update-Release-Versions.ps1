[CmdletBinding()]
param (
  [string]$language = "all",
  [bool]$checkDocLinks = $true,
  [bool]$compareTagVsGHIOVersions = $false,
  [string]$github_pat = $env:GITHUB_PAT,
  [string]$inputCacheFile = "https://azuresdkartifacts.blob.core.windows.net/verify-links-cache/verify-links-cache.txt",
  [int]$numMonthsForReleaseTags = 1
)
Set-StrictMode -Version 3
$ProgressPreference = "SilentlyContinue"; # Disable invoke-webrequest progress dialog

. (Join-Path $PSScriptRoot PackageList-Helpers.ps1)

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

$checkedLinks = @{}
function CheckLink($link, $showWarningIfMissing=$true)
{
  if ($checkedLinks.Count -eq 0 -and $inputCacheFile)
  {
    $cacheContent = ""
    if ($inputCacheFile.StartsWith("http")) {
      try {
        $response = Invoke-WebRequest -Uri $inputCacheFile
        $cacheContent = $response.Content
      }
      catch {
        $statusCode = $_.Exception.Response.StatusCode.value__
        Write-Error "Failed to read cache file from  page [$statusCode] $inputCacheFile"
      }
    }
    elseif (Test-Path $inputCacheFile) {
      $cacheContent = Get-Content $inputCacheFile -Raw
    }
    $goodLinks = $cacheContent.Split("`n").Where({ $_.Trim() -ne "" -and !$_.StartsWith("#") })

    foreach ($goodLink in $goodLinks) {
      $checkedLinks[$goodLink] = $true
    }
    Write-Verbose "$($checkedLinks.Count) good links from cache"
  }

  if ($checkedLinks.ContainsKey($link)) {
    if ($showWarningIfMissing -and !$checkedLinks[$link]) {
      Write-Warning "Invalid link $link"
    }
    return $checkedLinks[$link]
  }

  try
  {
    Write-Verbose "Checking $link"
    Invoke-WebRequest -Uri $link
    $checkedLinks[$link] = $true
    return $checkedLinks[$link]
  }
  catch
  {
    if ($showWarningIfMissing) {
      Write-Warning "Invalid link $link"
    }
  }
  $checkedLinks[$link] = $false
  return $checkedLinks[$link]

}

function CheckOptionalLinks($linkTemplates, $pkg, $skipIfNA = $false)
{
  if (!$checkDocLinks) {
    return
  }

  if (!$skipIfNA -or $pkg.MSDocs -eq "")
  {
    $preSuffix = GetLinkTemplateValue $linkTemplates "pre_suffix"
    $msdocLink = GetLinkTemplateValue $linkTemplates "msdocs_url_template" $pkg.Package

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
  }

  # We always perfer to the MSDoc links over GHDocs so they will never be displayed if MSDoc is setup so we
  # don't need to worry about checking the GHDoc links unless MSDocs is NA.
  if ($pkg.MSDocs -ne "NA") 
  {
    return
  }

  if (!$skipIfNA -or $pkg.GHDocs -eq "")
  {
    $ghdocvalid = ($pkg.VersionGA -or $pkg.VersionPreview)
    $ghlink = "[No versioned link yet]"
    if ($pkg.VersionGA) {
      $ghlink = GetLinkTemplateValue $linkTemplates "ghdocs_url_template" $pkg.Package $pkg.VersionGA
      $ghdocvalid = $ghdocvalid -and (CheckLink $ghlink $false)
    }
    if ($pkg.VersionPreview) {
      $ghlink = GetLinkTemplateValue $linkTemplates "ghdocs_url_template" $pkg.Package $pkg.VersionPreview
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
}

function CheckRequiredLinks($linkTemplates, $pkg, $version)
{
  # GroupId only exists for java so we need to test before we try and access
  $groupId = $null
  if ([bool]($pkg.PSobject.Properties.name -match "GroupId")) {
    $groupId = $pkg.GroupId
  }

  $srcLink = GetLinkTemplateValue $linkTemplates "source_url_template" $pkg.Package $version $pkg.RepoPath $groupId
  $valid = $true;
  if (!$pkg.RepoPath.StartsWith("http")) {
    $valid = $valid -and (CheckLink $srcLink)
  }

  $pkgLink = GetLinkTemplateValue $linkTemplates "package_url_template" $pkg.Package $version $pkg.RepoPath $groupId

  $valid = $valid -and (CheckLink $pkgLink)

  return $valid
}

function GetFirstGADate($pkg, $gaVersions)
{
  if ($gaVersions.Count -gt 0) {
    $gaIndex = $gaVersions.Count - 1;
    $otherPackage = $global:otherPackages.Where({ $_.Package -eq $pkg.Package })

    if ($otherPackage.Count -gt 0 -and $otherPackage[0].VersionGA) {
      Write-Verbose "Found other package entry for '$($pkg.Package)'";
      for ($i = 0; $i -lt $gaVersions.Count; $i++) {
        if ($otherPackage[0].VersionGA -eq $gaVersions[$i].RawVersion) {
          Write-Verbose "Found older package entry for '$($pkg.Package)' GA version of $($otherPackage[0].VersionGA) so picking the next GA for first GA date."
          $gaIndex = ($i - 1)
        }
      }
    }
    if ($gaIndex -lt 0) { return "" }
    $gaVersion = $gaVersions[$gaIndex]
    $committeDate = $gaVersion.Date -as [DateTime]

    if ($committeDate) {
      $committeDate = $committeDate.ToString("MM/dd/yyyy")
      Write-Host "For package '$($pkg.Package)' picking GA '$($gaVersion.RawVersion)' shipped on '$committeDate' as the first new GA date."
      return $committeDate
    }
  }
  return ""
}

function GetFirstPreviewDate($pkg, $previewVersions)
{
  if ($previewVersions.Count -gt 0) {
    $previewIndex = $previewVersions.Count - 1;
    $otherPackage = $global:otherPackages.Where({ $_.Package -eq $pkg.Package })

    if ($otherPackage.Count -gt 0 -and $otherPackage[0].VersionPreview) {
      Write-Verbose "Found other package entry for '$($pkg.Package)'";
      for ($i = 0; $i -lt $previewVersions.Count; $i++) {
        if ($otherPackage[0].VersionPreview -eq $previewVersions[$i].RawVersion) {
          Write-Verbose "Found older package entry for '$($pkg.Package)' Preview version of $($otherPackage[0].VersionPreview) so picking the next Preview for first Preview date."
          $gaIndex = ($i - 1)
        }
      }
    }
    if ($previewIndex -lt 0) { return "" }
    $previewVersion = $previewVersions[$previewIndex]
    $committeDate = $previewVersion.Date -as [DateTime]

    if ($committeDate) {
      $committeDate = $committeDate.ToString("MM/dd/yyyy")
      Write-Host "For package '$($pkg.Package)' picking Preview '$($previewVersion.RawVersion)' shipped on '$committeDate' as the first new Preview date."
      return $committeDate
    }
  }
  return ""
}

function Update-Packages($lang, $packageList, $langVersions, $langLinkTemplates)
{
  foreach ($pkg in $packageList)
  {
    $pkgVersion = $null
    
    if ($pkg.PSObject.Properties.Name -contains "GroupId" -and $langVersions.ContainsKey("$($pkg.GroupId)+$($pkg.Package)")) {
      # Some java packages use the GroupId+Package as the tag name so check for that case
      $pkgVersion = $langVersions["$($pkg.GroupId)+$($pkg.Package)"]

      if($pkg.RepoPath -match "^https://github.com/Azure/azure-sdk-for-java/tree/item.Package_item.Version/sdk/(?<serviceDirectory>.*)/item.Package/") {
        # Reset the RepoPath to just the service directory if we have shipped a new version because it should now follow the new GroupId+Package format
        $pkg.RepoPath = $matches["serviceDirectory"]
      }
    }
    elseif ($langVersions.ContainsKey($pkg.Package)) {
      $pkgVersion = $langVersions[$pkg.Package]
    }
    elseif ($langVersions.ContainsKey("")) {
      # Some repos use the same version for all packages so fall back to that case
      $pkgVersion = $langVersions[""]
    }

    if ($null -eq $pkgVersion -or !$pkgVersion.Versions) {
      Write-Verbose "Skipping update for $($pkg.Package) as we don't have version info for it. "
      CheckOptionalLinks $langLinkTemplates $pkg
      continue;
    }

    # Compute the latest versions based on the current versions plus any new versions
    # from the tags taking into account the tag versions don't contain all the versions
    # that have ever shipped.
    $latestGA = $pkg.VersionGA
    $latestPreview = $pkg.VersionPreview
    $versions = $pkgVersion.Versions
    if ($latestGA -and $versions.RawVersion -notcontains $latestGA) { $versions += (ToSemVer $latestGA) }
    if ($latestPreview -and $versions.RawVersion -notcontains $latestPreview) { $versions += (ToSemVer $latestPreview) }
    $versions = [AzureEngSemanticVersion]::SortVersions($versions)

    $latestPreview = $versions[0].RawVersion
    $previewVersions = $versions.Where({ $_.IsPrerelease })
    $gaVersions = $versions.Where({ !$_.IsPrerelease })
    if ($gaVersions.Count -ne 0)
    {
      $latestGA = $gaVersions[0].RawVersion
      $latestGADate = Get-DateFromSemVer $gaVersions[0]
      if ($latestGA -eq $latestPreview) {
        $latestPreview = ""
      }
    }

    $version = $latestGA

    if ($compareTagVsGHIOVersions) {
      $versionFromGH = GetVersionWebContent $lang $pkg.Package "latest-ga"
      if ($versionFromGH -and !$versionFromGH.StartsWith("0.") -and $version -ne $versionFromGH) {
        Write-Warning "Version mismatch for [$($pkg.Package)] GHVersion=[$versionFromGH] TagVersion=[$version]"
      }
    }

    if ($version -eq "") {
      $pkg.VersionGA = ""
    }
    elseif ($pkg.VersionGA -ne $version) {
      if (CheckRequiredLinks $langLinkTemplates $pkg $version){
        Write-Host "Updating VersionGA for '$($pkg.Package)' from '$($pkg.VersionGA)' to '$version'"
        $pkg.VersionGA = $version;
      }
      else {
        Write-Warning "Not updating VersionGA for $($pkg.Package) because at least one associated URL is not valid!"
      }
    }

    if ($pkg.VersionGA) {
      if (!$pkg.FirstGADate) {
        $pkg.FirstGADate = GetFirstGADate $pkg $gaVersions
      }
      if ($latestGADate) {
        $pkg.LatestGADate = $latestGADate
      }
    }

    if (!$pkg.FirstPreviewDate) {
      $pkg.FirstPreviewDate = GetFirstPreviewDate $pkg $previewVersions
    }
    $version = $latestPreview

    if ($compareTagVsGHIOVersions) {
      $versionFromGH = GetVersionWebContent $lang $pkg.Package "latest-preview"
      if ($versionFromGH -and $version -ne $versionFromGH) {
        Write-Warning "Version mismatch for [$($pkg.Package)] GHVersion=[$versionFromGH] TagVersion=[$version]"
      }
    }
    if ($version -eq "") {
      $pkg.VersionPreview = ""
    }
    elseif ($pkg.VersionPreview -ne $version) {
      if (CheckRequiredlinks $langLinkTemplates $pkg $version) {
        Write-Host "Updating VersionPreview for '$($pkg.Package)' from '$($pkg.VersionPreview)' to '$version'"
        $pkg.VersionPreview = $version;
      }
      else {
        Write-Warning "Not updating VersionPreview for $($pkg.Package) because at least one associated URL is not valid!"
      }
    }

    CheckOptionalLinks $langLinkTemplates $pkg
  }
}

function OutputVersions($lang)
{
  Write-Host "Checking $lang for updates..."
  $clientPackages, $global:otherPackages = Get-PackageListForLanguageSplit $lang

  $langVersions = GetPackageVersions $lang -afterDate ([DateTime]::Now.AddMonths(-1 * $numMonthsForReleaseTags))
  $langLinkTemplates = GetLinkTemplates $lang

  Update-Packages $lang $clientPackages $langVersions $langLinkTemplates

  Write-Host "Checking doc links for other packages"
  foreach ($otherPackage in $otherPackages)
  {
    if ($otherPackage.Hide) { continue }
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
    $allClientPackages = Get-PackageListForLanguage $lang
 
    foreach ($pkg in $allClientPackages){
      if(($pkg.Support -eq "deprecated")) {
        if (!$pkg.EOLDate -or $pkg.EOLDate -eq "NA")
        {
          Write-Warning "No EOLDate specified for deprecated package '$($pkg.Package)' in $csvFile."
          $foundIssues = $true
        }
        if (!$pkg.Replace)
        {
          Write-Warning "No replacement package specified for deprecated package '$($pkg.Package)' in $csvFile."
          Write-Warning "If the package name hasn't changed, copy the package name to the replacement library field."
          $foundIssues = $true
        }
        # If a replacement package exists, check if the replacement name matches the deprecated name.
        # Skip the migration guide check if the names are the same.
        elseif ($pkg.Replace -ne $pkg.Package)
        {
          if (!$pkg.ReplaceGuide)
          {
            Write-Warning "No migration guide set for deprecated package '$($pkg.Package)' in $csvFile."
            Write-Warning "Migration guide link should adhere to the following convention 'aka.ms/azsdk/<language>/migrate/<library>'"
            $foundIssues = $true
          }
        }
      }
    }
    
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

      if ($pkg.Type.Tolower() -cne $pkg.Type) {
        Write-Warning "The Type field needs to be all lowercase for '$($pkg.Package)' in $csvFile."
        Write-Host "Please update the CSV to change the Type field from '$($pkg.Type)' equal to $($pkg.Type.ToLower())."
        $foundIssues = $true
      }

      if ($pkg.New.Tolower() -cne $pkg.New) {
        Write-Warning "The New field needs to be all lowercase for '$($pkg.Package)' in $csvFile."
        Write-Host "Please update the CSV to change the New field from '$($pkg.New)' equal to $($pkg.New.ToLower())."
        $foundIssues = $true
      }
    }
  }

  $serviceGroups = $serviceNames | Sort-Object ServiceName | Group-Object ServiceName
  Write-Host "Found $($serviceNames.Count) service name with $($serviceGroups.Count) unique names:"

  foreach ($service in $serviceGroups)
  {
    $languages = $service.Group.Lang | Sort-Object -Unique
    $pkgGroups = $service.Group.PkgInfo | Group-Object DisplayName
    Write-Host "$($service.Name) [$($languages -join ', ')]"
    foreach ($pg in $pkgGroups)
    {
      Write-Host "        $($pg.Name) [$($pg.Group.Package -join ', ')]"
    }
  }

  if ($foundIssues) {
    Write-Error "Found one or more issues with data in the CSV files see the warnings above and fix as appropriate."
    exit 1
  }
}

function DumpAllShippedPackage()
{
  $packageList = @()
  foreach ($lang in $languageNameMapping.Keys)
  {
    $langName = Get-LanguageName $lang

    $packageVersions = GetPackageVersions $lang -afterDate ([DateTime]::Now.AddYears(-10))
    Write-Host "Found $($packageVersions.Values.Count) packages for language $langName"

    foreach ($pkg in $packageVersions.Values)
    {
      foreach ($pkgVersion in $pkg.Versions) 
      {
        $packageList += [PSCustomObject][ordered]@{
          Language = $langName
          Package = $pkg.Package
          Version = $pkgVersion.RawVersion
          Date = $pkgVersion.Date
        }
      }
    }
  }

  Set-Content -Path "shipped-packages.csv" -Value ($packageList | ConvertTo-Csv -NoTypeInformation)
}

if ($language -eq "allShipped") {
  DumpAllShippedPackage
}
elseif ($language -eq 'check') {
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
