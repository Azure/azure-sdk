---
title: "Android Guidelines: API Design"
keywords: guidelines android
permalink: android_design.html
folder: android
sidebar: android_sidebar
---

{% include draft.html content="The Android guidelines are in DRAFT status" %}

You do not have to write a special client library for Android in most cases. The standard Java client library will be used when paired with the Android-specific Azure Core library.  If you do need to create a specific Android edition, carefully consider the part of the service that will be accessed from the mobile app.  Not all methods will be equally relevant to mobile workloads.

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.  

## Namespaces

Java uses packages to group related types.  Grouping services within a cloud infrastructure is common since it aids discoverability and provides structure to the reference documentation.

In Java, the namespace should be named `com.azure.<group>.<service>[.<feature>]`.  All consumer-facing APIs that are commonly used should exist within this package structure.  Here:

- `<group>` is the group for the service (see the list above)
- `<service>` is the service name represented as a single word
- `<feature>` is an optional subpackage to break services into separate components (for example, storage may have `.blob`, `.files`, and `.queues`)

{% include requirement/MUST id="android-namespaces-prefix" %} start the package with `com.azure` to indicate an Azure client library.

{% include requirement/MUST id="android-namespaces-format" %} construct the package name with all lowercase letters (no camel case is allowed), without spaces, hyphens, or underscores. For example, Azure Key Vault would be in `com.azure.security.keyvault` - note that the two words 'Key' and 'Vault' are brought together to `keyvault`, instead of `keyVault`, `key_vault`, or `key-vault`.  It may further be shortened if the shortened version is well known in the community.  For example, "Azure Media Analytics" would have a compressed service name of `mediaanalytics`, and "Azure Service Bus" would become `servicebus`.

{% include requirement/MUST id="android-namespaces-package-name" %} pick a package name that allows the consumer to tie the package to the service being used. The package does **NOT** change when the branding of the product changes.  Avoid the use of marketing names that may change.

{% include requirement/MUST id="android-namespaces-approved-list" %} use the following list as the group of services:

{% include tables/data_namespaces.md %}

If the client library does not seem to fit into the group list, contact the [Architecture Board] to discuss the namespace requirements.

{% include requirement/MUST id="android-namespaces-management" %} place the management (Azure Resource Manager) API in the `management` group.  Use the grouping `<AZURE>.management.<group>.<service>` for the namespace. Since more services require control plane APIs than data plane APIs, other namespaces may be used explicitly for control plane only.  Data plane usage is by exception only.  Additional namespaces that can be used for control plane SDKs include:

{% include tables/mgmt_namespaces.md %}

Many `management` APIs do not have a data plane because they deal with management of the Azure account. Place the management library in the `com.azure.management` namespace.  For example, use `com.azure.management.costanalysis` instead of `com.azure.management.management.costanalysis`.

{% include requirement/MUSTNOT id="android-namespaces-ambiguity" %} choose similar names for clients that do different things.

> **DEVIATION** This talks about needing two clients - one that represents the service and one that represents how it appears on the Android client.  For example, you might have an appconfiguration client, but an android.appconfiguration client would be specific to Android that, for example, implements Jetpack config.  I see this being important only in a minor amount of cases.

{% include/requirement/MUST id="android-specific-namespace" %} use `android` as the feature segment of the namespace in cases where you need to produce an Android-specific client distinct from the main service client.

{% include requirement/MUST id="android-namespaces-registration" %} register the chosen namespace with the [Architecture Board].  Open an issue to request the namespace.  See [the registered namespace list](registered_namespaces.html) for a list of the currently registered namespaces.

## Client interface

Your API surface consists of one or more _service clients_ that the consumer will instantiate to connect to your service, plus a set of supporting types.

{% include requirement/MUST id="android-client-naming" %} name service client types with the _Client_ suffix.

{% include requirement/MUST id="android-client-location" %} place service client types that the consumer is most likely to interact with in the root package of the client library (for example, `com.azure.messaging.servicebus`).  Specialized service clients should be placed in subpackages.

{% include requirement/MUST id="android-client-constructor-minimal" %} allow the consumer to construct a service client with the minimal information needed to connect and authenticate to the service.

{% include requirement/MUST id="android-client-verb-prefix" %} standardize verb prefixes within a set of client libraries for a service.  

We speak about using the client library in a cross-language manner within outbound materials such as documentation, blogs, and public speaking.

> **DEVIATION** You don't need to support 100% of the service.  Only mobile-specific use cases need to be supported.

{% include requirement/MUST id="android-client-feature-support" %} support only those features provided by the Azure service that a mobile app would access.  While gaps in functionality do cause frustration, binary size in the mobile ecosystem is of a bigger concern.  **DO** be consistent with other mobile platforms in feature support (for example, iOS).

## Network requests

The client library wraps HTTP requests so it's important to support standard network capabilities.  Asynchronous programming techniques aren't widely understood.  However, such techniques are essential in developing resilient web services.  Many developers prefer synchronous method calls for their easy semantics when learning how to use a technology.  Consumers also expect certain capabilities in a network stack (such as call cancellation, automatic retry, and logging).

{% include requirement/MUST id="android-network-sync-and-async" %} support both synchronous and asynchronous service clients.

{% include requirement/MUST id="android-network-packaging-for-sync-and-async" %} have [separate service clients] for sync and async APIs.  The consumer needs to identify which methods are async and which are sync.

## Authentication

Azure services use different kinds of authentication schemes to allow clients to access the service.  Conceptually, there are two entities responsible in this process: a credential and an authentication policy.  Credentials provide confidential authentication data.  Authentication policies use the data provided by a credential to authenticate requests to the service.  

{% include requirement/MUST id="android-auth-support" %} support all authentication techniques that the service supports and that make sense in a mobile context.  Service principal authentication generally does not make sense, for example.

{% include requirement/MUST id="android-auth-azure-core" %} use credential and authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="android-auth-credentials" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service.  If using a service-specific credential type, the implementation must be non-blocking and atomic.

{% include requirement/MUST id="android-auth-fluent-builder" %} provide service client fluent builder APIs that accept all supported authentication credentials.

A connection string is a combination of an endpoint, credential data, and other options used to simplify service client configuration.  

{% include requirement/MUSTNOT id="android-auth-connection-strings"%} support connection strings.  Connection strings are insecure in the context of a mobile app.

## Response formats

Requests to the service fall into two basic groups: methods that make a single logical request, and methods that make a deterministic sequence of requests.  An example of a *single logical request* is a request that may be retried inside the operation.  An example of a *deterministic sequence of requests* is a paged operation.

The *logical entity* is a protocol neutral representation of a response. The logical entity may combine data from headers, body, and the status line. For example, you may expose an `ETag` header as a property on the logical entity.  `Response<T>` is the 'complete response'. It contains HTTP headers, status code, and the `T` object (a deserialized object created from the response body). The `T` object would be the 'logical entity'.

{% include requirement/MUST id="android-response-return-logical-entity" %} return the logical entity for the normal form of a service method. The logical entity MUST represent the information needed in the 99%+ case.

{% include requirement/MUST id="android-response-access-response" %} *make it possible* for a developer to access the complete response, including the status line, headers, and body.

Return `Response<T>` on the maximal overload for a service method with `WithResponse` appended to the name.  For example:

```java
Foo foo = client.getFoo(a);
Foo foo = client.getFoo(a, b);
Foo foo = client.getFoo(a, b, c, context); // This is the maximal overload
Response<Foo> response = client.getFooWithResponse(a, b, c, context);
```

{% include requirement/MUST id="android-response-provide-examples" %} provide examples on how to access the raw and streamed response for a request, where exposed by the client library.  We don't expect all methods to expose a streamed response.

{% include requirement/MUST id="android-response-pagination" %} provide a Java-idiomatic way to enumerate all logical entities for a paged operation, automatically fetching new pages as needed. For example:

```java
// Yes:
client.listSettings().forEach(this::print);

// No - don't force the caller of the library to do paging:
String nextPage = null;
while (!done) {
    Page<ConfigurationSetting> pageOfSettings = client.listSettings(nextPage);
    for (ConfigurationSetting setting : pageOfSettings) {
        print(setting);
    }
    nextPage = pageOfSettings.getNextPage();
    done = nextPage == null;
}
```

For more information on what to return for `list` operations, refer to [Pagination].

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="android-response-return-headers" %} return headers and other per-request metadata unless it's obvious as to which specific HTTP request the methods return value corresponds to.

{% include requirement/MUST id="android-response-failure-cases" %} provide enough information in failure cases for an application to take appropriate corrective action.

{% include requirement/SHOULDNOT id="android-response-reserved-words" %} use reserved words (such as `object` and `value`) as a property name within the logical entity.  Avoid reserved words in other supported languages.

## Pagination

Azure client libraries eschew low-level pagination APIs in favor of high-level abstractions that  implement per-item iterators. High-level APIs are easy for developers to use for the majority of use cases but can be more confusing when finer-grained control is required (for example, over-quota/throttling) and debugging when things go wrong. Other guidelines in this document work to mitigate this limitation, for example by providing robust logging, tracing, and pipeline customization options.


{% include requirement/MUST id="android-pagination-iterable" %} return `Iterable<T>` for synchronous APIs that expose paginated collections.  

> **DEVIATION** WE SHOULD EXPOSE SYNC PAGING APIS FOR ANDROID:  This is because Android Architecture Components is already async (so you connect via sync APIs) and the Paging control requires per-page iterators.

{% include requirement/MUST id="android-pagination-sync-support" %} return `PagedResponse<T>` for synchronous APIs that expose paginated collections.  The `PagedResponse<T>` type (located in Azure Core) provides access to paged results on a per-page basis.

For example, the configuration service sync client offers the following API:

```java
public final class ConfigurationClient {
    // synchronous API returning a Stream of ConfigurationSetting instances
    public Iterable<ConfigurationSetting> listSettings(SettingSelector options, Context context) {
        ...
    }

    public PagedResponse<ConfigurationSetting> listSettingsByPage(SettingSelector options, String continuationToken, Context context) {
        ...
    }
}
```

{% include requirement/MUSTNOT id="android-pagination-no-collections" %} use other collection types for sync APIs that return multiple values (for example, `List`, or `Iterator`).

{% include requirement/MUST id="android-pagination-paged-flux" %} return `PagedFlux<T>` for asynchronous APIs that expose paginated collections.  If the service doesn't offer paging, then return `Flux<T>`.

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

{% include requirement/MUST id="android-pagination-distinct-types" %} use distinct types for entities in a list endpoint and an entity returned from a get endpoint if these are different types, and otherwise you must use the same types in these situations.

{% include important.html content="Services should refrain from having a difference between the type of a particular entity as it exists in a list versus the result of a GET request for that individual item as it makes the client library's surface area simpler." %}

{% include requirement/MUSTNOT id="android-pagination-large-get-iterator" %} expose an iterator over each individual item if getting each item requires a corresponding GET request to the service. One GET per item is often too expensive and so not an action we want to take on behalf of users.

{% include requirement/MUSTNOT id="android-pagination-array-support" %} expose an API to get a paginated collection into an array. This is a dangerous capability for services which may return many, many pages.

{% include requirement/MUST id="android-pagination-paging-api" %} expose paging APIs when iterating over a collection. Paging APIs must accept a continuation token (from a prior run) and a maximum number of items to return, and must return a continuation token as part of the response so that the iterator may continue, potentially on a different machine.

This is automatically handled by the `PagedFlux<T>` type. Consumers of this API can consume individual items by treating the response as a `Flux<T>`:

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

## Long running operations

Long-running operations are operations which consist of an initial request to start the operation followed by polling to determine when the operation has completed or failed. Long-running operations in Azure tend to follow the [REST API guidelines for Long-running Operations][rest-lro], but there are exceptions.

{% include requirement/MUST id="android-lro-poller" %} represent long-running operations with some object that encapsulates the polling and the operation status. This object, called a *poller*, must provide APIs for:

1. querying the current operation state (either asynchronously, which may consult the service, or synchronously which must not)
2. requesting an asynchronous notification when the operation has completed
3. cancelling the operation if cancellation is supported by the service
4. registering disinterest in the operation so polling stops
5. triggering a poll operation manually (automatic polling must be disabled)
6. progress reporting (if supported by the service)

{% include requirement/MUST id="android-lro-options" %} support the following polling configuration options:

* `pollInterval`
  
Polling configuration may be used only in the absence of relevant retry-after headers from service, and otherwise should be ignored.

{% include requirement/MUST id="android-lro-prefix" %} prefix method names which return a poller with the `begin` prefix.

{% include requirement/MUST id="android-lro-continuation" %} provide a way to instantiate a poller with the serialized state of another poller to begin where it left off, for example by passing the state as a parameter to the same method which started the operation, or by directly instantiating a poller with that state.

{% include requirement/MUSTNOT id="android-lro-cancellation" %} cancel the long-running operation when cancellation is requested via a cancellation token. The cancellation token is cancelling the polling operation and should not have any effect on the service.

{% include requirement/MUST id="android-lro-logging" %} log polling status at the `Info` level (including time to next retry)

{% include requirement/MUST id="android-lro-progress-reporting" %} expose a progress reporting mechanism to the consumer if the service reports progress as part of the polling operation. 

{% include requirement/MUST id="android-lro-poller-class" %} use the `com.azure.core.polling.Poller` class to represent long-running operations.  The long-running operation API pattern is:

```java
public class <service_name>Client {
    // Poller<T> is a type in azure core
    public Poller<T> begin<operation_name>(<parameters>) {
        return new Poller<>(...);
    }
}
```

## Support for non-HTTP protocols

Most Azure services expose a RESTful API over HTTPS.  However, a few services use other protocols, such as [AMQP](https://www.amqp.org/), [MQTT](http://mqtt.org/), or [WebRTC](https://webrtc.org/). In these cases, the operation of the protocol can be split into two phases:

* Per-connection (surrounding when the connection is initiated and terminated)
* Per-operation (surrounding when an operation is sent through the open connection)

The policies that are added to a HTTP request/response (authentication, unique request ID, 
telemetry, distributed tracing, and logging) are still valid on both a per-connection and 
per-operation basis.  However, the methods by which these policies are implemented are protocol 
dependent.

{% include requirement/MUST id="android-proto-policies" %} implement as many of the policies as possible on a per-connection and per-operation basis.

For example, MQTT over WebSockets provides the ability to add headers during the initiation of the WebSockets connection, so this is a good place to add authentication, telemetry, and distributed tracing policies.  However, MQTT has no metadata (the equivalent of HTTP headers), so per-operation policies are not possible.  AMQP, by contract, does have per-operation metadata.  Unique request ID, and distributed tracing headers can be provided on a per-operation basis with AMQP.

{% include requirement/MUST id="android-proto-archboard" %} consult the [Architecture Board] on policy decisions for non-HTTP  protocols.  Implementation of all policies is expected.  If the protocol cannot support a policy, obtain an exception from the [Architecture Board].

{% include requirement/MUST id="android-proto-global-config" %} use the global configuration established in the Azure Core library to configure policies for non-HTTP protocols.  Consumers don't necessarily know what protocol is used by the client library.  They will expect the client library to honor global configuration that they have established for the entire Azure SDK.  

## The Java API

Consumers will use one or more _service clients_ to access Azure services, plus a set of model classes and other supporting types.  Both synchronous APIs and asynchronous APIs are supported.

### Async API

{% include requirement/MUST id="android-async-client-name" %} offer an async service client named `<ServiceName>AsyncClient`. More than one service client may be offered for a single service.

{% include requirement/MUST id="android-async-framework" %} use [Project Reactor] to provide consumers with a high-quality async API. 

{% include requirement/MUSTNOT id="android-async-only-framework" %} use any other async APIs, such as `CompletableFuture` or [RxJava].

{% include requirement/MUSTNOT id="android-async-suffix" %} use the suffix `Async` in methods that do operations asynchronously. Let the fact the user has an instance of an 'async client' provide this context.

{% include requirement/MUSTNOT id="android-async-multiple-methods" %} provide multiple asynchronous methods for a single REST endpoint, unless to provide overloaded methods to enable alternative or optional method parameters.

{% include requirement/MUSTNOT id="android-async-cancellation" %} provide API that accepts a cancellation token. Cancellation isn't a common pattern in Java. Developers who need to cancel requests unsubscribe from a publisher to cancel the request.

{% include requirement/MUSTNOT id="android-async-use-azure-core" %} write custom APIs for streaming or async operations. Make use of the existing functionality offered in the Azure core library. Discuss proposed changes to the Azure core library with the [Architecture Board].

{% include requirement/MUSTNOT id="android-async-no-blocking" %} include blocking calls inside async client library code. Use [BlockHound] to detect blocking calls in async APIs.

### Sync API

{% include requirement/MUST id="android-sync-client-name" %} offer a sync service client named `<ServiceName>Client`. More than one service client may be offered for a single service.

{% include requirement/MUSTNOT id="android-sync-cancellation" %} provide a sync API that accepts a cancellation token. Cancellation isn't a common pattern in Java.  Developers who need to cancel requests should use the async API instead.

## Service clients

{% include requirement/MUST id="android-service-client-naming" %} name service client types with the _Client_ suffix (for example, `ConfigurationClient`).

{% include requirement/MUST id="android-service-client-annotation" %} annotate all service clients with the `@ServiceClient` annotation.

{% include requirement/MUST id="android-service-client-location" %} place service clients in the root package of their corresponding client library (for example, `com.azure.storage.blob.BlobClient`, as `com.azure.storage.blob` is considered the root package in this example).

{% include requirement/MUST id="android-service-client-immutability" %} ensure that all service client classes are immutable upon instantiation.

{% include requirement/MUSTNOT id="android-service-client-constructors" %} provide any `public` or `protected` constructors in the service client, except where necessary to support mock testing. Keep visibility to a minimum.

{% include requirement/MUST id="android-sync-service-client-shape" %} follow the basic shape outlined below for all synchronous service clients:

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
    public Stream<<model>> list<service_operation>(<parameters>) {
        // deferring to async client internally
        return client.list<service_operation>(<parameters>).toStream();
    }

    // other members
    …
}
```

Refer to the [ConfigurationClient class] for a fully built-out example of how a sync client should be constructed.

{% include requirement/MUST id="android-async-service-client-shape" %} follow the basic shape outlined below for all asynchronous service clients:

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
    <service_name>Client(<parameters>, HttpPipeline pipeline) {
        super(pipeline);
    }

    // service methods...

    // A single response API
    public Mono<Response<<model>>> <service_operation>(<parameters>) {
        ...
    }

    // A paginated response API
    public PagedFlux<<model>> list<service_operation>(<parameters>) {
        ...
    }

    // other members
    ...
}
```

Refer to the [ConfigurationAsyncClient class] for a fully built-out example of how an async client should be constructed.

{% include requirement/MUST id="android-service-client-fluent-builder" %} offer a fluent builder API for constructing service clients named `<service_name>ClientBuilder`, which must support building a sync service client instance and an async service client instance (where appropriate). It must offer `buildClient()` and `buildAsyncClient()` API to create a synchronous and asynchronous service client instance, respectively:

```java
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

package com.azure.<group>.<service_name>;

@ServiceClientBuilder(serviceClients = {<service_name>Client.class, <service_name>AsyncClient.class})
public final class <service_name>ClientBuilder {

    // private fields for all settable parameters
    ...

    // public constructor - this is the only available front door to creating a service client instance
    public <service_name>ClientBuilder() {
        builder = <service_name>AsyncClient.builder();
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

{% include requirement/MUST id="android-service-client-builder-annotation" %} annotate service client builders with the `@ServiceClientBuilder` annotation.

{% include requirement/MUST %} ensure consistency across all client libraries, by using the following names for client builder fluent API:

| Name                 | Intent                                                                               |
|----------------------|--------------------------------------------------------------------------------------|
| `addPolicy`          | Adds a policy to the set of existing policies (assumes no custom pipeline is set).   |
| `buildAsyncClient`   | Creates a new **async** client on each call.                                         |
| `buildClient`        | Creates a new **sync** client on each call.                                          |
| `configuration`      | Sets the configuration store that is used during construction of the service client. |
| `credential`         | Sets the credential to use when authenticating HTTP requests.                        |
| `connectionString`   | Sets the connection string to use for.                                               |
| `endpoint`           | URL to send HTTP requests to.                                                        |
| `httpClient`         | Sets the HTTP client to use.                                                         |
| `httpLogDetailLevel` | Sets the logging level for HTTP requests and responses.                              |
| `pipeline`           | Sets the HTTP pipeline to use.                                                       |

`endpoint` may be renamed if a more user-friendly name can be justified. For example, a blob storage library developer may consider using `new BlobClientBuilder.blobUrl(..)`. In this case, the `endpoint` API should be removed.

{% include requirement/MUST id="android-service-client-builder-precedence" %} use the following precedence rules for builder arguments:

1. If the user sets a non-null `pipeline`, all other settings related to construction and configuration of a pipeline are ignored. The provided pipeline is used as-is.
2. If the user sets a `connectionString` and a `credential`, the `credential` will take precedence and the `connectionString` must be ignored.

Supporting common precedence rules ensures consistency across client libraries.

{% include requirement/MUST id="android-service-client-builder-illegal-state" %} throw an `IllegalStateException` from the builder method when it receives mutually exclusive arguments.  The consumer is over-specifying builder arguments, some of which will necessarily be ignored. The error message in the exception must clearly outline the issue.

{% include requirement/MUST id="android-service-client-builder-valid-client" %} ensure the builder will instantiate a service client into a valid state.  Throw validation exceptions during fluent property calls, or as part of the `build*()` calls.

{% include requirement/MUSTNOT id="android-service-client-builder-leakage" %} leak the underlying protocol transport implementation details to the consumer.  All types from the protocol transport implementation must be appropriately abstracted.

{% include requirement/MUST id="android-service-client-vending-prefix" %} prefix methods that create or vend subclients with `get` and suffix with `Client` or `AsyncClient` for sync and async subclients respectively (for example, `container.getBlobClient()` or `container.getBlobAsyncClient()`).

## Common service client patterns

{% include requirement/MUST id="android-service-client-approved-verbs" %} prefer the use of the following terms for CRUD operations:

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

{% include requirement/SHOULD id="android-service-client-flexibility" %} remain flexible and use names best suited for developer experience.  Don't let the naming rules result in non-idiomatic naming patterns.  For example, Java developers prefer `list` operations over `getAll` operations.

{% include requirement/MUST id="android-service-client-context" %} provide an overload method that takes a `com.azure.core.util.Context` argument for each service operation **in sync clients only**. The `Context` argument must be the last argument into the service method (except where `varargs` are used). If a service method has multiple overloads, only the 'maximal' overloads need to have the `Context` argument. A maximal overload is one that has a full set of arguments.  It may not be necessary to offer a 'Context overload' in all cases.  We prefer a minimal API surface, but `Context` must always be supported.

```java
getFoo()
getFoo(x)
getFoo(x, y)
getFoo(x, y, z) // maximal overload
getFoo(a)       // maximal overload

// this will result in the following two methods being required:
getFoo(x, y, z, Context)
getFoo(a, Context)
```

Don't include overloads that take `Context`in async clients.  Async clients use the [subscriber context built into Reactor Flux and Mono APIs][reactor-context].

## Model classes

Model classes are classes that consumers use to provide required information into client library methods. These classes typically represent the domain model, or options classes that must be configured before the request can be made.

{% include requirement/MUST id="android-models-constructors" %} provide public constructors for all model classes.

Use a no-args constructor and a fluent setter API to configure the model class. However, other designs may be used for the constructor when appropriate.

{% include requirement/MUSTNOT id="android-models-builder" %} offer a builder class for model classes.

{% include requirement/MUST id="android-models-fluent" %} provide a fluent API where appropriate.

Apply the `@Fluent` annotation to the class. Name setter methods after the property being set (for example, `proxy(Proxy p)`).  All setter methods must return `this`.

{% include requirement/MUST id="android-models-fluent-setters" %} ensure that setter methods within a fluent type return the same instance of the type.

Fluent types must not be immutable.  Don't return a new instance on each setter call.

{% include requirement/MUSTNOT id="android-models-no-javabeans" %} use the JavaBean naming convention of `get*`, `set*`, and `is*`.

## Other support classes

Don't offer builder or fluent APIs for supporting classes such as custom exception types, HTTP policies, and credential types.

{% include requirement/MUST id="android-support-javabeans" %} use the JavaBean naming convention of `get*`, `set*`, and `is*`.

{% include requirement/MUSTNOT id="android-support-no-fluent" %} use the fluent API naming convention outlined above for model classes.

{% include requirement/MUSTNOT id="android-support-no-builder" %} provide a builder class.

## Annotations

A number of annotations are defined in the Azure core library. A few annotations enable runtime functionality.  Most of the annotations are used as part of the [Azure Java SDK code linting tools](#java-tooling).

{% include requirement/MUST id="android-annotations-azurecore" %} use the Azure core library annotations outlined below in all applicable places. Use annotations eagerly as part of the initial code design.  The code linters will ensure continued conformance to some of the rules outlined in this specification.

{% include requirement/MUSTNOT id="android-annotations-format" %} include spaces in annotation string values, unless the description below states it's allowed.


### Service interface

A service interface defines the REST endpoints for a service, but isn't part of the public API.  It's hidden behind the service client class. For example, here is the service interface for one method within the `ConfigurationService`:

```java
@Host("{url}")
@ServiceInterface("AppConfig")
interface ConfigurationService {
    @Get("kv/{key}")
    @ExpectedResponses({200})
    @UnexpectedResponseExceptionType(code = {404}, value = ResourceNotFoundException.class)
    @UnexpectedResponseExceptionType(HttpResponseException.class)
    Mono<Response<ConfigurationSetting>> getKeyValue(
            @HostParam("url") String url, @PathParam("key") String key, @QueryParam("label") String label,
            @QueryParam("$select") String fields, @HeaderParam("Accept-Datetime") String acceptDatetime,
            @HeaderParam("If-Match") String ifMatch, @HeaderParam("If-None-Match") String ifNoneMatch,
            Context context);
    ...
}
```

| Annotation | Location | Description |
|------------|----------|-------------|
| `@ServiceInterface` | Service Interface | This interface represents a REST endpoint for the service.  The argument will be used as the service name in policies (such as telemetry and tracing). The argument must be short, alphanumeric, without spaces, and fit for public consumption. |
| `@Host` | Service Interface | The host name of the REST service.  The `{url}` maps with the `@HostParam` annotation. |
| `@<Method>` | Service Method | The HTTP method and endpoint used for the HTTP request. |
| `@ExpectedResponses` | Service Method | The list of HTTP status codes that the method expects to receive on success. |
| `@UnexpectedResponseExceptionType` | Method | Enables different exceptions to be thrown based on the status code returned. |
| `@BodyParam` | Argument | Places this argument into the body of the outgoing HTTP request. |
| `@HeaderParam` | Argument | Places this argument into the header of the outgoing HTTP request. |
| `@PathParam` | Argument | Places the argument into the endpoint path. |
| `@QueryParam` | Argument | Places the argument into the query string of the outgoing HTTP request. |

When specifying strings, you may use `{argument}` to do string replacement from arguments.  For example, the `@PathParam("key")` annotation replaces the `{key}` segment in the method annotation in the above example.

### Service client

Include the following annotations on the service client class.  For example, this code sample shows a sample class demonstrating the use of these two annotations:

```java
@ServiceClient(builder = ConfigurationAsyncClientBuilder.class, isAsync = true, service = ConfigurationService.class)
public final class ConfigurationAsyncClient {

    @ServiceMethod
    public Mono<Response<ConfigurationSetting>> addSetting(String key, String value) { 
        ... 
    }
}    
```

| Annotation | Location | Description |
|------------|----------|-------------|
| `@ServiceClient` | Service Client | Specifies the builder responsible for instantiating the service client, whether the API is asynchronous, and a reference back to the service interface (the interface annotated with `@ServiceInterface`). |
| `@ServiceMethod` | Service Method | Placed on all service client methods that do network operations. |

### Service Client Builder

The `@ServiceClientBuilder` annotation should be placed on any class that is responsible for instantiating service clients (that is, instantiating classes annotated with `@ServiceClient`). For example:

```java
@ServiceClientBuilder(serviceClients = {ConfigurationClient.class, ConfigurationAsyncClient.class})
public final class ConfigurationClientBuilder { ... }
```

This builder states that it can build instances of `ConfigurationClient` and `ConfigurationAsyncClient`.

### Model Classes

There are two annotations of note that should be applied on model classes, when applicable:

* The `@Fluent` annotation is given to all model classes that are expected to provide a fluent API to end users.
* The `@Immutable` annotation is given to all immutable classes.

## Versioning

{% include draft.html content="The API for specifying a specific service version is not yet defined.  This section will change as it becomes more concrete." %}

There are two versions that developers must be concerned with. Release versioning is the version of the library.  The Azure service API that the library calls also has a version. This section details how consumers can request a specific Azure service API when working with the library.

{% include requirement/MUST id="android-versioning-latest-service-api" %} call the latest supported service API version by default.

{% include requirement/MUST id="android-versioning-select-service-api" %} allow the consumer to select a supported service API version when instantiating the service client.

Include `.serviceVersion(ServiceVersion version)` as part of the client builder API.  `ServiceVersion` should be an enumeration. The enumeration must have a `getLatest()` method that returns the latest service version. If a consumer doesn't specify a service version, the builder will call `ServiceVersion.getLatest()` to obtain the appropriate service version.

{% include refs.md %}
{% include_relative refs.md %}
