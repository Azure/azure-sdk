---
title: "Java Azure SDK Design Guidelines"
keywords: guidelines java
permalink: java_introduction.html
folder: java
sidebar: general_sidebar
---

## Introduction

The following document describes Java specific guidelines for designing Azure SDK client libraries. These guidelines also expand on and simplify language-independent [General Azure SDK Guidelines][general-guidelines]. More specific guidelines take precedence over more general guidelines.

The Java guidelines are for the benefit of client library designers targeting service applications written in Java.  If you are a client library designer that is targeting Android mobile apps, refer to the [Android Guidelines](android_design.html) instead.

## Design Principles {#java-principles}

The main value of the Azure SDK is productivity. Other qualities, such as completeness, extensibility, and performance are important but secondary.  We ensure our customers can be highly productive when using our libraries by ensuring these libraries are:

**Idiomatic**

* The SDK should follow the general design guidelines and conventions of Java. It should feel natural to a Java developer.
* We embrace the ecosystem with its strengths and its flaws.
* We work with the ecosystem to improve it for all developers.
* Azure SDK libraries version just like standard Java libraries.

> We are not trying to fix bad parts of the language ecosystem; we embrace the ecosystem with its strengths and its flaws.

**Consistent**

* The Azure SDK feels like a single product of a single team, not a set of Maven libraries.
* Users learn common concepts once; apply the knowledge across all SDK components.
* All differences from the guidelines must have good reasons.

**Approachable**

* Small number of steps to get started; power knobs for advanced users
* Small number of concepts; small number of types; small number of members
* Approachable by our users, not by engineers designing the SDK components
* Easy to find great _getting started_ guides and samples
* Easy to acquire

**Dependable**

* 100% backward compatible
* Great logging, tracing, and error messages
* Predictable support lifecycle, feature coverage, and quality

### General Guidelines

{% include requirement/MUST id="java-general-follow-general-guidelines" %} follow the [General Azure SDK Guidelines].

{% include requirement/MUST id="java-general-repository" %} locate all source code in the [azure/azure-sdk-for-java] GitHub repository.

### Support for non-HTTP Protocols

Currently, this document describes guidelines for client libraries exposing HTTP services, with a small amount of guidance for AMQP-based services. If your service is not HTTP-based, please contact the [Azure SDK Architecture Board](https://azure.github.io/azure-sdk/policies_reviewprocess.html) for guidance.

## Azure SDK API Design {#java-api}

Azure services are exposed to Java developers as one or more *service client* types and a set of *supporting types*.

### Service Client

Service clients are the main starting points for developers calling Azure services with the Azure SDK. Each client library should have at least one client in its main namespace, so it’s easy to discover. The guidelines in this section describe patterns for the design of a service client. Because in Java both synchronous and asynchronous service clients are required, the sections below are organized into general service client guidance, followed by sync- and async-specific guidance.

There exists a distinction that must be made clear with service clients: not all classes that perform HTTP (or otherwise) requests to a service are automatically designated as a service client. A service client designation is only applied to classes that are able to be directly constructed because they are uniquely represented on the service. Additionally, a service client designation is only applied if there is a specific scenario that applies where the direct creation of the client is appropriate. If a resource can not be uniquely identified or there is no need for direct creation of the type, then the service client designation should not apply.

{% include requirement/MUST id="java-service-client-name" %} name service client types with the _Client_ suffix (for example, `ConfigurationClient`).

{% include requirement/MUST id="java-service-client-annotation" %} annotate all service clients with the `@ServiceClient` annotation.

{% include requirement/MUST id="java-service-client-namespace" %} place service client types that the consumer is most likely to interact with in the root package of the client library (for example, `com.azure.<group>.servicebus`). Specialized service clients should be placed in sub-packages.

{% include requirement/MUST id="java-service-client-immutable" %} ensure that all service client classes are immutable and stateless upon instantiation.

{% include requirement/MUST id="java-network-separate-packages" %} have separate service clients for sync and async APIs.

#### Sync Service Clients

{% include requirement/MUST id="java-sync-client-name" %} offer a sync service client named `<ServiceName>Client`. More than one service client may be offered for a single service. An example of a sync client is shown below:

```java
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

package com.azure.<group>.<service_name>;

@ServiceClient(
    builder = <service_name>ClientBuilder.class,
    serviceInterfaces = <service_name>Service.class)
public final class <service_name>Client {

    // internally, sync API can defer to async API with sync-over-async
    private final <service_name>AsyncClient client;

    // package-private constructors only - all instantiation is done with builders
    <service_name>Client(<service_name>AsyncClient client) {
        this.client = client;
    }

    // service methods...

    // A single response API
    public Response<<model>> <service_operation>(<parameters>) {
        // deferring to async client internally
        return client.<service_operation>(<parameters>).block();
    }

    // A non-paginated sync list API (refer to pagination section for more details)
    public IterableStream<<model>> list<service_operation>(<parameters>) {
        // ...
    }

    // A paginated sync list API (refer to pagination section for more details)
    public PagedIterable<<model>> list<service_operation>(<parameters>) {
        // ...
    }

    // other members
    …
}
```

Refer to the [ConfigurationClient class] for a fully built-out example of how a sync client should be constructed.

#### Async Service Clients

{% include requirement/MUST id="java-async-client-name" %} offer an async service client named `<ServiceName>AsyncClient`. More than one service client may be offered for a single service. An example of an async client is shown below:

```java
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

package com.azure.<group>.<service_name>;

@ServiceClient(
    builder = <service_name>ClientBuilder.class,
    serviceInterfaces = <service_name>Service.class,
    isAsync = true)
public final class <service_name>AsyncClient {

    // package-private constructors only - all instantiation is done with builders
    <service_name>Client(<parameters>) {
        // ...
    }

    // service methods...

    // A single response API
    public Mono<Response<<model>>> <service_operation>(<parameters>) {
        // ...
    }

    // A paginated response API
    public PagedFlux<<model>> list<service_operation>(<parameters>) {
        // ...
    }

    // other members
    ...
}
```

Refer to the [ConfigurationAsyncClient class] for a fully built-out example of how an async client should be constructed.

{% include requirement/MUST id="java-async-framework" %} use [Project Reactor] to provide consumers with a high-quality async API.

{% include requirement/MUSTNOT id="java-async-other-frameworks" %} use any other async APIs, such as `CompletableFuture` or [RxJava].

{% include requirement/MUSTNOT id="java-async-streaming" %} write custom APIs for streaming or async operations. Make use of the existing functionality offered in the Azure core library. Discuss proposed changes to the Azure core library with the [Architecture Board]. Refer to the [Azure Core Types](#using-azure-core-types) section for more information.

#### Service Client Creation

{% include requirement/MUSTNOT id="java-service-client-constructors" %} provide any `public` or `protected` constructors in the service client. Keep visibility to a minimum by using package-private constructors that may only be called by types in the same package, and then enable instantiation of the service client through the use of service client builders, detailed below.

{% include requirement/MUST id="java-service-client-fluent-builder" %} offer a fluent builder API for constructing service clients named `<service_name>ClientBuilder`, which must support building a sync service client instance and an async service client instance (where appropriate). It must offer `buildClient()` and `buildAsyncClient()` API to create a synchronous and asynchronous service client instance, respectively. Shown in the first code sample below is a generalized template, and following that is a stripped-down example builder.

```java
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.
package com.azure.<group>.<service_name>;

// Template of how a builder should look
@ServiceClientBuilder(serviceClients = {<service_name>Client.class, <service_name>AsyncClient.class})
public final class <service_name>ClientBuilder {

    // private fields for all settable parameters
    ...

    // This is the public constructor used to create the service client, so a public access modifier
    // makes sense here. This is required, and it is intended to prevent any public constructors
    // in the service client itself, because we do not want to allow users to create a service client
    // directly.
    public <service_name>ClientBuilder() {
        // any initialization necessary for the builder
    }

    // The buildClient() method returns a new instance of the sync client each time it is called
    public <service_name>Client buildClient() {
        // create an async client and pass that into the sync client for sync-over-async impl
        return new <service_name>Client(buildAsync());
    }

    // The buildAsyncClient() method returns a new instance of the async client each time it is called
    public <service_name>Client buildAsyncClient() {
        // configuration of pipeline, etc
        ...

        // instantiate new async client instance
        return new <service_name>AsyncClient(serviceEndpoint, pipeline);
    }

    // fluent API, each returning 'this', and one for each parameter to configure
    public <service_name>ClientBuilder <property>(<parameter>) {
        builder.<property>(<parameter>);
        return this;
    }
}
```

```java
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.
package com.azure.data.appconfiguration;

// concrete example of a builder
@ServiceClientBuilder(serviceClients = {ConfigurationAsyncClient.class, ConfigurationClient.class})
public final class ConfigurationClientBuilder {
    private String endpoint;
    private TokenCredential tokenCredential;
    private ConfigurationServiceVersion version = ConfigurationServiceVersion.getLatest();
    // other fields and its setters are omitted for brevity

    // public constructor - this is the only available front door to creating a service client instance
    public ConfigurationClientBuilder() {
        // empty constructor
    }

    // The buildClient() method returns a new instance of the sync client each time it is called
    public ConfigurationClient buildClient() {
        // create an async client and pass that into the sync client for sync-over-async impl
        return new ConfigurationClient(buildAsyncClient());
    }

    // The buildAsyncClient() method returns a new instance of the async client each time it is called
    public ConfigurationAsyncClient buildAsyncClient() {
        // configuration of pipeline, etc
        HttpPipeline pipeline = buildOrGetHttpPipeline();

        // instantiate new async client instance
        return new ConfigurationAsyncClient(endpoint, pipeline, serviceVersion);
    }

    // fluent APIs, each returning 'this', and one for each parameter to configure

    public ConfigurationClientBuilder endpoint(String endpoint) {
        try {
            new URL(endpoint);
        } catch (MalformedURLException ex) {
            throw logger.logExceptionAsWarning(new IllegalArgumentException("'endpoint' must be a valid URL"));
        }
        this.endpoint = endpoint;
        return this;
    }

    public ConfigurationClientBuilder credential(TokenCredential tokenCredential) {
        // token credential can not be null value
        this.tokenCredential = Objects.requireNonNull(tokenCredential);
        return this;
    }

    public ConfigurationClientBuilder serviceVersion(ConfigurationServiceVersion version) {
        this.version = version;
        return this;
    }

}
```

{% include requirement/MUST id="java-service-client-fluent-builder-multiple-clients" %} offer build method 'overloads' for when a builder can build multiple client types. These methods must be named in the form `build<client>Client()` and `build<client>AsyncClient()`. For example, `buildBlobClient()` and `buildBlobAsyncClient()`.

{% include requirement/MUST id="java-service-client-builder-annotation" %} annotate service client builders with the `@ServiceClientBuilder` annotation, setting the annotation parameters appropriately for the service client (e.g. `async` is true for async service clients).

{% include requirement/MUST id="java-service-client-builder-consistency" %} ensure consistency across all HTTP-based client libraries, by using the following names for client builder fluent API:

| Name                 | Intent                                                                                                 |
|----------------------|--------------------------------------------------------------------------------------------------------|
| `addPolicy`          | Adds a policy to the set of existing policies (assumes no custom pipeline is set).                     |
| `buildAsyncClient`   | Creates a new **async** client on each call.                                                           |
| `buildClient`        | Creates a new **sync** client on each call.                                                            |
| `clientOptions`      | Allows the user to set a variety of client-related options, such as user-agent string, headers, etc.   |
| `configuration`      | Sets the configuration store that is used during construction of the service client.                   |
| `connectionString`   | Sets the connection string to use for authenticating HTTP requests (only applicable if the Azure portal offers it for the service). |
| `credential`         | Sets the credential to use when authenticating HTTP requests.                                          |
| `endpoint`           | URL to send HTTP requests to.                                                                          |
| `httpClient`         | Sets the HTTP client to use.                                                                           |
| `httpLogOptions`     | Configuration for HTTP logging level, header redaction, etc.                                           |
| `pipeline`           | Sets the HTTP pipeline to use.                                                                         |
| `retryPolicy`        | Sets the retry policy to use (using the `RetryPolicy` type).                                           |
| `serviceVersion`     | Sets the [service version](#versioning) to use. This must be a type implementing `ServiceVersion`.     |

`endpoint` may be renamed if a more user-friendly name can be justified. For example, a blob storage library developer may consider using `new BlobClientBuilder.blobUrl(..)`. In this case, the `endpoint` API should be removed.

{% include requirement/MUST id="java-service-client-builder-consistency-amqp" %} ensure consistency across all AMQP-based client libraries, by using the following names for client builder fluent API:

| Name                       | Intent                                                                                                 |
|----------------------------|--------------------------------------------------------------------------------------------------------|
| `build<Type>AsyncClient`   | Creates a new **async** client on each call.                                                           |
| `build<Type>Client`        | Creates a new **sync** client on each call.                                                            |
| `configuration`            | Sets the configuration store that is used during construction of the service client.                   |
| `credential`               | Sets the credential to use when authenticating AMQP requests.                                          |
| `connectionString`         | Sets the connection string to use for authenticating AMQP requests (only applicable if the Azure portal offers it for the service). |
| `transportType`            | Sets the preferred transport type to AMQP or Web Sockets that the client should use.                   |
| `retry`                    | Sets the retry policy to use (using the `AmqpRetryOptions` type).                                      |
| `proxyOptions`             | Sets the proxy connection settings.                                                                    |
| `serviceVersion`           | Sets the [service version](#versioning) to use. This must be a type implementing `ServiceVersion`.     |

{% include requirement/MUST id="java-service-client-builder-state" %} throw an `IllegalStateException` from the builder method when it receives mutually exclusive arguments.  The consumer is over-specifying builder arguments, some of which will necessarily be ignored. The error message in the exception must clearly outline the issue.

{% include requirement/MUST id="java-client-construction" %} allow the consumer to construct a service client with the minimal information needed to connect and [authenticate](#authentication) to the service.

{% include requirement/MUST id="java-service-client-builder-validity" %} ensure the builder will instantiate a service client into a valid state.  Throw an `IllegalStateException` when the user calls the `build*()` methods with a configuration that is incomplete or invalid.

##### Service Versions

{% include requirement/MUST id="java-versioning-highest-api" %} call the highest supported service API version by default, and ensure this is clearly documented.

{% include requirement/MUST id="java-versioning-select-api-version" %} allow the consumer to explicitly select a supported service API version when instantiating the service client, as shown above in the [service client creation](#service-client-creation) section.

Use a builder parameter called `serviceVersion` on the client builder type (as [specified above](#service-client-creation)).

{% include requirement/MUST id="java-versioning-service-version-spec" %} specify a service version as an enum implementing the `ServiceVersion` interface. For example, the following is a code snippet from the `ConfigurationServiceVersion`:

```java
public enum ConfigurationServiceVersion implements ServiceVersion {
    V1_0("1.0");

    private final String version;

    ConfigurationServiceVersion(String version) {
        this.version = version;
    }

    @Override
    public String getVersion() {
        return this.version;
    }

    /**
     * Gets the latest service version supported by this client library
     *
     * @return the latest {@link ConfigurationServiceVersion}
     */
    public static ConfigurationServiceVersion getLatest() {
        return V1_0;
    }
}
```

This can then be called by the developer as such:

```java
public class UserApplication {
    public static void main(String args[]) {
        ConfigurationClient client = new ConfigurationClientBuilder()
            .credential(<tokenCredential>)
            .endpoint("<endpoint>")
            .serviceVersion(ConfigurationServiceVersion.V1_0) // set the version to V1
            .buildClient();

        // calls V1 service API
        ConfigurationSetting setting = client.getConfigurationSetting("name", "label");
    }
}
```

#### Service Methods

Service methods are methods that invoke operations on a service. They are commonly found on classes suffixed with `Client`, but can also be found on other resource classes that are vended by a client.

{% include requirement/MUSTNOT id="java-async-suffix" %} use the suffix `Async` in methods that do operations asynchronously. Let the fact the user has an instance of an 'async client' provide this context.

{% include requirement/MUST id="java-service-client-verbs" %} prefer the use of the following terms for CRUD operations:

|Verb              |Parameters        |Returns                 |Comments                                                                                                                |
|------------------|------------------|------------------------|------------------------------------------------------------------------------------------------------------------------|
| `upsert<noun>`   |key, item         |Updated or created item |Create new item or update existing item. Verb is primarily used in database-like services.                              |
| `set<noun>`      |key, item         |Updated or created item |Create new item or update existing item. Verb is primarily used for dictionary-like properties of a service.            |
| `create<noun>`   |key, item         |Created item            |Create new item. Fails if item already exists.                                                                          |
| `update<noun>`   |key, partial item |Updated item            |Fails if item doesn't exist.                                                                                            |
| `replace<noun>`  |key, item         |Replace existing item   |Completely replaces an existing item. Fails if the item doesn't exist.                                                  |
| `delete<noun>`   |key               |Deleted item, or `null` |Delete an existing item. Will succeed even if item didn't exist. Deleted item may be returned, if service supports it.  |
| `add<noun>`      |index, item       |Added item              |Add item to a collection. Item will be added last, or into the index position specified.                                |
| `get<noun>`      |key               |Item                    |Will return null if item doesn't exist.                                                                                |
| `list<noun>`     |                  |Items                   |Return list of items. Returns empty list if no items exist.                                                             |
| `<noun>Exists`   |key               |`boolean`               |Return `true` if the item exists.                                                                                       |

{% include requirement/SHOULD id="java-service-client-flexibility" %} remain flexible and use names best suited for developer experience.  Don't let the naming rules result in non-idiomatic naming patterns.  For example, Java developers prefer `list` operations over `getAll` operations.

One of the Azure Core types is `com.azure.core.util.Context`, which acts as an append-only key-value map, and which by default is empty. The `Context` allows end users of the API to modify the outgoing requests to Azure on a per-method call basis, for example to enable distributed tracing.

{% include requirement/MUST id="java-service-client-context" %} provide an overload method that takes a `com.azure.core.util.Context` argument for each service operation **in sync clients only**. The `Context` argument must be the last argument into the service method (except where `varargs` are used). If a service method has multiple overloads, only the 'maximal' overloads need to have the `Context` argument. A maximal overload is one that has a full set of arguments.  It may not be necessary to offer a 'Context overload' in all cases.  We prefer a minimal API surface, but `Context` must always be supported.

```java
getFoo()
getFoo(x)
getFoo(x, y)
getFoo(x, y, z) // maximal overload
getFoo(a)       // maximal overload

// this will result in the following two methods being required
// (replacing the two maximal overloads above)
getFoo(x, y, z, Context)
getFoo(a, Context)
```

{% include requirement/MUSTNOT id="java-service-client-context-async" %} include overloads that take `Context` in async clients.  Async clients use the [subscriber context built into Reactor Flux and Mono APIs][reactor-context].

#### Non-Service Methods

Clients often have non-service methods, for accessing details such as the service version, http pipeline, and so on. There may also be API that offers users the ability to create specialized sub-clients. These sub-clients

{% include requirement/MUST id="java-service-client-method-naming" %} use standard JavaBean naming prefixes for all methods that are not service methods.

{% include requirement/MUST id="java-service-client-vend-prefix" %} prefix methods in sync clients that create or vend sub-clients with `get` and suffix with `Client`. For example, `container.getBlobClient()`. Similarly, prefix methods in async clients that create or vend sub-clients with `get` and suffix with `AsyncClient`. For example, `container.getBlobAsyncClient()`. Keep in mind the guidance in the [service client](#service-client) section, as it cannot be assumed that the `Client` suffix applies to another client-like class vended by a client. The `Client` suffix is only applicable in certain situations, and therefore, methods should not be named `get*Client` if the type is not a client.

##### Cancellation

{% include requirement/MUSTNOT id="java-no-cancellation" %} provide any API that accepts a cancellation token, in both sync and async clients. Cancellation isn't a common pattern in Java. Developers who use our client libraries, and who need to cancel requests, should use the async API instead, where they can unsubscribe from a publisher to cancel the request.

##### Return Types

Requests to the service fall into two basic groups: methods that make a single logical request, and methods that make a deterministic sequence of requests.  An example of a *single logical request* is a request that may be retried inside the operation.  An example of a *deterministic sequence of requests* is a paged operation.

The *logical entity* is a protocol neutral representation of a response. The logical entity may combine data from headers, body, and the status line. For example, you may expose an `ETag` header as a property on the logical entity.  `Response<T>` is the 'complete response'. It contains HTTP headers, status code, and the `T` object (a deserialized object created from the response body). The `T` object would be the 'logical entity'.

{% include requirement/MUST id="java-response-logical-entity" %} return the logical entity (i.e. the `T`) for all **synchronous** service methods.

{% include requirement/MUST id="java-response-async-logical-entity" %} return the logical entity (i.e. the `T`) wrapped inside a `Mono` for all **asynchronous** service methods that make network requests.

Return `Response<T>` on the maximal overload for a service method with `WithResponse` appended to the name.  For example:

```java
Foo foo = client.getFoo(a);
Foo foo = client.getFoo(a, b);
Foo foo = client.getFoo(a, b, c, context); // This is the maximal overload, so it is replaced with the 'withResponse' 'overload' below
Response<Foo> response = client.getFooWithResponse(a, b, c, context);
```

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="java-response-headers" %} return headers and other per-request metadata unless it's obvious which specific HTTP request the methods return value corresponds to.

{% include requirement/MUST id="java-response-errors" %} provide enough information in failure cases for a developer to take appropriate corrective action, including a message describing what went wrong and details on the corrective actions to take.

#### Service Method Parameters

##### Option Parameters

Service methods fall into two main groups when it comes to the number and complexity of parameters they accept:

- Service Methods with simple inputs, _simple methods_ for short
- Service Methods with complex inputs, _complex methods_ for short

_Simple methods_ are methods that take up to six parameters, with most of the parameters being simple primitive types. _Complex methods_ are methods that take a larger number of parameters and typically correspond to REST APIs with complex request payloads.

_Simple methods_ should follow standard Java best practices for parameter list and overload design.

_Complex methods_ should introduce an _option parameter_ to represent the request payload. Consideration can subsequently be made for providing simpler convenience overloads for the most common scenarios. This is referred to in this document as the 'options pattern', and is demonstrated in the code below:

```java
public class BlobContainerClient {

    // simple service methods
    public BlobInfo uploadBlob(String blobName, byte[] content);
    public Response<BlobInfo> uploadBlobWithResponse(String blobName, byte[] content, Context context);

    // complex service methods, note the introduction of the 'CreateBlobOptions' type
    public BlobInfo createBlob(CreateBlobOptions options);
    public Response<BlobInfo> createBlobWithResponse(CreateBlobOptions options, Context context);

    // convenience overload[s]
    public BlobInfo createBlob(String blobName);
}

@Fluent
public class CreateBlobOptions {
    private String blobName;
    private PublicAccessType access;
    private Map<String, String> metadata;

    // Constructor enforces the requirement that blobName is always set
    public CreateBlobOptions(String blobName) {
        this.blobName = blobName;
    }

    public String getBlobName() {
        return blobName;
    }

    public CreateBlobOptions setAccess(PublicAccessType access) {
        this.access = access;
        return this;
    }

    public PublicAccessType getAccess() {
        return access;
    }

    public CreateBlobOptions setMetadata(Map<String, String> metadata) {
        this.metadata = metadata;
        return this;
    }

    public Map<String, String> getMetadata() {
        return metadata;
    }
}
```

{% include requirement/MUST id="java-params-complex-naming" %} name the _options_ type after the name of the service method it is used for, such that the type is named `<operation>Options`. For example, above the method was `createBlob`, and so the _options_ type was named `CreateBlobOptions`.

{% include requirement/MUST id="java-params-complex" %} use the _options_ parameter pattern for complex service methods.

{% include requirement/MAY id="java-params-complex-growth" %} use the _options_ parameter pattern for simple service methods that you expect to `grow` in the future.

{% include requirement/MAY id="java-params-simple-overloads" %} add simple overloads of methods using the _options_ parameter pattern.

If in common scenarios, users are likely to pass just a small subset of what the _options_ parameter represents, consider adding an overload with a parameter list representing just this subset.

{% include requirement/MUSTNOT id="java-params-complex-overloads" %} introduce method overloads that take a subset of the parameters as well as the _options_ parameter, except for parameters that are for client-side use only (e.g. `Context`, timeout, etc).

{% include requirement/MUST id="java-params-complex-withResponse" %} use the _options_ parameter type, if it exists, for all `*WithResponse` methods. If no _options_ parameter type exists, do not create one solely for the `*WithResponse` method.

{% include requirement/MUST id="java-params-options-package" %} place all options types in a root-level `models` package, to prevent too many root-level packages and to make use of the existing `models` package used by other model types.

{% include requirement/MUST id="java-params-options-design" %} design options types with the same design guidance as given below for model class types, namely fluent setters for optional arguments, using the standard JavaBean naming convention of `get*`, `set*`, and `is*`. Additionally, there may be constructor overloads for each combination of required arguments.

{% include requirement/MAY id="java-params-options-ctor" %} introduce constructor overloads for each combination of required arguments (in a similar manner to [required properties on model types](#java-models-constructors-args-required)).

##### Parameter Validation

The service client will have methods that send requests to the service. These methods take two kinds of parameters: _service parameters_ and _client parameters_. _Service parameters_ are sent across the wire to the service as URL segments, query parameters, request header values, and request bodies (typically JSON or XML). _Client parameters_ are used solely within the client library and are not sent to the service; examples are path parameters, Context or file paths. If, for example, a path parameter is not validated, it could result in sending a request to a malformed URL, which could prevent the service from having the opportunity to do validation on it.

{% include requirement/MUST id="java-params-client-validation" %} validate client parameters. This includes checks for null values for required path parameters, and checks for empty string values if a required path parameter declares a `minLength` greater than zero.

{% include requirement/MUSTNOT id="java-params-service-validation" %} validate service parameters. This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUST id="java-params-test-devex" %} test the developer experience when invalid service parameters are passed in. Ensure clear error messages are generated by the service. If the developer experience is inadequate, work with the service team to correct the problem.

#### Methods Returning Collections (Paging)

Many Azure REST APIs return collections of data in batches or pages. A client library will expose such APIs as special enumerable types `PagedIterable<T>` or `PagedFlux<T>` (or one of their parent types), for synchronous and asynchronous APIs, respectively. These types are located in the [azure-core library](#using-azure-core-types).

{% include requirement/MUST id="java-pagination-pagediterable" %} return `PagedIterable<T>` from service methods in synchronous that return a collection of items. For example, the configuration service **sync** client should offer the following API:

```java
public final class ConfigurationClient {
    // synchronous API returning a PagedIterable of ConfigurationSetting instances
    public PagedIterable<ConfigurationSetting> listSettings(...) {
        ...
    }
}
```

`PagedIterable` allows developers to write code that works using the standard *for* loop syntax (as it is an `Iterable`), and also to work with a Java `Stream` (as there is a `stream()` method). Consumers may also call `streamByPage()` and `iterableByPage()` methods to work on page boundaries. Subclasses of these types are acceptable as return types too, so long as the naming convention generally follows the pattern `<serviceName>PagedIterable` or `<operation>PagedFlux`.

{% include requirement/MUSTNOT id="java-pagination-collections" %} return other collection types for sync APIs that return collections (for example, do not return `List`, `Stream`, `Iterable`, or `Iterator`).

{% include requirement/MUST id="java-pagination-pagedflux" %} return `PagedFlux<T>` (or an appropriately-named subclass) for asynchronous APIs that expose a collection of items. Even if the service does not support pagination, always return `PagedFlux<T>`, as it allows for consumers to retrieve response information in a consistent manner.

```java
public final class ConfigurationAsyncClient {

    // asynchronous API returning a PagedFlux of ConfigurationSetting instances
    public PagedFlux<ConfigurationSetting> listSettings(SettingSelector options, Context context) {
        // The first lambda is a Supplier<PagedResponse<T>> returning the first page of results
        // as a Mono<PagedResponse<T>>.
        // The second lambda is a Function<String, Mono<PagedResponse<T>>>, returning a
        // Mono<PagedResponse<T>> representing a page based on the provided continuationToken.
        return new PagedFlux<>(
            () -> listFirstPageSettings(options, context),
            continuationToken -> listNextPageSettings(contextWithSpanName, continuationToken));
    }
}
```

Consumers of this API can consume individual items by treating the response as a `Flux<T>`:

```java
client.listSettings(..)
      .subscribe(item -> System.out.println("Processing item " + item));
```

The consumer may process items page-by-page instead:

```java
client.listSettings(..)
      .byPage()
      .subscribe(page -> {
        // page is a PagedResponse, which implements Page and Response, so there exists:
        //  * List<T> of items,
        //  * continuationToken (represented as a String),
        //  * Status code,
        //  * HTTP headers,
        //  * HTTP request
        System.out.println("Processing page " + page)
});
```

The `PagedFlux.byPage()` offers an overload to accept a `continuationToken` string, which will begin the returned `Flux` at the page specified by this token.

{% include requirement/MAY id="java-pagination-subtypes" %} subclass the azure-core paged and iterable APIs, where appropriate, to offer additional, service specific API to users. If this is done, the subtype must be named as it currently is, prefixed with the name of the service. For example, `SearchPagedFlux` and `SearchPagedIterable`. Subtypes are expected to be placed within a `util` package existing within the root package.

#### Methods Invoking Long-Running Operations

Some service operations, known as _Long Running Operations_ or _LROs_ take a long time (up to hours or days). Such operations do not return their result immediately, but rather are started, their progress is polled, and finally the result of the operation is retrieved.

The [azure-core](#using-azure-core-types) library exposes types that make supporting LROs simpler, most notably `SyncPoller<T>` and `PollerFlux<T>`, for synchronous and asynchronous clients, respectively. These classes represent a LRO and support operations for polling and waiting for status changes, and retrieving the final operation result.

{% include requirement/MUST id="java-lro-poller-class" %} use the `SyncPoller` and `PollerFlux` to represent long-running operations. The long-running operation API pattern is:

```java
// sync client
public final class <service_name>Client {
    // SyncPoller<T, U> is a type in azure core
    // T is the type of long-running operation poll response value
    // U is the type of the final result of long-running operation
    public SyncPoller<T, U> begin<operation_name>(<parameters>) {
        PollerFlux<> asyncPoller = asyncClient.begin<operation_name>(<parameters>);
        return asyncPoller.getSyncPoller();
    }
}
```

```java
// Async client
public final class <service_name>AsyncClient {
    // PollerFlux<T, U> is a type in azure core
    // T is the type of long-running operation poll response value
    // U is the type of the final result of long-running operation
    public PollerFlux<T, U> begin<operation_name>(<parameters>) {
        return new PollerFlux<>(...);
    }
}
```

{% include requirement/MUST id="java-lro-prefix" %} prefix method names which return a poller with the `begin` prefix.

{% include requirement/MUST id="java-lro-continuation" %} provide a way to instantiate a poller with the serialized state of another poller to begin where it left off, for example by passing the state as a parameter to the same method which started the operation, or by directly instantiating a poller with that state.

{% include requirement/MUSTNOT id="java-lro-no-void-terminal-state" %} specify any poller (`SyncPoller` or `PollerFlux`) with a terminal state (i.e. the `U` in `SyncPoller<T, U>` or `PollerFlux<T, U>`) as being `void`. This does not benefit users, as it is typically their desire to inspect the terminal state for some quality, and by being void we are making this inspection more difficult than necessary.

#### Conditional Request Methods

[Conditional requests](https://developer.mozilla.org/docs/Web/HTTP/Conditional_requests) are normally performed using HTTP headers.  The primary usage provides headers that match the `ETag` to some known value.  The `ETag` is an opaque identifier that represents a single version of a resource. For example, adding the following header will translate to "if the record's version, specified by the `ETag`, is not the same".

{% highlight text %}
If-Not-Match: "etag-value"
{% endhighlight %}

With headers, tests are possible for the following:

* Unconditionally (no additional headers)
* If (not) modified since a version (`If-Match` and `If-Not-Match`)
* If (not) modified since a date (`If-Modified-Since` and `If-Unmodified-Since`)
* If (not) present (`If-Match` and `If-Not-Match` with a `ETag=*` value)

Not all services support all of these semantics, and may not support any of them.  Developers have varying levels of understanding of the `ETag` and conditional requests, so it is best to abstract this concept from the API surface.  There are two types of conditional requests we need to be concerned with:

**Safe conditional requests** (e.g. GET)

These are typically used to save bandwidth in an "update cache" scenario, i.e. I have a cached value, only send me the data if what the service has is newer than my copy. These return either a 200 or a 304 status code, indicating the value was not modified, which tells the caller that their cached value is up to date.

**Unsafe conditional requests** (e.g. POST, PUT, or DELETE)

These are typically used to prevent losing updates in an optimistic concurrency scenario, i.e. I've modified the cached value I'm holding, but don't update the service version unless it has the same copy I've got. These return either a success or a 412 error status code, indicating the value was modified, to indicate to the caller that they'll need to retry their update if they want it to succeed.

These two cases are handled differently in client libraries.  However, the form of the call is the same in both cases.  The signature of the method should be:

{% highlight text %}
client.<method>(<item>, requestOptions)
{% endhighlight %}

The `requestOptions` field provides preconditions to the HTTP request.  The `Etag` value will be retrieved from the item that is passed into the method where possible, and method arguments where not possible. The form of the method will be modified based on idiomatic usage patterns in the language of choice.  In cases where the `ETag` value is not known, the operation cannot be conditional.
If the library developer does not need to support advanced usage of precondition headers, they can add a boolean parameter that is set to true to establish the condition.  For example, use one of the following boolean names instead of the conditions operator:

* `onlyIfChanged`
* `onlyIfUnchanged`
* `onlyIfMissing`
* `onlyIfPresent`

In all cases, the conditional expression is "opt-in", and the default is to perform the operation unconditionally.

The return value from a conditional operation must be carefully considered.  For safe operators (e.g. GET), return a response that will throw if the value is accessed (or follow the same convention used fro a `204 No Content` response), since there is no value in the body to reference.  For unsafe operators (e.g. PUT, DELETE, or POST), throw a specific error when a `Precondition Failed` or `Conflict` result is received.  This allows the consumer to do something different in the case of conflicting results.

{% include requirement/SHOULD %} accept a `conditions` parameter (which takes an enumerated type) on service methods that allow a conditional check on the service.

{% include requirement/SHOULD %} accept an additional boolean or enum parameter on service methods as necessary to enable conditional checks using `ETag`.

{% include requirement/SHOULD %} include the `ETag` field as part of the object model when conditional operations are supported.

{% include requirement/SHOULDNOT %} throw an error when a `304 Not Modified` response is received from the service, unless such errors are idiomatic to the language.

{% include requirement/SHOULD %} throw a distinct error when a `412 Precondition Failed` response or a `409 Conflict` response is received from the service due to a conditional check.

#### Hierarchical Clients

> TODO: Add discussion of hierarchical clients

### Supporting Types

#### Model Types

Model types are classes that developers of applications use to provide required information into, or to receive information from, Azure services. For example:

```java
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.
package com.azure.ai.textanalytics.models;

@Fluent
public final class PiiTaskParameters {

    // optional properties
    private PiiTaskParametersDomain domain;
    private String modelVersion = "latest";

   // optional properties have getters and fluent setters
    public PiiTaskParametersDomain getDomain() {
        return this.domain;
    }

    public PiiTaskParameters setDomain(PiiTaskParametersDomain domain) {
        this.domain = domain;
        return this;
    }

    public String getModelVersion() {
        return this.modelVersion;
    }

    public PiiTaskParameters setModelVersion(String modelVersion) {
        this.modelVersion = modelVersion;
        return this;
    }
}
```

{% include requirement/MUSTNOT id="java-models-builder" %} offer a separate builder class for model classes.

{% include requirement/MUST id="java-models-constructors" %} provide public constructors for all model classes that a user is allowed to instantiate. Model classes that are not instantiable by the user, for example if they are model types returned from the service, must not have any publicly visible constructors.

Because model types can represent many different kinds of models, it is important that they can correctly enforce required properties. Whilst many models have no required properties, some do, and moreso, some models can even support multiple mutually exclusive sets of required properties.

{% include requirement/MUST id="java-models-constructors-args" %} provide a no-args constructor if a model type has no required properties.

{% include requirement/MUST id="java-models-constructors-args-required" %} provide one or more constructors with arguments, if a model type has required properties. If there are multiple mutually exclusive sets of supported required parameter, a constructor must be introduced for each of these. For example:

```java
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.
package com.azure.ai.textanalytics.models;

public final class TextDocumentInput {

    // required properties
    private final String id;
    private final String text;

    // optional property
    private String language;

    // Constructor to enforce setting the required properties
    public TextDocumentInput(String id, String text) {
        this.id = Objects.requireNonNull(id, "'id' cannot be null");
        this.text = Objects.requireNonNull(text, "'text' cannot be null");
    }

    // required properties only have getters
    public String getId() {
        return this.id;
    }

    public String getText() {
        return this.text;
    }

    // optional property has both getter and fluent setter
    public String getLanguage() {
        return this.language;
    }

    public TextDocumentInput setLanguage(String language) {
        this.language = language;
        return this;
    }
}
```

{% include requirement/MUST id="java-models-fluent-api" %} provide a fluent setter API to configure the model class, where each `set` method should `return this`. This allows chaining of set operations.

{% include requirement/MUST id="java-models-fluent-override-set" %} override all `set` methods when extending a fluent type to return the extended type. This allows chaining of `set` operations on the sub-class.

```java
@Fluent
public class SettlementOptions {
    private ServiceBusTransactionContext transactionContext;

    public ServiceBusTransactionContext getTransactionContext() {
        return transactionContext;
    }

    public SettlementOptions setTransactionContext(ServiceBusTransactionContext transactionContext) {
        this.transactionContext = transactionContext;
        return this;
    }
}

@Fluent
public final AbandonOptions extends SettlementOptions {
    private Map<String, Object> propertiesToModify;

    public Map<String, Object> getPropertiesToModify() {
        return propertiesToModify;
    }

    public AbandonOptions setPropertiesToModify(Map<String, Object> propertiesToModify) {
        this.propertiesToModify = propertiesToModify;
        return this;
    }

    // Override setter method of the parent class
    @Override
    public AbandonOptions setTransactionContext(ServiceBusTransactionContext transactionContext) {
        super.setTransactionContext(transactionContext);
        return this;
    }
}
```

{% include requirement/MUST id="java-models-fluent-annotation" %} apply the `@Fluent` annotation to the class.

Fluent types must not be immutable.  Don't return a new instance on each setter call.

{% include requirement/MUST id="java-models-javabeans" %} use the JavaBean naming convention of `get*`, `set*`, and `is*`.

{% include requirement/MUST id="java-models-deserialize" %} include static methods if new model instances are required to be created from raw data. The static method names should be `from<dataformat>`. For example, to create an instance of `BinaryData` from a string, include a static method called `fromString` in `BinaryData` class.

{% include requirement/MUSTNOT id="java-models-collection-mutability" %} copy collection-based results, or wrap collection-related return types with unmodifiable wrappers. If a user calls a method `public List<String> getFoos()`, they should feel entitled to modify this collection as their needs fit. These modifications should be applied back to the model that supplied the collection in the first place. In places where this will impact the correct operation of the model type (i.e. where the types of values is constrained), it is acceptable to copy the collection or to wrap it as an unmodifiable type, provided that this is clearly documented in the related JavaDoc.

Model types sometimes exist only as an Azure service return type, and developers would never instantiate these. Often, these model types have API that is not user-friendly (in particular, overly complex constructors). It would be best for developers if they were never presented with this API in the first place, and we refer to these as 'undesirable public API'.

{% include requirement/MUST id="java-models-interface" %} put model classes that are intended as service return types only, and which have undesirable public API into the `.implementation.models` package. In its place, an interface should be put into the public-facing `.models` package, and it should be this type that is returned through the public API to end users.

Examples of situations where this is applicable include when there are constructors or setters on a type which receive implementation types, or when a type should be immutable but needs to be mutable internally. The interface should have the model type name, and the implementation (within `.implementation.models`) should be named `<interfaceName>Impl`.

#### Enumerations

Enumerations in Java are extremely convenient, but used improperly can lead to breaking changes to the API. This is because often the Java compiler is configured to fail if not all enum values are listed in a switch statement, so with the addition of a new enum value, users will encounter breaking builds when updating their dependency to a newer version. Because of this, the Java azure-core ships with the `ExpandableStringEnum` that is the suggested means through which enumerations are exposed. Whilst not technically a Java enumeration, it can be treated as such in much the same way, without concerns about breaking changes from adding new values. It is also more user-friendly when new values are introduced on the service side before a library update has been shipped, as users can manually create their own values within the context of a single `ExpandableStringEnum`.

{% include requirement/MUSTNOT id="java-enums" %} define Java enum types for parameters, properties, and return types, except in two scenarios:

1) When values are fixed and will never change over time, or,
2) When the enum is used as an input-only enum and therefore the likelihood of users running into breaking changes (i.e. when they must `switch` over all values) is low.

{% include requirement/MUST id="java-naming-enum-uppercase" %} use all upper-case names for enum (and `ExpandableStringEnum`) values. `EnumType.FOO` and `EnumType.TWO_WORDS` are valid, whereas `EnumType.Foo` and `EnumType.twoWords` are not.

{% include requirement/MAY id="java-expandable-enums" %} use the `ExpandableStringEnum` type provided by azure-core to define an enum-like API that declares well-known fields but which can also contain unknown values returned from the service, or user-defined values passed to the service. An example expandable enum, taken from azure-core's `OperationStatus` type, is shown below:

```java
public static final class OperationStatus extends ExpandableStringEnum<OperationStatus> {
    public static final OperationStatus NOT_STARTED = fromString("NOT_STARTED");
    public static final OperationStatus IN_PROGRESS = fromString("IN_PROGRESS");
    public static final OperationStatus SUCCESSFULLY_COMPLETED = fromString("SUCCESSFULLY_COMPLETED");
    public static final OperationStatus FAILED = fromString("FAILED");
    public static final OperationStatus USER_CANCELLED = fromString("USER_CANCELLED");

    /**
     * Creates or finds a {@link OperationStatus} from its string representation.
     * @param name a name to look for
     * @return the corresponding {@link OperationStatus}
     */
    public static OperationStatus fromString(String name) {
        return fromString(name, OperationStatus.class);
    }
}
```

#### Using Azure Core Types

{% include requirement/MUST id="java-core-types-must" %} make use of packages in Azure Core to provide behavior consistent across all Azure SDK libraries. This includes, but is not limited to:

* `HttpClient`, `HttpPipeline`, `Response`, etc for http client, pipeline and related functionality
* `ClientLogger` for logging
* `PagedFlux` and `PagedIterable` for returning paged results
* `SyncPoller` and `PollerFlux` for long running operations
* `TokenCredential`, `AzureKeyCredential`, etc for common auth interfaces

See the [Azure Core readme](https://github.com/Azure/azure-sdk-for-java/tree/main/sdk/core/azure-core) for more details.

#### Using Primitive Types

{% include requirement/MUSTNOT id="java-api-old-date-time" %} create API that exposes the old Java date library (e.g. `java.util.Date`, `java.util.Calendar`, and `java.util.Timezone`). All API must use the new date / time APIs that shipped in JDK 8 in the `java.time` package.

{% include requirement/MUSTNOT id="java-api-url" %} create API that exposes the `java.net.URL` API. This API is difficult to work with, and more frequently gets in the users way rather than provide any real assistance. Instead, use the String type to represent the URL. When it is necessary to parse this String into a URL, and if it fails to be parsed (throwing a checked `MalformedURLException`), catch this internally and throw an unchecked `IllegalArgumentException` instead.

{% include requirement/MUST id="java-api-file-paths" %} represent file paths using the Java `java.nio.file.Path` type. Do not use String or the older `java.io.File` type.

{% include requirement/MUST id="java-wrap-primitives" %} wrap primitive types where appropriate to represent a meaningful domain entity even if the model type contains a single field. For example, a phone number is just a string, but creating a new type to wrap primitive `String` type can be more informative and represents a domain concept. It may also provide stronger guarantees and validation than just the primitive type.

```java
public final class PhoneNumber {
    private String phoneNumber;

    public PhoneNumber setPhoneNumber(String phoneNumber) {
        ...
    }

    public String getPhoneNumber() {
        ...
    }
}
```

### Exceptions

Error handling is an important aspect of implementing a client library. It is the primary method by which problems are communicated to the consumer. We convey errors to developers by throwing appropriate exceptions from our service methods.

{% include requirement/MUST id="java-errors-http-request-failed" %} throw an exception when any HTTP request fails with an HTTP status code that is not defined by the service/Swagger as a successful status code.

{% include requirement/MUST id="java-errors-unchecked-exceptions" %} use unchecked exceptions. Java offers checked and unchecked exceptions, where checked exceptions force the user to introduce verbose `try .. catch` code blocks and handle each specified exception. Unchecked exceptions avoid verbosity and improve scalability issues inherent with checked exceptions in large apps.

In the case of a higher-level method that produces multiple HTTP requests, either the last exception or an aggregate exception of all failures should be produced.

{% include requirement/MUST id="java-errors-system-errors" %} use the following standard Java exceptions for pre-condition checking:

| Exception                       | When to use                                                    |
|---------------------------------|----------------------------------------------------------------|
| `IllegalArgumentException`      | When a method argument is non-null, but inappropriate          |
| `IllegalStateException`         | When the object state means method invocation can't continue   |
| `NullPointerException`          | When a method argument is `null` and `null` is unexpected      |
| `UnsupportedOperationException` | When an object doesn't support method invocation               |

{% include requirement/MUSTNOT id="java-errors-no-new-errors" %} create a new error type when a language-specific error type will suffice.

{% include requirement/MUST id="java-errors-document-all" %} specify all checked and unchecked exceptions thrown in a method within the JavaDoc documentation on the method as `@throws` statements.

{% include requirement/MUST id="java-errors-exception-tree" %} use the existing exception types present in the Azure core library for service request failures. Avoid creating new exception types. The following list outlines all available exception types (with indentation indicating exception type hierarchy):

- `AzureException`: Never use directly. Throw a more specific subtype.
  - `HttpResponseException`: Thrown when an unsuccessful response is received with http status code (e.g. 3XX, 4XX, 5XX) from the service request.
    - `ClientAuthenticationException`: Thrown when there's a failure to authenticate against the service.
    - `DecodeException`: Thrown when there's an error during response deserialization.
    - `ResourceExistsException`: Thrown when an HTTP request tried to create an already existing resource.
    - `ResourceModifiedException`: Thrown for invalid resource modification with status code of 4XX, typically 412 Conflict.
    - `ResourceNotFoundException`: Thrown when a resource is not found, typically triggered by a 412 response (for PUT) or 404 (for GET/POST).
    - `TooManyRedirectsException`: Thrown when an HTTP request has reached the maximum number of redirect attempts.
  - `ServiceResponseException`: Thrown when the request was sent to the service, but the client library wasn't able to understand the response.
  - `ServiceRequestException`: Thrown for an invalid response with custom error information.

{% include requirement/MUST id="java-errors-new-exceptions" %} extend from one of the above exceptions defined in azure-core when defining a new service-specific exception. Do not extend from `RuntimeException` directly.

{% include requirement/MUST id="java-errors-exception-public" %} define exception type in a public package if the exception is thrown from a public API. Do not throw an exception that is defined as package-private or is defined in `implementation` package.

### Authentication

Azure services use a variety of different authentication schemes to allow clients to access the service.  Conceptually, there are two entities responsible in this process: a credential and an authentication policy.  Credentials provide confidential authentication data.  Authentication policies use the data provided by a credential to authenticate requests to the service.

Primarily, all Azure services should support Azure Active Directory OAuth token authentication, and all clients of services that support Azure Active Directory OAuth token authentication must support authenticating requests in this manner.

{% include requirement/MUST id="java-auth-fluent-builder" %} provide service client fluent builder APIs that accepts an instance of the appropriate azure-core credential abstraction, namely `TokenCredential`, `BasicAuthenticationCredential`, or `AzureKeyCredential`.

{% include requirement/MUSTNOT id="auth-client-no-token-persistence" %} persist, cache, or reuse tokens beyond the validity period of the given token. If any caching is implemented, the token credential must be given the opportunity to refresh before it expires.

{% include requirement/MUST id="java-auth-use-core" %} use authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="java-auth-reserve-when-not-suported" %} reserve the API surface needed for TokenCredential authentication, in the rare case that a service does not yet support Azure Active Directory authentication.

In addition to Azure Active Directory OAuth, services may provide custom authentication schemes. In this case the following guidelines apply.

{% include requirement/MUST id="java-auth-support" %} support all authentication schemes that the service supports.

{% include requirement/MUST id="java-auth-provide-credential-types" %} define a public custom credential type which enables clients to authenticate requests using the custom scheme.

{% include requirement/SHOULDNOT id="java-auth-credential-type-base" %} define custom credential types extending or implementing the TokenCredential abstraction from Azure Core. This is especially true in type safe languages where extending or implementing this abstraction would break the type safety of other service clients, allowing users to instantiate them with the custom credential of the wrong service.

{% include requirement/MUST id="java-auth-credential-type-placement" %} define custom credential types in the same namespace and package as the client, or in a service group namespace and shared package, not in Azure Core or Azure Identity.

{% include requirement/MUSTNOT id="java-auth-azure-identity-dependency" %} take compile-scope dependency on `azure-identity` library.

{% include requirement/MUST id="java-auth-credential-type-prefix" %} prepend custom credential type names with the service name or service group name to provide clear context to its intended scope and usage.

{% include requirement/MUST id="java-auth-credential-type-suffix" %} append Credential to the end of the custom credential type name. Note this must be singular not plural.

{% include requirement/MUST id="java-auth-provide-credential-constructor" %} define a constructor or factory for the custom credential type which takes in ALL data needed for the custom authentication protocol.

{% include requirement/MUST id="java-auth-provide-update-method" %} define an update method which accepts all mutable credential data, and updates the credential in an atomic, thread safe manner.

{% include requirement/MUSTNOT id="java-auth-credential-set-properties" %} define public settable properties or fields which allow users to update the authentication data directly in a non-atomic manner.

{% include requirement/SHOULDNOT id="java-auth-credential-get-properties" %} define public properties or fields which allow users to access the authentication data directly. They are most often not needed by end users, and are difficult to use in a thread safe manner. In the case that exposing the authentication data is necessary, all the data needed to authenticate requests should be returned from a single API which guarantees the data returned is in a consistent state.

{% include requirement/MUST id="java-auth-provide-client-constructor" %} provide service client constructors or factories that accept all supported credential types.

Client libraries may support providing credential data via a connection string __ONLY IF__ the service provides a connection string to users via the portal or other tooling.   Connection strings are generally good for getting started as they are easily integrated into an application by copy/paste from the portal.  However, connection strings are considered a lesser form of authentication because the credentials cannot be rotated within a running process.

{% include requirement/MUSTNOT id="java-auth-connection-strings" %} support constructing a service client with a connection string unless such connection string is available within the Azure portal or Azure CLI.

### Namespaces

Java uses packages to group related types.  Grouping services within a cloud infrastructure is common since it aids discoverability and provides structure to the reference documentation.

In Java, the namespace should be named `com.azure.<group>.<service>[.<feature>]`.  All consumer-facing APIs that are commonly used should exist within this package structure.  Here:

- `<group>` is the group for the service (see the list above)
- `<service>` is the service name represented as a single word
- `<feature>` is an optional subpackage to break services into separate components (for example, storage may have `.blob`, `.files`, and `.queues`)

{% include requirement/MUST id="java-namespaces-prefix" %} start the package with `com.azure` to indicate an Azure client library.

{% include requirement/MUST id="java-namespaces-format" %} construct the package name with all lowercase letters (no camel case is allowed), without spaces, hyphens, or underscores. For example, Azure Key Vault would be in `com.azure.security.keyvault` - note that the two words 'Key' and 'Vault' are brought together to `keyvault`, instead of `keyVault`, `key_vault`, or `key-vault`.  It may further be shortened if the shortened version is well known in the community.  For example, "Azure Media Analytics" would have a compressed service name of `mediaanalytics`, and "Azure Service Bus" would become `servicebus`.

{% include requirement/MUST id="java-namespaces-package-name" %} pick a package name that allows the consumer to tie the package to the service being used. The package does **NOT** change when the branding of the product changes.  Avoid the use of marketing names that may change.

{% include requirement/MUST id="java-namespaces-approved-list" %} use the following list as the group of services:

{% include tables/data_namespaces.md %}

If the client library does not seem to fit into the group list, contact the [Architecture Board] to discuss the namespace requirements.

{% include requirement/MUST id="java-namespaces-management" %} place the management (Azure Resource Manager) API in the `resourcemanager` group.  Use the grouping `com.azure.resourcemanager.<service>` for the namespace. Management plane libraries do not have a `<group>`.

{% include requirement/MUST id="java-namespaces-registration" %} register the chosen namespace with the [Architecture Board].  Open an issue to request the namespace.  See [the registered namespace list](registered_namespaces.html) for a list of the currently registered namespaces.

#### Example Namespaces

Here are some examples of namespaces that meet these guidelines:

- `com.azure.identity.activedirectory`
- `com.azure.iot.deviceprovisioning`
- `com.azure.storage.blob`
- `com.azure.messaging.notificationhubs` (the client library for Notification Hubs)
- `com.azure.resourcemanager.notificationhubs` (the management library for Notification Hubs)

Here are some namespaces that do not meet the guidelines:

- `com.microsoft.azure.cosmosdb` (not in the `com.azure` namespace and does not use grouping)
- `com.azure.cognitiveservice.vision` (the grouping `cognitiveservice` is not in the approved list)

### Support for Mocking

All client libraries must support mocking to enable non-live testing of service clients by customers. One of the key things we want to support is to allow consumers of the library to easily write repeatable unit-tests for their applications without activating a service. This allows them to reliably and quickly test their code without worrying about the vagaries of the underlying service implementation (including, for example, network conditions or service outages). Mocking is also helpful to simulate failures, edge cases, and hard to reproduce situations (for example: does code work on February 29th).

Below is an example of writing a mock unit test using the [Mockito framework](https://site.mockito.org/). For more details on using Mockito in the context of the Azure SDK for Java, refer to the [unit testing](https://github.com/Azure/azure-sdk-for-java/wiki/Unit-Testing) wiki documentation.

```java
public class UserPreferencesTest {
    @Test
    public void getThemeTest() {
        // create a mock instance of client
        ConfigurationClient configurationClient = mock(ConfigurationClient.class);

        // mock the client response
        when(configurationClient.getSetting("theme", null)).thenReturn(new ConfigurationSetting().setValue("light"));

        // wire the mock client to UserPreferences
        UserPreferences userPreferences = new UserPreferences(configurationClient);

        // assert the client response
        assertEquals(Theme.LIGHT, userPreferences.getTheme());
    }
}
```

{% include requirement/MUST id="java-mocking" %} support mocking to enable non-live testing of service clients (and by extension also model types, option types, etc) by customers.

{% include requirement/MUST id="java-mocking-io" %} support mocking of all IO operations (including network and file operations).

## Azure SDK Library Design

### Packaging

#### Maven

All client libraries for Java standardize on the Maven build tooling for build and dependency management. This section details the standard configuration that must be used in all client libraries.

{% include requirement/MUST id="java-maven-pom" %} ship a maven pom.xml for each client library, or for each module within that client library (e.g. Storage might have one each for blob, queue, and file).

{% include requirement/MUST id="java-maven-groupid" %} specify the `groupId` as `com.azure`.

{% include requirement/MUST id="java-maven-artifactid" %} specify the `artifactId` to be of the form `azure-<group>-<service>`, for example, `azure-storage-blob`. In cases where the client library has multiple children modules, set the root POM `artifactId` to be of the form `azure-<group>-<service>-parent`.

{% include requirement/MUST id="java-maven-name" %} specify the `name` element to take the form `Microsoft Azure client library for <service name>`.

{% include requirement/MUST id="java-maven-description" %} specify the `description` element to be a slightly longer statement along the lines of `This package contains the Microsoft Azure <service> client library`.

{% include requirement/MUST id="java-maven-url" %} specify the `url` element to point to the root of the GitHub repository (i.e. `https://github.com/Azure/azure-sdk-for-java`).

{% include requirement/MUST id="java-maven-scm" %} specify the source code management section, to specify where the source code resides for the client library. If the source code is located in the https://github.com/Azure/azure-sdk-for-java repository, then the following form must be used:

```
<scm>
    <url>scm:git:https://github.com/Azure/azure-sdk-for-java</url>
    <connection>scm:git:git@github.com:Azure/azure-sdk-for-java.git</connection>
    <tag>HEAD</tag>
</scm>
```

{% include requirement/MUSTNOT id="java-maven-developers" %} change the `developers` section of the POM file - it must only list a developer `id` of `microsoft` and a `name` of `Microsoft Corporation`.

#### Service-Specific Common Libraries

There are occasions when common code needs to be shared between several client libraries. For example, a set of cooperating client libraries may wish to share a set of exceptions or models.

{% include requirement/MUST id="java-commonlib-approval" %} gain [Architecture Board] approval prior to implementing a common library.

{% include requirement/MUST id="java-commonlib-minimize-code" %} minimize the code within a common library. Code within the common library is available to the consumer of the client library and shared by multiple client libraries within the same namespace.

{% include requirement/MUST id="java-commonlib-namespace" %} store the common library in the same namespace as the associated client libraries.

A common library will only be approved if:

* The consumer of the non-shared library will consume the objects within the common library directly, AND
* The information will be shared between multiple client libraries.

Let's take two examples:

1. Implementing two Cognitive Services client libraries, we find a model is required that is produced by one Cognitive Services client library and consumed by another Cognitive Services client library, or the same model is produced by two client libraries. The consumer is required to do the passing of the model in their code, or may need to compare the model produced by one client library vs. that produced by another client library. This is a good candidate for choosing a common library.

2. Two Cognitive Services client libraries throw an `ObjectNotFound` exception to indicate that an object was not detected in an image. The user might trap the exception, but otherwise will not operate on the exception. There is no linkage between the `ObjectNotFound` exception in each client library. This is not a good candidate for creation of a common library (although you may wish to place this exception in a common library if one exists for the namespace already). Instead, produce two different exceptions - one in each client library.

#### Java 9 Modules

Java 9 and later support the notion of a module. A module *exports* certain packages, and *requires* other modules. Any package that is exported can be used by other modules, and anything that is not exported is invisible at compile and run times. This is a far stronger form of encapsulation than has existed previously for Java. For the Azure SDK for Java, a client library will be represented as one or more modules. Two good resources to understand modules are available on [oracle.com](https://www.oracle.com/corporate/features/understanding-java-9-modules.html) and [baeldung.com](https://www.baeldung.com/java-9-modularity).

{% include requirement/MUST id="java-module-info" %} include a `module-info.java` file for each module you ship.

{% include requirement/MUST id="java-module-name" %} name your module based on the root package of the client library it represents. For example, `com.azure.core` or `com.azure.storage.blob`.

{% include requirement/MUST id="java-module-requires" %} require only the minimum set of modules relevant for the module being developed.

{% include requirement/MUST id="java-module-exports" %} export only packages that are considered public API. In particular, do **not** export packages that are in the `implementation` package namespace, as these, by convention, are not intended for public use.

{% include requirement/MUSTNOT id="java-module-no-conditional-exports" %} conditionally `export` or `opens` packages to other modules without prior approval by the architecture board. A conditional `export` or `opens` statement takes the form `export X to Y` or `opens X to Y`.

{% include requirement/MUSTNOT id="java-module-split-packages" %} have the same package in multiple modules. That is, do not have `com.azure.storage.blob` in module `com.azure.storage.blob` and in module `com.azure.storage.blob.extras`. It is however allowed to have different packages with common parent packages split across different modules. For example, a package named `com.azure.storage` can be in one module, and `com.azure.storage.blob` can be in another.

### Versioning

{% include requirement/MUST id="java-versioning-backwards-compatibility" %} be 100% backwards compatible with older versions of the same package.

{% include requirement/MUST id="java-versioning-highest-api" %} call the highest supported service API version by default, and ensure this is clearly documented.

{% include requirement/MUST id="java-versioning-select-api-version-java-9" %} allow the consumer to explicitly select a supported service API version when instantiating the service client, by using the service client builder with a property called `serviceVersion`. This method must take a type implementing the `ServiceVersion` interface, named specifically for the service, but as generally as possible. For example, `IdentityServiceVersion` for Identity. For a service with multiple sub-services, such as Storage, if the services all share a common versioning system, `StorageServiceVersion` would suffice. If they did not, it would be necessary to have separate `BlobServiceVersion`, `QueueServiceVersion`, and `FileServiceVersion` enums.

{% include requirement/MUST id="java-versioning-enum-latest" %} offer a `getLatest()` method on the enum that returns the latest service version. If a consumer doesn't specify a service version, the builder will call `getLatest()` to obtain the appropriate service version.

{% include requirement/MUST id="java-versioning-enum--value-naming" %} use the version naming used by the service itself in naming the version values in the enum. The standard approach takes the form `V<year>_<month>_<day>`, such as `V2019_05_09`. Being consistent with the service naming enables easier cross-referencing between service versions and the availability of features in the client library.

{% include note.html content="Third-party reusable libraries shouldn't change behavior without an explicit decision by the developer.  When developing libraries that are based on the Azure SDK, lock the library to a specific service version to avoid changes in behavior." %}

{% include requirement/MUST id="java-versioning-new-package" %} introduce a new library (with new library names, new package names, and new type names) if you must do an API breaking change.

Breaking changes should happen rarely, if ever.  Register your intent to do a breaking change with [adparch]. You'll need to have a discussion with the language architect before approval.

#### Client Version Numbers {#java-versionnumbers}

Consistent version number scheme allows consumers to determine what to expect from a new version of the library.

{% include requirement/MUST id="java-version-semver" %} use _MAJOR_._MINOR_._PATCH_ format for the library version.

Use `-beta.N` suffix for beta package versions. For example, `1.0.0-beta.2`.

{% include requirement/MUST id="java-version-change-on-release" %} change the version number of the client library when **ANYTHING** changes in the client library.

{% include requirement/MUST id="java-version-patching" %} increment the patch version when fixing a bug.

{% include requirement/MUSTNOT id="java-version-features-in-patch" %} include new APIs in a patch release.

{% include requirement/MUST id="java-version-add-feature" %} increment the major or minor version when adding support for a service API version.

{% include requirement/MUST id="java-version-add-api" %} increment the major or minor version when adding a new method to the public API.

{% include requirement/SHOULD id="java-version-major-changes" %} increment the major version when making large feature changes.

{% include requirement/MUST id="java-version-change-on-release1" %} select a version number greater than the highest version number of any other released Track 1 packages for the service in all languages.

### Dependencies

Dependencies bring in many considerations that are often easily avoided by avoiding the dependency.

- **Versioning** - Many programming languages do not allow a consumer to load multiple versions of the same package. So, if we have an client library that requires v3 of package Foo and the consumer wants to use v5 of package Foo, then the consumer cannot build their application. This means that client libraries should not have dependencies by default.
- **Size** - Consumer applications must be able to deploy as fast as possible into the cloud and move in various ways across networks. Removing additional code (like dependencies) improves deployment performance.
- **Licensing** - You must be conscious of the licensing restrictions of a dependency and often provide proper attribution and notices when using them.
- **Compatibility** - Often times you do not control a dependency and it may choose to evolve in a direction that is incompatible with your original use.
- **Security** - If a security vulnerability is discovered in a dependency, it may be difficult or time consuming to get the vulnerability corrected if Microsoft does not control the dependency's code base.

{% include requirement/MUST id="java-dependencies-azure-core" %} depend on the `com.azure.core` library for functionality that is common across all client libraries.  This library includes APIs for HTTP connectivity, global configuration, logging, and credential handling.

{% include requirement/MUSTNOT id="java-dependencies-approved-list" %} be dependent on any other packages within the client library distribution package, with the exception of the following:

{% include_relative approved_dependencies.md %}

Dependency versions are purposefully not specified in this table. The definitive source for the dependency versions being used in all client libraries is [published in a separate document that is generated from the azure-sdk-for-java code repository](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/staging/dependency-whitelist.html). Transitive dependencies of these libraries, or dependencies that are part of a family of dependencies, are allowed.  For example, `reactor-netty` is a child project of `reactor`.

{% include requirement/MUSTNOT id="java-dependencies-archboard" %} introduce new dependencies on third-party libraries that are already referenced from the parent POM, without first discussing with the Architecture Board].

{% include requirement/MUSTNOT id="java-dependencies-versions" %} specify or change dependency versions in your client library POM file. All dependency versioning must be [centralized through existing tooling](https://github.com/Azure/azure-sdk-for-java/blob/main/CONTRIBUTING.md#versions-and-versioning).

{% include requirement/MUSTNOT id="java-dependencies-snapshot" %} include dependencies on external libraries that are -SNAPSHOT versions. All dependencies must be released versions.

{% include requirement/SHOULD id="java-dependencies-vendoring" %} consider copying or linking required code into the client library in order to avoid taking a dependency on another package that could conflict with the ecosystem. Make sure that you are not violating any licensing agreements and consider the maintenance that will be required of the duplicated code. ["A little copying is better than a little dependency"][1] (YouTube).

{% include requirement/MUSTNOT id="java-dependencies-concrete" %} depend on concrete logging, dependency injection, or configuration technologies (except as implemented in the `com.azure.core` library).  The client library will be used in applications that might be using the logging, DI, and configuration technologies of their choice.

### Native code

Native code plugins cause compatibility issues and require additional scrutiny. Certain languages compile to a machine-native format (for example, C or C++), whereas most modern languages opt to compile to an intermediary format to aid in cross-platform support.

{% include requirement/MUSTNOT id="java-no-native-code" %} write platform-specific / native code.

### Documentation

{% include requirement/MUST id="java-javadoc-build" %} ensure that anybody can clone the repo containing the client library and execute `mvn javadoc:javadoc` to generate the full and complete JavaDoc output for the code, without any need for additional processing steps.

{% include requirement/MUST id="java-javadoc-full-docs" %} include descriptive text of the method, as well as all parameters, the returned value (if any), all checked exceptions, as well as all unchecked exceptions. Failing to document unchecked exceptions means that users do not have any indication of how they can handle exceptional circumstances.

{% include requirement/MUST id="java-javadoc-samples" %} include code samples in all class-level JavaDoc, and in relevant method-level JavaDoc.

{% include requirement/MUSTNOT id="java-javadoc-hard-coding" %} hard-code the sample within the JavaDoc (where it may become stale). Put code samples in `/src/samples/java` and use the available tooling to reference them.

{% include requirement/MUST id="java-javadoc-naming-samples" %} follow the naming convention outlined below for naming samples tags:

 * If a new instance of the class is created through build() method of a builder or through constructor: `<packagename>.<classname>.instantiation`
 * For other methods in the class: `<packagename>.<classname>.<methodName>`
 * For overloaded methods, or methods with arguments: `<packagename>.<classname>.<methodName>#<argType1>-<argType2>`
 * Camel casing for the method name and argument types is valid, but not required.

## Repository Guidelines

### Documentation

#### General guidelines

{% include requirement/MUST id="java-docs-content-dev" %} include your service's content developer in the architectural review for your library. To find the content developer you should work with, check with your team's Program Manager.

{% include requirement/MUST id="java-docs-contributors-guide" %} follow the [Azure SDK Contributors Guide] (MICROSOFT INTERNAL)

{% include requirement/MUST id="java-docs-style-guide" %} adhere to the Microsoft style guides when you write public-facing documentation. (MICROSOFT INTERNAL)

* [Microsoft Writing Style Guide]
* [Microsoft Cloud Style Guide]

Use the style guides for both long-form documentation like a README and the `docstrings` in your code.

{% include requirement/SHOULD id="java-docs-into-silence" %} attempt to document your library into silence. Preempt developers' usage questions and minimize GitHub issues by clearly explaining your API in the `docstrings`. Include information on service limits and errors they might hit, and how to avoid and recover from those errors.

As you write your code, doc it so you never hear about it again. The fewer questions you have to answer about your client library, the more time you have to build new features for your service.

{% include requirement/MUSTNOT id="java-docs-maven-versions" %} include version details when specifying Maven dependency statements. Always refer the user back to a central document detailing how to use the Azure SDK for Java BOM.

#### Samples

Code samples are small applications that demonstrate a certain feature that is relevant to the client library.  Samples allow developers to quickly understand the full usage requirements of your client library. Code samples shouldn't be any more complex than they needed to demonstrate the feature. Don't write full applications. Samples should have a high signal to noise ratio between useful code and boilerplate code for non-related reasons.

{% include requirement/MUST id="java-samples-include-them" %} include code samples alongside your library's code within the repository. The samples should clearly and succinctly demonstrate the code most developers need to write with your library. Include samples for all common operations.  Pay attention to operations that are complex or might be difficult for new users of your library. Include samples for the champion scenarios you've identified for the library.

{% include requirement/MUST id="java-samples-location" %} place code samples within the `/src/samples/java` directory within the client library root directory. The samples will be compiled, but not packaged into the resulting jar.

{% include requirement/MUST id="java-samples-main" %} ensure that each sample file is executable by including a `public static void main(String[] args)` method.

{% include requirement/MUST id="java-samples-coding-style" %} use the latest coding conventions when creating samples. Make liberal use of modern Java syntax and APIs (for example, diamond operators) as they remove boilerplate from your samples and highlight you library. Don't use any language feature or API of Java the currently supported Java baseline.  The current supported Java version is Java 8.

{% include requirement/MUST id="java-samples-use-latest-library" %} compile sample code using the latest major release of the library. Review sample code for freshness.  At least one commit must be made (to update dependencies) to each sample per semester.

{% include requirement/MUST id="java-samples-grafting" %} ensure that code samples can be easily grafted from the documentation into a users own application.  For example, don't rely on variable declarations in other samples.

{% include requirement/MUST id="java-samples-readability" %} write code samples for ease of reading and comprehension over code compactness and efficiency.

{% include requirement/MUST id="java-samples-platform-support" %} ensure that samples can run in Windows, macOS, and Linux development environments.  Don't use a non-standard developer toolchain.

{% include requirement/MUST id="java-samples-build-code" %} build and test your code samples using the repository's continuous integration (CI) to ensure they remain functional.

{% include requirement/MUSTNOT id="java-snippets-no-combinations" %} combine multiple operations in a code sample unless it's required for demonstrating the type or member. For example, a Cosmos DB code sample doesn't include both account and container creation operations.  Create a sample for account creation, and another sample for container creation.

Combined operations require knowledge of additional operations that might be outside their current focus. The developer must first understand the code surrounding the operation they're working on, and can't copy and paste the code sample into their project.

## Java API Best Practices

This section introduces guidelines for fundamental Java development design decisions that are used throughout the Azure SDK for Java. For further guidance, consider reviewing presentations and documentation on [Java API design best practices](https://www.jonathangiles.net/java-api-design-best-practices.html).

### Naming Patterns

Using a consistent set of naming patterns across all client libraries will ensure a consistent and more intuitive developer experience. This section outlines good practices for naming that must be followed by all client libraries.

{% include requirement/MUST id="java-naming-succinct" %} prefer succinctness over verbosity in method and class names, except when readability is impacted. A few examples include:

* A class may want to return an identifier to a user. There is no additional value in the fully-qualified `getIdentifier()` compared with the shorter and equally-descriptive `getId()`.
* A method called `getName()` is short, but may leave some doubt in the users mind about which name is being represented. Instead, naming this method `getLinkName()` will remove all doubt from the users mind, and without substantial additional verbosity. Similarly, in the case of `getId()` above, always choose to specify the identifier name if there is any likelihood of confusion about which identifier is being referenced. For example, use `getTenantId()` rather than `getId()`, unless it is completely unambiguous as to which identifier is being referenced.

{% include requirement/MUSTNOT id="java-naming-uppercase-acronyms" %} fully uppercase acronyms. APIs must take the form of `getHttpConnection()` or `getUrlName()` rather than `getHTTPConnection()` or `getURLName()`.

{% include requirement/MUST id="java-naming-service-acronyns" %} use service-specific acronyms sparingly in API. Whereas most users will accept a method including `Http` or `Url` in the name, most users will not know what `Sas` or `Cpk` mean. Where possible (without breaking the succinctness over verbosity requirement above), expansion of acronyms, or at the very least sufficient documentation at class and method levels to describe the acronym, must be considered.

{% include requirement/MUST id="java-naming-host-vs-hostname" %} use the correct naming for 'host' vs 'hostname'. 'hostname' is the host name without any port number, whereas 'host' is the hostname with the port number.

{% include requirement/MUSTNOT id="java-naming-camel-case" %} use camel case on words that are commonly accepted in their combined form. For example, 'hostname' should be spelt as `hostname` rather than `hostName`, and 'username' should be spelt as `username` rather than `userName`.

{% include requirement/MUSTNOT id="java-interface-i-prefix" %} name interface types with an 'I' prefix, e.g. `ISearchClient`. Instead, do not have any prefix for an interface, preferring `SearchClient` as the name for the interface type in this case.

{% include refs.md %}
{% include_relative refs.md %}
