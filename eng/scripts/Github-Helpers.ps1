# These features use a GitHub API that only works under specific conditions. All of the following conditions must be true for this action to succeed.

# The target repository must have Allow auto-merge enabled in settings.
# The pull request base must have a branch protection rule with at least one requirement enabled.
# The pull request must be in a state where requirements have not yet been satisfied. If the pull request can already be merged, attempting to enable auto-merge will fail.

function EnableAutoMergeForPullRequest([int]$pullRequestNumber, [string]$name="azure-sdk", [string]$owner="Azure")
{
  # query MyQuery($number: Int = "", $owner: String = "", $name: String = "") {
  #   repository(name: $name, owner: $owner) { pullRequest(number: $number) { id } }
  # }
  $projectQuery = 'query($name: String!, $owner: String!, $pullRequestNumber: Int!) { repository(name: $name, owner: $owner) { pullRequest(number: $pullRequestNumber) { id } } }'
  $selectQuery = ".data.repository.pullRequest.id"
  $pullRequestId = gh api graphql -f query=$projectQuery -F name=$name -F owner=$owner -F pullRequestNumber=$pullRequestNumber --jq $selectQuery
  if (!$LASTEXITCODE) {
    EnableAutoMergeForPullRequestId $pullRequestId
  }
  else {
    Write-Error "$pullRequestId`nLASTEXITCODE = $LASTEXITCODE"
  }
}

function EnableAutoMergeForPullRequestId([string]$pullRequestId)
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
      Write-Verbose "Unable to enable automerge. Make sure you have enabled branch protection with at least one status check marked as required."
      $LASTEXITCODE = 0
    }
  }
  if ($LASTEXITCODE) {
    Write-Error "$response`nLASTEXITCODE = $LASTEXITCODE"
  }
}

function DisablePullRequestAutoMerge([string]$pullRequestId)
{
  $response = gh api graphql -F pullRequestId=$pullRequestId -f query='
    mutation($pullRequestId: ID!) {
      disablePullRequestAutoMerge(input: {pullRequestId: $pullRequestId}) {
        clientMutationId
      }
    }'
  if ($LASTEXITCODE) {
    Write-Error "$response`nLASTEXITCODE = $LASTEXITCODE"
  }
}