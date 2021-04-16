param (
  [string]$releasePeriod,
  [string]$languageRepoDirectory,
  [string]$releaseDirectory,
  [string]$releaseFileName
)

$PATTERN_REGEX = "^\[pattern(\.(?<SectionName>\w+))?\]:\s#\s\((?<Pattern>.*)\)"

# Filters out packages if the versions are not found in the packages.csv file.
# Also appends DisplayName and ServiceName to the releaseHighlights
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
            $releaseHighlights[$key]["ServiceName"] = $packageMetaData.ServiceName
            $results.Add($key, $releaseHighlights[$key])
        }
        else 
        {
            LogDebug "[ $packageName ] with version  [ $releaseVersion ] was skipped because there are duplicate versions in the package csv"
        }
    }
    return $results
}

function UpdateRelatedYaml ($existingYamlContent, $releaseHighlights, $pathToRelatedYaml)
{
    if ($null -eq $existingYamlContent.oldEntries)
    {
        $existingYamlContent.oldEntries = New-Object "System.Collections.Generic.List[System.Collections.Specialized.OrderedDictionary]"
    }

    if ($null -eq $existingYamlContent.newEntries)
    {
        $existingYamlContent.newEntries = New-Object "System.Collections.Generic.List[System.Collections.Specialized.OrderedDictionary]"
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
        $groupId = $releaseHighlights[$key]["PackageProperties"].Group
        $service = $releaseHighlights[$key]["ServiceName"]
        $highlightsBody = ($releaseHighlights[$key]["Content"] | Out-String).Trim()
        $packageSemVer = [AzureEngSemanticVersion]::ParseVersionString($PackageVersion)

        $newEntry = New-Object "System.Collections.Specialized.OrderedDictionary"
        $oldEntry = New-Object "System.Collections.Specialized.OrderedDictionary"

        $newEntry.Add("name", $packageName)
        $oldEntry.Add("name", $packageName)

        $newEntry.Add("version", $packageVersion)
        $oldEntry.Add("version", $packageVersion)
        if ($null -ne $GroupId)
        {
            $newEntry.Add("groupId", $GroupId)
            $oldEntry.Add("groupId", $GroupId)
        }

        $existingYamlContent.oldEntries.Add($oldEntry)

        $newEntry.Add("service", $service)
        $newEntry.Add("versionType", $packageSemVer.VersionType)
        $newEntry.Add("changelogUrl", $changelogUrl)
        $newEntry.Add("content", $highlightsBody)
        $existingYamlContent.newEntries.Add($newEntry)
    }
    Set-Content -Path $pathToRelatedYaml -Value (ConvertTo-Yaml $existingYamlContent)
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
$pathToRelatedYaml = (Join-Path $ReleaseDirectory ".." _data package_data $releasePeriod "${releaseFileName}.yaml")
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
    Set-Content -Path $pathToRelatedYaml -Value @("oldEntries:","newEntries:")
}

# Install Powershell Yaml
$ProgressPreference = "SilentlyContinue"
if ((Get-PSRepository).Where({$_.Name -eq "PSGallery"}).Count -eq 0)
{
    Register-PSRepository -Default -ErrorAction:SilentlyContinue
}

if ((Get-Module -ListAvailable -Name powershell-yaml).Where({ $_.Version -eq "0.4.2"} ).Count -eq 0)
{
    Install-Module -Name powershell-yaml -RequiredVersion 0.4.2 -Force -Scope CurrentUser
}

$existingYamlContent = ConvertFrom-Yaml (Get-Content $pathToRelatedYaml -Raw) -Ordered
$pathToDateOfLatestUpdates = (Join-Path $ReleaseDirectory "${releaseFileName}.lastupdated")
$collectChangelogPath = (Join-Path $commonScriptsPath Collect-ChangeLogs.ps1)
$dateOfLatestUpdate = @(Get-Content -Path $pathToDateOfLatestUpdates)

if ($dateOfLatestUpdate.Count -eq 0)
{
    LogError "Please make sure a valid date is present for [ $releaseFileName ] at [ $pathToDateOfLatestUpdates ]"
    exit 1
}

$incomingReleaseHighlights = &$collectChangelogPath -FromDate $dateOfLatestUpdate[0]

foreach ($key in @($incomingReleaseHighlights.Keys))
{
  $presentKey = $existingYamlContent.oldEntries | Where-Object { ($_.name + ':' + $_.version) -eq $key }
  if ($presentKey.Count -gt 0)
  {
    $incomingReleaseHighlights.Remove($key)
  }
}

$incomingReleaseHighlights = FilterOut-UnreleasedPackages -releaseHighlights $incomingReleaseHighlights

if ($incomingReleaseHighlights.Count -gt 0)
{
    UpdateRelatedYaml `
    -releaseHighlights $incomingReleaseHighlights `
    -existingYamlContent $existingYamlContent `
    -pathToRelatedYaml $pathToRelatedYaml

    Set-Content -Path $pathToDateOfLatestUpdates -Value (Get-Date -Format "yyyy-MM-dd") -NoNewline
}