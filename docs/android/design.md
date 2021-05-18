---
title: "Android Azure SDK Design Guidelines"
keywords: guidelines android
permalink: android_design.html
folder: android
sidebar: general_sidebar
---

{% include draft.html content="The Android guidelines are in DRAFT status" %}

## Introduction

The following document describes Android specific guidelines for designing Azure SDK client libraries. These guidelines also expand on and simplify language-independent [General Azure SDK Guidelines][general-guidelines]. More specific guidelines take precedence over more general guidelines.

The Android guidelines are for the benefit of client library designers targeting service applications written for the native Android ecosystem. You do not have to write a client library for Android if your service is not normally accessed from mobile apps.

### Design principles

The main value of the Azure SDK is productivity. Other qualities, such as completeness, extensibility, and performance are important but secondary. We ensure our customers can be highly productive when using our libraries by ensuring these libraries are:

**Idiomatic**

* The SDK should follow the general design guidelines and conventions for Android libraries written in Java. It should feel natural to an Android developer.
* We embrace the ecosystem with its strengths and its flaws.
* We work with the ecosystem to improve it for all developers.

**Consistent**

* The Azure SDK feels like a single product of a single team, not simply a collection of libraries for Azure services.
* Users learn common concepts once; apply the knowledge across all SDK components.
* All differences from the guidelines must have good reasons.

**Approachable**

* Small number of steps to get started; power knobs for advanced users.
* Small number of concepts; small number of types; small number of members.
* Approachable by our users, not by engineers designing the SDK components.
* Easy to find great _getting started_ guides and samples.
* Easy to acquire.

**Dependable**

* 100% backward compatible.
* Great logging and error messages.
* Predictable support lifecycle, feature coverage, and quality.

### General Guidelines

{% include requirement/MUST id="android-general-follow-general-guidelines" %} follow the [General Azure SDK Guidelines].

{% include requirement/MUST id="android-general-repository" %} locate all source code in the [Azure/azure-sdk-for-android] GitHub repository.

{% include requirement/MUST id="android-language" %} write the client libraries using Java 8.

The intent is to ensure that the client library is idiomatic for Android applications while remaining compatible with a minimum API level of Android 16 (Jelly Bean).

### Support for non-HTTP Protocols

Currently, this document describes guidelines for client libraries exposing HTTP services. If your service is not HTTP-based, please contact the [Azure SDK Architecture Board][Architecture Board] for guidance.

## Azure SDK API Design

Azure services are exposed to Android developers as one or more *service client* types and a set of *supporting types*.

### Service Client

Service clients are the main starting points for developers calling Azure services with the Azure SDK. Each client library should have at least one client in its main namespace, so it’s easy to discover. The guidelines in this section describe patterns for the design of a service client. Because for Android both synchronous and asynchronous service clients are required, the sections below are organized into general service client guidance, followed by sync- and async-specific guidance.

{% include requirement/MUST id="android-service-client-name" %} name service client types with the _Client_ suffix (for example, `ConfigurationClient`).

{% include requirement/MUST id="android-service-client-annotation" %} annotate all service clients with the `@ServiceClient` annotation.

{% include requirement/MUST id="android-service-client-namespace" %} place service client types that the consumer is most likely to interact with in the root package of the client library (for example, `com.azure.android.<group>.servicebus`). Specialized service clients should be placed in sub-packages.

{% include requirement/MUST id="android-service-client-immutable" %} ensure that all service client classes are immutable and stateless upon instantiation.

{% include requirement/MUST id="android-network-separate-packages" %} have separate service clients for sync and async APIs.

{% include requirement/SHOULD id="android-service-client-feature-support" %} support only those features provided by the Azure service that would make sense for a mobile app would access. Mobile apps are inherently consumer applications, and only a subset of Azure services and features are intended for use by consumer applications. While completeness is valuable and gaps in functionality can cause frustration, a smaller binary size and an opinionated stance of only providing consumer-facing functionality will make our libraries easier and more desirable for app developers to use.

{% include requirement/MUST id="android-service-client-mobile-consistency" %} provide a public API whose shape matches the public API shape provided in the equivalent iOS library as closely as possible. Clients should have the same names and provide the same functionality in their public APIs, and while method naming should be idiomatic to each platform, consistency in naming between the two platforms is the next most important consideration.

#### Sync Service Clients

{% include requirement/MUST id="android-sync-client-name" %} offer a sync service client named `<ServiceName>Client` containing all non-streaming service methods. More than one service client may be offered for a single service. An example of a sync client is shown below:

```java
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.
package com.azure.android.<group>.<service_name>;

@ServiceClient(
    builder = <service_name>ClientBuilder.class,
    serviceInterfaces = <service_name>Service.class)
public final class <service_name>Client {
    // Package-private constructors only - all instantiation is done with builders.
    <service_name>Client(<parameters>) {
        // ...
    }

    // Service methods...

    // A single response API.
    public <model> <service_operation>(<parameters>) {
        // ...
    }

    // A single response API including HTTP response details.
    public Response<<model>> <service_operation>(<parameters>) {
        // ...
    }

    // A paginated sync list API (refer to pagination section for more details).
    public PagedDataCollection<<model>> list<service_operation>(<parameters>) {
        // ...
    }
    
    // A paginated sync list API including HTTP response details (refer to pagination section for more details).
    public PagedDataResponseCollection<<model>> list<service_operation>(<parameters>) {
        // ...
    }

    // Other members.
    ...
}
```

> TODO: Link concrete example of a client class from the Android repository.

#### Async Service Clients

{% include requirement/MUST id="android-async-client-name" %} offer an async service client named `<ServiceName>AsyncClient` containing all service methods. More than one service client may be offered for a single service. An example of an async client is shown below:

```java
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.
package com.azure.android.<group>.<service_name>;

@ServiceClient(
    builder = <service_name>ClientBuilder.class,
    serviceInterfaces = <service_name>Service.class,
    isAsync = true)
public final class <service_name>AsyncClient {
    // Package-private constructors only - all instantiation is done with builders.
    <service_name>AsyncClient(<parameters>) {
        // ...
    }

    // Service methods...

    // A single response API.
    public CompletableFuture<<model>> <service_operation>(<parameters>) {
        // ...
    }

    // A single response API including HTTP response details.
    public CompletableFuture<Response<<model>>> <service_operation>(<parameters>) {
        // ...
    }

    // A paginated async list API (refer to pagination section for more details).
    public CompletableFuture<PagedDataCollection<<model>>> list<service_operation>(<parameters>) {
        // ...
    }

    // A paginated async list API including HTTP response details (refer to pagination section for more details).
    public CompletableFuture<PagedDataResponseCollection<<model>>> list<service_operation>(<parameters>) {
        // ...
    }

    // Other members.
    ...
}
```

{% include requirement/MUST id="android-async-framework" %} use [Android retro future's][RetroFuture] `CompletableFuture` to provide consumers with a high-quality async API.

{% include requirement/MUST id="android-async-rxjava" %} additionally provide a separate library containing an RxJava-based async client containing all service methods. The RxJava-based API must be contained within a separate library from the main library with the suffix `-rx`, e.g. `azure-someservice-rx`. Clients for this library must adhere to the async client naming conventions outlined above.

{% include requirement/MUSTNOT id="android-async-streaming" %} write custom APIs for streaming or async operations. Make use of the existing functionality offered in the Azure core library. Discuss proposed changes to the Azure core library with the [Architecture Board]. Refer to the [Azure Core Types](#using-azure-core-types) section for more information.

#### Service Client Creation

{% include requirement/MUSTNOT id="android-client-constructors" %} provide any `public` or `protected` constructors in the service client, except where necessary to support mock testing. Keep visibility to a minimum by using package-private constructors that may only be called by types in the same package, and then enable instantiation of the service client through the use of service client builders, detailed below.

{% include requirement/MUST id="android-service-client-fluent-builder" %} offer a fluent builder API for constructing service clients named `<service_name>ClientBuilder`, which must support building a sync service client instance and an async service client instance (where appropriate). It must offer `buildClient()` and `buildAsyncClient()` API to create a synchronous and asynchronous service client instance, respectively. Shown in the first code sample below is a generalized template, and following that is a stripped-down example builder.

```java
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.
package com.azure.android.<group>.<service_name>;

// Template of how a builder should look.
@ServiceClientBuilder(serviceClients = {<service_name>Client.class, <service_name>AsyncClient.class})
public final class <service_name>ClientBuilder {
    // private fields for all settable parameters
    ...

    // This is the public constructor used to create the service client, so a public access modifier makes sense here.
    // This is required, and it is intended to prevent any public constructors in the service client itself, because we
    // do not want to allow users to create a service client directly.
    public <service_name>ClientBuilder() {
        // Any initialization necessary for the builder.
    }

    // The buildClient() method returns a new instance of the sync client each time it is called.
    public <service_name>Client buildClient() {
        // Create an async client and pass that into the sync client for sync-over-async impl.
        return new <service_name>Client(buildAsync());
    }

    // The buildAsyncClient() method returns a new instance of the async client each time it is called.
    public <service_name>Client buildAsyncClient() {
        // Configuration of pipeline, etc.
        ...

        // Instantiate new async client instance.
        return new <service_name>AsyncClient(serviceEndpoint, pipeline);
    }

    // Fluent API, each returning 'this', and one for each parameter to configure.
    public <service_name>ClientBuilder <property>(<parameter>) {
        builder.<property>(<parameter>);
        return this;
    }
}
```

```java
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.
package com.azure.android.data.appconfiguration;

// Concrete example of a builder.
@ServiceClientBuilder(serviceClients = {ConfigurationAsyncClient.class, ConfigurationClient.class})
public final class ConfigurationClientBuilder {
    private String endpoint;
    private TokenCredential tokenCredential;
    private ConfigurationServiceVersion version = ConfigurationServiceVersion.getLatest();
    // Other fields and its setters are omitted for brevity.

    // Public constructor - this is the only available front door to creating a service client instance.
    public ConfigurationClientBuilder() {
        // Empty constructor
    }

    // The buildClient() method returns a new instance of the sync client each time it is called.
    public ConfigurationClient buildClient() {
        // Create an async client and pass that into the sync client for sync-over-async impl.
        return new ConfigurationClient(buildAsyncClient());
    }

    // The buildAsyncClient() method returns a new instance of the async client each time it is called.
    public ConfigurationAsyncClient buildAsyncClient() {
        // Configuration of pipeline, etc.
        HttpPipeline pipeline = buildOrGetHttpPipeline();

        // Instantiate new async client instance.
        return new ConfigurationAsyncClient(endpoint, pipeline, serviceVersion);
    }

    // Fluent APIs, each returning 'this', and one for each parameter to configure.

    public ConfigurationClientBuilder endpoint(String endpoint) {
        try {
            new URL(endpoint);
        } catch (MalformedURLException ex) {
            throw logger.logExceptionAsWarning(new IllegalArgumentException("'endpoint' must be a valid URL."));
        }
        this.endpoint = endpoint;
        return this;
    }
}
```

{% include requirement/MUST id="android-service-client-fluent-builder-multiple-clients" %} offer build method 'overloads' for when a builder can build multiple client types. These methods must be named in the form `build<client>Client()` and `build<client>AsyncClient()`. For example, `buildBlobClient()` and `buildBlobAsyncClient()`.

{% include requirement/MUST id="android-service-client-builder-annotation" %} annotate service client builders with the `@ServiceClientBuilder` annotation, setting the annotation parameters appropriately for the service client (e.g. `async` is true for async service clients).

{% include requirement/MUST id="android-service-client-builder-consistency" %} ensure consistency across all HTTP-based client libraries, by using the following names for client builder fluent API:

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

`endpoint` may be renamed if a more user-friendly name can be justified. For example, a blob storage library developer may consider using `new BlobClientBuilder.blobUrl(..)`. In this case, the `endpoint` API should be removed.

{% include requirement/MUST id="android-required-and-optional-client-parameters" %} accept all arguments required to construct a client as individual parameters to the client builder. An argument is considered required if the library author deems it to be essential to the developer experience of the client API, regardless of whether the argument is flagged as required in the service's API spec.

{% include requirement/MUST id="android-client-options-parameter" %} accept all optional arguments for client creation via an [options object](#Using ClientOptions) provided as a single parameter named `clientOptions`. Do not accept individual optional arguments as separate parameters.

{% include requirement/MUST id="android-service-client-builder-state" %} throw an `IllegalStateException` from the builder method when it receives mutually exclusive arguments.  The consumer is over-specifying builder arguments, some of which will necessarily be ignored. The error message in the exception must clearly outline the issue.

{% include requirement/MUST id="android-client-constructor-minimal" %} allow the consumer to construct a service client with the minimal information needed to connect and [authenticate](#authentication) to the service. For example:

{% include requirement/MUST id="android-service-client-builder-validity" %} ensure the builder will instantiate a service client into a valid state. Throw an `IllegalStateException` when the user calls the `build*()` methods with a configuration that is incomplete or invalid.

##### Using ClientOptions

{% include requirement/MUSTNOT id="android-client-options" %} accept options used for customization of the client as individual optional parameters in client builders. Accept a single, immutable `Options` object as an optional parameter for all client builders instead. This object must have a constructor that accepts all possible options for the client constructor as optional parameters. For example:

```java
public class ConfigurationClientOptions extends ClientOptions {
    // An options parameter.
    String someParameter;
    
    public ConfigurationClientOptions(@NonNull ApiVersion apiVersion, @NonNull ClientLogger logger, @NonNull String someParameter) {
         super(apiVersion, logger);
         this.someParameter = someParameter;
    }
}
```

{% include requirement/MUST id="android-client-options-classes-extend" %} make `Options` objects used when initializing a service client extend from Azure Core's `ClientOptions` class.

{% include requirement/MUST id="android-client-options-types" %} use rich types where possible for options. For example, use the `Date` type for dates. When not possible, name the option with a suffix to express the expected type. If the expected type is a unit, the suffix should follow the format `In<Unit>`. Unit should be `ms` for milliseconds, and otherwise the name of the unit. Examples include `timeoutInMs` and `delayInSeconds`.

{% include requirement/MUST id="android-client-options-classes-naming" %} name the _options_ type after the client of the service method it is used for, such that the type is named `<clientName>Options`. For example, above the _options_ type was named `ConfigurationClientOptions`.

{% include requirement/MUST id="android-client-options-location" %} store options classes (and supporting enumerations / classes referenced by such models) within the `options` package inside the library's root directory.

##### Service Versions

{% include requirement/MUST id="android-versioning-latest-service-api" %} call the highest supported service API version by default, and ensure this is clearly documented.

{% include requirement/MUST id="android-versioning-select-service-api" %} provide an enum of supported service API versions that can be supplied via the [options class](#option-parameters) when initializing the service client, as shown below:

```java
public enum ConfigurationApiVersion implements ApiVersion {
  V1_0("1.0");

  private final String version;

  ConfigurationApiVersion(String version) {
    this.version = version;
  }

  @Override
  public String getVersion() {
    return this.version;
  }

  /**
   * Gets the latest service API version supported by this client library.
   *
   * @return The latest {@link ConfigurationApiVersion}.
   */
  public static ConfigurationApiVersion getLatest() {
    return V1_0;
  }
}
```

This can then be called by the developer as such:

```java
ConfigurationClient client = new ConfigurationClientBuilder()
    .credential(<tokenCredential>)
    .endpoint("<endpoint>")
    .options(new ConfigurationClientOptions(ConfigurationApiVersion.V1_0, ClientLogger.getDefault())) // Set the version to V1.
    .buildClient();

// calls V1 service API
ConfigurationSetting setting = client.getConfigurationSetting("name", "label");
```

`apiVersion` is a required parameter of Azure Core's `ClientOptions` class.

{% include requirement/MUST id="android-versioning-latest-service-property" %} return the latest stable API version for the service that is supported by the client using the enum's `getLatest()` method.

#### Service Methods

Service methods are the methods on the client that invoke operations on the service.

{% include requirement/MUST id="android-service-client-method-naming" %} use standard JavaBean naming prefixes for all methods that are not service methods.

{% include requirement/MUSTNOT id="android-async-suffix" %} use the suffix `Async` in methods that do operations asynchronously. Let the fact the user has an instance of an 'async client' provide this context.

{% include requirement/MUSTNOT id="android-async-multiple-methods" %} provide multiple asynchronous methods for a single REST endpoint in the same library, unless to provide overloaded methods to enable alternative or optional method parameters.

##### Naming

{% include requirement/MUST id="android-client-verb-prefix" %} name service methods using a standardized set of verbs or verb prefixes within a set of client libraries for a service. Prefer the use of the following terms for CRUD operations:

<!-- The table data is in yaml format on _data/tables/android_standard_verbs -->
{% assign data = site.data.tables.android_standard_verbs.entries %}
{% include tables/standard_verbs_template.html %}

{% include requirement/SHOULD id="android-service-client-flexibility" %} remain flexible and use names best suited for developer experience.  Don't let the naming rules result in non-idiomatic naming patterns.  For example, Java developers prefer `list` operations over `getAll` operations.

{% include requirement/MUST id="android-service-client-verb-prefix" %} use the verb as as prefix for the method name when object(s) the action will apply to or return is unclear. For example, prefer `storageBlobClient.listContainers()` rather than `storageBlobClient.list()`.

{% include requirement/MUST id="android-service-client-vend-prefix" %} prefix methods in clients that create or vend subclients with `get` and suffix with `Client`. For example, `container.getBlobClient()`.

##### Cancellation

{% include requirement/MUST id="android-async-cancellation" %} support an optional `CancellationToken` object in conformance with the [`RequestOptions` class definition](#option-parameters). This object allows the developer to call `cancel()` on the token or set a timeout, after which a best-effort attempt is made to cancel the request.

{% include requirement/MUST id="android-async-cancellation-implementation" %} cancel any in-flight requests when a developer calls `cancel()` on the `CancellationToken`. If the body of the client method includes multiple, sequential operations, you must check for cancellation before executing any operations after the first. Since the underlying Android network APIs do not permit cancellation of in-flight requests, you must also check for cancellation immediately after receiving any response. If cancellation has been requested, indicate that the call has been cancelled and do not return or otherwise further process the response.

{% include requirement/MUST id="android-async-cancellation-triggers-error" %} return an `AzureException` when cancellation is requested stating that the request was canceled, even if the request was successful.

##### Return Types

Requests to the service fall into two basic groups: methods that make a single logical request, and methods that make a deterministic sequence of requests.  An example of a *single logical request* is a request that may be retried inside the operation. An example of a *deterministic sequence of requests* is a paged operation.

The *logical entity* is a protocol neutral representation of a response. The logical entity may combine data from headers, body, and the status line. For example, you may expose an `ETag` header as a property on the logical entity. `Response<T>` is the ‘complete response’. It contains HTTP headers, status code, and the T object (a deserialized object created from the response body). The T object would be the ‘logical entity’.

{% include requirement/MUST id="android-response-logical-entity" %} return the logical entity (i.e. the `T`) for all **synchronous** service methods.


{% include requirement/MUST id="android-response-return-logical-entity-async-rx" %} return the logical entity (i.e. the `T`) wrapped inside an [android-retrofuture's][RetroFuture] `CompletableFuture` for all non-streaming asynchronous service methods that make network requests. Do not use the JDK's `java.util.concurrent.CompletableFuture`, as this type is not available on all Android devices.

{% include requirement/MUST id="android-response-return-logical-entity-async-rx" %} return the logical entity (i.e. the `T`) wrapped inside a `Single` or `Observable` for all RxJava-based asynchronous service methods that make network requests.

Return `Response<T>` on the maximal overload for a service method with `WithResponse` appended to the name. For example:

```java
Foo foo = client.getFoo(a);
Foo foo = client.getFoo(a, b);
Foo foo = client.getFoo(a, b, c, context); // This is the maximal overload, so it is replaced with the 'withResponse' 'overload' below
Response<Foo> response = client.getFooWithResponse(a, b, c, context);
```

{% include requirement/MUST id="android-response-access-response" %} *make it possible* for a developer to access the complete response, including the status line, headers, and body. The type `Response<T>` encodes this requirement and is the recommended return type for async client methods. The `T` parameter is the type of the logical entity.

{% include requirement/MUST id="android-response-provide-examples" %} provide examples on how to access the raw and streamed response for a request, where exposed by the client library. We don't expect all methods to expose a streamed response.

{% include requirement/MUST id="android-response-pagination" %} return an instance of the `PagedDataCollection` or `PagedDataResponseCollection` classes for all paged operations. For more information on what to return for `list` operations, refer to [Pagination](#pagination).

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="android-response-return-headers" %} return headers and other per-request metadata unless it's obvious as to which specific HTTP request the methods return value corresponds to.

{% include requirement/MUST id="android-response-failure-cases" %} provide enough information in failure cases for an application to take appropriate corrective action, including a message describing what went wrong and details on the corrective actions to take.

{% include requirement/SHOULDNOT id="android-response-reserved-words" %} use reserved words (such as `class`) as a property name within the logical entity. Avoid reserved words in other supported languages.

#### Service Method Parameters

{% include requirement/MUST id="android-required-and-optional-method-parameters" %} accept all arguments required to or execute a method call as individual parameters to the method. An argument is considered required if the library author deems it to be essential to the developer experience of the client API, regardless of whether the argument is flagged as required in the service's API spec.

##### Option Parameters

{% include requirement/MUSTNOT id="android-request-options" %} accept options used for customization of a service client method call as individual optional parameters.

{% include requirement/MUST id="android-request-options-single" %} accept a single `Options` object as an optional parameter for service client methods.

{% include requirement/MUST id="android-request-options-object" %} provide an immutable object named with the suffix `Options` to allow for customization of each service client method call. This object must have a constructor that accepts all possible options for the method call as optional parameters. For example:

```java
//TODO: Add sample
```

{% include requirement/MUST id="android-request-options-classes-extend" %} make `Options` objects used to define options passed to execute a method call extend from Azure Core's `RequestOptions` class.

{% include requirement/MUST id="android-request-options-classes-naming" %} name the _options_ type after the name of the service method it is used for, such that the type is named `<operation>Options`. For example, above the method was `createBlob`, and so the _options_ type was named `CreateBlobOptions`.

{% include requirement/MUST id="android-request-options-types" %} use rich types where possible for options. For example, use the `Date` type for dates. When not possible, name the option with a suffix to express the expected type. If the expected type is a unit, the suffix should follow the format `In<Unit>`. Unit should be `ms` for milliseconds, and otherwise the name of the unit. Examples include `timeoutInMs` and `delayInSeconds`.

{% include requirement/MUST id="android-request-options-withResponse" %} use the _options_ parameter type, if it exists, for all `*WithResponse` methods. If no _options_ parameter type exists, do not create one solely for the `*WithResponse` method.

{% include requirement/MUST id="android-request-options-location" %} store options classes (and supporting enumerations / classes referenced by such models) within the `options` package inside the library's root directory.

{% include requirement/MUST id="android-request-options-design" %} design options types with the same design guidance as given below for model class types, namely fluent setters for optional arguments, using the standard JavaBean naming convention of `get*`, `set*`, and `is*`. Additionally, there may be constructor overloads for each combination of required arguments.

{% include requirement/MAY id="android-request-options-ctor" %} introduce constructor overloads for each combination of required arguments (in a similar manner to [required properties on model types](#model-types)).

##### Parameter Validation

The service client will have several methods that perform requests on the service. _Service parameters_ are directly passed across the wire to an Azure service. _Client parameters_ are not passed directly to the service, but used within the client library to fulfill the request. Examples of client parameters include values that are used to construct a URI, or a file that needs to be uploaded to storage.

{% include requirement/MUST id="general-params-client-validation" %} validate client parameters.

{% include requirement/MUSTNOT id="general-params-server-validation" %} validate service parameters. This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

Common parameter validations include null checks, empty string checks, and range checks. Let the service validate its parameters.

{% include requirement/MUST id="general-params-check-devex" %} test the developer experience when invalid service parameters are passed in. Ensure clear error messages are generated by the client. If the developer experience is inadequate, work with the service team to correct the problem.

#### Methods Returning Collections (Paging)

The Azure SDK for Android contains the and `PagedDataCollection`, `PagedDataResponseCollection` types, which provide idiomatic ways to iterate through all results of a paged operation:

{% include requirement/MUST id="android-pagination-sync-support" %} return Azure Core's `PagedDataCollection` for APIs that expose paginated collections. This type provides access to paged results on a per-page basis.

{% include requirement/MUST id="android-pagination-rest-sync-support" %} return Azure Core's `PagedDataResponseCollection` for synchronous APIs that expose paginated collections that need to include its HTTP response details. This type provides access to paged results on a per-page basis.

For example, the Azure Communication Services Chat sync client offers the following API:

```java
public final class ChatClient {
    // Synchronous API returning a list of chat messages from a thread, including the response details.
    public PagedDataResponseCollection<ChatMessage, Page<ChatMessage>> listChatMessagesWithPageResponse(String chatThreadId, Integer maxPageSize, OffsetDateTime startTime) {
        ...
    }
}

// Page-by-page iteration with Response
final PagedDataResponseCollection<ChatMessage, Page<ChatMessage>> pagesWithResponse = chatServiceClient.listChatMessagesWithPageResponse("threadId", 5, OffsetDateTime.now());
final Response<Page<ChatMessage>> firstPageWithResponse = pagesWithResponse.getFirstPage();
final Response<Page<ChatMessage>> nextPageWithResponse = pagesWithResponse.getPage(firstPageWithResponse.getValue().getNextPageId());

// Item-by-item iteration.
final Page<ChatMessage> nextPage = nextPageWithResponse.getValue();

for (ChatMessage chatMessage : nextPage.getItems()) {
    ...
}
```

{% include requirement/MUSTNOT id="android-pagination-no-collections" %} use other collection types for sync APIs that return multiple values (for example, `List`, or `Iterator`).

{% include requirement/MUST id="android-pagination-async" %} use [android-retrofuture's][RetroFuture] `CompletableFuture` type in combination with Azure Core's `PagedDataResponseCollection` for handling HTTP responses from asynchronous APIs that expose paginated collections.

For example, the Azure Communication Services Chat async client offers the following API:

```java
// TODO: Add sample for async paging APIs.
```

{% include requirement/MUST id="android-pagination-distinct-types" %} use the same type for entities returned from a list operation vs. a get operation if those operations return different views of the same result. For example a list operation may provide only a minimal representation of each result, with the expectation that a get operation must be performed for each result to access the full representation. If the representations are compatible, reuse the same type for both the list and the get operation. Otherwise, it is permissible to use distinct types for each operation.

{% include important.html content="Services should refrain from having a difference between the type of a particular entity as it exists in a list versus the result of a GET request for that individual item as it makes the client library's surface area simpler." %}

{% include requirement/MUSTNOT id="android-pagination-large-get-iterator" %} expose an iterator over each individual item if getting each item requires a corresponding GET request to the service. One GET per item is often too expensive and so not an action we want to take on behalf of users.

{% include requirement/MUSTNOT id="android-pagination-array-support" %} expose an API to get a paginated collection into an array. This is a dangerous capability for services which may return many, many pages.

{% include requirement/MUST id="android-pagination-paging-api" %} expose paging APIs when iterating over a collection. Paging APIs must accept a continuation token (from a prior run) and a maximum number of items to return, and must return a continuation token as part of the response so that the iterator may continue, potentially on a different machine.

This is automatically handled by `PagedDataCollection`, and `PagedDataResponseCollection`. Consumers of this APIs can consume individual items via the `getItems()` API in the underlying `Page` of these collections.

The `getPage()` API in the aforementioned collections accepts a continuation token (`pageId`) string, which will retrieve the page specified by this token.

#### Methods Invoking Long Running Operations

Long-running operations are uncommon in a mobile context. If you feel like you need long running operations, contact the [Azure SDK mobile team](mailto:azuresdkmobileteam@microsoft.com) for advice.

> TODO: Expand upon why LROs are uncommon in a mobile context.

#### Conditional Request Methods

> TODO

#### Hierarchical Clients

> TODO: Add discussion of hierarchical clients

### Supporting Types

#### Model Types

Model types are classes that developers of applications use to provide required information into, or to receive information from, Azure services. For example:

```java
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.
package com.azure.android.ai.textanalytics.models;

@Fluent
public final class PiiTaskParameters {
    // Optional properties.
    private PiiTaskParametersDomain domain;
    private String modelVersion = "latest";

   // Optional properties have getters and fluent setters.
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

{% include requirement/MUSTNOT id="android-models-builder" %} offer a separate builder class for model classes.

{% include requirement/MUST id="android-models-constructors" %} provide public constructors for all model classes that a user is allowed to instantiate. Model classes that are not instantiable by the user, for example if they are model types returned from the service, must not have any publicly visible constructors.

Because model types can represent many different kinds of models, it is important that they can correctly enforce required properties. Whilst many models have no required properties, some do, and moreso, some models can even support multiple mutually exclusive sets of required properties.

{% include requirement/MUST id="android-models-constructors-args" %} provide a no-args constructor if a model type has no required properties.

{% include requirement/MUST id="android-models-constructors-args-required" %} provide one or more constructors with arguments, if a model type has required properties. If there are multiple mutually exclusive sets of supported required parameters, a constructor must be introduced for each of these. For example:

```java
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.
package com.azure.android.ai.textanalytics.models;

@Fluent
public final class TextDocumentInput {
    // Required properties.
    private final String id;
    private final String text;
  
    // Optional property.
    private String language;
  
    // Constructor to enforce setting the required properties.
    public TextDocumentInput(String id, String text) {
        this.id = Objects.requireNonNull(id, "'id' cannot be null.");
        this.text = Objects.requireNonNull(text, "'text' cannot be null.");
    }
  
    // Required properties only have getters.
    public String getId() {
        return this.id;
    }
  
    public String getText() {
        return this.text;
    }
  
    // Optional property has both getter and fluent setter.
    public String getLanguage() {
        return this.language;
    }
  
    public TextDocumentInput setLanguage(String language) {
        this.language = language;
        return this;
    }
}
```

{% include requirement/MUST id="android-models-fluent" %} provide a fluent setter API to configure the model class, where each `set` method should `return this`. This allows chaining of set operations.

{% include requirement/MUST id="android-models-fluent" %} override all `set` methods when extending a fluent type to return the extended type. This allows chaining of `set` operations on the sub-class.

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

{% include requirement/MUST id="android-models-fluent-annotation" %} apply the `@Fluent` annotation to the class.

Fluent types must not be immutable.  Don't return a new instance on each setter call.

{% include requirement/MUST id="android-models-javabeans" %} use the JavaBean naming convention of `get*`, `set*`, and `is*`.

{% include requirement/MUST id="android-models-deserialize" %} include static methods if new model instances are required to be created from raw data. The static method names should be `from<dataFormat>`. For example, to create an instance of `BinaryData` from a string, include a static method called `fromString` in `BinaryData` class.

Model types sometimes exist only as an Azure service return type, and developers would never instantiate these. Often, these model types have API that is not user-friendly (in particular, overly complex constructors). It would be best for developers if they were never presented with this API in the first place, and we refer to these as 'undesirable public API'.

{% include requirement/MUST id="android-models-interface" %} put model classes that are intended as service return types only, and which have undesirable public API into the `.implementation.models` package. In its place, an interface should be put into the public-facing `.models` package, and it should be this type that is returned through the public API to end users.

Examples of situations where this is applicable include when there are constructors or setters on a type which receive implementation types, or when a type should be immutable but needs to be mutable internally. The interface should have the model type name, and the implementation (within `.implementation.models`) should be named `<interfaceName>Impl`.

#### Enumerations

{% include requirement/MUST id="android-enums" %} use an `enum` for parameters, properties, and return types when values are known.

{% include requirement/MUST id="android-naming-enum-uppercase" %} use all upper-case names for enum (and 'expandable' enum) values. `EnumType.FOO` and `EnumType.TWO_WORDS` are valid, whereas `EnumType.Foo` and `EnumType.twoWords` are not.

{% include requirement/MAY id="android-expandable-enums" %} use the `ExpandableStringEnum` type provided by Azure Core to define an enum-like API that declares well-known fields but which can also contain unknown values returned from the service, or user-defined values passed to the service. An example expandable enum, taken from azure-core's `OperationStatus` type, is shown below:

```java
public static final class OperationStatus extends ExpandableStringEnum<OperationStatus> {
    public static final OperationStatus NOT_STARTED = fromString("NOT_STARTED");
    public static final OperationStatus IN_PROGRESS = fromString("IN_PROGRESS");
    public static final OperationStatus SUCCESSFULLY_COMPLETED = fromString("SUCCESSFULLY_COMPLETED");
    public static final OperationStatus FAILED = fromString("FAILED");
    public static final OperationStatus USER_CANCELLED = fromString("USER_CANCELLED");

    /**
     * Creates or finds a {@link OperationStatus} from its string representation.
     * @param name A name to look for.
     * @return The corresponding {@link OperationStatus}.
     */
    public static OperationStatus fromString(String name) {
        return fromString(name, OperationStatus.class);
    }
}
```

{% include requirement/MUST id="android-enums-no-future-growth" %} use [Android's TypeDef][TypeDef] notation instead of enum only if the values are known to not change like days of a week, months in a year etc.

{% include requirement/MUST id="android-enums-future-growth" %} use `ExpandableStringEnum` provided by Azure Core for enumerations if the values are known to expand in future.

#### Using Azure Core Types

{% include requirement/MUST id="android-core-types-must" %} make use of packages in Azure Core to provide behavior consistent across all Azure SDK libraries. This includes, but is not limited to:

* `HttpClient`, `HttpPipeline`, `Response`, etc. for http client, pipeline and related functionality
* `ClientLogger` for logging
* `PagedDataCollection` and `PagedDataResponseCollection` for returning paged results

See the [Azure Core README][Azure Core] for more details.

#### Using Primitive Types

{% include requirement/MUSTNOT id="android-api-old-date-time" %} create API that exposes the old Java date library (e.g. `java.util.Date`, `java.util.Calendar`, and `java.util.Timezone`), nor the newer date / time APIs that shipped in JDK 8 in the `java.util.time` package. All APIs must use the [ThreeTenABP Date][ThreeTenABP] APIs.

{% include requirement/MUSTNOT id="android-api-url" %} create API that exposes the `java.net.URL` API. This API is difficult to work with, and more frequently gets in the users way rather than provide any real assistance. Instead, use the String type to represent the URL. When it is necessary to parse this String into a URL, and if it fails to be parsed (throwing a checked `MalformedURLException`), catch this internally and throw an unchecked `IllegalArgumentException` instead.

{% include requirement/MUST id="android-wrap-primitives" %} wrap primitive types where appropriate to represent a meaningful domain entity even if the model type contains a single field. For example, a phone number is just a string, but creating a new type to wrap primitive `String` type can be more informative and represents a domain concept. It may also provide stronger guarantees and validation than just the primitive type.

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

#### Using Android-compatible Java APIs

{% include requirement/MUST id="android-library-java-lang" %} write client libraries in Java. This avoids forcing customers to depend on the Kotlin runtime in their applications.

{% include requirement/MUST id="android-library-java-version" %} write client libraries using Java 8 syntax. Java 8 syntax constructs will be down-leveled using [Java 8 language feature desugaring](https://developer.android.com/studio/write/java8-support#supported_features) provided by Android Gradle Plugin 3.0.0+. This includes use of the following Java 8 language features:

* Lambda expressions
* Method references
* Type annotations (except `TYPE_USE` and `TYPE_PARAMETER`)
* Default and static interface methods
* Repeating annotations

{% include requirement/MUSTNOT id="android-library-java-api" %} use Java 8+ APIs. Some such APIs are able to be down-leveled using [Java 8+ API desugaring](https://developer.android.com/studio/write/java8-support#library-desugaring) provided by Android Gradle Plugin 4.0.0+. However many developers may not be using a sufficiently updated version of the plugin, and library desugaring injects additional code into the customer's application, potentially increasing the APK size or method count. This includes use of the following Java 8+ APIs:

* Sequential streams (`java.util.stream`)
* `java.time`
* `java.util.function`
* Java 8+ additions to `java.util.{Map,Collection,Comparator}`
* Optionals (`java.util.Optional`, `java.util.OptionalInt` and `java.util.OptionalDouble`)
* Java 8+ additions to `java.util.concurrent.atomic` (new methods on `AtomicInteger`, `AtomicLong` and `AtomicReference`)
* `ConcurrentHashMap`

### Exceptions

Error handling is an important aspect of implementing a client library. It is the primary method by which problems are communicated to the consumer. We convey errors to developers by throwing appropriate exceptions from our service methods.

{% include requirement/MUST id="android-errors-http-request-failed" %} throw an exception when any HTTP request fails with an HTTP status code that is not defined by the service/Swagger as a successful status code.

{% include requirement/MUST id="android-errors-use-unchecked-exceptions" %}  use unchecked exceptions. Java offers checked and unchecked exceptions, where checked exceptions force the user to introduce verbose `try ... catch` code blocks and handle each specified exception. Unchecked exceptions avoid verbosity and improve scalability issues inherent with checked exceptions in large apps.

In the case of a higher-level method that produces multiple HTTP requests, either the last exception or an aggregate exception of all failures should be produced.

{% include requirement/MUST id="android-errors-standard-types" %} use the following standard Java exceptions for pre-condition checking:

| Exception                       | When to use                                                    |
|---------------------------------|----------------------------------------------------------------|
| `IllegalArgumentException`      | When a method argument is non-null, but inappropriate          |
| `IllegalStateException`         | When the object state means method invocation can't continue   |
| `NullPointerException`          | When a method argument is `null` and `null` is unexpected      |
| `UnsupportedOperationException` | When an object doesn't support method invocation               |

{% include requirement/MUSTNOT id="android-errors-no-new-types" %} create a new error type when a language-specific error type will suffice.

{% include requirement/MUST id="android-errors-javadoc" %} specify all checked and unchecked exceptions thrown in a method within the JavaDoc documentation on the method as `@throws` statements.

{% include requirement/MUST id="android-errors-exception-tree" %} use the existing exception types present in the Azure Core library for service request failures. Avoid creating new exception types. The following list outlines all available exception types (with indentation indicating exception type hierarchy):

- `AzureException`: Never use directly. Throw a more specific subtype.
  - `HttpResponseException`: Thrown when an unsuccessful response is received with http status code (e.g. 3XX, 4XX, 5XX) from the service request. 
    - `ClientAuthenticationException`: Thrown when there’s a failure to authenticate against the service.
    - `DecodeException`: Thrown when there’s an error during response deserialization.
    - `ResourceExistsException`: Thrown when an HTTP request tried to create an already existing resource.
    - `ResourceModifiedException`: Thrown for invalid resource modification with status code of 4XX, typically 412 Conflict.
    - `ResourceNotFoundException`: Thrown when a resource is not found, typically triggered by a 412 response (for PUT) or 404 (for GET/POST).
    - `TooManyRedirectsException`: Thrown when an HTTP request has reached the maximum number of redirect attempts.
- `ServiceResponseException`: Thrown when the request was sent to the service, but the client library wasn't able to understand the response.
- `ServiceRequestException`: Thrown for an invalid response with custom error information.

> TBD: 
> * Hook in to HockeyApp

### Authentication

Azure services use different kinds of authentication schemes to allow clients to access the service. Conceptually, there are two entities responsible in this process: a credential and an authentication policy. Credentials provide confidential authentication data. Authentication policies use the data provided by a credential to authenticate requests to the service. 

{% include requirement/MUST id="android-auth-fluent-builder" %} provide service client fluent builder APIs that accept an instance of the appropriate Azure Core credential abstraction.

> TODO : Determine the appropriate credential abstractions for a mobile context.

{% include requirement/MUST id="android-auth-support" %} support all authentication techniques that the service supports and that make sense in a mobile context. Service principal authentication generally does not make sense, for example.

> TODO: Determine what are the supported authentication scenarios, which credential types will represent them and where will said types reside (Azure Core, Azure Identity, etc.)

{% include requirement/MUSTNOT id="android-auth-no-token-persistence" %} persist, cache, or reuse security credentials. Security credentials should be considered short lived to cover both security concerns and credential refresh situations.

{% include requirement/MUST id="android-auth-azure-core" %} use authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="android-auth-provide-credential-types" %} define a public custom credential type which enables clients to authenticate requests using the custom scheme.

{% include requirement/SHOULDNOT id="android-auth-credential-type-base" %} define custom credential types extending or implementing abstractions from Azure Core.

{% include requirement/MUST id="android-auth-credential" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service. If using a service-specific credential type, the implementation must be non-blocking and atomic.

{% include requirement/MUST id="android-auth-credential-type-placement" %} define custom credential types in the same namespace and package as the client, or in a service group namespace and shared package, not in Azure Core or Azure Identity.

{% include requirement/MUST id="android-auth-credential-type-prefix" %} prepend custom credential type names with the service name or service group name to provide clear context to its intended scope and usage.

{% include requirement/MUST id="android-auth-credential-type-suffix" %} append `Credential` to the end of the custom credential type name. Note this must be singular, not plural. 

{% include requirement/MUST id="android-auth-provide-credential-constructor" %} define a constructor or factory for the custom credential type which takes in ALL data needed for the custom authentication protocol.

{% include requirement/MUST id="android-auth-provide-update-method" %} define an update method which accepts all mutable credential data, and updates the credential in an atomic, thread safe manner.

{% include requirement/MUSTNOT id="android-auth-credential-set-properties" %} define public settable properties or fields which allow users to update the authentication data directly in a non-atomic manner.

{% include requirement/SHOULDNOT id="android-auth-credential-get-properties" %} define public properties or fields which allow users to access the authentication data directly. They are most often not needed by end users, and are difficult to use in a thread safe manner. In the case that exposing the authentication data is necessary, all the data needed to authenticate requests should be returned from a single API which guarantees the data returned is in a consistent state.

{% include requirement/MUST id="android-auth-provide-client-constructor" %} provide service client constructors or factories that accept all supported credential types.

Client libraries may support providing credential data via a connection string __ONLY IF__ the service provides a connection string to users via the portal or other tooling. Connection strings are generally good for getting started as they are easily integrated into an application by copy/paste from the portal. However, connection strings are considered a lesser form of authentication because the credentials cannot be rotated within a running process.

{% include requirement/MAY id="android-auth-connection-strings"%} provide a service client initializer that accepts a connection string if appropriate. The connection string must be provided as the first parameter to the initializer and must be named `connectionString`. When supporting connection strings, the documentation must include a warning that building credentials such as connection strings into a consumer-facing application is inherently insecure.

{% include requirement/MUSTNOT id="android-auth-connection-strings-only" %} support initializing a service client with a connection string unless such connection string is available within tooling (for copy/paste operations).

{% include requirement/SHOULDNOT id="android-auth-no-connection-strings-embedded" %} support connection strings with embedded secrets. Android apps are not cryptographically secure and may be distributed to millions of devices. A developer should assume that any credential placed in an Android app is compromised.

When implementing authentication, don't open up the consumer to security holes like PII (personally identifiable information) leakage or credential leakage. Credentials are generally issued with a time limit, and must be refreshed periodically to ensure that the service connection continues to function as expected. Ensure your client library follows all current security recommendations and consider an independent security review of the client library to ensure you're not introducing potential security problems for the consumer.

If your service implements a non-standard credential system (that is, a credential system that is not supported by Azure Core), then you need to produce an authentication policy for the HTTP pipeline that can authenticate requests given the alternative credential types provided by the client library.

{% include requirement/MUST id="android-auth-policy" %} provide a suitable authentication policy that authenticates the HTTP request in the HTTP pipeline when using non-standard credentials.

### Namespaces

Java uses packages to group related types. Grouping services within a cloud infrastructure is common since it aids discoverability and provides structure to the reference documentation.

In Java, the namespace should be named `com.azure.android.<group>.<service>[.<feature>]`. All consumer-facing APIs that are commonly used should exist within this package structure. Here:

- `<group>` is the group for the service (see the list above)
- `<service>` is the service name represented as a single word
- `<feature>` is an optional subpackage to break services into separate components (for example, storage may have `.blob`, `.files`, and `.queues`)

{% include requirement/MUST id="android-namespaces-prefix" %} start the package with `com.azure.android` to indicate an Azure client library for Android.

{% include requirement/MUST id="android-namespaces-format" %} construct the package name with all lowercase letters (no camel case is allowed), without spaces, hyphens, or underscores. For example, Azure Key Vault would be in `com.azure.android.security.keyvault` - note that the two words 'Key' and 'Vault' are brought together to `keyvault`, instead of `keyVault`, `key_vault`, or `key-vault`. It may further be shortened if the shortened version is well-known in the community. For example, "Azure Media Analytics" would have a compressed service name of `mediaanalytics`, and "Azure Service Bus" would become `servicebus`.

{% include requirement/MUST id="android-namespaces-package-name" %} pick a package name that allows the consumer to tie the package to the service being used. The package does **NOT** change when the branding of the product changes. Avoid the use of marketing names that may change.

{% include requirement/MUST id="android-namespaces-approved-list" %} use the following list as the group of services:

{% include tables/data_namespaces.md %}

If the client library does not seem to fit into the group list, contact the [Architecture Board] to discuss the namespace requirements.

{% include requirement/MUST id="android-namespaces-management" %} place the management (Azure Resource Manager) API in the `management` group. Use the grouping `<AZURE>.management.<group>.<service>` for the namespace. We do not expect many management APIs for Android, so this should be uncommon.

{% include requirement/MUSTNOT id="android-namespaces-ambiguity" %} choose similar names for clients that do different things.

{% include requirement/MUST id="android-namespaces-registration" %} register the chosen namespace with the [Architecture Board]. Open an issue to request the namespace. See [the registered namespace list](registered_namespaces.html) for a list of the currently registered namespaces.

{% include requirement/MUSTNOT id="android-namespaces-implementation" %} allow implementation code (that is, code that doesn't form part of the public API) to be mistaken as public API. There are two valid arrangements for implementation code:

1. Implementation classes can be placed within a subpackage named `implementation`.
2. Implementation classes can be made package-private and placed within the same package as the consuming class.

CheckStyle checks ensure that classes within an `implementation` package aren't exposed through public API.

#### Example Namespaces

Here are some examples of namespaces that meet these guidelines:

- `com.azure.android.data.cosmos`
- `com.azure.android.communication.common`
- `com.azure.android.storage.blob`

Here are some namespaces that do not meet the guidelines:

- `com.microsoft.azure.cosmosdb` (not in the `com.azure.android` namespace and does not use grouping)
- `com.azure.identity.activedirectory` (not in the `com.azure.android` namespace)
- `com.azure.mixedreality.kinect` (the grouping is not in the approved list)

### Support for Mocking

{% include requirement/MUST id="android-testing-stub-os" %} encapsulate access to Android OS APIs by way of an intermediate interface. This allows the runtime implementation to be swapped out for a test implementation in unit tests.

{% include requirement/MUST id="android-testing-mocking" %} support mocking of network operations.

> TODO: Say something about mocking requests and how to design for it.

## Azure SDK Library Design

### Supported Platforms

Android developers need to concern themselves with the runtime environment they are running in. The Android ecosystem is very fragmented, meaning that multiple versions and form factors are prevalent.

{% include requirement/MUST id="android-library-support" %} support all versions of Android starting with API level 16 (Jelly Bean).

{% include requirement/MUST id="android-library-java-lang" %} write client libraries in Java. This avoids forcing customers to depend on the Kotlin runtime in their applications.

{% include requirement/MUST id="android-java8-support" %} support Java 8 language features that do not require [desugaring](https://developer.android.com/studio/write/java8-support#library-desugaring) to work on older Android versions. For more information on the list of supported language features, please refer [Use Java 8 language features and APIs](https://developer.android.com/studio/write/java8-support#supported_features).

### Packaging

#### Gradle and Android Studio

All client libraries for Android standardize on the Gradle build tooling for build and dependency management. This section details the standard configuration that must be used in all client libraries.

{% include requirement/MUST id="android-build-gradle" %} ship a `build.gradle` file for each client library, or for each module within that client library (e.g. Storage might have one each for blob, queue, and file).

{% include requirement/MUST id="android-manifest-package-suffix" %} specify the `package` in the package's `AndroidManifest.xml` to use the prefix `com.azure.android`.

{% include requirement/MUST id="android-manifest-package-name" %} name Android library modules to be of the form `azure-<group>-<service>`, for example, `azure-storage-blob`. In cases where the client library has multiple children modules, set the root module name to be of the form `azure-<group>-<service>-parent`.

{% include requirement/MUST id="android-gradle-name" %} specify the `ext.publishName` element to take the form `Microsoft Azure Android client library for <service name>`.

{% include requirement/MUST id="android-gradle-description" %} specify the `description` element to be a slightly longer statement along the lines of `This package contains the Microsoft Azure <service> client library`.

#### Service-Specific Common Libraries

There are occasions when common code needs to be shared between several client libraries. For example, a set of cooperating client libraries may wish to share a set of exceptions or models.

{% include requirement/MUST id="general-commonlib-approval" %} gain [Architecture Board] approval prior to implementing a common library.

{% include requirement/MUST id="general-commonlib-minimize-code" %} minimize the code within a common library. Code within the common library is available to the consumer of the client library and shared by multiple client libraries within the same namespace.

The common library should use the `common` suffix.  For example, if Azure Storage has a common library, it would be called `azure-storage-common`.

A common library will only be approved if:

* The consumer of the non-shared library will consume the objects within the common library directly, AND
* The information will be shared between multiple client libraries.

Let's take two examples:

1. Implementing two Cognitive Services client libraries, we find a model is required that is produced by one Cognitive Services client library and consumed by another Cognitive Services client library, or the same model is produced by two client libraries. The consumer is required to do the passing of the model in their code, or may need to compare the model produced by one client library vs. that produced by another client library. This is a good candidate for choosing a common library.

2. Two Cognitive Services client libraries throw an `ObjectNotFound` exception to indicate that an object was not detected in an image.  The user might trap the exception, but otherwise will not operate on the exception. There is no linkage between the `ObjectNotFound` exception in each client library. This is not a good candidate for creation of a common library (although you may wish to place this exception in a common library if one exists for the namespace already). Instead, produce two different exceptions - one in each client library.

### Versioning

{% include requirement/MUST id="android-versioning-backwards-compatibility" %} be 100% backwards compatible with older versions of the same package.

{% include requirement/MUST id="android-versioning-highest-api" %} call the highest supported service API version by default.

{% include requirement/MUST id="android-versioning-select-api-version" %} allow the consumer to explicitly select a supported service API version when instantiating the service client, by using the service client builder with a property called `serviceVersion`. This method must take a type implementing the `ServiceVersion` interface, named specifically for the service, but as generally as possible. For example, `IdentityServiceVersion` for Identity. For a service with multiple sub-services, such as Storage, if the services all share a common versioning system, `StorageServiceVersion` would suffice. If they did not, it would be necessary to have separate `BlobServiceVersion`, `QueueServiceVersion`, and `FileServiceVersion` enums.

{% include requirement/MUST id="android-versioning-enum-latest" %} offer a `getLatest()` method on the enum that returns the latest service version. If a consumer doesn't specify a service version, the builder will call `getLatest()` to obtain the appropriate service version.

{% include requirement/MUST id="android-versioning-enum-value-naming" %} use the version naming used by the service itself in naming the version values in the enum. The standard approach takes the form `V<year>_<month>_<day>`, such as `V2019_05_09`. Being consistent with the service naming enables easier cross-referencing between service versions and the availability of features in the client library.

{% include note.html content="Third-party reusable libraries shouldn't change behavior without an explicit decision by the developer.  When developing libraries that are based on the Azure SDK, lock the library to a specific service version to avoid changes in behavior." %}

{% include requirement/MUST id="android-versioning-new-package" %} introduce a new library (with new library names, new package names, and new type names) if you must do an API breaking change.

Breaking changes should happen rarely, if ever. Register your intent to do a breaking change with the [Architecture Board]. You'll need to have a discussion with the language architect before approval.

#### Client Version Numbers

A consistent version number scheme allows consumers to determine what to expect from a new version of the library.

{% include requirement/MUST id="android-version-semver" %} use _MAJOR_._MINOR_._PATCH_ format for the library version.

Use `-beta.N` suffix for beta package versions. For example, `1.0.0-beta.2`.

{% include requirement/MUST id="android-version-change-on-release" %} change the version number of the client library when **ANYTHING** changes in the client library.

{% include requirement/MUST id="android-version-patching" %} increment the patch version when fixing a bug.

{% include requirement/MUSTNOT id="android-version-features-in-patch" %} include new APIs in a patch release.

{% include requirement/MUST id="android-version-add-feature" %} increment the major or minor version when adding support for a service API version.

{% include requirement/MUST id="android-version-add-api" %} increment the major or minor version when adding a new method to the public API.

{% include requirement/SHOULD id="android-version-major-changes" %} increment the major version when making large feature changes.

### Dependencies

Dependencies bring in many considerations that are often easily avoided by avoiding the dependency.

- **Versioning** - Many programming languages do not allow a consumer to load multiple versions of the same package. So, if we have an client library that requires `v3` of package `Foo` and the consumer wants to use `v5` of package `Foo`, then the consumer cannot build their application. This means that client libraries should not have dependencies by default.
- **Size** - Consumer applications for mobile devices must be lightweight. Removing additional code (like dependencies) reduces the size.
- **Licensing** - You must be conscious of the licensing restrictions of a dependency and often provide proper attribution and notices when using them.
- **Compatibility** - Often times you do not control a dependency and it may choose to evolve in a direction that is incompatible with your original use.
- **Security** - If a security vulnerability is discovered in a dependency, it may be difficult or time consuming to get the vulnerability corrected if Microsoft does not control the dependency's code base.

{% include requirement/MUST id="android-dependencies-azure-core" %} depend on the Android Azure Core (`com.azure.android.core`) library for functionality that is common across all client libraries. This library includes APIs for HTTP connectivity, global configuration, logging, and credential handling.

{% include requirement/MUSTNOT id="android-dependencies-approved" %} be dependent on any other packages within the client library distribution package, with the exception of the following:

{% include_relative approved_dependencies.md %}

> TODO: We should have a guideline around use of AndroidX libraries. Or if they're treated the same as other external dependencies we should add them to the approved dependencies list.

> TODO: Add a link to dependency whitelist. Also mention about transitive dependencies of those dependencies.

{% include requirement/MUSTNOT id="android-dependencies-archboard" %} introduce new dependencies on third-party libraries that are already referenced from the top level `build.gradle` file, without first discussing with the [Architecture Board].

{% include requirement/MUSTNOT id="android-dependencies-versions" %} specify or change dependency versions in your client library Gradle file. All dependency versioning must be centralized through the common parent `build.gradle` file.

{% include requirement/MUSTNOT id="android-dependencies-snapshot" %} include dependencies on pre-released or beta versions of external libraries. All dependencies must be approved for general use.

{% include requirement/SHOULD id="android-dependencies-vendoring" %} consider copying or linking required code into the client library in order to avoid taking a dependency on another package that could conflict with the ecosystem. Make sure that you are not violating any licensing agreements and consider the maintenance that will be required of the duplicated code. ["A little copying is better than a little dependency"][1] (YouTube).

{% include requirement/MUSTNOT id="android-dependencies-concrete" %} depend on concrete logging, dependency injection, or configuration technologies (except as implemented in the Azure Core library). The client library will be used in applications that might be using the logging, DI, and configuration technologies of their choice.

### Native code

Native code plugins cause compatibility issues and require additional scrutiny. Certain languages compile to a machine-native format (for example, C or C++), whereas most modern languages opt to compile to an intermediary format to aid in cross-platform support.

{% include requirement/SHOULDNOT id="android-no-native-code" %} write platform-specific / native code. If you feel like you need to include native binaries in your library, contact the [Azure SDK mobile team](mailto:azuresdkmobileteam@microsoft.com) for advice.

{% include requirement/MUST id="android-native-code-arch" %} include binaries for all common Android architectures if your library includes platform-specific / native code. You should only include such native code in the Android library if:

* You distribute full source and it is compiled in the context of the customer code.
* You hide the implementation code behind a Java-based facade.
* You are doing so for performance reasons. No other reason is acceptable.

> TODO: Develop and significantly expand upon our guidance for libraries with native (C/C++) code

### Documentation

{% include requirement/MUST id="android-javadoc-build" %} ensure that anybody can clone the repo containing the client library and generate the full and complete JavaDoc output for the code, without any need for additional processing steps.

{% include requirement/MUST id="android-javadoc-full-docs" %} include descriptive text of the method, as well as all parameters, the returned value (if any), all checked exceptions, as well as all unchecked exceptions. Failing to document unchecked exceptions means that users do not have any indication of how they can handle exceptional circumstances.

{% include requirement/MUST id="android-javadoc-samples" %} include code samples in all class-level JavaDoc, and in relevant method-level JavaDoc.

{% include requirement/MUSTNOT id="android-javadoc-hard-coding" %} hard-code the sample within the JavaDoc (where it may become stale). Put code samples in `/src/samples/java` and use the available tooling to reference them.

{% include requirement/MUST id="android-javadoc-naming-samples" %} follow the naming convention outlined below for naming samples tags:

* If a new instance of the class is created through build() method of a builder or through constructor: `<packagename>.<classname>.instantiation`
* For other methods in the class: `<packagename>.<classname>.<methodName>`
* For overloaded methods, or methods with arguments: `<packagename>.<classname>.<methodName>#<argType1>-<argType2>`
* Camel casing for the method name and argument types is valid, but not required.

## Repository Guidelines

### Documentation

#### General guidelines

{% include requirement/MUST id="android-docs-content-dev" %} include your service's content developer in the architectural review for your library. To find the content developer you should work with, check with your team's Program Manager.

{% include requirement/MUST id="android-docs-contributors-guide" %} follow the [Azure SDK Contributors Guide] (MICROSOFT INTERNAL)

{% include requirement/MUST id="android-docs-style-guide" %} adhere to the Microsoft style guides when you write public-facing documentation. (MICROSOFT INTERNAL)

* [Microsoft Writing Style Guide]
* [Microsoft Cloud Style Guide]

Use the style guides for both long-form documentation like a README and the `docstrings` in your code.

{% include requirement/SHOULD id="android-docs-into-silence" %} attempt to document your library into silence. Preempt developers' usage questions and minimize GitHub issues by clearly explaining your API in the `docstrings`. Include information on service limits and errors they might hit, and how to avoid and recover from those errors.

As you write your code, doc it so you never hear about it again. The fewer questions you have to answer about your client library, the more time you have to build new features for your service.

{% include requirement/MUSTNOT id="android-docs-gradle-versions" %} include version details when specifying Gradle dependency statements..

#### Samples

Code samples are small applications that demonstrate a certain feature that is relevant to the client library.  Samples allow developers to quickly understand the full usage requirements of your client library. Code samples shouldn't be any more complex than they needed to demonstrate the feature. Don't write full applications. Samples should have a high signal to noise ratio between useful code and boilerplate code for non-related reasons.

{% include requirement/MUST id="android-samples-include-them" %} include code samples alongside your library's code within the repository. The samples should clearly and succinctly demonstrate the code most developers need to write with your library. Include samples for all common operations.  Pay attention to operations that are complex or might be difficult for new users of your library. Include samples for the champion scenarios you've identified for the library.

{% include requirement/MUST id="android-samples-location" %} place code samples within the `/src/samples/java` directory within the client library root directory. The samples will be compiled, but not packaged into the resulting jar.

> TODO: Add section about making code runnable through means similar to a Java class' main method.

{% include requirement/MUST id="android-samples-coding-style" %} use the latest coding conventions when creating samples. Make liberal use of Java 8 syntax and APIs (for example, diamond operators) as they remove boilerplate from your samples and highlight you library, as long as they are included in [Android's Java 8 supported features list for the Gradle 3.0.0+ plugin][Java 8 supported features].

{% include requirement/MUST id="android-samples-use-latest-library" %} compile sample code using the latest major release of the library. Review sample code for freshness.  At least one commit must be made (to update dependencies) to each sample per semester.

{% include requirement/MUST id="android-samples-grafting" %} ensure that code samples can be easily grafted from the documentation into a users own application. For example, don't rely on variable declarations in other samples.

{% include requirement/MUST id="android-samples-readability" %} write code samples for ease of reading and comprehension over code compactness and efficiency.

{% include requirement/MUST id="android-samples-platform-support" %} ensure that samples can run in Android Studio for Windows, macOS and Linux. Don't use a non-standard developer toolchain.

{% include requirement/MUST id="android-samples-build-code" %} build and test your code samples using the repository's continuous integration (CI) to ensure they remain functional.

{% include requirement/MUSTNOT id="android-snippets-no-combinations" %} combine multiple operations in a code sample unless it's required for demonstrating the type or member. For example, a Cosmos DB code sample doesn't include both account and container creation operations.  Create a sample for account creation, and another sample for container creation.

Combined operations require knowledge of additional operations that might be outside their current focus. The developer must first understand the code surrounding the operation they're working on, and can't copy and paste the code sample into their project.

## Java Best Practices for Android

> TODO

### Naming Patterns

Using a consistent set of naming patterns across all client libraries will ensure a consistent and more intuitive developer experience. This section outlines good practices for naming that must be followed by all client libraries.

{% include requirement/MUST id="android-naming-succinct" %} prefer succinctness over verbosity in method and class names, except when readability is impacted. A few examples include:

* A class may want to return an identifier to a user. There is no additional value in the fully-qualified `getIdentifier()` compared with the shorter and equally-descriptive `getId()`.
* A method called `getName()` is short, but may leave some doubt in the users mind about which name is being represented. Instead, naming this method `getLinkName()` will remove all doubt from the users mind, and without substantial additional verbosity. Similarly, in the case of `getId()` above, always choose to specify the identifier name if there is any likelihood of confusion about which identifier is being referenced. For example, use `getTenantId()` rather than `getId()`, unless it is completely unambiguous as to which identifier is being referenced.

{% include requirement/MUSTNOT id="android-naming-uppercase-acronyms" %} fully uppercase acronyms. APIs must take the form of `getHttpConnection()` or `getUrlName()` rather than `getHTTPConnection()` or `getURLName()`.

{% include requirement/MUST id="android-naming-service-acronyns" %} use service-specific acronyms sparingly in API. Whereas most users will accept a method including `Http` or `Url` in the name, most users will not know what `Sas` or `Cpk` mean. Where possible (without breaking the succinctness over verbosity requirement above), expansion of acronyms, or at the very least sufficient documentation at class and method levels to describe the acronym, must be considered.

{% include requirement/MUST id="android-naming-host-vs-hostname" %} use the correct naming for 'host' vs 'hostname'. 'hostname' is the host name without any port number, whereas 'host' is the hostname with the port number.

{% include requirement/MUSTNOT id="android-naming-camel-case" %} use camel case on words that are commonly accepted in their combined form. For example, 'hostname' should be spelt as `hostname` rather than `hostName`, and 'username' should be spelt as `username` rather than `userName`.

{% include requirement/MUSTNOT id="android-interface-i-prefix" %} name interface types with an 'I' prefix, e.g. `ISearchClient`. Instead, do not have any prefix for an interface, preferring `SearchClient` as the name for the interface type in this case.

{% include refs.md %}
{% include_relative refs.md %}
