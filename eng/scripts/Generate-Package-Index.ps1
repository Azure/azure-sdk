param (
  $language = "all",
  $releaseFolder = "$PSScriptRoot\..\..\_data\releases\latest",
  $outputFolder = "."
)
Set-StrictMode -Version 3

$releaseFolder = Resolve-Path $releaseFolder
$outputFolder = Resolve-Path $outputFolder

function MSDocLink($lang, $pkg) 
{
  if ($pkg.MSDocs -eq "NA") { return "" }
  if ($pkg.MSDocs -ne "") { return "[docs]($($pkg.MSDocs))" }

  $msPackagePath = $pkg.Package -replace "@?azure[\.\-/]", ""
  return "[docs](https://docs.microsoft.com/${lang}/api/overview/azure/${msPackagePath}-readme${suffix}/)"
}

function Get-Heading()
{
 return  "| Name | Package | Docs | Source |" + [System.Environment]::NewLine + 
         "| ---- | ------- | ---- | ------ |" + [System.Environment]::NewLine
}
function Get-Row($pkg, $lang, $packageFormat, $sourceFormat)
{
  $displayName = $pkg.DisplayName
  $docs = MSDocLink $lang $pkg
  $docs = $docs -replace "https://docs.microsoft.com(/en-us)?", ""

  $version = $pkg.VersionGA
  if ($version -eq "") { $version = $pkg.VersionPreview }

  if ($version -eq "") {
    Write-Warning "No version found for $($pkg.Package) so skipping"
    return
  }

  if ($pkg.VersionGA -ne "" -and $pkg.VersionPreview -ne "") {
    $package = $packageFormat -f $pkg.Package, $pkg.VersionGA
    $package += "<br>"
    $package += $packageFormat -f $pkg.Package, $pkg.VersionPreview

    $source = $sourceFormat -f $pkg.Package, $pkg.VersionGA, $pkg.RepoPath
    $source += "<br>"
    $source += $sourceFormat -f $pkg.Package, $pkg.VersionPreview, $pkg.RepoPath
  }
  else {
    $package = $packageFormat -f $pkg.Package, $version
    $source = $sourceFormat -f $pkg.Package, $version, $pkg.RepoPath
  }

  if ($pkg.RepoPath -eq "NA") {
    $source = ""
  }
  elseif ($pkg.RepoPath.StartsWith("http")) {
    $source = "GitHub [${version}]($($pkg.RepoPath))"
  }

  return "| ${displayName} | ${package} | ${docs} | ${source} |" + [System.Environment]::NewLine
}

function Get-java-row($pkg)
{
  $groupId = $pkg.GroupId
  $packageFormat = "maven [{1}](https://search.maven.org/artifact/${groupId}/{0}/{1}/jar/)"
  $sourceFormat = "GitHub [{1}](https://github.com/Azure/azure-sdk-for-java/tree/{0}_{1}/sdk/{2}/{0}/)"
  
  return Get-Row $pkg "java" $packageFormat $sourceFormat
}

function Get-js-row($pkg)
{
  $packageFormat = "npm [{1}](https://www.npmjs.com/package/{0}/v/{1})"
  $trimmedPackage = $pkg.Package -replace "^@azure/", ""
  $sourceFormat = "GitHub [{1}](https://github.com/Azure/azure-sdk-for-js/tree/{0}_{1}/sdk/{2}/${trimmedPackage}/)"
  return Get-Row $pkg "javascript" $packageFormat $sourceFormat
}

function Get-dotnet-row($pkg)
{
  $packageFormat = "NuGet [{1}](https://www.nuget.org/packages/{0}/{1})"
  $sourceFormat = "GitHub [{1}](https://github.com/Azure/azure-sdk-for-net/tree/{0}_{1}/sdk/{2}/{0}/)"
  return Get-Row $pkg "dotnet" $packageFormat $sourceFormat
}

function Get-python-row($pkg)
{
  $packageFormat = "pypi [{1}](https://pypi.org/project/{0}/{1})"
  $sourceFormat = "GitHub [{1}](https://github.com/Azure/azure-sdk-for-python/tree/{0}_{1}/sdk/{2}/{0}/)"
  return Get-Row $pkg "python" $packageFormat $sourceFormat
}

function Write-Markdown($lang)
{
  $packagelistFile = Join-Path $releaseFolder "$lang-packages.csv"
  $packageList = Get-Content $packagelistFile | ConvertFrom-Csv | Sort-Object Type, DisplayName, Package, GroupId
  $packageList = $packageList | Where-Object { $_.Hide -ne "true" }

  $clientPackageList = $packageList | Where-Object { $_.New -eq "true" }
  $otherPackages = $packageList | Where-Object { !$_.New -ne "true" }

  $fileContent = Get-Heading
  $LangFunction = "Get-$lang-row"
  foreach($pkg in $clientPackageList)
  {
    $fileContent += &$LangFunction $pkg 
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
  foreach($pkg in $allPackageList)
  {
    $allFileContent += &$LangFunction $pkg
  }

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
  default {
    Write-Host "Unrecognized Language: $language"
    exit 1
  }
}

