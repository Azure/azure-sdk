import {
    extractLabeledUrl,
    extractLabeledValue,
    getLanguageSection,
    getSelectedLanguages,
    hasCheckedConfirmation,
    LANGUAGE_DEFINITIONS
} from './issue-parsing.js';
import { validateUrl as defaultValidateUrl } from './url-validation.js';

const COMMENT_MARKER = '<!-- arch-board-triage-bot -->';

function createValidationItem(kind, value) {
    return `${kind}: ${value}`;
}

async function analyzeTriage(issueBody, currentLabels, { validateUrl = defaultValidateUrl } = {}) {
    const selectedLanguages = getSelectedLanguages(issueBody);
    const selectedLabelSet = new Set(selectedLanguages.map((language) => language.label));
    const allLanguageLabels = LANGUAGE_DEFINITIONS.map((language) => language.label);
    const labelsToAdd = [...selectedLabelSet].filter((label) => !currentLabels.includes(label));
    const labelsToRemove = allLanguageLabels.filter((label) => currentLabels.includes(label) && !selectedLabelSet.has(label));
    const missing = [];
    const validated = [];
    const warnings = [];

    for (const language of selectedLanguages.filter((candidate) => candidate.tier === 'tier1')) {
        const section = getLanguageSection(issueBody, language.label);
        const languageMissing = [];
        const languageValidated = [];

        if (!section || section === '_No response_') {
            languageMissing.push('No artifacts provided');
            missing.push({ language: language.label, items: languageMissing });
            continue;
        }

        const apiviewUrl = extractLabeledUrl(section, 'APIView');
        if (!apiviewUrl) {
            languageMissing.push('APIView link not provided');
        } else {
            const result = await validateUrl(apiviewUrl);
            if (!result.valid) {
                languageMissing.push(`APIView link is invalid: ${apiviewUrl}`);
            } else {
                languageValidated.push(createValidationItem('APIView', apiviewUrl));
            }
        }

        const samplesValue = extractLabeledValue(section, 'Samples');
        if (!samplesValue) {
            languageMissing.push('Samples not provided');
        } else if (/uploaded\s+in\s+apiview/i.test(samplesValue)) {
            languageValidated.push('Samples: uploaded in APIView');
        } else {
            const sampleUrlMatch = samplesValue.match(/https?:\/\/[^\s)]+/i);
            if (!sampleUrlMatch) {
                languageMissing.push('Samples link not provided');
            } else {
                const result = await validateUrl(sampleUrlMatch[0]);
                if (!result.valid) {
                    languageMissing.push(`Samples link is invalid: ${sampleUrlMatch[0]}`);
                } else {
                    languageValidated.push(createValidationItem('Samples', sampleUrlMatch[0]));
                }
            }
        }

        const prUrl = extractLabeledUrl(section, 'PR');
        if (!prUrl) {
            languageMissing.push('PR link not provided');
        } else {
            const result = await validateUrl(prUrl);
            if (!result.valid) {
                languageMissing.push(`PR link is invalid: ${prUrl}`);
            } else {
                languageValidated.push(createValidationItem('PR', prUrl));
            }
        }

        const readmeUrl = extractLabeledUrl(section, 'README');
        if (!readmeUrl) {
            languageMissing.push('README link not provided');
        } else {
            const result = await validateUrl(readmeUrl);
            if (!result.valid) {
                languageMissing.push(`README link is invalid: ${readmeUrl}`);
            } else {
                languageValidated.push(createValidationItem('README', readmeUrl));
            }
        }

        if (languageMissing.length > 0) {
            missing.push({ language: language.label, items: languageMissing });
        }

        if (languageValidated.length > 0) {
            validated.push({ language: language.label, items: languageValidated });
        }
    }

    const tier2Languages = selectedLanguages.filter((language) => language.tier === 'tier2');
    if (tier2Languages.length > 0) {
        const section = getLanguageSection(issueBody, 'Additional Languages (C++, Rust)');
        if (!section || section === '_No response_') {
            missing.push({
                language: tier2Languages.map((language) => language.label).join(', '),
                items: ['No artifacts provided in the Additional Languages section']
            });
        } else {
            validated.push({
                language: 'Additional Languages',
                items: ['Content provided (manual review required for Tier-2 languages)']
            });
        }
    }

    if (!hasCheckedConfirmation(issueBody, 'A diff revision is selected in APIView for each language')) {
        missing.push({
            language: 'Confirmations',
            items: ['Diff revision confirmation not checked']
        });
    }

    if (!hasCheckedConfirmation(issueBody, 'CI checks are passing on all linked PRs')) {
        warnings.push('CI checks have not been confirmed as passing');
    }

    return {
        labelsToAdd,
        labelsToRemove,
        missing,
        selectedLanguages,
        validated,
        warnings
    };
}

async function upsertComment({ github, context, issueNumber, body }) {
    const markedBody = `${COMMENT_MARKER}\n${body}`;
    const { data: comments } = await github.rest.issues.listComments({
        owner: context.repo.owner,
        repo: context.repo.repo,
        issue_number: issueNumber
    });

    const existingComment = comments.find((comment) => comment.body?.includes(COMMENT_MARKER));
    if (existingComment) {
        await github.rest.issues.updateComment({
            owner: context.repo.owner,
            repo: context.repo.repo,
            comment_id: existingComment.id,
            body: markedBody
        });
    } else {
        await github.rest.issues.createComment({
            owner: context.repo.owner,
            repo: context.repo.repo,
            issue_number: issueNumber,
            body: markedBody
        });
    }
}

function buildSuccessComment({ selectedLanguages, validated, warnings }) {
    let body = `✅ **All materials verified for ${selectedLanguages.map((language) => language.label).join(', ')}.**\n\nThis review request is ready for architects. The \`ready-for-review\` label has been applied.\n\n`;
    if (warnings.length > 0) {
        body += `**Note:** ${warnings.join(', ')}\n\n`;
    }

    body += '<details><summary>Validation details</summary>\n\n';
    for (const entry of validated) {
        body += `**${entry.language}:**\n`;
        for (const item of entry.items) {
            body += `- ✅ ${item}\n`;
        }
        body += '\n';
    }
    body += '</details>';
    return body.trim();
}

function buildFailureComment({ missing, validated }) {
    let body = '⚠️ **Some required materials are missing or invalid.** Please update the issue and the automation will re-check.\n\n';
    for (const entry of missing) {
        body += `**${entry.language}:**\n`;
        for (const item of entry.items) {
            body += `- ❌ ${item}\n`;
        }
        body += '\n';
    }

    if (validated.length > 0) {
        body += '<details><summary>Items that passed validation</summary>\n\n';
        for (const entry of validated) {
            body += `**${entry.language}:**\n`;
            for (const item of entry.items) {
                body += `- ✅ ${item}\n`;
            }
            body += '\n';
        }
        body += '</details>';
    }

    return body.trim();
}

export {
    COMMENT_MARKER,
    analyzeTriage,
    buildFailureComment,
    buildSuccessComment,
    upsertComment
};

export default async function triage({
    github,
    context,
    core,
    validateUrl = defaultValidateUrl
}) {
    const issue = context.payload.issue;
    const issueBody = issue.body ?? '';
    const issueNumber = issue.number;
    const currentLabels = issue.labels.map((label) => label.name);
    const result = await analyzeTriage(issueBody, currentLabels, { validateUrl });

    if (result.labelsToAdd.length > 0) {
        await github.rest.issues.addLabels({
            owner: context.repo.owner,
            repo: context.repo.repo,
            issue_number: issueNumber,
            labels: result.labelsToAdd
        });
    }

    for (const label of result.labelsToRemove) {
        try {
            await github.rest.issues.removeLabel({
                owner: context.repo.owner,
                repo: context.repo.repo,
                issue_number: issueNumber,
                name: label
            });
        } catch {
        }
    }

    if (result.selectedLanguages.length === 0) {
        if (!currentLabels.includes('needs-info')) {
            await github.rest.issues.addLabels({
                owner: context.repo.owner,
                repo: context.repo.repo,
                issue_number: issueNumber,
                labels: ['needs-info']
            });
        }

        if (currentLabels.includes('ready-for-review')) {
            try {
                await github.rest.issues.removeLabel({
                    owner: context.repo.owner,
                    repo: context.repo.repo,
                    issue_number: issueNumber,
                    name: 'ready-for-review'
                });
            } catch {
            }
        }

        await upsertComment({
            github,
            context,
            issueNumber,
            body: '⚠️ **No languages were selected.** Please edit the issue and check at least one language under "Languages for this Review".'
        });

        return { ...result, status: 'needs-info' };
    }

    if (result.missing.length === 0) {
        if (!currentLabels.includes('ready-for-review')) {
            await github.rest.issues.addLabels({
                owner: context.repo.owner,
                repo: context.repo.repo,
                issue_number: issueNumber,
                labels: ['ready-for-review']
            });
        }

        if (currentLabels.includes('needs-info')) {
            try {
                await github.rest.issues.removeLabel({
                    owner: context.repo.owner,
                    repo: context.repo.repo,
                    issue_number: issueNumber,
                    name: 'needs-info'
                });
            } catch {
            }
        }

        await upsertComment({
            github,
            context,
            issueNumber,
            body: buildSuccessComment(result)
        });

        core?.info?.('Review request is ready for review.');
        return { ...result, status: 'ready-for-review' };
    }

    if (!currentLabels.includes('needs-info')) {
        await github.rest.issues.addLabels({
            owner: context.repo.owner,
            repo: context.repo.repo,
            issue_number: issueNumber,
            labels: ['needs-info']
        });
    }

    if (currentLabels.includes('ready-for-review')) {
        try {
            await github.rest.issues.removeLabel({
                owner: context.repo.owner,
                repo: context.repo.repo,
                issue_number: issueNumber,
                name: 'ready-for-review'
            });
        } catch {
        }
    }

    await upsertComment({
        github,
        context,
        issueNumber,
        body: buildFailureComment(result)
    });

    core?.info?.('Review request still needs more information.');
    return { ...result, status: 'needs-info' };
}
