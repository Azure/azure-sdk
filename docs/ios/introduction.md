---
title: "iOS Guidelines: Introduction"
keywords: guidelines ios
permalink: ios_introduction.html
folder: ios
sidebar: ios_sidebar
---

{% include draft.html content="The iOS guidelines are in DRAFT status" %}

The iOS guidelines are for the benefit of client library designers targeting service applications written for the native iOS ecosystem.  You do not have to write a client library for iOS if your service is not normally accessed from mobile apps.

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

{% include requirement/MUST id="ios-general-follow-general-guidelines" %} follow the [General Azure SDK Guidelines].

{% include requirement/MUST id="ios-general-repository" %} locate all source code in the [azure/azure-sdk-for-ios] GitHub repository.

{% include requirement/MUST id="ios-general-engsys" %} follow Azure SDK engineering systems guidelines for working in the [azure/azure-sdk-for-ios] GitHub repository.

{% include requirement/MUST id="ios-language" %} write the client library in Swift-5.

{% include requirement/MUST id="ios-objc" %} ensure the client library is usable in an iOS application written in Objective-C.

The intent is to ensure that the client library is idiomatic in Swift, but usable in Objective-C.  We are comfortable with a non-idiomatic usage pattern in Objective-C as long as the same pattern is idiomatic in Swift.

{% include refs.md %}
{% include_relative refs.md %}
