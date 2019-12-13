param (
  $language = "all",
  $releaseFolder = "$PSScriptRoot\..\..\_data\releases\latest"
)

$releaseFolder = Resolve-Path $releaseFolder

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

        # Hack for java we need to ignore preview tags because of sorting issues
        if (!($apiUrl.Contains("-java") -and $version.Contains("-preview"))) {

          ## TODO: Sort based on SemVer and not blindly take the last one
          #if ($pv.Latest -lt $version) {
          $pv.Latest = $version
          #}
        }
      }
    }
  return $packageVersions
}

function CheckLink($url)
{
  try
  {
    #Write-Host "Checking $url"
    $response = Invoke-WebRequest -Uri $url
    return $true
  }
  catch
  {
    Write-Warning "Invalid link $url"
  }
  return $false
}

function Update-java-Packages($packageList, $versions)
{
  foreach ($pkg in $packageList)
  {
    $version = $versions[$pkg.Package].Latest;

    $valid = $true;
    $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-java/tree/{0}_{1}/sdk/{2}/{0}/" -f $pkg.Package, $version, $pkg.RepoPath))
    $valid = $valid -and (CheckLink ("https://search.maven.org/artifact/com.azure/{0}/{1}/jar/" -f $pkg.Package, $version))

    $pkg.MissingDocs = !(CheckLink ("https://azuresdkdocs.blob.core.windows.net/`$web/java/{0}/{1}/index.html" -f $pkg.Package, $version))

    if ($valid)
    {
      if ($pkg.Version -ne $version)
      {
        Write-Host "Updating version $($pkg.Package) from $($pkg.Version) to $version"
        $pkg.Version = $version;
      }
    }
    else
    {
      Write-Warning "Not updating version for $($pkg.Package) because at least one associated URL is not valid!"
    }

  }
}

function Update-js-Packages($packageList, $versions)
{
  foreach ($pkg in $packageList)
  {
    $version = $versions["@azure/$($pkg.Package)"].Latest;

    $valid = $true;
    $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-js/tree/@azure/{0}_{1}/sdk/{2}/{0}/" -f $pkg.Package, $version, $pkg.RepoPath))
    $valid = $valid -and (CheckLink ("https://www.npmjs.com/package/@azure/{0}/v/{1}" -f $pkg.Package, $version))

    $pkg.MissingDocs = !(CheckLink ("https://azuresdkdocs.blob.core.windows.net/`$web/javascript/azure-{0}/{1}/index.html" -f $pkg.Package, $version))

    if ($valid)
    {
      if ($pkg.Version -ne $version)
      {
        Write-Host "Updating version $($pkg.Package) from $($pkg.Version) to $version"
        $pkg.Version = $version;
      }
    }
    else
    {
      Write-Warning "Not updating version for $($pkg.Package) because at least one associated URL is not valid!"
    }
  }
}

function Update-dotnet-Packages($packageList, $tf)
{
  foreach ($pkg in $packageList)
  {
    $version = $versions[$pkg.Package].Latest;

    $valid = $true;
    $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-net/tree/{0}_{1}/sdk/{2}/{0}/" -f $pkg.Package, $version, $pkg.RepoPath))
    $valid = $valid -and (CheckLink ("https://www.nuget.org/packages/{0}/{1}" -f $pkg.Package, $version))

    $pkg.MissingDocs = !(CheckLink ("https://azuresdkdocs.blob.core.windows.net/`$web/dotnet/{0}/{1}/api/index.html" -f $pkg.Package, $version))

    if ($valid)
    {
      if ($pkg.Version -ne $version)
      {
        Write-Host "Updating version $($pkg.Package) from $($pkg.Version) to $version"
        $pkg.Version = $version;
      }
    }
    else
    {
      Write-Warning "Not updating version for $($pkg.Package) because at least one associated URL is not valid!"
    }
  }
}

function Update-python-Packages($packageList, $tf)
{
  foreach ($pkg in $packageList)
  {
    $version = $versions[$pkg.Package].Latest;

    $valid = $true;
    $valid = $valid -and (CheckLink ("https://github.com/Azure/azure-sdk-for-python/tree/{0}_{1}/sdk/{2}/{3}/" -f $pkg.Package, $version, $pkg.RepoPath, $pkg.Package))
    $valid = $valid -and (CheckLink ("https://pypi.org/project/{0}/{1}" -f $pkg.Package, $version))

    $pkg.MissingDocs = !(CheckLink ("https://azuresdkdocs.blob.core.windows.net/`$web/python/{0}/{1}/index.html" -f $pkg.Package, $version))

    if ($valid)
    {
      if ($pkg.Version -ne $version)
      {
        Write-Host "Updating version $($pkg.Package) from $($pkg.Version) to $version"
        $pkg.Version = $version;
      }
    }
    else
    {
      Write-Warning "Not updating version for $($pkg.Package) because at least one associated URL is not valid!"
    }
  }
}

function Output-Latest-Versions($lang)
{
  $packagelistFile = Join-Path $releaseFolder "$lang-packages.csv"
  $packageList = gc $packagelistFile | ConvertFrom-Csv | sort Service


  $apiUrl = "https://api.github.com/repos/azure/azure-sdk-for-$lang"
  if ($lang -eq "dotnet") { $apiUrl = "https://api.github.com/repos/azure/azure-sdk-for-net" }

  $versions = GetPackageVersions $apiUrl

  $LangFunction = "Update-$lang-Packages"
  &$LangFunction $packageList $versions

  Write-Host "Writing $packagelistFile"
  $packageList | ConvertTo-CSV -NoTypeInformation | out-file $packagelistFile -encoding ascii
}

switch($language)
{
  "all" {
    Output-Latest-Versions "java"
    Output-Latest-Versions "js"
    Output-Latest-Versions "dotnet"
    Output-Latest-Versions "python"
    break
  }
  "java" {
    Output-Latest-Versions $language
    break
  }
  "js" {
    Output-Latest-Versions $language
    break
  }
  "dotnet" {
    Output-Latest-Versions $language
    break
  }
  "python" {
    Output-Latest-Versions $language
    break
  }
  default {
    Write-Host "Unrecognized Language: $language"
    exit(1)
  }
}

