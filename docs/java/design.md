---
title: "Java Guidelines: API Design"
keywords: guidelines java
permalink: java_design.html
folder: java
sidebar: java_sidebar
---

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.  

## Namespaces

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

{% include requirement/MUST id="java-namespaces-management" %} place the management (Azure Resource Manager) API in the `management` group.  Use the grouping `<AZURE>.management.<group>.<service>` for the namespace. Since more services require control plane APIs than data plane APIs, other namespaces may be used explicitly for control plane only.  Data plane usage is by exception only.  Additional namespaces that can be used for control plane SDKs include:

{% include tables/mgmt_namespaces.md %}

Many `management` APIs do not have a data plane because they deal with management of the Azure account. Place the management library in the `com.azure.management` namespace.  For example, use `com.azure.management.costanalysis` instead of `com.azure.management.management.costanalysis`.

{% include requirement/MUSTNOT id="java-namespaces-ambiguity" %} choose similar names for clients that do different things.

{% include requirement/MUST id="java-namespaces-registration" %} register the chosen namespace with the [Architecture Board].  Open an issue to request the namespace.  See [the registered namespace list](registered_namespaces.html) for a list of the currently registered namespaces.

### Example Namespaces

Here are some examples of namespaces that meet these guidelines:

- `com.azure.data.cosmos`
- `com.azure.identity.activedirectory`
- `com.azure.iot.deviceprovisioning`
- `com.azure.storage.blob`
- `com.azure.messaging.notificationhubs` (the client library for Notification Hubs)
- `com.azure.management.messaging.notificationhubs` (the management library for Notification Hubs)

Here are some namespaces that do not meet the guidelines:

- `com.microsoft.azure.cosmosdb` (not in the `com.azure` namespace and does not use grouping)
- `com.azure.mixedreality.kinect` (the grouping is not in the approved list)

{% include requirement/MUSTNOT id="java-namespaces-implementation" %} allow implementation code (that is, code that doesn't form part of the public API) to be mistaken as public API. There are two valid arrangements for implementation code:

1. Implementation classes can be placed within a subpackage named `implementation`.
2. Implementation classes can be made package-private and placed within the same package as the consuming class.

CheckStyle checks ensure that classes within an `implementation` package aren't exposed through public API.

### Maven

All client libraries for Java standardize on the Maven build tooling for build and dependency management. This section details the standard configuration that must be used in all client libraries.

{% include requirement/MUST id="java-maven-pom" %} ship a maven pom.xml for each client library, or for each module within that client library (e.g. Storage might have one each for blob, queue, and file).

{% include requirement/MUST id="java-maven-groupid" %} specify the `groupId` as `com.azure`.

{% include requirement/MUST id="java-maven-artifactid" %} specify the `artifactId` to be of the form `azure-<group>-<service>`, for example, `azure-storage-blob`. In cases where the client library has multiple children modules, set the root POM `artifactId` to be of the form `azure-<group>-<service>-parent`.

{% include requirement/MUST id="java-maven-name" %} specify the `name` element to take the form `Microsoft Azure client library for <service name>`.

{% include requirement/MUST id="java-maven-description" %} specify the `description` element to be a slightly longer statement along the lines of `This package contains the Microsoft Azure <service> client library`.

{% include requirement/MUST id="java-maven-url" %} specify the `url` element to point to the root of the GitHub repository (i.e. `https://github.com/Azure/azure-sdk-for-java`).

{% include requirement/MUST id="java-maven-url" %} specify the source code management section, to specify where the source code resides for the client library. If the source code is located in the https://github.com/Azure/azure-sdk-for-java repository, then the following form must be used:

```
<scm>
    <url>scm:git:https://github.com/Azure/azure-sdk-for-java</url>
    <connection>scm:git:git@github.com:Azure/azure-sdk-for-java.git</connection>
    <tag>HEAD</tag>
</scm>
```

{% include requirement/MUSTNOT id="java-maven-developers" %} change the `developers` section of the POM file - it must only list a developer `id` of `microsoft` and a `name` of `Microsoft Corporation`.

### Modules

Java 9 and later support the notion of a module. A module *exports* certain packages, and *requires* other modules. Any package that is exported can be used by other modules, and anything that is not exported is invisible at compile and run times. This is a far stronger form of encapsulation than has existed previously for Java. For the Azure SDK for Java, a client library will be repesented as one or more modules. Two good resources to understand modules are available on [oracle.com](https://www.oracle.com/corporate/features/understanding-java-9-modules.html) and [baeldung.com](https://www.baeldung.com/java-9-modularity).

{% include requirement/MUST id="java-module-info" %} include a `module-info.java` file for each module you ship.

{% include requirement/MUST id="java-module-name" %} name your module based on the root package of the client library it represents. For example, `com.azure.core` or `com.azure.storage.blob`.

{% include requirement/MUST id="java-module-requires" %} require only the minimum set of modules relevant for the module being developed.

{% include requirement/MUST id="java-module-exports" %} export only packages that are considered public API. In particular, do **not** export packages that are in the `implementation` package namespace, as these, by convention, are not intended for public use.

{% include requirement/MUSTNOT id="java-module-no-conditional-exports" %} conditionally `export` or `opens` packages to other modules without prior approval by the architecture board. A conditional `export` or `opens` statement takes the form `export X to Y` or `opens X to Y`.

{% include requirement/MUSTNOT id="java-module-split-packages" %} have the same package in multiple modules. That is, do not have `com.azure.storage.blob` in module `com.azure.storage.blob` and in module `com.azure.storage.blob.extras`. It is however allowed to have different packages with common parent packages split across different modules. For example, a package named `com.azure.storage` can be in one module, and `com.azure.storage.blob` can be in another.

## Client interface

Your API surface consists of one or more _service clients_ that the consumer will instantiate to connect to your service, plus a set of supporting types.

{% include requirement/MUST id="java-client-naming" %} name service client types with the _Client_ suffix.

{% include requirement/MUST id="java-client-namespace" %} place service client types that the consumer is most likely to interact with in the root package of the client library (for example, `com.azure.<group>.servicebus`).  Specialized service clients should be placed in subpackages.

{% include requirement/MUST id="java-client-construction" %} allow the consumer to construct a service client with the minimal information needed to connect and authenticate to the service.

{% include requirement/MUST id="java-client-verb-prefixes" %} standardize verb prefixes within a set of client libraries for a service.  

We speak about using the client library in a cross-language manner within outbound materials such as documentation, blogs, and public speaking.

{% include requirement/MUST id="java-client-feature-support" %} support 100% of the features provided by the Azure service the client library represents. Gaps in functionality cause confusion and frustration among developers.

## Network requests

The client library wraps HTTP requests so it's important to support standard network capabilities.  Asynchronous programming techniques aren't widely understood.  However, such techniques are essential in developing resilient web services.  Many developers prefer synchronous method calls for their easy semantics when learning how to use a technology.  Consumers also expect certain capabilities in a network stack (such as call cancellation, automatic retry, and logging).

{% include requirement/MUST id="java-network-sync-async" %} support both synchronous and asynchronous service clients.

{% include requirement/MUST id="java-network-separate-packages" %} have [separate service clients] for sync and async APIs.  The consumer needs to identify which methods are async and which are sync.

## Authentication

Azure services use different kinds of authentication schemes to allow clients to access the service.  Conceptually, there are two entities responsible in this process: a credential and an authentication policy.  Credentials provide confidential authentication data.  Authentication policies use the data provided by a credential to authenticate requests to the service.  

{% include requirement/MUST id="java-auth-support" %} support all authentication techniques that the service supports.

{% include requirement/MUST id="java-auth-azurecore" %} use credential and authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="java-auth-credentials" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service.  If using a service-specific credential type, the implementation must be non-blocking and atomic.

{% include requirement/MUST id="java-auth-fluent-builder" %} provide service client fluent builder APIs that accept all supported authentication credentials.

A connection string is a combination of an endpoint, credential data, and other options used to simplify service client configuration.  Client libraries may support a connection string __ONLY IF__ the service provides it via the portal or other tooling.   Connection strings are easily integrated into an application by copy/paste from the portal.  However, credentials within a connection string can't be rotated within a running process.  Their use should be discouraged in production apps.

{% include requirement/MUSTNOT id="java-auth-connection-strings" %} support constructing a service client with a connection string unless such connection string is available within tooling (for copy/paste operations).

## Response formats

Requests to the service fall into two basic groups: methods that make a single logical request, and methods that make a deterministic sequence of requests.  An example of a *single logical request* is a request that may be retried inside the operation.  An example of a *deterministic sequence of requests* is a paged operation.

The *logical entity* is a protocol neutral representation of a response. The logical entity may combine data from headers, body, and the status line. For example, you may expose an `ETag` header as a property on the logical entity.  `Response<T>` is the 'complete response'. It contains HTTP headers, status code, and the `T` object (a deserialized object created from the response body). The `T` object would be the 'logical entity'.

{% include requirement/MUST id="java-response-logical-entity" %} return the logical entity for the normal form of a service method. The logical entity MUST represent the information needed in the 99%+ case.

{% include requirement/MUST id="java-response-access-complete" %} *make it possible* for a developer to access the complete response, including the status line, headers, and body.

Return `Response<T>` on the maximal overload for a service method with `WithResponse` appended to the name.  For example:

```java
Foo foo = client.getFoo(a);
Foo foo = client.getFoo(a, b);
Foo foo = client.getFoo(a, b, c, context); // This is the maximal overload
Response<Foo> response = client.getFooWithResponse(a, b, c, context);
```

{% include requirement/MUST id="java-response-examples" %} provide examples on how to access the raw and streamed response for a request, where exposed by the client library.  We don't expect all methods to expose a streamed response.

{% include requirement/MUST id="java-pagination-idiomatic" %} provide a Java-idiomatic way to enumerate all logical entities for a paged operation, automatically fetching new pages as needed. For example:

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

{% include requirement/MUSTNOT id="java-response-headers" %} return headers and other per-request metadata unless it's obvious as to which specific HTTP request the methods return value corresponds to.

{% include requirement/MUST id="java-response-errors" %} provide enough information in failure cases for an application to take appropriate corrective action.

{% include requirement/SHOULDNOT id="java-response-no-reserved-words" %} use reserved words (such as `object` and `value`) as a property name within the logical entity.  Avoid reserved words in other supported languages.

## Pagination

Azure client libraries eschew low-level pagination APIs in favor of high-level abstractions that  implement per-item iterators. High-level APIs are easy for developers to use for the majority of use cases but can be more confusing when finer-grained control is required (for example,  over-quota/throttling) and debugging when things go wrong. Other guidelines in this document work to mitigate this limitation, for example by providing robust logging, tracing, and pipeline  customization options.

{% include requirement/MUST id="java-pagination-streaming" %} return `PagedIterable<T>` (found in azure-core under `com.azure.core.http.rest`) for synchronous APIs that expose paginated collections, and return `IterableStream<T>` (found in azure-core under `com.azure.core.util`) for synchronous APIs that do not support pagination. These APIs allow consumers to write code that works using the standard *for* loop syntax (as it is an `Iterable`), and also to work with a Java `Stream` (as there is a `stream()` method). `PagedIterable` goes further, by offering consumers `streamByPage` and `iterableByPage` methods to work on page boundaries.

For example, the configuration service sync client might offer the following API:

```java
public final class ConfigurationClient {
    // synchronous API returning a PagedIterable of ConfigurationSetting instances
    public PagedIterable<ConfigurationSetting> listSettings(...) {
        ...
    }
}
```

{% include requirement/MUSTNOT id="java-pagination-collections" %} use other collection types for sync APIs that return collections (for example, `List`, `Stream`, `Iterable`, or `Iterator`).

{% include requirement/MUST id="java-pagination-pagedflux" %} return `PagedFlux<T>` for asynchronous APIs that expose collections. Even if the service does not support pagination, always return `PagedFlux<T>`, as it allows for consumers to retrieve response information in a consistent manner.

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

{% include requirement/MUST id="java-pagination-distinct-types" %} use distinct types for entities in a list endpoint and an entity returned from a get endpoint if these are different types, and otherwise you must use the same types in these situations.

> Services should refrain from having a difference between the type of a particular entity as it exists in a list versus the result of a GET request for that individual item as it makes the client library's surface area simpler.

{% include requirement/MUSTNOT id="java-pagination-get-iterator" %} expose an iterator over each individual item if getting each item requires a corresponding GET request to the service. One GET per item is often too expensive and so not an action we want to take on behalf of users.

{% include requirement/MUSTNOT id="java-pagination-arrays" %} expose an API to get a paginated collection into an array. This is a dangerous capability for services which may return many, many pages.

{% include requirement/MUST id="java-pagination-api" %} expose paging APIs when iterating over a collection. Paging APIs must accept a continuation token (from a prior run) and a maximum number of items to return, and must return a continuation token as part of the response so that the iterator may continue, potentially on a different machine.

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

{% include requirement/MUST id="java-lro-poller" %} represent long-running operations with some object that encapsulates the polling and the operation status. This object, called a *poller*, must provide APIs for:

1. querying the current operation state (either asynchronously, which may consult the service, or synchronously which must not)
2. requesting an asynchronous notification when the operation has completed
3. cancelling the operation if cancellation is supported by the service
4. registering disinterest in the operation so polling stops
5. triggering a poll operation manually (automatic polling must be disabled)
6. progress reporting (if supported by the service)

{% include requirement/MUST id="java-lro-options" %} support the following polling configuration options:

* `pollInterval`
  
Polling configuration may be used only in the absence of relevant retry-after headers from service, and otherwise should be ignored.

{% include requirement/MUST id="java-lro-prefix" %} prefix method names which return a poller with the `begin` prefix.

{% include requirement/MUST id="java-lro-continuation" %} provide a way to instantiate a poller with the serialized state of another poller to begin where it left off, for example by passing the state as a parameter to the same method which started the operation, or by directly instantiating a poller with that state.

{% include requirement/MUSTNOT id="java-lro-cancellation" %} cancel the long-running operation when cancellation is requested via a cancellation token. The cancellation token is cancelling the polling operation and should not have any effect on the service.

{% include requirement/MUST id="java-lro-logging" %} log polling status at the `Info` level (including time to next retry)

{% include requirement/MUST id="java-lro-progress-reporting" %} expose a progress reporting mechanism to the consumer if the service reports progress as part of the polling operation. 

{% include requirement/MUST id="java-lro-poller-class" %} use the `com.azure.core.polling.Poller` class to represent long-running operations.  The long-running operation API pattern is:

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

The policies that are added to a HTTP request/response (authentication, unique request ID, telemetry, distributed tracing, and logging) are still valid on both a per-connection and per-operation basis.  However, the methods by which these policies are implemented are protocol dependent.

{% include requirement/MUST id="java-protos-policies" %} implement as many of the policies as possible on a per-connection and per-operation basis.

For example, MQTT over WebSockets provides the ability to add headers during the initiation of the WebSockets connection, so this is a good place to add authentication, telemetry, and distributed tracing policies.  However, MQTT has no metadata (the equivalent of HTTP headers), so per-operation policies are not possible.  AMQP, by contract, does have per-operation metadata.  Unique request ID, and distributed tracing headers can be provided on a per-operation basis with AMQP.

{% include requirement/MUST id="java-protos-archboard" %} consult the [Architecture Board] on policy decisions for non-HTTP  protocols.  Implementation of all policies is expected.  If the protocol cannot support a policy, obtain an exception from the [Architecture Board].

{% include requirement/MUST id="java-protos-global-config" %} use the global configuration established in the Azure Core library to configure policies for non-HTTP protocols.  Consumers don't necessarily know what protocol is used by the client library.  They will expect the client library to honor global configuration that they have established for the entire Azure SDK.  

## The Java API

Consumers will use one or more _service clients_ to access Azure services, plus a set of model classes and other supporting types.  Both synchronous APIs and asynchronous APIs are supported.

### Async API

{% include requirement/MUST id="java-async-client-name" %} offer an async service client named `<ServiceName>AsyncClient`. More than one service client may be offered for a single service.

{% include requirement/MUST id="java-async-framework" %} use [Project Reactor] to provide consumers with a high-quality async API.

{% include requirement/MUSTNOT id="java-async-other-frameworks" %} use any other async APIs, such as `CompletableFuture` or [RxJava].

{% include requirement/MUSTNOT id="java-async-suffix" %} use the suffix `Async` in methods that do operations asynchronously. Let the fact the user has an instance of an 'async client' provide this context.

{% include requirement/MUSTNOT id="java-async-methods" %} provide multiple asynchronous methods for a single REST endpoint, unless to provide overloaded methods to enable alternative or optional method parameters.

{% include requirement/MUSTNOT id="java-async-cancellation" %} provide API that accepts a cancellation token. Cancellation isn't a common pattern in Java. Developers who need to cancel requests unsubscribe from a publisher to cancel the request.

{% include requirement/MUSTNOT id="java-async-streaming" %} write custom APIs for streaming or async operations. Make use of the existing functionality offered in the Azure core library. Discuss proposed changes to the Azure core library with the [Architecture Board].

{% include requirement/MUSTNOT id="java-async-blocking" %} include blocking calls inside async client library code. Use [BlockHound] to detect blocking calls in async APIs.

### Sync API

{% include requirement/MUST id="java-sync-client-name" %} offer a sync service client named `<ServiceName>Client`. More than one service client may be offered for a single service.

{% include requirement/MUSTNOT id="java-sync-cancellation" %} provide a sync API that accepts a cancellation token. Cancellation isn't a common pattern in Java.  Developers who need to cancel requests should use the async API instead.

## Service clients

{% include requirement/MUST id="java-service-client-name" %} name service client types with the _Client_ suffix (for example, `ConfigurationClient`).

{% include requirement/MUST id="java-service-client-annotation" %} annotate all service clients with the `@ServiceClient` annotation.

{% include requirement/MUST id="java-service-client-namespace" %} place service clients in the root package of their corresponding client library (for example, `com.azure.storage.blob.BlobClient`, as `com.azure.storage.blob` is considered the root package in this example).

{% include requirement/MUST id="java-service-client-immutable" %} ensure that all service client classes are immutable upon instantiation.

{% include requirement/MUSTNOT id="java-service-client-constructors" %} provide any `public` or `protected` constructors in the service client, except where necessary to support mock testing. Keep visibility to a minimum.

{% include requirement/MUST id="java-service-client-method-naming" %} use standard JavaBean naming prefixes for all getters and setters that are not service methods.

{% include requirement/MUST id="java-sync-client-shape" %} follow the basic shape outlined below for all synchronous service clients:

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

{% include requirement/MUST id="java-async-client-shape" %} follow the basic shape outlined below for all asynchronous service clients:

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

{% include requirement/MUST id="java-service-client-fluent-builder" %} offer a fluent builder API for constructing service clients named `<service_name>ClientBuilder`, which must support building a sync service client instance and an async service client instance (where appropriate). It must offer `buildClient()` and `buildAsyncClient()` API to create a synchronous and asynchronous service client instance, respectively:

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

{% include requirement/MUST id="java-service-client-builder-annotation" %} annotate service client builders with the `@ServiceClientBuilder` annotation.

{% include requirement/MUST id="java-service-client-builder-consistency" %} ensure consistency across all client libraries, by using the following names for client builder fluent API:

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
| `httpLogOptions`     | Configuration for HTTP logging level, header redaction, etc.                         |
| `pipeline`           | Sets the HTTP pipeline to use.                                                       |

`endpoint` may be renamed if a more user-friendly name can be justified. For example, a blob storage library developer may consider using `new BlobClientBuilder.blobUrl(..)`. In this case, the `endpoint` API should be removed.

{% include requirement/MUST id="java-service-client-builder-precedence" %} use the following precedence rules for builder arguments:

1. If the user sets a non-null `pipeline`, all other settings related to construction and configuration of a pipeline are ignored. The provided pipeline is used as-is.
2. If the user sets a `connectionString` and a `credential`, the `credential` will take precedence and the `connectionString` must be ignored.

Supporting common precedence rules ensures consistency across client libraries.

{% include requirement/MUST id="java-service-client-builder-state" %} throw an `IllegalStateException` from the builder method when it receives mutually exclusive arguments.  The consumer is over-specifying builder arguments, some of which will necessarily be ignored. The error message in the exception must clearly outline the issue.

{% include requirement/MUST id="java-service-client-builder-validity" %} ensure the builder will instantiate a service client into a valid state.  Throw validation exceptions during fluent property calls, or as part of the `build*()` calls.

{% include requirement/MUSTNOT id="java-service-client-builder-leakage" %} leak the underlying protocol transport implementation details to the consumer.  All types from the protocol transport implementation must be appropriately abstracted.

{% include requirement/MUST id="java-service-client-vend-prefix" %} prefix methods that create or vend subclients with `get` and suffix with `Client` or `AsyncClient` for sync and async subclients respectively (for example, `container.getBlobClient()` or `container.getBlobAsyncClient()`).

## Common service client patterns

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

{% include requirement/MUST id="java-service-client-context" %} provide an overload method that takes a `com.azure.core.util.Context` argument for each service operation **in sync clients only**. The `Context` argument must be the last argument into the service method (except where `varargs` are used). If a service method has multiple overloads, only the 'maximal' overloads need to have the `Context` argument. A maximal overload is one that has a full set of arguments.  It may not be necessary to offer a 'Context overload' in all cases.  We prefer a minimal API surface, but `Context` must always be supported.

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

Don't include overloads that take `Context` in async clients.  Async clients use the [subscriber context built into Reactor Flux and Mono APIs][reactor-context].

## Model classes

Model classes are classes that consumers use to provide required information into client library methods. These classes typically represent the domain model, or options classes that must be configured before the request can be made.

{% include requirement/MUST id="java-models-constructors" %} provide public constructors for all model classes.

Use a no-args constructor and a fluent setter API to configure the model class. However, other designs may be used for the constructor when appropriate.

{% include requirement/MUSTNOT id="java-models-builder" %} offer a builder class for model classes.

{% include requirement/MUST id="java-models-fluent" %} provide a fluent API where appropriate. Setter methods in model classes are required to return `this` to enable method chaining.

{% include requirement/MUST id="java-models-fluent-annotation" %} apply the `@Fluent` annotation to the class.

{% include requirement/MUST id="java-models-setters" %} ensure that setter methods within a fluent type return the same instance of the type.

Fluent types must not be immutable.  Don't return a new instance on each setter call.

{% include requirement/MUST id="java-models-javabeans" %} use the JavaBean naming convention of `get*`, `set*`, and `is*`.

## Other support classes

Don't offer builder or fluent APIs for supporting classes such as custom exception types, HTTP policies, and credential types.

{% include requirement/MUST id="java-support-prefix" %} use standard JavaBean prefixes for setter and getter methods.

{% include requirement/MUSTNOT id="java-support-setter-return-type" %} return `this` in setter methods - these methods should have a `void` return type.

{% include requirement/MUSTNOT id="java-support-builder" %} provide a builder class.

## Naming Patterns

Using a consistent set of naming patterns across all client libraries will ensure a consistent and more intuitive developer experience. This section outlines good practices for naming that must be followed by all client libraries.

{% include requirement/MUST id="java-naming-succinct" %} prefer succinctness over verbosity, except when readability is impacted. A few examples include:

* A class may want to return an identifier to a user. There is no additional value in the fully-qualified `getIdentifier()` compared with the shorter and equally-descriptive `getId()`.
* A method called `getName()` is short, but may leave some doubt in the users mind about which name is being represented. Instead, naming this method `getLinkName()` will remove all doubt from the users mind, and without substantial additional verbosity. Similarly, in the case of `getId()` above, always choose to specify the identifier name if there is any likelihood of confusion about which identifier is being referenced. For example, use `getTenantId()` rather than `getId()`, unless it is completely unambiguous as to which identifier is being referenced.

{% include requirement/MUSTNOT id="java-naming-uppercase-acronyms" %} fully uppercase acronyms. APIs must take the form of `getHttpConnection()` or `getUrlName()` rather than `getHTTPConnection()` or `getURLName()`.

{% include requirement/MUST id="java-naming-service-acronyns" %} use service-specific acronyms sparingly in API. Whereas most users will accept a method including `Http` or `Url` in the name, most users will not know what `Sas` or `Cpk` mean. Where possible (without breaking the succinctness over verbosity requirement above), expansion of acronyms, or at the very least sufficient documentation at class and method levels to describe the acronym, must be considered.

{% include requirement/MUST id="java-naming-host-vs-hostname" %} understand the difference between a host and a hostname, and use the correct name. `hostname` is the host name without any port number, whereas `host` is the hostname with the port number. Additionally, API referring to the host name should be spelt as `hostname`, rather than `hostName`. The same applies to `username`, which should be used instead of `userName`.

{% include requirement/MUSTNOT id="java-interface-i-prefix" %} name interface types with an 'I' prefix, e.g. `ISearchClient`. Instead, do not have any prefix for an interface, preferring `SearchClient` as the name for the interface type in this case.

## Java API Guidance

{% include requirement/MUSTNOT id="java-api-old-date-time" %} create API that exposes the old Java date library (e.g. `java.util.Date`, `java.util.Calendar`, and `java.util.Timezone`). All API must use the new date / time APIs that shipped in JDK 8 in the `java.util.time` package.

{% include requirement/MUSTNOT id="java-api-url" %} create API that exposes the `java.net.URL` API. This API is difficult to work with, and more frequently gets in the users way rather than provide any real assistance. Instead, use the String type to represent the URL. When it is necessary to parse this String into a URL, and if it fails to be parsed (throwing a checked `MalformedURLException`), catch this internally and throw an unchecked `IllegalArgumentException` instead.

{% include requirement/MUST id="java-api-file-paths" %} represent file paths using the Java `java.nio.file.Path` type. Do not use String or the older `java.io.File` type.

### Enumerations

{% include requirement/MUST id="java-enums" %} use an `enum` for parameters, properties, and return types when values are known.

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

## Annotations

A number of annotations are defined in the Azure core library. A few annotations enable runtime functionality.  Most of the annotations are used as part of the [Azure Java SDK code linting tools](#java-tooling).

{% include requirement/MUST id="java-annotations-azure-core" %} use the Azure core library annotations outlined below in all applicable places. Use annotations eagerly as part of the initial code design.  The code linters will ensure continued conformance to some of the rules outlined in this specification.

{% include requirement/MUSTNOT id="java-annotations-format" %} include spaces in annotation string values, unless the description below states it's allowed.

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
|:-----------|:---------|:------------|
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
|:-----------|:---------|:------------|
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

{% include requirement/MUST id="java-versioning-backwards-compatibility" %} be 100% backwards compatible with older versions of the same package.

{% include requirement/MUST id="java-versioning-highest-api" %} call the highest supported service API version by default.

{% include requirement/MUST id="java-versioning-select-api-version" %} allow the consumer to explicitly select a supported service API version when instantiating the service client, by using the service client builder with a property called `serviceVersion`. The fixed-element enum type will be named specifically for the service, but as generally as possible. For example, `IdentityServiceVersion` for Identity. For a service with multiple sub-services, such as Storage, if the services all share a common versioning system, `StorageServiceVersion` would suffice. If they did not, it would be necessary to have separate `BlobServiceVersion`, `QueueServiceVersion`, and `FileServiceVersion` enums.

{% include requirement/MUST id="java-versioning-enum-latest" %} offer a `getLatest()` method on the enum that returns the latest service version. If a consumer doesn't specify a service version, the builder will call `getLatest()` to obtain the appropriate service version.

{% include requirement/MUST id="java-versioning-enum--value-naming" %} use the version naming used by the service itself in naming the version values in the enum. The standard approach takes the form `V<year>_<month>_<day>`, such as `V2019_05_09`. Being consistent with the service naming enables easier cross-referencing between service versions and the availability of features in the client library.

{% include note.html content="Third-party reusable libraries shouldn't change behavior without an explicit decision by the developer.  When developing libraries that are based on the Azure SDK, lock the library to a specific service version to avoid changes in behavior." %}

{% include requirement/MUST id="java-versioning-new-package" %} introduce a new library (with new library names, new package names, and new type names) if you must do an API breaking change.

Breaking changes should happen rarely, if ever.  Register your intent to do a breaking change with [adparch]. You'll need to have a discussion with the language architect before approval.

{% include refs.md %}
{% include_relative refs.md %}
