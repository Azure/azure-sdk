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

Service clients are the main starting points for developers calling Azure services with the Azure SDK. Each client library should have at least one client, so it’s easy to discover. The guidelines in this section describe patterns for the design of a service client.

```java
//TODO: Add sample
```

{% include requirement/MUST id="android-async-sync-client" %} provide a sync client containing all non-streaming service methods.

{% include requirement/MUST id="android-async-client" %} provide an async client containing all service methods.

{% include requirement/MUST id="android-service-client-name" %} name service client types with the _Client_ suffix (e.g. `ConfigurationClient`) for sync clients. Async clients should use the _AsyncClient_ suffix (e.g. `ConfigurationAsyncClient`).

{% include requirement/MUST id="android-async-rxjava" %} additionally provide a separate library containing an RxJava-based async client containing all service methods. The RxJava-based API must be contained within a separate library from the main library with the suffix `-rx`, e.g. `azure-someservice-rx`. Clients for this library must adhere to the async client naming conventions outlined above. 

{% include requirement/MUST id="android-service-client-immutable" %} ensure that all service client classes are immutable upon instantiation.

{% include requirement/SHOULD id="android-service-client-feature-support" %} support only those features provided by the Azure service that would make sense for a mobile app would access. Mobile apps are inherently consumer applications, and only a subset of Azure services and features are intended for use by consumer applications. While completeness is valuable and gaps in functionality can cause frustration, a smaller binary size and an opinionated stance of only providing consumer-facing functionality will make our libraries easier and more desirable for app developers to use.

{% include requirement/MUST id="android-service-client-mobile-consistency" %} provide a public API whose shape matches the public API shape provided in the equivalent iOS library as closely as possible. Clients should have the same names and provide the same functionality in their public APIs, and while method naming should be idiomatic to each platform, consistency in naming between the two platforms is the next most important consideration.

#### Service Client Creation

{% include requirement/MUSTNOT id="android-client-constructors" %} provide any `public` or `protected` constructors in the service client, except where necessary to support mock testing. Keep visibility to a minimum by using package-private constructors that may only be called by types in the same package, and then enable instantiation of the service client through the use of service client builders, detailed below.

{% include requirement/MUST id="android-client-builder" %} offer a fluent builder API for constructing service clients named `<service_name>ClientBuilder`, said builder must be an inner class within the service client class it will instantiate. Shown in the first code sample below is a generalized template, and following that is a stripped-down example builder.

```java
//TODO: Add samples
```

{% include requirement/MUSTNOT id="android-client-no-static-constructors" %} provide static methods to initialize a client.

{% include requirement/MUST id="android-client-options-parameter" %} accept all optional arguments for client creation via an [options object](#option-parameters) provided as a single parameter named `options`. Do not accept individual optional arguments as separate parameters.

{% include requirement/MUST id="android-service-client-builder-state" %} throw an `IllegalStateException` from the builder method when it receives mutually exclusive arguments.  The consumer is over-specifying builder arguments, some of which will necessarily be ignored. The error message in the exception must clearly outline the issue.

{% include requirement/MUST id="android-client-constructor-minimal" %} allow the consumer to construct a service client with the minimal information needed to connect and [authenticate](#authentication) to the service. For example:

{% include requirement/MUST id="android-service-client-builder-validity" %} ensure the builder will instantiate a service client into a valid state.  Throw an `IllegalStateException` when the user calls the `build*()` methods with a configuration that is incomplete or invalid.

```java
//TODO: Add sample
```

{% include requirement/MUST id="java-service-client-builder-validity" %} ensure the builder will instantiate a service client into a valid state.  Throw an `IllegalStateException` when the user calls the `build*()` methods with a configuration that is incomplete or invalid.

##### Using ClientOptions

{% include requirement/MUSTNOT id="android-client-options" %} accept options used for customization of the client as individual optional parameters in client builders. Accept a single, immutable `Options` object as an optional parameter for all client builders instead. This object must have a constructor that accepts all possible options for the client constructor as optional parameters. For example:

```java
//TODO: Add sample
```

{% include requirement/MUST id="android-options-classes-extend" %} make `Options` objects used when initializing a service client extend from Azure Core's `ClientOptions` class.

{% include requirement/MUST id="android-options-types" %} use rich types where possible for options. For example, use the `Date` type for dates. When not possible, name the option with a suffix to express the expected type. If the expected type is a unit, the suffix should follow the format `In<Unit>`. Unit should be `ms` for milliseconds, and otherwise the name of the unit. Examples include `timeoutInMs` and `delayInSeconds`.

{% include requirement/MUST id="android-options-parameter-required" %} accept all arguments required to construct a client or execute a method call as individual parameters to the client constructor or method. An argument is considered required if the library author deems it to be essential to the developer experience of the client API, regardless of whether the argument is flagged as required in the service's API spec.

{% include requirement/MUST id="android-client-options-location" %} store options classes (and supporting enumerations / classes referenced by such models) within the `options` package inside the library's root directory.

##### Service Versions

{% include requirement/MUST id="android-versioning-latest-service-api" %} call the highest supported service API version by default, and ensure this is clearly documented.

{% include requirement/MUST id="android-versioning-select-service-api" %} provide an enum of supported service API versions that can be supplied via the [options class](#option-parameters) when initializing the service client, as shown below:

```java
//TODO: Add sample
```

`serviceVersion` is a required parameter of Azure Core's `ClientOptions` class.

{% include requirement/MUST id="android-versioning-latest-service-property" %} return the latest stable API version for the service that is supported by the client from the enum's `latest` property.

#### Service Methods

Service methods are the methods on the client that invoke operations on the service.

{% include requirement/MUST id="android-service-client-method-naming" %} use standard JavaBean naming prefixes for all methods that are not service methods.

{% include requirement/MUSTNOT id="android-async-multiple-methods" %} provide multiple asynchronous methods for a single REST endpoint in the same library, unless to provide overloaded methods to enable alternative or optional method parameters.

##### Naming

{% include requirement/MUST id="android-client-verb-prefix" %} name service methods using a standardized set of verbs or verb prefixes within a set of client libraries for a service. Prefer the use of the following terms for CRUD operations:

|Verb              | Parameters        | Returns                 |Comments                                                                                                                |
|------------------|-------------------|-------------------------|------------------------------------------------------------------------------------------------------------------------|
| `upsert<noun>`   | key, item         | Updated or created item | Create new item or update existing item. Verb is primarily used in database-like services.                             |
| `set<noun>`      | key, item         | Updated or created item | Create new item or update existing item. Verb is primarily used for dictionary-like properties of a service.           |
| `create<noun>`   | key, item         | Created item            | Create new item. Fails if item already exists.                                                                         |
| `update<noun>`   | key, partial item | Updated item            | Fails if item doesn't exist.                                                                                           |
| `replace<noun>`  | key, item         | Replace existing item   | Completely replaces an existing item. Fails if the item doesn't exist.                                                 |
| `delete<noun>`   | key               | Deleted item, or `null` | Delete an existing item. Will succeed even if item didn't exist. Deleted item may be returned, if service supports it. |
| `add<noun>`      | index, item       | Added item              | Add item to a collection. Item will be added last, or into the index position specified.                               |
| `get<noun>`      | key               | Item                    | Will return `null` if item doesn't exist.                                                                              |
| `list<noun>`     |                   | Items                   | Return list of items. Returns empty list if no items exist.                                                            |
| `<noun>Exists`   | key               | `boolean`               | Return `true` if the item exists.                                                                                      |

{% include requirement/MUST id="android-service-client-verb-prefix" %} use the verb as as prefix for the method name when object(s) the action will apply to or return is unclear. For example, prefer `storageBlobClient.listContainers()` rather than `storageBlobClient.list()`.

{% include requirement/SHOULD id="android-service-client-flexibility" %} remain flexible and use names best suited for developer experience. Don't let the naming rules result in non-idiomatic naming patterns. For example, Java developers prefer `list` operations over `getAll` operations.

{% include requirement/MUSTNOT id="android-async-suffix" %} use the suffix `Async` in methods that do operations asynchronously. Let the fact the user has an instance of an 'async client' provide this context.

##### Cancellation

{% include requirement/MUST id="android-async-cancellation" %} support an optional `CancellationToken` object in conformance with the [`RequestOptions` class definition](#option-parameters). This object allows the developer to call `cancel()` on the token or set a timeout, after which a best-effort attempt is made to cancel the request.

{% include requirement/MUST id="android-async-cancellation-implementation" %} cancel any in-flight requests when a developer calls `cancel()` on the `CancellationToken`. If the body of the client method includes multiple, sequential operations, you must check for cancellation before executing any operations after the first. Since the underlying Android network APIs do not permit cancellation of in-flight requests, you must also check for cancellation immediately after receiving any response. If cancellation has been requested, indicate that the call has been cancelled and do not return or otherwise further process the response.

{% include requirement/MUST id="android-async-cancellation-triggers-error" %} return an `AzureException` when cancellation is requested stating that the request was canceled, even if the request was successful.

##### Return Types

Requests to the service fall into two basic groups: methods that make a single logical request, and methods that make a deterministic sequence of requests.  An example of a *single logical request* is a request that may be retried inside the operation. An example of a *deterministic sequence of requests* is a paged operation.

The *logical entity* is a protocol neutral representation of a response. The logical entity may combine data from headers, body, and the status line. For example, you may expose an `ETag` header as a property on the logical entity. `Response<T>` is the ‘complete response’. It contains HTTP headers, status code, and the T object (a deserialized object created from the response body). The T object would be the ‘logical entity’.

{% include requirement/MUST id="android-response-return-logical-entity" %} return the logical entity (i.e. the `T`) for all synchronous service methods.

{% include requirement/MUST id="android-response-return-logical-entity-async-rx" %} return the logical entity (i.e. the `T`) wrapped inside an [android-retrofuture's](https://github.com/retrostreams/android-retrofuture) `CompletableFuture` for all non-streaming asynchronous service methods that make network requests. Do not use the JDK's `java.util.concurrent.CompletableFuture`, as this type is not available on all Android devices.

{% include requirement/MUST id="android-response-return-logical-entity-async-rx" %} return the logical entity (i.e. the `T`) wrapped inside a `Single` or `Observable` for all RxJava-based asynchronous service methods that make network requests.

Return Response<T> on the maximal overload for a service method with WithResponse appended to the name. For example:

```java
Foo foo = client.getFoo(a);
Foo foo = client.getFoo(a, b);
Foo foo = client.getFoo(a, b, c, context); // This is the maximal overload, so it is replaced with the 'withResponse' 'overload' below
Response<Foo> response = client.getFooWithResponse(a, b, c, context);
```

{% include requirement/MUST id="android-response-access-response" %} *make it possible* for a developer to access the complete response, including the status line, headers, and body. The type `Response<T>` encodes this requirement and is the recommended return type for async client methods. The `T` parameter is the type of the logical entity.

{% include requirement/MUST id="android-response-provide-examples" %} provide examples on how to access the raw and streamed response for a request, where exposed by the client library. We don't expect all methods to expose a streamed response.

{% include requirement/MUST id="android-response-pagination" %} return an instance of the `PagedDataCollection`, `AsyncPagedDataCollection` or `PagedDataResponseCollection` classes for all paged operations. For more information on what to return for `list` operations, refer to [Pagination](#pagination).

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="android-response-return-headers" %} return headers and other per-request metadata unless it's obvious as to which specific HTTP request the methods return value corresponds to.

{% include requirement/MUST id="android-response-failure-cases" %} provide enough information in failure cases for an application to take appropriate corrective action.

{% include requirement/SHOULDNOT id="android-response-reserved-words" %} use reserved words (such as `class`) as a property name within the logical entity. Avoid reserved words in other supported languages.

#### Service Method Parameters

##### Option Parameters

{% include requirement/MUSTNOT id="android-request-options" %} accept options used for customization of a service client method call as individual optional parameters.

{% include requirement/MUST id="android-request-options-single" %} accept a single `Options` object as an optional parameter for all service client methods.

{% include requirement/MUST id="android-request-options-object" %} provide an immutable object named with the suffix `Options` to allow for customization of each service client method call. This object must have a constructor that accepts all possible options for the method call as optional parameters. For example:

```java
//TODO: Add sample
```

{% include requirement/MUST id="android-request-options-classes-extend" %} make `Options` objects used to define options passed to execute a method call extend from Azure Core's `RequestOptions` class.

{% include requirement/MUST id="android-options-types" %} use rich types where possible for options. For example, use the `Date` type for dates. When not possible, name the option with a suffix to express the expected type. If the expected type is a unit, the suffix should follow the format `In<Unit>`. Unit should be `ms` for milliseconds, and otherwise the name of the unit. Examples include `timeoutInMs` and `delayInSeconds`.

{% include requirement/MUST id="android-client-options-location" %} store options classes (and supporting enumerations / classes referenced by such models) within the `options` package inside the library's root directory.

##### Parameter Validation

The service client will have several methods that perform requests on the service. _Service parameters_ are directly passed across the wire to an Azure service. _Client parameters_ are not passed directly to the service, but used within the client library to fulfill the request. Examples of client parameters include values that are used to construct a URI, or a file that needs to be uploaded to storage.

{% include requirement/MUST id="general-params-client-validation" %} validate client parameters.

{% include requirement/MUSTNOT id="general-params-server-validation" %} validate service parameters. This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUST id="general-params-check-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service. If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

#### Methods Returning Collections (Paging)

The Azure SDK for Android contains the `PagedDataCollection`, `PagedDataResponseCollection` and `AsyncPagedDataCollection` types, which provide idiomatic ways to iterate through all results of a paged operation:

{% include requirement/MUST id="android-pagination-sync-support" %} return `PagedDataCollection<T, P>` for APIs that expose paginated collections. The `PagedDataCollection<T, P>` type (located in Azure Core) provides access to paged results on a per-page basis.

{% include requirement/MUST id="android-pagination-rest-sync-support" %} return `PagedDataResponseCollection<T, P>` for synchronous APIs that expose paginated collections that need to include its HTTP response details. The `PagedDataResponseCollection<T, P>` type (located in Azure Core) provides access to paged results on a per-page basis.

{% include requirement/MUST id="android-pagination-rest-async-support" %} return `AsyncPagedDataCollection<T, P>` for asynchronous APIs that expose paginated collections that need to include its HTTP response details. The `AsyncPagedDataCollection<T, P>` type (located in Azure Core) provides access to paged results on a per-page basis.

For example, the chat service sync client offers the following API:

```java
public final class ChatClient {
    // Synchronous API returning a list of chat messages from a thread, including the response details.
    public PagedDataResponseCollection<ChatMessage, Page<ChatMessage>> listChatMessagesWithPageResponse(String chatThreadId, Integer maxPageSize, OffsetDateTime startTime) {
        ...
    }
}

// Page-by-page synchronous iteration with Response
final PagedDataResponseCollection<ChatMessage, Page<ChatMessage>> pagesWithResponse = chatServiceClient.listChatMessagesWithPageResponse("threadId",5, OffsetDateTime.now());
final Response<Page<ChatMessage>> firstPageWithResponse = pagesWithResponse.getFirstPage();
final Response<Page<ChatMessage>> nextPageWithResponse = pagesWithResponse.getPage(firstPageWithResponse.getValue().getNextPageId());
// Get more pages.
...
// Item-by-item synchronous iteration.
final Page<ChatMessage> nextPage = nextPageWithResponse.getValue();

for (ChatMessage chatMessage : nextPage.getItems()) {
    ...
}
```

{% include requirement/MUSTNOT id="android-pagination-no-collections" %} use other collection types for sync APIs that return multiple values (for example, `List`, or `Iterator`).

{% include requirement/MUST id="android-pagination-paged-flux" %} use the Azure Core `Callback<AsyncPagedDataCollection<T, P>>>` type for handling HTTP responses from asynchronous APIs that expose paginated collections.

For example, the chat service async client offers the following API:

```java
public final class ChatAsyncClient {
    // Asynchronous API returning a list of chat messages from a thread, including the response details.
    public void listChatMessagesPages(String chatThreadId, Integer maxPageSize, OffsetDateTime startTime, final Callback<AsyncPagedDataCollection<ChatMessage, Page<ChatMessage>>> collectionCallback) {
        ...
    }
}

// Page-by-page asynchronous iteration
chatAsyncClient.listChatMessagesPages("threadId", 5, OffsetDateTime.now(), new Callback<AsyncPagedDataCollection<ChatMessage, Page<ChatMessage>>>() {
    @Override
    public void onSuccess(AsyncPagedDataCollection<ChatMessage, Page<ChatMessage>> asyncPagedDataCollection, Response response) {
        asyncPagedDataCollection.getFirstPage(new Callback<Page<ChatMessage>>() {
            @Override
            public void onSuccess(Page<ChatMessage> result, Response response) {
                // Item-by-item synchronous iteration.
                for (ChatMessage chatMessage : result.getItems()) {
                    ...
                }

                // Get the next page
                asyncPagedDataCollection.getPage(result.getNextPageId(), new Callback<Page<ChatMessage>>() {
                    @Override
                    public void onSuccess(Page<ChatMessage> result, Response response) {
                        // Get more pages.
                    }
                }
            }
        }
    }
}
```

{% include requirement/MUST id="android-pagination-distinct-types" %} use the same type for entities returned from a list operation vs. a get operation if those operations return different views of the same result. For example a list operation may provide only a minimal representation of each result, with the expectation that a get operation must be performed for each result to access the full representation. If the representations are compatible, reuse the same type for both the list and the get operation. Otherwise, it is permissible to use distinct types for each operation.

{% include important.html content="Services should refrain from having a difference between the type of a particular entity as it exists in a list versus the result of a GET request for that individual item as it makes the client library's surface area simpler." %}

{% include requirement/MUSTNOT id="android-pagination-large-get-iterator" %} expose an iterator over each individual item if getting each item requires a corresponding GET request to the service. One GET per item is often too expensive and so not an action we want to take on behalf of users.

{% include requirement/MUSTNOT id="android-pagination-array-support" %} expose an API to get a paginated collection into an array. This is a dangerous capability for services which may return many, many pages.

{% include requirement/MUST id="android-pagination-paging-api" %} expose paging APIs when iterating over a collection. Paging APIs must accept a continuation token (from a prior run) and a maximum number of items to return, and must return a continuation token as part of the response so that the iterator may continue, potentially on a different machine.

This is automatically handled by `PagedDataCollection<T, P>`, `PagedDataResponseCollection<T, P>` and `AsyncPagedDataCollection<T, P>`. Consumers of this API can consume individual items via the `getItems()` API in the underlying `Page<T>` of these collections.

The `getPage()` API in the aforementioned collections accepts a continuation token (`pageId`) string, which will retrieve the page specified by this token.

#### Methods Invoking Long Running Operations

Long-running operations are uncommon in a mobile context. If you feel like you need long running operations, contact the [Azure SDK mobile team](mailto:azuresdkmobileteam@microsoft.com) for advice.

> TODO: Expand upon why LROs are uncommon in a mobile context.

#### Conditional Request Methods

> TODO

#### Model Types

Models are structures that consumers use to provide required information into client library methods. These structures typically represent the domain model or *logical entity*, a class neutral representation of a response.

{% include requirement/MUST id="android-client-model-object" %} express client models as immutable objects. Such an object must express all properties of the model as final values, and have a constructor that accepts all required properties of the model as parameters. For example:

```java
//TODO: Add sample
```

{% include requirement/MUST id="android-client-model-domain-location" %} store client models (and supporting enumerations / structures referenced by such models) within the `models` package inside the library's root directory.

#### Enumerations

> TODO

#### Using Azure Core Types

> TODO

#### Using Primitive Types

> TODO

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

{% include requirement/MUST id="android-errors-http-request-failed" %} throw an exception when any HTTP request fails with an HTTP status code that is not defined by the service/Swagger as a successful status code. These exceptions should also be logged as errors.

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

{% include requirement/MUST id="android-errors-exception-tree" %} use the existing exception types present in the Azure Core library for service request failures. The following list outlines all available exception types (with indentation indicating exception type hierarchy):

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

## Authentication

Azure services use different kinds of authentication schemes to allow clients to access the service. Conceptually, there are two entities responsible in this process: a credential and an authentication policy. Credentials provide confidential authentication data. Authentication policies use the data provided by a credential to authenticate requests to the service. 

{% include requirement/MUST id="android-auth-fluent-builder" %} provide service client fluent builder APIs that accepts an instance of the appropriate Azure Core credential abstraction.

> TODO : Determine the appropriate credential abstractions for a mobile context.

{% include requirement/MUST id="android-auth-support" %} support all authentication techniques that the service supports and that make sense in a mobile context. Service principal authentication generally does not make sense, for example.

> TODO: Determine what are the supported authentication scenarios, which credential types will represent them and where will said types reside (Azure Core, Azure Identity, etc.)

{% include requirement/MUSTNOT id="android-auth-no-token-persistence" %} persist, cache, or reuse security credentials. Security credentials should be considered short lived to cover both security concerns and credential refresh situations.

{% include requirement/MUST id="android-auth-azure-core" %} use authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="android-auth-provide-credential-types" %} define a public custom credential type which enables clients to authenticate requests using the custom scheme.

{% include requirement/SHOULDNOT id="android-auth-credential-type-base" %} define custom credential types extending or implementing abstractions from Azure Core.

{% include requirement/MUST id="android-auth-credentials" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service. If using a service-specific credential type, the implementation must be non-blocking and atomic.

{% include requirement/MUST id="android-auth-credential-type-placement" %} define custom credential types in the same namespace and package as the client, or in a service group namespace and shared package, not in Azure Core or Azure Identity.

{% include requirement/MUST id="android-auth-credential-type-prefix" %} prepend custom credential type names with the service name or service group name to provide clear context to its intended scope and usage.

{% include requirement/MUST id="android-auth-credential-type-suffix" %} append `Credential` to the end of the custom credential type name. Note this must be singular, not plural. 

{% include requirement/MUST id="android-auth-provide-credential-constructor" %} define a constructor or factory for the custom credential type which takes in ALL data needed for the custom authentication protocol.

{% include requirement/MUST id="android-auth-provide-update-method" %} define an update method which accepts all mutable credential data, and updates the credential in an atomic, thread safe manner.

{% include requirement/MUSTNOT id="android-auth-credential-set-properties" %} define public settable properties or fields which allow users to update the authentication data directly in a non-atomic manner.

{% include requirement/SHOULDNOT id="android-auth-credential-get-properties" %} define public properties or fields which allow users to access the authentication data directly. They are most often not needed by end users, and are difficult to use in a thread safe manner. In the case that exposing the authentication data is necessary, all the data needed to authenticate requests should be returned from a single API which guarantees the data returned is in a consistent state.

{% include requirement/MUST id="android-auth-provide-client-constructor" %} provide service client constructors or factories that accept all supported credential types.

Client libraries may support providing credential data via a connection string __ONLY IF__ the service provides a connection string to users via the portal or other tooling. Connection strings are generally good for getting started as they are easily integrated into an application by copy/paste from the portal. However, connection strings are considered a lesser form of authentication because the credentials cannot be rotated within a running process.

{% include requirement/MAY id="android-auth-connection-strings" %} provide a service client initializer that accepts a connection string if appropriate. The connection string must be provided as the first parameter to the initializer and must be named `connectionString`. When supporting connection strings, the documentation must include a warning that building credentials such as connection strings into a consumer-facing application is inherently insecure.

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

> TODO: Say something about mocking of the requests and how to design for it.

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

{% include requirement/MUST id="android-dependencies-azure-core" %} depend on the Android Azure Core library for functionality that is common across all client libraries. This library includes APIs for HTTP connectivity, global configuration, logging, and credential handling.

{% include requirement/MUSTNOT id="android-dependencies-approved" %} be dependent on any other packages within the client library distribution package, with the exception of the following:

{% include_relative approved_dependencies.md %}

> TODO: How can we use a common approved dependencies list.

> TODO: We should also have a guideline around use of AndroidX libraries. Or if they're treated the same as other external dependencies we should add them to the approved dependencies list.

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

> TODO

## Repository Guidelines

### Documentation

#### General guidelines

> TODO

#### Samples

> TODO

## Java Best Practices

> TODO

### Naming Patterns

> TODO

{% include refs.md %}
{% include_relative refs.md %}
