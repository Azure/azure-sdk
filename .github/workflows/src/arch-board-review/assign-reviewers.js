/**
 * Assign Reviewers — routes a ready review request to per-language architects.
 *
 * Called by triage once an issue reaches `ready-for-review`. For each selected
 * language it assigns every configured architect from the shared
 * `api-review-approvers.yml` approvers list to the issue. Assigning triggers
 * GitHub's native notifications, so architects are reached through their own
 * notification preferences.
 *
 * The approvers list is the same source of truth used by approval validation, so
 * there is no separate reviewer list to keep in sync. Management-plane issues
 * additionally consider the management-plane approvers.
 *
 * The assignment itself is the notification mechanism; the resolved handles are
 * surfaced in triage's "materials verified" comment for visibility. Idempotent:
 * only newly resolved assignees are added, so edits to an already-assigned issue
 * do not re-assign or re-notify.
 *
 * Edits are reconciled: if a language selection changes (e.g. Java swapped for
 * Python), architects the automation previously assigned but that no longer apply
 * are removed. Only configured approvers are removed, so assignees added manually
 * (or by anyone outside the approvers list) are always preserved.
 */
import { readFile } from "node:fs/promises";

import { getSelectedLanguages } from "./issue-parsing.js";
import {
  getAllApprovers,
  getApproversForLanguage,
  getManagementApprovers,
  isManagementPlaneIssue,
  loadApproversConfig,
} from "./approval-check.js";

const DEFAULT_APPROVERS_PATH = new URL("../../../api-review-approvers.yml", import.meta.url);

/**
 * Resolve the architects for each selected language from the approvers list.
 *
 * Every configured architect for a language is assigned (management-plane issues
 * additionally include the management-plane approvers). There is intentionally no
 * load balancing - if a language has more than one architect they are all tagged.
 * If that ever gets noisy we can add distribution later.
 *
 * @param {object} params
 * @param {string} params.issueBody
 * @param {object} params.approversConfig
 * @returns {{ byLanguage: { language: string, reviewers: string[] }[], assignees: string[], unassigned: string[] }}
 *   `unassigned` lists selected languages that have no configured architect.
 */
function resolveAssignments({ issueBody, approversConfig }) {
  const selectedLanguages = getSelectedLanguages(issueBody);
  const managementReviewers = isManagementPlaneIssue(issueBody)
    ? getManagementApprovers(approversConfig)
    : [];

  const byLanguage = [];
  const assigneeSet = new Set();
  const unassigned = [];

  for (const language of selectedLanguages) {
    const reviewers = [
      ...new Set([
        ...getApproversForLanguage(approversConfig, language.id),
        ...managementReviewers,
      ]),
    ];
    if (reviewers.length > 0) {
      byLanguage.push({ language: language.label, reviewers });
      for (const reviewer of reviewers) {
        assigneeSet.add(reviewer);
      }
    } else {
      unassigned.push(language.label);
    }
  }

  return { byLanguage, assignees: [...assigneeSet], unassigned };
}

export { resolveAssignments };

/**
 * Resolve reviewers for the issue, assign any that are not already assigned, and
 * remove stale automation-assigned architects that no longer apply after an edit.
 * Does not post a comment - the resolved handles are surfaced by the caller's
 * validation comment. Returns the per-language mapping for that rendering.
 *
 * @returns {Promise<{ byLanguage: { language: string, reviewers: string[] }[], assigned: string[], removed: string[], unassigned: string[], skipped: boolean, reason: string | null }>}
 *   When `skipped` is true, `reason` is `"already-assigned"` (reviewers exist and
 *   nothing changed) or `"no-reviewers-resolved"` (no architect could be resolved
 *   for the selected languages). When `skipped` is false, `reason` is null.
 */
export default async function assignReviewers({
  github,
  context,
  core,
  approversConfig,
  approversPath = DEFAULT_APPROVERS_PATH,
  readFileImpl = readFile,
}) {
  const issue = context.payload.issue;
  const issueBody = issue.body ?? "";
  const issueNumber = issue.number;
  const currentAssignees = (issue.assignees ?? []).map((assignee) => assignee.login);
  const { owner, repo } = context.repo;

  const resolvedConfig =
    approversConfig ?? (await loadApproversConfig(approversPath, readFileImpl));

  const { byLanguage, assignees, unassigned } = resolveAssignments({
    issueBody,
    approversConfig: resolvedConfig,
  });

  if (unassigned.length > 0) {
    core?.warning?.(`No architect configured for: ${unassigned.join(", ")}`);
  }

  const resolvedLower = new Set(assignees.map((login) => login.toLowerCase()));
  const currentLower = new Set(currentAssignees.map((login) => login.toLowerCase()));
  const configuredApprovers = new Set(
    getAllApprovers(resolvedConfig).map((login) => login.toLowerCase()),
  );

  const newAssignees = assignees.filter((login) => !currentLower.has(login.toLowerCase()));

  // Reconcile edits: remove architects the automation manages (configured
  // approvers) that are no longer resolved for the current languages. Manual
  // assignees that are not in the approvers list are left untouched.
  const staleAssignees = currentAssignees.filter(
    (login) =>
      configuredApprovers.has(login.toLowerCase()) && !resolvedLower.has(login.toLowerCase()),
  );

  if (newAssignees.length > 0) {
    await github.rest.issues.addAssignees({
      owner,
      repo,
      issue_number: issueNumber,
      assignees: newAssignees,
    });
    core?.info?.(`Assigned reviewers: ${newAssignees.join(", ")}`);
  }

  if (staleAssignees.length > 0) {
    await github.rest.issues.removeAssignees({
      owner,
      repo,
      issue_number: issueNumber,
      assignees: staleAssignees,
    });
    core?.info?.(`Removed stale reviewers: ${staleAssignees.join(", ")}`);
  }

  if (newAssignees.length === 0 && staleAssignees.length === 0) {
    const reason = assignees.length === 0 ? "no-reviewers-resolved" : "already-assigned";
    core?.info?.(
      reason === "already-assigned"
        ? "Reviewers already up to date; no assignment changes."
        : "No architect could be resolved for the selected languages.",
    );
    return { byLanguage, assigned: [], removed: [], unassigned, skipped: true, reason };
  }

  return {
    byLanguage,
    assigned: newAssignees,
    removed: staleAssignees,
    unassigned,
    skipped: false,
    reason: null,
  };
}
