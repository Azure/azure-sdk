/**
 * Issue Parsing — extracts structured data from GitHub Issue Form bodies.
 *
 * Shared utilities for parsing the arch-board-review issue template:
 * - Language checkbox detection (which languages are selected)
 * - Section extraction (per-language artifact blocks)
 * - Labeled value/URL extraction (e.g., "APIView: https://...")
 * - Confirmation checkbox detection (e.g., "A diff revision is selected")
 */
const LANGUAGE_DEFINITIONS = [
  { label: ".NET", id: "dotnet", tier: "tier1" },
  { label: "Java", id: "java", tier: "tier1" },
  { label: "Python", id: "python", tier: "tier1" },
  { label: "TypeScript", id: "typescript", tier: "tier1" },
  { label: "Go", id: "go", tier: "tier1" },
  { label: "C++", id: "cpp", tier: "tier2" },
  { label: "Rust", id: "rust", tier: "tier2" },
];

function escapeRegex(value) {
  return value.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}

function isChecked(body, label) {
  const regex = new RegExp(`-\\s*\\[\\s*[Xx]\\s*\\]\\s*${escapeRegex(label)}\\s*$`, "m");
  return regex.test(body);
}

function getSelectedLanguages(issueBody) {
  return LANGUAGE_DEFINITIONS.filter((language) => isChecked(issueBody, language.label));
}

function getLanguageSection(body, heading) {
  const header = `### ${heading}`;
  const startIndex = body.indexOf(header);
  if (startIndex === -1) {
    return null;
  }

  const afterHeader = body.slice(startIndex + header.length);
  const nextHeaderIndex = afterHeader.indexOf("\n### ");
  return nextHeaderIndex === -1 ? afterHeader.trim() : afterHeader.slice(0, nextHeaderIndex).trim();
}

function extractLabeledValue(sectionText, label) {
  if (!sectionText) {
    return null;
  }

  const match = sectionText.match(new RegExp(`-\\s*${escapeRegex(label)}:\\s*(.+)`, "i"));
  return match ? match[1].trim() : null;
}

function extractLabeledUrl(sectionText, label) {
  const value = extractLabeledValue(sectionText, label);
  if (!value) {
    return null;
  }

  const match = value.match(/https?:\/\/[^\s)]+/i);
  return match ? match[0] : null;
}

function hasCheckedConfirmation(issueBody, label) {
  return isChecked(issueBody, label);
}

export {
  LANGUAGE_DEFINITIONS,
  escapeRegex,
  extractLabeledUrl,
  extractLabeledValue,
  getLanguageSection,
  getSelectedLanguages,
  hasCheckedConfirmation,
  isChecked,
};
