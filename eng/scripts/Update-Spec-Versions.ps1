[CmdletBinding()]
param (
  [string]$specsRoot
)

Set-StrictMode -Version 3
$ProgressPreference = "SilentlyContinue"; # Disable invoke-webrequest progress dialog

. (Join-Path $PSScriptRoot PackageList-Helpers.ps1)

function GetJsonFiles($relSpecPath)
{
  # Assumes that working directory is the root of the repo, we might want to harden this assumption
  return Get-ChildItem "specification/$relSpecPath" *.json
}

function GetJsonFileListString($jsonFilesInPath)
{
  return ($jsonFilesInPath.Name | Sort-Object) -join "|"
}

function UpdateSpecMetadata($spec)
{
  $version = ""
  $anyTypeSpec = $false
  $inconsistentVersion = $false

  $jsonFilesInPath = GetJsonFiles $spec.SpecPath
  
  foreach ($jsonFile in $jsonFilesInPath) 
  {
    $specContent = Get-Content $jsonFile | ConvertFrom-Json -AsHashtable
    Write-Verbose "Processing $jsonFile"
    
    if (!$specContent) { Write-Verbose "Failed to read $specPath"; continue }
    if (!$specContent.ContainsKey("info") -or !$specContent.info.ContainsKey("version")) { Write-Verbose "Skipping: '$jsonFile' doesn't contain info.version"; continue }

    if ($spec.Type -eq "mgmt" -and $specContent.ContainsKey("host") -and $specContent.host -ne "management.azure.com") {
      Write-Verbose "Found mgmt spec at $specPath without management.azure.com as the host"
    }

    if (!$version) { $version = $specContent.info.version }

    if ($version -ne $specContent.info.version) {
      if ($spec.ServiceFamily -ne "network") {
        Write-Verbose "VersionMismatchBetweenOtherSpecs: '$($specContent.info.version)' != '$version' for '$jsonFile'."
      }
      $inconsistentVersion = $true
    }

    # Ignore differences with version starting with v or ending in -preview
    if (($spec.Version -replace "v|-preview") -ne ($specContent.info.version -replace "v|-preview")) {
      if ($spec.ServiceFamily -ne "network") {
        Write-Verbose "VersionMismatchBetweenPathAndSpec: '$($spec.Version)' != '$($specContent.info.version)' for '$jsonFile'"
      }
    }

    # TODO: Find TypeSpec project
    if ($specContent.info.ContainsKey('x-typespec-generated')) {
      $anyTypeSpec = $true
    }
  }

  if ($inconsistentVersion) {
    $version = "Varies"
  }

  # Get the first date a file was checked into the spec version folder
  $dateCreated = git log --diff-filter=A --pretty=format:'%cs' --reverse -- "specification/$($spec.SpecPath)" | Select-Object -First 1

  $spec.Version = $version
  $spec.IsTypeSpec = $anyTypeSpec
  $spec.DateCreated = $dateCreated
  $spec.JsonFiles = GetJsonFileListString $jsonFilesInPath

  return $spec
}

function DiscoverSpec($relSpecPath)
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

  return [PSCustomObject][ordered]@{
    SpecPath = $relSpecPath
    ServiceFamily = $serviceFamily
    ResourcePath = $rpPath
    Version = $versionFromPath
    VersionType = $verType
    Type = $specType
    IsTypeSpec = ""
    DateCreated = ""
    JsonFiles = GetJsonFileListString (GetJsonFiles $relSpecPath)
  }
}

function FindAllSpecs($specsRoot)
{
  $potentialSpecs = Get-ChildItem -Recurse -Include *.json $specsRoot
  #TODO: Map to tspconfig
  #$potentialTypeSpecs = Get-ChildItem -Recurse -Include tspconfig.yaml $specsRoot

  $processedPaths = @{}
  foreach ($potentialSpec in $potentialSpecs)
  {
    $specPath = $potentialSpec -replace "\\", "/"

    if ($specPath -match "/(examples|scenarios|restler|common|common-types)/") { continue }
    if ($specPath -notmatch "specification/(?<relSpecPath>[^/]+/(data-plane|resource-manager).*?/(preview|stable)/([^/]+))/[^/]+\.json$") { continue }

    $relSpecPath = $matches["relSpecPath"]

    if ($processedPaths.ContainsKey($relSpecPath)) { continue }

    $processedPaths[$relSpecPath] = DiscoverSpec $relSpecPath
  }
  
  return $processedPaths.Values
}

function GatherSpecs($specsRoot)
{
  $newSpecsToWrite = @()
  try
  {
    Push-Location $specsRoot
    $discoveredSpecs = FindAllSpecs $specsRoot | Where-Object { $_ }

    $speclistFile = Join-Path $releaseFolder "specs.csv"
    $specs = Get-Content $speclistFile | ConvertFrom-Csv

    foreach ($discoveredSpec in $discoveredSpecs)
    {
      $foundSpecs = $specs.Where({ $_.SpecPath -eq $discoveredSpec.SpecPath })

      if ($foundSpecs.Count -gt 1) { 
        Write-Host "Found more than one spec with path $($discoveredSpec.SpecPath) that should never happen but only taking the first one."
      }
      if ($foundSpecs.Count -eq 1) {
        $spec = $foundSpecs[0]
      }
      else {
        # Add new one
        $spec = $discoveredSpec
      }

      # If json file ist changes or missing date created query that data
      if ($spec.JsonFiles -ne $discoveredSpec.JsonFiles -or $spec.DateCreated -eq "")
      {
        $spec = UpdateSpecMetadata $spec
      }

      $newSpecsToWrite += $spec
    }
  }
  finally {
    Pop-Location
  }

  Write-Host "Writing $speclistFile"
  $new = @($newSpecsToWrite | Where-Object { $_.IsTypeSpec -eq "True" } | Sort-Object ServiceFamily, ResourcePath, SpecPath)
  $other = @($newSpecsToWrite | Where-Object { $_.IsTypeSpec -ne "True" } |  Sort-Object ServiceFamily, ResourcePath, SpecPath)

  $sortedSpecs = $new + $other
  $sortedSpecs | ConvertTo-CSV -NoTypeInformation -UseQuotes Always | Out-File $speclistFile -encoding ascii
}

GatherSpecs $specsRoot
