[CmdletBinding()]
param (
  [string]$specsRoot,
  [bool]$mergeWithExisting = $false,
  [string]$specValidationIssues = ""
)

Set-StrictMode -Version 3
$ProgressPreference = "SilentlyContinue"; # Disable invoke-webrequest progress dialog

. (Join-Path $PSScriptRoot PackageList-Helpers.ps1)
. (Join-Path $PSScriptRoot .. common scripts Helpers PSModule-Helpers.ps1)

Install-ModuleIfNotInstalled "powershell-yaml" "0.4.7" | Import-Module

$specsGitFolder = (Join-Path $specsRoot ".git")
$specsGitFolderExists = (Test-Path $specsGitFolder) 
$specificationRoot = (Join-Path $specsRoot "specification") -replace "\\", "/"
$validationIssues = @()
function LogSpecValidationIssue($issue, $message)
{
  $script:validationIssues += "${issue}: ${message}"
  return $issue
}
function NormalizedParent($path)
{
  return $path -replace "/[^/]+$"
}
function MakeRelativeToSpecFolder($path)
{
  return ($path -replace "\\", "/") -replace "^$specificationRoot/", ""
}
function ResolveToSpecFolder($specPath, $jsonPath)
{
  if ($jsonPath) { $specPath = Join-Path $specPath $jsonPath }
  return Join-Path $specificationRoot $specPath
}

function GetServiceLifeCycle($allSpecs, $serviceFamily, $resourcePath)
{
  $stableSpecs = $allSpecs.Where({ 
    $_.ServiceFamily -eq $serviceFamily -and $_.ResourcePath -eq $resourcePath -and $_.VersionType -eq "stable" -and $_.IsTypeSpec -ne "True"
  })

  if ($stableSpecs.Count -eq 0) {
    return "Greenfield"
  }
  return "Brownfield"
}

function UpdateSpecMetadata($spec)
{
  $version = ""
  $anyTypeSpec = $false
  $inconsistentVersion = @()
  $jsonFiles = @($spec.JsonFiles.Split("|") | ForEach-Object { ResolveToSpecFolder $spec.SpecPath $_ })

  $specFolderPath = ""
  $validationErrors = @()
    
  foreach ($jsonFile in $jsonFiles)
  {
    if (-not (Test-Path $jsonFile)) {
      $validationErrors += LogSpecValidationIssue "SpecFileDoesNotExist" "'$jsonFile' under '$($spec.SpecPath)' doesn't exist."
      continue
    }

    $specContent = Get-Content $jsonFile | ConvertFrom-Json -AsHashtable
    Write-Verbose "Reading '$jsonFile' for metadata"

    $jsonFile = MakeRelativeToSpecFolder $jsonFile
    $specPathInfo = ParseSpecPath $jsonFile
    if (!$specPathInfo) { 
      $validationErrors += LogSpecValidationIssue "SpecFileIsNotUnderServiceFolder" "'$jsonFile' in '$($spec.SpecPath)' doesn't match standard path format." 
      continue
    }

    if ($spec.Type -ne $specPathInfo.Type) {
      $validationErrors += LogSpecValidationIssue "SpecTypeMismatchBetweenSpecFiles" "'$($specPathInfo.Type)' != '$($spec.Type)' for '$jsonFile'"
    }

    if ($spec.VersionType -ne $specPathInfo.VersionType) {
      $validationErrors += LogSpecValidationIssue "VersionTypeMismatchBetweenSpecFiles" "'$($specPathInfo.VersionType)' != '$($spec.VersionType)' for '$jsonFile'"
    }

    if (!$specFolderPath) { $specFolderPath = $specPathInfo.SpecFolderPath }
    if ($specFolderPath -ne $specPathInfo.SpecFolderPath) {
      $validationErrors += LogSpecValidationIssue "SpecPathMismatchBetweenSpecFiles" "'$specFolderPath' != '$($specPathInfo.SpecFolderPath)' for '$jsonFile'"
    }
    
    if (!$specContent) { Write-Verbose "Failed to read $jsonFile"; continue }
    if (!$specContent.ContainsKey("info") -or !$specContent.info.ContainsKey("version")) { Write-Verbose "Skipping: '$jsonFile' doesn't contain info.version"; continue }

    if ($spec.Type -eq "mgmt" -and $specContent.ContainsKey("host") -and $specContent.host -ne "management.azure.com") {
      Write-Verbose "Found mgmt spec at $jsonFile without management.azure.com as the host"
    }

    if (!$version) { $version = $specContent.info.version }

    if ($version -ne $specContent.info.version) {
      $validationErrors += LogSpecValidationIssue "VersionMismatchBetweenSpecFiles" "'$($specContent.info.version)' != '$version' for '$jsonFile'."
      $inconsistentVersion += $version
      $inconsistentVersion += $specContent.info.version
    }

    # Ignore differences with version starting with v or ending in -preview
    if (($spec.Version -replace "v|-preview") -ne ($specContent.info.version -replace "v|-preview")) {
      $validationErrors += LogSpecValidationIssue "VersionMismatchBetweenPathAndSpec" "'$($spec.Version)' != '$($specContent.info.version)' for '$jsonFile'"
    }

    # TODO: Find TypeSpec project
    if ($specContent.info.ContainsKey('x-typespec-generated')) {
      $anyTypeSpec = $true
    }
  }

  if ($inconsistentVersion) {
    $version = "Varies: " + ($inconsistentVersion | Sort-Object -Unique | Join-String -Sep ",")
  }

  $spec.Version = $version
  $spec.IsTypeSpec = $anyTypeSpec
  $spec.SpecValidationErrors = ($validationErrors | Sort-Object -Unique | Join-String -Sep ",")

  return $spec
}

function ParseSpecPath($specFilePath)
{
  if ($specFilePath -notmatch "^(?<serviceFamily>[^/]+)/(?<type>data-plane|resource-manager)(?<rpPath>.+)?/(?<verType>preview|stable)/(?<version>[^/]+).*?/[^/]+\.json$") { 
    Write-Verbose "Skipping: '$specFilePath' doesn't match the standard directory path regex"
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
    SpecFilePath = $specFilePath
    SpecFolderPath = NormalizedParent $specFilePath
    ServiceFamily = $serviceFamily
    ResourcePath = $rpPath
    Version = $versionFromPath
    VersionType = $verType
    Type = $specType
  }
}

function DiscoverSpec($specPathInfo, $specConfig)
{
  $specReadmeTag = ""
  if ($specConfig) 
  {
    $specPath = $specConfig.ReadmePath 
    $specReadmeTag = $specConfig.tag
    $jsonFiles = $specConfig["input-file"]
  }
  else 
  {
    $specPath = $relSpecPath
    $jsonFiles = Get-ChildItem (ResolveToSpecFolder $specPath) *.json | Split-Path -Leaf
  }

  $jsonFilesString = $jsonFiles | Sort-Object | Join-String -Sep "|"

  $spec = [PSCustomObject][ordered]@{
    SpecPath = $specPath
    SpecReadmeTag = $specReadmeTag
    SpecValidationErrors = ""
    ServiceFamily = $specPathInfo.ServiceFamily
    ResourcePath = $specPathInfo.ResourcePath
    Version = $specPathInfo.Version
    VersionType = $specPathInfo.VersionType
    Type = $specPathInfo.Type
    IsTypeSpec = ""
    ServiceLifeCycle = "" # Brownfield, Greenfield
    DateCreated = ""
    JsonFiles = $jsonFilesString
  }

  return UpdateSpecMetadata $spec
}

function FindAllSpecs($specsPath)
{
  #TODO: Map to tspconfig
  #$potentialTypeSpecs = Get-ChildItem -Recurse -Include tspconfig.yaml $specsPath

  $potentialReadmes = @(Get-ChildItem -Recurse -Include "README.md" $specsPath)

  Write-Host "Found $($potentialReadmes.Count) README.md files"
  $specToReadmeMap = @{}
  $readmeCount = 0

  foreach ($readmeFile in $potentialReadmes)
  {
    $specConfig = ParseReadme $readmeFile    
    if (!$specConfig) { continue }

    $readmeCount++
    $readmePath = MakeRelativeToSpecFolder $readmeFile.DirectoryName
    $specConfig = $specConfig | Add-Member -MemberType NoteProperty -Name "ReadmePath" -Value $readmePath -PassThru
    #$specConfig = $specConfig | Add-Member -MemberType NoteProperty -Name "ReadmeFileName" -Value $readmeFile.Name -PassThru

    foreach ($inputFile in $specConfig["input-file"])
    {
      $specRelPath = (Join-Path $readmePath $inputFile) -replace "\\", "/"
      $specToReadmeMap[$specRelPath] = $specConfig
    }
  }
  Write-Host "Found $readmeCount README.md files with yaml blocks"

  $potentialSpecs = Get-ChildItem -Recurse -Include *.json $specsPath

  Write-Host "Found $($potentialSpecs.Count) potential spec files"
  $specCount = 0
  $processedPaths = @{}
  foreach ($potentialSpec in $potentialSpecs)
  {
    $specPath = MakeRelativeToSpecFolder $potentialSpec

    # Skip files under common, examples, scenarios, restler, common-types 
    if ($specPath -match "/(examples|scenarios|restler|common|common-types)/") { continue }

    $specPathInfo = ParseSpecPath $specPath
    if (!$specPathInfo) { continue }

    $specCount++

    $relSpecPath = NormalizedParent $specPath
    $specConfig = $specToReadmeMap[$specPath]
    $pathKey = $relSpecPath
    if ($specConfig) { $pathKey = $specConfig.ReadmePath }

    if ($processedPaths.ContainsKey($pathKey)) { continue }
    
    $processedPaths[$pathKey] = DiscoverSpec $specPathInfo $specConfig
  }
  Write-Host "Discovered $specCount spec files"
  
  return $processedPaths.Values | Where-Object { $_ }
}

function CombineHashTables ($ht1, $ht2) 
{
  if (!$ht2) { return $ht1 }
  #Write-Host $ht2
  foreach ($key in $ht2.Keys) 
  {
    if ($ht1.ContainsKey($key)) {
      if ($ht1[$key] -is [Hashtable] -and $ht2[$key] -is [Hashtable]) {
        $ht1[$key] = CombineHashTables $ht1[$key] $ht2[$key]
      } else {
      $ht1[$key] = $ht1[$key] + $ht2[$key]
      }
    } else {
      $ht1[$key] = $ht2[$key]
    }
  }
  return $ht1
}
function ParseReadme($readme)
{
  try {
  $readmeContent = Get-Content $readme -Raw

  $yamlRegex = '(?s)```\s*yaml(?<con>.*?)\n(?<yaml>.*?)\s*```'

  $yms = [regex]::Matches($readmeContent, $yamlRegex) 

  if ($yms.Count -eq 0) {
    Write-Verbose "No yaml blocks found in $readme"
    return $null
  }

  $yamlContent = @{}

  $yamlBlocksNoConditions = $yms | Where-Object { $_.Groups["con"].Value -eq "" }

  foreach ($yb in $yamlBlocksNoConditions)  {
    $ybc = $yb.Groups["yaml"].Value | ConvertFrom-Yaml
    $yamlContent = CombineHashTables $yamlContent $ybc
  }

  if (!$yamlContent.ContainsKey("tag")) {
    Write-Verbose "No default tag found in $readme"
    return $null
  }

  $defaultTag = $yamlContent.tag
  $yamlBlocksWitConditions = $yms | Where-Object { $_.Groups["con"].Value -ne "" }

  foreach ($yb in $yamlBlocksWitConditions)
  {
    $condition = $yb.Groups["con"].Value.Trim()
    if ($condition) {
      $expectedCondition = "\`$\(tag\)\s*==\s*'${defaultTag}'"
      #Write-Host "[$condition] == [$expectedCondition]"
      if ($condition -notmatch $expectedCondition) {
        continue
      }
    }

    $ybc = $yb.Groups["yaml"].Value | ConvertFrom-Yaml
    $yamlContent = CombineHashTables $yamlContent $ybc
  } 
  }
  catch {
    Write-Host "Failed to parse $readme"
    throw
    return $null
  }
 
  return $yamlContent
}

function UpdateSpecIndex()
{
  $newSpecsToWrite = @()
  $discoveredSpecs = FindAllSpecs $specificationRoot

  $speclistFile = Join-Path $releaseFolder "specs.csv"
  $specs = Get-Content $speclistFile | ConvertFrom-Csv

  Write-Host "Updating metadata for $($discoveredSpecs.Count) discovered specs"
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

    $spec.SpecValidationErrors = $discoveredSpec.SpecValidationErrors
    $spec.SpecReadmeTag = $discoveredSpec.SpecReadmeTag
    $spec.JsonFiles = $discoveredSpec.JsonFiles
    $spec.Version = $discoveredSpec.Version
    $spec.IsTypeSpec = $discoveredSpec.IsTypeSpec

    if ($specsGitFolderExists -and !$spec.DateCreated -and !$spec.JsonFiles.Contains("/")) {
      # Given files can be in different locations with different dates which aren't easy to reconcile we are only computing the date created 
      # if there is only one folder. If there is only one folder then we compute the commit date for the earliest file in that folder.
      # This should handle all the new TypeSpec generated files which is what we are most interested in.
      $spec.DateCreated = git --git-dir=$specsGitFolder log --diff-filter=A --pretty=format:'%cs' --reverse -- "specification/$($spec.SpecPath)" | Select-Object -First 1
    }

    $spec.ServiceLifeCycle = GetServiceLifeCycle $specs $spec.ServiceFamily $spec.ResourcePath

    $newSpecsToWrite += $spec
  }

  if ($mergeWithExisting) 
  {
    foreach ($existingSpec in $specs)
    {
      $foundSpecs = $newSpecsToWrite.Where({ $_.SpecPath -eq $existingSpec.SpecPath })
      if ($foundSpecs.Count -eq 0) {
        $newSpecsToWrite += $existingSpec
      }
    }
  }

  Write-Host "Writing $speclistFile"
  $new = @($newSpecsToWrite | Where-Object { $_.IsTypeSpec -eq "True" } | Sort-Object ServiceFamily, ResourcePath, SpecPath)
  $other = @($newSpecsToWrite | Where-Object { $_.IsTypeSpec -ne "True" } |  Sort-Object ServiceFamily, ResourcePath, SpecPath)

  $sortedSpecs = $new + $other
  $sortedSpecs | ConvertTo-CSV -NoTypeInformation -UseQuotes Always | Out-File $speclistFile -encoding ascii
 
  $specsFromReadme = $sortedSpecs | Where-Object { $_.SpecReadmeTag -ne "" }
  Write-Host "Found $($specsFromReadme.Count) specs from readme files"

  if ($validationIssues.Count -gt 0) {
    $specsWithErrors = $sortedSpecs | Where-Object { $_.SpecValidationErrors }
    
    Write-Host "Found $($validationIssues.Count) validation issues across $($specsWithErrors.Count) specs."
    if ($specValidationIssues) {
      Write-Host "See $specValidationIssues for all the details."
      $validationIssues | Out-File $specValidationIssues
      exit 1
    }
  }
}

UpdateSpecIndex
