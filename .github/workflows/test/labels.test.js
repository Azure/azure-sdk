import { describe, expect, it, vi } from 'vitest';

import { addLabels, ensureLabel, ensureLabelRemoved, removeLabel } from '../src/labels.js';

function createGithubMock() {
    return {
        rest: {
            issues: {
                addLabels: vi.fn().mockResolvedValue({}),
                removeLabel: vi.fn().mockResolvedValue({})
            }
        }
    };
}

describe('addLabels', () => {
    it('adds labels when array is non-empty', async () => {
        const github = createGithubMock();
        await addLabels(github, 'o', 'r', 1, ['bug', 'help']);
        expect(github.rest.issues.addLabels).toHaveBeenCalledWith(
            expect.objectContaining({ labels: ['bug', 'help'] })
        );
    });

    it('skips call when array is empty', async () => {
        const github = createGithubMock();
        await addLabels(github, 'o', 'r', 1, []);
        expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
    });
});

describe('removeLabel', () => {
    it('ignores 404 errors', async () => {
        const github = createGithubMock();
        const error = new Error('Not Found');
        error.status = 404;
        github.rest.issues.removeLabel.mockRejectedValueOnce(error);
        await expect(removeLabel(github, 'o', 'r', 1, 'missing')).resolves.not.toThrow();
    });

    it('rethrows non-404 errors', async () => {
        const github = createGithubMock();
        const error = new Error('Internal Server Error');
        error.status = 500;
        github.rest.issues.removeLabel.mockRejectedValueOnce(error);
        await expect(removeLabel(github, 'o', 'r', 1, 'bug')).rejects.toThrow('Internal Server Error');
    });
});

describe('ensureLabel', () => {
    it('adds label when not present', async () => {
        const github = createGithubMock();
        await ensureLabel(github, 'o', 'r', 1, 'bug', []);
        expect(github.rest.issues.addLabels).toHaveBeenCalled();
    });

    it('skips when label already present', async () => {
        const github = createGithubMock();
        await ensureLabel(github, 'o', 'r', 1, 'bug', ['bug']);
        expect(github.rest.issues.addLabels).not.toHaveBeenCalled();
    });
});

describe('ensureLabelRemoved', () => {
    it('removes label when present', async () => {
        const github = createGithubMock();
        await ensureLabelRemoved(github, 'o', 'r', 1, 'bug', ['bug']);
        expect(github.rest.issues.removeLabel).toHaveBeenCalled();
    });

    it('skips when label already absent', async () => {
        const github = createGithubMock();
        await ensureLabelRemoved(github, 'o', 'r', 1, 'bug', []);
        expect(github.rest.issues.removeLabel).not.toHaveBeenCalled();
    });
});
