import { describe, expect, it, vi } from "vitest";

import triage, { analyzeTriage, COMMENT_IDENTIFIER } from "../../src/arch-board-review/triage.js";

function createIssueBody({
  languages = ["Java"],
  javaSection = `
### Java
- APIView: https://apiview.dev/Assemblies/Review/abc123
- Samples: Uploaded in APIView
- PR: https://github.com/Azure/azure-sdk-for-java/pull/1
- README: https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/readme.md
`,
  confirmations = `
- [x] A diff revision is selected in APIView for each language
- [x] CI checks are passing on all linked PRs
`,
} = {}) {
  const checkboxLines = [".NET", "Java", "Python", "TypeScript", "Go", "C++", "Rust"]
    .map((language) => `- [${languages.includes(language) ? "x" : " "}] ${language}`)
    .join("\n");

  return `
### Languages for this Review
${checkboxLines}

${javaSection}

### Confirmations
${confirmations}
`;
}

function createGithubMock() {
  return {
    paginate: vi.fn().mockResolvedValue([]),
    rest: {
      issues: {
        addLabels: vi.fn().mockResolvedValue({}),
        createComment: vi.fn().mockResolvedValue({ data: { id: 1 } }),
        listComments: {},
        removeLabel: vi.fn().mockResolvedValue({}),
        updateComment: vi.fn().mockResolvedValue({}),
      },
    },
  };
}

function createContext({ issueBody, labels }) {
  return {
    repo: { owner: "Azure", repo: "azure-sdk" },
    payload: {
      issue: {
        number: 456,
        body: issueBody,
        labels: labels.map((name) => ({ name })),
      },
    },
  };
}

describe("triage", () => {
  it("adds needs-info when required artifacts are missing", async () => {
    const github = createGithubMock();
    const issueBody = createIssueBody({
      javaSection: `
### Java
- APIView: https://apiview.dev/Assemblies/Review/abc123
`,
    });
    const context = createContext({ issueBody, labels: ["board-review"] });
    const validateUrl = vi.fn().mockResolvedValue({ valid: true, reason: null });

    const result = await triage({ github, context, validateUrl });

    expect(result.status).toBe("needs-info");
    expect(github.rest.issues.addLabels).toHaveBeenNthCalledWith(
      1,
      expect.objectContaining({ labels: ["Java"] }),
    );
    expect(github.rest.issues.addLabels).toHaveBeenNthCalledWith(
      2,
      expect.objectContaining({ labels: ["needs-info"] }),
    );
    expect(github.rest.issues.createComment).toHaveBeenCalledWith(
      expect.objectContaining({
        body: expect.stringContaining("Some required materials are missing or invalid"),
      }),
    );
  });

  it("applies ready-for-review when all artifacts validate", async () => {
    const github = createGithubMock();
    const context = createContext({
      issueBody: createIssueBody(),
      labels: ["board-review", "needs-info"],
    });
    const validateUrl = vi.fn().mockResolvedValue({ valid: true, reason: null });

    const result = await triage({ github, context, validateUrl });

    expect(result.status).toBe("ready-for-review");
    expect(github.rest.issues.addLabels).toHaveBeenNthCalledWith(
      1,
      expect.objectContaining({ labels: ["Java"] }),
    );
    expect(github.rest.issues.addLabels).toHaveBeenNthCalledWith(
      2,
      expect.objectContaining({ labels: ["ready-for-review"] }),
    );
    expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(
      expect.objectContaining({ name: "needs-info" }),
    );
    expect(github.rest.issues.createComment).toHaveBeenCalledWith(
      expect.objectContaining({
        body: expect.stringContaining("All materials verified"),
      }),
    );
  });

  it("syncs language labels when the selection changes", async () => {
    const analysis = await analyzeTriage(createIssueBody(), ["board-review", "Java", "Python"], {
      validateUrl: vi.fn().mockResolvedValue({ valid: true, reason: null }),
    });

    expect(analysis.labelsToAdd).toEqual([]);
    expect(analysis.labelsToRemove).toEqual(["Python"]);
  });

  it("reports invalid urls through artifact validation", async () => {
    const issueBody = createIssueBody({
      javaSection: `
### Java
- APIView: https://apiview.dev/Assemblies
- Samples: https://evil.example.com/samples
- PR: https://github.com/Azure/azure-sdk-for-java/pull/1
- README: https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/readme.md
`,
    });
    const validateUrl = vi.fn(async (url) => {
      if (url.includes("evil.example.com") || url.endsWith("/Assemblies")) {
        return { valid: false, reason: "invalid" };
      }

      return { valid: true, reason: null };
    });

    const analysis = await analyzeTriage(issueBody, ["board-review"], { validateUrl });

    expect(analysis.missing).toEqual(
      expect.arrayContaining([
        expect.objectContaining({
          language: "Java",
          items: expect.arrayContaining([
            expect.stringContaining("APIView link is invalid"),
            expect.stringContaining("Samples link is invalid"),
          ]),
        }),
      ]),
    );
  });
});
