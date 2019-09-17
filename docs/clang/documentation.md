---
title: "C Guidelines: Documentation"
keywords: guidelines clang
permalink: clang_documentation.html
folder: clang
sidebar: clang_sidebar
---

{% include draft.html content="The C Language guidelines are in DRAFT status" %}

There are several documentation deliverables that must be included in or as a companion to your client library. Beyond complete and helpful API documentation within the code itself (docstrings), you need a great README and other supporting documentation.

* `README.md` - Resides in the root of your library's directory within the SDK repository; includes package installation and client library usage information. ([example][README-EXAMPLE])
* `API reference` - Generated from the docstrings in your code; published on docs.microsoft.com. 
* `Code snippets` - Short code examples that demonstrate single (atomic) operations for the champion scenarios you've identified for your library; included in your README, docstrings, and Quickstart. 
* `Quickstart` - Article on docs.microsoft.com that is similar to but expands on the README content; typically written by your service's content developer. 
* `Conceptual` - Long-form documentation like Quickstarts, Tutorials, How-to guides, and other content on docs.microsoft.com; typically written by your service's content developer. 

{% include requirement/MUST id="clang-docs-contentdev" %} include your service's content developer in the Architecture Board review for your library. To find the content developer you should work with, check with your team's Program Manager.

{% include requirement/MUST id="clang-docs-contributors-guide" %} follow the [Azure SDK Contributors Guide]. (MICROSOFT INTERNAL)

{% include requirement/MUST id="clang-docs-style-guide" %} adhere to the specifications set forth in the Microsoft style guides when you write public-facing documentation. This applies to both long-form documentation like a README and the docstrings in your code. (MICROSOFT INTERNAL)

* [Microsoft Writing Style Guide].
* [Microsoft Cloud Style Guide].

{% include requirement/SHOULD id="clang-docs-to-silence" %} attempt to document your library into silence. Preempt developers' usage questions and minimize GitHub issues by clearly explaining your API in the docstrings. Include information on service limits and errors they might hit, and how to avoid and recover from those errors.

As you write your code, *doc it so you never hear about it again.* The less questions you have to answer about your client library, the more time you have to build new features for your service.

> TODO: How to write docstrings

### Code snippets

{% include requirement/MUST id="clang-docs-include-snippets" %} include example code snippets alongside your library's code within the repository. The snippets should clearly and succinctly demonstrate the operations most developers need to perform with your library. Include snippets for every common operation, and especially for those that are complex or might otherwise be difficult for new users of your library. At a bare minimum, include snippets for the champion scenarios you've identified for the library.

{% include requirement/MUST id="clang-docs-build-snippets" %} build and test your example code snippets using the repository's continuous integration (CI) to ensure they remain functional.

{% include requirement/MUST id="clang-docs-snippets-in-docstrings" %} include the example code snippets in your library's docstrings so they appear in its API reference. If the language and its tools support it, ingest these snippets directly into the API reference from within the docstrings. 

> TODO: Include explicit reference on how to include example code in the doc snippets.

{% include requirement/MUSTNOT id="clang-docs-operation-combinations" %} combine more than one operation in a code snippet unless it's required for demonstrating the type or member, or it's *in addition to* existing snippets that demonstrate atomic operations. For example, a Cosmos DB code snippet should not include both account and container creation operations--create two different snippets, one for account creation, and one for container creation.

Combined operations cause unnecessary friction for a library consumer by requiring knowledge of additional operations which might be outside their current focus. It requires them to first understand the tangential code surrounding the operation they're working on, then carefully extract just the code they need for their task. The developer can no longer simply copy and paste the code snippet into their project.

> TODO: Include any build instructions that you must add to your CMakefile in order to generate the documentation.

{% include refs.md %}