import { describe, expect, it } from 'vitest';

import {
    extractLabeledUrl,
    extractLabeledValue,
    getLanguageSection,
    getSelectedLanguages,
    hasCheckedConfirmation
} from '../../src/arch-board-review/issue-parsing.js';

describe('issue-parsing', () => {
    it('detects checked language checkboxes and ignores unchecked ones', () => {
        const issueBody = `
- [x] Java
- [ ] Python
- [X] TypeScript
`;

        expect(getSelectedLanguages(issueBody).map((language) => language.id)).toEqual(['java', 'typescript']);
    });

    it('extracts a language section until the next heading', () => {
        const issueBody = `
### Java
- APIView: https://apiview.dev/Assemblies/Review/123
- PR: https://github.com/Azure/azure-sdk-for-java/pull/1

### Python
- APIView: https://apiview.dev/Assemblies/Review/456
`;

        expect(getLanguageSection(issueBody, 'Java')).toContain('https://github.com/Azure/azure-sdk-for-java/pull/1');
        expect(getLanguageSection(issueBody, 'Java')).not.toContain('### Python');
    });

    it('extracts labeled values and urls from a section', () => {
        const section = `
- APIView: https://apiview.dev/Assemblies/Review/123
- Samples: Uploaded in APIView
`;

        expect(extractLabeledUrl(section, 'APIView')).toBe('https://apiview.dev/Assemblies/Review/123');
        expect(extractLabeledValue(section, 'Samples')).toBe('Uploaded in APIView');
    });

    it('detects checked confirmation checkboxes', () => {
        const issueBody = `
- [x] A diff revision is selected in APIView for each language
- [ ] CI checks are passing on all linked PRs
`;

        expect(hasCheckedConfirmation(issueBody, 'A diff revision is selected in APIView for each language')).toBe(true);
        expect(hasCheckedConfirmation(issueBody, 'CI checks are passing on all linked PRs')).toBe(false);
    });
});
