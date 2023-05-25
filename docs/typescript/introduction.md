---
title: "TypeScript Guidelines: Introduction"
keywords: guidelines typescript
permalink: typescript_introduction.html
folder: typescript
sidebar: general_sidebar
---

The TypeScript guidelines are for the benefit of client library designers targeting service applications written in TypeScript for the benefit of both TypeScript and JavaScript.

## Design principles

The Azure SDK should be designed to enhance the productivity of developers connecting to Azure services. Other qualities (such as completeness, extensibility, and performance) are important but secondary. Productivity is achieved by adhering to the principles described below:

### Idiomatic

* The SDK should follow the general design guidelines and conventions for the target language. It should feel natural to a developer in the target language.
* We embrace the ecosystem with its strengths and its flaws.
* We work with the ecosystem to improve it for all developers.

### Consistent

* Client libraries should be consistent within the language, consistent with the service and consistent between all target languages. In cases of conflict, consistency within the language is the highest priority and consistency between all target languages is the lowest priority.
* Service-agnostic concepts such as logging, HTTP communication, and error handling should be consistent. The developer should not have to relearn service-agnostic concepts as they move between client libraries.
* Consistency of terminology between the client library and the service is a good thing that aids in diagnosability.
* All differences between the service and client library must have a good (articulated) reason for existing, rooted in idiomatic usage rather than whim.
* The Azure SDK for each target language feels like a single product developed by a single team.
* There should be feature parity across target languages. This is more important than feature parity with the service.

### Approachable

* We are experts in the supported technologies so our customers, the developers, don't have to be.
* Developers should find great documentation (hero tutorial, how to articles, samples, and API documentation) that makes it easy to be successful with the Azure service.
* Getting off the ground should be easy through the use of predictable defaults that implement best practices. Think about progressive concept disclosure.
* The SDK should be easily acquired through the most normal mechanisms in the target language and ecosystem.
* Developers can be overwhelmed when learning new service concepts. The core use cases should be discoverable.

### Diagnosable

* The developer should be able to understand what is going on.
* It should be discoverable when and under what circumstances a network call is made.
* Defaults are discoverable and their intent is clear.
* Logging, tracing, and exception handling are fundamental and should be thoughtful.
* Error messages should be concise, correlated with the service, actionable, and human readable. Ideally, the error message should lead the consumer to a useful action that they can take.
* Integrating with the preferred debugger for the target language should be easy.

### Dependable

* Breaking changes are more harmful to a user's experience than most new features and improvements are beneficial.
* Incompatibilities should never be introduced deliberately without thorough review and very strong justification.
* Do not rely on dependencies that can force our hand on compatibility.

## General Guidelines

{% include requirement/MUST id="ts-follow-general-guidelines" %} follow the [General Azure SDK Guidelines].

{% include requirement/MUST id="ts-repository-location" %} locate all source code in the [azure/azure-sdk-for-js] GitHub repository.

{% include requirement/MUST id="ts-engineering-systems" %} follow Azure SDK engineering systems guidelines for working in the [azure/azure-sdk-for-js] GitHub repository.

{% include requirement/MUST id="ts-azure-scope" %} follow these guidelines if you publish your client library under the `@azure` scope in npm.

{% include requirement/SHOULD id="ts-azure-scope-for-others" %} follow these guidelines even if you're not publishing an Azure library under the `@azure` scope.

## Terminology

AMD Module
: A module format often used in the browser, for example as implemented by [RequireJS].

[CommonJS][cjs] (CJS)
: The module format of Node.js (`require`, `module.exports`).

[ECMAScript Module][esm] (ES Module or ESM)
: The standard import/export syntax defined in ECMAScript 6.

{% include refs.md %}
{% include_relative refs.md %}
