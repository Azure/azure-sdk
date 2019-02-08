## Azure SDK design guidelines documents

This folder contains content of design guidelines for all Azure SDK components.

- [C#](https://azuresdkspecs.z5.web.core.windows.net/DotNetSpec.html)
- [Java](https://azuresdkspecs.z5.web.core.windows.net/JavaSpec.html)
- [Python](https://azuresdkspecs.z5.web.core.windows.net/PythonSpec.html)
- [TypeScript](https://azuresdkspecs.z5.web.core.windows.net/TypeScriptSpec.html)

### Contributing
Pull requests to improve these guideline documents are welcome!

The documents are written using [Madoko](http://madoko.org), a Markdown super-set. Guideline sources (```*.mdk``` files) contained in this repo are compiled into language-specific documents (listed above), and a single-page consolidated [Azure SDK Design Guidelines](https://azuresdkspecs.z5.web.core.windows.net/DesignGuidelines.html) document. The guideline documents get automatically updated whenever these source files change.

To generate guideline documents on your machine, clone the repo, and run `npm install`, followed by `npm run build` from the root directory of your clone. An `out` directory will be generated, with an HTML file containing the documents, which can be opened in your browser.
