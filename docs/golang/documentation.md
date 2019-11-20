---
title: "Go Guidelines: Documentation"
keywords: guidelines golang
permalink: golang_documentation.html
folder: golang
sidebar: golang_sidebar
---

{% include draft.html content="The Go Language guidelines are in DRAFT status" %}

There are several documentation deliverables that must be included in or as a companion to your client library. Beyond complete and helpful API documentation within the code itself ([GoDoc]), you need a great README and other supporting documentation.

* `README.md` - Resides in the root of your library's directory within the SDK repository; includes package installation and client library usage information. ([example][README-EXAMPLE])
* `API reference` - Generated from the docstrings in your code; published on [godoc.org](https://godoc.org) and [docs.microsoft.com](https://docs.microsoft.com). 
* `Code snippets` - Short code examples that demonstrate single (atomic) operations for the champion scenarios you've identified for your library; included in your README, docstrings, and Quickstart. 
* `Quickstart` - Article on docs.microsoft.com that is similar to but expands on the README content; typically written by your service's content developer. 
* `Conceptual` - Long-form documentation like Quickstarts, Tutorials, How-to guides, and other content on docs.microsoft.com; typically written by your service's content developer. 

{% include requirement/MUST id="golang-docs-contentdev" %} include your service's content developer in the Architecture Board review for your library. To find the content developer you should work with, check with your team's Program Manager.

{% include requirement/MUST id="golang-docs-contributors-guide" %} follow the [Azure SDK Contributors Guide]. (MICROSOFT INTERNAL)

{% include requirement/MUST id="golang-docs-style-guide" %} adhere to the specifications set forth in the Microsoft style guides when you write public-facing documentation. This applies to both long-form documentation like a README and the docstrings in your code. (MICROSOFT INTERNAL)

* [Microsoft Writing Style Guide].
* [Microsoft Cloud Style Guide].

{% include requirement/SHOULD id="golang-docs-to-silence" %} attempt to document your library into silence. Preempt developers' usage questions and minimize GitHub issues by clearly explaining your API in the [GoDoc]. Include information on service limits and errors they might hit, and how to avoid and recover from those errors.

As you write your code, *doc it so you never hear about it again.* The less questions you have to answer about your client library, the more time you have to build new features for your service.

### Code examples

Code examples are small functions that demonstrate a certain feature that is relevant to the client library.  Examples allow developers to quickly understand the full usage requirements of your client library.  Code examples shouldn't be any more complex than needed to demonstrate the feature.  Don't write full applications.  Examples should have a high signal to noise ratio between useful code and boilerplate code for non-related reasons.

{% include requirement/MUST id="golang-include-code-examples" %} include code examples within your package’s code. The examples should clearly and succinctly demonstrate the code most developers need to write with your library. Include examples for all common operations. Pay attention to operations that are complex or might be difficult for new users of your library. Include examples for the champion scenarios you’ve identified for the library.

{% include requirement/MUST id="golang-code-example-location" %} place code examples within the package directory, for example in an `examples_test.go` file.

{% include requirement/MUST id="golang-code-example-comments" %} add an `Output:` or `Unordered output:` [comment](https://golang.org/pkg/testing/#hdr-Examples) at the end of the example if the output is deterministic and suitable for running as a unit test.

{% include requirement/MUST id="golang-code-example-graft" %} ensure that code examples can be easily grafted from the documentation into a user’s own application.

{% include requirement/MUST id="golang-code-example-readability" %} write code examples for ease of reading and comprehension over code compactness and efficiency.

{% include requirement/MUST id="golang-code-example-platforms" %} ensure that examples can run in Windows, macOS, and Linux development environments.

{% include requirement/MUST id="golang-code-example-builds" %} build and test your code examples using the repository’s continuous integration (CI) to ensure they remain functional.

{% include requirement/MUST id="golang-code-example-exports" %} ensure that all exported types, members, functions, and methods are documented. 

{% include requirement/MUSTNOT id="golang-code-example-combination" %} combine multiple operations in a code example unless it’s required for demonstrating the type or member. For example, a Cosmos DB code example doesn’t include both account and container creation operations. Create an example for account creation, and another example for container creation.

Combined operations require knowledge of additional operations that might be outside the user’s current focus. The developer must first understand the code surrounding the operation they’re working on and can’t copy and paste the code example into their project.


{% include refs.md %}
{% include_relative refs.md %}
