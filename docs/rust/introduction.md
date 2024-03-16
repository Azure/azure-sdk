---
title: "Rust Guidelines: Introduction"
keywords: guidelines rust
permalink: rust_introduction.html
folder: rust
sidebar: general_sidebar
---

{% include draft.html content="The Rust Language guidelines are in DRAFT status" %}

## Introduction

The Rust guidelines are for the benefit of client library designers targeting service applications written in Rust. You do not have to write a client library for Rust if your service is not normally accessed from Rust.

### Design Principles {#rust-principles}

The Azure SDK should be designed to enhance the productivity of developers connecting to Azure services. Other qualities (such as completeness, extensibility, and performance) are important but secondary. Productivity is achieved by adhering to the principles described below:

#### Idiomatic

* The SDK should follow the general [design guidelines and conventions][rust-lang-guidelines] for the Rust language. It should feel natural to a developer in the Rust language.
* We embrace the ecosystem with its strengths and its flaws.
* We work with the ecosystem to improve it for all developers.

#### Consistent

* Client libraries should be consistent within the language, consistent with the service and consistent between all target languages. In cases of conflict, consistency within the language is the highest priority and consistency between all target languages is the lowest priority.
* Service-agnostic concepts such as logging, HTTP communication, and error handling should be consistent. The developer should not have to relearn service-agnostic concepts as they move between client libraries.
* Consistency of terminology between the client library and the service is a good thing that aids in diagnostics.
* All differences between the service and client library must have a good (articulated) reason for existing, rooted in idiomatic usage rather than whim.
* The Azure SDK for each target language feels like a single product developed by a single team.
* There should be feature parity across target languages. This is more important than feature parity with the service.

#### Approachable

* We are experts in the supported technologies so our customers, the developers, don't have to be.
* Developers should find great documentation (hero tutorial, how to articles, samples, and API documentation) that makes it easy to be successful with the Azure service.
* Getting off the ground should be easy through the use of predictable defaults that implement best practices. Think about progressive concept disclosure.
* The SDK should be easily acquired through the most normal mechanisms in the target language and ecosystem.
* Developers can be overwhelmed when learning new service concepts. The core use cases should be discoverable.

#### Diagnosable

* The developer should be able to understand what is going on.
* It should be discoverable when and under what circumstances a network call is made.
* Defaults are discoverable and their intent is clear.
* Logging, tracing, and exception handling are fundamental and should be thoughtful.
* Error messages should be concise, correlated with the service, actionable, and human readable. Ideally, the error message should lead the consumer to a useful action that they can take.
* Integrating with the preferred debugger for the target language should be easy.

#### Dependable

* Breaking changes are more harmful to a user's experience than most new features and improvements are beneficial.
* Incompatibilities should never be introduced deliberately without thorough review and very strong justification.
* Do not rely on dependencies that can force our hand on compatibility.

### General Guidelines {#rust-general}

{% include requirement/MUST id="rust-general-follow-general-guidelines" %} follow the [General Azure SDK Guidelines].

{% include requirement/MUST id="rust-general-pipeline" %} use `azure_core::Pipeline` to implement all methods that call Azure REST services.

{% include requirement/MUST id="rust-general-idiomatic-code" %} write idiomatic Rust code. If you’re not familiar with the language, a great place to start is <https://www.rust-lang.org/learn>. Do __NOT__ simply attempt to translate your language of choice into Rust.

{% include requirement/MUSTNOT id="rust-general-version" %} use grammar or features newer than the `rust-version` declared in the root `Cargo.toml` workspace.

{% include requirement/MUSTNOT id="rust-general-dependencies" %} necessarily depend on any particular async runtime or HTTP stack.

{% include requirement/SHOULD id="rust-general-dependencies-default" %} depend on `tokio` (async runtime) and `reqwest` (HTTP stack) in the `default` feature for crates.

### Support for non-HTTP Protocols

This document contains guidelines developed primarily for typical Azure REST services i.e., stateless services with request-response based interaction model. Many of the guidelines in this document are more broadly applicable, but some might be specific to such REST services.

## Azure SDK API Design {#rust-api}

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.

{% include requirement/MUST id="rust-api-naming-concise" %} use clear, concise, and meaningful names.

{% include requirement/MUST id="rust-api-naming-standard" %} follow [Rust naming conventions][rust-lang-naming].

{% include requirement/SHOULDNOT id="rust-api-naming-abbreviation" %} use abbreviations unless necessary or when they are commonly used and understood. For example, `iot` is used since it is a commonly understood industry term; however, using `kv` for Key Vault would not be allowed since `kv` is not commonly used to refer to Key Vault.

{% include requirement/MUST id="rust-api-dependencies" %} consult the [Architecture Board] if you wish to use a dependency that is not on the list of [centrally managed dependencies][rust-lang-dependencies].

### Service Client {#rust-client}

Service clients are the main starting points for developers calling Azure services with the Azure SDK. Each client library should have at least one client in its main namespace, so it’s easy to discover. The guidelines in this section describe patterns for the design of a service client.

There exists a distinction that must be made clear with service clients: not all classes that perform HTTP (or otherwise) requests to a service are automatically designated as a service client. A service client designation is only applied to classes that are able to be directly constructed because they are uniquely represented on the service. Additionally, a service client designation is only applied if there is a specific scenario that applies where the direct creation of the client is appropriate. If a resource can not be uniquely identified or there is no need for direct creation of the type, then the service client designation should not apply.

{% include requirement/MUST id="rust-client-name" %} name service client types with the _Client_ suffix e.g., `SecretClient`.

Client names are specific to the service to avoid ambiguity when using multiple clients without requiring `as` to change the binding name e.g.,

```text
error[E0252]: the name `Client` is defined multiple times
  --> src/main.rs:2:38
   |
1  |     use azure_storage_blob::Client;
   |         ----------- previous import of the type `Client` here
2  |     use azure_security_keyvault::secrets::Client;
   |         ^^^^^^^^^^^ `Client` reimported here
   |
```

{% include requirement/SHOULD id="rust-client-namespace" %} place service client types that the consumer is most likely to interact with in the root module of the client library e.g., `azure_security_keyvault`. Specialized service clients should be placed in submodules e.g., `azure_security_keyvault::secrets`.

{% include requirement/MUST id="rust-client-immutable" %} ensure that all service client classes thread safe (usually by making them immutable and stateless).

{% include requirement/MUST id="rust-client-endpoint" %} define a public `endpoint(&self) -> &azure_core::Url` method to get the endpoint used to create the client.

#### Service Client Constructors {#rust-client-constructors}

{% include requirement/MUST id="rust-client-constructors-new" %} define a public function `new` that takes the following form and returns `Self` or `azure_core::Result<Self>` if the function may fail.

```rust
impl SecretClient {
    pub fn new(endpoint: impl AsRef<str>, credential: std::sync::Arc<dyn azure_core::TokenCredential>, options: Option<SecretClientOptions>) -> azure_core::Result<Self> {
        let endpoint = azure_core::Url::parse(endpoint.as_ref())?;
        let options = options.unwrap_or_default();
        todo!()
    }
}
```

{% include requirement/MAY id="rust-client-constructors-credential" %} accept a different credential type if the service does not support AAD authentication.

##### Client Configuration {#rust-client-configuration}

{% include requirement/MUST id="rust-client-configuration-name" %} name the client options struct with the same as the client name + "Options" e.g., a `SecretClient` takes a `SecretClientOptions`.

{% include requirement/MUST id="rust-client-configuration-version" %} define a `pub api_version: String` field to pass to the service for all HTTP clients.

{% include requirement/MUST id="rust-client-configuration-core" %} define a `pub options: azure_core::ClientOptions` field to define global configuration shared by all HTTP clients.

{% include requirement/MUST id="rust-client-configuration-clone" %} derive `Clone` to support cloning client configuration for other clients.

{% include requirement/MUST id="rust-client-configuration-default" %} derive `Default` to support creating default client configuration including the default `api-version` used when calling into the service.

The requirements above would define an example client options struct like:

```rust
#[derive(Clone, Default)]
pub struct SecretClientOptions {
    pub api_version: String,
    pub options: azure_core::ClientOptions,
}
```

{% include requirement/MUSTNOT id="rust-client-configuration-env" %} use client library-specific runtime configuration such as environment variables or configuration files. Some environments e.g., WASM or many IoT devices won't have access to an environment block or file system.

{% include requirement/MUSTNOT id="rust-client-configuration-env-sys" %} change the default values of the client options based on system or program state.

{% include requirement/MUSTNOT id="rust-client-configuration-env-build" %} change the default values of the client options based on how the client library was built.

{% include requirement/MUSTNOT id="rust-client-configuration-immutable" %} change the behavior of the client after the client is constructed with the following exceptions:

* Log level, which must take effect immediately across all client libraries.
* Tracing on or off, which must take effect immediately across all client libraries.

##### Service Versions {#rust-client-api-version}

{% include requirement/MUST id="rust-client-api-version-latest" %} call the latest supported service API version by default. Typically this will be the API version from which the client library was generated.

{% include requirement/MUST id="rust-client-api-version-override" %} allow the consumer to explicitly select a supported service API version when instantiating the service client.

##### Mocking {#rust-client-mocking}

{% include requirement/MUST id="rust-client-mocking-trait-name" %} define a trait named after the client name + "Methods" e.g., `SecretClientMethods`.

{% include requirement/MUST id="rust-client-mocking-trait-methods" %} implement all methods of the client methods trait on the client which have the body `unimplemented!()` or `std::future::ready(unimplemented!())` for async methods e.g.,

```rust
pub trait SecretClientMethods {
    fn endpoint(&self) -> &Url {
        unimplemented!()
    }

    async fn set_secret(&self, _name: impl Into<String>, _version: impl Into<String>, _options: Option<SetSecretOptions>) -> azure_core::Result<Response> {
        std::future::ready(unimplemented!())
    }
}

pub struct SecretClient {
    // ...
}

impl SecretClient {
    // pub fn new(..) -> Result<Self>
}

impl SecretClientMethods for SecretClient {
    fn endpoint(&self) -> &Url {
        // ...
    }

    async fn set_secret(&self, _name: impl Into<String>, _version: impl Into<String>, _options: Option<SetSecretOptions>) -> azure_core::Result<Response> {
        // ...
    }
}
```

#### Service Methods {#rust-client-methods}

_Service methods_ are the methods on the client that invoke operations on the service.

##### Sync and Async

The Rust SDK is designed for asynchronous API calls. Customers who need synchronous calls may use something like [`futures::executor::block_on`](https://docs.rs/futures/latest/futures/executor/fn.block_on.html)
to wait synchronously on a `Future`.

{% include requirement/MUST id="rust-client-methods-async-api" %} provide an asynchronous programming model for service methods.

{% include requirement/MUSTNOT id="rust-client-methods-async-api" %} provide a synchronous programming model for service methods.

##### Naming

{% include requirement/MUST id="rust-client-methods-naming-case" %} use snake_case method names converted from likely either camelCase or PascalCase declared in the service specification e.g., `getResource` would be declared as `get_resource`.

{% include requirement/MUST id="rust-client-methods-naming-list" %} use the `list_` prefix for service methods that return one or more pages containing a list of resources e.g., `list_properties_of_secrets()`.

{% include requirement/MUST id="rust-client-methods-naming-conversion-prefix" %} use the following prefixes in the described scenarios:

| Prefix | Scenario | Example |
| ------ | -------- | ------- |
| (none) | field getter | `field_name(&self) -> FieldType` |
| `with_` | field setter returning `Self` - typically used in builders | `with_field_name(&mut self, value: FieldType) -> &mut Self` |
| `set_` | field setter returning nothing or anything else | `set_field_name(&mut self, value: FieldType)` |

##### Cancellation

Cancelling an asynchronous method call in Rust is done by dropping the `Future`.

The Rust `std` crate itself does not implement an async runtime, so different async runtimes must be chosen by the caller and may support cancellation different. `tokio` is common and should be the default, but not required.
Various extensions also exist that the caller may use that may otherwise not work with passing in a cancellation token like in some other Azure SDK languages.

##### Return Types

{% include requirement/MUST id="rust-client-methods-return-result"} return an `azure_core::Result<azure_core::Response>` from an `async fn`.

This is equivalent to returning an `impl Future<Output = azure_core::Result<azure_core::Response>>` from an `fn`.

> TODO: Update when LRO and pageable design guidelines.

##### Thread Safety

{% include requirement/MUST id="rust-client-methods-thread-safety" %} be thread-safe. All public members of the client type must be safe to call from multiple threads concurrently.

#### Service Method Parameters {#rust-parameters}

{% include requirement/MUST id="rust-parameters-self" %} take a `&self` as the first parameter. All service clients must be immutable

{% include requirement/MAY id="rust-parameters-interior-mutability" %} use interior mutability e.g., `std::sync::OnceLock` for single-resource caching e.g., a single key-specific `CryptographyClient` that attempts to download the public key material for subsequent public key operations.

##### Parameter Validation

The service client will have several methods that perform requests on the service. _Service parameters_ are directly passed across the wire to an Azure service. _Client parameters_ are not passed directly to the service, but used within the client library to fulfill the request. Examples of client parameters include values that are used to construct a URI or a file that needs to be uploaded to storage.

{% include requirement/MUST id="rust-parameters-client-validation" %} validate client parameters.

{% include requirement/MUSTNOT id="rust-parameters-server-validation" %} validate service parameters. This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUSTNOT id="rust-parameters-server-defaults" %} encode service parameter default values. These values may change from version to version and may cause unexpected results when calling older versions from a newer client. Let the service apply default parameter values.

{% include requirement/MUST id="rust-parameters-check-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service. If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

#### Methods Returning Collections (Paging) {#rust-paging}

Rust is a lower-level language but often provides higher-level, zero-cost abstractions such as iterators. Iterators are an idiomatic way to enumerate vectors or streams such as `futures::Stream`.

{% include requirement/MUST id="rust-paging-pageable" %} return an `azure_core::Pageable<T>` from pageable service client methods.

{% include requirement/MUST id="rust-paging-pageable-stream" %} implement `futures::Stream` for `azure_core::Pageable<T>`. This defines a `poll_next()` method that returns an `Option<T>` that returns `None` when the consumer has reached the end of the result set. This will enumerate all items for all pages.

{% include requirement/MUST id="rust-paging-pageable-page" %} implement an `to_page(&self) -> &azure_core::Page<T>` for `azure_core::Pageable<T>` that returns the current page of items.

{% include requirement/MUST id="rust-paging-pageable-page-iter" %} implement `IntoIterator` on `azure_core::Page<T>`. This allows customers to enumerate each page separately, and to enumerate each page of items therein.

{% include requirement/MUST id="rust-paging-pageable-page-iter-size" %} implement `Iterator::size_hint()` on the returned `IntoIterator` for `azure_core::Page<T>`.

#### Methods Invoking Long Running Operations {#rust-lro}

> TODO: Review this section

Some service operations, known as _Long Running Operations_ or _LROs_ take a long time (up to hours or days). Such operations do not return their result immediately, but rather are started, their progress is polled, and finally the result of the operation is retrieved.

Azure::Core library exposes an abstract type called `Operation<T>`, which represents such LROs and supports operations for polling and waiting for status changes, and retrieving the final operation result. A service method invoking a long running operation will return a subclass of `Operation<T>`, as shown below.

> TODO: Add operation details.

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

This section describes guidelines for the design _model types_ and all their transitive closure of public dependencies (i.e. the _model graph_). A model type is a representation of a REST service's resource.

{% include requirement/MUST id="rust-design-model-public-getters" %} ensure model public properties are const if they aren't intended to be changed by the user.

Most output-only models can be fully read-only. Models that are used as both outputs and inputs (i.e. received from and sent to the service) typically have a mixture of read-only and read-write properties.

> TODO: This section needs to be driven by code in the Core library.

##### Model Type Naming

> TODO: This section needs to be driven by code in the Core library.

#### Enumerations

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

See [enumeration-like structure documentation](implementation.md#rust-enums) for implementation details.

#### Using Azure Core Types {#rust-core-types}

> TODO: Review this section

The `tbd` package provides common functionality for client libraries. Documentation and usage examples can be found in the [azure/azure-sdk-for-rust](https://github.com/Azure/azure-sdk-for-rust/tree/main/sdk/core) repository.

#### Using Primitive Types

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

### Errors {#rust-errors}

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Rust Errors

### Authentication {#rust-authentication}

> TODO: Review this section

Azure services use a variety of different authentication schemes to allow clients to access the service. Conceptually, there are two entities responsible in this process: a credential and an authentication policy. Credentials provide confidential authentication data. Authentication policies use the data provided by a credential to authenticate requests to the service.

{% include requirement/MUST id="rust-design-logical-client-support-all-auth-techniques" %} support all authentication techniques that the service supports and are available to a client application (as opposed to service side). C is used only for client applications when talking to Azure, so some authentication techniques may not be valid.

{% include requirement/MUST id="rust-design-logical-client-use-azure-core" %} use credential and authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="rust-design-logical-client-prefer-token-auth" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service in a non-blocking atomic manner for each authentication scheme that does not have an implementation in Azure Core.

{% include requirement/MUST id="rust-apisurface-auth-in-constructors" %} provide service client constructors or factories that accept any supported authentication credentials.

{% include requirement/SHOULDNOT id="rust-design-logical-client-surface-no-connection-strings" %} support providing credential data via a connection string. Connection string interfaces should be provided __ONLY IF__ the service provides a connection string to users via the portal or other tooling.

{% include requirement/MUSTNOT id="rust-design-logical-client-surface-no-connection-string-ctors" %} support constructing a service client with a connection string unless such connection string. Provide a `CreateFromConnectionString` static member function which returns a client instead to encourage customers to choose non-connection-string-based authentication.

When implementing authentication, don't open up the consumer to security holes like PII (personally identifiable information) leakage or credential leakage. Credentials are generally issued with a time limit, and must be refreshed periodically to ensure that the service connection continues to function as expected. Ensure your client library follows all current security recommendations and consider an independent security review of the client library to ensure you're not introducing potential security problems for the consumer.

{% include requirement/MUSTNOT id="rust-implementing-no-persistence-auth" %}
persist, cache, or reuse security credentials. Security credentials should be considered short lived to cover both security concerns and credential refresh situations.

If your service implements a non-standard credential system (one that is not supported by Azure Core), then you need to produce an authentication policy for the HTTP pipeline that can authenticate requests given the alternative credential types provided by the client library.

{% include requirement/MUST id="rust-implementing-secure-auth-erase" %} Use a "secure" function to zero authentication or authorization credentials as soon as possible once they are no longer needed. Examples of such functions
include: `SecureZeroMemory`, `memset_s`, and `explicit_bzero`. Examples of insecure functions include `memset`. An optimizer may notice that the credentials are
never accessed again, and optimize away the call to `memset`, resulting in the credentials remaining in memory.

{% include requirement/MUST id="rust-implementing-auth-policy" %}
provide a suitable authentication policy that authenticates the HTTP request in the HTTP pipeline when using non-standard credentials. This includes custom connection strings, if supported.

### Namespaces {#rust-namespace-naming}

{% include requirement/MUST id="rust-namespace-naming-typespec" %} use namespaces as defined by TypeSpecs for the service using all lowercase characters and underscores:

```typespec
namespace Azure.Security.KeyVault;
// crate: azure_security_keyvault
namespace Azure.Security.KeyVault.Secrets {
    // module azure_security_leyvault::secrets
}
```

{% include requirement/SHOULDNOT id="rust-namespace-naming-internals" %} export modules used only within the crate. You may use `pub(crate)` when declaring these modules to export public types within that module to other types and functions within the crate:

```rust
// lib.rs
pub(crate) mod helpers;

// helpers.rs
pub fn helper() {} // not exported publicly
```

### Support for Mocking {#rust-mocking}

In addition to [mocking clients](#rust-client-mocking):

{% include requirement/MUST id="rust-mocking-model-fields" %} declare all model fields public.

{% include requirement/MUST id="rust-mocking-helpers" %} define a `from()` method for all helper types like pageables and LROs that allow callers to return those types from client mocks.

## Azure SDK Library Design

### Packaging {#rust-packaging}

Packages in Rust are called "crates". Crate names follow the same [general guidance on namespaces][general-design-namespaces] using underscores as a separator e.g., `azure_core`, `azure_security_keyvault`, etc.

{% include requirement/MUST id="rust-packaging-prefix" %} start the crate name with `azure_` for data plane crates or `azure_resourcemanager_` for control plane (ARM) crates.

> TODO: Now that [RFC 3243](https://github.com/rust-lang/rfcs/pull/3243) is merged, having already-reserved `azure_mgmt_*` crates matters less; however, we should revisit using "mgmt" if the RFC hasn't been implemented by the time we need it.

{% include requirement/MUST id="rust-packaging-name" %} construct the crate name with all lowercase characters and underscores in the form `azure_<group>_<service>`. Uppercase characters and dashes are not allowed. For example, `azure_security_keyvault`.

Rust does support dashes in crate names, but it may create confusion with customers to reference a crate like `azure-core` then import a module like `azure_core`. Many older crates do this, but the trend has been to use underscores in both cases to avoid confusion.

{% include requirement/MUST id="rust-packaging-registration" %} register the chosen crate name with the [Architecture Board]. Open an issue to request the crate name. See the [registered package list] for a list of the currently registered packages.

{% include requirement/MUST id="rust-packaging-group" %} package different endpoints within a service that version together in a single crate but under separate modules as needed.

Using Key Vault as an example and comparing with other languages like [.NET][dotnet-guidelines]:

* `Azure.Security.KeyVault.Secrets` -> `azure_security_keyvault::secrets`
* `Azure.Security.KeyVault.Keys` -> `azure_security_keyvault::keys`
* `Azure.Security.KeyVault.Certificates` -> `azure_security_keyvault::certificates`

This makes efficient use of generated client code for each services' TypeSpec or OpenAPI specification in a statically-compiled language like Rust.

{% include requirement/MUSTNOT id="rust-packaging-independent" %} package multiple service specifications that version independently within the same crate.

#### Directory Structure

{% include requirement/MUST id="directory-structure-root" %} place all crates' source under the `sdk/` root directory using an appropriate service directory name e.g., `sdk/keyvault`. The service directory name will often match what is in the [Azure/azure-rest-api-specs](https://github.com/Azure/azure-rest-api-specs) repository and will most often be the same across Azure SDK languages.

{% include requirement/MUST id="directory-structure-crate" %} put all crate source within the service directory e.g., `sdk/keyvault/Cargo.toml`.

If you have cause to release separate crates for a single service, please discuss first with the [Architecture Board].

#### Common Libraries

{% include requirement/MUST id="rust-common-macros-review" %} review new macros with your language architect(s).

{% include requirement/MAY id="rust-common-macros-core" %} use common procedural macros from `azure_core`.

### Versioning {#rust-versioning}

#### Client Versions

{% include requirement/MUST id="rust-versioning-backwards-compatibility" %} be 100% backwards compatible with older versions of the same package.

{% include requirement/MUST id="rust-versioning-major-version" %} increase the major semantic version number if an API breaking change is required.

Breaking changes should happen rarely, if ever. Register your intent to do a breaking change with the [Architecture Board]. You'll need to have a discussion with the language architect before approval.

##### Package Version Numbers {#rust-package-versions}

Consistent version number scheme allows consumers to determine what to expect from a new version of the library.

{% include requirement/MUST id="rust-package-versions-semver" %} use _MAJOR_._MINOR_._PATCH_ format for the version of the library dll and the NuGet package.

Use _-beta._N_ suffix for beta package versions. For example, _1.0.0-beta.2_.

{% include requirement/MUST id="rust-package-versions-change-on-release" %} change the version number of the client library when __ANYTHING__ changes in the client library.

{% include requirement/MUST id="rust-package-versions-patching" %} increment the patch version when fixing a bug.

{% include requirement/MUSTNOT id="rust-package-versions-features-in-patch" %} include new APIs in a patch release.

{% include requirement/MUST id="rust-package-versions-add-feature" %} increment the major or minor version when adding support for a service API version.

{% include requirement/MUST id="rust-package-versions-add-api" %} increment the major or minor version when adding a new method to the public API.

{% include requirement/SHOULD id="rust-package-versions-major-changes" %} increment the major version when making large feature changes.

{% include requirement/MUST id="rust-package-versions-change-on-release" %} select a version number greater than the highest version number of any other released Track 1 package for the service in any other scope or language.

### Dependencies {#rust-dependencies}

Dependencies bring in many considerations that are often easily avoided by avoiding the
dependency.

* __Versioning__ - Many programming languages do not allow a consumer to load multiple versions of the same package. So, if we have an client library that requires v3 of package Foo and the consumer wants to use v5 of package Foo, then the consumer cannot build their application. This means that client libraries should not have dependencies by default.
* __Size__ - Consumer applications must be able to deploy as fast as possible into the cloud and move in various ways across networks. Removing additional code (like dependencies) improves deployment performance.
* __Licensing__ - You must be conscious of the licensing restrictions of a dependency and often provide proper attribution and notices when using them.
* __Compatibility__ - Often times you do not control a dependency and it may choose to evolve in a direction that is incompatible with your original use.
* __Security__ - If a security vulnerability is discovered in a dependency, it may be difficult or time consuming to get the vulnerability corrected if Microsoft does not control the dependencies code base.

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

### Documentation Comments {#rust-documentation}

{% include requirement/MUST id="rust-documentation-api" %} document all public APIs prior to General Availability (GA).

{% include requirement/MUST id="rust-documentation-api" %} include the crate `README.md` in the root `lib.rs` to provide an overview of the crate in rendered documentation e.g.:

```rust
// near the top of lib.rs:
#![doc = include_str!("../README.md")]
```

This will impact line numbers, so you should only export APIs publicly from `lib.rs`.

{% include requirement/SHOULD id="rust-documentation-api" %}

## Repository Guidelines {#rust-repository}

{% include requirement/MUST id="rust-general-repository" %} locate all source code and README in the [azure/azure-sdk-for-rust] GitHub repository.

{% include requirement/MUST id="rust-general-engsys" %} follow Azure SDK engineering systems guidelines for working in the [azure/azure-sdk-for-rust] GitHub repository.

> TODO: Content in this section below here should be moved to a better location.

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

### Documentation Style

There are several documentation deliverables that must be included in or as a companion to your client library. Beyond complete and helpful API documentation within the code itself (docstrings), you need a great README and other supporting documentation.

* `README.md` - Resides in the root of your library's directory within the SDK repository; includes package installation and client library usage information.
* `API reference` - Generated from the docstrings in your code; published on docs.microsoft.com.
* `Code snippets` - Short code examples that demonstrate single (atomic) operations for the champion scenarios you've identified for your library; included in your README, docstrings, and Quickstart.
* `Quickstart` - Article on docs.microsoft.com that is similar to but expands on the README content; typically written by your service's content developer.
* `Conceptual` - Long-form documentation like Quickstarts, Tutorials, How-to guides, and other content on docs.microsoft.com; typically written by your service's content developer.

{% include requirement/MUST id="rust-docs-contentdev" %} include your service's content developer in the [Architecture Board] review for your library. To find the content developer you should work with, check with your team's Program Manager.

{% include requirement/MUST id="rust-docs-contributors-guide" %} follow the [Azure SDK Contributors Guide]. (MICROSOFT INTERNAL)

{% include requirement/MUST id="rust-docs-style-guide" %} adhere to the specifications set forth in the Microsoft style guides when you write public-facing documentation. This applies to both long-form documentation like a README and the docstrings in your code. (MICROSOFT INTERNAL)

* [Microsoft Writing Style Guide].
* [Microsoft Cloud Style Guide].

{% include requirement/SHOULD id="rust-docs-to-silence" %} attempt to document your library into silence. Preempt developers' usage questions and minimize GitHub issues by clearly explaining your API in the docstrings. Include information on service limits and errors they might hit, and how to avoid and recover from those errors.

As you write your code, _doc it so you never hear about it again._ The less questions you have to answer about your client library, the more time you have to build new features for your service.

#### Docstrings

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Code snippets

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Buildsystem integration

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Formatting

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

> TODO: Provide Rust specific API design guidelines. Example:

<!-- Links -->

{% include refs.md %}
{% include_relative refs.md %}
