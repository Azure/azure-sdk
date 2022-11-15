function Get-GithubProjectId([string] $project)
{
  # project should be ine one of the following formats
  # https://github.com/orgs/<org>/projects/<number>
  # https://github.com/users/<user>/projects/<number>
  # or just a number in which case default to Azure as the org
  $projectId = ""
  if ($project -match "((orgs/(?<org>.*))|(users/(?<user>.*))/projects/)?(?<number>\d+)$")
  {
    $projectNumber = $matches["number"]
    if ($matches["user"]) {
      $name = $matches["user"]
      $projectQuery = 'query($name: String!, $number: Int!) { user(login: $name) { projectNext(number: $number) { id } } }'
      $selectQuery = ".data.user.projectNext.id"
    }
    else {
      $name = $matches["org"]
      $name ??= "Azure"

      $projectQuery = 'query($name: String!, $number: Int!) { organization(login: $name) { projectNext(number: $number) { id } } }'
      $selectQuery = ".data.organization.projectNext.id"
    }

    $projectId = gh api graphql -f query=$projectQuery -F name=$name -F number=$projectNumber --jq $selectQuery
  }
  return $projectId
}

function Add-GithubIssueToProject([string]$projectId, [string]$issueId)
{
  $projectItemId = gh api graphql -F projectId=$projectId -F issueId=$issueId -f query='
    mutation($projectId: ID!, $issueId: ID!) {
      addProjectNextItem(input: {projectId: $projectId, contentId: $issueId}) {
        projectNextItem {
          id
        }
      }
    }' --jq ".data.addProjectNextItem.projectNextItem.id"

  return $projectItemId
}

function Remove-GithubIssueFromProject([string]$projectId, [string]$projectItemId)
{
  $projectDeletedItemId = gh api graphql -F projectId=$projectId -F itemId=$projectItemId -f query='
    mutation($projectId: ID!, $itemId: ID!)  {
      deleteProjectNextItem(input: {projectId: $projectId, itemId: $itemId} ) {
        deletedItemId
      }
  }' --jq ".data.deleteProjectNextItem.deletedItemId"

  return $projectDeletedItemId
}

# These features use a GitHub API that only works under specific conditions. All of the following conditions must be true for this action to succeed.

# The target repository must have Allow auto-merge enabled in settings.
# The pull request base must have a branch protection rule with at least one requirement enabled.
# The pull request must be in a state where requirements have not yet been satisfied. If the pull request can already be merged, attempting to enable auto-merge will fail.

function EnablePullRequestAutoMerge([string]$pullRequestId)
{
  $response = gh api graphql -F pullRequestId=$pullRequestId -f query='
    mutation($pullRequestId: ID!) {
      enablePullRequestAutoMerge(input: {pullRequestId: $pullRequestId, mergeMethod: SQUASH}) {
        clientMutationId
      }
    }'

  if ($LASTEXITCODE) {
    $responseJson = $response | ConvertFrom-Json
    if ($responseJson.errors.message -match "pull request is in (clean|unstable) status") {
      Write-Host "Unable to enable automerge. Make sure you have enabled branch protection with at least one status check marked as required."
      $LASTEXITCODE = 0
    }
  }
  Write-Host "$response`nLASTEXITCODE = $LASTEXITCODE"
  return ($LASTEXITCODE -eq 0)
}

function DisablePullRequestAutoMerge([string]$pullRequestId)
{
  $response = gh api graphql -F pullRequestId=$pullRequestId -f query='
    mutation($pullRequestId: ID!) {
      disablePullRequestAutoMerge(input: {pullRequestId: $pullRequestId}) {
        clientMutationId
      }
    }'
  Write-Host "$response`nLASTEXITCODE = $LASTEXITCODE"
  return ($LASTEXITCODE -eq 0)
}