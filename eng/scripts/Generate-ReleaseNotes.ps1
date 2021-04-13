param (
  [string]$releasePeriod,
  [string]$languageRepoDirectory,
  [string]$releaseDirectory,
  [string]$releaseFileName
)

$PATTERN_REGEX = "^\[pattern(\.(?<SectionName>\w+))?\]:\s#\s\((?<Pattern>.*)\)"

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

function UpdateRelatedYaml ($existingYamlContent, $releaseHighlights, $pathToRelatedYaml)
{
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
        $GroupId = $releaseHighlights[$key]["PackageProperties"].Group
        $highlightsBody = ($releaseHighlights[$key]["Content"] | Out-String).Trim()

        $newEntry = [ordered]@{}
        $newEntry.Add("name", $packageName)
        $newEntry.Add("version", $packageVersion)
        $newEntry.Add("groupId", $GroupId)
        $existingYamlContent.processed.Add($newEntry)
        $existingYamlContent.install.Add($newEntry)

        $packageSemVer = [AzureEngSemanticVersion]::ParseVersionString($PackageVersion)
        if ($packageSemVer.VersionType -eq "GA")
        {
            $existingYamlContent.ga.Add($packageFriendlyName)
        }
        if ($packageSemVer.VersionType -eq "Beta")
        {
            $existingYamlContent.beta.Add($packageFriendlyName)
        }
        if ($packageSemVer.VersionType -eq "Patch")
        {
            $existingYamlContent.patch.Add($packageFriendlyName)
        }

        $newEntry.Add("changelogUrl", $changelogUrl)
        $newEntry.Add("content", $highlightsBody)
        $existingYamlContent.highlights.Add($newEntry)
    }
    Set-Content -Path $pathToRelatedYaml -Value (ConvertTo-Yaml $existingYamlContent)
}

function Write-GeneralReleaseNote ($existingYamlContent, $releaseFilePath, $releaseTemplatePath)
{
    $templateContent = Get-Content -Path $releaseTemplatePath
    $newReleaseContent = @()
    foreach ($line in $templateContent)
    {
        if ($line -match $PATTERN_REGEX)
        {
            $sectionName = $matches["SectionName"]
            $pattern = $matches["Pattern"]
            $sectionYaml = $existingYamlContent[$sectionName] | Sort-Object
            
            if ($sectionYaml.name -ne $null) {
                $sectionYaml =  $sectionYaml | Sort-Object -Property name
            }

            $sectionMd= @()

            foreach ($item in $existingYamlContent[$sectionName])
            {
                $packageName = $item.name
                $packageVersion = $item.version
                $packageFriendlyName = $item

                if ($null -eq $packageFriendlyName)
                {
                    $packageFriendlyName = $packageName
                }
                $changelogUrl = $item.changelog
                $GroupId = $item.groupId
                $highlightsBody = $item.content
                $lineValue = $ExecutionContext.InvokeCommand.ExpandString($pattern)
                $sectionMd += $lineValue
            }
            $newReleaseContent += $sectionMd
        }
        $newReleaseContent += $line
    }

    Set-Content -Path $releaseFilePath -Value $newReleaseContent

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
$pathToRelatedYaml = (Join-Path $ReleaseDirectory $releasePeriod "${releaseFileName}.yaml")
LogDebug "Release File Path [ $releaseFilePath ]"
LogDebug "Related Yaml File Path [ $pathToRelatedYaml ]"

if (!(Test-Path $pathToRelatedYaml))
{
    Set-Content -Path $pathToRelatedYaml -Value @("processed:","ga:","patch:","beta:","install:", "highlights:")
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
  $presentKey = $existingYamlContent.processed | Where-Object { ($_.name + ':' + $_.version) -eq $key }
  if ($presentKey.Count -gt 0)
  {
    $incomingReleaseHighlights.Remove($key)
  }
}

$incomingReleaseHighlights = FilterOut-UnreleasedPackages -releaseHighlights $incomingReleaseHighlights

if ($incomingReleaseHighlights.Count -gt 0)
{
    $existingYamlContent = UpdateRelatedYaml `
    -releaseHighlights $incomingReleaseHighlights `
    -existingYamlContent $existingYamlContent `
    -pathToRelatedYaml $pathToRelatedYaml

    Write-GeneralReleaseNote `
    -existingYamlContent $existingYamlContent `
    -releaseFilePath $releaseFilePath `
    -releaseTemplatePath $releaseTemplatePath

    Set-Content -Path $pathToDateOfLatestUpdates -Value (Get-Date -Format "yyyy-MM-dd") -NoNewline
}