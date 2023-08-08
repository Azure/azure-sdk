
[CmdletBinding()]
param(
  [string]$CSVPath = $null,
  [string]$pkgFilter = $null
)
#Requires -Version 7.0
Set-StrictMode -Version 3

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
if (!$?){
  Write-Host 'Installing azure-devops extension'
  az extension add --name azure-devops
}

. (Join-Path $PSScriptRoot .. common scripts SemVer.ps1)
. (Join-Path $PSScriptRoot .. common scripts Helpers DevOps-WorkItem-Helpers.ps1)
. (Join-Path $PSScriptRoot PackageList-Helpers.ps1)

CheckDevOpsAccess

$unchangedPkgList = Get-CombinedPackageListForPlannedVersions $pkgFilter

$uniqueName = ""
if (!$CSVPath)
{
  $uniqueName = "plannedpackages_$([System.IO.Path]::GetRandomFileName()).csv"
  $CSVPath = $uniqueName
  $seedString = "Seeded CSV file with existing packages "
  if ($pkgFilter) { $seedString += "that match '$pkgFilter' " }
  $seedString += "and opening it in excel."
  Write-Host $seedString
  Write-Host " - Provide PlannedVersion (X.Y.Z[-beta.N]) and PlannedDate (MM/dd/yyyy) values for each package."
  Write-Host " - If you adding a brand new package not in the list add a new row and fill in all field values."
  Write-Host " - If you want to add multiple planned versions and dates for a package duplicate the entire"
  Write-Host "   row and only update the PlannedVersion and PlannedDate for each row."
  Write-Host " - Delete or leave Planned fields empty for any packages you don't want to add planned dates."
  Write-Host "Once done editing save the file and close excel..."
  $unchangedPkgList | ConvertTo-CSV -NoTypeInformation -UseQuotes Always | Out-File $CSVPath -encoding ascii

  Start-Process -wait excel -argumentlist $CSVPath
}

$changedPkgList = Get-Content $CSVPath | ConvertFrom-Csv | Where-Object {
  if (!$_.PlannedDate -or !$_.PlannedVersion) {
    return $false
  }

  $pkgName = $_.Package
  $pkgPlannedVersion = $_.PlannedVersion
  $pkgPlannedDate = $_.PlannedDate
  $parsedVersion = new-object AzureEngSemanticVersion($pkgPlannedVersion)
  if (!$parsedVersion.IsSemVerFormat) {
    Write-Host "Skipping update for $pkgName as the version format is incorrect $pkgPlannedVersion"
    return $false
  }

  $matchingPkg = $unchangedPkgList.Where({
    if ($pkgName -ne $_.Package) { return $false }
    if (($pkgPlannedDate -as [DateTime]) -ne ($_.PlannedDate -as [DateTime])) { return $false }
    if ($pkgPlannedVersion -ne $_.PlannedVersion) { return $false }
    return $true
  })
  if ($matchingPkg.Count -gt 0) {
    return $false
  }
  Write-Host "$pkgName has changes $pkgPlannedVersion $pkgPlannedDate"
  return $true
}

if (!$changedPkgList -or $changedPkgList.Count -eq 0) {
  Write-Host "Didn't find any packages with a planned version and date in [$CSVPath]."

  if ($uniqueName) {
    Write-Host "In some cases excel is delayed in saving a file so if you made changes try re-running the script passing in the file like:"
    Write-Host ".\eng\scripts\BulkUpdatePackagePlannedDates.ps1 $CSVPath"
  }
  exit 0
}

foreach ($pkg in $changedPkgList) {
  Write-Host "Updating package $($pkg.Package) with planned version $($pkg.PlannedVersion) on $($pkg.PlannedDate)"

  $plannedVersion = [AzureEngSemanticVersion]::ParseVersionString($pkg.PlannedVersion)
  if (!$plannedVersion) {
    Write-Warning "Skipping because version '$($pkg.PlannedVersion)' is not a valid version."
    continue
  }
  $verMajorMinor = "" + $plannedVersion.Major + "." + $plannedVersion.Minor

  $packageInfo = [PSCustomObject][ordered]@{
    Package = $pkg.Package
    DisplayName = $pkg.DisplayName
    ServiceName = $pkg.ServiceName
    RepoPath = $pkg.RepoPath
    Type = $pkg.Type
    New = $pkg.New
  };

  $plannedVersions = @(
      [PSCustomObject][ordered]@{
        Type = $plannedVersion.VersionType
        Version = $plannedVersion.RawVersion
        Date = ([DateTime]$pkg.PlannedDate).ToString("MM/dd/yyyy")
      }
    )

  $pkgWI = FindOrCreateClonePackageWorkItem $pkg.Language $packageInfo $verMajorMinor -outputCommand $false
  $pkgWI = UpdatePackageVersions $pkgWI -plannedVersions $plannedVersions
  Write-Host "https://dev.azure.com/azure-sdk/Release/_workitems/edit/$($pkgWI.id)/"
}
