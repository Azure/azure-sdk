/**
 * Triage — parses and validates architecture board review requests.
 *
 * Triggered by the `arch-board-triage.yml` workflow when a board-review issue
 * is opened or edited. Detects selected languages from checkboxes, validates
 * required artifacts (APIView link, samples, PR, README) per language, syncs
 * language labels, and posts/updates a bot comment with validation results.
 *
 * Issues with all artifacts present get `ready-for-review`; incomplete ones
 * get `needs-info`.
 */
import {
  extractLabeledUrl,
  extractLabeledValue,
  getLanguageSection,
  getSelectedLanguages,
  hasCheckedConfirmation,
  LANGUAGE_DEFINITIONS,
} from "./issue-parsing.js";
import { validateUrl as defaultValidateUrl } from "./url-validation.js";
import defaultAssignReviewers from "./assign-reviewers.js";
import { commentOrUpdate } from "../comment.js";
import { addLabels, ensureLabel, ensureLabelRemoved, removeLabel } from "../labels.js";

const COMMENT_IDENTIFIER = "arch-board-triage-bot";

function createValidationItem(kind, value) {
  return `${kind}: ${value}`;
}

async function analyzeTriage(issueBody, currentLabels, { validateUrl = defaultValidateUrl } = {}) {
  const selectedLanguages = getSelectedLanguages(issueBody);
  const selectedLabelSet = new Set(selectedLanguages.map((language) => language.label));
  const allLanguageLabels = LANGUAGE_DEFINITIONS.map((language) => language.label);
  const labelsToAdd = [...selectedLabelSet].filter((label) => !currentLabels.includes(label));
  const labelsToRemove = allLanguageLabels.filter(
    (label) => currentLabels.includes(label) && !selectedLabelSet.has(label),
  );
  const missing = [];
  const validated = [];
  const warnings = [];

  for (const language of selectedLanguages.filter((candidate) => candidate.tier === "tier1")) {
    const section = getLanguageSection(issueBody, language.label);
    const languageMissing = [];
    const languageValidated = [];

    if (!section || section === "_No response_") {
      languageMissing.push("No artifacts provided");
      missing.push({ language: language.label, items: languageMissing });
      continue;
    }

    const apiviewUrl = extractLabeledUrl(section, "APIView");
    if (!apiviewUrl) {
      languageMissing.push("APIView link not provided");
    } else {
      const result = await validateUrl(apiviewUrl);
      if (!result.valid) {
        languageMissing.push(`APIView link is invalid: ${apiviewUrl}`);
      } else {
        languageValidated.push(createValidationItem("APIView", apiviewUrl));
      }
    }

    const samplesValue = extractLabeledValue(section, "Samples");
    if (!samplesValue) {
      languageMissing.push("Samples not provided");
    } else if (/uploaded\s+in\s+apiview/i.test(samplesValue)) {
      languageValidated.push("Samples: uploaded in APIView");
    } else {
      const sampleUrlMatch = samplesValue.match(/https?:\/\/[^\s)]+/i);
      if (!sampleUrlMatch) {
        languageMissing.push("Samples link not provided");
      } else {
        const result = await validateUrl(sampleUrlMatch[0]);
        if (!result.valid) {
          languageMissing.push(`Samples link is invalid: ${sampleUrlMatch[0]}`);
        } else {
          languageValidated.push(createValidationItem("Samples", sampleUrlMatch[0]));
        }
      }
    }

    const prUrl = extractLabeledUrl(section, "PR");
    if (!prUrl) {
      languageMissing.push("PR link not provided");
    } else {
      const result = await validateUrl(prUrl);
      if (!result.valid) {
        languageMissing.push(`PR link is invalid: ${prUrl}`);
      } else {
        languageValidated.push(createValidationItem("PR", prUrl));
      }
    }

    const readmeUrl = extractLabeledUrl(section, "README");
    if (!readmeUrl) {
      languageMissing.push("README link not provided");
    } else {
      const result = await validateUrl(readmeUrl);
      if (!result.valid) {
        languageMissing.push(`README link is invalid: ${readmeUrl}`);
      } else {
        languageValidated.push(createValidationItem("README", readmeUrl));
      }
    }

    if (languageMissing.length > 0) {
      missing.push({ language: language.label, items: languageMissing });
    }

    if (languageValidated.length > 0) {
      validated.push({ language: language.label, items: languageValidated });
    }
  }

  const tier2Languages = selectedLanguages.filter((language) => language.tier === "tier2");
  if (tier2Languages.length > 0) {
    const section = getLanguageSection(issueBody, "Additional Languages (C++, Rust)");
    if (!section || section === "_No response_") {
      missing.push({
        language: tier2Languages.map((language) => language.label).join(", "),
        items: ["No artifacts provided in the Additional Languages section"],
      });
    } else {
      validated.push({
        language: "Additional Languages",
        items: ["Content provided (manual review required for Tier-2 languages)"],
      });
    }
  }

  if (
    !hasCheckedConfirmation(
      issueBody,
      "For existing packages, a diff revision is selected in APIView for each language. For brand-new packages, the initial API surface is submitted.",
    )
  ) {
    missing.push({
      language: "Confirmations",
      items: ["Diff revision confirmation not checked"],
    });
  }

  if (!hasCheckedConfirmation(issueBody, "CI checks are passing on all linked PRs")) {
    warnings.push("CI checks have not been confirmed as passing");
  }

  return {
    labelsToAdd,
    labelsToRemove,
    missing,
    selectedLanguages,
    validated,
    warnings,
  };
}

function buildSuccessComment({ selectedLanguages, validated, warnings, assignments, unassigned }) {
  let body = `✅ **All materials verified for ${selectedLanguages.map((language) => language.label).join(", ")}.**\n\nThis review request is ready for architects. The \`ready-for-review\` label has been applied.\n\n`;
  if (warnings.length > 0) {
    body += `**Note:** ${warnings.join(", ")}\n\n`;
  }

  if (assignments && assignments.length > 0) {
    const assignedLine = assignments
      .map((entry) => `${entry.language} → \`${entry.reviewer}\``)
      .join(" · ");
    body += `**Assigned for review:** ${assignedLine}\n\nAssigned architects are notified via GitHub. Apply your \`<language>-api-approved\` label when the review is complete.\n\n`;
  }

  if (unassigned && unassigned.length > 0) {
    body += `⚠️ **No architect is configured for: ${unassigned.join(", ")}.** These languages need manual assignment - please assign a reviewer.\n\n`;
  }

  body += "<details><summary>Validation details</summary>\n\n";
  for (const entry of validated) {
    body += `**${entry.language}:**\n`;
    for (const item of entry.items) {
      body += `- ✅ ${item}\n`;
    }
    body += "\n";
  }
  body += "</details>";
  return body.trim();
}

function buildFailureComment({ missing, validated }) {
  let body =
    "⚠️ **Some required materials are missing or invalid.** Please update the issue and the automation will re-check.\n\n";
  for (const entry of missing) {
    body += `**${entry.language}:**\n`;
    for (const item of entry.items) {
      body += `- ❌ ${item}\n`;
    }
    body += "\n";
  }

  if (validated.length > 0) {
    body += "<details><summary>Items that passed validation</summary>\n\n";
    for (const entry of validated) {
      body += `**${entry.language}:**\n`;
      for (const item of entry.items) {
        body += `- ✅ ${item}\n`;
      }
      body += "\n";
    }
    body += "</details>";
  }

  return body.trim();
}

export { COMMENT_IDENTIFIER, analyzeTriage, buildFailureComment, buildSuccessComment };

export default async function triage({
  github,
  context,
  core,
  validateUrl = defaultValidateUrl,
  assignReviewers = defaultAssignReviewers,
}) {
  const issue = context.payload.issue;
  const issueBody = issue.body ?? "";
  const issueNumber = issue.number;
  const currentLabels = issue.labels.map((label) => label.name);
  const { owner, repo } = context.repo;
  const result = await analyzeTriage(issueBody, currentLabels, { validateUrl });

  await addLabels(github, owner, repo, issueNumber, result.labelsToAdd);

  for (const label of result.labelsToRemove) {
    await removeLabel(github, owner, repo, issueNumber, label);
  }

  const postComment = (body) =>
    commentOrUpdate(github, core, owner, repo, issueNumber, body, COMMENT_IDENTIFIER);

  if (result.selectedLanguages.length === 0) {
    await ensureLabel(github, owner, repo, issueNumber, "needs-info", currentLabels);
    await ensureLabelRemoved(github, owner, repo, issueNumber, "ready-for-review", currentLabels);

    await postComment(
      '⚠️ **No languages were selected.** Please edit the issue and check at least one language under "Languages for this Review".',
    );

    return { ...result, status: "needs-info" };
  }

  if (result.missing.length === 0) {
    await ensureLabel(github, owner, repo, issueNumber, "ready-for-review", currentLabels);
    await ensureLabelRemoved(github, owner, repo, issueNumber, "needs-info", currentLabels);

    const assignment = await assignReviewers({ github, context, core });

    await postComment(
      buildSuccessComment({
        ...result,
        assignments: assignment?.byLanguage ?? [],
        unassigned: assignment?.unassigned ?? [],
      }),
    );

    core?.info?.("Review request is ready for review.");
    return { ...result, status: "ready-for-review", assignment };
  }

  await ensureLabel(github, owner, repo, issueNumber, "needs-info", currentLabels);
  await ensureLabelRemoved(github, owner, repo, issueNumber, "ready-for-review", currentLabels);

  await postComment(buildFailureComment(result));

  core?.info?.("Review request still needs more information.");
  return { ...result, status: "needs-info" };
}
