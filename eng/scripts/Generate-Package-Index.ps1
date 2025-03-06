param (
  $language = "all",
  $releaseFolder = "$PSScriptRoot\..\..\_data\releases\latest",
  $outputFolder = "."
)
Set-StrictMode -Version 3

. (Join-Path $PSScriptRoot PackageList-Helpers.ps1)

$releaseFolder = Resolve-Path $releaseFolder
$outputFolder = Resolve-Path $outputFolder

function MSDocLink($pkg, $linkTemplates)
{
  if ($pkg.MSDocs -eq "NA") { return "" }
  if ($pkg.MSDocs -ne "") {
    $msdoclink = $pkg.MSDocs
  }
  else {
    $preSuffix = GetLinkTemplateValue $linkTemplates "pre_suffix"
    $msdoclink = GetLinkTemplateValue $linkTemplates "msdocs_url_template" $pkg.Package

    if (!$pkg.VersionGA -and $pkg.VersionPreview -and $preSuffix) {
      $msdoclink += $preSuffix
    }
  }
  # Make relative link
  $msdoclink = $msdoclink -replace "https://(docs|learn).microsoft.com(/en-us)?", ""
  return "[docs]($msdoclink)"
}

function Get-Heading()
{
 return  "| Name | Package | Docs | Source |" + [System.Environment]::NewLine +
         "| ---- | ------- | ---- | ------ |" + [System.Environment]::NewLine
}

function Get-Row($pkg, $linkTemplates)
{
  $MDLinkFormat = "{0} [{1}]({2})"
  $srcLabel = "GitHub"
  $pkgLabel = GetLinkTemplateValue $linkTemplates "package_label"
  $displayName = $pkg.DisplayName

  $version = $pkg.VersionGA
  if ($version -eq "") { $version = $pkg.VersionPreview }

  if ($version -eq "") {
    Write-Warning "No version found for $($pkg.Package) so skipping"
    return
  }

  # GroupId only exists for java so we need to test before we try and access
  $groupId = $null
  if ([bool]($pkg.PSobject.Properties.name -match "GroupId")) {
    $groupId = $pkg.GroupId
  }

  if ($pkg.VersionGA -ne "" -and $pkg.VersionPreview -ne "") {
    $pkgLink = GetLinkTemplateValue $linkTemplates "package_url_template" $pkg.Package $pkg.VersionGA $pkg.RepoPath $groupId
    $package = $MDLinkFormat -f $pkgLabel, $pkg.VersionGA, $pkgLink
    $package += "<br>"
    $pkgLink = GetLinkTemplateValue $linkTemplates "package_url_template" $pkg.Package $pkg.VersionPreview $pkg.RepoPath $groupId
    $package += $MDLinkFormat -f $pkgLabel, $pkg.VersionPreview, $pkgLink

    $srcLink = GetLinkTemplateValue $linkTemplates "source_url_template" $pkg.Package $pkg.VersionGA $pkg.RepoPath
    $source = $MDLinkFormat -f $srcLabel, $pkg.VersionGA, $srcLink
    if (!$pkg.RepoPath.StartsWith("http")) {
      $source += "<br>"
      $srcLink = GetLinkTemplateValue $linkTemplates "source_url_template" $pkg.Package $pkg.VersionPreview $pkg.RepoPath
      $source += $MDLinkFormat -f $srcLabel, $pkg.VersionPreview, $srcLink
    }
  }
  else {
    $pkgLink = GetLinkTemplateValue $linkTemplates "package_url_template" $pkg.Package $version $pkg.RepoPath $groupId
    $package = $MDLinkFormat -f $pkgLabel, $version, $pkgLink

    $srcLink = GetLinkTemplateValue $linkTemplates "source_url_template" $pkg.Package $version $pkg.RepoPath
    $source = $MDLinkFormat -f $srcLabel, $version, $srcLink
  }

  if ($pkg.RepoPath -eq "NA") {
    $source = ""
  }

  $docs = MSDocLink $pkg $linkTemplates

  return "| ${displayName} | ${package} | ${docs} | ${source} |" + [System.Environment]::NewLine
}

function Write-Markdown($lang)
{
  $langLinkTemplates = GetLinkTemplates $lang
  $packagelistFile = Join-Path $releaseFolder "$lang-packages.csv"
  $packageList = Get-Content $packagelistFile | ConvertFrom-Csv | Sort-Object Type, DisplayName, Package, GroupId
  $packageList = $packageList | Where-Object { $_.Hide -ne "true" }

  $clientPackageList = $packageList | Where-Object { $_.New -eq "true" }
  $otherPackages = $packageList | Where-Object { !($_.New -eq "true") }

  $fileContent = Get-Heading
  foreach($pkg in $clientPackageList)
  {
    $fileContent += Get-Row $pkg $langLinkTemplates
  }
  $fileLang = $lang
  if ($lang -eq "js") {
    $fileLang = "javascript"
  }

  $mdfile = Join-Path $outputFolder "$fileLang-new.md"
  Write-Host "Writing $mdfile"
  Set-Content $mdfile -Value $fileContent -NoNewline

  $allPackageList = $clientPackageList + $otherPackages

  $allFileContent = Get-Heading
  $deprecated = 0
  foreach($pkg in $allPackageList)
  {
    if ($pkg.Support -eq 'deprecated') {
      $deprecated++
    } else {
      $allFileContent += Get-Row $pkg $langLinkTemplates
    }
  }
  Write-Host "Skipped $deprecated deprecated package"

  $allMdfile = Join-Path $outputFolder "$fileLang-all.md"
  Write-Host "Writing $allMdfile"
  Set-Content $allMdfile -Value $allFileContent -NoNewline
}

switch($language)
{
  "all" {
    Write-Markdown "java"
    Write-Markdown "js"
    Write-Markdown "dotnet"
    Write-Markdown "python"
    Write-Markdown "go"
    break
  }
  "java" {
    Write-Markdown $language
    break
  }
  "js" {
    Write-Markdown $language
    break
  }
  "dotnet" {
    Write-Markdown $language
    break
  }
  "python" {
    Write-Markdown $language
    break
  }
  "go" {
    Write-Markdown $language
    break
  }
  default {
    Write-Host "Unrecognized Language: $language"
    exit 1
  }
}

