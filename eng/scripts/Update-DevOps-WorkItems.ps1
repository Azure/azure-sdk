[CmdletBinding()]
param (
  [string] $pkgFilter = $null,
  [bool] $updateAllVersions = $false, # When false only updates the versions in the preview and ga in csv
  [string] $github_pat = $env:GITHUB_PAT,
  [string] $devops_pat = $env:DEVOPS_PAT
)
Set-StrictMode -Version 3
$ErrorActionPreference = "Continue"

. (Join-Path $PSScriptRoot PackageList-Helpers.ps1)
. (Join-Path $PSScriptRoot PackageVersion-Helpers.ps1)
. (Join-Path $PSScriptRoot .. common scripts helpers DevOps-WorkItem-Helpers.ps1)

$allVersions = @{}
$allPackagesFromCSV = @{}

$allLangPkgVersions = @{}
function GetVersionGroupForPackage($lang, $pkg)
{
  $versions = @()

  $langPkgVersions = $allLangPkgVersions[$lang]

  # Consider adding the versions from the csv but we don't have a date for them currently
  if ($langPkgVersions.ContainsKey($pkg.Package)) {
    $versions += $langPkgVersions[$pkg.Package].Versions
  }
  if ($pkg.VersionGA -and ($versions.Count -eq 0 -or $versions.RawVersion -notcontains $pkg.VersionGA)) {
    $versions += ToSemVer $pkg.VersionGA
  }
  if ($pkg.VersionPreview -and ($versions.Count -eq 0 -or $versions.RawVersion -notcontains $pkg.VersionPreview)) {
    $versions += ToSemVer $pkg.VersionPreview
  }

  $versions = @([AzureEngSemanticVersion]::SortVersions($versions))

  if ($versions.Count -eq 0) {
    Write-Verbose "No versioning information for $lang - $($pkg.Package)"
    continue
  }
  
  $verGroups = $versions | Group-Object -Property Major, Minor

  return $verGroups
}

function InitializeVersionInformation()
{
  if ($allVersions.Count -gt 0) { 
    return
  }

  foreach ($lang in $languageNameMapping.Keys) 
  {
    $langName = Get-LanguageName $lang
    $packageList = Get-PackageListForLanguage $lang
    $allPackagesFromCSV[$langName] = $packageList
    $packageList, $_ = Get-PackageListSplit $packageList

    if ($pkgFilter) {
      $packageList = $packageList | Where-Object { $_.Package -like $pkgFilter }
    }

    $allLangPkgVersions[$langName] = GetPackageVersions $lang
    Write-Verbose "Found $($allLangPkgVersions[$langName].Count) versions for language $langName"

    $packageSet = @{}
    foreach ($pkg in $packageList)
    {
      $verGroups = GetVersionGroupForPackage $langName $pkg
  
      $pkgVerGroups = @{}
      foreach ($verGroup in $verGroups)
      {
        $verMajMin = ($verGroup.Name -replace ", ", ".")

        if (!$updateAllVersions) {
          if (!(PackageMatchesVersionGroup $pkg $verMajMin)) {
            continue
          }
        }

        $pkgVerGroups[$verMajMin] = New-Object PSObject -Property @{
          Versions = $verGroup.Group
          VersionMajorMinor = $verMajMin
          PackageInfo = $pkg
        }
      }
      $packageSet[$pkg.Package] = New-Object PSObject -Property @{
        VersionGroups = $pkgVerGroups
        PackageInfo = $pkg
      }
    }
    $allVersions[$langName] = $packageSet
  }
}
function GetVersionInfo($pkgLang, $pkgName, $verMajorMinor)
{
  InitializeVersionInformation

  if (!$allVersions.ContainsKey($pkgLang)) {
    return $null
  }
  if (!$allVersions[$pkgLang].ContainsKey($pkgName)) {
    return $null
  }
  # Return the package item if the version isn't passed
  if (!$verMajorMinor){
    return $allVersions[$pkgLang][$pkgName]
  }
  if (!$allVersions[$pkgLang][$pkgName].VersionGroups.ContainsKey($verMajorMinor)) {
    return $null
  }
  return $allVersions[$pkgLang][$pkgName].VesionGroups[$verMajorMinor]
}

function PackageMatchesVersionGroup($pkg, $versionGroupToCheck)
{
  if ($pkg.VersionGA -and $pkg.VersionGA.StartsWith($versionGroupToCheck)) {
    return $true
  }

  if ($pkg.VersionPreview -and $pkg.VersionPreview.StartsWith($versionGroupToCheck)) {
    return $true
  }
  return $false
}

function ParseVersionsFromTags($versionsFromTags, $existingShippedVersionSet)
{
  $versionList = @()
  foreach ($v in $versionsFromTags)
  {
    $d = "Unknown"
    if ($existingShippedVersionSet.ContainsKey($v.RawVersion)) {
      # Use cached values from the work items
      $d = $existingShippedVersionSet[$v.RawVersion].Date
    }
    # if we don't have a cached value or the cached value is Unknown look at the 
    # release tag to try and get a date
    if ($d -eq "Unknown") {
      $shaDate = GetCommitterDate $v.TagShaUrl
      if ($shaDate) {
        $d = $shaDate.ToString("MM/dd/yyyy")
      }
    }
    $versionList += New-Object PSObject -Property @{
      Type = $v.VersionType
      Version = $v.RawVersion
      Date = $d 
    }
  }
  return ,$versionList
}

function UpdateShippedPackageVersions($pkgWorkItem, $versionsFromTags)
{
  $existingVersions = ParseVersionSetFromMDField $pkgWorkItem.fields["Custom.ShippedPackages"]
  $shippedVersions = ParseVersionsFromTags $versionsFromTags $existingVersions

  UpdatePackageVersions $pkgWorkItem -shippedVersions $shippedVersions
}

function RefreshItems()
{
  LoginToAzureDevops $devops_pat
  InitializeVersionInformation
  InitializeWorkItemCache
  $allPackageWorkItems = GetCachedPackageWorkItems
  if ($pkgFilter) {
    $allPackageWorkItems = $allPackageWorkItems | Where-Object { $_.fields["Custom.Package"] -like $pkgFilter }
  }

  ## Loop over all package work items
  foreach ($pkgWI in $allPackageWorkItems)
  {
    $pkgLang = $pkgWI.fields["Custom.Language"]
    $pkgName = $pkgWI.fields["Custom.Package"]
    $version = $pkgWI.fields["Custom.PackageVersionMajorMinor"]

    if (!$pkgLang -or !$pkgName -or !$version) {
      Write-Warning "Skipping item $($pkgWI.id) because it doesn't have one or all of the required language, package, or version fields."
      continue
    }

    if ($version -match "(?<major>\d+)\.(?<minor>\d+)") {
      $verMajorMinor = "" + $matches["major"] + "." + $matches["minor"]
    }
    else {
      Write-Warning "Version for item $($pkgWI.id) is set to [$version] which is not a valid version. Skipping"
      continue
    }

    $pkgInfo = GetVersionInfo $pkgLang $pkgName
    
    $pkg = $null
    $versions = $null

    if ($pkgInfo) {
      if ($pkgInfo.VersionGroups.ContainsKey($verMajorMinor)) {
        $versions = $pkgInfo.VersionGroups[$verMajorMinor].Versions
      }
      $pkg = $pkgInfo.PackageInfo
    }
    else {
      $pkgFromCsv = $allPackagesFromCSV[$pkgLang].Where({ $pkgName -eq $_.Package })

      # For java filter down to com.azure* groupId
      if ($pkgLang -eq "Java") {
        $pkgFromCsv = $pkgFromCsv.Where({ $_.GroupId -like "com.azure*" })
      }

      if ($pkgFromCsv.Count -ne 0) {
        if ($pkgFromCsv.Count -gt 1) {
          Write-Warning "[$($pkgWI.id)]$pkgLang - $pkgName($verMajorMinor) - Detected new package with multiple matching package names in the csv, so skipping it."
          continue
        }
        else {
          $csvEntry = $pkgFromCsv[0]
          $csvEntry.New = $pkgWI.fields["Custom.PackageTypeNewLibrary"].ToString().ToLower()
          $csvEntry.Type = $pkgWI.fields["Custom.PackageType"]
          $csvEntry.DisplayName = $pkgWI.fields["Custom.PackageDisplayName"]
          $csvEntry.ServiceName = $pkgWI.fields["Custom.ServiceName"]

          if ($pkgWI.fields["Custom.PackageRepoPath"] -and ($null -eq $csvEntry.RepoPath -or "NA" -eq $csvEntry.RepoPath)) {
            $csvEntry.RepoPath = $pkgWI.fields["Custom.PackageRepoPath"]
          }

          if (!$csvEntry.RepoPath) {
            $csvEntry.RepoPath = "NA"
          }

          Write-Host "[$($pkgWI.id)]$pkgLang - $pkgName($verMajorMinor) - Detected new package in CSV with a release work item so updating metadata for it in the CSV to match release work item."
          Set-PackageListForLanguage $pkgLang $allPackagesFromCSV[$pkgLang]

          $verGroups = GetVersionGroupForPackage $pkgLang $csvEntry
          if ($verGroups) {
            foreach ($verGroup in $verGroups) {
              if ($verGroup.Name.Replace(", ", ".") -eq $verMajorMinor) {
                $versions = $verGroup.Group
                break;
              }
            }
          }
          $pkg = $csvEntry
        }
      }
      else {
        Write-Host "[$($pkgWI.id)] - $pkgLang - $pkgName($verMajorMinor) - Detected new package not in CSV file. Only normalizing release work item until release."

        $pkg = [PSCustomObject][ordered]@{
          Package = $pkgName
          DisplayName = $pkgWI.fields["Custom.PackageDisplayName"]
          ServiceName = $pkgWI.fields["Custom.ServiceName"]
          RepoPath = $pkgWI.fields["Custom.PackageRepoPath"]
          Type = $pkgWI.fields["Custom.PackageType"]
          New = $pkgWI.fields["Custom.PackageTypeNewLibrary"].ToString().ToLower()
        };
        
        #Write-Host "Skipping '$($pkgWI.id) - $pkgLang - $pkgName($verMajorMinor)', as this looks like a brand new package that hasn't shipped so we don't have any versioning information in the CSV."
        #continue
      }
    }

    Write-Verbose "[$($pkgWI.id)]$pkgLang - $pkgName ($verMajorMinor) - '$($pkgWI.fields['System.State'])'"

    $updatedWI = CreateOrUpdatePackageWorkItem (Get-LanguageName $pkgLang) $pkg $verMajorMinor $pkgWI
    if ($versions) {
      UpdateShippedPackageVersions $updatedWI $versions
    }
  }

  ## Loop over all packages in csv
  foreach ($pkgLang in $allVersions.Keys)
  {
    foreach ($pkgName in $allVersions[$pkgLang].Keys)
    {
      foreach ($verMajorMinor in $allVersions[$pkgLang][$pkgName].VersionGroups.Keys)
      {
        $verInfo = $allVersions[$pkgLang][$pkgName].VersionGroups[$verMajorMinor]

        if (!$verInfo.PackageInfo.ServiceName)
        {
          Write-Warning "No ServiceName for '$pkgLang - $pkgName' in CSV so not creating a package work-item for it."
          continue
        }

        if (!$verInfo.PackageInfo.DisplayName)
        {
          Write-Warning "No DisplayName for '$pkgLang - $pkgName' in CSV so not creating a package work-item for it."
          continue
        }
        if (!$verInfo.PackageInfo.RepoPath -and $verInfo.PackageInfo.RepoPath -eq "NA")
        {
          Write-Warning "No RepoPath set for '$pkgLang - $pkgName' in CSV so not creating a package work-item for it."
          continue
        }

        $pkgWI = FindOrCreateClonePackageWorkItem (Get-LanguageName $pkgLang) $verInfo.PackageInfo $verMajorMinor -outputCommand $false
        Write-Verbose "[$($pkgWI.id)]$pkgLang - $pkgName ($verMajorMinor)"
        UpdateShippedPackageVersions $pkgWI $verInfo.Versions
      }
    }
  }
}

RefreshItems
