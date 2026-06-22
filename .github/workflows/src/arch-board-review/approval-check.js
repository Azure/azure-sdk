import { readFile } from 'node:fs/promises';
import yaml from 'js-yaml';

import { getSelectedLanguages } from './issue-parsing.js';

const APPROVAL_LABEL_PATTERN = /^(dotnet|java|python|typescript|go|cpp|rust)-api-approved$/;
const DEFAULT_APPROVERS_PATH = new URL('../../../api-review-approvers.yml', import.meta.url);

function isApprovalLabel(label) {
    return APPROVAL_LABEL_PATTERN.test(label ?? '');
}

function getApproversForLanguage(approversConfig, languageId) {
    return approversConfig['data-plane']?.[languageId] ?? [];
}

function getManagementApprovers(approversConfig) {
    return approversConfig['management-plane']?.all ?? [];
}

function isManagementPlaneIssue(issueBody) {
    return /management\s*plane/i.test(issueBody);
}

async function loadApproversConfig(configPath, readFileImpl) {
    const contents = await readFileImpl(configPath, 'utf8');
    return yaml.load(contents);
}

function getAllowedApprovers({ approversConfig, labelAdded, issueBody }) {
    const languageId = labelAdded.split('-')[0];
    const allowedApprovers = new Set(getApproversForLanguage(approversConfig, languageId));

    if (isManagementPlaneIssue(issueBody)) {
        for (const approver of getManagementApprovers(approversConfig)) {
            allowedApprovers.add(approver);
        }
    }

    return [...allowedApprovers];
}

function buildUnauthorizedComment(labelAdded, addedBy) {
    return `⚠️ **Approval label \`${labelAdded}\` was removed.** Only authorized architects can apply approval labels.\n\n@${addedBy} is not an authorized approver for this language.`;
}

function buildApprovalCompleteComment(requiredLabels) {
    const approvedLabels = requiredLabels.map((label) => `\`${label}\``).join(', ');
    return `✅ **All API review approvals received.** Closing this issue.\n\n**Approved:** ${approvedLabels}`;
}

export {
    APPROVAL_LABEL_PATTERN,
    buildApprovalCompleteComment,
    buildUnauthorizedComment,
    getAllowedApprovers,
    getApproversForLanguage,
    getManagementApprovers,
    isApprovalLabel,
    isManagementPlaneIssue,
    loadApproversConfig
};

export default async function checkApproval({
    github,
    context,
    core,
    approversConfig,
    approversPath = DEFAULT_APPROVERS_PATH,
    readFileImpl = readFile
}) {
    const issue = context.payload.issue;
    const issueNumber = issue.number;
    const issueBody = issue.body ?? '';
    const labels = issue.labels.map((label) => label.name);
    const labelAdded = context.payload.label?.name ?? '';
    const addedBy = context.payload.sender?.login ?? '';

    if (!isApprovalLabel(labelAdded)) {
        core?.info?.(`Skipping non-approval label: ${labelAdded || '<none>'}`);
        return { skipped: true, reason: 'non-approval-label' };
    }

    const resolvedApproversConfig = approversConfig ?? await loadApproversConfig(approversPath, readFileImpl);
    const allowedApprovers = getAllowedApprovers({
        approversConfig: resolvedApproversConfig,
        labelAdded,
        issueBody
    });

    if (!allowedApprovers.includes(addedBy)) {
        core?.info?.(`Removing unauthorized label ${labelAdded} added by ${addedBy}`);

        try {
            await github.rest.issues.removeLabel({
                owner: context.repo.owner,
                repo: context.repo.repo,
                issue_number: issueNumber,
                name: labelAdded
            });
        } catch {
        }

        await github.rest.issues.createComment({
            owner: context.repo.owner,
            repo: context.repo.repo,
            issue_number: issueNumber,
            body: buildUnauthorizedComment(labelAdded, addedBy)
        });

        return { unauthorized: true, allowedApprovers };
    }

    const selectedLanguages = getSelectedLanguages(issueBody);
    const requiredLabels = selectedLanguages.map((language) => `${language.id}-api-approved`);
    const missingLabels = requiredLabels.filter((requiredLabel) => !labels.includes(requiredLabel));

    if (requiredLabels.length === 0) {
        core?.info?.('No selected languages detected; skipping close check.');
        return { skipped: true, reason: 'no-selected-languages' };
    }

    if (missingLabels.length === 0) {
        await github.rest.issues.createComment({
            owner: context.repo.owner,
            repo: context.repo.repo,
            issue_number: issueNumber,
            body: buildApprovalCompleteComment(requiredLabels)
        });

        await github.rest.issues.update({
            owner: context.repo.owner,
            repo: context.repo.repo,
            issue_number: issueNumber,
            state: 'closed',
            state_reason: 'completed'
        });
    }

    return {
        closed: missingLabels.length === 0,
        missingLabels,
        requiredLabels,
        selectedLanguages
    };
}
