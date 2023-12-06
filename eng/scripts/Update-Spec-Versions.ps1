[CmdletBinding()]
param (
  [string]$specsRoot
)

Set-StrictMode -Version 3
$ProgressPreference = "SilentlyContinue"; # Disable invoke-webrequest progress dialog

. (Join-Path $PSScriptRoot PackageList-Helpers.ps1)

# spec - json file
#  path
#  name
#  version
# TODO: map to SDK library via readme.md or tspconfig.yaml

function CreateSpec($jsonFilesInPath, $relSpecPath)
{
  if ($relSpecPath -notmatch "^(?<serviceFamily>[^/]+)/(?<type>data-plane|resource-manager)/(?<rpPath>.+)?(?<verType>preview|stable)/(?<version>[^/]+)$") { 
    Write-Verbose "Skipping: '$relSpecPath' doesn't match the standard directory path regex"
    return $null
  }
  $serviceFamily = $matches["serviceFamily"]
  $rpPath = $matches["rpPath"]?.Trim('/')
  $verType = $matches["verType"]
  $versionFromPath = $matches["version"]
  $specType = $matches["type"]
  if ($specType -eq "data-plane") { $specType = "data" }
  if ($specType -eq "resource-manager") { $specType = "mgmt" }

  $version = ""
  $anyTypeSpec = $false

  $jsonFileList = @()
  $inconsistentVersion = $false
  foreach ($jsonFile in $jsonFilesInPath) 
  {
    $specContent = Get-Content $jsonFile | ConvertFrom-Json -AsHashtable
    #Write-Host "Processing $jsonFile"
    
    if (!$specContent) { Write-Verbose "Failed to read $specPath"; continue }
    if (!$specContent.ContainsKey("info") -or !$specContent.info.ContainsKey("version")) { Write-Verbose "Skipping: '$jsonFile' doesn't contain info.version"; continue }

    if ($specType -eq "mgmt" -and $specContent.ContainsKey("host") -and $specContent.host -ne "management.azure.com") {
      Write-Verbose "Found mgmt spec at $specPath without management.azure.com as the host"
    }

    if (!$version) { $version = $specContent.info.version }

    if ($version -ne $specContent.info.version) {
      if ($serviceFamily -ne "network") {
        Write-Verbose "VersionMismatchBetweenOtherSpecs: '$($specContent.info.version)' != '$version' for '$jsonFile'."
      }
      $inconsistentVersion = $true
    }

    # Ignore differences with version starting with v or ending in -preview
    if (($versionFromPath -replace "v|-preview") -ne ($specContent.info.version -replace "v|-preview")) {
      if ($serviceFamily -ne "network") {
        Write-Verbose "VersionMismatchBetweenPathAndSpec: '$versionFromPath' != '$($specContent.info.version)' for '$jsonFile'"
      }
    }

    # TODO: Find TypeSpec project
    if ($specContent.info.ContainsKey('x-typespec-generated')) {
      $anyTypeSpec = $true
    }

    $jsonFileList += $jsonFile.Name
  }

  if ($inconsistentVersion) {
    $version = "Varies"
  }

  return [PSCustomObject][ordered]@{
    SpecPath = $relSpecPath
    ServiceFamily = $serviceFamily
    ResourcePath = $rpPath
    Version = $version
    VersionType = $verType
    Type = $specType
    IsTypeSpec = $anyTypeSpec
    JsonFiles = ($jsonFileList -join "|")
  }
}

function FindAllSpecs($specsRoot)
{
  $potentialSpecs = Get-ChildItem -Recurse -Include *.json $specsRoot
  #TODO: Map to tspconfig if 
  #$potentialTypeSpecs = Get-ChildItem -Recurse -Include tspconfig.yaml $specsRoot

  $processedPaths = @{}
  foreach ($potentialSpec in $potentialSpecs)
  {
    $specPath = $potentialSpec -replace "\\", "/"

    if ($specPath -match "/(examples|scenarios|restler|common|common-types)/") { continue }
    if ($specPath -notmatch "specification/(?<relSpecPath>[^/]+/(data-plane|resource-manager).*?/(preview|stable)/([^/]+))/[^/]+\.json$") { continue }

    $relSpecPath = $matches["relSpecPath"]

    if ($processedPaths.ContainsKey($relSpecPath)) { continue }

    $jsonFilesInPath = Get-ChildItem $potentialSpec.Directory *.json
    $processedPaths[$relSpecPath] = CreateSpec $jsonFilesInPath $relSpecPath
  }
  return $processedPaths.Values
}

function GatherSpecs($specsRoot)
{
  $specs = FindAllSpecs $specsRoot | Where-Object { $_ }

  $speclistFile = Join-Path $releaseFolder "specs.csv"
  Write-Host "Writing $speclistFile"

  $new = @($specs | Where-Object { $_.IsTypeSpec } | Sort-Object ServiceFamily, ResourcePath)
  $other = @($specs | Where-Object { !$_.IsTypeSpec } |  Sort-Object ServiceFamily, ResourcePath)

  $sortedSpecs = $new + $other
  $sortedSpecs | ConvertTo-CSV -NoTypeInformation -UseQuotes Always | Out-File $speclistFile -encoding ascii
}

GatherSpecs $specsRoot