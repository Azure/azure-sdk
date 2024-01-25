---
title: "Rust Guidelines: Introduction"
keywords: guidelines rust
permalink: rust_introduction.html
folder: rust
sidebar: general_sidebar
---

{% include draft.html content="The Rust Language guidelines are in DRAFT status" %}

## Introduction

The Rust guidelines are for the benefit of client library designers targeting service applications written in Rust.  You do not have to write a client library for Rust if your service is not normally accessed from Rust.

### Design Principles {#rust-principles}

The Azure SDK should be designed to enhance the productivity of developers connecting to Azure services. Other qualities (such as completeness, extensibility, and performance) are important but secondary. Productivity is achieved by adhering to the principles described below:

**Idiomatic**

* The SDK should follow the general design guidelines and conventions for the target language. It should feel natural to a developer in the target language.
* We embrace the ecosystem with its strengths and its flaws.
* We work with the ecosystem to improve it for all developers.

**Consistent**

* Client libraries should be consistent within the language, consistent with the service and consistent between all target languages. In cases of conflict, consistency within the language is the highest priority and consistency between all target languages is the lowest priority.
* Service-agnostic concepts such as logging, HTTP communication, and error handling should be consistent. The developer should not have to relearn service-agnostic concepts as they move between client libraries.
* Consistency of terminology between the client library and the service is a good thing that aids in diagnosability.
* All differences between the service and client library must have a good (articulated) reason for existing, rooted in idiomatic usage rather than whim.
* The Azure SDK for each target language feels like a single product developed by a single team.
* There should be feature parity across target languages. This is more important than feature parity with the service.

**Approachable**

* We are experts in the supported technologies so our customers, the developers, don't have to be.
* Developers should find great documentation (hero tutorial, how to articles, samples, and API documentation) that makes it easy to be successful with the Azure service.
* Getting off the ground should be easy through the use of predictable defaults that implement best practices. Think about progressive concept disclosure.
* The SDK should be easily acquired through the most normal mechanisms in the target language and ecosystem.
* Developers can be overwhelmed when learning new service concepts. The core use cases should be discoverable.

**Diagnosable**

* The developer should be able to understand what is going on.
* It should be discoverable when and under what circumstances a network call is made.
* Defaults are discoverable and their intent is clear.
* Logging, tracing, and exception handling are fundamental and should be thoughtful.
* Error messages should be concise, correlated with the service, actionable, and human readable. Ideally, the error message should lead the consumer to a useful action that they can take.
* Integrating with the preferred debugger for the target language should be easy.

**Dependable**

* Breaking changes are more harmful to a user's experience than most new features and improvements are beneficial.
* Incompatibilities should never be introduced deliberately without thorough review and very strong justification.
* Do not rely on dependencies that can force our hand on compatibility.

### General Guidelines {#rust-general}

{% include requirement/MUST id="rust-general-follow-general-guidelines" %} follow the [General Azure SDK Guidelines].

### Support for non-HTTP Protocols

This document contains guidelines developed primarily for typical Azure REST services, i.e. stateless services with request-response based interaction model. Many of the guidelines in this document are more broadly applicable, but some might be specific to such REST services.

## Azure SDK API Design {#rust-api}

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.

{% include requirement/MUST id="rust-design-naming-concise" %} use clear, concise, and meaningful names.

{% include requirement/SHOULDNOT id="rust-design-naming-abbrev" %} use abbreviations unless necessary or when they are commonly used and understood.  For example, `az` is allowed since it is commonly used to mean `Azure`, and `iot` is used since it is a commonly understood industry term.  However, using `kv` for Key Vault would not be allowed since `kv` is not commonly used to refer to Key Vault.

{% include requirement/MUST id="rust-design-dependencies-adparch" %} consult the [Architecture Board] if you wish to use a dependency that is not on the list of approved dependencies.

### Service Client {#rust-client}

Service clients are the main starting points for developers calling Azure services with the Azure SDK. Each client library should have at least one client in its main namespace, so it’s easy to discover. The guidelines in this section describe patterns for the design of a service client.

There exists a distinction that must be made clear with service clients: not all classes that perform HTTP (or otherwise) requests to a service are automatically designated as a service client. A service client designation is only applied to classes that are able to be directly constructed because they are uniquely represented on the service. Additionally, a service client designation is only applied if there is a specific scenario that applies where the direct creation of the client is appropriate. If a resource can not be uniquely identified or there is no need for direct creation of the type, then the service client designation should not apply.

{% include requirement/MUST id="rust-service-client-name" %} name service client types with the _Client_ suffix (for example, `ConfigurationClient`).

{% include requirement/MUST id="rust-service-client-namespace" %} place service client types that the consumer is most likely to interact with in the root namespace of the client library (for example, `Azure::<group>::<service>`). Specialized service clients should be placed in sub-packages.

{% include requirement/MUST id="rust-service-client-type" %} make service clients `classes`, not `structs`.

{% include requirement/MUST id="rust-service-client-immutable" %} ensure that all service client classes thread safe (usually by making them immutable and stateless).

{% include requirement/MUST id="rust-service-client-geturl" %} expose a `GetUrl()` method which returns the URL.

#### Service Client Constructors {#rust-client-ctor}

{% include requirement/MUST id="rust-service-client-constructor-minimal" %} provide a minimal constructor that takes only the parameters required to connect to the service.

> TODO: Add service client factory pattern examples for connection strings.

{% include requirement/MUSTNOT id="rust-client-constructor-no-default-params" %} use default parameters in the simplest constructor.

{% include requirement/MUST id="rust-client-constructor-overloads" %} provide constructor overloads that allow specifying additional options via  an `options` parameter. The type of the parameter is typically a subclass of ```ClientOptions``` type, shown below.

##### Client Configuration

{% include requirement/MUST id="rust-config-global-config" %} use relevant global configuration settings either by default or when explicitly requested to by the user, for example by passing in a configuration object to a client constructor.

{% include requirement/MUST id="rust-config-for-different-clients" %} allow different clients of the same type to use different configurations.

{% include requirement/MUST id="rust-config-optout" %} allow consumers of your service clients to opt out of all global configuration settings at once.

{% include requirement/MUST id="rust-config-global-overrides" %} allow all global configuration settings to be overridden by client-provided options. The names of these options should align with any user-facing global configuration keys.

{% include requirement/MUSTNOT id="rust-config-defaults-nochange" %} Change the default values of client
configuration options based on system or program state.

{% include requirement/MUSTNOT id="rust-config-defaults-nobuildchange" %} Change default values of
client configuration options based on how the client library was built.

{% include requirement/MUSTNOT id="rust-config-behaviour-changes" %} change behavior based on configuration changes that occur after the client is constructed. Hierarchies of clients inherit parent client configuration unless explicitly changed or overridden. Exceptions to this requirement are as follows:

1. Log level, which must take effect immediately across the Azure SDK.
2. Tracing on/off, which must take effect immediately across the Azure SDK.

{% include requirement/MUSTNOT id="rust-config-noruntime" %} use client library specific runtime
configuration such as environment variables or a config file. Keep in mind that many IoT devices
won't have a filesystem or an "environment block" to read from.

##### Using ClientOptions {#rust-usage-options}

> TODO: This section needs to be driven by code in the Core library.

##### Service Versions

> TODO: This section needs to be driven by code in the Core library.

{% include requirement/MUST id="rust-versioning-highest-api" %} call the highest supported service API version by default.

{% include requirement/MUST id="rust-versioning-select-api-version" %} allow the consumer to explicitly select a supported service API version when instantiating the service client.

Use a constructor parameter called `version` on the client options type.

* The `version` parameter must be the first parameter to all constructor overloads.
* The `version` parameter must be required, and default to the latest supported service version.
* The type of the `version` parameter must be `ServiceVersion`; an enum nested in the options type.
* The `ServiceVersion` enum must use explicit values starting from 1.
* `ServiceVersion` enum value 0 is reserved. When 0 is passed into APIs, ArgumentException should be thrown.

##### Mocking

> TODO: This section needs to be driven by code in the Core library.

#### Service Methods {#rust-client-methods}

> TODO: This section needs to be driven by code in the Core library.

_Service methods_ are the methods on the client that invoke operations on the service.

##### Sync and Async

The Rust SDK is designed for asynchronous api calls.

{% include requirement/MUST id="rust-design-client-sync-api" %} provide an asynchronous programming model.

{% include requirement/MUSTNOT id="rust-design-client-sync-api" %} provide a sync programming model.

> TODO: This section needs to be driven by code in the Core library.

##### Naming

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

##### Cancellation

> TODO: Review this section

{% include requirement/MUST id="rust-service-methods-cancellation" %} ensure all service methods, both asynchronous and synchronous, take an optional `Context` parameter called _context_.

The context should be further passed to all calls that take a context. DO NOT check the context manually, except when running a significant amount of CPU-bound work within the library, e.g. a loop that can take more than a typical network call.

##### Mocking

> TODO: This section needs to be driven by code in the Core library.

##### Return Types

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

##### Thread Safety

{% include requirement/MUST id="rust-design-client-methods-thread-safety" %} be thread-safe. All public members of the client type must be safe to call from multiple threads concurrently.

#### Service Method Parameters {#rust-parameters}

> TODO: This section needs to be driven by code in the Core library.

##### Parameter Validation

The service client will have several methods that perform requests on the service.  _Service parameters_ are directly passed across the wire to an Azure service.  _Client parameters_ are not passed directly to the service, but used within the client library to fulfill the request.  Examples of client parameters include values that are used to construct a URI, or a file that needs to be uploaded to storage.

{% include requirement/MUST id="rust-params-client-validation" %} validate client parameters.

{% include requirement/MUSTNOT id="rust-params-server-validation" %} validate service parameters.  This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUST id="rust-params-check-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service.  If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

#### Methods Returning Collections (Paging) {#rust-paging}

Although object-orientated languages can eschew low-level pagination APIs in favor of high-level abstractions, Rust acts as a lower level language and thus embraces pagination APIs provided by the service.  You should work within the confines of the paging system provided by the service.

{% include requirement/MUST id="rust-design-logical-client-pagination-use-paging" %} export the same paging API as the service provides.

{% include requirement/MUST id="rust-design-logical-client-pagination-rust-last-page" %} indicate in the return type if the consumer has reached the end of the result set.

{% include requirement/MUST id="rust-design-logical-client-pagination-size-of-page" %} indicate in the return type how many items were returned by the service, and have a list of those items for the consumer to iterate over.

#### Methods Invoking Long Running Operations {#rust-longrunning}

> TODO: Review this section

Some service operations, known as _Long Running Operations_ or _LROs_ take a long time (up to hours or days). Such operations do not return their result immediately, but rather are started, their progress is polled, and finally the result of the operation is retrieved.

Azure::Core library exposes an abstract type called `Operation<T>`, which represents such LROs and supports operations for polling and waiting for status changes, and retrieving the final operation result.  A service method invoking a long running operation will return a subclass of `Operation<T>`, as shown below.

> TODO: This section needs to be driven by code in the Core library.

{% include requirement/MUST id="rust-lro-prefix" %} name all methods that start an LRO with the `Start` prefix.

{% include requirement/MUST id="rust-lro-return" %} return a subclass of `Operation<T>` from LRO methods.

{% include requirement/MAY id="rust-lro-subclass" %} add additional APIs to subclasses of `Operation<T>`.
For example, some subclasses add a constructor allowing to create an operation instance from a previously saved operation ID. Also, some subclasses are more granular states besides the `IsDone` and `HasValue` states that are present on the base class.

##### Conditional Request Methods

> TODO: This section needs to be driven by code in the Core library.

##### Hierarchical Clients

> TODO: This section needs to be driven by code in the Core library.

### Supporting Types

In addition to service client types, Azure SDK APIs provide and use other supporting types as well.

#### Model Types {#rust-model-types}

This section describes guidelines for the design _model types_ and all their transitive closure of public dependencies (i.e. the _model graph_).  A model type is a representation of a REST service's resource.


{% include requirement/MUST id="rust-design-model-public-getters" %} ensure model public properties are const if they aren't intended to be changed by the user.

Most output-only models can be fully read-only. Models that are used as both outputs and inputs (i.e. received from and sent to the service) typically have a mixture of read-only and read-write properties.

> TODO: This section needs to be driven by code in the Core library.

##### Model Type Naming

> TODO: This section needs to be driven by code in the Core library.

#### Enumerations

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

See [enumeration-like structure documentation](implementation.md#rust-enums) for implementation details.

#### Using Azure Core Types {#rust-commontypes}

> TODO: Review this section

The `tbd` package provides common functionality for client libraries.  Documentation and usage examples can be found in the [azure/azure-sdk-for-rust](https://github.com/Azure/azure-sdk-for-rust/tree/main/sdk/core) repository.

#### Using Primitive Types

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

### Exceptions {#rust-errors}

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Rust Exceptions

### Authentication {#rust-authentication}

> TODO: Review this section

Azure services use a variety of different authentication schemes to allow clients to access the service. Conceptually, there are two entities responsible in this process: a credential and an authentication policy.  Credentials provide confidential authentication data.  Authentication policies use the data provided by a credential to authenticate requests to the service.

{% include requirement/MUST id="rust-design-logical-client-support-all-auth-techniques" %} support all authentication techniques that the service supports and are available to a client application (as opposed to service side).  C is used only for client applications when talking to Azure, so some authentication techniques may not be valid.

{% include requirement/MUST id="rust-design-logical-client-use-azure-core" %} use credential and authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="rust-design-logical-client-prefer-token-auth" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service in a non-blocking atomic manner for each authentication scheme that does not have an implementation in Azure Core.

{% include requirement/MUST id="rust-apisurface-auth-in-constructors" %} provide service client constructors or factories that accept any supported authentication credentials.

{% include requirement/SHOULDNOT id="rust-design-logical-client-surface-no-connection-strings" %} support providing credential data via a connection string. Connection string interfaces should be provided __ONLY IF__ the service provides a connection string to users via the portal or other tooling.

{% include requirement/MUSTNOT id="rust-design-logical-client-surface-no-connection-string-ctors" %} support constructing a service client with a connection string unless such connection string. Provide a `CreateFromConnectionString` static member function which returns a client instead to encourage customers to choose non-connection-string-based authentication.

When implementing authentication, don't open up the consumer to security holes like PII (personally identifiable information) leakage or credential leakage.  Credentials are generally issued with a time limit, and must be refreshed periodically to ensure that the service connection continues to function as expected.  Ensure your client library follows all current security recommendations and consider an independent security review of the client library to ensure you're not introducing potential security problems for the consumer.

{% include requirement/MUSTNOT id="rust-implementing-no-persistence-auth" %}
persist, cache, or reuse security credentials.  Security credentials should be considered short lived to cover both security concerns and credential refresh situations.

If your service implements a non-standard credential system (one that is not supported by Azure Core), then you need to produce an authentication policy for the HTTP pipeline that can authenticate requests given the alternative credential types provided by the client library.

{% include requirement/MUST id="rust-implementing-secure-auth-erase" %} Use a "secure" function to zero authentication or authorization credentials as soon as possible once they are no longer needed. Examples of such functions
include: `SecureZeroMemory`, `memset_s`, and `explicit_bzero`. Examples of insecure functions include `memset`. An optimizer may notice that the credentials are
never accessed again, and optimize away the call to `memset`, resulting in the credentials remaining in memory.

{% include requirement/MUST id="rust-implementing-auth-policy" %}
provide a suitable authentication policy that authenticates the HTTP request in the HTTP pipeline when using non-standard credentials.  This includes custom connection strings, if supported.

### Namespaces {#rust-namespace-naming}

### Support for Mocking {#rust-mocking}

> TODO: This section needs to be driven by code in the Core library.

## Azure SDK Library Design

### Packaging {#rust-packaging}

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Common Libraries

> TODO: This section needs to be driven by code in the Core library.

### Versioning {#rust-versioning}

#### Client Versions

{% include requirement/MUST id="rust-versioning-backwards-compatibility" %} be 100% backwards compatible with older versions of the same package.

> TODO: Review this section

{% include requirement/MUST id="rust-versioning-new-package" %} introduce a new package (with new assembly names, new namespace names, and new type names) if you must do an API breaking change.

Breaking changes should happen rarely, if ever.  Register your intent to do a breaking change with [adparch]. You'll need to have a discussion with the language architect before approval.

##### Package Version Numbers {#rust-versionnumbers}

> TODO: Review this section

Consistent version number scheme allows consumers to determine what to expect from a new version of the library.

{% include requirement/MUST id="rust-version-semver" %} use _MAJOR_._MINOR_._PATCH_ format for the version of the library dll and the NuGet package.

Use _-beta._N_ suffix for beta package versions. For example, _1.0.0-beta.2_.

{% include requirement/MUST id="rust-version-change-on-release" %} change the version number of the client library when **ANYTHING** changes in the client library.

{% include requirement/MUST id="rust-version-patching" %} increment the patch version when fixing a bug.

{% include requirement/MUSTNOT id="rust-version-features-in-patch" %} include new APIs in a patch release.

{% include requirement/MUST id="rust-version-add-feature" %} increment the major or minor version when adding support for a service API version.

{% include requirement/MUST id="rust-version-add-api" %} increment the major or minor version when adding a new method to the public API.

{% include requirement/SHOULD id="rust-version-major-changes" %} increment the major version when making large feature changes.

{% include requirement/MUST id="rust-version-change-on-release" %} select a version number greater than the highest version number of any other released Track 1 package for the service in any other scope or language.

### Dependencies {#rust-dependencies}

Dependencies bring in many considerations that are often easily avoided by avoiding the
dependency.

- **Versioning** - Many programming languages do not allow a consumer to load multiple versions of the same package. So, if we have an client library that requires v3 of package Foo and the consumer wants to use v5 of package Foo, then the consumer cannot build their application. This means that client libraries should not have dependencies by default.
- **Size** - Consumer applications must be able to deploy as fast as possible into the cloud and move in various ways across networks. Removing additional code (like dependencies) improves deployment performance.
- **Licensing** - You must be conscious of the licensing restrictions of a dependency and often provide proper attribution and notices when using them.
- **Compatibility** - Often times you do not control a dependency and it may choose to evolve in a direction that is incompatible with your original use.
- **Security** - If a security vulnerability is discovered in a dependency, it may be difficult or time consuming to get the vulnerability corrected if Microsoft does not control the dependencies code base.

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

### Documentation Comments {#rust-documentation}

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section


## Repository Guidelines {#rust-repository}

{% include requirement/MUST id="rust-general-repository" %} locate all source code and README in the [azure/azure-sdk-for-rust] GitHub repository.

{% include requirement/MUST id="rust-general-engsys" %} follow Azure SDK engineering systems guidelines for working in the [azure/azure-sdk-for-rust] GitHub repository.

> TODO: Content in this section below here should be moved to a better location.

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section


### Documentation Style

There are several documentation deliverables that must be included in or as a companion to your client library. Beyond complete and helpful API documentation within the code itself (docstrings), you need a great README and other supporting documentation.

* `README.md` - Resides in the root of your library's directory within the SDK repository; includes package installation and client library usage information. ([example][README-EXAMPLE])
* `API reference` - Generated from the docstrings in your code; published on docs.microsoft.com.
* `Code snippets` - Short code examples that demonstrate single (atomic) operations for the champion scenarios you've identified for your library; included in your README, docstrings, and Quickstart.
* `Quickstart` - Article on docs.microsoft.com that is similar to but expands on the README content; typically written by your service's content developer.
* `Conceptual` - Long-form documentation like Quickstarts, Tutorials, How-to guides, and other content on docs.microsoft.com; typically written by your service's content developer.

{% include requirement/MUST id="rust-docs-contentdev" %} include your service's content developer in the Architecture Board review for your library. To find the content developer you should work with, check with your team's Program Manager.

{% include requirement/MUST id="rust-docs-contributors-guide" %} follow the [Azure SDK Contributors Guide]. (MICROSOFT INTERNAL)

{% include requirement/MUST id="rust-docs-style-guide" %} adhere to the specifications set forth in the Microsoft style guides when you write public-facing documentation. This applies to both long-form documentation like a README and the docstrings in your code. (MICROSOFT INTERNAL)

* [Microsoft Writing Style Guide].
* [Microsoft Cloud Style Guide].

{% include requirement/SHOULD id="rust-docs-to-silence" %} attempt to document your library into silence. Preempt developers' usage questions and minimize GitHub issues by clearly explaining your API in the docstrings. Include information on service limits and errors they might hit, and how to avoid and recover from those errors.

As you write your code, *doc it so you never hear about it again.* The less questions you have to answer about your client library, the more time you have to build new features for your service.

**Docstrings**

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

**Code snippets**

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section


**Buildsystem integration**

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section


**Formatting**

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section


### README {#rust-repository-readme}

{% include requirement/MUST id="rust-docs-readme" %} have a README.md file in the component root folder.

An example of a good `README.md` file can be found [here](https://github.com/Azure/azure-sdk-for-rust/blob/main/sdk/core/README.md).

{% include requirement/MUST id="rust-docs-readme-consumer" %} optimize the `README.md` for the consumer of the client library.

The contributor guide (`CONTRIBUTING.md`) should be a separate file linked to from the main component `README.md`.

### Samples {#rust-samples}

> TODO: Provide sample guidelines.

## Commonly Overlooked Rust API Design Guidelines {#rust-appendix-overlookedguidelines}

> TODO: Provide Rust specific API design guidelines.  Example:


<!-- Links -->

{% include refs.md %}
{% include_relative refs.md %}
