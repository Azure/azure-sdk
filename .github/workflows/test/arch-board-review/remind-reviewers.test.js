import { describe, expect, it, vi } from "vitest";

import remindReviewers, {
  buildNeedsInfoReminderComment,
  buildReminderComment,
  getContactLogins,
  getMissingReviews,
  isStale,
} from "../../src/arch-board-review/remind-reviewers.js";

const approversConfig = {
  "data-plane": {
    dotnet: ["dotnet-architect"],
    python: ["python-architect"],
  },
  "management-plane": {
    all: [],
  },
};

function createIssue({
  number = 123,
  updatedAt = "2026-10-01T00:00:00Z",
  labels = ["board-review", "ready-for-review"],
  body = `
### Languages for this Review

.NET, Python

### .NET

- PR: https://github.com/Azure/azure-sdk-for-net/pull/100

### Python

- PR: https://github.com/Azure/azure-sdk-for-python/pull/200
`,
} = {}) {
  return {
    number,
    updated_at: updatedAt,
    labels: labels.map((name) => ({ name })),
    body,
    user: { login: "issue-author" },
  };
}

function createGithubMock(issues = []) {
  const listForRepo = vi.fn();
  return {
    paginate: vi.fn().mockResolvedValue(issues),
    rest: {
      issues: {
        listForRepo,
        createComment: vi.fn().mockResolvedValue({}),
      },
    },
  };
}

describe("review reminder helpers", () => {
  it("recognizes issues that have had no activity for the configured period", () => {
    expect(isStale(createIssue(), new Date("2026-10-08T00:00:00Z"), 7)).toBe(true);
    expect(isStale(createIssue(), new Date("2026-10-07T23:59:59Z"), 7)).toBe(false);
  });

  it("returns only languages with missing approval labels", () => {
    const issue = createIssue({
      labels: ["board-review", "ready-for-review", "dotnet-api-approved"],
    });

    expect(getMissingReviews(issue, approversConfig)).toEqual([
      {
        language: { label: "Python", id: "python", tier: "tier1" },
        reviewers: ["python-architect"],
        pullRequestUrl: "https://github.com/Azure/azure-sdk-for-python/pull/200",
      },
    ]);
  });

  it("uses main contacts and falls back to the issue author", () => {
    const issue = createIssue({
      body: `
### Main Contacts

@service-owner, @sdk-owner
`,
    });

    expect(getContactLogins(issue)).toEqual(["service-owner", "sdk-owner"]);
    expect(
      getContactLogins(
        createIssue({
          body: `
### Main Contacts

service-owner, sdk-owner
`,
        }),
      ),
    ).toEqual(["service-owner", "sdk-owner"]);
    expect(
      getContactLogins(
        createIssue({
          body: `
### Main Contacts

@service-owner, sdk-owner
`,
        }),
      ),
    ).toEqual(["service-owner", "sdk-owner"]);
    expect(
      getContactLogins(
        createIssue({
          body: `
### Main Contacts

@service_owner
`,
        }),
      ),
    ).toEqual(["issue-author"]);
    expect(getContactLogins(createIssue())).toEqual(["issue-author"]);
  });

  it("keeps separate PR links for C++ and Rust in the shared artifacts section", () => {
    const issue = createIssue({
      body: `
### Languages for this Review

C++, Rust

### Additional Languages (C++, Rust)

**C++**
- PR: https://github.com/Azure/azure-sdk-for-cpp/pull/100

**Rust**
- PR: https://github.com/Azure/azure-sdk-for-rust/pull/200
`,
    });

    expect(getMissingReviews(issue, approversConfig)).toEqual([
      {
        language: { label: "C++", id: "cpp", tier: "tier2" },
        reviewers: [],
        pullRequestUrl: "https://github.com/Azure/azure-sdk-for-cpp/pull/100",
      },
      {
        language: { label: "Rust", id: "rust", tier: "tier2" },
        reviewers: [],
        pullRequestUrl: "https://github.com/Azure/azure-sdk-for-rust/pull/200",
      },
    ]);
  });

  it("builds an explicit needs-info reminder", () => {
    expect(buildNeedsInfoReminderComment(["service-owner"], 7)).toContain(
      "@service-owner, this request",
    );
  });

  it("uses neutral wording for incomplete or stale approval state", () => {
    const body = buildReminderComment(
      [
        {
          language: { label: ".NET", id: "dotnet" },
          reviewers: ["dotnet-architect"],
          pullRequestUrl: "https://github.com/Azure/azure-sdk-for-net/pull/100",
        },
      ],
      7,
    );

    expect(body).toContain("@dotnet-architect");
    expect(body).toContain("linked PR");
    expect(body).toContain("if the API was already approved");
  });
});

describe("remindReviewers", () => {
  const context = { repo: { owner: "Azure", repo: "azure-sdk" } };
  const core = { info: vi.fn(), warning: vi.fn() };
  const now = new Date("2026-10-10T00:00:00Z");

  it("does not call pull request APIs or comment on active issues", async () => {
    const github = createGithubMock([createIssue({ updatedAt: "2026-10-09T00:00:00Z" })]);

    const result = await remindReviewers({
      github,
      context,
      core,
      now,
      approversConfig,
    });

    expect(result).toEqual({ checked: 1, reminded: 0 });
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it("mentions only architects for languages still missing approval", async () => {
    const github = createGithubMock([
      createIssue({ labels: ["board-review", "ready-for-review", "dotnet-api-approved"] }),
    ]);
    const result = await remindReviewers({
      github,
      context,
      core,
      now,
      approversConfig,
    });

    expect(result).toEqual({ checked: 1, reminded: 1 });
    expect(github.rest.issues.createComment).toHaveBeenCalledWith(
      expect.objectContaining({
        issue_number: 123,
        body: expect.stringContaining("@python-architect"),
      }),
    );
    expect(github.rest.issues.createComment.mock.calls[0][0].body).not.toContain(
      "@dotnet-architect",
    );
  });

  it("mentions service contacts for needs-info without reading linked PRs", async () => {
    const github = createGithubMock([
      createIssue({
        labels: ["board-review", "needs-info"],
        body: `
### Main Contacts

@service-owner
`,
      }),
    ]);
    const result = await remindReviewers({
      github,
      context,
      core,
      now,
      approversConfig,
    });

    expect(result).toEqual({ checked: 1, reminded: 1 });
    expect(github.rest.issues.createComment).toHaveBeenCalledWith(
      expect.objectContaining({
        body: expect.stringContaining("@service-owner"),
      }),
    );
  });

  it("skips issues that already have every required approval", async () => {
    const github = createGithubMock([
      createIssue({
        labels: ["board-review", "ready-for-review", "dotnet-api-approved", "python-api-approved"],
      }),
    ]);
    const result = await remindReviewers({
      github,
      context,
      core,
      now,
      approversConfig,
    });

    expect(result).toEqual({ checked: 1, reminded: 0 });
    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
  });
});
