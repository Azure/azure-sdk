. (Join-Path $PSScriptRoot PackageVersion-Helpers.ps1)

$releaseFolder = Resolve-Path "$PSScriptRoot\..\..\_data\releases\latest"

$languageNameMapping = @{
  c = "C" # -- These don't follow normal tagging rules
  cpp = "C++"
  dotnet = ".NET"
  java = "Java"
  js = "JavaScript"
  python = "Python"
  go = "Go" # -- No csv or tagging info
  ios = "iOS" # -- These don't follow normal tagging rules
  android = "Android" # -- These don't follow normal tagging/githubio rules
  rust = "Rust"
}

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

  $pkg = [PSCustomObject][ordered]@{
    Package = $package
  }

  if ($groupId) {
    $pkg | Add-Member -NotePropertyName "GroupId" -NotePropertyValue $groupId
  }

  $otherProps = [ordered]@{
    VersionGA = $versionGA
    VersionPreview = $versionPreview
    DisplayName = "Unknown Display Name"
    ServiceName = "Unknown Service"
    RepoPath = "NA"
    MSDocs = "NA"
    GHDocs = "NA"
    Type = ""
    New = "false"
    PlannedVersions = ""
    LatestGADate = ""
    FirstGADate = ""
    FirstPreviewDate = ""
    Support = ""
    EOLDate = ""
    Hide = ""
    Replace = ""
    ReplaceGuide = ""
    MSDocService = ""
    ServiceId = ""
    Notes = "Needs Review"
  }

  $pkg | Add-Member -NotePropertyMembers $otherProps

  return $pkg
}

function ClonePackage($pkg)
{
  return [PSCustomObject][ordered]@{
    Package = $pkg.Package
    GroupId = $pkg.GroupId
    VersionGA = $pkg.VersionGA
    VersionPreview = $pkg.VersionPreview
    DisplayName = $pkg.DisplayName
    ServiceName = $pkg.ServiceName
    RepoPath = $pkg.RepoPath
    MSDocs = $pkg.MSDocs
    GHDocs = $pkg.GHDocs
    Type = $pkg.Type
    New = $pkg.New
    PlannedVersions = $pkg.PlannedVersions
    LatestGADate = $pkg.LatestGADate
    FirstGADate = $pkg.FirstGADate
    FirstPreviewDate = $pkg.FirstPreviewDate
    Support = $pkg.Support
    EOLDate = $pkg.EOLDate
    Hide = $pkg.Hide
    Replace = $pkg.Replace
    ReplaceGuide = $pkg.ReplaceGuide
    MSDocService = $pkg.MSDocService
    ServiceId = $pkg.ServiceId
    Notes = $pkg.Notes
  };
}

function Get-LanguageName($lang)
{
  $pkgLang = $languageNameMapping[$lang]
  if (!$pkgLang) {
    $pkgLang = $lang
  }
  return $pkgLang
}

function Get-LangCsvFilePath($lang)
{
  $lang = $lang.ToLower()
  if ($languageNameMapping.ContainsKey($lang)) {
    return Join-Path $releaseFolder "$lang-packages.csv"
  }
  foreach ($key in $languageNameMapping.Keys)
  {
    if ($languageNameMapping[$key] -eq $lang) {
      return Join-Path $releaseFolder "$key-packages.csv"
    }
  }
  throw "Language $lang as it isn't in the language mapping."
}

function Get-PackageListForLanguage([string]$lang)
{
  $packagelistFile = Get-LangCsvFilePath $lang
  $packageList = Get-Content $packagelistFile | ConvertFrom-Csv | Sort-Object Type, DisplayName, Package, GroupId, ServiceName
  return $packageList
}

function Get-PackageLookupForLanguage([string]$lang)
{
  return GetPackageLookup (Get-PackageListForLanguage $lang)
}

function Get-PackageListSplit([Array]$packageList)
{
  $newPackages = $packageList.Where({ $_.Hide -ne "true" -and $_.New -eq "true" })
  $otherPackages = $packageList.Where({ !($_.Hide -ne "true" -and $_.New -eq "true") })

  return ($newPackages, $otherPackages)
}

function Get-PackageListForLanguageSplit([string]$lang)
{
  return Get-PackageListSplit (Get-PackageListForLanguage $lang)
}

function Set-PackageListForLanguage([string]$lang, [Array]$packageList)
{
  $packagelistFile = Get-LangCsvFilePath $lang
  Write-Host "Writing $packagelistFile"

  $new, $other = Get-PackageListSplit $packageList

  $new = $new | Sort-Object Type, DisplayName, Package, GroupId, ServiceName, Support
  $other = $other | Sort-Object Type, DisplayName, Package, GroupId, ServiceName, Support

  $sortedPackages = $new + $other
  $sortedPackages | ConvertTo-CSV -NoTypeInformation -UseQuotes Always | Out-File $packagelistFile -encoding ascii
}

function Get-CombinedPackageListForPlannedVersions($pkgFilter)
{
  $allPackages = @()
  foreach ($lang in $languageNameMapping.Keys)
  {
    $mappedLang = $languageNameMapping[$lang]
    $clientPkgs, $_ = Get-PackageListForLanguageSplit $lang

    foreach ($pkg in $clientPkgs) {
      if ($pkgFilter -and $pkg.Package -notmatch $pkgFilter) { continue }

      $pkg | Add-Member -NotePropertyName "Language" -NotePropertyValue $mappedLang
      $pkg | Add-Member -NotePropertyName "PlannedVersion" -NotePropertyValue ""
      $pkg | Add-Member -NotePropertyName "PlannedDate" -NotePropertyValue ""

      # Create an entry for each planned package
      if ($pkg.PlannedVersions) {
        $plannedVersions = $pkg.PlannedVersions.Split("|").Trim().Where({ $_ })

        foreach ($plannedVersion in $plannedVersions)
        {
          $pkgPlannedVersion = $pkg.PSObject.Copy()
          $pkgPlannedVersion.PlannedVersion, $pkgPlannedVersion.PlannedDate = $plannedVersion.Split(",")
          $allPackages += $pkgPlannedVersion
        }
      }

      $allPackages += $pkg
    }
  }

  $latestVersion = @{label="LatestVersion"; expression={ if ($_.VersionGA) { $_.VersionGA } else { $_.VersionPreview }}}
  return $allPackages | Select-Object "Language", "Package", "DisplayName", "ServiceName", "PlannedVersion", "PlannedDate", $latestVersion, "RepoPath", "Type", "New" | Sort-Object "Language", "Package"
}

function Add-NewFieldToAll($field, $afterField)
{
  foreach ($lang in $languageNameMapping.Keys)
  {
    Add-NewFieldToLanguage $lang $field $afterField
  }
}

function Add-NewFieldToLanguage($lang, $field, $afterField = $null, $fieldDefaultValue="")
{
  $packageList = Get-PackageListForLanguage $lang

  $updatedPackageList = @()
  foreach ($pkg in $packageList)
  {
    $orderedPkg = [ordered]@{ }

    foreach ($prop in $pkg.PSObject.Properties.Name)
    {
      $orderedPkg[$prop] = $pkg.$prop
      if ($afterField -eq $prop)
      {
        $orderedPkg[$field] = $fieldDefaultValue
      }
    }
    if (!$afterField) {
      $orderedPkg[$field] = $fieldDefaultValue
    }

    $updatedPackageList += [pscustomobject]$orderedPkg
  }

  Set-PackageListForLanguage $lang $updatedPackageList
}

function Add-NewFieldToSpecs($field, $afterField = $null, $fieldDefaultValue="")
{
  $speclistFile = Join-Path $releaseFolder "specs.csv"
  $packageList = Get-Content $speclistFile | ConvertFrom-Csv

  $updatedPackageList = @()
  foreach ($pkg in $packageList)
  {
    $orderedPkg = [ordered]@{ }

    foreach ($prop in $pkg.PSObject.Properties.Name)
    {
      $orderedPkg[$prop] = $pkg.$prop
      if ($afterField -eq $prop)
      {
        $orderedPkg[$field] = $fieldDefaultValue
      }
    }
    if (!$afterField) {
      $orderedPkg[$field] = $fieldDefaultValue
    }

    $updatedPackageList += [pscustomobject]$orderedPkg
  }

  $new = @($updatedPackageList | Where-Object { $_.IsTypeSpec -eq "True" } | Sort-Object ServiceFamily, ResourcePath, SpecPath)
  $other = @($updatedPackageList | Where-Object { $_.IsTypeSpec -ne "True" } |  Sort-Object ServiceFamily, ResourcePath, SpecPath)

  $sortedSpecs = $new + $other
  $sortedSpecs | ConvertTo-CSV -NoTypeInformation -UseQuotes Always | Out-File $speclistFile -encoding ascii
}

function PackageEqual($pkg1, $pkg2)
{
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

function GetPackageKey($pkg)
{
  $pkgKey = $pkg.Package
  $groupId = $null

  if ($pkg.PSObject.Members.Name -contains "GroupId") {
    $groupId = $pkg.GroupId
  }

  if ($groupId) {
    $pkgKey = "${groupId}:${pkgKey}"
  }

  return $pkgKey
}

function GetPackageLookup($packageList)
{
  $packageLookup = @{}

  foreach ($pkg in $packageList)
  {
    $pkgKey = GetPackageKey $pkg

    # We want to prefer updating non-hidden packages but if there is only
    # a hidden entry then we will return that
    if (!$packageLookup.ContainsKey($pkgKey) -or $packageLookup[$pkgKey].Hide -eq "true")
    {
      $packageLookup[$pkgKey] = $pkg
    }
    else
    {
      # Warn if there are more then one non-hidden package
      if ($pkg.Hide -ne "true") {
        Write-Host "Found more than one package entry for $($pkg.Package) selecting the first non-hidden one."
      }
    }

    if ($pkg.PSObject.Members.Name -contains "GroupId" -and ($pkg.New -eq "true") -and $pkg.Package) {
      $pkgKey = $pkg.Package
      if (!$packageLookup.ContainsKey($pkgKey))
      {
        $packageLookup[$pkgKey] = $pkg
      }
      else
      {
        $packageValue = $packageLookup[$pkgKey]
        Write-Host "Found more than one package entry for $($packageValue.Package) selecting the first one with groupId $($packageValue.GroupId), skipping $($pkg.GroupId)"
      }
    }
  }

  return $packageLookup
}

function LookupMatchingPackage($pkg, $packageLookup)
{
  $pkgKey = GetPackageKey $pkg

  if ($packageLookup.ContainsKey($pkgKey))
  {
    return $packageLookup[$pkgKey]
  }
  return $null
}

function FindMatchingPackage($pkg, $packageList)
{
  $pkgEntries = $packageList.Where({ PackageEqual $_ $pkg })

  # If pkgEntries is greater then one filter out the hidden packages
  # as we have some cases were we have duplicates with the older one hidden
  # this is to allow us to have entries for when sdk's switched to track 2
  if ($pkgEntries.Count -gt 1) {
    $pkgEntries = $pkgEntries.Where({ $_.Hide -ne "true" })
  }

  if ($pkgEntries.Count -gt 1) {
    Write-Host "Found $($pkgEntries.Count) package entries for $($pkg.Package) selecting the first one."
    return $pkgEntries[0]
  }
  elseif ($pkgEntries.Count -eq 0) {
    return $null
  }
  else {
    return $pkgEntries[0]
  }
}

function CopyOverFieldValues($copyFromReleaseFolder, $field)
{
  foreach ($lang in $languageNameMapping.Keys)
  {
    $releaseFolder = $copyFromReleaseFolder
    $pl1 = Get-PackageListForLanguage $lang
    $releaseFolder = Resolve-Path "$PSScriptRoot\..\..\_data\releases\latest"
    $pl2 = Get-PackageListForLanguage $lang

    foreach ($p1 in $pl1)
    {
      $p2 = FindMatchingPackage $p1 $pl2

      if ($p2) {
        $p2.$field = $p1.$field
      }
    }

    Set-PackageListForLanguage $lang $pl2
  }
}

function ImportDataFromFile($importFile)
{
  $importPackageData = Get-Content $importFile | ConvertFrom-Csv

  $allLanguageData = @{}

  foreach ($lang in $languageNameMapping.Keys)
  {
    $allLanguageData[$lang] = Get-PackageListForLanguage $lang
  }

  foreach ($pkgData in $importPackageData)
  {
    $releaseData = $allLanguageData[$pkgData.Language]

    if ($pkgData.Language -eq "Java" -or $pkgData.Language -eq "Android") {
      $gaSplit = $pkgData.Package.Split("/")
      if ($gaSplit.Count -ne 2) { Write-Error "Unable to split package name into group and artifact for $($pkgData.Package)" }

      $pkgData | Add-Member -NotePropertyName "GroupId" -NotePropertyValue $gaSplit[0]
      $pkgData.Package = $gaSplit[1]
    }

    $pkg = FindMatchingPackage $pkgData $releaseData

    if (!$pkg) {
      Write-Host "Did not find matching package for $($pkgData.Language) $($pkgData.Package) so adding"
      $pkg = CreatePackage $pkgData.Package "0.0.0"
      $releaseData += $pkg
      $allLanguageData[$pkgData.Language] = $releaseData
    }

    foreach ($prop in $pkgData.PSObject.Properties.Name) {
      if ($pkg.PSObject.Properties.Name -contains $prop) {
        $pkg.$prop = $pkgData.$prop
      }
    }
  }

  foreach ($lang in $languageNameMapping.Keys)
  {
    Set-PackageListForLanguage $lang $allLanguageData[$lang]
  }
}

function GetLinkTemplates($lang)
{
  $langLinkTemplates = @{}
  $releaseVariableFolder = Resolve-Path "$PSScriptRoot\..\..\_includes\releases\variables"
  $releaseVariableContent = Get-Content (Join-Path $releaseVariableFolder "$lang.md")

  foreach ($line in $releaseVariableContent)
  {
    if ($line -match "{%\s*assign\s*(?<name>\S+)\s*=\s*`"(?<value>\S*)`"\s+%}")
    {
      $langLinkTemplates[$matches["name"]] = $matches["value"]
      Write-Verbose ("" + $matches["name"] + " = [" + $matches["value"] + "]")
    }
  }

  return $langLinkTemplates
}

function GetLinkTemplateValue($linkTemplates, $templateName, $packageName = $null, $version = $null, $repoPath = $null, $groupId = $null)
{
  $replacedString = $linkTemplates[$templateName]

  if ($repoPath) {
    if ($repoPath.StartsWith("http") -and $templateName.Contains("source")) {
      $replacedString = $repoPath
    }
    else {
      $replacedString = $replacedString -replace "item.RepoPath", $repoPath
    }
  }

  if ($packageName) {
    $packageTrim = $linkTemplates["package_trim"]
    $trimmedPackageName = $packageName -replace "^$packageTrim", ""

    $replacedString = $replacedString -replace "item.Package", $packageName
    $replacedString = $replacedString -replace "item.TrimmedPackage", $trimmedPackageName
  }

  if ($version) {
    $replacedString = $replacedString -replace "item.Version", $version
  }

  if ($groupId) {
    $replacedString = $replacedString -replace "item.GroupId", $groupId
  }

  return $replacedString
 }
