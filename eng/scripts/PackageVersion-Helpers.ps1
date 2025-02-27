. (Join-Path $PSScriptRoot .. common scripts SemVer.ps1)

function GetLatestTags($repo, [DateTimeOffset]$afterDate = [DateTimeOffset]::UtcNow.AddMonths(-1))
{
  $GithubHeaders = @{}
  if (!$github_pat) {
    Write-Error "github_pat was not set so retrieving tag information might be rate-limited"
    return $null
  }
  else {
    $GithubHeaders = @{
      Authorization = "bearer ${github_pat}"
    }
  }

  # https://docs.github.com/en/graphql/overview/explorer is a good tool for debugging these graph queries
  $query = @'
{
  repository(owner: "Azure", name: "<repo_name>") {
    refs(refPrefix: "refs/tags/", after: "<after_tag>", first: 100, orderBy: {field: TAG_COMMIT_DATE, direction: DESC}) {
      nodes {
        target {
          ... on Commit {
            committedDate
          }
          ... on Tag {
            target {
              ... on Commit {
                committedDate
              }
            }
          }
        }
        name
      }
      pageInfo {
        hasNextPage
        endCursor
      }
    }
  }
}
'@.Replace('"', '\"').Replace("`n", "\n") #Need to escape quotes and newlines only in the query value

  $queryBodyWithoutAfter = @'
{
  "query": "<query>"
}
'@.Replace("<query>", $query).Replace("<repo_name>", $repo)

  $queryBody = $queryBodyWithoutAfter.Replace("<after_tag>", "")

  try
  {
    $tags = @()
    do {
      $done = $true
      Write-Verbose "Checking for tags in $repo with date $afterDate"
      $response = (Invoke-RestMethod -Method "POST" -Uri "https://api.github.com/graphql" -Headers $GithubHeaders -Body $queryBody)

      if ($response.psobject.members.name -contains "errors" -and $response.errors.message) {
        Write-Error $response.errors.message
        return $null
      }

      if ($response.data.repository.refs.pageInfo.hasNextPage)
      {
        $queryBody = $queryBodyWithoutAfter.Replace("<after_tag>", $response.data.repository.refs.pageInfo.endCursor)
        $done = $false
      }

      foreach ($tagNode in $response.data.repository.refs.nodes)
      {
        $annotatedTag = $false
        # Capture the dates as datetimeoffset as they are usually utc and we mostly only care about the date part and not the time
        if ($tagNode.target.psobject.members.name -contains "committedDate")
        {
          # For lightweight tags the target is directly a commit
          $tagDate = [DateTimeOffset]$tagNode.target.committedDate
        }
        else {
          # For annotated tags the target is one more level deep from the commit
          $tagDate = [DateTimeOffset]$tagNode.target.target.committedDate
          $annotatedTag = $true
        }

        if ($tagDate -ge $afterDate) {
          Write-Verbose "Found $($tagNode.name) in repo $repo with date ${tagDate}"
          $tags += [PSCustomObject]@{
            Tag = $tagNode.name
            # Remove the time part of this date and note this date is UTC so depending on usage context
            # this can cause an off-by-one day issue if used to compare against local
            Date = $tagDate.ToString("MM/dd/yyy")
          }
        }
        else {
          # Don't break to loop on annotated tags as they can point at really old commits
          if (!$annotatedTag) {
            Write-Verbose "Skipping tag $($tagNode.name) in repo $repo with date ${tagDate} because it is before ${afterDate}"
            $done = $true
            break
          }
        }
      }
    } until ($done)

    return $tags
  }
  catch
  {
    Write-Error $_
    return $null
  }
}

function ToSemVer($version, $tagDate = "Unknown")
{
  $sv = [AzureEngSemanticVersion]::ParseVersionString($version)
  if ($null -ne $sv) {
    $sv | Add-Member -NotePropertyName "Date" -NotePropertyValue $tagDate
  }
  return $sv
}

function Get-DateFromSemVer($semVer)
{
  $d = $semVer.Date -as [DateTime]
  if ($d) {
    return $d.ToString("MM/dd/yyyy")
  }
  return ""
}

function GetPackageVersions($lang, [DateTimeOffset]$afterDate = [DateTimeOffset]::UtcNow.AddMonths(-1), $tagSplit = "_")
{
  $repoName = "azure-sdk-for-$lang"
  if ($lang -eq "dotnet") { $repoName = "azure-sdk-for-net" }
  if ($lang -eq "go") { $tagSplit = "/v" }
  if ($lang -eq "rust") { $tagSplit = "@" }
  if ($lang -eq "c") { $tagSplit = $null }

  $tags = GetLatestTags $repoName $afterDate
  $packageVersions = @{}

  foreach ($tag in $tags)
  {
    $tagName = $tag.Tag

    if ($tagSplit)
    {
      $splitIndex = $tagName.LastIndexOf($tagSplit)

      if ($splitIndex -lt 0) {
        Write-Verbose "Failed to file '$tagSplit' in tag in language '$lang' for tag '$tagName'."
        continue
      }

      $package = $tagName.Substring(0, $splitIndex)
      $version = $tagName.Substring($splitIndex + $tagSplit.Length)
    }
    else
    {
      $package = ""
      $version = $tagName
    }

    # Temporary hack to avoid seeing the track 2 mgmt version 30.0.0 packages
    # we plan to clean-up and deprecate those version at which point this
    # hack can be removed.
    if ($lang -eq "js" -and $version.StartsWith("30.0.0-beta")) {
      continue
    }

    if (!$packageVersions.ContainsKey($package)) {
      $packageVersions.Add($package, [PSCustomObject]@{
        Package = $package
        Versions = @()
      });
    }

    $sv = ToSemVer $version $tag.Date
    if ($sv) {
      $packageVersions[$package].Versions += $sv
    }
    else {
      Write-Verbose "Failed to parse version number '$version' for package '$package' in language '$lang' with tag '$tagName'."
    }
  }
  return $packageVersions
}
