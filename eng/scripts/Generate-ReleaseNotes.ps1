param (
  [string]$RepositoryName,
  [string]$BaseBranchName
)

$releasePeriod = Get-Date -Format "yyyy-MM"
Write-Host "##vso[task.setvariable variable=thisReleasePeriod]$releasePeriod"
$workingDirectory = Get-Location
$repoPath = Join-Path $workingDirectory $RepositoryName
$commonScriptsPath = (Join-Path $repoPath eng common scripts)
$commonScript = (Join-Path $commonScriptsPath common.ps1)
$collectChangelogPath = (Join-Path $commonScriptsPath Collect-ChangeLogs.ps1)
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

if (!Test-Path $commonScript)
{
  LogError "Path [ $commonScript ] not found."
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

. $commonScript
$PATTERN_REGEX = "^\[pattern(\.(?<SectionName>\w+))?\]:\s#\s\((?<Pattern>.*)\)"
$CsvMetaData = Get-CSVMetadata

function Get-PackagesInfoFromFile ($releaseNotesLocation) 
{
    $releaseNotesContent = Get-Content -Path $releaseNotesLocation
    $checkLine = $False
    $presentPkgInfo = @()

    foreach ($line in $releaseNotesContent)
    {
        $line = $line.Trim()
        if ($line.StartsWith("<!--"))
        {
            $checkLine = $True
            continue
        }
        if ($line.EndsWith("-->"))
        {
            break
        }
        if ($checkLine)
        {
            $pkgInfo = $line.Split(":")
            $packageName = $pkgInfo[0]
            $packageMetaData = $CsvMetaData | Where-Object { $_.Package -eq $packageName }
            if ($packageMetaData.Count -gt 0)
            {
                $presentPkgInfo += $line
            }
        }
    }
    return $presentPkgInfo
}

function Filter-ReleaseHighlights ($releaseHighlights)
{
    $results = @{}

    foreach ($key in $releaseHighlights.Keys)
    {
        $keyInfo = $key.Split(":")
        $packageName = $keyInfo[0]
        $releaseVersion = $keyInfo[1]
        $packageGroupId = $releaseHighlights[$key]["PackageProperties"].Group

        $packageMetaData = $CsvMetaData | Where-Object { ($_.Package -eq $packageName) -and ($_.GroupId -eq $packageGroupId) }

        if ($packageMetaData.Hide -eq "true")
        {
            continue
        }

        $sortedVersions = [AzureEngSemanticVersion]::SortVersionStrings(@($releaseVersion, $packageMetaData.VersionGA, $packageMetaData.VersionPreview))

        if ($sortedVersions[0] -eq $releaseVersion)
        {
            continue
        }
        $releaseHighlights[$key]["DisplayName"] = $DisplayName
        $results.Add($key, $releaseHighlights[$key])
    }
    return $results
}

function Write-GeneralReleaseNote ($releaseHighlights, $releaseFilePath)
{
    $releaseContent = Get-Content $releaseFilePath
    $newReleaseContent = @()
    $writingPaused = $False

    foreach ($line in $releaseContent)
    {
        if ($line -match $PATTERN_REGEX)
        {
            $sectionName = $matches["SectionName"]
            $pattern = $matches["Pattern"]

            foreach ($key in $releaseHighlights.Keys)
            {
                $pkgInfo = $key.Split(":")
                $packageName = $pkgInfo[0]
                $packageVersion = $pkgInfo[1]
                $packageFriendlyName = $releaseHighlights[$key]["DisplayName"]

                if ($null -eq $packageFriendlyName)
                {
                    $packageFriendlyName = $packageName
                }

                $changelogUrl = $releaseHighlights[$key]["ChangelogUrl"]
                $changelogUrl = "(${changelogUrl})"
                $highlightsBody = $releaseHighlights[$key]["Content"]
                $packageSemVer = [AzureEngSemanticVersion]::ParseVersionString($PackageVersion)
                
                $lineValue = $ExecutionContext.InvokeCommand.ExpandString($pattern)
                if ([System.String]::IsNullOrEmpty($sectionName) -or $packageSemVer.VersionType -eq $sectionName)
                {
                    $newReleaseContent += $lineValue
                }
            }
            $newReleaseContent += ""
            if ($writingPaused)
            {
                $newReleaseContent += "```````n"
                $writingPaused = $False
            }
        }

        if (![System.String]::IsNullOrEmpty($line) -and $writingPaused)
        {
            $newReleaseContent += "```````n"
            $writingPaused = $False
        }

        if ($line -eq "``````")
        {
            $writingPaused = $True
        }

        if (!$writingPaused)
        {
            $newReleaseContent += $line
        }
    }
    Set-Content -Path $releaseFilePath -Value $newReleaseContent
}

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





