param (
  $language = "all",
  $releaseFolder = "$PSScriptRoot\..\..\_data\releases\latest",
  $allFolder =  "$PSScriptRoot\..\..\_data\allpackages",
  $outputFolder = "."
)

$releaseFolder = Resolve-Path $releaseFolder
$allFolder = Resolve-Path $allFolder
$outputFolder = Resolve-Path $outputFolder


function MSDocLink($lang, $pkg) 
{
  if ($pkg.MSDocs -eq "NA") { return "" }
  if ($pkg.MSDocs -ne "") { return "[docs]($($pkg.MSDocs))" }

  $msPackagePath = $pkg.Package -replace "@?azure[\.\-/]", ""
  return "[docs](https://docs.microsoft.com/${lang}/api/overview/azure/${msPackagePath}-readme/)"
}

function Get-Heading()
{
 return  "| Service | Package | Docs | Source |`n" + 
         "| ------- | ------- | ---- | ------ |`n"
}
function Get-Row($pkg, $lang, $packageFormat, $sourceFormat)
{
  $service = $pkg.Service
  $docs = MSDocLink $lang $pkg

  if ($pkg.VersionGA -ne "" -and $pkg.VersionPreview -ne "") {
    $package = $packageFormat -f $pkg.Package, $pkg.VersionGA
    $package += "<br>"
    $package += $packageFormat -f $pkg.Package, $pkg.VersionPreview

    $source = $sourceFormat -f $pkg.Package, $pkg.VersionGA, $pkg.RepoPath
    $source += "<br>"
    $source += $sourceFormat -f $pkg.Package, $pkg.VersionPreview, $pkg.RepoPath
  }
  else {
    $version = $pkg.VersionGA
    if ($version -eq "") { $version = $pkg.VersionPreview }
    $package = $packageFormat -f $pkg.Package, $version
    $source = $sourceFormat -f $pkg.Package, $version, $pkg.RepoPath
  }

  if ($pkg.RepoPath -eq "NA") {
    $source = ""
  }

  return "| ${service} | ${package} | ${docs} | ${source} |`n"
}

function Get-java-row($pkg)
{
  $groupId = $pkg.GroupId
  $packageFormat = "maven [{1}](https://search.maven.org/artifact/${groupId}/{0}/{1}/jar/)"
  $sourceFormat = "github [{1}](https://github.com/Azure/azure-sdk-for-java/tree/{0}_{1}/sdk/{2}/{0}/)"
  
  return Get-Row $pkg "java" $packageFormat $sourceFormat
}

function Get-js-row($pkg)
{
  $packageFormat = "npm [{1}](https://www.npmjs.com/package/{0}/v/{1})"
  $sourceFormat = "github [{1}](https://github.com/Azure/azure-sdk-for-js/tree/{0}_{1}/sdk/{2}/{0}/)"
  return Get-Row $pkg "js" $packageFormat $sourceFormat
}

function Get-dotnet-row($pkg)
{
  $packageFormat = "nuget [{1}](https://www.nuget.org/packages/{0}/{1})"
  $sourceFormat = "github [{1}](https://github.com/Azure/azure-sdk-for-net/tree/{0}_{1}/sdk/{2}/{0}/)"
  return Get-Row $pkg "dotnet" $packageFormat $sourceFormat
}

function Get-python-row($pkg)
{
  $packageFormat = "pypi [{1}](https://pypi.org/project/{0}/{1})"
  $sourceFormat = "github [{1}](https://github.com/Azure/azure-sdk-for-python/tree/{0}_{1}/sdk/{2}/{0}/)"
  return Get-Row $pkg "python" $packageFormat $sourceFormat
}

function Write-Markdown($lang)
{
  $packagelistFile = Join-Path $releaseFolder "$lang-packages.csv"
  $packageList = Get-Content $packagelistFile | ConvertFrom-Csv | Sort-Object Service

  $fileContent = Get-Heading
  $LangFunction = "Get-$lang-row"
  foreach($pkg in $packageList)
  {
    $fileContent += &$LangFunction $pkg 
  }
  
  $mdfile = Join-Path $outputFolder "$lang-new.md"
  Write-Host "Writing $mdfile"
  $fileContent | Set-Content $mdfile

  $allPackagelistFile = Join-Path $allFolder "$lang-packages.csv"
  $allPackageList = Get-Content $allPackagelistFile | ConvertFrom-Csv | Sort-Object Service


  $allFileContent = Get-Heading
  foreach($pkg in $allPackageList)
  {
    $pkgProperties = [ordered]@{
      VersionGA = $pkg.Version
      VersionPreview = ""
      MSDocs = "NA"
      RepoPath = "NA"
    }
  
    $pkg | Add-Member -NotePropertyMembers $pkgProperties -Force

    $pkgEntries = $packageList | Where-Object { $_.Package -eq $pkg.Package -and $_.GroupId -eq $pkg.GroupId }

    if ($pkgEntries.Count -eq 1) {
      $pkg.MSDocs = $pkgEntries[0].MSDocs
      $pkg.RepoPath = $pkgEntries[0].RepoPath
    }

    $allFileContent += &$LangFunction $pkg
  }

  $allMdfile = Join-Path $outputFolder "$lang-all.md"
  Write-Host "Writing $allMdfile"
  $allFileContent | Set-Content $allMdfile
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
    exit(1)
  }
}

