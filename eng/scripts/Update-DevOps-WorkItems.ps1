[CmdletBinding()]
param (
  [string] $pkgFilter = $null,
  [bool] $updateAllVersions = $false, # When false only updates the versions in the preview and ga in csv
  [string] $github_pat = $env:GITHUB_PAT,
  [bool] $ignoreReleasePlannerTests = $true
)
Set-StrictMode -Version 3

. (Join-Path $PSScriptRoot PackageList-Helpers.ps1)
. (Join-Path $PSScriptRoot .. common scripts Helpers DevOps-WorkItem-Helpers.ps1)

if (!(Get-Command az -ErrorAction SilentlyContinue)) {
  Write-Error 'You must have the Azure CLI installed: https://aka.ms/azure-cli'
  exit 1
}

az account show *> $null
if (!$?) {
  Write-Host 'Running az login...'
  az login *> $null
}

az extension show -n azure-devops *> $null
if (!$?) {
  Write-Host 'Installing azure-devops extension'
  az extension add --name azure-devops
} else {
  # Force update the extension to the latest version if it was already installed
  # this is needed to ensure we have the authentication issue fixed from earlier versions
  az extension update -n azure-devops *> $null
}

$allVersions = @{}
$allPackagesFromCSV = @{}

$allLangPkgVersions = @{}
function GetVersionGroupForPackage($lang, $pkg)
{
  $versions = @()

  $langPkgVersions = $allLangPkgVersions[$lang]

  # Consider adding the versions from the csv but we don't have a date for them currently
  if ($pkg.PSObject.Properties.Name -contains "GroupId" -and $langPkgVersions.ContainsKey("$($pkg.GroupId)+$($pkg.Package)")) {
    $versions += $langPkgVersions["$($pkg.GroupId)+$($pkg.Package)"].Versions
  }
  elseif ($langPkgVersions.ContainsKey($pkg.Package)) {
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

      $pkgNameKey = $pkg.Package
      if ($langName -eq "Java" -and $pkg.PSObject.Properties.Name -contains "GroupId") {
        $pkgNameKey = "$($pkg.GroupId)+$($pkg.Package)"
      }
      $packageSet[$pkgNameKey] = New-Object PSObject -Property @{
        VersionGroups = $pkgVerGroups
        PackageInfo = $pkg
      }
    }
    $allVersions[$langName] = $packageSet
  }
}
function GetVersionInfo($pkgLang, $pkgNameKey, $verMajorMinor)
{
  InitializeVersionInformation

  if (!$allVersions.ContainsKey($pkgLang)) {
    return $null
  }
  if (!$allVersions[$pkgLang].ContainsKey($pkgNameKey)) {
    return $null
  }
  # Return the package item if the version isn't passed
  if (!$verMajorMinor){
    return $allVersions[$pkgLang][$pkgNameKey]
  }
  if (!$allVersions[$pkgLang][$pkgNameKey].VersionGroups.ContainsKey($verMajorMinor)) {
    return $null
  }
  return $allVersions[$pkgLang][$pkgNameKey].VersionGroups[$verMajorMinor]
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
    # release tag to try and get a date if we have one
    $tagDate = $v.Date -as [DateTime]
    if ($d -eq "Unknown" -and $tagDate) {
      $d = $tagDate.ToString("MM/dd/yyyy")
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

  return UpdatePackageVersions $pkgWorkItem -shippedVersions $shippedVersions
}

function RefreshItems()
{
  InitializeVersionInformation
  InitializeWorkItemCache
  $allPackageWorkItems = GetCachedPackageWorkItems
  if ($pkgFilter) {
    $allPackageWorkItems = $allPackageWorkItems | Where-Object { $_.fields["Custom.Package"] -like $pkgFilter }
  }

  $allVersionValues = @{}

  ## Loop over all package work items
  foreach ($pkgWI in $allPackageWorkItems)
  {
    $pkgLang = $pkgWI.fields["Custom.Language"]
    $pkgName = $pkgWI.fields["Custom.Package"]
    $version = $pkgWI.fields["Custom.PackageVersionMajorMinor"]
    $groupId = $pkgWI.fields["Custom.GroupId"]

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

    # Get version info, note this only gets the packages with New=True in this case.
    $pkgNameKey = $pkgName
    if ($pkgLang -eq "Java" -and $groupId) {
      $pkgNameKey = "$groupId+$pkgName"
    }
    $pkgInfo = GetVersionInfo $pkgLang $pkgNameKey
    $pkg = $null
    $versions = $null

    # If the csv entry is marked as "Needs Review" we want to prefer the data in the workitem over the data in csv
    if ($pkgInfo -and $pkgInfo.PackageInfo.Notes -ne "Needs Review")
    {
      if ($pkgInfo.VersionGroups.ContainsKey($verMajorMinor)) {
        $versions = $pkgInfo.VersionGroups[$verMajorMinor].Versions
      }
      $pkg = $pkgInfo.PackageInfo
    }
    else
    {
      $pkgFromCsv = $allPackagesFromCSV[$pkgLang].Where({ 
        if ($pkgLang -eq "Java" -and $pkgName -eq $_.Package -and $groupId -eq $_.GroupId) {
          return $true
        }
        return $pkgName -eq $_.Package
      })

      if ($pkgFromCsv.Count -ne 0)
      {
        if ($pkgFromCsv.Count -gt 1) {
          Write-Warning "[$($pkgWI.id)]$pkgLang - $pkgNameKey($verMajorMinor) - Detected new package with multiple matching package names in the csv, so skipping it."
          continue
        }
        else {
          $csvEntry = $pkgFromCsv[0]
          if ($csvEntry.Hide -eq "true") {
            # For any entry that is explicitly marked as hidden we should skip any updating
            continue
          }

          $csvEntryVersion = $csvEntry.VersionGA
          if (!$csvEntryVersion) { $csvEntryVersion = $csvEntry.VersionPreview }
          if (!$csvEntryVersion.StartsWith($verMajorMinor)) {
            Write-Warning "[$($pkgWI.id)]$pkgLang - $pkgNameKey($verMajorMinor) - Detected package work item with different version('$csvEntryVersion') then in CSV, so skipping it."
            continue
          }

          $csvEntry.New = $pkgWI.fields["Custom.PackageTypeNewLibrary"].ToString().ToLower()
          $csvEntry.Type = $pkgWI.fields["Custom.PackageType"]

          if ($csvEntry.DisplayName.Contains("Unknown")) {
            $csvEntry.DisplayName = $pkgWI.fields["Custom.PackageDisplayName"]
          }
          if ($csvEntry.ServiceName.Contains("Unknown")) {
            $csvEntry.ServiceName = $pkgWI.fields["Custom.ServiceName"]
          }

          if ($pkgWI.fields["Custom.PackageRepoPath"] -and (!$csvEntry.RepoPath -or "NA" -eq $csvEntry.RepoPath))
          {
            # @azure-rest packages have unique repo path formatting so we need create a custom template for them
            if ($csvEntry.Package.StartsWith("@azure-rest") -and !$pkgWI.fields["Custom.PackageRepoPath"].StartsWith("https"))
            {
              $jsLinkTemplates = GetLinkTemplates "js"

              $repoPath = $jsLinkTemplates["source_url_template"]

              # this assumes that the previous PackageRepoPath is the service directory which is generally the case when first created
              $repoPath = $repoPath -replace "item.RepoPath", $pkgWI.fields["Custom.PackageRepoPath"]

              # this assumes that the item.TrimmedPackage parameter in the template needs to be remove the scope and add "-rest" to end
              $repoPath = $repoPath -replace "item.TrimmedPackage", ($csvEntry.Package -replace "@azure-rest/(.*)", "`$1-rest")

              $csvEntry.RepoPath = $repoPath
            }
            else
            {
              $csvEntry.RepoPath = $pkgWI.fields["Custom.PackageRepoPath"]
            }
          }

          if (!$csvEntry.RepoPath) {
            $csvEntry.RepoPath = "NA"
          }

          Write-Host "[$($pkgWI.id)]$pkgLang - $pkgNameKey($verMajorMinor) - Detected new package in CSV with a release work item so updating metadata for it in the CSV to match release work item."

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
        Write-Host "[$($pkgWI.id)]$pkgLang - $pkgNameKey($verMajorMinor) - Detected new package not in CSV file. Only normalizing release work item until release."

        $pkg = [PSCustomObject][ordered]@{
          Package = $pkgName
          GroupId = $pkgWI.fields["Custom.GroupId"]
          DisplayName = $pkgWI.fields["Custom.PackageDisplayName"]
          ServiceName = $pkgWI.fields["Custom.ServiceName"]
          RepoPath = $pkgWI.fields["Custom.PackageRepoPath"]
          Type = $pkgWI.fields["Custom.PackageType"]
          New = $pkgWI.fields["Custom.PackageTypeNewLibrary"].ToString().ToLower()
        };
      }
    }

    Write-Verbose "[$($pkgWI.id)]$pkgLang - $pkgNameKey($verMajorMinor) - '$($pkgWI.fields['System.State'])'"

    $updatedWI = CreateOrUpdatePackageWorkItem (Get-LanguageName $pkgLang) $pkg $verMajorMinor $pkgWI
    $updatedWI = UpdateShippedPackageVersions $updatedWI $versions

    # Collect all the versions
    if (!$allVersionValues.ContainsKey($pkgLang)) {
      $allVersionValues[$pkgLang] = @{}
    }
    $allVersionValues[$pkgLang][$pkgNameKey] += $($updatedWI.fields["Custom.PackageBetaVersions"]) + "|"
    $allVersionValues[$pkgLang][$pkgNameKey] += $($updatedWI.fields["Custom.PackageGAVersion"]) + "|"
    $allVersionValues[$pkgLang][$pkgNameKey] += $($updatedWI.fields["Custom.PackagePatchVersions"]) + "|"
  }

  ## Loop over all packages marked as New in CSV files
  foreach ($pkgLang in $allVersions.Keys)
  {
    foreach ($pkgNameKey in $allVersions[$pkgLang].Keys)
    {
      foreach ($verMajorMinor in $allVersions[$pkgLang][$pkgNameKey].VersionGroups.Keys)
      {
        $verInfo = $allVersions[$pkgLang][$pkgNameKey].VersionGroups[$verMajorMinor]
        if (!$verInfo.PackageInfo.ServiceName)
        {
          Write-Warning "No ServiceName for '$pkgLang - $pkgNameKey' in CSV so not creating a package work-item for it."
          continue
        }

        if (!$verInfo.PackageInfo.DisplayName)
        {
          Write-Warning "No DisplayName for '$pkgLang - $pkgNameKey' in CSV so not creating a package work-item for it."
          continue
        }
        if (!$verInfo.PackageInfo.RepoPath -and $verInfo.PackageInfo.RepoPath -eq "NA")
        {
          Write-Warning "No RepoPath set for '$pkgLang - $pkgNameKey' in CSV so not creating a package work-item for it."
          continue
        }

        $pkgWI = FindOrCreateClonePackageWorkItem (Get-LanguageName $pkgLang) $verInfo.PackageInfo $verMajorMinor -outputCommand $true
        Write-Verbose "[$($pkgWI.id)]$pkgLang - $pkgNameKey($verMajorMinor)"
        $pkgWI = UpdateShippedPackageVersions $pkgWI $verInfo.Versions
      }

      $csvEntry = $allVersions[$pkgLang][$pkgNameKey].PackageInfo
      if ($csvEntry.PSObject.Members.Name -contains "PlannedVersions" -and $allVersionValues.ContainsKey($pkgLang) -and $allVersionValues[$pkgLang].ContainsKey($pkgNameKey))
      {
        $pkgVersionValues = $allVersionValues[$pkgLang][$pkgNameKey].Split("|").Trim().Where({ $_ })
        $pkgPlannedVersions = @{}

        $today = [DateTime](Get-Date -Format "MM/dd/yyyy")
        foreach ($pkgVersionValue in $pkgVersionValues) {
          $ver, $date = $pkgVersionValue.Split(",")
          if (($date -as [DateTime]) -ge $today) {
            $pkgPlannedVersions[$ver] = New-Object PSObject -Property @{
              Version = $ver
              Date = ([DateTime]$date).Tostring("MM/dd/yyyy")
            }
          }
        },
        $sortedPlannedVersions = $pkgPlannedVersions.Values | Sort-Object @{Expression = {$_.Date -as [DateTime]}; Descending = $false}, Version -Descending | ForEach-Object { "$($_.Version),$($_.Date)" }
        $csvEntry.PlannedVersions = $sortedPlannedVersions -join "|"
      }
    }
    Set-PackageListForLanguage $pkgLang $allPackagesFromCSV[$pkgLang]
  }
}

RefreshItems
