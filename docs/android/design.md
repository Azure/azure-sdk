---
title: "Android Guidelines: API Design"
keywords: guidelines android
permalink: android_design.html
folder: android
sidebar: general_sidebar
---

{% include draft.html content="The Android guidelines are in DRAFT status" %}

You do not have to write a special client library for Android in most cases. The standard Java client library will be used when paired with the Android-specific Azure Core library. If you do need to create a specific Android edition, carefully consider the part of the service that will be accessed from the mobile app. Not all methods will be equally relevant to mobile workloads.

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service. 

## Namespaces

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

### Gradle

All client libraries for Android standardize on the Gradle build tooling for build and dependency management. This section details the standard configuration that must be used in all client libraries.

{% include requirement/MUST id="android-build-gradle" %} ship a build.gradle file for each client library, or for each module within that client library (e.g. Storage might have one each for blob, queue, and file).

{% include requirement/MUST id="android-manifest-package" %} specify the `package` to be of the form `com.azure.android.<group>.<service>[.<feature>]` in your library's AndroidManifest, for example, `com.azure.android.storage.blob`.

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.azure.android.storage.blob"/>
```

{% include requirement/MUST id="android-gradle-publish-name" %} specify the `ext.publishName` property to take the form `Microsoft Azure Android Client Library for <service name>` at the top-level of the Gradle file.

{% include requirement/MUST id="android-gradle-description" %} specify the `description` property to be a slightly longer statement along the lines of `This package contains the Android client library for Microsoft Azure <service>`.

## Service clients

Your API surface consists of one or more _service clients_ that the consumer will instantiate to connect to your service, plus a set of supporting types.

{% include requirement/MUST id="android-client-feature-support" %} support only those features provided by the Azure service that a mobile app would access. While gaps in functionality do cause frustration, binary size in the mobile ecosystem is of a bigger concern.

{% include requirement/MUST id="android-client-mobile-consistency" %} be consistent with other mobile platforms in feature support (for example, iOS).

### Service clients

#### Client naming

{% include requirement/MUST id="android-client-naming" %} name service client types with the _Client_ suffix (for example, `ConfigurationClient`). More than one service client may be offered for a single service. For example, a client for the storage service's Blob feature should be named `StorageBlobClient`.

{% include requirement/MUST id="android-async-client-name" %} offer an async service client named `<Service>[<Feature>]AsyncClient`.

{% include requirement/MUST id="android-sync-client-name" %} offer a sync service client named `<Service>[<Feature>]Client`.

{% include requirement/MUST id="android-client-location" %} place service client types that the consumer is most likely to interact with in the root package of the client library (for example, `com.azure.storage.blob`). Specialized service clients should be placed in subpackages.

{% include requirement/MUST id="android-client-verb-prefix" %} standardize verb prefixes within a set of client libraries for a service.

We speak about using the client library in a cross-language manner within outbound materials such as documentation, blogs, and public speaking.

#### Client initialization 

{% include requirement/MUST id="android-client-constructor-minimal" %} allow the consumer to construct a service client with the minimal information needed to connect and authenticate to the service.

{% include requirement/MUST id="android-client-builder" %} offer a fluent builder API for constructing service clients, said builder must be an inner class within the service client class it will instantiate.

{% include requirement/MUST id="android-client-immutability" %} ensure that all service client classes are immutable upon instantiation.

{% include requirement/MUSTNOT id="android-client-constructors" %} provide any `public` or `protected` constructors in the service client, except where necessary to support mock testing. Keep visibility to a minimum.

{% include requirement/MUSTNOT id="android-client-no-static-constructors" %} provide static methods to initialize a client.

#### Async clients

{% include requirement/MUST id="android-async-sync-client" %} provide a sync client containing all non-streaming service methods.

{% include requirement/MAY id="android-async-sync-client-streaming" %} include streaming service methods in the sync client if it makes sense in the context of the service.

{% include requirement/MUST id="android-async-client" %} provide an async client containing all service methods.

{% include requirement/MUSTNOT id="android-async-suffix" %} use the suffix `Async` in methods that do operations asynchronously. Let the fact the user has an instance of an 'async client' provide this context.

{% include requirement/MUST id="android-async-client-completablefuture" %} return [android-retrofuture's](https://github.com/retrostreams/android-retrofuture) `CompletableFuture` from all non-streaming service methods. Do not use the JDK's `java.util.concurrent.CompletableFuture`, as this type is not available on all Android devices.

{% include requirement/MUST id="android-async-client-callback" %} return `void` and accept a callback or delegate parameter to all streaming service methods.

{% include requirement/MUST id="android-async-rxjava" %} additionally provide a separate library containing an RxJava-based async client containing all service methods. The RxJava-based API must be contained within a separate library from the main library with the suffix `-rx`, e.g. `azure-someservice-rx`.

{% include requirement/MUSTNOT id="android-async-multiple-methods" %} provide multiple asynchronous methods for a single REST endpoint in the same library, unless to provide overloaded methods to enable alternative or optional method parameters.

{% include requirement/MUSTNOT id="android-async-no-blocking" %} include blocking calls inside async client library code.

#### Client options

Client constructors and client methods must accept options to customize the client or to customize how the method will be executed. 

{% include requirement/MUST id="android-options-object" %} provide an immutable class named with the suffix `Options` to allow for customization of each client or method call.

{% include requirement/MUST id="android-options-classes-extend" %} make `Options` objects extend from Azure Core's `ClientOptions` for clients and `RequestOptions` for method calls.

{% include requirement/MUST id="android-options-parameter-required" %} accept all arguments required to construct a client or execute a method call as individual parameters to the client constructor or method. An argument is considered required if the library author deems it to be essential to the developer experience of the client API, regardless of whether the argument is flagged as required in the service's API spec.

{% include requirement/MUST id="android-options-parameter-optional" %} include an overload of each constructor or method that accepts an `Options` object as the final parameter named `options`. The `Options` object must contain all optional arguments to the constructor or method call, do not expose individual optional arguments as separate parameters to the constructor or method.

{% include requirement/MUST id="android-options-types" %} use rich types where possible for options. For example, use the `Date` type for dates. When not possible, name the option with a suffix to express the expected type. If the expected type is a unit, the suffix should follow the format `In<Unit>`. Unit should be `ms` for milliseconds, and otherwise the name of the unit. Examples include `timeoutInMs` and `delayInSeconds`.

#### Client models

Models are classes that consumers use to provide required information into client library methods. These classes typically represent the domain model, or options classes that must be configured before the request can be made.

{% include requirement/MUST id="android-models-constructors" %} provide public constructors for all model classes that a user is allowed to instantiate. Model classes that are not instantiable by the user, for example if they are model types returned from the service, should not have any publicly visible constructors.

Use a no-args constructor and a fluent setter API to configure the model class. However, other designs may be used for the constructor when appropriate.

{% include requirement/MUSTNOT id="android-models-builder" %} offer a builder class for model classes.

{% include requirement/MUST id="android-models-interface" %} put model classes that are intended as service return types only, and which have undesirable public API (which is not intended for consumers of the client library) into the `.implementation.models` package. In its place, an interface should be put into the public-facing `.models` package, and it should be this type that is returned through the public API to end users. Examples of situations where this is applicable include when there are constructors or setters on a type which receive implementation types, or when a type should be immutable but needs to be mutable internally. The interface should have the model type name, and the implementation (within `.implementation.models`) should be named `<interfaceName>Impl`.

**Note:** Extra caution must be taken to ensure that the returned interface has had consideration given to any future evolution of the interface, as growing an interface presents its own set of challenges (that is, [default methods](https://docs.oracle.com/javase/tutorial/java/IandI/defaultmethods.html)).

{% include requirement/MUST id="android-models-fluent" %} provide a fluent API where appropriate.

Apply the `@Fluent` annotation to the class. Name setter methods after the property being set (for example, `proxy(Proxy p)`). All setter methods must return `this`.

{% include requirement/MUST id="android-models-fluent-setters" %} ensure that setter methods within a fluent type return the same instance of the type.

Fluent types must not be immutable. Don't return a new instance on each setter call.

{% include requirement/MUST id="android-models-javabeans" %} use the JavaBean naming convention of `get*`, `set*`, and `is*`.

{% include requirement/MUST id="android-client-model-domain-location" %} store client models representing the domain model (and enumerations / classes referenced by such models) within the `models` package inside the library's root directory.

{% include requirement/MUST id="android-client-model-options-location" %} store client models representing options classes (and enumerations / classes referenced by such models) within the `options` package inside the library's root directory.

{% include requirement/MUST id="android-client-model-conformance" %} conform to the `AzureClientOptions` protocol for classes that define options passed when initializing a service client, and the `AzureOptions` protocol for classes that define options passed to a single service client API method.

##### Other support classes

Don't offer builder or fluent APIs for supporting classes such as custom exception types, HTTP policies, and credential types.

{% include requirement/MUST id="android-support-prefix" %} use standard JavaBean prefixes for setter and getter methods.

{% include requirement/MUSTNOT id="android-support-setter-return-type" %} return `this` in setter methods - these methods should have a `void` return type.

{% include requirement/MUSTNOT id="android-support-no-builder" %} provide a builder class.

#### Client methods

{% include requirement/MUST id="android-client-verb-prefix" %} name client methods using a standardized set of verbs or verb prefixes within a set of client libraries for a service. Prefer the use of the following terms for CRUD operations:

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

{% include requirement/MUSTNOT id="android-async-suffix" %} use the suffix `Async` in methods that do operations asynchronously.

## Network requests

> TODO: Revise

The client library wraps HTTP requests so it's important to support standard network capabilities. Asynchronous programming techniques aren't widely understood. However, such techniques are essential in developing resilient web services. Many developers prefer synchronous method calls for their easy semantics when learning how to use a technology. Consumers also expect certain capabilities in a network stack (such as call cancellation, automatic retry, and logging).

{% include requirement/MUST id="android-network-sync-and-async" %} support both synchronous and asynchronous service clients.

{% include requirement/MUST id="android-network-packaging-for-sync-and-async" %} have separate service clients for sync and async APIs. The consumer needs to identify which methods are async and which are sync.

{% include requirement/MUST id="android-network-callback-final" %} accept a callback as the final parameter for async client methods.

{% include requirement/SHOULD id="android-network-callback-single" %} accept only a single callback for any given async client method. Providing a method that accepts multiple callbacks leads to unnecessarily cluttered code.

{% include requirement/MUST id="android-network-callback-name" %} use the name `callback` for all callback parameter names.

{% include requirement/MUST id="android-network-callback-type" %} make exclusive use of the `Callback` or `CallbackWithHeaders` types from Azure Core when defining an async client method `callback` parameter.

## Authentication

Azure services use different kinds of authentication schemes to allow clients to access the service. Conceptually, there are two entities responsible in this process: a credential and an authentication policy. Credentials provide confidential authentication data. Authentication policies use the data provided by a credential to authenticate requests to the service. 

{% include requirement/MUST id="android-auth-support" %} support all authentication techniques that the service supports and that make sense in a mobile context. Service principal authentication generally does not make sense, for example.

{% include requirement/MUSTNOT id="android-auth-no-token-persistence" %} persist, cache, or reuse tokens beyond the validity period of the given token. If any caching is implemented, the token credential must be given the opportunity to refresh before it expires.

{% include requirement/MUST id="android-auth-azure-core" %} use credential and authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="android-auth-fluent-builder" %} provide service client fluent builder APIs that accept all supported authentication credentials.

{% include requirement/MUST id="android-auth-credentials" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service. If using a service-specific credential type, the implementation must be non-blocking and atomic.

{% include requirement/MUST id="android-auth-credential-type-placement" %} define custom credential types in the same namespace and package as the client, or in a service group namespace and shared package, not in Azure Core or Azure Identity.

{% include requirement/MUST id="android-auth-credential-type-prefix" %} prepend custom credential type names with the service name or service group name to provide clear context to its intended scope and usage.

{% include requirement/MUST id="android-auth-credential-type-suffix" %} append Credential to the end of the custom credential type name. Note this must be singular not plural. 

{% include requirement/MUST id="android-auth-provide-credential-constructor" %} define a constructor or factory for the custom credential type which takes in ALL data needed for the custom authentication protocol.

{% include requirement/MUST id="android-auth-provide-update-method" %} define an update method which accepts all mutable credential data, and updates the credential in an atomic, thread safe manner.

{% include requirement/MUSTNOT id="android-auth-credential-set-properties" %} define public settable properties or fields which allow users to update the authentication data directly in a non-atomic manner.

{% include requirement/SHOULDNOT id="android-auth-credential-get-properties" %} define public properties or fields which allow users to access the authentication data directly. They are most often not needed by end users, and are difficult to use in a thread safe manner. In the case that exposing the authentication data is necessary, all the data needed to authenticate requests should be returned from a single API which guarantees the data returned is in a consistent state.

Client libraries may support providing credential data via a connection string __ONLY IF__ the service provides a connection string to users via the portal or other tooling. Connection strings are generally good for getting started as they are easily integrated into an application by copy/paste from the portal. However, connection strings are considered a lesser form of authentication because the credentials cannot be rotated within a running process.

{% include requirement/MAY id="android-auth-connection-strings"%} provide a service client initializer that accepts a connection string if appropriate. The connection string must be provided as the first parameter to the initializer and must be named `connectionString`. When supporting connection strings, the documentation must include a warning that building credentials such as connection strings into a consumer-facing application is inherently insecure.

{% include requirement/MUSTNOT id="android-auth-connection-strings-only" %} support initializing a service client with a connection string unless such connection string is available within tooling (for copy/paste operations).

## Response formats

Requests to the service fall into two basic groups: methods that make a single logical request, and methods that make a deterministic sequence of requests. An example of a *single logical request* is a request that may be retried inside the operation. An example of a *deterministic sequence of requests* is a paged operation.

The *logical entity* is a protocol neutral representation of a response. The logical entity may combine data from headers, body, and the status line. For example, you may expose an `ETag` header as a property on the logical entity. `Response<T>` is the 'complete response'. It contains HTTP headers, status code, and the `T` object (a deserialized object created from the response body). The `T` object would be the 'logical entity'.

{% include requirement/MUST id="android-response-return-logical-entity" %} return the logical entity for the normal form of a service method. The logical entity MUST represent the information needed in the 99%+ case.

{% include requirement/MUST id="android-response-access-response" %} *make it possible* for a developer to access the complete response, including the status line, headers, and body.

Return `Response<T>` on the maximal overload for a service method with `WithResponse` appended to the name. For example:

```java
Foo foo = client.getFoo(a);
Foo foo = client.getFoo(a, b);
Foo foo = client.getFoo(a, b, c, context); // This is the maximal overload
Response<Foo> response = client.getFooWithResponse(a, b, c, context);
```

{% include requirement/MUST id="android-response-provide-examples" %} provide examples on how to access the raw and streamed response for a request, where exposed by the client library. We don't expect all methods to expose a streamed response.

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

{% include requirement/MUST id="android-response-pagination" %} return an instance of the `PagedDataCollection<T>` class for all paged operations. For more information on what to return for `list` operations, refer to [Pagination](#pagination).

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="android-response-return-headers" %} return headers and other per-request metadata unless it's obvious as to which specific HTTP request the methods return value corresponds to.

{% include requirement/MUST id="android-response-failure-cases" %} provide enough information in failure cases for an application to take appropriate corrective action.

{% include requirement/SHOULDNOT id="android-response-reserved-words" %} use reserved words (such as `object` and `value`) as a property name within the logical entity. Avoid reserved words in other supported languages.

## Pagination

> TODO: Revise

Azure client libraries eschew low-level pagination APIs in favor of high-level abstractions that implement per-item iterators. High-level APIs are easy for developers to use for the majority of use cases but can be more confusing when finer-grained control is required (for example, over-quota/throttling) and debugging when things go wrong. Other guidelines in this document work to mitigate this limitation, for example by providing robust logging, tracing, and pipeline customization options.

{% include requirement/MUST id="android-pagination-sync-support" %} return `PagedDataCollection<T, P>` for APIs that expose paginated collections. The `PagedDataCollection<T, P>` type (located in Azure Core) provides access to paged results on a per-page basis.

{% include requirement/MUST id="android-pagination-rest-sync-support" %} return `PagedDataResponseCollection<T, P>` for synchronous APIs that expose paginated collections that need to include its HTTP response details. The `PagedDataResponseCollection<T, P>` type (located in Azure Core) provides access to paged results on a per-page basis.

{% include requirement/MUST id="android-pagination-rest-async-support" %} return `PagedDataCollection<T, P>` for asynchronous APIs that expose paginated collections that need to include its HTTP response details. The `AsyncPagedDataCollection<T, P>` type (located in Azure Core) provides access to paged results on a per-page basis.

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

## Cancellation

{% include requirement/MUST id="android-async-cancellation" %} support an optional `CancellationToken` object in conformance with the `RequestOptions` interface. This object allows the developer to call `cancel()` on the token or set a timeout, after which a best-effort attempt is made to cancel the request.

{% include requirement/MUST id="android-async-cancellation-implementation" %} cancel any in-flight requests when a developer calls `cancel()` on the `CancellationToken`. If the body of the client method includes multiple, sequential operations, you must check for cancellation before executing any operations after the first. Since the underlying Android network APIs do not permit cancellation of in-flight requests, you must also check for cancellation immediately after receiving any response. If cancellation has been requested, indicate that the call has been cancelled and do not return or otherwise further process the response.

{% include requirement/MUST id="android-async-cancellation-triggers-error" %} return an `AzureException` when cancellation is requested stating that the request was canceled, even if the request was successful.

## Long running operations

Long-running operations are uncommon in a mobile context.  If you feel like you need long running operations, contact the [Azure SDK mobile team](mailto:azuresdkmobileteam@microsoft.com) for advice.

{% include requirement/MAY id="android-lro-poller" %} represent long-running operations with some object that encapsulates the polling and the operation status.

## Support for non-HTTP protocols

Most Azure services expose a RESTful API over HTTPS. However, a few services use other protocols, such as [AMQP](https://www.amqp.org/), [MQTT](http://mqtt.org/), or [WebRTC](https://webrtc.org/). In these cases, the operation of the protocol can be split into two phases:

* Per-connection (surrounding when the connection is initiated and terminated)
* Per-operation (surrounding when an operation is sent through the open connection)

The policies that are added to a HTTP request/response (authentication, unique request ID, 
telemetry, distributed tracing, and logging) are still valid on both a per-connection and 
per-operation basis. However, the methods by which these policies are implemented are protocol 
dependent.

{% include requirement/MUST id="android-proto-policies" %} implement as many of the policies as possible on a per-connection and per-operation basis.

For example, MQTT over WebSockets provides the ability to add headers during the initiation of the WebSockets connection, so this is a good place to add authentication, telemetry, and distributed tracing policies. However, MQTT has no metadata (the equivalent of HTTP headers), so per-operation policies are not possible. AMQP, by contract, does have per-operation metadata. Unique request ID, and distributed tracing headers can be provided on a per-operation basis with AMQP.

{% include requirement/MUST id="android-proto-archboard" %} consult the [Architecture Board] on policy decisions for non-HTTP  protocols. Implementation of all policies is expected. If the protocol cannot support a policy, obtain an exception from the [Architecture Board].

{% include requirement/MUST id="android-proto-global-config" %} use the global configuration established in the Azure Core library to configure policies for non-HTTP protocols.  Consumers don't necessarily know what protocol is used by the client library.  They will expect the client library to honor global configuration that they have established for the entire Azure SDK.

## Service versioning

There are two versions that developers must be concerned with. Release versioning is the version of the library.  The Azure service API that the library calls also has a version. This section details how consumers can request a specific Azure service API when working with the library.

{% include requirement/MUST id="ios-versioning-latest-service-api" %} call the latest supported service API version by default.

{% include requirement/MUST id="ios-versioning-select-service-api" %} allow the consumer to select a supported service API version when instantiating the service client.

Include `.serviceVersion(ServiceVersion version)` as part of the client builder API. `ServiceVersion` should be an enumeration. The enumeration must have a `getLatest()` method that returns the latest service version. If a consumer doesn't specify a service version, the builder will call `ServiceVersion.getLatest()` to obtain the appropriate service version.

{% include refs.md %}
{% include_relative refs.md %}
