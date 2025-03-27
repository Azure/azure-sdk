---
title: "General Guidelines: Terminology"
keywords: guidelines
permalink: general_terminology.html
folder: general
sidebar: general_sidebar
---

Throughout the guidelines, the following terms should be understood:

Architecture Board
: The Azure Developer Experience [Architecture Board] is comprised of language experts who advise and review client libraries used for accessing Azure services.

Azure SDK
: The collection of _client libraries_ for a single target language, used for accessing Azure services.

Azure Core
: A dependency of many client libraries.  The Azure Core library provides access to the HTTP pipeline, common credential types, and other types that are appropriate to the Azure SDK as a whole.

Client
: A class that provides methods to send requests to the service.

Client Library
: A library (and associated tools, documentation, and samples) that _consumers_ use to ease working with an Azure service.  There is generally a client library per Azure service and per target language.  Sometimes a single client library will contain the ability to connect to multiple services.

Consumer
: Where appropriate to disambiguate between the various types of developers, we use the term _consumer_ to indicate the developer who is using a client library in an app to connect to an Azure service.

Docstrings
: The comments embedded within the code that describe the API surface being implemented.  The _docstrings_ are extracted and post-processed during the build to generate API reference documentation.

Library Developer
: Where appropriate to disambiguate between the various types of developers, we use the term _library developer_ to indicate the developer who is writing a client library.

Package
: A client library after it has been packaged for distribution to consumers.  Packages are generally installed using a package manager from a package repository.

Package Repository
: Each client library is published separately to the appropriate language-specific package repository.  For example, we distribute JavaScript libraries to [npmjs.org](https://npmjs.org) (also known as the NPM Registry), and Python libraries to [PyPI](https://pypi.org/).  These releases are performed exclusively by the Azure SDK engineering systems team.  Consumers install packages using a package manager.  For example, a JavaScript consumer might use yarn, npm, or similar, whereas a Python consumer will use `pip` to install packages into their project.

Progressive Concept Disclosure
: The first interaction with the client library should not rely on advanced service concepts.  As the consumer of the library becomes more adept, we expose the concepts necessary at the point at which the consumer needs those concepts for implementation. [Progressive Disclosure] was first discussed by the Nielson Norman Group as an approach to designing better user interfaces.

Service client
: The starting points for consumers calling Azure services with the Azure SDK. A service client is distinguished from other clients in that it can be directly constructed. Each client library should have at least one service client in its main namespace, so it’s easy to discover.

Subclient {#subclient}
: A subclient is a type of client that cannot be directly constructed. Subclients can only be returned from another client.

## Requirements

Each requirement in this document is labelled and color-coded to show the relative importance.  In order from highest importance to lowest importance:

{% include requirement/MUST %} adopt this requirement for the client library.  If you feel you need an exception, engage with the [Architecture Board] prior to implementation.

{% include requirement/MUSTNOT %} adopt this requirement for the client library.  If you feel you need an exception, engage with the [Architecture Board] prior to implementation.

{% include requirement/SHOULD %} strongly consider this requirement for the client library.  If not following this advice, you **MUST** disclose the variance during the [Architecture Board] design review. 

{% include requirement/SHOULDNOT %} strongly consider this requirement for the client library.  If not following this advice, you **MUST** disclose the variance during the [Architecture Board] design review.

{% include requirement/MAY %} consider this advice if appropriate to your situation.  No notification to the architecture board is required.

{% include refs.md %}

[Progressive Disclosure]: https://www.nngroup.com/articles/progressive-disclosure/
