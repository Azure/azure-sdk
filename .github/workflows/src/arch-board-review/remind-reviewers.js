/**
 * Review Reminders — explicitly mentions architects on stale board reviews.
 *
 * The scheduled workflow uses existing issue labels as its source of truth.
 * Reviews are reminded after seven days without issue activity. A new reminder
 * comment resets that inactivity window, which bounds reminders to once a week.
 */
import { readFile } from "node:fs/promises";

import { loadApproversConfig } from "./approval-check.js";
import { resolveAssignments } from "./assign-reviewers.js";
import {
  extractLabeledUrl,
  getBoldSubsection,
  getLanguageSection,
  getSelectedLanguages,
} from "./issue-parsing.js";

const DEFAULT_APPROVERS_PATH = new URL("../../../api-review-approvers.yml", import.meta.url);
const DEFAULT_STALE_DAYS = 7;
const MILLISECONDS_PER_DAY = 24 * 60 * 60 * 1000;

function isStale(issue, now, staleDays) {
  const updatedAt = Date.parse(issue.updated_at);
  return (
    Number.isFinite(updatedAt) && now.getTime() - updatedAt >= staleDays * MILLISECONDS_PER_DAY
  );
}

function getMissingReviews(issue, approversConfig) {
  const issueBody = issue.body ?? "";
  const labels = new Set((issue.labels ?? []).map((label) => label.name));
  const assignments = resolveAssignments({ issueBody, approversConfig });
  const reviewersByLanguage = new Map(
    assignments.byLanguage.map((entry) => [entry.language, entry.reviewers]),
  );

  return getSelectedLanguages(issueBody)
    .filter((language) => !labels.has(`${language.id}-api-approved`))
    .map((language) => {
      const section =
        language.tier === "tier2"
          ? getBoldSubsection(
              getLanguageSection(issueBody, "Additional Languages (C++, Rust)"),
              language.label,
            )
          : getLanguageSection(issueBody, language.label);
      return {
        language,
        reviewers: reviewersByLanguage.get(language.label) ?? [],
        pullRequestUrl: extractLabeledUrl(section, "PR"),
      };
    });
}

function getContactLogins(issue) {
  const contactsSection = getLanguageSection(issue.body ?? "", "Main Contacts")?.trim() ?? "";
  const fallback = issue.user?.login ? [issue.user.login] : [];
  if (!contactsSection || contactsSection === "_No response_") {
    return fallback;
  }

  const candidates = contactsSection
    .split(/[,\n\s]+/)
    .map((candidate) => candidate.replace(/^@/, "").trim())
    .filter(Boolean);
  const contacts = candidates.filter((candidate) =>
    /^[A-Za-z0-9](?:[A-Za-z0-9-]{0,38})$/.test(candidate),
  );
  const uniqueContacts = [...new Set(contacts)];
  return uniqueContacts.length > 0 ? uniqueContacts : fallback;
}

function buildReminderComment(reviews, staleDays) {
  let body = `🔔 **Architecture review reminder**\n\nThis review has had no activity for at least ${staleDays} days and still has missing approval labels.\n\n`;

  for (const review of reviews) {
    const mentions =
      review.reviewers.length > 0
        ? review.reviewers.map((reviewer) => `@${reviewer}`).join(", ")
        : "_No architect configured_";
    const approvalLabel = `${review.language.id}-api-approved`;
    const pullRequestLink = review.pullRequestUrl
      ? ` See the [linked PR](${review.pullRequestUrl}).`
      : "";
    body += `- **${review.language.label}:** ${mentions}.${pullRequestLink} Please complete the review, or apply \`${approvalLabel}\` if the API was already approved.\n`;
  }

  return body.trim();
}

function buildNeedsInfoReminderComment(contactLogins, staleDays) {
  const mentions =
    contactLogins.length > 0
      ? contactLogins.map((login) => `@${login}`).join(", ")
      : "Service team";
  return `🔔 **Architecture review reminder**\n\n${mentions}, this request has had no activity for at least ${staleDays} days and is still marked \`needs-info\`. Please update the issue with the missing materials so the automation can re-check it.`;
}

async function remindReviewers({
  github,
  context,
  core,
  now = new Date(),
  staleDays = DEFAULT_STALE_DAYS,
  approversConfig,
  approversPath = DEFAULT_APPROVERS_PATH,
  readFileImpl = readFile,
}) {
  const { owner, repo } = context.repo;
  const resolvedApproversConfig =
    approversConfig ?? (await loadApproversConfig(approversPath, readFileImpl));
  const issues = await github.paginate(github.rest.issues.listForRepo, {
    owner,
    repo,
    state: "open",
    labels: "board-review",
    per_page: 100,
  });

  let reminded = 0;
  for (const issue of issues) {
    if (issue.pull_request || !isStale(issue, now, staleDays)) {
      continue;
    }

    const labels = new Set((issue.labels ?? []).map((label) => label.name));
    if (labels.has("needs-info")) {
      await github.rest.issues.createComment({
        owner,
        repo,
        issue_number: issue.number,
        body: buildNeedsInfoReminderComment(getContactLogins(issue), staleDays),
      });
      reminded += 1;
      core?.info?.(`Reminded service contacts on issue #${issue.number}.`);
      continue;
    }

    if (!labels.has("ready-for-review")) {
      continue;
    }

    const missingReviews = getMissingReviews(issue, resolvedApproversConfig);
    if (missingReviews.length === 0) {
      continue;
    }

    await github.rest.issues.createComment({
      owner,
      repo,
      issue_number: issue.number,
      body: buildReminderComment(missingReviews, staleDays),
    });
    reminded += 1;
    core?.info?.(`Reminded reviewers on issue #${issue.number}.`);
  }

  return { checked: issues.length, reminded };
}

export {
  DEFAULT_STALE_DAYS,
  buildNeedsInfoReminderComment,
  buildReminderComment,
  getContactLogins,
  getMissingReviews,
  isStale,
};

export default remindReviewers;
