import { describe, expect, it, vi } from "vitest";

import assignReviewers, {
  resolveAssignments,
} from "../../src/arch-board-review/assign-reviewers.js";

const approversConfig = {
  "data-plane": {
    java: ["java-user-1", "java-user-2"],
    python: ["python-user-1", "python-user-2"],
  },
  "management-plane": {
    all: ["mgmt-user-1", "mgmt-user-2"],
  },
};

function createGithubMock() {
  return {
    rest: {
      issues: {
        addAssignees: vi.fn().mockResolvedValue({}),
        removeAssignees: vi.fn().mockResolvedValue({}),
        createComment: vi.fn().mockResolvedValue({}),
      },
    },
  };
}

function createContext({ issueBody, number = 456, assignees = [] }) {
  return {
    repo: { owner: "Azure", repo: "azure-sdk" },
    payload: {
      issue: {
        number,
        body: issueBody,
        assignees: assignees.map((login) => ({ login })),
      },
    },
  };
}

describe("resolveAssignments", () => {
  it("assigns every architect for each selected language", () => {
    const issueBody = "- [x] Java\n- [x] Python";
    const { byLanguage, assignees } = resolveAssignments({
      issueBody,
      approversConfig,
    });
    expect(byLanguage).toEqual([
      { language: "Java", reviewers: ["java-user-1", "java-user-2"] },
      { language: "Python", reviewers: ["python-user-1", "python-user-2"] },
    ]);
    expect(assignees).toEqual(["java-user-1", "java-user-2", "python-user-1", "python-user-2"]);
  });

  it("includes management-plane approvers for management-plane issues", () => {
    const issueBody = "This is a management plane library.\n- [x] Java";
    const { byLanguage } = resolveAssignments({
      issueBody,
      approversConfig,
    });
    expect(byLanguage).toEqual([
      {
        language: "Java",
        reviewers: ["java-user-1", "java-user-2", "mgmt-user-1", "mgmt-user-2"],
      },
    ]);
  });

  it("reports selected languages with no configured architect as unassigned", () => {
    const { byLanguage, assignees, unassigned } = resolveAssignments({
      issueBody: "- [x] C++",
      approversConfig,
    });
    expect(byLanguage).toEqual([]);
    expect(assignees).toEqual([]);
    expect(unassigned).toEqual(["C++"]);
  });

  it("returns nothing when no languages are selected", () => {
    const { byLanguage, assignees, unassigned } = resolveAssignments({
      issueBody: "no languages here",
      approversConfig,
    });
    expect(byLanguage).toEqual([]);
    expect(assignees).toEqual([]);
    expect(unassigned).toEqual([]);
  });
});

describe("assignReviewers", () => {
  const core = { info: vi.fn(), warning: vi.fn() };

  it("assigns all resolved reviewers and returns the per-language mapping", async () => {
    const github = createGithubMock();
    const context = createContext({ issueBody: "- [x] Java" });

    const result = await assignReviewers({ github, context, core, approversConfig });

    expect(result.assigned).toEqual(["java-user-1", "java-user-2"]);
    expect(result.byLanguage).toEqual([
      { language: "Java", reviewers: ["java-user-1", "java-user-2"] },
    ]);
    expect(github.rest.issues.addAssignees).toHaveBeenCalledWith(
      expect.objectContaining({ assignees: ["java-user-1", "java-user-2"] }),
    );
  });

  it("does not post a comment (comment is owned by triage)", async () => {
    const github = createGithubMock();
    const context = createContext({ issueBody: "- [x] Java" });

    await assignReviewers({ github, context, core, approversConfig });

    expect(github.rest.issues.createComment).not.toHaveBeenCalled();
  });

  it("is idempotent when all reviewers are already assigned (case-insensitive)", async () => {
    const github = createGithubMock();
    const context = createContext({
      issueBody: "- [x] Java",
      assignees: ["JAVA-USER-1", "JAVA-USER-2"],
    });

    const result = await assignReviewers({ github, context, core, approversConfig });

    expect(result.skipped).toBe(true);
    expect(result.reason).toBe("already-assigned");
    expect(github.rest.issues.addAssignees).not.toHaveBeenCalled();
  });

  it("only adds the reviewers that are not already assigned", async () => {
    const github = createGithubMock();
    const context = createContext({
      issueBody: "- [x] Java",
      assignees: ["java-user-1"],
    });

    const result = await assignReviewers({ github, context, core, approversConfig });

    expect(result.assigned).toEqual(["java-user-2"]);
    expect(github.rest.issues.addAssignees).toHaveBeenCalledWith(
      expect.objectContaining({ assignees: ["java-user-2"] }),
    );
  });

  it("surfaces unassigned languages without assigning", async () => {
    const github = createGithubMock();
    const context = createContext({ issueBody: "- [x] C++" });

    const result = await assignReviewers({ github, context, core, approversConfig });

    expect(result.unassigned).toEqual(["C++"]);
    expect(result.skipped).toBe(true);
    expect(result.reason).toBe("no-reviewers-resolved");
    expect(github.rest.issues.addAssignees).not.toHaveBeenCalled();
  });

  it("removes stale automation-assigned architects when the language selection changes", async () => {
    // Previously assigned the Java architects; issue was edited to Python only.
    const github = createGithubMock();
    const context = createContext({
      issueBody: "- [x] Python",
      assignees: ["java-user-1", "java-user-2"],
    });

    const result = await assignReviewers({ github, context, core, approversConfig });

    expect(result.assigned).toEqual(["python-user-1", "python-user-2"]);
    expect(result.removed).toEqual(["java-user-1", "java-user-2"]);
    expect(github.rest.issues.addAssignees).toHaveBeenCalledWith(
      expect.objectContaining({ assignees: ["python-user-1", "python-user-2"] }),
    );
    expect(github.rest.issues.removeAssignees).toHaveBeenCalledWith(
      expect.objectContaining({ assignees: ["java-user-1", "java-user-2"] }),
    );
  });

  it("preserves manual (unconfigured) assignees during reconciliation", async () => {
    const github = createGithubMock();
    const context = createContext({
      issueBody: "- [x] Python",
      assignees: ["some-manual-user", "java-user-1"],
    });

    const result = await assignReviewers({ github, context, core, approversConfig });

    expect(result.removed).toEqual(["java-user-1"]);
    expect(github.rest.issues.removeAssignees).toHaveBeenCalledWith(
      expect.objectContaining({ assignees: ["java-user-1"] }),
    );
  });
});
