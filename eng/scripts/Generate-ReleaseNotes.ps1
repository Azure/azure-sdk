param (
  [string]$releasePeriod,
  [string]$languageRepoDirectory,
  [string]$releaseDirectory,
  [string]$releaseFileName
)

$PATTERN_REGEX = "^\[pattern(\.(?<SectionName>\w+))?\]:\s#\s\((?<Pattern>.*)\)"

if (!(Test-Path $LanguageRepoDirectory))
{
  Write-Error "Path [ $LanguageRepoDirectory ] not found."
  exit 1
}
Write-Host "Repo Path $LanguageRepoDirectory"

$commonScriptsPath = (Join-Path $LanguageRepoDirectory eng common scripts)
$commonScript = (Join-Path $commonScriptsPath common.ps1)
Write-Host "Common Script $commonScript"

. $commonScript
$CsvMetaData = Get-CSVMetadata -MetadataUri "https://raw.githubusercontent.com/azure-sdk/azure-sdk/PackageVersionUpdates/_data/releases/latest/${releaseFileName}-packages.csv"

$releaseFilePath = (Join-Path $ReleaseDirectory $releasePeriod "${releaseFileName}.md")
LogDebug "Release File Path [ $releaseFilePath ]"

if (!(Test-Path $releaseFilePath))
{
    $PSScriptRoot\Generate-Release-Structure.ps1 -releaseFileName "${releaseFileName}.md"
}

$existingReleaseContent = Get-Content $releaseFilePath


$pathToDateOfLatestUpdates = (Join-Path $ReleaseDirectory "${releaseFileName}.lastupdated")
$collectChangelogPath = (Join-Path $commonScriptsPath Collect-ChangeLogs.ps1)

function Get-PackagesInfoFromFile ($releaseNotesContent) 
{
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
            if ($pkgInfo.Count -gt 0)
            {
                $packageName = $pkgInfo[0]
                $packageMetaData = $CsvMetaData | Where-Object { $_.Package -eq $packageName }
                if ($packageMetaData.Count -gt 0)
                {
                    $presentPkgInfo += $line
                }
            }
        }
    }
    return $presentPkgInfo
}

function FilterOut-UnreleasedPackages ($releaseHighlights)
{
    $results = @{}

    foreach ($key in $releaseHighlights.Keys)
    {
        $keyInfo = $key.Split(":")
        $packageName = $keyInfo[0]
        $releaseVersion = $keyInfo[1]
        $packageGroupId = $releaseHighlights[$key]["PackageProperties"].Group

        $packageMetaData = $CsvMetaData | Where-Object { ($_.Package -eq $packageName) -and
             ($_.GroupId -eq $packageGroupId) -and ($_.Hide -ne "true")}

        if ($packageMetaData.Count -eq 1)
        {
            $sortedVersions = [AzureEngSemanticVersion]::SortVersionStrings(@($releaseVersion, $packageMetaData.VersionGA, $packageMetaData.VersionPreview))

            if (($sortedVersions[0] -eq $releaseVersion) -and ($releaseVersion -ne $packageMetaData.VersionGA) -and ($releaseVersion -ne $packageMetaData.VersionPreview))
            {
                continue
                LogDebug "[ $packageName ] with version  [$releaseVersion ] was skipped because it has a newer release version than present in the package csv"
            }
            $releaseHighlights[$key]["DisplayName"] = $packageMetaData.DisplayName
            $results.Add($key, $releaseHighlights[$key])
        }
        else 
        {
            LogDebug "[ $packageName ] with version  [ $releaseVersion ] was skipped because there are duplicate versions in the package csv"
        }
    }
    return $results
}

function Write-GeneralReleaseNote ($releaseHighlights, $releaseNotesContent, $releaseFilePath)
{
    [System.Collections.ArrayList]$newReleaseContent = @()
    $insertPosition = $null
    $arrayToInsert = @()

    foreach ($line in $releaseNotesContent)
    {
        if ($line -match $PATTERN_REGEX)
        {
            $sectionName = $matches["SectionName"]
            $pattern = $matches["Pattern"]

            if ($newReleaseContent.Count -gt 0 -and 
                [System.String]::IsNullOrEmpty($newReleaseContent[$newReleaseContent.Count - 1]))
            {
                $newReleaseContent.RemoveAt($newReleaseContent.Count - 1)
            }

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
                $highlightsBody = ($releaseHighlights[$key]["Content"] | Out-String).Trim()
                $packageSemVer = [AzureEngSemanticVersion]::ParseVersionString($PackageVersion)
                
                $lineValue = $ExecutionContext.InvokeCommand.ExpandString($pattern)
                if ([System.String]::IsNullOrEmpty($sectionName) -or $packageSemVer.VersionType -eq $sectionName)
                {
                    if ($null -ne $insertPosition)
                    {
                        $arrayToInsert += $lineValue
                    }
                    else
                    {
                        $newReleaseContent += $lineValue
                    }
                }
            }

            if ($null -ne $insertPosition -and ($arrayToInsert.Count -gt 0))
            {
                $newReleaseContent.Insert($insertPosition, $arrayToInsert)
                $insertPosition = $null
                $arrayToInsert = $null
            }

            if (![System.String]::IsNullOrEmpty($newReleaseContent[$newReleaseContent.Count - 1]))
            {
                $newReleaseContent += ""
            }
        }

        if (($null -ne $insertPosition) -and (![System.String]::IsNullOrEmpty($line)))
        {
            $insertPosition = $null
        }

        if ($line -eq "``````")
        {
            $insertPosition = $newReleaseContent.Count - 1
        }

        $newReleaseContent += $line
    }
    Set-Content -Path $releaseFilePath -Value $newReleaseContent
}

$presentPkgsInfo = Get-PackagesInfoFromFile -releaseNotesContent $existingReleaseContent
$dateOfLatestUpdate = @(Get-Content -Path $pathToDateOfLatestUpdates)

if ($dateOfLatestUpdate.Count -eq 0)
{
    LogError "Please make sure a valid date is present for [ $releaseFileName ] at [ $pathToDateOfLatestUpdates ]"
    exit 1
}

$incomingReleaseHighlights = &$collectChangelogPath -FromDate $dateOfLatestUpdate[0]

foreach ($key in @($incomingReleaseHighlights.Keys))
{
  $presentKey = $presentPkgsInfo | Where-Object { $_ -eq $key }
  if ($presentKey.Count -gt 0)
  {
    $incomingReleaseHighlights.Remove($key)
  }
}

$incomingReleaseHighlights = FilterOut-UnreleasedPackages -releaseHighlights $incomingReleaseHighlights


if ($incomingReleaseHighlights.Count -gt 0)
{
    Write-GeneralReleaseNote `
    -releaseHighlights $incomingReleaseHighlights `
    -releaseNotesContent $existingReleaseContent `
    -releaseFilePath $releaseFilePath

    Set-Content -Path $pathToDateOfLatestUpdates -Value (Get-Date -Format "yyyy-MM-dd") -NoNewline
}