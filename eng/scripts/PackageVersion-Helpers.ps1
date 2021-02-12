. (Join-Path $PSScriptRoot .. common scripts SemVer.ps1)

function GetCommitterDate($shaUrl)
{
  if (!$github_pat) {
    throw "github_pat was not set so we cannot retrieve git tag information"
  }
  $GithubHeaders = @{
    Authorization = "bearer ${github_pat}"
  }

  try
  {
    if (!$shaUrl -or $shaUrl -eq "Unknown") { return $null }
    $ProgressPreference = "SilentlyContinue"; # Disable invoke-webrequest progress dialog
    $response = Invoke-WebRequest $shaUrl -headers $GithubHeaders
    $content = $response.Content | ConvertFrom-Json -AsHashTable

    # lightweight tags just point to a commit
    if ($content["committer"] -and $content["committer"].date) {
      return [System.DateTimeOffset]$content["committer"].date
    }
    # annotated tags point to tag
    if ($content["tagger"] -and $content["tagger"].date) {
      return [System.DateTimeOffset]$content["tagger"].date
    }
    return $null
  }
  catch
  {
    Write-Host "Failed to get date information for $shaUrl"
    Write-Host $_
    return $null
  }
}
function GetExistingTags($apiUrl)
{
  if (!$github_pat) {
    throw "github_pat was not set so we cannot retrieve git tag information"
  }
  $GithubHeaders = @{
    Authorization = "bearer ${github_pat}"
  }

  try
  {
    return (Invoke-RestMethod -Method "GET" -Uri "$apiUrl/git/refs/tags" -headers $GithubHeaders) 
  }
  catch
  {
    Write-Host $_
    return $null
  }
}

function ToSemVer($version, $tagUrl = "Unknown")
{
  $sv = [AzureEngSemanticVersion]::ParseVersionString($version)
  if ($null -ne $sv) {
    $sv | Add-Member -NotePropertyName "TagShaUrl" -NotePropertyValue $tagUrl
  }
  return $sv
}

function GetPackageVersions($lang, $tagSplit = "_")
{
  $apiUrl = "https://api.github.com/repos/azure/azure-sdk-for-$lang"
  if ($lang -eq "dotnet") { $apiUrl = "https://api.github.com/repos/azure/azure-sdk-for-net" }
  if ($lang -eq "go") { $tagSplit = "/v" }
  if ($lang -eq "c") { $tagSplit = $null }
  if ($lang -eq "ios") { $tagSplit = $null }

  $tags = GetExistingTags $apiUrl
  $packageVersions = @{}

  foreach ($tag in $tags)
  {
    $tagName = $tag.ref.Replace("refs/tags/", "")

    if ($tagSplit)
    {
      $sp = $tagName -split $tagSplit
      if ($sp.Length -ne 2) {
        continue
      }

      $package = $sp[0]
      $version = $sp[1]
    }
    else 
    {
      $package = ""
      $version = $tagName
    }

    if (!$packageVersions.ContainsKey($package)) {
      $packageVersions.Add($package, [PSCustomObject]@{
        LatestGA = ""
        LatestPreview = ""
        Versions = @()
      });
    }

    $sv = ToSemVer $version $tag.object.url
    if ($null -ne $sv) {
      $packageVersions[$package].Versions += $sv
    }
    else {
      Write-Verbose "Failed to parse version number '$version' for package '$package' in language '$lang' with tag '$tag'."
    }
  }

  foreach ($package in $packageVersions.Keys)
  {
    $pkgVersion = $packageVersions[$package]
    if ($pkgVersion.Versions.Count -eq 0) {
      Write-Host "Found no versions for package [$package] for language [$lang]."
      continue
    }
    $versions = [AzureEngSemanticVersion]::SortVersions($pkgVersion.Versions)

    $pkgVersion.LatestPreview = $versions[0].RawVersion
    $gaVersions = @($versions | Where-Object { !$_.IsPrerelease -and $_.Major -gt 0})
    if ($gaVersions.Count -ne 0)
    {
      $pkgVersion.LatestGA = $gaVersions[0].RawVersion
      if ($pkgVersion.LatestGA -eq $pkgVersion.LatestPreview) {
        $pkgVersion.LatestPreview = ""
      }
    }
    $pkgVersion.Versions = $versions
    Write-Verbose "[$lang - $package] GA: '$($pkgVersion.LatestGA)', Preview: '$($pkgVersion.LatestPreview)', Versions: $versions"
  }
  return $packageVersions
}