# GitHub Copilot Instructions for Azure SDK Repository

## Package Index Update Pull Requests

**Do not comment on routine package index updates.** Automated version, date,
link, and row-order updates in `_data/releases/` do not need review commentary.

The sole exception is the package-naming review pilot: on new rows or changed
`ServiceName`/`DisplayName` fields in `_data/releases/latest/*-packages.csv`,
follow [release CSV naming instructions](instructions/release-csv-names.instructions.md).
Suggest supported friendly-name corrections or ask the owner to confirm
unknown names. Do not flag pre-existing names on version-only updates.

Copilot is advisory. Human reviewers verify and apply accepted names. Never
auto-apply suggestions, approve or merge package-index PRs, or update their
Azure DevOps work items as part of a review.
