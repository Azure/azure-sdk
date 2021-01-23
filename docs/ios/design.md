---
title: "iOS Guidelines: API Design"
keywords: guidelines ios
permalink: ios_design.html
folder: ios
sidebar: general_sidebar
---

{% include draft.html content="The iOS guidelines are in DRAFT status" %}

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.

## Namespaces and Module Naming

Swift does not use namespaces.  Instead, there are product module names.  The following requirements pertain to naming of modules for iOS libraries.

The product module name should be named `Azure<Service>[<Feature>]`.  All classes should exist within this module.  Here:

- `<Service>` is the service name represented as a single word
- `<Feature>` is an optional subpackage to break services into separate components (for example, storage may have `Blob`, `File`, and `Queue` subpackages)

{% include requirement/MUST id="ios-modulename-format" %} start the module name with `Azure` to indicate an Azure client library.  Use a capitalized shortened name for the service name, and finish with an optional suffix for the feature.

For example, Azure Key Vault would be in AzureKeyVault.  Note that Key and Vault are brought together and capitalized individually, so `KeyVault` instead of `key_vault`, `keyvault`, or `key-vault`.

{% include requirement/MUST id="ios-modulename-selection" %} pick a module name that allows the consumer to tie the module to the service being used. The package does **NOT** change when the branding of the product changes.  Avoid the use of marketing names that may change.

{% include requirement/MUST id="ios-modulename-path" %} locate the module's project files and all code pertaining to the module in a directory following the format `sdk/<service>/<ModuleName>/`. For example, code for the storage service's Blob library should be stored in `sdk/storage/AzureStorageBlob/`.

{% include requirement/MUST id="ios-modulename-bundle" %} construct the module's bundle identifier following the format `com.azure.<service>.<ModuleName>`. For example, the storage service's Blob library should use the bundle identifier `com.azure.storage.AzureStorageBlob`.

{% include requirement/MUST id="ios-namespaces-management" %} place the management (Azure Resource Manager) API in the `AzureMgmt` prefixed module.  For example, a Swift management API for Azure Key Vault would use `AzureMgmtKeyVault`.  We do not expect many management APIs for Swift, so this should be uncommon.

{% include requirement/MUSTNOT id="ios-namespaces-ambiguity" %} choose similar names for clients that do different things.

{% include requirement/MUST id="ios-namespaces-registration" %} register the chosen namespace with the [Architecture Board].  Open an issue to request the namespace.  See [the registered namespace list](registered_namespaces.html) for a list of the currently registered namespaces.

## Service clients

Your API surface consists of one or more _service clients_ that the consumer will instantiate to connect to your service, plus a set of supporting types.

{% include requirement/MUST id="ios-client-feature-support" %} support only those features provided by the Azure service that a mobile app would access.  While gaps in functionality do cause frustration, binary size in the mobile ecosystem is of a bigger concern.

{% include requirement/MUST id="ios-client-mobile-consistency" %} be consistent with other mobile platforms in feature support (for example, Android).

### Client interface

{% include requirement/MUST id="ios-async-client-name" %} offer an async service client named `<Service>[<Feature>]Client`, as async is the most common paradigm on iOS. More than one service client may be offered for a single service. For example, a client for the storage service's Blob feature should be named `StorageBlobClient`.

{% include requirement/MUSTNOT id="ios-async-framework" %} use a third-party library to provide an async API.

{% include requirement/MUSTNOT id="ios-async-use-azure-core" %} write custom APIs for streaming or async operations. Make use of the existing functionality offered in the Azure core library. Discuss proposed changes to the Azure core library with the [Architecture Board].

{% include requirement/MUST id="ios-client-initializer-minimal" %} allow the consumer to initialize a service client with the minimal information needed to connect and authenticate to the service.

{% include requirement/MUST id="ios-use-multiple-inits" %} provide unambiguous initializers and parameter labels for all client initialization scenarios. Do not use the `_` syntax to avoid requiring parameter labels. For example:

{% highlight swift %}
class ExampleClient {
    public init(endpoint: String, credential: String? = nil, options: Options? = nil) {
        ...
    }

    public init(connectionString: String, options: Options? = nil) {
        ...
    }
}
{% endhighlight %}

{% include requirement/MUSTNOT id="ios-client-no-static-initializers" %} provide static methods to initialize a client.

### Client options
Client initializers, and some client methods, accept options to customize the client or to customize how the method will be executed. 

{% include requirement/MUST id="ios-options-object" %} provide an immutable struct named with the suffix `Options` to allow for customization of the client / method call. This struct should have an initializer that accepts all possible options for the client / method call as optional parameters with defaults for each parameter.

{% include requirement/MUST id="ios-options-parameter" %} accept an `Options` struct as a single parameter named `options` in the client initializer or method signature, rather than accepting individual options as separate parameters.

{% include requirement/MUST id="ios-options-types" %} use rich types where possible for options. For example, use the `Date` type for dates and the `URL` type for URIs. When not possible, name the option with a suffix to express the expected type. If the expected type is a unit, the suffix should follow the format `In<Unit>`. Unit should be `ms` for milliseconds, and otherwise the name of the unit. Examples include `timeoutInMs` and `delayInSeconds`.

### Client models

Models are structures that consumers use to provide required information into client library methods. These structures typically represent the domain model, or options structures that must be configured before the request can be made.

{% include requirement/MUST id="ios-client-model-immutable-struct" %} express client models as immutable structs rather than classes. All properties of models must be expressed as `let` values.

{% include requirement/MUST id="ios-client-model-struct-init" %} provide an initializer with default values for every property the model contains.

{% include requirement/MUST id="ios-client-model-domain-location" %} store client models representing the domain model (and enumerations / structures referenced by such models) within the `Source/Models` directory inside the library's root directory.

{% include requirement/MUST id="ios-client-model-options-location" %} store client models representing options structures (and enumerations / structures referenced by such models) within the `Source/Options` directory inside the library's root directory.

{% include requirement/MUST id="ios-client-model-conformance" %} conform to the `AzureClientOptions` protocol for structures that define options passed when initializing a service client, and the `AzureOptions` protocol for structures that define options passed to a single service client API method.

### Client methods

{% include requirement/MUST id="ios-client-verb-prefix" %} name client methods using a standardized set of verbs or verb prefixes within a set of client libraries for a service. Prefer the use of the following terms for CRUD operations:

|Verb       |Parameters        |Returns                 |Comments                                                                                                               |
|-----------|------------------|------------------------|-----------------------------------------------------------------------------------------------------------------------|
| `upsert`  |key, item         |Updated or created item |Create new item or update existing item. Verb is primarily used in database-like services.                             |
| `set`     |key, item         |Updated or created item |Create new item or update existing item. Verb is primarily used for dictionary-like properties of a service.           |
| `create`  |key, item         |Created item            |Create new item. Fails if item already exists.                                                                         |
| `update`  |key, partial item |Updated item            |Fails if item doesn't exist.                                                                                           |
| `replace` |key, item         |Replace existing item   |Completely replaces an existing item. Fails if the item doesn't exist.                                                 |
| `delete`  |key               |Deleted item or `nil`   |Delete an existing item. Will succeed even if item didn't exist. Deleted item may be returned, if service supports it. |
| `add`     |index, item       |Added item              |Add item to a collection. Item will be added last, or into the index position specified.                               |
| `get`     |key               |Item or `nil`           |Will return `nil` if item doesn't exist.                                                                               |
| `list`    |                  |Items                   |Return list of items. Returns empty list if no items exist.                                                            |

{% include requirement/MUST id="ios-service-client-verb" %} use the verb by itself as the method name when the name of the first parameter and the return type (or callback parameter type) makes it obvious what object the action will apply to and/or what object(s) will be returned. For example, prefer `keyVaultClient.get(key: 'foo')` rather than `keyVaultClient.getKey(name: 'foo')` or `keyVaultClient.getKey('foo')`.

{% include requirement/MUST id="ios-service-client-verb-prefix" %} use the verb as as prefix for the method name when object(s) the action will apply to or return is unclear. For example, prefer `storageBlobClient.listContainers()` rather than `storageBlobClient.list()`.

{% include requirement/MUST id="ios-service-client-method-parameter-name" %} provide unambiguous parameter labels for all client methods. Avoid using the `_` syntax to avoid requiring parameter labels for client methods.

{% include requirement/MAY id="ios-service-client-method-parameter-unnamed" %} use the `_` syntax to avoid requiring a parameter label for the first parameter of delegate methods and other scenarios where doing so is idiomatic to Swift naming conventions.

{% include requirement/SHOULD id="ios-service-client-flexibility" %} remain flexible and use names best suited for developer experience.  Don't let the naming rules result in non-idiomatic naming patterns.  For example, naming methods `download(blob:)` and `upload(blob:)` provides more semantic meaning and would be more idiomatic than naming them `get(blob:)` and `put(blob:)`.

{% include requirement/MUSTNOT id="ios-async-suffix" %} use the suffix `Async` in methods that do operations asynchronously.

## Network requests

The client library wraps HTTP requests so it's important to support standard network capabilities.  Asynchronous programming techniques aren't widely understood.  However, such techniques are essential in developing resilient web services.  Many developers prefer synchronous method calls for their easy semantics when learning how to use a technology.  Consumers also expect certain capabilities in a network stack (such as call cancellation, automatic retry, and logging).

{% include requirement/MUST id="ios-network-callback-final" %} accept a callback as the final parameter for async client methods, allowing developers to take advantage of Swift's trailing closure syntax.

{% include requirement/SHOULD id="ios-network-callback-single" %} accept only a single callback for any given async client method. Providing a method that accepts multiple callbacks leads to unnecessarily cluttered code, and only the final callback parameter can make use of the trailing closure syntax.

{% include requirement/MUST id="ios-network-callback-suffix" %} use the suffix `handler` for all callback parameter names, e.g. `completionHandler`, `progressHandler`.

{% include requirement/SHOULD id="ios-network-callback-type" %} use `HTTPResultHandler` as the type of the callback to expose both the result (or error) and the response data.

{% include requirement/MAY id="ios-network-delegate" %} provide a delegate protocol that the developer can conform to instead of a callback parameter for async client methods where use of the delegate would improve clarity and/or reduce clutter. For such methods, you may either accept the delegate as the final parameter or return an object to which the delegate can be attached.

{% include requirement/MUST id="ios-network-delegate-name" %} follow the Swift naming conventions when providing a delegate protocol. Protocols that describe what something is should read as nouns (e.g. `Collection`), protocols that describe a capability should be named using the suffixes `able`, `ible`, or `ing` (e.g. `Equatable`, `ProgressReporting`).

{% include requirement/MUST id="ios-network-delegate-method-names" %} use a consistent prefix for each method defined by the delegate so that the developer can easily locate the delegate methods via code completion. The name of the delegating object is commonly used as as the prefix. For example, a `TransferDelegate` protocol used to notify about events coming from `Transfer` objects might define delegate methods that start with `transfer`, e.g. `transfer(_:didUpdateWithState:)`, `transferDidComplete(_:)`.

{% include requirement/SHOULD id="ios-network-delegate-method-param" %} accept the delegating object as the first unnamed parameter to delegate methods when using the delegating object's name as the prefix for the delegate method.

{% include requirement/MUST id="ios-network-delegate-method-impls" %} provide empty (do-nothing) default implementations for all delegate methods.

{% include requirement/MUSTNOT id="ios-network-multiple-methods" %} provide multiple methods for a single REST endpoint.

{% include requirement/MUSTNOT id="ios-async-no-blocking" %} include blocking calls inside async client library code.

## Authentication

Azure services use different kinds of authentication schemes to allow clients to access the service.  Conceptually, there are two entities responsible in this process: a credential and an authentication policy.  Credentials provide confidential authentication data.  Authentication policies use the data provided by a credential to authenticate requests to the service.

{% include requirement/MUST id="ios-auth-support" %} support all authentication techniques that the service supports and that make sense in a mobile context.  Service principal authentication generally does not make sense, for example.

{% include requirement/MUST id="ios-auth-azure-core" %} use credential and authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="ios-auth-credentials" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service.  If using a service-specific credential type, the implementation must be non-blocking and atomic.

{% include requirement/MUST id="ios-auth-provide-client-initializer" %} provide service client initializers that accept all supported credential types. The credential must be provided as the first parameter to the initializer and must be named `credential`.

{% include requirement/MUST id="ios-auth-validate-credentials"%} validate all credential objects passed to service client initializers by calling the object's `validate()` method.

Client libraries may support providing credential data via a connection string __ONLY IF__ the service provides a connection string to users via the portal or other tooling. Connection strings are generally good for getting started as they are easily integrated into an application by copy/paste from the portal. However, connection strings are considered a lesser form of authentication because the credentials cannot be rotated within a running process.

{% include requirement/MAY id="ios-auth-connection-strings"%} provide a service client initializer that accepts a connection string if appropriate. The connection string must be provided as the first parameter to the initializer and must be named `connectionString`. When supporting connection strings, the documentation must include a warning that building credentials such as connection strings into a consumer-facing application is inherently insecure.

{% include requirement/MUSTNOT id="ios-auth-connection-strings-only" %} support initializing a service client with a connection string unless such connection string is available within tooling (for copy/paste operations).

## Response formats

Requests to the service fall into two basic groups: methods that make a single logical request, and methods that make a deterministic sequence of requests.  An example of a *single logical request* is a request that may be retried inside the operation.  An example of a *deterministic sequence of requests* is a paged operation.

The *logical entity* is a protocol neutral representation of a response. The logical entity may combine data from headers, body, and the status line. For example, you may expose an `ETag` header as a property on the logical entity.  `Response` is the 'raw response'. It contains HTTP headers, status code, and the response body. The `T` object would be the 'logical entity'.

{% include requirement/MUST id="ios-response-return-logical-entity" %} return the logical entity for the normal form of a service method. The logical entity MUST represent the information needed in the 99%+ case.

{% include requirement/MUST id="ios-response-access-response" %} *make it possible* for a developer to access the complete response, including the status line, headers, and body. The callback type `HTTPResultHandler` encodes this requirement and is the recommended type for callbacks passed to async client methods.

{% include requirement/MUST id="ios-response-provide-examples" %} provide examples on how to access the raw and streamed response for a request, where exposed by the client library.  We don't expect all methods to expose a streamed response.

{% include requirement/MUST id="ios-response-pagination" %} return an instance of the `PagedCollection` class for all paged operations. For more information on what to return for `list` operations, refer to [Pagination](#pagination).

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="ios-response-return-headers" %} return headers and other per-request metadata unless it's obvious as to which specific HTTP request the methods return value corresponds to.

{% include requirement/MUST id="ios-response-failure-cases" %} provide enough information in failure cases for an application to take appropriate corrective action.

{% include requirement/SHOULDNOT id="ios-response-reserved-words" %} use reserved words (such as `object` and `value`) as a property name within the logical entity.  Avoid reserved words in other supported languages.

## Pagination

Azure client libraries eschew low-level pagination APIs in favor of high-level abstractions that implement per-item iterators. High-level APIs are easy for developers to use for the majority of use cases but can be more confusing when finer-grained control is required (for example, over-quota/throttling) and debugging when things go wrong. Other guidelines in this document work to mitigate this limitation, for example by providing robust logging, tracing, and pipeline customization options.

The Azure SDK for iOS contains the `PagedCollection` type, which provides Swift-idiomatic ways to iterate through all results of a paged operation. The developer can asynchronously iterate through the `PagedCollection` in a page-by-page or item-by-item fashion by calling the `forEachPage` and `forEachItem` methods:

{% highlight swift %}
// Automatic asynchronous iteration of a `PagedCollection` page-by-page
client.listConfigurationSettings(...) { result, _ in
    if case let .success(pagedCollection) = result {
        pagedCollection.forEachPage { settings in
            for setting in settings {
                print(setting.description)
            }
            // `return false` to interrupt iteration
            return true
        }
    }
}

// Automatic asynchronous iteration of a `PagedCollection` item-by-item
client.listConfigurationSettings(...) { result, _ in
    if case let .success(pagedCollection) = result {
        pagedCollection.forEachItem { setting in
            print(setting.description)
            // `return false` to interrupt iteration
            return true
        }
    }
}
{% endhighlight %}

The developer can also choose to directly access the `PagedCollection`'s `items` and `pageItems` properties, manually advancing the collection by calling the asynchronous `nextPage` method as needed:

{% highlight swift %}
// Explicit asynchronous iteration of a `PagedCollection` page-by-page
override func viewDidAppear(_ animated: Bool) {
    ...
    // Execute the asynchronous method and use the resulting paged collection as the data source
    client.listConfigurationSettings(...) { result, _ in
        if case let .success(pagedCollection) = result {
            self.dataSource = pagedCollection
            ...
        }
    }
    ...
}

internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    ...
    // Get the corresponding item from the pagedCollection
    let item = self.dataSource.items[indexPath.row]
    ...
    // Load the next page if the user is at the end of the current page
    if indexPath.row == self.dataSource.count - 1 {
        // nextPage automatically stops when exhausted, no need to handle that case separately
        self.dataSource.nextPage { result
            if case .success = result {
                ...
            }
        }
    }
    ...
}
{% endhighlight %}

Finally, `PagedCollection` also provides an iterator property that conforms to the `Sequence` protocol, providing a way for the developer to synchronously consume all results of a paged operation using a standard `for ... in` loop:

{% highlight swift %}
// Automatic synchronous iteration of a `PagedCollection` item-by-item
client.listConfigurationSettings(...) { result, _ in
    if case let .success(pagedCollection) = result {
        // Synchronous iteration will block the UI thread as more pages are fetched
        DispatchQueue.global(qos: .background).async {
            for setting in pagedCollection.syncIterator {
                print(setting.description)
                // `break` to interrupt iteration
            }
        }
    }
}
{% endhighlight %}

{% include requirement/MUST id="ios-pagination-async-support" %} return a `PagedCollection` for APIs that expose a collection of results, regardless of whether the collection is paginated or non-paginated. This ensures that paginated and non-paginated collections are accessed and operate the same way. Users should not need to appreciate the difference.

{% include requirement/MUST id="ios-pagination-distinct-types" %} use the same type for entities returned from a list operation vs. a get operation if those operations return different views of the same result. For example a list operation may provide only a minimal representation of each result, with the expectation that a get operation must be performed for each result to access the full representation. If the representations are compatible, reuse the same type for both the list and the get operation. Otherwise, it is permissable to use distinct types for each operation.

{% include important.html content="Services should refrain from having a difference between the type of a particular entity as it exists in a list versus the result of a GET request for that individual item as it makes the client library's surface area simpler." %}

{% include requirement/MUSTNOT id="ios-pagination-large-get-iterator" %} expose an iterator over each individual item if getting each item requires a corresponding GET request to the service. One GET per item is often too expensive and so not an action we want to take on behalf of users.

{% include requirement/MUSTNOT id="ios-pagination-array-support" %} expose an API to get a paginated collection into an array. This is a dangerous capability for services which may return many, many pages.

{% include requirement/MUSTNOT id="ios-pagination-paging-api" %} expose pagination internals when iterating over a collection. Consumers should work with only the `PagedCollection`, not the underlying Paging APIs.

## Cancellation

{% include requirement/MUST id="ios-async-cancellation" %} support an optional `CancellationToken` object in conformance with the `AzureOptions` protocol. This object allows the developer to call `.cancel()` on the token or set a timeout, after which a best-effort attempt is made to cancel the request.

{% include requirement/MUST id="ios-async-cancellation-implementation" %} cancel any in-flight requests when a developer calls `cancel()` on the `CancellationToken`. If the body of the client method includes multiple, sequential operations, you must check for cancellation before executing any operations after the first. Since the underlying iOS network APIs do not permit cancellation of in-flight requests, you must also check for cancellation immediately after receiving any response. If cancellation has been requested, indicate that the call has been cancelled and do not return or otherwise further process the response.

{% include requirement/MUST id="ios-async-cancellation-triggers-error" %} return an `AzureError.sdk` error when cancellation is requested stating that the request was canceled, even if the request was successful.

## Long running operations

Long-running operations are uncommon in a mobile context.  If you feel like you need long running operations, contact the [Azure SDK mobile team](mailto:azuresdkmobileteam@microsoft.com) for advice.

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

## Service versioning

There are two versions that developers must be concerned with. Release versioning is the version of the library.  The Azure service API that the library calls also has a version. This section details how consumers can request a specific Azure service API when working with the library.

{% include requirement/MUST id="ios-versioning-latest-service-api" %} call the latest supported service API version by default.

{% include requirement/MUST id="ios-versioning-select-service-api" %} allow the consumer to select a supported service API version when instantiating the service client.

Include the following in the `ClientOptions` class for the client:

{% highlight swift %}
class CatHerdingClient {
    enum ApiVersion: String {
        /// API version "2018-01-02"
        case v20180102 = "2018-01-02"
        /// API version "2019-05-06"
        case v20190506 = "2019-05-06"

        /// The most recent API version of the Cat Herding service
        public static var latest: ApiVersion {
            return .v20190506
        }
    }
}

class CatHerdingClientOptions: AzureClientOptions {
    /// The API version of the Cat Herding service to invoke.
    public let apiVersion: String
    ...

    public init(
        apiVersion: CatHerdingClient.ApiVersion = .latest,
        ...
    )
}
{% endhighlight %}

The `latest` property for the service version should always be the latest stable API version for the service.

{% include refs.md %}
{% include_relative refs.md %}
