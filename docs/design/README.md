## Azure SDK design guidelines documents

This folder contains design guidelines for all Azure client libraries. Specifications are written using [Madoko](http://madoko.org), a Markdown super-set. These specifications are compiled into a single-page [Azure SDK Design Guidelines](https://azuresdkspecs.z5.web.core.windows.net/DesignGuidelines.html) document, and this is updated whenever these files change.

It is recommended that all contributors familiarize themselves with the [language-independent guidelines](https://azuresdkspecs.z5.web.core.windows.net/DesignGuidelines.html) first, before reading the specification for their language of choice. The language-independent guidelines may be overridden on a per-language basis by more specific guidance for a specific language. 

The language-specific guidelines are available from the following links:

- [C#](https://azuresdkspecs.z5.web.core.windows.net/DesignGuidelines.html#sec-c-specific-guidelines)
- [Java](https://azuresdkspecs.z5.web.core.windows.net/DesignGuidelines.html#sec-java-specific-guidelines)
- [Python](https://azuresdkspecs.z5.web.core.windows.net/DesignGuidelines.html#sec-python-specific-guidelines)
- [TypeScript](https://azuresdkspecs.z5.web.core.windows.net/DesignGuidelines.html#sec-javascript-specific-guidelines)

### Contributing
Pull requests to improve these specification documents are welcome!

To generate the specification document on your machine, clone the repo, and run `npm install`, followed by `npm run build` from the root directory of your clone. An `out` directory will be generated, with an HTML file containing the spec, which can be opened in your browser.
