import { describe, expect, it, vi } from 'vitest';

import { commentOrUpdate, parseExistingComment } from '../src/comment.js';

describe('parseExistingComment', () => {
    it('finds a comment containing the marker', () => {
        const comments = [
            { id: 1, body: 'unrelated' },
            { id: 2, body: '<!-- my-bot -->\nHello world' }
        ];
        const [id, body] = parseExistingComment(comments, 'my-bot');
        expect(id).toBe(2);
        expect(body).toContain('Hello world');
    });

    it('returns undefined when no match', () => {
        const [id, body] = parseExistingComment([{ id: 1, body: 'nope' }], 'my-bot');
        expect(id).toBeUndefined();
        expect(body).toBeUndefined();
    });
});

describe('commentOrUpdate', () => {
    function createGithubMock(existingComments = []) {
        return {
            paginate: vi.fn().mockResolvedValue(existingComments),
            rest: {
                issues: {
                    listComments: {},
                    createComment: vi.fn().mockResolvedValue({ data: { id: 99 } }),
                    updateComment: vi.fn().mockResolvedValue({})
                }
            }
        };
    }

    it('creates a new comment when none exists', async () => {
        const github = createGithubMock();
        await commentOrUpdate(github, 'owner', 'repo', 1, 'Hello', 'test-bot');

        expect(github.rest.issues.createComment).toHaveBeenCalledWith(
            expect.objectContaining({ body: '<!-- test-bot -->\nHello' })
        );
        expect(github.rest.issues.updateComment).not.toHaveBeenCalled();
    });

    it('updates an existing comment', async () => {
        const github = createGithubMock([
            { id: 42, body: '<!-- test-bot -->\nOld content' }
        ]);
        await commentOrUpdate(github, 'owner', 'repo', 1, 'New content', 'test-bot');

        expect(github.rest.issues.updateComment).toHaveBeenCalledWith(
            expect.objectContaining({ comment_id: 42, body: '<!-- test-bot -->\nNew content' })
        );
        expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    });

    it('skips update when body is unchanged', async () => {
        const github = createGithubMock([
            { id: 42, body: '<!-- test-bot -->\nSame content' }
        ]);
        await commentOrUpdate(github, 'owner', 'repo', 1, 'Same content', 'test-bot');

        expect(github.rest.issues.updateComment).not.toHaveBeenCalled();
        expect(github.rest.issues.createComment).not.toHaveBeenCalled();
    });
});
