param (
  [string]$releaseDateString = "",
  [string]$releaseTemplate = "$PSScriptRoot\release-template",
  [string]$releaseRootFolder = "$PSScriptRoot\..\..\releases",
  [bool]$publishRelease = $false,
  [string]$releaseFileName = "*",
  [string[]]$ExcludeFileNames = @()
)

if ($releaseDateString -eq "") {
  $releaseDate = [DateTime]::Now
}
else {
  $releaseDate = [DateTime]$releaseDateString
}

$releaseString = $releaseDate.ToString("yyyy-MM")
$releaseFolder = Join-Path (Resolve-Path $releaseRootFolder) $releaseString
$releaseSidebar = Resolve-Path "$PSScriptRoot\..\..\_data\sidebars\releases_sidebar.yml"

if ($publishRelease) {
  ### Update release sidebar
  Install-Module -Name powershell-yaml -RequiredVersion 0.4.2 -Force -Scope CurrentUser

  $yml = Get-Content $releaseSidebar | ConvertFrom-Yaml -Ordered

  $yearGroupName = $releaseDate.ToString("yyyy") + " Releases"
  $yearGroup = $yml.entries.folders | Where-Object { $_.title -eq $yearGroupName }

  if (!$yearGroup) {
    $yearGroup = [ordered]@{ title = "$yearGroupName"; folderitems = new-object "System.Collections.Generic.List[object]" }

    # insert in spot 1 as spot 0 is reserved for Latest
    $yml.entries[0].folders.Insert(1, $yearGroup)
  }

  $monthGroupName = $releaseDate.ToString("MMMM")
  $monthGroup = $yearGroup.folderitems | Where-Object { $_.title -eq $monthGroupName }

  if (!$monthGroup) {
    $monthGroup = [ordered]@{ title = $monthGroupName; url = "/releases/$releaseString/index.html" }
    $yearGroup.folderitems.Insert(0, $monthGroup)
  }

  $yml | ConvertTo-Yaml -OutFile $releaseSidebar -Force
  
  # If the release folder exists exit otherwise continue on and create the release folder
  if (Test-Path $releaseFolder) {
    exit 0
  }
}

if (!(Test-Path $releaseFolder)) {
  New-Item -Type Directory $releaseFolder | Out-Null
}

### Copy template files for ones that don't exist
foreach ($file in (Get-ChildItem $releaseTemplate/$releaseFileName -Exclude $ExcludeFileNames)) {
  $newFile = Join-Path $releasefolder $file.Name
  if (Test-Path $newFile) {
    Write-Host "Skipping $newFile because it already exists"
  }
  else {
    Copy-Item $file $newFile
  }
}

### Update template files with date
foreach ($file in (Get-ChildItem $releaseFolder/$releaseFileName)) {
  $fileContent = Get-Content $file -Raw

  $dateFormats = [regex]::Matches($fileContent, "%%(?<format>.*?)%%")

  foreach ($dateFormatMatch in $dateFormats)
  {
    $fileContent = $fileContent -replace $dateFormatMatch.Groups[0], $releaseDate.ToString($dateFormatMatch.Groups["format"])
  }

  $fileContent | Set-Content $file -NoNewline
}
