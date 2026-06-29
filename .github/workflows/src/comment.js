/**
 * Comment helpers — create or update bot comments on issues/PRs.
 *
 * Follows the same pattern as azure-rest-api-specs `.github/workflows/src/comment.js`:
 * uses an HTML comment marker to identify and update existing bot comments.
 */

/**
 * Finds an existing comment containing the given marker.
 *
 * @param {Array<{id: number, body?: string}>} comments
 * @param {string} marker - HTML comment marker to search for
 * @returns {[number | undefined, string | undefined]}
 */
function parseExistingComment(comments, marker) {
  for (const comment of comments) {
    if (comment.body?.includes(marker)) {
      return [comment.id, comment.body];
    }
  }
  return [undefined, undefined];
}

/**
 * Creates a new issue comment or updates an existing one identified by `commentIdentifier`.
 *
 * @param {object} github - Octokit instance from actions/github-script
 * @param {string} owner
 * @param {string} repo
 * @param {number} issueNumber
 * @param {string} body - Markdown content of the comment
 * @param {string} commentIdentifier - Value stored in an HTML comment for retrieval
 * @param {object} [core] - @actions/core for logging (optional)
 */
async function commentOrUpdate(github, owner, repo, issueNumber, body, commentIdentifier, core) {
  const markedBody = `<!-- ${commentIdentifier} -->\n${body}`;

  const comments = await github.paginate(github.rest.issues.listComments, {
    owner,
    repo,
    issue_number: issueNumber,
    per_page: 100,
  });

  const [commentId, existingBody] = parseExistingComment(comments, commentIdentifier);

  if (commentId) {
    if (existingBody === markedBody) {
      core?.info?.(`No update needed for comment ${commentId}.`);
      return;
    }
    await github.rest.issues.updateComment({
      owner,
      repo,
      comment_id: commentId,
      body: markedBody,
    });
    core?.info?.(`Updated existing comment ${commentId}.`);
  } else {
    const { data: newComment } = await github.rest.issues.createComment({
      owner,
      repo,
      issue_number: issueNumber,
      body: markedBody,
    });
    core?.info?.(`Created new comment #${newComment.id}`);
  }
}

export { commentOrUpdate, parseExistingComment };
