# Architecture Board Review Process

Automated workflow for API review requests in `Azure/azure-sdk`.

## Flow

```
Service team fills out issue form
        ↓
  arch-board-triage.yml
  (triggers on: opened, edited)
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
  ┌──────────────┐    ┌──────────────┐
  │ All valid?   │───→│ ready-for-   │
  │              │ Y  │ review label │
  └──────────────┘    └──────────────┘
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
| Label | When applied | Meaning |
|-------|-------------|---------|
| `architecture` | On issue creation (from template) | Issue is a board review request |
| `board-review` | On issue creation (from template) | Issue is a board review request |
| `.NET`, `Java`, `Python`, `TypeScript`, `Go` | Triage detects selected language | Language needs review |
| `ready-for-review` | All required artifacts validated | Ready for architects |
| `needs-info` | Missing or invalid artifacts | Service team needs to fix |

### Applied by architects (manually)
| Label | Who can apply | Effect |
|-------|--------------|--------|
| `dotnet-api-approved` | .NET architects | Marks .NET review complete |
| `java-api-approved` | Java architects | Marks Java review complete |
| `python-api-approved` | Python architects | Marks Python review complete |
| `typescript-api-approved` | TypeScript architects | Marks TypeScript review complete |
| `go-api-approved` | Go architects | Marks Go review complete |
| `cpp-api-approved` | C++ architects | Marks C++ review complete |
| `rust-api-approved` | Rust architects | Marks Rust review complete |

When all selected languages have `<lang>-api-approved`, the issue is auto-closed.

Unauthorized label additions are reverted with a comment.

## Files

| File | Purpose |
|------|---------|
| `ISSUE_TEMPLATE/arch-board-review.yml` | GitHub Issue Form template |
| `workflows/arch-board-triage.yml` | Triage workflow (parse + validate + label) |
| `workflows/approval-close.yml` | Approval workflow (label check + auto-close) |
| `workflows/src/arch-board-review/triage.js` | Triage logic |
| `workflows/src/arch-board-review/approval-check.js` | Approval logic |
| `workflows/src/arch-board-review/issue-parsing.js` | Shared issue body parsing |
| `workflows/src/arch-board-review/url-validation.js` | URL validation with SSRF protection |
| `api-review-approvers.yml` | Authorized approvers per language |

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

## Language Tiers

- **Tier-1** (.NET, Java, Python, TypeScript): Full artifact validation — APIView, Samples, PR, README
- **Tier-1 for mgmt only** (Go): Same validation as Tier-1
- **Tier-2** (C++, Rust): Free-form text in "Additional Languages" section, manual review

## Validation Rules

For each Tier-1 language, the bot checks:
1. **APIView link** — must be a valid URL on `apiview.dev`
2. **Samples** — either a URL or "Uploaded in APIView"
3. **PR link** — must be a valid URL on `github.com/Azure/azure-sdk-for-<lang>`
4. **README link** — must be a valid URL
5. **Confirmations** — "diff revision selected" must be checked (required)

URLs are validated against an allowlist: `github.com`, `apiview.dev`, `learn.microsoft.com`, `azure.github.io`.
