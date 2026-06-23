/**
 * Label helpers — add and remove labels on issues/PRs with error handling.
 *
 * Centralises the try/catch pattern for label removal (which throws 404 when
 * the label is already absent) and bulk add/remove for label sync.
 */

/**
 * Adds one or more labels to an issue.
 *
 * @param {object} github - Octokit instance
 * @param {string} owner
 * @param {string} repo
 * @param {number} issueNumber
 * @param {string[]} labels
 */
async function addLabels(github, owner, repo, issueNumber, labels) {
    if (labels.length === 0) return;
    await github.rest.issues.addLabels({
        owner,
        repo,
        issue_number: issueNumber,
        labels
    });
}

/**
 * Removes a single label from an issue. Silently ignores 404 (already removed).
 *
 * @param {object} github - Octokit instance
 * @param {string} owner
 * @param {string} repo
 * @param {number} issueNumber
 * @param {string} label
 */
async function removeLabel(github, owner, repo, issueNumber, label) {
    try {
        await github.rest.issues.removeLabel({
            owner,
            repo,
            issue_number: issueNumber,
            name: label
        });
    } catch (error) {
        if (error.status !== 404) throw error;
    }
}

/**
 * Ensures a label is present on an issue. No-op if already applied.
 *
 * @param {object} github
 * @param {string} owner
 * @param {string} repo
 * @param {number} issueNumber
 * @param {string} label
 * @param {string[]} currentLabels - Current label names on the issue
 */
async function ensureLabel(github, owner, repo, issueNumber, label, currentLabels) {
    if (!currentLabels.includes(label)) {
        await addLabels(github, owner, repo, issueNumber, [label]);
    }
}

/**
 * Ensures a label is absent from an issue. No-op if already absent.
 *
 * @param {object} github
 * @param {string} owner
 * @param {string} repo
 * @param {number} issueNumber
 * @param {string} label
 * @param {string[]} currentLabels - Current label names on the issue
 */
async function ensureLabelRemoved(github, owner, repo, issueNumber, label, currentLabels) {
    if (currentLabels.includes(label)) {
        await removeLabel(github, owner, repo, issueNumber, label);
    }
}

export { addLabels, ensureLabel, ensureLabelRemoved, removeLabel };
