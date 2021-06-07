param (
  [string]$releasePeriod,
  [string]$commonScriptPath,
  [string]$releaseDirectory,
  [string]$repoLanguage,
  [string]$changedPackagesPath
)

function GetReleaseNotesData ($changedPackages)
{
    $entries = New-Object "System.Collections.Generic.List[System.Collections.Specialized.OrderedDictionary]"
    foreach ($package in $changedPackages)
    {
        if ($package.Language -ne $repoLanguage)
        {
            continue
        }

        $changelogBlobLink = "$($package.SourceUrl)/CHANGELOG.md"
        $changelogRawLink = $changelogBlobLink -replace "https://github.com/(.*)/(tree|blob)", "https://raw.githubusercontent.com/`$1"
        try
        { 
            $changelogContent = Invoke-RestMethod -Method GET -Uri $changelogRawLink -MaximumRetryCount 2
        }
        catch
        {
            # Skip if the changelog Url is invalid
            LogWarning "Failed to get content from ${changelogRawLink}"
            LogWarning "ReleaseNotes will not be collected for $($package.Package) : $($package.UpdatedVersion). Please add entry manually."
            continue
        }

        $changeLogEntries = Get-ChangeLogEntriesFromContent -changeLogContent $changelogContent
        $updatedVersionEntry = $changeLogEntries[$package.UpdatedVersion]

        if ($updatedVersionEntry)
        {
            $packageSemVer = [AzureEngSemanticVersion]::ParseVersionString($package.UpdatedVersion)
            $releaseEntryContent = @()

            if ($updatedVersionEntry.ReleaseContent)
            {
                # Bumping all MD headers by one level to fit in with the release template structure.
                $updatedVersionEntry.ReleaseContent | %{
                    $line = $_
                    if ($line.StartsWith("#"))
                    {
                        $line = "#${line}"
                    }
                    $releaseEntryContent += $line
                }
            }

            $entry = [ordered]@{
                Name = $package.Package
                Version = $package.UpdatedVersion
                DisplayName = $package.DisplayName
                ServiceName = $package.ServiceName
                VersionType = $packageSemVer.VersionType
                Hidden = $false
                ChangelogUrl = $changelogBlobLink
                ChangelogContent = ($releaseEntryContent | Out-String).Trim()
            }

            if (!$entry.DisplayName)
            {
                $entry.DisplayName = $entry.Name
            }

            if ($package.PSObject.Members.Name -contains "GroupId")
            {
                $entry.Add("GroupId", $package.GroupId)
            }
            $entries.Add($entry)
        }
    }
    return $entries
}

. (Join-Path $commonScriptPath ChangeLog-Operations.ps1)
. (Join-Path $commonScriptPath SemVer.ps1)

$pathToRelatedYaml = (Join-Path $ReleaseDirectory ".." _data releases $releasePeriod "${repoLanguage}.yml")
LogDebug "Related Yaml File Path [ $pathToRelatedYaml ]"

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

$changedPackages = Get-Content -Path $changedPackagesPath | ConvertFrom-Json
$incomingReleaseEntries = GetReleaseNotesData -changedPackages $changedPackages
$filteredEntries = New-Object "System.Collections.Generic.List[System.Collections.Specialized.OrderedDictionary]"

if($existingYamlContent.entries)
{
    foreach ($entry in $incomingReleaseEntries)
    {
        $presentKey = $existingYamlContent.entries.Where( { ($_.name -eq $entry.name) -and ($_.version -eq $entry.version) } )
        if ($presentKey.Count -gt 0)
        {
            continue
        }
        $filteredEntries.Add($entry)
    }
}
else 
{
    $filteredEntries = $incomingReleaseEntries
}

$existingYamlContent.entries = $filteredEntries

Set-Content -Path $pathToRelatedYaml -Value (ConvertTo-Yaml $existingYamlContent)