---
title: "Rust Guidelines: Introduction"
keywords: guidelines rust
permalink: rust_introduction.html
folder: rust
sidebar: general_sidebar
---

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

{% include requirement/MUSTNOT id="rust-general-dependencies" %} unconditionally depend on any particular async runtime or HTTP stack.

{% include requirement/SHOULD id="rust-general-dependencies-default" %} depend on `tokio` (async runtime) and `reqwest` (HTTP stack) in the `default` feature for crates e.g.:

```toml
[dependencies]
reqwest = { workspace = true, optional = true }

[features]
default = [ "reqwest" ]
reqwest = [ "dep:reqwest" ]
```

Default features can be ignored by consumers and individual features enabled as needed. This allows consumers to ignore default features and use their own HTTP stack and/or async runtime to implement a client.

{% include requirement/MUSTNOT id="rust-general-unwrap" %} call `unwrap()`, `expect()`, or other functions that may panic unless you are absolutely sure they never will. It's almost always better to use `map()`, `unwrap_or_else()`, or a myriad of related functions to remap errors, return suitable defaults, etc.

{% include requirement/MUSTNOT id="rust-general-prelude" %} define a `prelude` module.

These may lead to name collisions, especially when multiple versions of a crate are imported.

### Support for non-HTTP Protocols

This document contains guidelines developed primarily for typical Azure REST services i.e., stateless services with request-response based interaction model. Many of the guidelines in this document are more broadly applicable, but some might be specific to such REST services.

## Azure SDK API Design {#rust-api}

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.

{% include requirement/MUST id="rust-api-naming-concise" %} use clear, concise, and meaningful names.

{% include requirement/MUST id="rust-api-naming-standard" %} follow [Rust naming conventions][rust-lang-naming].

{% include requirement/SHOULDNOT id="rust-api-naming-abbreviation" %} use abbreviations unless necessary or when they are commonly used and understood. For example, `iot` is used since it is a commonly understood industry term; however, using `kv` for Key Vault would not be allowed since `kv` is not commonly used to refer to Key Vault.

With mixed casing like "IoT", consider the following guidelines:

* For module and method names, always use lowercase e.g., `get_secret()`.
* For type names, use PascalCase e.g., `SecretClient`.

{% include requirement/MUST id="rust-api-dependencies" %} consult the [Architecture Board] if you wish to use a dependency that is not on the list of [centrally managed dependencies][rust-lang-workspace-dependencies].

### Service Client {#rust-client}

Service clients are the main starting points for developers calling Azure services with the Azure SDK. Each client library should have at least one client in its main namespace, so it’s easy to discover. The guidelines in this section describe patterns for the design of a service client.

There exists a distinction that must be made clear with service clients: not all classes that perform HTTP (or otherwise) requests to a service are automatically designated as a service client. A service client designation is only applied to classes that are able to be directly constructed because they are uniquely represented on the service. Additionally, a service client designation is only applied if there is a specific scenario that applies where the direct creation of the client is appropriate. If a resource can not be uniquely identified or there is no need for direct creation of the type, then the service client designation should not apply.

{% include requirement/MUST id="rust-client-name" %} name service client types with the _Client_ suffix e.g., `SecretClient`.

Client names are specific to the service to avoid ambiguity when using multiple clients without requiring `as` to change the binding name when importing e.g.,

```text
error[E0252]: the name `Client` is defined multiple times
  --> src/main.rs:2:38
   |
1  |     use azure_storage_blob::Client;
   |         ----------- previous import of the type `Client` here
2  |     use azure_security_keyvault_secrets::Client;
   |         ^^^^^^^^^^^ `Client` reimported here
   |
```

{% include requirement/MUST id="rust-client-namespace" %} export all service client and their client options that the consumer can create and is most likely to interact with in the root module of the client library e.g., `azure_security_keyvault_secrets`.

{% include requirement/MUST id="rust-client-clients-module" %} export all clients, subclients, and their client options from a `clients` submodule of the crate root e.g., `azure_security_keyvault_secrets::clients`. Clients that can be created directly as described above should be re-exported from the crate root.

{% include requirement/MUST id="rust-client-models-module" %} export all models and client method options from a `models` submodule of the crate root e.g., `azure_security_keyvault_secrets::models` e.g.,

```rust
// lib.rs
pub mod clients;
pub mod models;

pub use clients::SecretClient;
```

See [Rust modules][rust-modules] for more information.

{% include requirement/MUST id="rust-client-immutable" %} ensure that all service client methods are thread safe (usually by making them immutable and stateless).

{% include requirement/MUST id="rust-client-endpoint" %} define a public `endpoint(&self) -> &azure_core::Url` method to get the endpoint used to create the client.

{% include requirement/MUST id="rust-client-internal-fields" %} define all fields within a client struct with `pub(crate)` accessibility. This allows the fields e.g., the `pipeline`, to be used in [convenience clients' extension methods][rust-client-convenience].

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

{% include requirement/MUST id="rust-client-constructors-multiple-credentials" %} define a `new` function that takes a `TokenCredential` and a `with_{credential_type}` function e.g., `with_key_credential` if a client supports both AAD authentication and other token credentials that do not implement `TokenCredential`.

In cases when different credential types are supported, we want the primary use case to support AAD authentication over other authentication schemes.

##### Client Configuration {#rust-client-configuration}

Client options should be plain old data structures to allow easy, idiomatic creation of options and to easily share these options across multiple clients as needed.

{% include requirement/MUST id="rust-client-configuration-name" %} define a client options struct with the same as the client name + "Options" e.g., a `SecretClient` takes a `SecretClientOptions`.

{% include requirement/SHOULD id="rust-client-configuration-namespace" %} export client option structs from the same module(s) from which clients and subclients are exported e.g., `azure_security_keyvault_secrets` and `azure_security_keyvault_secrets::clients` for `SecretClient`.

See [Rust modules][rust-modules] for more information.

{% include requirement/MUST id="rust-client-configuration-fields" %} define all client-specific fields of client option structs as public and of type `Option<T>` except for `api_version` of type `String`, if applicable.

{% include requirement/MUST id="rust-client-configuration-fields-options" %} define an `client_options: azure_core::ClientOptions` public field.

{% include requirement/MUST id="rust-client-configuration-clone" %} derive `Clone` to support cloning client configuration for other clients.

{% include requirement/SHOULDNOT id="rust-client-configuration-debug" %} derive `Debug` since this may inadvertently leak PII. Derive [`azure_core::fmt::SafeDebug`][rust-safety-debug] instead.

{% include requirement/MUST id="rust-client-configuration-default" %} implement `Default` to support creating default client configuration including the default `api_version` used when calling into the service.

The requirements above would define an example client options struct like:

```rust
use azure_core::{ClientOptions, fmt::SafeDebug};

#[derive(Clone, SafeDebug)]
pub struct SecretClientOptions {
    pub api_version: String,
    pub client_options: ClientOptions,
}

impl Default for SecretClientOptions {
    fn default() -> Self {
        Self {
            api_version: "7.5".to_string(),
            options: ClientOptions::default(),
        }
    }
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

{% include requirement/MUST id="rust-client-api-version-override" %} allow the consumer to explicitly set a service API version when instantiating the service client.

##### Mocking {#rust-client-mocking}

> We are reevaluating options for mocking to provide the best experience for API consumers whether or not they plan to utilize mocks or fakes.

#### Service Methods {#rust-client-methods}

{% include requirement/MUST id="rust-client-methods" %} take a `body: RequestContent<T>` if and only if the service method accepts a request body e.g., `POST` or `PUT`.

{% include requirement/MUST id="rust-client-methods-params" %} use the service specified name of all parameters.

{% include requirement/MUST id="rust-client-methods-configuration-name" %} define a client method options struct with the same name as the client, client method name, and "Options" e.g., a `set_secret` takes an `Option<SecretClientSetSecretOptions>` as the last parameter.
This is required even if the service method does not currently take any options because - should it ever add options - the client method signature does not have to change and will not break callers.

{% include requirement/MUST id="rust-client-methods-configuration-namespace" %} export client method option structs from the `models` module e.g., `azure_security_keyvault_secrets::models`.

See [Rust modules][rust-modules] for more information.

{% include requirement/MUST id="rust-client-methods-configuration-fields" %} define all client method-specific fields of method option structs as public and of type `Option<T>`.

{% include requirement/MUST id="rust-client-methods-configuration-fields-options" %} define a `method_options: azure_core::ClientMethodOptions` public field.

{% include requirement/MUST id="rust-client-methods-configuration-clone" %} derive `Clone` to support cloning method configuration for additional client method invocations.

{% include requirement/MUST id="rust-client-methods-configuration-debug" %} derive `Debug` since this may inadvertently leak PII. Derive [`azure_core::fmt::SafeDebug`][rust-safety-debug] instead.

{% include requirement/MUST id="rust-client-methods-configuration-default" %} derive or implement `Default` to support creating default method configuration.

The requirements above would define an example client options struct like:

```rust
use azure_core::{ClientMethodOptions, fmt::SafeDebug};

impl SecretClientMethods for SecretClient {
    async fn set_secret(
        &self,
        name: &str,
        options: Option<SecretClientSetSecretOptions>,
    ) -> azure_core::Result<Response<KeyVaultSecret>> {
        todo!()
    }
}

#[derive(Clone, SafeDebug, Default)]
pub struct SecretClientSetSecretOptions {
    pub enabled: Option<bool>,
    pub method_options: ClientMethodOptions,
}
```

##### Sync and Async {#rust-client-methods-async}

The Rust SDK is designed for asynchronous API calls. Customers who need synchronous calls may use something like [`futures::executor::block_on`](https://docs.rs/futures/latest/futures/executor/fn.block_on.html)
to wait synchronously on a `Future`.

{% include requirement/MUST id="rust-client-methods-async-api" %} provide an asynchronous programming model for service methods.

{% include requirement/MUSTNOT id="rust-client-methods-async-nosync" %} provide a synchronous programming model for service methods.

##### Naming {#rust-client-methods-naming}

{% include requirement/MUST id="rust-client-methods-naming-case" %} use snake_case method names converted from likely either camelCase or PascalCase declared in the service specification e.g., `getResource` would be declared as `get_resource`.

{% include requirement/MUST id="rust-client-methods-naming-verbs" %} use the following verb patterns for CRUD operations:

| Pattern       | HTTP Method  | Comments
| ------------- | ------------ | --------
| add_{noun}    | POST or PUT  | Add a resource to a collection. Fails if the resource exists.
| delete_{noun} | DELETE       | Delete a resource. Does not fail if the resource does not exist.
| get_{noun}    | GET          | Get a resource. Fails if the resource does not exist.
| list_{noun}   | GET          | {#rust-client-methods-naming-list} Get a collection of resources. May be in zero or may pages of results. Returns an empty list if no resources exist.
| {noun}_exists | GET or HEAD  | Check if a resource exists.
| set_{noun}    | POST or PUT  | Adds a new or updates an existing resource.
| update_{noun} | PATCH or PUT | Updates existing resources. Fails if resource does not exist.

{% include requirement/MUST id="rust-client-methods-naming-conversion-prefix" %} use the following prefixes in the described scenarios:

| Prefix | Scenario | Example |
| ------ | -------- | ------- |
| (none) | field getter | `field_name(&self) -> FieldType` |
| `with_` | [non-default constructor](#rust-client-constructors-multiple-credentials) or field setter returning `Self` - typically used in builders | `with_field_name(&mut self, value: FieldType) -> &mut Self` |
| `set_` | field setter returning nothing or anything else | `set_field_name(&mut self, value: FieldType)` |

##### Operation Options {#rust-client-methods-options}

{% include requirement/MUST id="rust-client-methods-options-separate" %} separate the `Context` containing client method options from service method options. See [example](#rust-client-methods) above.

The `azure_core::Pipeline` is constructed when the service client constructed, and because the clients must be immutable the pipeline cannot be altered directly.
Any data passed to client methods to alter the pipeline e.g., retry policy options, must be passed to pipeline policies via the `Context`.

{% include requirement/MUST id="rust-client-methods-options-context" %} pass pipeline policy options in the `Context` passed to each pipeline policy.

{% include requirement/MUST id="rust-client-methods-options-pipeline" %} clone the `azure_core::Pipeline` if the list of pipeline policies is altered by a client method e.g., a custom pipeline policy is added per-call.

{% include requirement/MAY id="rust-client-methods-options-api-version" %} allow the caller to change the API version e.g., `api-version` when calling the endpoint.

##### Return Types {#rust-client-methods-return}

{% include requirement/MUST id="rust-client-methods-return-pageable" %} return an `azure_core::Result<azure_core::Pager<T>>` from an `async fn` when the service returns a [pageable response](#rust-paging).

{% include requirement/MUST id="rust-client-methods-return-lro" %} return an `azure_core::Result<azure_core::Poller<T>>` from an `async fn` when the service implements the operation a [long-running operation](#rust-lro).

{% include requirement/MUST id="rust-client-methods-return-result" %} return an `azure_core::Result<azure_core::Response<T, F>>` from an `async fn` for all other service responses.
If the service method does not return any content e.g., HTTP 204, the client method should return a `Result<Response<(), NoFormat>>` containing the `()` unit type.
If the service method returns binary data, the client method should return a `Result<Response<Byte, NoFormat>>`.

Most services return JSON corresponding to the `JsonFormat` type for the `F` type parameter, which can be elided since `JsonFormat` is the default.

{% include requirement/MUST id="rust-client-methods-return-raw-response" %} provide the status code, headers, and self-consuming async raw response stream from all return types e.g.,

``` rust
impl<T, F> Response<T, F> {
    pub fn status(&self) -> &StatusCode {
        todo!()
    }

    pub fn headers(&self) -> &Headers {
        todo!()
    }

    pub async fn into_content(self) -> ResponseContent {
        todo!()
    }
}
```

This is equivalent to returning an `impl Future<Output = azure_core::Result<azure_core::Response<T, F>>>` from an `fn`.

{% include requirement/MUST id="rust-client-methods-return-headers-methods" %} must export extension method traits for defined headers from the `models` module on `Response<T, F>` where `T` is a model type and `F` represents the format e.g., `JsonFormat` (default).
If the method does not return a model and would otherwise return the unit type `Response<(), NoFormat>`, you should instead return an empty struct using the same naming convention has options: client name + method name + "Result" e.g.,

```rust
#[derive(SafeDebug)]
pub struct SecretClientSetSecretResult;
```

This should be treated as a model, so derive the same traits and export from `models` as you would any other model.

{% include requirement/MUST id="rust-client-methods-return-headers-methods-name" %} name the trait similar to options: client name + method name + "ResultHeaders" e.g., `SecretClientSetSecretResultHeaders`.

{% include requirement/MUST id="rust-client-methods-return-headers-methods-return" %} return an `azure_core::Result<Option<T>>` where `T` is an appropriate type for the header e.g., `usize` for `content-length`, `azure_core::Etag` for etags, etc.
The implementation can simply call methods like `Headers::get_optional_as()` or `Headers::get_optional_string()` as appropriate.

{% include requirement/MUST id="rust-client-methods-return-headers-methods-sealed" %} seal the trait to prevent it from being implemented by other types as shown in the example below.
Implementations should use a single definition of `private::Sealed` for all such traits that require it.

```rust
pub trait SecretClientSetSecretResultHeaders: private::Sealed {
    fn content_type_header(&self) -> azure_core::Result<Option<String>>;
}

impl SecretClientSetSecretResultHeaders for Response<SecretClientSetSecretResult> {
    fn content_type_header(&self) -> azure_core::Result<Option<String>> {
        Ok(self.headers().get_optional_string(&headers::CONTENT_TYPE))
    }
}

mod private {
    pub trait Sealed {}
    impl Sealed for Response<SecretClientSetSecretResult> {}
}
```

##### Cancellation {#rust-client-methods-cancellation}

Cancelling an asynchronous method call in Rust is done by dropping the `Future`.

The Rust `std` crate itself does not implement an async runtime, so different async runtimes must be chosen by the caller and may support cancellation different. `tokio` is common and should be the default, but not required.
Various extensions also exist that the caller may use that may otherwise not work with passing in a cancellation token like in some other Azure SDK languages.

#### Service Method Parameters {#rust-parameters}

{% include requirement/MUST id="rust-parameters-self" %} take a `&self` as the first parameter. All service clients must be immutable

{% include requirement/MUST id="rust-parameters-into" %} declare parameter types as reference types e.g., `&str` (or any reference to type `&T`)` when the data only needs to be borrowed e.g., a URL parameter.

```rust
impl SecretClient {
    pub fn new(endpoint: &str) -> Result<Self> {
        let endpoint = azure_core::Url::parse(endpoint)?;

        todo!()
    }
}
```

The `endpoint` parameter is never saved so a reference is fine. Except for possible body parameters, any parameter should typically be borrowed since required parameters comprise URL path segments or query parameters.

{% include requirement/MUST id="rust-parameters-request-content" %} declare a parameter named `content` of type `RequestContent<T>`, where `T` is the service-defined request model.

{% include requirement/MUST id="rust-parameters-request-content-convert" %} support converting to a `RequestContent<T>` from a `T`, `Stream`, or `AsRef<str>`.

{% include requirement/MAY id="rust-parameters-interior-mutability" %} use interior mutability e.g., `std::sync::OnceLock` for single-resource caching e.g., a single key-specific `CryptographyClient` that attempts to download the public key material for subsequent public key operations.

##### Parameter Validation {#rust-parameters-validation}

The service client will have several methods that perform requests on the service. _Service parameters_ are directly passed across the wire to an Azure service. _Client parameters_ are not passed directly to the service, but used within the client library to fulfill the request. Examples of client parameters include values that are used to construct a URI or a file that needs to be uploaded to storage.

{% include requirement/MUST id="rust-parameters-validation-client" %} validate client parameters.

{% include requirement/MUSTNOT id="rust-parameters-validation-server" %} validate service parameters. This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUSTNOT id="rust-parameters-validation-server-defaults" %} encode service parameter default values. These values may change from version to version and may cause unexpected results when calling older versions from a newer client. Let the service apply default parameter values.

{% include requirement/MUST id="rust-parameters-validation-check-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service. If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

#### Methods Returning Collections (Paging) {#rust-paging}

Rust is a lower-level language but often provides higher-level, zero-cost abstractions such as iterators. Iterators are an idiomatic way to enumerate vectors or streams such as `futures::Stream`.

{% include requirement/MUST id="rust-paging-pageable-page-trait" %} implement the `azure_core::http::pager::Page` trait on a pageable type that returns the pageable items for a page of items.

{% include requirement/MUST id="rust-paging-pageable" %} return an `azure_core::http::Pager<T>` from pageable service client methods where `T` is model type being enumerated.

{% include requirement/MUST id="rust-paging-pageable-stream" %} implement `futures::Stream` for `azure_core::http::pager::Pager<T>`. This defines a `poll_next()` method that returns an `Option<T>` that returns `None` when the consumer has reached the end of the result set. This will enumerate all items for all pages.

{% include requirement/MUST id="rust-paging-pageable-page" %} implement an `into_pages(self) -> &azure_core::http::pager::PageIterator<T>` for `azure_core::http::pager::Pager<T>` that returns the current page of items.

{% include requirement/MUST id="rust-paging-pageable-page-iter" %} implement `IntoIterator` on `azure_core::http::pager::PageIterator<T>`. This allows customers to enumerate each page separately, and to enumerate each page of items therein.

{% include requirement/MUST id="rust-paging-pageable-page-iter-size" %} implement `Iterator::size_hint()` on the returned `IntoIterator` for `azure_core::http::pager::PageIterator<T>`.

{% include requirement/MUST id="rust-paging-pageable-restart" %} support reconstructing an `azure_core::http::pager::Pager<T>` so that a caller can start paging from a previous state.

#### Methods Invoking Long-running Operations {#rust-lro}

Some service operations, known as [_Long-running Operations_][rest-lro] or _LROs_ take a long time to execute - up to hours or even days. Such operations do not return their result immediately but rather are started and their progressed polled until the operation reaches a terminal state including `Succeeded`, `Failed`, or `Canceled`.

The `azure_core` crate exposes an abstract type called `azure_core::http::poller::Poller<T>`, which represents LROs and supports operations for polling and waiting for status changes, and retrieving the final operation result. A service method invoking a long-running operation will return an `azure_core::http::poller::Poller<T>` as described below.

{% include requirement/MUST id="rust-lro-prefix" %} name all methods that start an LRO with the `begin_` prefix.

{% include requirement/MUST id="rust-lro-stream" %} implement `futures::Stream` for `azure_core::http::poller::Poller<T>`. This defines a `poll_next()` method that returns an `Option<T>` that returns `None` when the polling has terminated.

{% include requirement/MUST id="rust-lro-restart" %} support reconstructing an `azure_core::http::poller::Poller<T>` so that a caller can start polling from a previous state.

##### Conditional Request Methods {#rust-etag}

{% include requirement/MUST id="rust-etag-options" %} define ETag-related options e.g., `if_match`, `if_none_match`, etc., in the service method options e.g.:

```rust
use azure_core::SafeDebug;

#[derive(Clone, SafeDebug)]
pub struct SetSecretOptions {
    enabled: Option<bool>,
    if_match: Option<azure_core::ETag>,
}
```

##### Hierarchical Clients {#rust-subclients}

Subclients can only be returned by other clients and cannot be constructed by developers using our crates. See [General Azure SDK Terminology] general guidelines.

{% include requirement/MAY id="rust-subclients-return" %} return clients from other clients e.g., a `DatabaseClient` from a `CosmosClient`.

{% include requirement/MUSTNOT id="rust-subclients-create" %} define constructors on subclients. They must be constructed only from other clients.

{% include requirement/MUST id="rust-subclients-suffix" %} name all client methods returning a client with the `_client` suffix e.g., `CosmosClient::database_client()`.

{% include requirement/MUSTNOT id="rust-subclients-export" %} export subclients from the crate root. They should be exported from a `clients` submodule of the crate root example `azure_security_keyvault_secrets::clients`.

See [Rust modules][rust-modules] for more information.

{% include requirement/MUSTNOT id="rust-subclients-noasync" %} define client methods returning a client as asynchronous.

{% include requirement/MUST id="rust-subclients-pipeline" %} clone the parent client `azure_core::Pipeline` so that lifetime parameters and guarantees are not required.

### Supporting Types

In addition to service client types, Azure SDK APIs provide and use other supporting types as well.

#### Model Types {#rust-model-types}

This section describes guidelines for the design _model types_ and all their transitive closure of public dependencies (i.e. the _model graph_). A model type is a representation of a REST service's resource.

{% include requirement/MUST id="rust-model-types-derive" %} derive or implement `Clone` and `Default` for all model structs.

{% include requirement/MUST id="rust-model-types-serde" %} derive or implement `serde::Serialize` and/or `serde::Deserialize` as appropriate i.e., if the model is input (serializable), output (deserializable), or both.

{% include requirement/MUST id="rust-model-types-public" %} define all fields as `pub`.

{% include requirement/MUST id="rust-model-types-optional" %} define all non-vector fields using `Option<T>`.

{% include requirement/MUST id="rust-model-types-vectors" %} define all vector fields as `Vec<T>`.
These must deserialize as empty (non-allocating) if the vector they are deserializing is missing or empty, and should serialize as empty except in JSON merge+patch payloads.

Though uncommon, service definitions do not always match the service implementation when it comes to required fields. Upon the recommendation of the Breaking Change Reviewers, the specification is often changed to reflect the service if the service has already been deployed.

{% include requirement/MUST id="rust-model-types-serde-optional" %} attribute fields with `#[serde(skip_serializing_if = "Option::is_none")]` unless an explicit `null` must be serialized.

{% include requirement/MUST id="rust-model-types-non-exhaustive" %} attribute response-only model structs with `#[non_exhaustive]`.

This forces all downstream crates, for example, to use the `..` operator to match any remaining fields that may be added in the future for pattern binding:

```rust
// struct Example {
//     pub foo: Option<String>,
//     pub bar: Option<i32>,
// }

let { foo, bar, .. } = client.method().await?.try_into()?;
```

{% include requirement/MUSTNOT id="rust-model-types-not-non-exhaustive" %} attribute request-only or request-response model structs with `#[non_exhaustive]`.

This prevents downstream crates from creating types even when using the `..Default::default()` expression, which means developers cannot construct models as plain data objects.

See [RFC 2008][rust-lang-rfc-2008] for more information.

##### Model Type Naming {#rust-model-names}

{% include requirement/MUST id="rust-model-names-type" %} define models using the names from TypeSpec unless those names conflict with keywords or common types from `std`, `futures`, or other common dependencies.

If name collisions are likely and the TypeSpec cannot be changed, you can either use the `@clientName` TypeSpec decorator or update a client `.tsp` file.

{% include requirement/MUST id="rust-model-names-fields" %} define model fields using "camelCase".

To facilitate this, attribute the model type:

```rust
#[derive(serde::Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Example {
    pub compound_name: String, // -> "compoundName"
}
```

{% include requirement/MUSTNOT id="rust-model-names-rename" %} rename fields using the `#[serde]` attribute or by other means. All model changes must only be done in TypeSpec.

##### Builders {#rust-builders}

Though we prefer a `new()` constructor function to create instances, builders are still an idiomatic pattern in Rust, such as the [typestate builder pattern][rust-lang-typestate] that can help guide developers into constructing a valid type variants.

{% include requirement/MAY id="rust-builders-support" %} implement builders for special cases e.g., URI builders.

If you do implement a builder, it must be defined according to the following guidelines:

{% include requirement/MUST id="rust-builders-factory" %} define a `builder()` factory method on the type to be constructed that returns a struct with the same as the type + "Builder" e.g., `Model::builder()` returns a `ModelBuilder`.

{% include requirement/MUST id="rust-builders-self" %} consume `mut self` in `with_` setter methods and return `Self` except in the final `build(&self)` method.

{% include requirement/MUST id="rust-builders-return" %} return an owned value from the final `build(&self)` method.

{% include requirement/MUST id="rust-builders-return-params" %} define required parameters in the final `build(&self)` method if not using a typestate pattern e.g., `build(&self, endpoint: &str)`.

#### Enumerations {#rust-enums}

{% include requirement/MUST id="rust-enums-names" %} implement all enumeration variations as PascalCase.

{% include requirement/MUST id="rust-enums-derive" %} derive or implement `Clone`, `Eq`, and `PartialEq` for all enums.

{% include requirement/SHOULDNOT id="rust-enums-debug" %} derive `Debug` since this may inadvertently leak PII. Derive [`azure_core::fmt::SafeDebug`][rust-safety-debug] instead.

{% include requirement/MUST id="rust-enums-derive-copy" %} derive `Copy` for all fixed enums.

{% include requirement/MUST id="rust-enums-serde" %} derive or implement `serde::Serialize` and/or `serde::Deserialize` as appropriate i.e., if the enum is used in input (serializable), output (deserializable), or both.

{% include requirement/MUST id="rust-enums-non-exhaustive" %} attribute all enums with `#[non_exhaustive]`.

This forces all downstream crates, for example, to use the `_` match arm to match any remaining enums that may be added in the future for pattern binding:

```rust
// enum Example {
//     Foo,
//     Bar,
// }

let value = match model.kind {
    Example:Foo => todo!(),
    Example::Bar => todo!(),
    _ => todo!(),
};
```

This is necessary for both fixed enums and extensible enums since new variants may be added and matched during deserialization.

See [RFC 2008][rust-lang-rfc-2008] for more information.

{% include requirement/MUST id="rust-enum-fixed" %} implement all fixed enumerations using only defined variants:

```rust
use azure_core::SafeDebug;

#[derive(Clone, Copy, SafeDebug, Eq, PartialEq, Deserialize, Serialize)]
#[non_exhaustive]
pub enum FixedEnum {
    #[serde(rename = "foo")]
    Foo,
    #[serde(rename = "bar")]
    Bar,
}
```

{% include requirement/MUST id="rust-enum-extensible" %} implement all extensible enumerations - those which may take a variant that is not defined - using defined variants and an untagged `UnknownValue`:

```rust
use azure_core::SafeDebug;

#[derive(Clone, SafeDebug, Eq, PartialEq, Deserialize, Serialize)]
#[non_exhaustive]
pub enum ExtensibleEnum {
    #[serde(rename = "foo")]
    Foo,
    #[serde(rename = "bar")]
    Bar,
    #[serde(untagged)]
    UnknownValue(String),
}
```

{% include requirement/MAY id="rust-enum-serialize" %} implement `serde::Deserialize`, `serde::Serialize`, or both as appropriate depending on whether the enumeration is found only in responses, requests, or both, respectively.

{% include requirement/SHOULD id="rust-enum-generated-attributes" %} define variant attribute `#[serde(rename = "name")]` for generated code for each variant.

{% include requirement/MAY id="rust-enum-convenience-attributes" %} use container attribute `#[serde(rename_all = "camelCase")]` for convenience layers, or whatever casing is appropriate.

#### Using Azure Core Types {#rust-core-types}

The `azure_core` package provides common functionality for client libraries. Documentation and usage examples can be found in the [Azure/azure-sdk-for-rust](https://github.com/Azure/azure-sdk-for-rust/tree/main/sdk/core) repository.

### Errors {#rust-errors}

{% include requirement/MUST id="rust-errors-core" %} return an `azure_core::Result<T>` which uses `azure_core::Error`.

{% include requirement/MUST id="rust-errors-core-methods" %} call appropriate methods on `azure_core::Error` to wrap or otherwise convert to an appropriate `azure_core::ErrorKind`.

{% include requirement/MAY id="rust-errors-into" %} implement `Into<azure_core::Error>` for any other error type returned by functions you call if not already defined to support the `?` operator.

Since your crate will define neither `azure_core::Error` or likely the error being returned to you from another dependency, you will need to use the [newtype][rust-lang-newtype] idiom e.g.:

```rust
#[derive(Debug)]
pub struct Error(dependency::Error);

impl std::error::Error for Error {
    fn source(&self) -> Option<&(dyn Error + 'static)> {
        self.0.source()
    }
}

impl std::fmt::Display for Error {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        self.0.fmt(f)
    }
}

impl Into<azure_core::Error> for Error {
    fn into(self) -> azure_core::Error {
        azure_core::Error::new(azure_core::ErrorKind::Other, Box::new(self))
    }
}
```

### Authentication {#rust-authentication}

Azure services use a variety of different authentication schemes to allow clients to access the service. Conceptually, there are two entities responsible in this process: a credential and an authentication policy. Credentials provide confidential authentication data. Authentication policies use the data provided by a credential to authenticate requests to the service.

{% include requirement/MUST id="rust-authentication-all-supported-schemes" %} support all authentication schemes supported by the service and implemented in `azure_core` and `azure_identity`.

{% include requirement/SHOULD id="rust-authentication-azure-core" %} use only credentials and authentication policies defined in `azure_core`.

Crates support different types of [dependencies][rust-lang-dependencies] e.g., `[dependencies]` for code linked into applications and `[dev-dependencies]` used for tests, examples, etc.

{% include requirement/MUSTNOT id="rust-authentication-azure-identity-dependency" %} take a dependency on `azure_identity`.

{% include requirement/MAY id="rust-authentication-azure-identity-dev-dependency" %} take a development dependency on `azure_identity` for tests and examples.

{% include requirement/MUST id="rust-authentication-prefer-token-auth" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service in a non-blocking atomic manner for each authentication scheme that does not have an implementation in `azure_core`.

{% include requirement/MUST id="rust-authentication-constructors" %} provide service client constructors or factories that accept any supported authentication credentials.

{% include requirement/SHOULDNOT id="rust-authentication-connection-strings" %} support providing credential data via a connection string. Connection string interfaces should be provided __ONLY IF__ the service provides a connection string to users via the Portal or other tooling. Use a `with_connection_string()` function to construct a client in that case e.g.:

```rust
impl ExampleClient {
    pub fn with_connection_string(connection_string: &str, options: Option<ExampleClientOptions>) {
        todo!()
    }
}
```

When implementing authentication, don't open up the consumer to security holes like PII (personally identifiable information) leakage or credential leakage. Credentials are generally issued with a time limit and must be refreshed periodically to ensure that the service connection continues to function as expected. Ensure your client library follows all current security recommendations and consider an independent security review of the client library to ensure you're not introducing potential security problems for the consumer.

{% include requirement/MUSTNOT id="rust-authentication-persistence" %} persist, cache, or reuse security credentials. Security credentials should be considered short lived to cover both security concerns and credential refresh situations.

If your service implements a non-standard credential system - one not supported by `azure_core` - then you need to implement an authentication policy for the HTTP pipeline that can authenticate requests given the alternative credential types provided by the client library.

{% include requirement/MAY id="rust-authentication-custom" %} implement an authentication policy and credential in a client library crate if the authentication scheme is supported only by the service.

{% include requirement/MUST id="rust-authentication-erase" %} securely free and zero authentication tokens and other credential data as soon as they are no longer needed.

### Namespaces {#rust-namespace-naming}

{% include requirement/MUST id="rust-namespace-naming-typespec" %} use namespaces as defined by TypeSpecs for the service using all lowercase characters and underscores:

```typespec
namespace Azure.Security.KeyVault;
// crate: azure_security_keyvault
namespace Azure.Security.KeyVault.Secrets {
    // module azure_security_keyvault_secrets
}
```

{% include requirement/SHOULDNOT id="rust-namespace-naming-internals" %} export modules used only within the crate. You may use `pub(crate)` when declaring these modules to export public types within that module to other types and functions within the crate:

```rust
// lib.rs
pub(crate) mod helpers;

// helpers.rs
pub fn helper() {} // not exported publicly
```

## Azure SDK Library Design

### Packaging {#rust-packaging}

Packages in Rust are called "crates". Crate names follow the same [general guidance on namespaces][general-design-namespaces] using underscores as a separator e.g., `azure_core`, `azure_security_keyvault`, etc.

{% include requirement/MUST id="rust-packaging-prefix" %} start the crate name with `azure_` for data plane crates or `azure_resourcemanager_` for control plane (ARM) crates.

> TODO: Now that [RFC 3243](https://github.com/rust-lang/rfcs/pull/3243) is merged, having already-reserved `azure_mgmt_*` crates matters less; however, we should revisit using "mgmt" if the RFC hasn't been implemented by the time we need it.

{% include requirement/MUST id="rust-packaging-name" %} construct the crate name with all lowercase characters and underscores in the form `azure_<group>_<service>`. Uppercase characters and dashes are not allowed. For example, `azure_security_keyvault`.

Rust does support dashes in crate names, but it may create confusion with customers to reference a crate like `azure-core` then import a module like `azure_core`. Many older crates do this, but the trend has been to use underscores in both cases to avoid confusion.

{% include requirement/MUST id="rust-packaging-feature-name" %} use underscores, when necessary, in feature names e.g., `reqwest_rustls` to enable the `reqwest`-based HTTP client with `rustls` support for TLS.

Dashes are supported in feature names as well as crate names, but using underscores in both crate names and feature names provides a consistent experience for developers.

{% include requirement/MUST id="rust-packaging-registration" %} register the chosen crate name with the [Architecture Board]. Open an issue to request the crate name. See the [registered package list] for a list of the currently registered packages.

{% include requirement/MUST id="rust-packaging-project" %} define a separate crate for each [TypeSpec project][rust-lang-typespec-config] within a service directory e.g.,

* `specification/keyvault/data-plane/Microsoft.KeyVault/Security.KeyVault.Secrets` -> `sdk/keyvault/azure_security_keyvault_secrets`
* `specification/keyvault/data-plane/Microsoft.KeyVault/Security.KeyVault.Keys` -> `sdk/keyvault/azure_security_keyvault_keys`
* `specification/keyvault/data-plane/Microsoft.KeyVault/Security.KeyVault.Certificates` -> `sdk/keyvault/azure_security_keyvault_certificates`

{% include requirement/MAY id="rust-packaging-common-project" %} define a common crate under the service directory that all service client crates use. Unless there's a name conflict, this should use the "common" suffix e.g., `azure_security_keyvault_common`. The API must be public but you **MAY** document that those APIs are not intended for public use, similar to some other languages' common libraries.

{% include requirement/MUSTNOT id="rust-packaging-independent" %} package multiple service specifications that version independently within the same crate.

#### Directory Structure

{% include requirement/MUST id="directory-structure-root" %} place all service directories under the `sdk/` root directory e.g., `sdk/keyvault`. The service directory name will often match what is in the [Azure/azure-rest-api-specs](https://github.com/Azure/azure-rest-api-specs) repository and will most often be the same across Azure SDK languages.

{% include requirement/MUST id="directory-structure-crate" %} put all crate source under the service directory in a subdirectory using the name of the crate e.g., `sdk/keyvault/azure_security_keyvault_secrets/Cargo.toml`. This crate directory should correspond to a TypeSpec project and the crate name configured in the TypeSpec project's [`tspconfig.yaml`][rust-lang-typespec-config].

{% include requirement/SHOULD id="directory-structure-lib" %} only export public APIs from the crate `lib.rs` and define all other types in suitable [modules][rust-lang-modules]:

{% include requirement/MUSTNOT id="directory-structure-build-script" %} include a `build.rs` build script in the crate root.

* Single-file modules should be declared in a file next to their parent module.
* Multi-file modules should be declared in a directory next to their parent module with a `mod.rs` file.

For example:

```text
src/
  policies/
    client_id.rs
    mod.rs
    retry.rs
    transport.rs
  error.rs
  lib.rs
Cargo.lock
Cargo.toml
```

You can find a complete example of our directory structure in our [implementation documentation][rust-directories].

#### Common Libraries

{% include requirement/MUST id="rust-common-macros-review" %} review new macros with your language architect(s).

{% include requirement/MAY id="rust-common-macros-core" %} use common procedural macros from `azure_core`.

### Versioning {#rust-versioning}

#### Client Versions

{% include requirement/MUST id="rust-versioning-backwards-compatibility" %} be 100% backwards compatible with older versions of the same package.

{% include requirement/MUST id="rust-versioning-major-version" %} increase the major semantic version number if an API breaking change is required.

See <https://semver.org> for more information.

{% include requirement/MUST id="rust-versioning-breaking-change-review" %} discuss breaking changes with the language architect before making changes.

Note there are different types of breaking changes:

1. The service introduced breaking changes that the client library must reflect in code. Approval may still be required, but should not burden code owner(s).
2. The client library introduced breaking changes for good reason.

Breaking changes introduced by the client library should happen rarely, if ever. Register your intent to make client breaking changes with the [Architecture Board].

##### Package Version Numbers {#rust-package-versions}

Consistent version number scheme allows consumers to determine what to expect from a new version of the library.

{% include requirement/MUST id="rust-package-versions-semver" %} use _MAJOR_._MINOR_._PATCH_ format for the version of the crate.

Use _-beta._N_ suffix for beta package versions. For example, _1.0.0-beta.2_.

See <https://semver.org> for more information.

{% include requirement/MUST id="rust-package-versions-change-on-release" %} change the version number of the client library when __ANYTHING__ changes in the client library.

{% include requirement/MUST id="rust-package-versions-patching" %} increment the patch version when fixing a bug.

{% include requirement/MUSTNOT id="rust-package-versions-features-in-patch" %} include new APIs in a patch release.

{% include requirement/MUST id="rust-package-versions-add-feature" %} increment the major or minor version when adding support for a service API version.

{% include requirement/MUST id="rust-package-versions-add-api" %} increment the major or minor version when adding a new method to the public API.

{% include requirement/SHOULD id="rust-package-versions-major-changes" %} increment the major version when making large feature changes.

### Dependencies {#rust-dependencies}

Dependencies bring in many considerations that are often easily avoided by avoiding the dependency.

* __Versioning__ - Though Rust allows a consumer to build multiple versions of the same crate, directly depending on different versions of the same crate, or importing types or calling functions from different versions of the same crate may be unintuitive.
* __Size__ - Consumer applications must be able to deploy as fast as possible into the cloud and move in various ways across networks. Removing additional code (like dependencies) improves deployment performance.
* __Licensing__ - You must be conscious of the licensing restrictions of a dependency and often provide proper attribution and notices when using them.
* __Compatibility__ - Often times you do not control a dependency and it may choose to evolve in a direction that is incompatible with your original use.
* __Security__ - If a security vulnerability is discovered in a dependency, it may be difficult or time consuming to get the vulnerability corrected if Microsoft does not control the dependencies code base.

{% include requirement/MUST id="rust-dependencies-centralized" %} declare all dependencies in the repository root `Cargo.toml` workspace in the `[dependencies]` section regardless of which type of dependency crates will inherit, e.g.:

```toml
[workspace.dependencies]
azure_core = { version = "0.1.0", path = "sdk/core" }
futures = "0.3.30"
tokio = { version = "1.36.0", features = ["macros", "rt-multi-thread"] }
```

{% include requirement/MUST id="rust-dependencies-inherit" %} inherit all dependencies from the workspace in individual creates' `Cargo.toml` files e.g.:

```toml
[dependencies]
azure_core = { workspace = true }
futures = { workspace = true }

[dev-dependencies]
tokio = { workspace = true }
```

{% include requirement/MAY id="rust-dependencies-features" %} override the features required for a crate.

### Code Lints {#rust-linting}

{% include requirement/MUST id="rust-linting-centralized" %} centralized general linting rules, whether allowed or denied, into the root workspace `Cargo.toml` e.g.:

```toml
[workspace.lints.rust]
dead_code = "allow"

[workspace.lints.clippy]
```

{% include requirement/MUST id="rust-linting-inherit" %} inherit linting rules from the workspace in each member crate e.g., :

```toml
[lints]
workspace = true
```

{% include requirement/MAY id="rust-linting-source" %} define source-specific lint rules in `.rs` source files if they can't be mitigated.

{% include requirement/MUSTNOT id="rust-linting-crate" %} define crate-specific lint rules in `Cargo.toml` files since these will apply to all source and should not be so pervasive.

### Documentation Comments {#rust-documentation}

Documentation comments in Rust not only support markdown, but can contain examples that are optionally runnable as tests when executing `cargo test`. Read [the rustdoc book][rust-lang-rustdoc] for more information,
especially about [tests in doc comments][rust-lang-rustdoc-tests].

{% include requirement/MUST id="rust-documentation-api" %} document all public APIs prior to General Availability (GA). This includes functions, structs, methods, fields, and traits, e.g.:

```rust
/// A secret stored in Key Vault.
pub struct Secret {
    /// The name of the secret.
    pub name: String,

    // ...
}
```

{% include requirement/MUST id="rust-documentation-readme" %} include the crate `README.md` in the root `lib.rs` to provide an overview of the crate in rendered documentation e.g.:

```rust
// near the top of lib.rs:
#![doc = include_str!("../README.md")]
```

This will impact line numbers, so you should only export APIs publicly from `lib.rs`.

{% include requirement/MAY id="rust-documentation-module-readme" %} include a separate `README.md` for a module as module documentation e.g., for module `http` defined in `http/mod.rs`:

```rust
#![doc = include_str!("README.md")]`
```

This would include the contents of `http/README.md`, which would render documentation for developers browsing in the GitHub web UI, as well as compile and potentially run any tests you have defined as examples in the `README.md` e.g.,

````markdown
This is how you would construct a client:

```rust no_run
let client = SecretClient::new(...);
```
````

{% include requirement/MUST id="rust-documentation-doc-auto-cfg" %} document which, if any, features a module, type, or function requires.

Near the top of `src/lib.rs` after [inclusion of the README](#rust-documentation-readme), add:

```rust
#![cfg_attr(docsrs, feature(doc_auto_cfg))]
```

{% include requirement/MUST id="rust-documentation-warn-missing-docs" %} warn for missing docs.

Near the top of `src/lib.rs` after [inclusion of the README](#rust-documentation-readme), add:

```rust
#![warn(missing_docs)]
```

If you must first add comments to TypeSpec members or convenience types and members, use `expect` instead of `warn` until you finish adding documentation.
`expect` will then trigger a warning (as error) reminding you to flip that back to `warn` so that future violations of `missing_docs` are discovered.

{% include requirement/MUST id="rust-documentation-parameters" %} document all parameters. Prior to [conventional doc comment markdown headers][rust-lang-rustdoc-headings], declare an `Arguments` heading as needed (not needed for `&self`):

```rust
/// Sets a secret and returns more information about the secret from the service.
///
/// # Arguments
///
/// * `name` - The name of the secret.
/// * `options` - Optional properties of the secret.
async fn set_secret(
    &self,
    name: &str,
    options: Option<SetSecretMethodOptions>,
) -> Result<Response>;
```

See [Rust by Example: Documentation][rust-lang-doc-meta] for more information.

{% include requirement/SHOULD id="rust-documentation-tests" %} use testable examples in documentation which improve test coverage and show callers runnable examples.

{% include requirement/MAY id="rust-documentation-expect" %} use `expect(&str)` to unwrap a value or panic with an explanation useful to consumers only in doc comments.

## Repository Guidelines {#rust-repository}

{% include requirement/MUST id="rust-repository-repository" %} locate all source code and READMEs in the [Azure/azure-sdk-for-rust] GitHub repository.

{% include requirement/MUST id="rust-repository-engsys" %} follow Azure SDK engineering systems guidelines for working in the [Azure/azure-sdk-for-rust] GitHub repository.

{% include requirement/MUST id="rust-repository-cargo-lock" %} commit `Cargo.lock` to the repository.

### Documentation Style {#rust-repo-docs}

There are several documentation deliverables that must be included in or as a companion to your client library. Beyond complete and helpful API documentation within the code itself (doc comments), you need a great README and other supporting documentation.

* `README.md` - Resides in the root of your library's directory within the SDK repository; includes package installation and client library usage information.
* `API reference` - Generated from the doc comments in your code; published on <https://learn.microsoft.com> and <https://docs.rs>.
* `Code snippets` - Short code examples that demonstrate single (atomic) operations for the champion scenarios you've identified for your library; included in your README, doc comments, and Quickstart.
* `Quickstart` - Article on <https://learn.microsoft.com> that is similar to but expands on the README content; typically written by your service's content developer.
* `Conceptual` - Long-form documentation like Quickstarts, Tutorials, How-to guides, and other content on docs.microsoft.com; typically written by your service's content developer.

{% include requirement/MUST id="rust-repo-docs-contentdev" %} include your service's content developer in the [Architecture Board] review for your library. To find the content developer you should work with, check with your team's Program Manager.

{% include requirement/MUST id="rust-repo-docs-contributors-guide" %} follow the [Azure SDK Contributors Guide]. (MICROSOFT INTERNAL)

{% include requirement/MUST id="rust-repo-docs-style-guide" %} adhere to the specifications set forth in the Microsoft style guides when you write public-facing documentation. This applies to both long-form documentation like a README and the doc comments in your code. (MICROSOFT INTERNAL)

* [Microsoft Writing Style Guide]
* [Microsoft Cloud Style Guide]

{% include requirement/SHOULD id="rust-repo-docs-to-silence" %} attempt to document your library into silence. Preempt developers' usage questions and minimize GitHub issues by clearly explaining your API in the doc comments. Include information on service limits and errors they might hit, and how to avoid and recover from those errors.

As you write your code, _document it so you never hear about it again._ The less questions you have to answer about your client library, the more time you have to build new features for your service.

#### Code Snippets {#rust-doc-samples}

{% include requirement/SHOULD id="rust-doc-samples-runnable" %} include [runnable examples in documentation][rust-lang-rustdoc-tests] for client methods or convenience layers that may require additional explanation specific to those members.

{% include requirement/MUST id="rust-doc-samples-no-run" %} add `no_run` to the code fence for documentation examples if that code requirements external resources.

{% include requirement/SHOULD id="rust-doc-samples-unwrap" %} use `unwrap()` or `expect(&str)` in examples and not the [question mark operator `?`][rust-lang-question-mark-operator], which requires additional setup.

{% include requirement/SHOULDNOT id="rust-doc-samples-main" %} include the `main` function in the signature, if even necessary e.g., for showing async examples.

````rust
/// ``` no_run
/// # async fn main() {
///     let client = SecretClient::new("https://myvault.vault.azure.net", Arc::new(DefaultAzureCredential::default()), None).unwrap();
///     let secret = client.set_secret("name", "value", None, None).await.unwrap();
///     println!("{secret:?}");
/// # }
/// ```
````

{% include requirement/MUST id="rust-doc-samples-no-run" %} attribute code fences with `no_run` if the code cannot or should not run when running `cargo test`. There are additional [documentation test attributes][rust-lang-rustdoc-tests-attributes] that may be of interest.

#### Build System Integration {#rust-engsys}

{% include requirement/MUST id="rust-engsys-stable" %} test all crates impacted by a Pull Request (PR) using the minimum supported Rust version (MSRV) from the `stable` channel i.e., `azure_core`'s `rust-version` in its `Cargo.toml`.

{% include requirement/MUST id="rust-engsys-nightly" %} test all crates impacted by a PR using the latest nightly toolchain.

{% include requirement/MUST id="rust-engsys-async" %} test `azure_core` and any other crates that implement async functions separate from `azure_core::Pipeline` using [`tokio`](https://tokio.rs) and [`monoio`](https://github.com/bytedance/monoio) in both single- and multi-threaded configurations. These tests do not necessarily have to run for every PR e.g., they may run nightly or weekly.

{% include requirement/SHOULD id="rust-engsys-partner-policies" %} test some partner `Pipeline` policies in nightly or weekly runs.

#### Formatting {#rust-repo-formatting}

{% include requirement/MUST id="rust-repo-formatting-rustfmt" %} format all source using `rustfmt`. `.vscode/settings.json` will do this automatically for Visual Studio Code.

{% include requirement/MUST id="rust-repo-formatting-engsys" %} check that all source is formatted in build pipelines.

This prevents noisy subsequent pull requests if another maintainer formats source, which is always recommended. All source should be formatted the same based on `rustfmt` defaults and any repo overrides that may be set.

### README {#rust-repository-readme}

{% include requirement/MUST id="rust-repository-readme-file" %} have a `README.md` file in the component root folder.

An example of a good `README.md` file can be found [here](https://github.com/Azure/azure-sdk-for-rust/blob/main/sdk/core/azure_core/README.md).

{% include requirement/MUST id="rust-repository-readme-consumer" %} optimize the `README.md` for the consumer of the client library.

The contributor guide (`CONTRIBUTING.md`) should be a separate file.

### Samples {#rust-repo-samples}

{% include requirement/MUST id="rust-repo-samples-examples" %} include runnable examples using `azure_identity::DefaultAzureCredential` and library-specific environment variables e.g., `AZURE_KEYVAULT_URL` in crates' `examples/` directory.

{% include requirement/MUST id="rust-repo-samples-unique" %} use unique example file names throughout the workspace.

The example file names are compiled into executes with the same name as the source file; thus, they must have unique names throughout the workspace.
To facilitate this, preface your example name with the client name - converting PascalCase type name to snake_case - or, if still ambiguous, the service directory or crate name e.g., `secret_client_set_secret.rs` or `keyvault_secret_client_set_secret.rs`.

See Cargo's [project layout][rust-lang-project-layout] for more information about conventional directories.

{% include requirement/SHOULD id="rust-repo-samples-question-operator" %} use the `?` operator to handle errors or optional values as much as possible.
This does mean that your sample method - including main - should return a `Result<T, E>`. This can be specific like `azure_core::Result<T>` if suitable,
or generic like `std::result::Result<(), Box<dyn std::error::Error>>` (`std::result::Result` is imported by default) e.g.,

````markdown
```rust
use azure_identity::DefaultAzureCredential;
use azure_security_keyvault_secrets::SecretClient;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let credential = DefaultAzureCredential::new()?;
    let client = SecretClient::new("https://my-vault.vault.azure.net", credential.clone(), None)?;
    // ...

    Ok(())
}
```
````

<!-- Links -->

{% include refs.md %}
{% include_relative refs.md %}
