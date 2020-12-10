$releaseFolder =  Resolve-Path "$PSScriptRoot\..\..\_data\releases\latest"

$languageNameMapping = @{
  # c = "C" - -- These don't follow normal tagging rules
  cpp = "C++"
  dotnet = ".NET"
  java = "Java"
  js = "JavaScript"
  python = "Python"
  # go = "Go" -- No csv or tagging info
  # ios = "iOS" -- These don't follow normal tagging rules
  # android = "Android" -- These don't follow normal tagging/githubio rules
}

function Get-LanguageName($lang)
{
  $pkgLang = $languageNameMapping[$lang]
  if (!$pkgLang) { 
    $pkgLang = $lang
  }
  return $pkgLang
}

function Get-LangCsvFilePath($lang) 
{
  if ($languageNameMapping.ContainsKey($lang)) {
    return Join-Path $releaseFolder "$lang-packages.csv"
  }
  foreach ($key in $languageNameMapping.Keys)
  {
    if ($languageNameMapping[$key] -eq $lang) {
      return Join-Path $releaseFolder "$key-packages.csv"
    }
  }
  throw "Language $lang as it isn't in the language mapping."
}

function Get-PackageListForLanguage([string]$lang)
{
  $packagelistFile = Get-LangCsvFilePath $lang
  $packageList = Get-Content $packagelistFile | ConvertFrom-Csv | Sort-Object Type, DisplayName, Package, GroupId, ServiceName
  return $packageList
}

function Get-PackageListSplit([Array]$packageList)
{
  $newPackages = $packageList.Where({ $_.Hide -ne "true" -and $_.New -eq "true" })
  $otherPackages = $packageList.Where({ !($_.Hide -ne "true" -and $_.New -eq "true") })

  return ($newPackages, $otherPackages)
}

function Get-PackageListForLanguageSplit([string]$lang)
{
  return Get-PackageListSplit (Get-PackageListForLanguage $lang)
}

function Set-PackageListForLanguage([string]$lang, [Array]$packageList) 
{
  $packagelistFile = Get-LangCsvFilePath $lang
  Write-Host "Writing $packagelistFile"

  $new, $other = Get-PackageListSplit $packageList

  $new = $new | Sort-Object Type, DisplayName, Package, GroupId, ServiceName
  $other = $other | Sort-Object Type, DisplayName, Package, GroupId, ServiceName

  $sortedPackages = $new + $other
  $sortedPackages | ConvertTo-CSV -NoTypeInformation -UseQuotes Always | Out-File $packagelistFile -encoding ascii
}