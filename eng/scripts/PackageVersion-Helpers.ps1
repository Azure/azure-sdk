. (Join-Path $PSScriptRoot .. common scripts SemVer.ps1)

function GetLatestTags($repo, [DateTime]$afterDate = [DateTime]::Now.AddMonths(-1))
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
        if ($tagNode.target.psobject.members.name -contains "committedDate")
        {
          # For lightweight tags the target is directly a commit
          $tagDate = [DateTime]$tagNode.target.committedDate
        }
        else {
          # For annotated tags the target is one more level deep from the commit
          $tagDate = [DateTime]$tagNode.target.target.committedDate
        }

        if ($tagDate -ge $afterDate) {
          Write-Verbose "Found $($tagNode.name) in repo $repo with date ${tagDate}"
          $tags += [PSCustomObject]@{
            Tag = $tagNode.name
            Date = $tagDate
          }
        }
        else {
          Write-Verbose "Skipping tag $($tagNode.name) in repo $repo with date ${tagDate} because it is before ${afterDate}"
          $done = $true
          break
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

function GetPackageVersions($lang, [DateTime]$afterDate = [DateTime]::Now.AddMonths(-1), $tagSplit = "_")
{
  $repoName = "azure-sdk-for-$lang"
  if ($lang -eq "dotnet") { $repoName = "azure-sdk-for-net" }
  if ($lang -eq "go") { $tagSplit = "/v" }
  if ($lang -eq "c") { $tagSplit = $null }

  $tags = GetLatestTags $repoName $afterDate
  $packageVersions = @{}

  foreach ($tag in $tags)
  {
    $tagName = $tag.Tag

    if ($tagSplit)
    {
      $sp = $tagName -split $tagSplit
      if ($sp.Length -ne 2) {
        Write-Verbose "Failed to split tag correctly in language '$lang' with tag '$tagName'."
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