/**
 * Assign Reviewers — routes a ready review request to per-language architects.
 *
 * Called by triage once an issue reaches `ready-for-review`. For each selected
 * language it picks one architect (round-robin, keyed off the issue number) from
 * the shared `api-review-approvers.yml` roster and assigns them to the issue.
 * Assigning triggers GitHub's native notifications, so architects are reached
 * through their own notification preferences.
 *
 * The roster is the same source of truth used by approval validation, so there is
 * no separate reviewer list to keep in sync. Management-plane issues additionally
 * consider the management-plane approvers.
 *
 * The assignment itself is the notification mechanism; the resolved handles are
 * surfaced in triage's "materials verified" comment for visibility. Idempotent:
 * only newly resolved assignees are added, so edits to an already-assigned issue
 * do not re-assign or re-notify.
 *
 * Edits are reconciled: if a language selection changes (e.g. Java swapped for
 * Python), architects the automation previously assigned but that no longer apply
 * are removed. Only roster members are removed, so assignees added manually (or by
 * anyone outside the roster) are always preserved.
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
 * Deterministically pick one candidate, distributing across issues by number.
 *
 * @param {string[]} candidates
 * @param {number} issueNumber
 * @returns {string | null}
 */
function pickReviewer(candidates, issueNumber) {
  if (!candidates || candidates.length === 0) {
    return null;
  }
  return candidates[issueNumber % candidates.length];
}

/**
 * Resolve one architect per selected language from the roster.
 *
 * @param {object} params
 * @param {string} params.issueBody
 * @param {number} params.issueNumber
 * @param {object} params.approversConfig
 * @returns {{ byLanguage: { language: string, reviewer: string }[], assignees: string[], unassigned: string[] }}
 *   `unassigned` lists selected languages that have no configured architect.
 */
function resolveAssignments({ issueBody, issueNumber, approversConfig }) {
  const selectedLanguages = getSelectedLanguages(issueBody);
  const managementReviewers = isManagementPlaneIssue(issueBody)
    ? getManagementApprovers(approversConfig)
    : [];

  const byLanguage = [];
  const assigneeSet = new Set();
  const unassigned = [];

  for (const language of selectedLanguages) {
    const candidates = [
      ...new Set([
        ...getApproversForLanguage(approversConfig, language.id),
        ...managementReviewers,
      ]),
    ];
    const reviewer = pickReviewer(candidates, issueNumber);
    if (reviewer) {
      byLanguage.push({ language: language.label, reviewer });
      assigneeSet.add(reviewer);
    } else {
      unassigned.push(language.label);
    }
  }

  return { byLanguage, assignees: [...assigneeSet], unassigned };
}

export { pickReviewer, resolveAssignments };

/**
 * Resolve reviewers for the issue, assign any that are not already assigned, and
 * remove stale automation-assigned architects that no longer apply after an edit.
 * Does not post a comment - the resolved handles are surfaced by the caller's
 * validation comment. Returns the per-language mapping for that rendering.
 *
 * @returns {Promise<{ byLanguage: { language: string, reviewer: string }[], assigned: string[], removed: string[], unassigned: string[], skipped: boolean }>}
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
    issueNumber,
    approversConfig: resolvedConfig,
  });

  if (unassigned.length > 0) {
    core?.warning?.(`No architect configured for: ${unassigned.join(", ")}`);
  }

  const resolvedLower = new Set(assignees.map((login) => login.toLowerCase()));
  const currentLower = new Set(currentAssignees.map((login) => login.toLowerCase()));
  const rosterManaged = new Set(
    getAllApprovers(resolvedConfig).map((login) => login.toLowerCase()),
  );

  const newAssignees = assignees.filter((login) => !currentLower.has(login.toLowerCase()));

  // Reconcile edits: remove architects the automation manages (roster members)
  // that are no longer resolved for the current languages. Manual assignees that
  // are not in the roster are left untouched.
  const staleAssignees = currentAssignees.filter(
    (login) => rosterManaged.has(login.toLowerCase()) && !resolvedLower.has(login.toLowerCase()),
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
    core?.info?.("Reviewers already up to date; no assignment changes.");
    return { byLanguage, assigned: [], removed: [], unassigned, skipped: true };
  }

  return {
    byLanguage,
    assigned: newAssignees,
    removed: staleAssignees,
    unassigned,
    skipped: false,
  };
}
