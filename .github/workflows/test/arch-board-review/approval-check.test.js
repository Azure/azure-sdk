import { describe, expect, it, vi } from 'vitest';

import checkApproval from '../../src/arch-board-review/approval-check.js';

const approversConfig = {
    'data-plane': {
        java: ['authorized-architect'],
        python: ['python-architect']
    },
    'management-plane': {
        all: ['management-architect']
    }
};

function createGithubMock() {
    return {
        rest: {
            issues: {
                createComment: vi.fn().mockResolvedValue({}),
                removeLabel: vi.fn().mockResolvedValue({}),
                update: vi.fn().mockResolvedValue({})
            }
        }
    };
}

function createContext({ issueBody, labels, labelAdded, addedBy }) {
    return {
        repo: { owner: 'Azure', repo: 'azure-sdk' },
        payload: {
            issue: {
                number: 123,
                body: issueBody,
                labels: labels.map((name) => ({ name }))
            },
            label: { name: labelAdded },
            sender: { login: addedBy }
        }
    };
}

describe('approval-check', () => {
    it('removes unauthorized approval labels and posts a comment', async () => {
        const github = createGithubMock();
        const context = createContext({
            issueBody: '- [x] Java',
            labels: ['board-review', 'java-api-approved'],
            labelAdded: 'java-api-approved',
            addedBy: 'random-user'
        });

        const result = await checkApproval({ github, context, approversConfig });

        expect(result.unauthorized).toBe(true);
        expect(github.rest.issues.removeLabel).toHaveBeenCalledWith(expect.objectContaining({ name: 'java-api-approved' }));
        expect(github.rest.issues.createComment).toHaveBeenCalledWith(expect.objectContaining({
            body: expect.stringContaining('was removed')
        }));
        expect(github.rest.issues.update).not.toHaveBeenCalled();
    });

    it('keeps authorized approvals without closing until all labels are present', async () => {
        const github = createGithubMock();
        const context = createContext({
            issueBody: `
- [x] Java
- [x] Python
`,
            labels: ['board-review', 'java-api-approved'],
            labelAdded: 'java-api-approved',
            addedBy: 'authorized-architect'
        });

        const result = await checkApproval({ github, context, approversConfig });

        expect(result.closed).toBe(false);
        expect(result.missingLabels).toEqual(['python-api-approved']);
        expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
        expect(github.rest.issues.createComment).not.toHaveBeenCalled();
        expect(github.rest.issues.update).not.toHaveBeenCalled();
    });

    it('closes the issue once all required approvals are present', async () => {
        const github = createGithubMock();
        const context = createContext({
            issueBody: `
- [x] Java
- [x] Python
`,
            labels: ['board-review', 'java-api-approved', 'python-api-approved'],
            labelAdded: 'python-api-approved',
            addedBy: 'python-architect'
        });

        const result = await checkApproval({ github, context, approversConfig });

        expect(result.closed).toBe(true);
        expect(github.rest.issues.createComment).toHaveBeenCalledWith(expect.objectContaining({
            body: expect.stringContaining('All API review approvals received')
        }));
        expect(github.rest.issues.update).toHaveBeenCalledWith(expect.objectContaining({
            state: 'closed',
            state_reason: 'completed'
        }));
    });
});
