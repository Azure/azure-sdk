# Sample github action to use this auto-merge label functionality
# name: Handle auto-merge

# on:
#   pull_request_target:
#     types: [labeled, unlabeled]

# jobs:
#   handle_auto_merge_label:
#     name: Check for auto-merge label
#     runs-on: ubuntu-latest

#     steps:
#       - uses: actions/checkout@v3
#       - name: Check for auto-merge
#         run: |
#           ${{ github.workspace }}/eng/scripts/HandleAutoMerge.ps1 `
#            -label "${{ github.event.label.name }}" `
#            -pullRequestId "${{ github.event.pull_request.node_id }}" `
#            -pullRequestNumber "${{ github.event.pull_request.number }}" `
#            -labelAdded:$("${{ github.event.action }}" -eq "labeled") `
#         shell: pwsh
#         env:
#           GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)]
  [string]$label,
  [Parameter(Mandatory = $true)]
  [string]$pullRequestId,
  [string]$pullRequestNumber = $pullRequestId,
  [switch]$labelAdded
)
Set-StrictMode -Version 3

. $PSScriptRoot/Github-Project-Helpers.ps1

Write-Verbose $(gh api -H "Accept: application/vnd.github.v3+json" /rate_limit --jq '.resources')

if ($label -ne "auto-merge") {
  Write-Host "Skipping action because the label name is [$label] which is not [auto-merge]."
  exit 0
}

$succeeded = $true
if ($labelAdded) {
  Write-Host "Enabling auto merge for pull request $pullRequestNumber ($pullRequestId) because [$label] was added."
  $succeeded = EnablePullRequestAutoMerge $pullRequestId
}
else {
  Write-Host "Disabling auto merge for pull request $pullRequestNumber ($pullRequestId) because [$label] was removed."
  $succeeded = DisablePullRequestAutoMerge $pullRequestId
}

Write-Verbose (gh api -H "Accept: application/vnd.github.v3+json" /rate_limit --jq '.resources')

if (!$succeeded) {
  exit 1
}
exit 0
