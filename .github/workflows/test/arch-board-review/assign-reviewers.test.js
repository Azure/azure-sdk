import { describe, expect, it, vi } from "vitest";

import assignReviewers, {
  pickReviewer,
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

describe("pickReviewer", () => {
  it("returns null for an empty candidate list", () => {
    expect(pickReviewer([], 5)).toBeNull();
    expect(pickReviewer(undefined, 5)).toBeNull();
  });

  it("distributes deterministically by issue number", () => {
    const candidates = ["a", "b"];
    expect(pickReviewer(candidates, 4)).toBe("a");
    expect(pickReviewer(candidates, 5)).toBe("b");
  });
});

describe("resolveAssignments", () => {
  it("resolves one reviewer per selected language", () => {
    const issueBody = "- [x] Java\n- [x] Python";
    const { byLanguage, assignees } = resolveAssignments({
      issueBody,
      issueNumber: 456,
      approversConfig,
    });
    expect(byLanguage).toEqual([
      { language: "Java", reviewer: "java-user-1" },
      { language: "Python", reviewer: "python-user-1" },
    ]);
    expect(assignees).toEqual(["java-user-1", "python-user-1"]);
  });

  it("includes management-plane approvers in the pool for management-plane issues", () => {
    // Java pool is [java-user-1, java-user-2, mgmt-user-1, mgmt-user-2]; index 2 lands on a
    // management approver, proving plane-aware selection (would be java-user-1 without it).
    const issueBody = "This is a management plane library.\n- [x] Java";
    const { byLanguage } = resolveAssignments({
      issueBody,
      issueNumber: 2,
      approversConfig,
    });
    expect(byLanguage).toEqual([{ language: "Java", reviewer: "mgmt-user-1" }]);
  });

  it("reports selected languages with no configured architect as unassigned", () => {
    const { byLanguage, assignees, unassigned } = resolveAssignments({
      issueBody: "- [x] C++",
      issueNumber: 1,
      approversConfig,
    });
    expect(byLanguage).toEqual([]);
    expect(assignees).toEqual([]);
    expect(unassigned).toEqual(["C++"]);
  });

  it("returns nothing when no languages are selected", () => {
    const { byLanguage, assignees, unassigned } = resolveAssignments({
      issueBody: "no languages here",
      issueNumber: 1,
      approversConfig,
    });
    expect(byLanguage).toEqual([]);
    expect(assignees).toEqual([]);
    expect(unassigned).toEqual([]);
  });
});

describe("assignReviewers", () => {
  const core = { info: vi.fn(), warning: vi.fn() };

  it("assigns resolved reviewers and returns the per-language mapping", async () => {
    const github = createGithubMock();
    const context = createContext({ issueBody: "- [x] Java" });

    const result = await assignReviewers({ github, context, core, approversConfig });

    expect(result.assigned).toEqual(["java-user-1"]);
    expect(result.byLanguage).toEqual([{ language: "Java", reviewer: "java-user-1" }]);
    expect(github.rest.issues.addAssignees).toHaveBeenCalledWith(
      expect.objectContaining({ assignees: ["java-user-1"] }),
    );
  });

  it("does not post a comment (comment is owned by triage)", async () => {
    const github = createGithubMock();
    const context = createContext({ issueBody: "- [x] Java" });

    await assignReviewers({ github, context, core, approversConfig });

    expect(github.rest.issues.createComment).toBeUndefined();
  });

  it("is idempotent when the reviewer is already assigned (case-insensitive)", async () => {
    const github = createGithubMock();
    const context = createContext({
      issueBody: "- [x] Java",
      assignees: ["JAVA-USER-1"],
    });

    const result = await assignReviewers({ github, context, core, approversConfig });

    expect(result.skipped).toBe(true);
    expect(github.rest.issues.addAssignees).not.toHaveBeenCalled();
  });

  it("surfaces unassigned languages without assigning", async () => {
    const github = createGithubMock();
    const context = createContext({ issueBody: "- [x] C++" });

    const result = await assignReviewers({ github, context, core, approversConfig });

    expect(result.unassigned).toEqual(["C++"]);
    expect(result.skipped).toBe(true);
    expect(github.rest.issues.addAssignees).not.toHaveBeenCalled();
  });
});
