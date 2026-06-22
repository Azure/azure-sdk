const ALLOWED_HOSTS = [
    'apiview.dev',
    'github.com',
    'learn.microsoft.com',
    'azure.github.io'
];

function isAllowedHost(url) {
    try {
        const parsed = new URL(url);
        return ALLOWED_HOSTS.some((host) => parsed.hostname === host || parsed.hostname.endsWith(`.${host}`));
    } catch {
        return false;
    }
}

function hasApiViewReviewId(url) {
    try {
        const parsed = new URL(url);
        if (!(parsed.hostname === 'apiview.dev' || parsed.hostname.endsWith('.apiview.dev'))) {
            return false;
        }

        return /\/review\/[a-z0-9-]+/i.test(parsed.pathname)
            || parsed.searchParams.has('activeApiRevisionId')
            || parsed.searchParams.has('revisionId');
    } catch {
        return false;
    }
}

async function tryFetch(fetchImpl, url, init) {
    try {
        const response = await fetchImpl(url, init);
        return response.ok || response.status === 405;
    } catch {
        return false;
    }
}

async function validateUrl(url, { fetchImpl = globalThis.fetch, timeoutMs = 10000 } = {}) {
    if (!isAllowedHost(url)) {
        return { valid: false, reason: 'host-not-allowed' };
    }

    if (url.includes('apiview.dev') && !hasApiViewReviewId(url)) {
        return { valid: false, reason: 'missing-apiview-review-id' };
    }

    if (url.includes('apiview.dev')) {
        return { valid: true, reason: null };
    }

    if (typeof fetchImpl !== 'function') {
        return { valid: false, reason: 'fetch-unavailable' };
    }

    const signal = typeof AbortSignal?.timeout === 'function' ? AbortSignal.timeout(timeoutMs) : undefined;
    const headSucceeded = await tryFetch(fetchImpl, url, { method: 'HEAD', redirect: 'follow', signal });
    if (headSucceeded) {
        return { valid: true, reason: null };
    }

    const getSucceeded = await tryFetch(fetchImpl, url, { method: 'GET', redirect: 'follow', signal });
    return getSucceeded
        ? { valid: true, reason: null }
        : { valid: false, reason: 'unreachable' };
}

export {
    ALLOWED_HOSTS,
    hasApiViewReviewId,
    isAllowedHost,
    validateUrl
};
