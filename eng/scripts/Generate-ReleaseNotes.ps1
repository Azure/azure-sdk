param (
  [string]$releasePeriod,
  [string]$languageRepoDirectory,
  [string]$releaseDirectory,
  [string]$releaseFileName
)

# Filters out packages if the versions are not found in the packages.csv file.
# Also appends DisplayName and ServiceName to the releaseHighlights
function FilterOut-UnreleasedPackages ($releaseHighlights)
{
    $results = @()

    foreach ($key in $releaseHighlights.Keys)
    {
        $keyInfo = $key.Split(":")
        $packageName = $keyInfo[0]
        $releaseVersion = $keyInfo[1]
        $packageGroupId = $releaseHighlights[$key]["PackageProperties"].Group

        $packageMetaData = $CsvMetaData.Where({ ($_.Package -eq $packageName) -and
             ($_.GroupId -eq $packageGroupId) -and ($_.Hide -ne "true") })

        if ($packageMetaData.Count -eq 1)
        {
            $sortedVersions = [AzureEngSemanticVersion]::SortVersionStrings(@($releaseVersion, $packageMetaData.VersionGA, $packageMetaData.VersionPreview))

            if (($sortedVersions[0] -eq $releaseVersion) -and ($releaseVersion -ne $packageMetaData.VersionGA) -and ($releaseVersion -ne $packageMetaData.VersionPreview))
            {
                continue
                LogDebug "[ $packageName ] with version  [$releaseVersion ] was skipped because it has a newer release version than present in the package csv"
            }
            $packageSemVer = [AzureEngSemanticVersion]::ParseVersionString($releaseVersion)
            
            $entry = [ordered]@{
                Name = $packageName
                Version = $releaseVersion
                DisplayName = $packageMetaData.DisplayName
                ServiceName = $packageMetaData.ServiceName
                VersionType = $packageSemVer.VersionType
                Hidden = $false
                ChangelogUrl = $releaseHighlights[$key].ChangelogUrl
                ChangelogContent = ($releaseHighlights[$key].Content | Out-String).Trim()
            }

            if (!$entry.DisplayName)
            {
                $entry.DisplayName = $entry.Name
            }

            if ($packageGroupId)
            {
                $entry.Add("GroupId", $packageGroupId)
            }

            $results += $entry
        }
        else 
        {
            LogDebug "[ $packageName ] with version  [ $releaseVersion ] was skipped because there are duplicate versions in the package csv"
        }
    }
    return $results
}

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

$releaseTemplatePath = (Join-Path $ReleaseDirectory ".." eng scripts release-template "${releaseFileName}.md")
$releaseFilePath = (Join-Path $ReleaseDirectory $releasePeriod "${releaseFileName}.md")
$pathToRelatedYaml = (Join-Path $ReleaseDirectory ".." _data releases $releasePeriod "${releaseFileName}.yml")
LogDebug "Release Template Path [ $releaseTemplatePath ]"
LogDebug "Release File Path [ $releaseFilePath ]"
LogDebug "Related Yaml File Path [ $pathToRelatedYaml ]"

if (!(Test-Path $releaseFilePath))
{
    &(Join-Path $PSScriptRoot Generate-Release-Structure.ps1) -releaseFileName "${releaseFileName}.md"
}

if (!(Test-Path $pathToRelatedYaml))
{
    New-Item -Path $pathToRelatedYaml -Force
    Set-Content -Path $pathToRelatedYaml -Value @("entries:")
}

# Install Powershell Yaml
$ProgressPreference = "SilentlyContinue"
$ToolsFeed = "https://pkgs.dev.azure.com/azure-sdk/public/_packaging/azure-sdk-tools/nuget/v2"
Register-PSRepository -Name azure-sdk-tools-feed -SourceLocation $ToolsFeed -PublishLocation $ToolsFeed -InstallationPolicy Trusted -ErrorAction SilentlyContinue
Install-Module -Repository azure-sdk-tools-feed powershell-yaml

$existingYamlContent = ConvertFrom-Yaml (Get-Content $pathToRelatedYaml -Raw) -Ordered
$collectChangelogPath = (Join-Path $commonScriptsPath Collect-ChangeLogs.ps1)

$incomingReleaseHighlights = &$collectChangelogPath -FromDate [Datetime]$releasePeriod

foreach ($key in @($incomingReleaseHighlights.Keys))
{
  $presentKey = $existingYamlContent.entries.Where( { ($_.name + ':' + $_.version) -eq $key } )
  if ($presentKey.Count -gt 0)
  {
    $incomingReleaseHighlights.Remove($key)
  }
}

$filteredReleaseHighlights = FilterOut-UnreleasedPackages -releaseHighlights $incomingReleaseHighlights

if ($null -eq $existingYamlContent.entries)
{
    $existingYamlContent.entries = New-Object "System.Collections.Generic.List[System.Collections.Specialized.OrderedDictionary]"
}

foreach ($entry in $filteredReleaseHighlights)
{
    $existingYamlContent.entries += $entry
}

Set-Content -Path $pathToRelatedYaml -Value (ConvertTo-Yaml $existingYamlContent)