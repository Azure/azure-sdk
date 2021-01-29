param (
  [string]$RepositoryName,
  [string]$BaseBranchName
)

$PATTERN_REGEX = "^\[pattern(\.(?<SectionName>\w+))?\]:\s#\s\((?<Pattern>.*)\)"

$releasePeriod = Get-Date -Format "yyyy-MM"
Write-Host "##vso[task.setvariable variable=thisReleasePeriod]$releasePeriod"

$workingDirectory = Get-Location
Write-Host "Working Directory $workingDirectory"

$repoPath = Join-Path $workingDirectory $RepositoryName
if (!(Test-Path $repoPath))
{
  Write-Error "Path [ $repoPath ] not found."
  exit 1
}
Write-Host "Repo Path $repoPath"

$commonScriptsPath = (Join-Path $repoPath eng common scripts)
$commonScript = (Join-Path $commonScriptsPath common.ps1)
Write-Host "Common Script $commonScript"

. $commonScript
$CsvMetaData = Get-CSVMetadata

$collectChangelogPath = (Join-Path $commonScriptsPath Collect-ChangeLogs.ps1)
$releaseFilePath = (Join-Path $workingDirectory azure-sdk releases $releasePeriod "${Language}.md")

if (!(Test-Path $releaseFilePath)) 
{
  $releaseFilePath = (Join-Path $workingDirectory azure-sdk releases $releasePeriod "${LanguageShort}.md")
}
Write-Host "Release File Path $releaseFilePath"

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
        $releaseHighlights[$key]["DisplayName"] = $packageMetaData.DisplayName
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
            if (![System.String]::IsNullOrEmpty($newReleaseContent[$newReleaseContent.Count - 1]))
            {
                $newReleaseContent += ""
            }

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
$incomingReleaseHighlights = &$collectChangelogPath -Month (Get-Date -Format "MM")

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





