---
title: "iOS Guidelines: API Design"
keywords: guidelines ios
permalink: ios_design.html
folder: ios
sidebar: ios_sidebar
---

{% include draft.html content="The iOS guidelines are in DRAFT status" %}

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.  

## Namespaces and Module Naming

Swift does not use namespaces.  Instead, there are product module names.  The following requirements pertain to naming of modules for iOS libraries.

The product module name should be named `Azure<service>[<feature>]`.  All classes should exist within this module.  Here:

- `<service>` is the service name represented as a single word
- `<feature>` is an optional subpackage to break services into separate components (for example, storage may have `Blobs`, `Files`, and `Queues`)

{% include requirement/MUST id="ios-modulename-format" %} start the module name with `Azure` to indicate an Azure client library.  Use a capitalized shortened name for the service name, and finish with an optional suffix for the feature.

For example, Azure Key Vault would be in AzureKeyVault.  Note that Key and Vault are brought together and capitalized individually, so `KeyVault` instead of `key_vault`, `keyvault`, or `key-vault`.

{% include requirement/MUST id="ios-modulename-selection" %} pick a module name that allows the consumer to tie the module to the service being used. The package does **NOT** change when the branding of the product changes.  Avoid the use of marketing names that may change.

{% include requirement/MUST id="ios-namespaces-management" %} place the management (Azure Resource Manager) API in the `AzureMgmt` prefixed module.  For example, a Swift manangement API for Azure Key Vault would use `AzureMgmtKeyVault`.  We do not expect many management APIs for Swift, so this should be uncommon.

{% include requirement/MUSTNOT id="ios-namespaces-ambiguity" %} choose similar names for clients that do different things.

{% include requirement/MUST id="ios-namespaces-registration" %} register the chosen namespace with the [Architecture Board].  Open an issue to request the namespace.  See [the registered namespace list](registered_namespaces.html) for a list of the currently registered namespaces.

## Client interface

Your API surface consists of one or more _service clients_ that the consumer will instantiate to connect to your service, plus a set of supporting types.

{% include requirement/MUST id="ios-client-naming" %} name service client types with the _Client_ suffix.

{% include requirement/MUST id="ios-client-constructor-minimal" %} allow the consumer to construct a service client with the minimal information needed to connect and authenticate to the service.

{% include requirement/MUST id="ios-client-verb-prefix" %} standardize verb prefixes within a set of client libraries for a service.  

We speak about using the client library in a cross-language manner within outbound materials such as documentation, blogs, and public speaking.

{% include requirement/MUST id="ios-client-feature-support" %} support only those features provided by the Azure service that a mobile app would access.  While gaps in functionality do cause frustration, binary size in the mobile ecosystem is of a bigger concern.  **DO** be consistent with other mobile platforms in feature support (for example, Android).

## Network requests

The client library wraps HTTP requests so it's important to support standard network capabilities.  Asynchronous programming techniques aren't widely understood.  However, such techniques are essential in developing resilient web services.  Many developers prefer synchronous method calls for their easy semantics when learning how to use a technology.  Consumers also expect certain capabilities in a network stack (such as call cancellation, automatic retry, and logging).

{% include requirement/MUST id="ios-network-async" %} support asynchronous service clients.

{% include requirement/MAY id="ios-network-sync" %} support synchronous service clients. This client should end with the _SyncClient_ suffix.

{% include requirement/MUST id="ios-network-packaging-for-sync-and-async" %} bundle the sync and async service clients in the same module.

## Authentication

Azure services use different kinds of authentication schemes to allow clients to access the service.  Conceptually, there are two entities responsible in this process: a credential and an authentication policy.  Credentials provide confidential authentication data.  Authentication policies use the data provided by a credential to authenticate requests to the service.  

{% include requirement/MUST id="ios-auth-support" %} support all authentication techniques that the service supports and that make sense in a mobile context.  Service principal authentication generally does not make sense, for example.

{% include requirement/MUST id="ios-auth-azure-core" %} use credential and authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="ios-auth-credentials" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service.  If using a service-specific credential type, the implementation must be non-blocking and atomic.

A connection string is a combination of an endpoint, credential data, and other options used to simplify service client configuration.  

{% include requirement/MUSTNOT id="ios-auth-connection-strings"%} support connection strings.  Connection strings are insecure in the context of a mobile app.


## Response formats

Requests to the service fall into two basic groups: methods that make a single logical request, and methods that make a deterministic sequence of requests.  An example of a *single logical request* is a request that may be retried inside the operation.  An example of a *deterministic sequence of requests* is a paged operation.

The *logical entity* is a protocol neutral representation of a response. The logical entity may combine data from headers, body, and the status line. For example, you may expose an `ETag` header as a property on the logical entity.  `Response` is the 'raw response'. It contains HTTP headers, status code, and the response body. The `T` object would be the 'logical entity'.

{% include requirement/MUST id="ios-response-return-logical-entity" %} return the logical entity for the normal form of a service method. The logical entity MUST represent the information needed in the 99%+ case.

{% include requirement/MUST id="ios-response-access-response" %} *make it possible* for a developer to access the complete response, including the status line, headers, and body.  This shall be included as part of the asynchronous callback signature.  For example:

{% highlight swift %}
client.listConfigurationSettings(key: "cat", label: nil) { result, response in
    let statusCode = response.statusCode
    switch result {
    case .success(let settings):
       print(settings)
    case .failure(let error):
       print("Error! \(error.localizedDescription)")
    }
}
{% endhighlight %}

For synchronous clients, this shall be accomplished by passing an optional HttpResponse object into the client method. For example:

{% highlight swift %}
var response = HttpResponse()
let settings = client.listConfigurationSettings(key: "cat", withResponse: response)
let statusCode = response.statusCode
{% endhighlight %}

{% include requirement/MUST id="ios-response-provide-examples" %} provide examples on how to access the raw and streamed response for a request, where exposed by the client library.  We don't expect all methods to expose a streamed response.

{% include requirement/MUST id="ios-response-pagination" %} provide a Swift-idiomatic way to iterate through all pages of a paged operation, automatically fetching new pages as needed. For example:

{% highlight swift %}
// Yes:
client.listConfigurationSettings(...) { settings, response, error in
    for page in settings:
        for setting in page:
            print(setting.description)
}

// No - don't force the caller of the library to do paging:
client.listConfigurationSettings(...) { result, response in
    switch result {
        case .success(let settings):
            let nextPage: String?
            let done = false
            repeat {
                let pageOfSettings = settings.nextPage();
                for setting in pageOfSettings {
                    print(setting.description)
                }
                nextPage = pageOfSettings.nextLink
                done = nextPage == nil
            } while (!done)
    }
}
{% endhighlight %}

For more information on what to return for `list` operations, refer to [Pagination].

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="ios-response-return-headers" %} return headers and other per-request metadata unless it's obvious as to which specific HTTP request the methods return value corresponds to.

{% include requirement/MUST id="ios-response-failure-cases" %} provide enough information in failure cases for an application to take appropriate corrective action.

{% include requirement/SHOULDNOT id="ios-response-reserved-words" %} use reserved words (such as `object` and `value`) as a property name within the logical entity.  Avoid reserved words in other supported languages.

## Pagination

Azure client libraries eschew low-level pagination APIs in favor of high-level abstractions that implement per-item iterators. High-level APIs are easy for developers to use for the majority of use cases but can be more confusing when finer-grained control is required (for example, over-quota/throttling) and debugging when things go wrong. Other guidelines in this document work to mitigate this limitation, for example by providing robust logging, tracing, and pipeline customization options.

### Asynchronous Paging

{% include requirement/MUST id="ios-pagination-async-support" %} return `@escaping (Result<PagedCollection<T>, Error>, HttpResponse) -> Void)` for asynchronous APIs that expose paginated or non-paginated collections. This ensures that paginated and non-paginated collections are accessed and operate the same way. Users should not need to appreciate the difference.

```swift
public class AppConfigurationClient: PipelineClient {

  // asynchronous API returning a PagedCollection of ConfigurationSetting instances
  public func listConfigurationSettings(forKey key: String?, forLabel label: String?,
                                        completion: @escaping (Result<PagedCollection<ConfigurationSetting>, Error), HttpResponse) -> Void {
    ...
    // in the run completion handler
    switch result {
        case .success(let data):
            let codingKeys = PagedCodingKeys(continuationToken: "@nextLink")
            do {
                let paged = try PagedCollection<ConfigurationSetting>(client: self, request: request,
                                                                      data: data, codingKeys: codingKeys)
                completion(.success(paged), httpResponse)
            } catch {
                completion(.failure(error), httpResponse)
            }
        case .failure(let error):
            completion(.failure(error), httpResponse)
        }
    }
}
```

Consumers of this API can consume individual items using the nextItem() method:

```swift
let paged = try PagedCollection<ConfigurationSetting>(...)
paged.nextItem { result in
    switch result {
    case. failure(let error):
        ...
    case .success(let item):
        doSomething(with: item)
    }
}
```

{% include requirement/MUST id="ios-pagination-distinct-types" %} use distinct types for entities in a list endpoint and an entity returned from a get endpoint if these are different types, and otherwise you must use the same types in these situations.

{% include important.html content="Services should refrain from having a difference between the type of a particular entity as it exists in a list versus the result of a GET request for that individual item as it makes the client library's surface area simpler." %}

{% include requirement/MUSTNOT id="ios-pagination-large-get-iterator" %} expose an iterator over each individual item if getting each item requires a corresponding GET request to the service. One GET per item is often too expensive and so not an action we want to take on behalf of users.

{% include requirement/MUSTNOT id="ios-pagination-array-support" %} expose an API to get a paginated collection into an array. This is a dangerous capability for services which may return many, many pages.

{% include requirement/MUSTNOT id="ios-pagination-paging-api" %} expose paging APIs when iterating over a collection. Paging APIs must not accept a continuation token.

The consumer may process items page-by-page instead:

```swift
client.listConfigurationSettings(...) { result, httpResponse in
    ...
    let paged = PagedCollection<ConfigurationSettings>(...)
    paged.nextPage { result in
        switch result {
        case .success(let page):
            doSomething(with: page)
        case .failure(let error):
            ...
        }
    }
    ...
});
```

### Synchronous Paging

{% include requirement/MUST id="ios-pagination-sync-support" %} return `PagedIterable<T>` for synchronous APIs that expose paginated and non-paginated collections. This ensures that paginated and non-paginated collections are accessed and operate the same way. Users should not need to appreciate the difference. The `PagedIterable<T>` protocol (located in Azure Core) provides access to paged results on a per-page basis.

For example, the cat-herding service sync client offers the following API:

```swift
public class CatHerdingClient: PipelineClient {
    // synchronous API returning only a non-paginated collection of Cats.
    public func listCats(...) -> PagedIterable<Cat> throws {
        ...
    }

    // synchronous API returning PagedInterable<T> Kitten paged instances
    public func listKittens() -> PagedIterable<Kitten> throws {
        ...
    }
}
```

{% include requirement/MUSTNOT id="ios-pagination-no-collections" %} use other collection types for sync APIs that return multiple values (for example, `Array`, or `Iterator`).

## Long running operations

Long-running operations are uncommon in a mobile context.

{% include requirement/MAY id="ios-lro-poller" %} represent long-running operations with some object that encapsulates the polling and the operation status.

## Support for non-HTTP protocols

Most Azure services expose a RESTful API over HTTPS.  However, a few services use other protocols, such as [AMQP](https://www.amqp.org/), [MQTT](http://mqtt.org/), or [WebRTC](https://webrtc.org/). In these cases, the operation of the protocol can be split into two phases:

* Per-connection (surrounding when the connection is initiated and terminated)
* Per-operation (surrounding when an operation is sent through the open connection)

The policies that are added to a HTTP request/response (authentication, unique request ID, 
telemetry, distributed tracing, and logging) are still valid on both a per-connection and 
per-operation basis.  However, the methods by which these policies are implemented are protocol 
dependent.

{% include requirement/MUST id="ios-proto-policies" %} implement as many of the policies as possible on a per-connection and per-operation basis.

For example, MQTT over WebSockets provides the ability to add headers during the initiation of the WebSockets connection, so this is a good place to add authentication, telemetry, and distributed tracing policies.  However, MQTT has no metadata (the equivalent of HTTP headers), so per-operation policies are not possible.  AMQP, by contract, does have per-operation metadata.  Unique request ID, and distributed tracing headers can be provided on a per-operation basis with AMQP.

{% include requirement/MUST id="ios-proto-archboard" %} consult the [Architecture Board] on policy decisions for non-HTTP  protocols.  Implementation of all policies is expected.  If the protocol cannot support a policy, obtain an exception from the [Architecture Board].

{% include requirement/MUST id="ios-proto-global-config" %} use the global configuration established in the Azure Core library to configure policies for non-HTTP protocols.  Consumers don't necessarily know what protocol is used by the client library.  They will expect the client library to honor global configuration that they have established for the entire Azure SDK.  

## The Swift API

Consumers will use one or more _service clients_ to access Azure services, plus a set of model classes and other supporting types.  Both synchronous APIs and asynchronous APIs are supported.

### Async API

{% include requirement/MUST id="ios-async-client-name" %} offer an async service client named `<ServiceName>Client`, as async is the most common paradigm on iOS. More than one service client may be offered for a single service.

{% include requirement/MUSTNOT id="ios-async-framework" %} use a third-party library to provide an async API. This is to avoid potential Objective-C incompatability with the chosen library.

{% include requirement/MUSTNOT id="ios-async-suffix" %} use the suffix `Async` in methods that do operations asynchronously. Let the fact the user has an instance of an 'async client' provide this context.

{% include requirement/MUSTNOT id="ios-async-multiple-methods" %} provide multiple asynchronous methods for a single REST endpoint.

{% include requirement/MUSTNOT id="ios-async-cancellation" %} provide API that accepts a cancellation token. Cancellation tokens are not supported by the native iOS Networking APIs. Client APIs shall begin their request and return an `AzureTask`. Developers who need to cancel a request calls `.cancel()` on the `AzureTask` object.

{% include requirement/MUSTNOT id="ios-async-use-azure-core" %} write custom APIs for streaming or async operations. Make use of the existing functionality offered in the Azure core library. Discuss proposed changes to the Azure core library with the [Architecture Board].

{% include requirement/MUSTNOT id="ios-async-no-blocking" %} include blocking calls inside async client library code.

### Sync API

{% include requirement/MAY id="ios-sync-client-name" %} offer a sync service client named `<ServiceName>SyncClient`. More than one service client may be offered for a single service.

## Service clients

Refer to the [AppConfigurationClient class] for a fully built-out example of how an async client should be constructed.

{% include requirement/MUST id="ios-service-client-naming" %} name service client types with the _Client_ suffix (for example, `AppConfigurationClient`). Since async is the default paradigm in iOS, client types with the _Client_ suffix are asynchronous. Synchronous clients are named with the _SyncClient_ suffix.

{% include requirement/MUST id="ios-service-client-location" %} place service clients in the root package of their corresponding client library (for example, `com.azure.storage.blob.BlobClient`, as `com.azure.storage.blob` is considered the root package in this example).

{% include requirement/MUST id="ios-service-client-constructor" %} allow the consumer to construct a service client with the minimal information needed to connect and authenticate to the service.

{% include requirement/MUST id="ios-use-multiple-inits" %} provide unambiguous initializers for all client construction scenarios. Don't use static methods to construct a client. Don't use `_` syntax to avoid requiring parameter labels.

```swift
class ExampleClient {
    public init(endpoint: String, credential: String? = nil, options: Options? = nil) {
        ...
    }
    
    public init(connectionString: String, options: Options? = nil) {
        ...
    }
}
```

### Options {#ios-options}
The guidelines in this section apply to options passed in options bags to clients, whether methods or constructors. When referring to option names, this means the key of the object users must use to specify that option when passing it into a method or constructor.

{% include requirement/MUST id="ios-options-suffix-durations" %} suffix durations with In<Unit>. Unit should be ms for milliseconds, and otherwise the name of the unit. Examples include timeoutInMs and delayInSeconds.

### Service Client Verbs

{% include requirement/MUST id="ios-service-client-approved-verbs" %} prefer the use of the following terms for CRUD operations:

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

{% include requirement/SHOULD id="ios-service-client-flexibility" %} remain flexible and use names best suited for developer experience.  Don't let the naming rules result in non-idiomatic naming patterns.  For example, Swift developers prefer `list` operations over `getAll` operations.

## Model classes

Model classes are classes that consumers use to provide required information into client library methods. These classes typically represent the domain model, or options classes that must be configured before the request can be made.

> **TODO** Integrate naming : see https://github.com/Azure/azure-sdk/pull/664

> **TODO** Produce Swift specific guidance on where models go and how to construct them.

## Versioning

{% include draft.html content="The API for specifying a specific service version is not yet defined.  This section will change as it becomes more concrete." %}

There are two versions that developers must be concerned with. Release versioning is the version of the library.  The Azure service API that the library calls also has a version. This section details how consumers can request a specific Azure service API when working with the library.

{% include requirement/MUST id="ios-versioning-latest-service-api" %} call the latest supported service API version by default.

{% include requirement/MUST id="ios-versioning-select-service-api" %} allow the consumer to select a supported service API version when instantiating the service client.  

Include the following in the `ClientOptions` class for the client:

{% highlight swift %}
enum CatHerdingServiceVersion : String {
    case Latest = "2019-05-06"
    case V2019_05_06 = "2019-05-06"
}

class CatHerdingClientOptions {
    var serviceVersion: CatHerdingServiceVersion = CatHerdingServiceVersion.Latest
    // other service client options...
}
{% endhighlight %}

The `Latest` option for the service version should always be the latest stable API version for the service.

{% include refs.md %}
{% include_relative refs.md %}
