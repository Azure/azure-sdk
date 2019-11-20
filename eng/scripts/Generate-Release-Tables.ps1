param (
  $language = "all",
  $releaseFolder = "..\..\releases\2019-11",
  [switch]$dumpVersions=$false
)

function GetExistingTags($apiUrl)
{
  try
  {
    return (Invoke-RestMethod -Method "GET" -Uri "$apiUrl/git/refs/tags"  ) | % { $_.ref.Replace("refs/tags/", "") }
  }
  catch
  {
    $statusCode = $_.Exception.Response.StatusCode.value__
    $statusDescription = $_.Exception.Response.StatusDescription

    Write-Host "Failed to retrieve tags from repository."
    Write-Host "StatusCode:" $statusCode
    Write-Host "StatusDescription:" $statusDescription
    exit(1)
  }
}


function GetPackageVersions($apiUrl)
{
  $tags = GetExistingTags $apiUrl
  $packageVersions = @{ }
  $packageTags = $tags | % {
      $sp = $_.Split('_');
      if ($sp.Length -eq 2) {
        $package = $sp[0];
        $version = $sp[1];
        if (!$packageVersions.Contains($package)) {
          $packageVersions.Add($package, $(new-object PSObject -Property @{ Versions = @(); Latest = $version }));
        }
        $pv = $packageVersions[$package];
        $pv.Versions += $version;

        ## TODO: Sort based on SemVer for not take the last one
        #if ($pv.Latest -lt $version) {
        $pv.Latest = $version
        #}
      }
    }
  return $packageVersions
}

function CreateLink($text, $url)
{
  try
  {
    #Write-Host "Checking $url"
    $response = Invoke-WebRequest -Uri $url
    return "[{0}]({1})" -f $text, $url
  }
  catch
  {
    #Write-Warning "Invalid link $url"
    return "N/A"
  }
}

function ProbeLinks($text, $baseUrl)
{
  $link = "N/A"
  $standardLink = ""
  $urls = @()
  $urls += ($args | % { $baseUrl + $_ })
  # If there are no args assume $baseUrl is the only url
  if ($args.Count -eq 0) { $urls += $baseUrl }

  foreach($url in $urls)
  {
    $link = CreateLink $text $url
    if ($link -ne "N/A") { break; }
    if ($standardLink -eq "") { $standardLink = $url }
  }
  if ($standardLink -ne "") {
    if ($link -eq "N/A") {
      Write-Warning "$standardLink not found so marking N/A"
    }
    else {
      Write-Host "$standardLink not found."
      Write-Host "  Instead using alternative $link."
    }
  }

  return $link
}

function ProbeChangeLogLinks($text, $baseUrl)
{
  return ProbeLinks $text $baseUrl "CHANGELOG.md" "ChangeLog.md" "Changelog.md" "changelog.md" "ChangeLog.txt" "Changelog.txt" "changelog.txt"
}

function Write-java-Packages($packageList, $tf)
{
  $table = ""
  foreach ($pkg in $packageList)
  {
    $repoPath = "https://github.com/Azure/azure-sdk-for-java/blob/{0}_{1}/sdk/{2}/{0}/" -f $pkg.Package, $pkg.Version, $pkg.RepoPath
    $packageUrl = ProbeLinks $($pkg.Package + " - " + $pkg.Version) $("https://search.maven.org/artifact/com.azure/{0}/{1}/jar/" -f $pkg.Package, $pkg.Version)
    $docsUrl = ProbeLinks "Api Reference" $("https://azuresdkdocs.blob.core.windows.net/`$web/java/{0}/{1}/index.html" -f $pkg.Package, $pkg.Version)
    $readmeUrl = ProbeLinks "ReadMe" "$repoPath" "README.md"
    $samplesUrl = ProbeLinks "Samples" "$repoPath" "src/samples"
    $changelogUrl = ProbeChangeLogLinks "ChangeLog" "$repoPath"
    $table += ($tf -f $pkg.Service, $packageUrl, $readmeUrl, $samplesUrl, $docsUrl, $changeLogUrl)
  }
  return $table
}

function Write-js-Packages($packageList, $tf)
{
  $table = ""
  foreach ($pkg in $packageList)
  {
    $repoPath = "https://github.com/Azure/azure-sdk-for-js/blob/@azure/{0}_{1}/sdk/{2}/{0}/" -f $pkg.Package, $pkg.Version, $pkg.RepoPath
    $packageUrl = ProbeLinks $($pkg.Package + " - " + $pkg.Version) $("https://www.npmjs.com/package/@azure/{0}/v/{1}" -f $pkg.Package, $pkg.Version)
    $docsUrl = ProbeLinks "Api Reference" $("https://azuresdkdocs.blob.core.windows.net/`$web/javascript/azure-{0}/{1}/index.html" -f $pkg.Package, $pkg.Version)
    $readmeUrl = ProbeLinks "ReadMe" "$repoPath" "README.md"
    $samplesUrl = ProbeLinks "Samples" "$repoPath" "samples"
    $changelogUrl = ProbeChangeLogLinks "ChangeLog" "$repoPath"
    $table += ($tf -f $pkg.Service, $packageUrl, $readmeUrl, $samplesUrl, $docsUrl, $changeLogUrl)
  }
  return $table
}

function Write-net-Packages($packageList, $tf)
{
  $table = ""
  foreach ($pkg in $packageList)
  {
    $repoPath = "https://github.com/Azure/azure-sdk-for-net/blob/{0}_{1}/sdk/{2}/{0}/" -f $pkg.Package, $pkg.Version, $pkg.RepoPath
    $packageUrl = ProbeLinks $($pkg.Package + " - " + $pkg.Version) $("https://www.nuget.org/packages/{0}/{1}" -f $pkg.Package, $pkg.Version)
    $docsUrl = ProbeLinks "Api Reference" $("https://azuresdkdocs.blob.core.windows.net/`$web/dotnet/{0}/{1}/api/index.html" -f $pkg.Package, $pkg.Version)
    $readmeUrl = ProbeLinks "ReadMe" "$repoPath" "README.md"
    $samplesUrl = ProbeLinks "Samples" "$repoPath" "samples"
    $changelogUrl = ProbeChangeLogLinks "ChangeLog" "$repoPath"
    $table += ($tf -f $pkg.Service, $packageUrl, $readmeUrl, $samplesUrl, $docsUrl, $changeLogUrl)

  }
  return $table
}

function Write-python-Packages($packageList, $tf)
{
  $table = ""
  foreach ($pkg in $packageList)
  {
    # Need to have an override for an invalid package path for azure-eventhub package lives in sdk/eventhub/azure-eventhubs path. We should fix that.
    $pkgPath = $pkg.Package
    if ($pkg.PackagePathOverride -ne $nul) { $pkgPath = $pkg.PackagePathOverride}
    $repoPath = "https://github.com/Azure/azure-sdk-for-python/blob/{0}_{1}/sdk/{2}/{3}/" -f $pkg.Package, $pkg.Version, $pkg.RepoPath, $pkgPath
    $packageUrl = ProbeLinks $($pkg.Package + " - " + $pkg.Version) $("https://pypi.org/project/{0}/{1}" -f $pkg.Package, $pkg.Version)
    $docsUrl = ProbeLinks "Api Reference" $("https://azuresdkdocs.blob.core.windows.net/`$web/python/{0}/{1}/index.html" -f $pkg.Package, $pkg.Version)
    $readmeUrl = ProbeLinks "ReadMe" "$repoPath" "README.md"
    $samplesUrl = ProbeLinks "Samples" "$repoPath" "samples"
    $changelogUrl = ProbeLinks "ChangeLog" "$repoPath" "CHANGELOG.md" "HISTORY.md"
    $table += ($tf -f $pkg.Service, $packageUrl, $readmeUrl, $samplesUrl, $docsUrl, $changeLogUrl)
  }
  return $table
}

function Output-quicklinks($lang)
{
  $packageList = gc "$lang-packages.csv" | ConvertFrom-Csv | sort Service

  $table =  "| Service | Package | Readme | Samples | API Reference | Changelog |`r`n"
  $table += "| ------- | ------- | ------ | ------- | ------------- | --------- |`r`n"
  $tf    =  "| {0} | {1} | {2} | {3} | {4} | {5} |`r`n"

  $LangFunction = "Write-$lang-Packages"
  $table += &$LangFunction $packageList $tf

  $outputFile = Join-Path $releaseFolder "$lang-quicklinks.md"
  Write-Host "Writing $outputFile"
  $table | out-file $outputFile -encoding utf8
}

if ($dumpVersions)
{
  $repoId = "azure/azure-sdk-for-$lang"
  $apiUrl = "https://api.github.com/repos/$repoId"
  Write-Host "Using API URL $apiUrl"

  #TODO: Pull the versions live when generating
  $versions = GetPackageVersions $apiUrl
  #$versions.Keys | ?{ $_.StartsWith("Azure") } | Sort | %{ "$_, " + $versions[$_].Latest }
  $versions.Keys | ?{ -not $_.StartsWith("azure-mgmt") } | Sort | %{ "$_, " + $versions[$_].Latest }

  exit
}


switch($language)
{
  "all" {
    Output-quicklinks "java"
    Output-quicklinks "js"
    Output-quicklinks "net"
    Output-quicklinks "python"
    break
  }
  "java" {
    Output-quicklinks $language
    break
  }
  "js" {
    Output-quicklinks $language
    break
  }
  "net" {
    Output-quicklinks $language
    break
  }
  "python" {
    Output-quicklinks $language
    break
  }
  default {
    Write-Host "Unrecognized Language: $language"
    exit(1)
  }
}

