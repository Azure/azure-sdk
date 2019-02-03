## Azure SDK design guidelines documents

This folder contains design guidelines for all Azure client libraries. Specifications are written using [Madoko](http://madoko.org), a Markdown super-set. These specifications are compiled into a single-page [Azure SDK Design Guidelines](https://azuresdkspecs.z5.web.core.windows.net/DesignGuidelines.html) document, and this is updated whenever these files change.

Each language-specific guideline document below includes a section on language-independent topics. This is to ensure that all SDK components follow a number of language-independent best practices, and this advice is uniform across all languages. In some cases the advice is overridden by the language-specific advice, which always takes precedence. The guidelines are available from the following links:

- [C#](https://azuresdkspecs.z5.web.core.windows.net/DotNetSpec.html)
- [Java](https://azuresdkspecs.z5.web.core.windows.net/JavaSpec.html)
- [Python](https://azuresdkspecs.z5.web.core.windows.net/PythonSpec.html)
- [TypeScript](https://azuresdkspecs.z5.web.core.windows.net/TypeScriptSpec.html)

### Contributing
Pull requests to improve these specification documents are welcome!

To generate the specification document on your machine, clone the repo, and run `npm install`, followed by `npm run build` from the root directory of your clone. An `out` directory will be generated, with an HTML file containing the spec, which can be opened in your browser.
