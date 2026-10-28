import { describe, expect, it } from "vitest";

import {
  extractLabeledUrl,
  extractLabeledValue,
  getBoldSubsection,
  getLanguageSection,
  getSelectedLanguages,
  hasCheckedConfirmation,
} from "../../src/arch-board-review/issue-parsing.js";

describe("issue-parsing", () => {
  it("detects checked language checkboxes and ignores unchecked ones", () => {
    const issueBody = `
- [x] Java
- [ ] Python
- [X] TypeScript
`;

    expect(getSelectedLanguages(issueBody).map((language) => language.id)).toEqual([
      "java",
      "typescript",
    ]);
  });

  it("detects languages selected via a multi-select dropdown (comma-separated values)", () => {
    const issueBody = `
### Languages for this Review

Java, Python, C++

---
## Artifacts Required (per language)

For each selected language above, fill in the links below.

### .NET
Leave blank if .NET is not selected above.
`;

    expect(getSelectedLanguages(issueBody).map((language) => language.id)).toEqual([
      "java",
      "python",
      "cpp",
    ]);
  });

  it("extracts a language section until the next heading", () => {
    const issueBody = `
### Java
- APIView: https://apiview.dev/Assemblies/Review/123
- PR: https://github.com/Azure/azure-sdk-for-java/pull/1

### Python
- APIView: https://apiview.dev/Assemblies/Review/456
`;

    expect(getLanguageSection(issueBody, "Java")).toContain(
      "https://github.com/Azure/azure-sdk-for-java/pull/1",
    );
    expect(getLanguageSection(issueBody, "Java")).not.toContain("### Python");
  });

  it("extracts labeled values and urls from a section", () => {
    const section = `
- APIView: https://apiview.dev/Assemblies/Review/123
- Samples: Uploaded in APIView
`;

    expect(extractLabeledUrl(section, "APIView")).toBe("https://apiview.dev/Assemblies/Review/123");
    expect(extractLabeledValue(section, "Samples")).toBe("Uploaded in APIView");
  });

  it("extracts separate language blocks from a shared additional-languages section", () => {
    const section = `
**C++**
- PR: https://github.com/Azure/azure-sdk-for-cpp/pull/1

**Rust**
- PR: https://github.com/Azure/azure-sdk-for-rust/pull/2
`;

    expect(getBoldSubsection(section, "C++")).toContain("azure-sdk-for-cpp/pull/1");
    expect(getBoldSubsection(section, "C++")).not.toContain("azure-sdk-for-rust");
    expect(getBoldSubsection(section, "Rust")).toContain("azure-sdk-for-rust/pull/2");
  });

  it("detects checked confirmation checkboxes", () => {
    const issueBody = `
- [x] For existing packages, a diff revision is selected in APIView for each language. For brand-new packages, the initial API surface is submitted.
- [ ] CI checks are passing on all linked PRs
`;

    expect(
      hasCheckedConfirmation(
        issueBody,
        "For existing packages, a diff revision is selected in APIView for each language. For brand-new packages, the initial API surface is submitted.",
      ),
    ).toBe(true);
    expect(hasCheckedConfirmation(issueBody, "CI checks are passing on all linked PRs")).toBe(
      false,
    );
  });
});
