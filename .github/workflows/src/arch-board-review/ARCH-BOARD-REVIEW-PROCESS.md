# Architecture Board Review Process

Automated workflow for API review requests in `Azure/azure-sdk`.

## Flow

```
Service team fills out issue form
        ↓
  arch-board-triage.yml
  (triggers on: opened, edited, reopened)
        ↓
  triage.js parses issue body
        ↓
  ┌─────────────────────────────┐
  │ For each selected language: │
  │ • Validate APIView link     │
  │ • Check samples provided    │
  │ • Validate PR link          │
  │ • Validate README link      │
  │ • Sync language labels      │
  └─────────────────────────────┘
        ↓
  ┌──────────────┐    ┌───────────────────────────┐
  │ All valid?   │───→│ ready-for-review label    │
  │              │ Y  │ + assign one architect    │
  │              │    │   per language (notifies  │
  │              │    │   them via GitHub)        │
  └──────────────┘    └───────────────────────────┘
        │ N
        ↓
  ┌──────────────┐
  │ needs-info   │
  │ label + bot  │
  │ comment      │
  └──────────────┘

Architect applies <language>-api-approved label
        ↓
  approval-close.yml
  (triggers on: labeled)
        ↓
  approval-check.js verifies:
  • Label applied by authorized approver
  • All selected languages approved
        ↓
  Issue auto-closed when complete
```

## Labels

### Applied by automation

| Label                                                       | When applied                      | Meaning                         |
| ----------------------------------------------------------- | --------------------------------- | ------------------------------- |
| `architecture`                                              | On issue creation (from template) | Issue is a board review request |
| `board-review`                                              | On issue creation (from template) | Issue is a board review request |
| `.NET`, `Java`, `Python`, `TypeScript`, `Go`, `C++`, `Rust` | Triage detects selected language  | Language needs review           |
| `ready-for-review`                                          | All required artifacts validated  | Ready for architects            |
| `needs-info`                                                | Missing or invalid artifacts      | Service team needs to fix       |

### Applied by architects (manually)

| Label                     | Who can apply         | Effect                           |
| ------------------------- | --------------------- | -------------------------------- |
| `dotnet-api-approved`     | .NET architects       | Marks .NET review complete       |
| `java-api-approved`       | Java architects       | Marks Java review complete       |
| `python-api-approved`     | Python architects     | Marks Python review complete     |
| `typescript-api-approved` | TypeScript architects | Marks TypeScript review complete |
| `go-api-approved`         | Go architects         | Marks Go review complete         |
| `cpp-api-approved`        | C++ architects        | Marks C++ review complete        |
| `rust-api-approved`       | Rust architects       | Marks Rust review complete       |

For **management plane** issues, management-plane approvers (defined under
`management-plane.all` in `api-review-approvers.yml`) can apply any
language's `<lang>-api-approved` label in addition to the language-specific
architects.

When all selected languages have `<lang>-api-approved`, the issue is auto-closed.

Unauthorized label additions are reverted with a comment.

## Reviewer Assignment

When an issue reaches `ready-for-review`, `assign-reviewers.js` assigns one
architect per selected language, chosen from the same
`api-review-approvers.yml` roster (round-robin, keyed off the issue number).
Assigning the issue triggers GitHub's native notifications, so architects are
reached through their own notification preferences. The assigned handles are
listed in the triage "materials verified" comment for visibility.

For **management plane** issues, the management-plane approvers are included in
the candidate pool alongside the language-specific architects.

Assignment is idempotent: an architect already assigned is not re-assigned, so
subsequent edits to a ready issue do not re-notify.

## Approver Configuration

Approvers are defined in `.github/api-review-approvers.yml`:

```yaml
data-plane:
  dotnet: [user1, user2]
  java: [user3, user4]
  # ...

management-plane:
  all: [user5, user6]
```

Management plane approvers can approve any language on management plane issues.

## Validation Rules

For each Tier-1 language, the bot checks:

1. **APIView link** — must be a valid URL on `apiview.dev`
2. **Samples** — either a URL or "Uploaded in APIView"
3. **PR link** — must be a valid URL on `github.com/Azure/azure-sdk-for-<lang>`
4. **README link** — must be a valid URL
5. **Confirmations** — "diff revision selected" must be checked (required)

URLs are validated against an allowlist: `github.com`, `apiview.dev`, `learn.microsoft.com`, `azure.github.io`.
