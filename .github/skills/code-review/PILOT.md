# Release CSV Naming Review Pilot

This pilot lives in Azure/azure-sdk, where package-index CSV PRs are opened.
The deployed `.github/instructions/release-csv-names.instructions.md` is the
canonical policy. The repo-local `code-review` skill loads it; there is no
second naming policy or dependency on an azure-sdk-tools PR. The existing
azsdk-cli review skill in azure-sdk-tools is unaffected.

## Naming flow and human review

Package discovery no longer guesses friendly names from package identifiers.
New `ServiceName` and `DisplayName` values are `unknown`, matching the existing
package CI parent. The existing `Needs Review` note is retained; no new state
or word-splitting dictionary is introduced. Discovery preserves existing CSV
names while updating versions and package classification.

Copilot reviews new rows and changed name fields, suggesting evidence-backed
spacing and acronym/product casing or asking the owner to confirm an unresolved
name. Feedback is non-blocking. Human reviewers verify and apply accepted
names; Copilot does not approve, merge, apply edits, or mutate work items.
Routine version/date/link updates and row reordering need no naming feedback.

DevOps synchronization happens before the CSV PR is reviewed. Unresolved names
must therefore reuse the existing `unknown` parent during that interval. If a
package work item already has known names, synchronization preserves them
using the existing fallback, now recognizing lowercase and legacy placeholders.
Subsequent runs consume accepted CSV names and reuse matching Service/Product
Epics. Pre-existing incorrect or duplicate Epics need a separate audit.

## Rollout

The repository already has an automatic Copilot review rule. Verify that custom
instructions are enabled and attributed on an actual generated CSV PR. No new
review-request workflow or repository-permission changes are included.

Keep existing human/code-owner approvals. Confirm that the automation identity
used for auto-merge cannot bypass them. The existing rule does not review every
push: manually request another review when new naming changes are added after
the first review. Do not treat Copilot feedback as approval or a merge gate.

Maintain a record of useful suggestions, incorrect suggestions, missed names,
and scope errors in the pilot issue. Classify comments with thumbs-up/down
reactions; log a missed case with the PR and changed row. Copilot does not
process replies to its review comments as new instructions.

## Validation

From the repository root, use Node.js 22.12+ and the pinned Vally installation:

```powershell
npm ci --ignore-scripts --prefix eng/common/scripts/eval
$vally = './eng/common/scripts/eval/node_modules/.bin/vally'
& $vally lint .github/skills/code-review --strict
& $vally lint -e .github/skills/code-review/evals/package-names.eval.yaml --strict
node --test .github/skills/code-review/evals/grader-guards.test.mjs
& $vally eval -e .github/skills/code-review/evals/package-names.eval.yaml --workers 3 --junit --output-dir .github/skills/code-review/results
Import-Module Pester -MinimumVersion 5.7.1
Invoke-Pester -Path ./eng/scripts/tests/Package-Names.Tests.ps1 -Output Detailed
```

Use `vally.cmd` on Windows if needed. Model evaluations require a locally
configured Copilot-enabled credential; never commit it or expose it to PR
code. Optional dependency install scripts are disabled because these checks
do not need native database bindings. CI runs only static skill/eval validation, deterministic grader checks,
and offline Pester tests. Model evaluations remain a maintainer-run pilot
check; do not assume the synced tools-repository eval pipeline is configured
for this repository.

The naming suite preserves all 12 CSV scenarios, including one-field unknown
changes, advisory-only evidence-backed suggestions, ambiguous names, branding,
scope exclusions, and untrusted PR instructions. Three routing-only cases
mount and require real competing SDK skills. Fixture file copies use the
current checkout's instruction and root policy, so edits are evaluated in
the same PR without a remote snapshot. Shell/network/write tools are rejected
by the naming graders; no production service is connected.

The 52 Pester cases mock registry, GitHub, Python commands, and DevOps IO. They
cover language discovery, version and name preservation, unknown-parent reuse,
legacy placeholders, and repeated synchronization after human CSV corrections.
