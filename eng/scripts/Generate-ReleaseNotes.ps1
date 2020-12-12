param (
  [string]$RepositoryName,
  [string]$BaseBranchName
)

$releasePeriod = Get-Date -Format "yyyy-MM"
Write-Host "##vso[task.setvariable variable=thisReleasePeriod]$releasePeriod"
$workingDirectory = Get-Location
$repoPath = Join-Path $workingDirectory $RepositoryName
$collectChangelogPath = (Join-Path $repoPath eng common scripts Collect-ChangeLogs.ps1)
$generalReleaseNotesLogicPath = (Join-Path $repoPath eng common scripts GeneralReleaseNotesLogic.ps1)
$releaseFilePath = (Join-Path $workingDirectory releases $releasePeriod "$Language.md")

if (!Test-Path $releaseFilePath) 
{
  $releaseFilePath = (Join-Path $workingDirectory releases $releasePeriod "$LanguageShort.md")
}

if (!Test-Path $repoPath)
{
  LogError "Path [ $repoPath ] not found."
  exit 1
}

if (!Test-Path $collectChangelogPath)
{
  LogError "Path [ $collectChangelogPath ] not found."
  exit 1
}

if (!Test-Path $releaseFilePath)
{
  LogError "Path [ $releaseFilePath ] not found."
  exit 1
}

if (!Test-Path $generalReleaseNotesLogicPath)
{
  LogError "Path [ $generalReleaseNotesLogicPath ] not found."
  exit 1
}

. $generalReleaseNotesLogicPath

$presentPkgsInfo = Get-PackagesInfoFromFile -releaseNotesLocation $releaseFilePath
$incomingReleaseHighlights = &$collectChangelogPath

foreach ($key in $incomingReleaseHighlights.Keys)
{
  $presentKey = $presentPkgsInfo | Where-Object { $_ -eq $key }
  if ($presentKey.Count -gt 0)
  {
    $incomingReleaseHighlights.Remove($key)
  }
}

$incomingReleaseHighlights = Filter-ReleaseHighlights -releaseHighlights $incomingReleaseHighlights

Write-GeneralReleaseNote `
-releaseHighlights $incomingReleaseHighlights `
-releaseFilePath $releaseFilePath `





