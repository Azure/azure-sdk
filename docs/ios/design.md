---
title: "iOS Azure SDK Design Guidelines"
keywords: guidelines ios
permalink: ios_design.html
folder: ios
sidebar: general_sidebar
---

{% include draft.html content="The iOS guidelines are in DRAFT status" %}

## Introduction

The following document describes iOS specific guidelines for designing Azure SDK client libraries. These guidelines also expand on and simplify language-independent [General Azure SDK Guidelines][general-guidelines]. More specific guidelines take precedence over more general guidelines.

The iOS guidelines are for the benefit of client library designers targeting service applications written for the native iOS ecosystem. You do not have to write a client library for iOS if your service is not normally accessed from mobile apps.

### Design Principles

The main value of the Azure SDK is productivity. Other qualities, such as completeness, extensibility, and performance are important but secondary.  We ensure our customers can be highly productive when using our libraries by ensuring these libraries are:

**Idiomatic**

* The SDK should follow the general design guidelines and conventions for iOS libraries written in Swift, as described in the [Swift API design guidelines](https://swift.org/documentation/api-design-guidelines/). It should feel natural to a Swift developer.
* We embrace the ecosystem with its strengths and its flaws.
* We use industry-standard tooling like SwiftLint and SwiftFormat to ensure our code follows a consistent style with the rest of the ecosystem and to avoid bikeshedding about stylistic choices.
* Azure SDK libraries version together as a single entity. Swift embraces a "one repo = one package" model, so all libraries are released each time a release is created.

**Consistent**

* The Azure SDK feels like a single product of a single team, not simply a collection of libraries for Azure services.
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
* Great logging and error messages
* Predictable support lifecycle, feature coverage, and quality

### General Guidelines

{% include requirement/MUST id="ios-general-follow-general-guidelines" %} follow the [General Azure SDK Guidelines].

{% include requirement/MUST id="ios-general-repository" %} locate all source code in the [Azure/azure-sdk-for-ios] GitHub repository.

{% include requirement/MUST id="ios-language" %} write the client library in Swift 5.

The intent is to ensure that the client library is idiomatic in Swift applications. The library should not make specific accommodations to support Objective-C applications.

### Support for non-HTTP Protocols

Currently, this document describes guidelines for client libraries exposing HTTP services. If your service is not HTTP-based, please contact the [Azure SDK Architecture Board](https://azure.github.io/azure-sdk/policies_reviewprocess.html) for guidance.

## Azure SDK API Design

Azure services are exposed to iOS developers as one or more *service client* types and a set of *supporting types*.

### Service Client

Service clients are the main starting points for developers calling Azure services with the Azure SDK. Each client library should have at least one client, so it’s easy to discover. The guidelines in this section describe patterns for the design of a service client.

{% highlight swift %}
import AzureCore
import Foundation

// A client always inherits from `PipelineClient`. It may also conform to the
// `PageableClient` protocol if it provides any methods that return collections
// from paginated APIs.
public final class ConfigurationClient: PipelineClient, PageableClient {

    // Properties are defined as immutable, and are set in initializers
    public let options: ConfigurationClientOptions

    // MARK: Initializers

    // A common private initializer to assign immutable properties and call
    // `super.init()`
    private init(
        endpoint: URL,
        authPolicy: Authenticating,
        withOptions options: ConfigurationClientOptions
    ) throws {
        self.options = options
        super.init(...)
    }

    // One or more public convenience initializers make it easy for consumers to
    // create client instances
    public convenience init(
        endpoint: URL,
        credential: TokenCredential,
        withOptions options: ConfigurationClientOptions? = nil
    ) throws {
        let authPolicy = BearerTokenCredentialPolicy(credential: credential)
        try self.init(
            endpoint: endpoint,
            authPolicy: authPolicy,
            withOptions: options ?? ConfigurationClientOptions()
        )
    }

    ...

    // MARK: Public Client Methods

    ...

    // MARK: PageableClient Protocol

    // Always group methods that are used to conform with a protocol together
    ...
}
{% endhighlight %}

{% include requirement/MUST id="ios-service-client-name" %} name service client types with the _Client_ suffix (for example, `ConfigurationClient`).

{% include requirement/MUST id="ios-service-client-immutable" %} ensure that all service client classes are immutable upon instantiation.

{% include requirement/SHOULD id="ios-service-client-feature-support" %} support only those features provided by the Azure service that would make sense for a mobile app would access. Mobile apps are inherently consumer applications, and only a subset of Azure services and features are intended for use by consumer applications. While completeness is valuable and gaps in functionality can cause frustration, a smaller binary size and an opinionated stance of only providing consumer-facing functionality will make our libraries easier and more desirable for app developers to use.

{% include requirement/MUST id="ios-service-client-mobile-consistency" %} provide a public API whose shape matches the public API shape provided in the equivalent Android (Java) library as closely as possible. Clients should have the same names and provide the same functionality in their public APIs, and while method naming should be idiomatic to each platform, consistency in naming between the two platforms is the next most important consideration.

#### Service Client Creation

{% include requirement/MUST id="ios-client-initializer-minimal" %} allow the consumer to initialize a service client with the minimal information needed to connect and authenticate to the service.

{% include requirement/MUST id="ios-client-options-parameter" %} accept all optional initializer arguments via an [options struct](#option-parameters) provided as a single, final parameter named `options`. Do not accept individual initializer options as separate parameters.

{% include requirement/MUST id="ios-client-multiple-inits" %} provide unambiguous initializers and parameter labels for all client initialization scenarios. Do not use the `_` syntax to avoid requiring parameter labels. For example:

{% highlight swift %}
public convenience init(
    endpoint: URL,
    credential: TokenCredential,
    withOptions options: ConfigurationClientOptions? = nil
) {
    ...
}

public convenience init(
    connectionString: String,
    withOptions options: ConfigurationClientOptions? = nil
) {
    ...
}
{% endhighlight %}

{% include requirement/MUSTNOT id="ios-client-no-static-initializers" %} provide static methods to initialize a client.

##### Using ClientOptions

{% include requirement/MUSTNOT id="ios-client-options" %} accept options used for customization of the client as individual optional parameters in client initializers.

{% include requirement/MUST id="ios-client-options-single" %} accept a single `Options` struct as an optional parameter for all client initializers.

{% include requirement/MUST id="ios-client-options-object" %} provide an immutable struct named with the suffix `Options` to allow for customization of the client during initialization. This struct must have an initializer that accepts all possible options for the client initializer as optional parameters, with defaults for each parameter. For example:

{% highlight swift %}
public struct ConfigurationClientOptions: ClientOptions {
    // MARK: ClientOptions Protocol

    public let apiVersion: String
    public let logger: ClientLogger
    public let telemetryOptions: TelemetryOptions
    public let transportOptions: TransportOptions
    public let dispatchQueue: DispatchQueue?

    // MARK: ConfigurationClient Options

    public let configurationSettingEncryptionKey: EncryptionKey?

    // MARK: Initializer

    public init(
        apiVersion: ConfigurationClient.ApiVersion = .latest,
        logger: ClientLogger = ClientLoggers.default(tag: "ConfigurationClient"),
        telemetryOptions: TelemetryOptions = TelemetryOptions(),
        transportOptions: TransportOptions = TransportOptions(),
        dispatchQueue: DispatchQueue? = nil,
        configurationSettingEncryptionKey: EncryptionKey? = nil
    ) {
        self.apiVersion = apiVersion.rawValue
        self.logger = logger
        self.telemetryOptions = telemetryOptions
        self.transportOptions = transportOptions
        self.dispatchQueue = dispatchQueue
        self.configurationSettingEncryptionKey = configurationSettingEncryptionKey
    }
{% endhighlight %}

{% include requirement/MUST id="ios-client-options-conformance" %} conform to the `ClientOptions` protocol for structures that define options passed when initializing a service client.

{% include requirement/MUST id="ios-client-options-types" %} use rich types where possible for options. For example, use the `Date` type for dates and the `URL` type for URIs. When not possible, name the option with a suffix to express the expected type. If the expected type is a unit, the suffix should follow the format `In<Unit>` (e.g. `lengthInMeters`).

{% include requirement/MUST id="ios-client-options-location" %} store options structures (and supporting enumerations / structures referenced by such models) within the `Source/Options` directory inside the library's root directory.

##### Service Versions

{% include requirement/MUST id="ios-versioning-latest-service-api" %} call the highest supported service API version by default, and ensure this is clearly documented.

{% include requirement/MUST id="ios-versioning-select-service-api" %} provide an enum of supported service API versions that can be supplied via the [options struct](#option-parameters) when initializing the service client, as shown below:

{% highlight swift %}
public final class ConfigurationClient {
    public enum ApiVersion: String {
        /// API version "2018-01-02"
        case v20180102 = "2018-01-02"
        /// API version "2019-05-06"
        case v20190506 = "2019-05-06"

        /// The most recent API version of the service
        public static var latest: ApiVersion {
            return .v20190506
        }
    }
}

public struct ConfigurationClientOptions: ClientOptions {
    /// The API version of the service to invoke
    public let apiVersion: String
    ...

    public init(
        apiVersion: ConfigurationClient.ApiVersion = .latest,
        ...
    )
}
{% endhighlight %}

{% include requirement/MUST id="ios-versioning-latest-service-property" %} return the latest stable API version for the service that is supported by the client from the enum's `latest` property.

#### Service Methods

Service methods are the methods on the client that invoke operations on the service.

{% include requirement/MUST id="ios-async-service-methods" %} provide only async service methods, as async is the most common paradigm on iOS.

{% include requirement/MUSTNOT id="ios-async-no-blocking" %} include blocking calls inside service methods or any code called by a service method.

{% include requirement/MUSTNOT id="ios-async-framework" %} use a third-party library to provide an async API. Use only one of the approved methods described below.

{% include requirement/MUSTNOT id="ios-async-use-azure-core" %} write custom APIs for streaming or async operations. Make use of the existing functionality offered in the Azure Core library. Discuss proposed changes to the Azure Core library with the [Architecture Board].

##### Callbacks

{% include requirement/MUST id="ios-network-callback-final" %} accept a callback as the final parameter for service methods, allowing developers to take advantage of Swift's trailing closure syntax. For example:

{% highlight swift %}
// Library code

public final class ConfigurationClient {
    func get(
        configurationSetting: String,
        completionHandler: @escaping HTTPResultHandler<String>
    ) {
        ...
    }
}
{% endhighlight %}
{% highlight swift %}
// Consumer code

let client = ConfigurationClient(...)
client.get(configurationSetting: "FooSetting") { result, httpResponse in
    switch result {
    case let .success(value):
        // operate on the value
    case let .failure(error):
        // handle error
    }
}
{% endhighlight %}

{% include requirement/SHOULD id="ios-network-callback-single" %} accept only a single callback for any given service method

Providing a method that accepts multiple callbacks leads to unnecessarily cluttered code, and only the final callback parameter can make use of the trailing closure syntax.

{% include requirement/MUST id="ios-network-callback-suffix" %} use the suffix `Handler` for all callback parameter names, e.g. `completionHandler`, `progressHandler`.

{% include requirement/SHOULD id="ios-network-callback-type" %} use `HTTPResultHandler` as the type of the callback to expose both the result (or error) and the response data.

##### Delegates

{% include requirement/MAY id="ios-network-delegate" %} provide a delegate protocol that the developer can conform to instead of a callback parameter for service methods where use of the delegate would improve clarity and/or reduce clutter. For such methods, you may either accept the delegate as the final parameter or provide a property on the client to which the delegate can be attached. For example:

{% highlight swift %}
// Library code

// Delegate protocols define multiple methods which will be called asynchronously
public protocol ConfigurationSettingDelegate {
    func configurationSetting(
        _ configurationSetting: String,
        didChangeFrom oldValue: String,
        to newValue: String
    )

    func configurationSettingDidClear(_ configurationSetting: String)
}

// Provide a default do-nothing implementation of all delegate methods
public extension ConfigurationSettingDelegate {
    func configurationSetting(
        _ configurationSetting: String,
        didChangeFrom oldValue: String,
        to newValue: String
    ) { }

    func configurationSettingDidClear(_ configurationSetting: String) { }
}

public final class ConfigurationClient {
    // Accept a delegate parameter
    public func getChanges(
        forConfigurationSettingsWithPrefix prefix: String,
        delegate: ConfigurationSettingDelegate
    ) {
        ...
    }

    // Or provide a property on the client to which a delegate can be attached
    public weak var configurationSettingDelegate: ConfigurationSettingDelegate? = nil

    public func getChanges(forConfigurationSettingsWithPrefix prefix: String) {
        ...
    }
}
{% endhighlight %}
{% highlight swift %}
// Consumer Code

public func registerForChanges() {
    let client = ConfigurationClient(...)

    // Provide delegate as a parameter
    client.getChanges(forConfigurationSettingsWithPrefix: "Foo", delegate: self)

    // Or attach delegate to the client
    client.getChanges(forConfigurationSettingsWithPrefix: "Foo")
    client.configurationSettingDelegate = self
}

// MARK: ConfigurationSettingDelegate Protocol

// The consumer need not implement all delegate methods since the library
// declares default do-nothing implementations for each
public func configurationSetting(
    _ setting: String,
    didChangeFrom oldValue: String,
    to newValue: String
) {
    ...
}
{% endhighlight %}

{% include requirement/MUST id="ios-network-delegate-name" %} follow the [Swift naming conventions](https://swift.org/documentation/api-design-guidelines/#naming) when providing a delegate protocol.

Protocols that describe what something is should read as nouns (e.g. `Collection`), protocols that describe a capability should be named using the suffixes `able`, `ible`, or `ing` (e.g. `Equatable`, `ProgressReporting`). In most cases, a delegate protocol should be named after the delegating object, with the suffix `Delegate` (e.g. `ConfigurationSettingDelegate`).

{% include requirement/MUST id="ios-network-delegate-method-names" %} use a consistent prefix for each method defined by the delegate so that the developer can easily locate the delegate methods via code completion.

The name of the delegating object is commonly used as as the prefix. For example, a `ConfigurationSettingDelegate` protocol used to notify about events coming from `ConfigurationSetting` objects might define delegate methods that start with `configurationSetting`, e.g. `configurationSetting(_:didChangeFrom:to:)`, `configurationSettingDidClear(_:)`.

{% include requirement/SHOULD id="ios-network-delegate-method-param" %} accept the delegating object as the first unnamed parameter to delegate methods when using the delegating object's name as the prefix for the delegate method.

{% include requirement/MUST id="ios-network-delegate-method-impls" %} provide empty (do-nothing) default implementations for all delegate methods.

##### Naming

{% include requirement/MUST id="ios-client-verb-prefix" %} name service methods using a standardized set of verbs or verb prefixes within a set of client libraries for a service. Prefer the use of the following terms for CRUD operations:

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

{% include requirement/MUST id="ios-service-client-verb" %} use the verb by itself as the method name when the name of the first parameter makes it obvious what object the action will apply to. For example, prefer `configurationClient.get(configurationSetting: 'FooSetting', completionHandler: ...)` rather than `configurationClient.getConfigurationSetting(name: 'FooSetting', completionHandler: ...)` or `configurationClient.getConfigurationSetting('FooSetting', completionHandler: ...)`.

{% include requirement/MUST id="ios-service-client-verb-prefix" %} use the verb as as prefix for the method name when object(s) the action will apply to or return is unclear. For example, prefer `configurationClient.listConfigurationSettings()` rather than `configurationClient.list()`.

{% include requirement/MUST id="ios-service-client-method-parameter-name" %} provide unambiguous parameter labels for all client methods. Avoid using the `_` syntax to avoid requiring parameter labels for client methods.

{% include requirement/MAY id="ios-service-client-method-parameter-unnamed" %} use the `_` syntax to avoid requiring a parameter label for the first parameter of delegate methods and other scenarios where doing so is idiomatic to Swift naming conventions.

{% include requirement/SHOULD id="ios-service-client-flexibility" %} remain flexible and use names best suited for developer experience. Don't let the naming rules result in non-idiomatic naming patterns. For example, naming methods `download(blob:)` and `upload(blob:)` provides more semantic meaning and would be more idiomatic than naming them `get(blob:)` and `put(blob:)`.

{% include requirement/MUSTNOT id="ios-async-suffix" %} use the suffix `Async` for service methods or other methods that do operations asynchronously, since async is the default and expected mode of operation within the SDK.

##### Cancellation

{% include requirement/MUST id="ios-async-cancellation" %} support an optional `CancellationToken` object in conformance with the [`RequestOptions` protocol](#option-parameters). This object allows the developer to call `.cancel()` on the token or set a timeout, after which a best-effort attempt is made to cancel the request.

{% include requirement/MUST id="ios-async-cancellation-implementation" %} cancel any in-flight requests when a developer calls `cancel()` on the `CancellationToken`. If the body of the client method includes multiple, sequential operations, you must check for cancellation before executing any operations after the first. Since the underlying iOS network APIs do not permit cancellation of in-flight requests, you must also check for cancellation immediately after receiving any response. If cancellation has been requested, indicate that the call has been cancelled and do not return or otherwise further process the response.

{% include requirement/MUST id="ios-async-cancellation-triggers-error" %} return an `AzureError.sdk` error when cancellation is requested stating that the request was canceled, even if the request was successful.

#### Service Method Return Types

Requests to the service fall into two basic groups: methods that make a single logical request, and methods that make a deterministic sequence of requests.  An example of a *single logical request* is a request that may be retried inside the operation. An example of a *deterministic sequence of requests* is a paged operation.

The *logical entity* is a protocol neutral representation of a response. The logical entity may be a simple Swift type where appropriate, or a [model type](#model-types) defined within the client library in which case it may combine data from headers, body, and/or the status line. For example, you may expose an `ETag` header as a property on a model type if it's relevent to the service or to the operation with which the model type is used. In contrast, the `HTTPResponse` type defined in the Azure Core library represents the 'raw response'. It contains HTTP headers, status code, and the response body.

{% include requirement/MUST id="ios-response-return-logical-entity" %} return the logical entity for the normal form of a service method. The logical entity MUST represent the information needed in the 99%+ case.

{% include requirement/MUST id="ios-response-access-response" %} *make it possible* for a developer to access the complete response, including the status line, headers, and body. The callback type `HTTPResultHandler<T>` encodes this requirement and is the recommended type for callbacks passed to async client methods. The `T` parameter is the type of the logical entity.

{% include requirement/MUST id="ios-response-provide-examples" %} provide examples on how to access the raw and streamed response for a request, where exposed by the client library. We don't expect all methods to expose a streamed response.

{% include requirement/MUST id="ios-response-pagination" %} return an instance of the `PagedCollection` class for all paged operations. For more information on what to return for `list` operations, refer to [Pagination](#pagination).

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="ios-response-return-headers" %} return headers and other per-request metadata unless it's obvious as to which specific HTTP request the methods return value corresponds to.

{% include requirement/MUST id="ios-response-failure-cases" %} provide enough information in failure cases for an application to take appropriate corrective action.

{% include requirement/SHOULDNOT id="ios-response-reserved-words" %} use reserved words (such as `object` and `value`) as a property name within the logical entity.  Avoid reserved words in other supported languages.

#### Service Method Parameters

##### Option Parameters

{% include requirement/MUSTNOT id="ios-request-options" %} accept options used for customization of a service client method call as individual optional parameters.

{% include requirement/MUST id="ios-request-options-single" %} accept a single `Options` struct as an optional parameter for all service client methods.

{% include requirement/MUST id="ios-request-options-object" %} provide an immutable struct named with the suffix `Options` to allow for customization of each service client method call. This struct must have an initializer that accepts all possible options for the method call as optional parameters, with defaults for each parameter. For example:

{% highlight swift %}
public struct ListConfigurationSettingsOptions: RequestOptions {
    // MARK: RequestOptions Protocol

    public let clientRequestId: String?
    public let cancellationToken: CancellationToken?
    public let dispatchQueue: DispatchQueue?
    public var context: PipelineContext?

    // MARK: ListConfigurationSettings Options

    public let configurationSettingPrefix: String?
    public let maxResults: Int?
    public let timeout: TimeInterval?

    // MARK: Initializer

    public init(
        clientRequestId: String? = nil,
        cancellationToken: CancellationToken? = nil,
        dispatchQueue: DispatchQueue? = nil,
        configurationSettingPrefix: String? = nil,
        maxResults: Int? = nil,
        timeout: TimeInterval? = nil
    ) {
        self.clientRequestId = clientRequestId
        self.cancellationToken = cancellationToken
        self.dispatchQueue = dispatchQueue
        self.configurationSettingPrefix = configurationSettingPrefix
        self.maxResults = maxResults
        self.timeout = timeout
    }
}
{% endhighlight %}

{% include requirement/MUST id="ios-request-options-conformance" %} conform to the `RequestOptions` protocol for structures that define options passed to a service client API method.

{% include requirement/MUST id="ios-request-options-types" %} use rich types where possible for options. For example, use the `Date` type for dates and the `URL` type for URIs. When not possible, name the option with a suffix to express the expected type. If the expected type is a unit, the suffix should follow the format `In<Unit>` (e.g. `lengthInMeters`).

{% include requirement/MUST id="ios-request-options-location" %} store options structures (and supporting enumerations / structures referenced by such models) within the `Source/Options` directory inside the library's root directory.

##### Parameter Validation

The service client will have several methods that perform requests on the service.  _Service parameters_ are directly passed across the wire to an Azure service.  _Client parameters_ are not passed directly to the service, but used within the client library to fulfill the request.  Examples of client parameters include values that are used to construct a URI, or a file that needs to be uploaded to storage.

{% include requirement/MUST id="general-params-client-validation" %} validate client parameters.

{% include requirement/MUSTNOT id="general-params-server-validation" %} validate service parameters.  This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUST id="general-params-check-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service.  If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

#### Methods Returning Collections (Paging)

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

{% include requirement/MUST id="ios-pagination-client" %} conform clients to the `PageableClient` protocol if they contain service client methods that expose paginated collections of results.

{% include requirement/MUST id="ios-pagination-async-support" %} return a `PagedCollection` from service client methods that expose a collection of results, regardless of whether the collection is paginated or non-paginated. This ensures that paginated and non-paginated collections are accessed and operate the same way. Users should not need to appreciate the difference.

> TODO: Add an example of a service client method that returns a `PagedCollection`

{% include requirement/MUST id="ios-pagination-distinct-types" %} use the same type for entities returned from a list operation vs. a get operation if those operations return different views of the same result. For example a list operation may provide only a minimal representation of each result, with the expectation that a get operation must be performed for each result to access the full representation. If the representations are compatible, reuse the same type for both the list and the get operation. Otherwise, it is permissable to use distinct types for each operation.

{% include important.html content="Services should refrain from having a difference between the type of a particular entity as it exists in a list versus the result of a GET request for that individual item as it makes the client library's surface area simpler." %}

{% include requirement/MUSTNOT id="ios-pagination-large-get-iterator" %} expose an iterator over each individual item if getting each item requires a corresponding GET request to the service. One GET per item is often too expensive and so not an action we want to take on behalf of users.

{% include requirement/MUSTNOT id="ios-pagination-array-support" %} expose an API to get a paginated collection into an array. This is a dangerous capability for services which may return many, many pages.

{% include requirement/MUSTNOT id="ios-pagination-paging-api" %} expose pagination internals when iterating over a collection. Consumers should work with only the `PagedCollection`, not the underlying Paging APIs.

#### Methods Invoking Long Running Operations

Long-running operations are uncommon in a mobile context. If you feel like you need long running operations, contact the [Azure SDK mobile team](mailto:azuresdkmobileteam@microsoft.com) for advice.

> TODO: Expand upon why LROs are uncommon in a mobile context.

#### Conditional Request Methods

> TODO

### Supporting Types

#### Model Types

Models are structures that consumers use to provide required information into client library methods. These structures typically represent the domain model or *logical entity*, a protocol neutral representation of a response.

{% include requirement/MUST id="ios-client-model-object" %} express client models as immutable structs rather than classes. Such a struct must express all properties of the model as `let` values, and have an initializer that accepts all properties of the model as parameters, with defaults provided for all optional parameters. For example:

{% highlight swift %}
public struct FeatureFlagGroup {
    public let groupName: String
    public let serviceEnabled: Bool
    public let userEnabled: Bool

    // MARK: Initializer

    public init(
        groupName: String,
        serviceEnabled: Bool = true,
        userEnabled: Bool = true
    ) {
        self.groupName = groupName
        self.serviceEnabled = serviceEnabled
        self.userEnabled = userEnabled
    }
{% endhighlight %}

{% include requirement/MUST id="ios-client-model-domain-location" %} store client models (and supporting enumerations / structures referenced by such models) within the `Source/Models` directory inside the library's root directory.

#### Enumerations

> TODO

#### Using Azure Core Types

> TODO

#### Using Primitive Types

> TODO

### Errors

> TODO: Error handling (see general guidelines)

> TBD: 
> * Hook in to HockeyApp

### Authentication

Azure services use different kinds of authentication schemes to allow clients to access the service. Conceptually, there are two entities responsible in this process: a credential and an authentication policy. Credentials provide confidential authentication data.  Authentication policies use the data provided by a credential to authenticate requests to the service.

{% include requirement/MUST id="ios-auth-support" %} support all authentication techniques that the service supports and that make sense in a mobile context. Service principal authentication generally does not make sense, for example.

{% include requirement/MUST id="ios-auth-azure-core" %} use credential and authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="ios-auth-credentials" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service.  If using a service-specific credential type, the implementation must be non-blocking and atomic.

{% include requirement/MUST id="ios-auth-credential-type" %} conform credential types to the `Credential` protocol (either directly, or by inheriting from or conforming to any type which itself conforms to `Credential`).

{% include requirement/MUST id="ios-auth-provide-client-initializer" %} provide service client initializers that accept all supported credential types. The credential must be provided as the first parameter to the initializer and must be named `credential`.

{% include requirement/MUST id="ios-auth-validate-credentials"%} validate all credential objects passed to service client initializers by calling the `validate()` method defined by the `Credential` protocol.

Client libraries may support providing credential data via a connection string __ONLY IF__ the service provides a connection string to users via the portal or other tooling. Connection strings are generally good for getting started as they are easily integrated into an application by copy/paste from the portal. However, connection strings are considered a lesser form of authentication because the credentials cannot be rotated within a running process.

{% include requirement/MAY id="ios-auth-connection-strings"%} provide a service client initializer that accepts a connection string if appropriate. The connection string must be provided as the first parameter to the initializer and must be named `connectionString`. When supporting connection strings, the documentation must include a warning that building credentials such as connection strings into a consumer-facing application is inherently insecure.

{% include requirement/MUSTNOT id="ios-auth-connection-strings-only" %} support initializing a service client with a connection string unless such connection string is available within tooling (for copy/paste operations).

{% include requirement/SHOULDNOT id="ios-authimpl-no-connection-strings" %} support connection strings with embedded secrets. iOS apps are not cryptographically secure and may be distributed to millions of devices. A developer should assume that any credential placed in an iOS app is compromised.

When implementing authentication, don't open up the consumer to security holes like PII (personally identifiable information) leakage or credential leakage. Credentials are generally issued with a time limit, and must be refreshed periodically to ensure that the service connection continues to function as expected. Ensure your client library follows all current security recommendations and consider an independent security review of the client library to ensure you're not introducing potential security problems for the consumer.

{% include requirement/MUSTNOT id="ios-authimpl-no-persisting" %} persist, cache, or reuse security credentials. Security credentials should be considered short lived to cover both security concerns and credential refresh situations.

If your service implements a non-standard credential system (that is, a credential system that is not supported by `AzureCore`), then you need to produce an authentication policy for the HTTP pipeline that can authenticate requests given the alternative credential types provided by the client library.

{% include requirement/MUST id="ios-authimpl-provide-auth-policy" %} provide an authentication policy that conforms to the `Authenticating` protocol, to authenticate the HTTP request when using non-standard credentials.

### Modules

Swift uses modules to group related types into a single distributable package. Grouping services within a cloud infrastructure is common since it aids discoverability and provides structure to the reference documentation.

{% include requirement/MUST id="ios-service-client-module" %} implement your library, and all service clients and supporting types, in a single module.

{% include requirement/MUST id="ios-service-client-module-name" %} name the module with the _Azure_ prefix (for example, `AzureConfiguration`).

{% include requirement/MAY id="ios-service-client-module-subpackage" %} break a single library into sub-modules where appropriate (for example, when a service provides multiple distinct feature sets which can be used independently). When doing so, you must include a feature suffix (for example, `AzureStorageBlob`) in the module name.

> TODO: Document module groups (e.g. 'communication') and their relation to modules

#### Example Modules

> TODO

### Support for Mocking

> TODO

## Azure SDK Library Design

### Supported Platforms

iOS developers need to concern themselves with the runtime environment they are running in.  The iOS ecosystem enjoys little fragmentation, but multiple versions and form factors are still prevalent.

{% include requirement/MUST id="ios-library-support" %} support the following versions of iOS:

* All currently available patch builds in the minor release
* The last patch build for the previous minor release
* The last patch build for the previous major release.

For example, as of writing, iOS 13.1.3 has just been released.  We expect support for 12.4.2 (the last patch release in the previous major release), iOS 13.0.0 (the last patch release in the previous minor release), iOS 13.1.0, 13.1.1, 13.1.2, and 13.1.3 (all the patch releases for the current minor release).

{% include requirement/MUST id="ios-swift-support" %} support Swift 5.  This ensures the maximum ABI compatibility going forward.

{% include requirement/MAY id="ios-swift4-support" %} support Swift 4.

{% include requirement/MAY id="ios-objc-support" %} support Objective-C.

{% include requirement/MUST id="ios-platform-support" %} support iPhone and iPad form factors.

{% include requirement/SHOULD id="ios-opt-platform-support" %} support other Apple platforms such as WatchOS and TvOS.

Only support Objective-C and Swift 4 if you have a business justification for doing so.  Optimize for applications written using Swift 5.

{% include requirement/MUST id="ios-library-same-libraries" %} release all clients within a single distributable package.

### Packaging

#### Swift Package Manager

> TODO

#### CocoaPods

> TODO

#### Service-Specific Common Libraries

There are occasions when common code needs to be shared between several client libraries.  For example, a set of cooperating client libraries may wish to share a set of exceptions or models.

{% include requirement/MUST id="general-commonlib-approval" %} gain [Architecture Board] approval prior to implementing a common library.

{% include requirement/MUST id="general-commonlib-minimize-code" %} minimize the code within a common library.  Code within the common library is available to the consumer of the client library and shared by multiple client libraries within the same namespace.

The common library should use the `Common` suffix.  For example, if Azure Storage has a common library, it would be called `AzureStorageCommon`.

A common library will only be approved if:

* The consumer of the non-shared library will consume the objects within the common library directly, AND
* The information will be shared between multiple client libraries.

Let's take two examples:

1. Implementing two Cognitive Services client libraries, we find a model is required that is produced by one Cognitive Services client library and consumed by another Coginitive Services client library, or the same model is produced by two client libraries.  The consumer is required to do the passing of the model in their code, or may need to compare the model produced by one client library vs. that produced by another client library.  This is a good candidate for choosing a common library.

2. Two Cognitive Services client libraries throw an `ObjectNotFound` exception to indicate that an object was not detected in an image.  The user might trap the exception, but otherwise will not operate on the exception.  There is no linkage between the `ObjectNotFound` exception in each client library.  This is not a good candidate for creation of a common library (although you may wish to place this exception in a common library if one exists for the namespace already).  Instead, produce two different exceptions - one in each client library.

### Versioning

> TODO

#### Client Version Numbers

> TODO

### Dependencies

{% include requirement/MUST id="ios-dependencies-azure-core" %} depend on the iOS `AzureCore` library for functionality that is common across all client libraries.  This library includes APIs for HTTP connectivity, global configuration, logging, and credential handling.

{% include requirement/MUSTNOT id="ios-dependencies-approved" %} be dependent on any other packages within the client library distribution package, with the exception of the following:

{% include_relative approved_dependencies.md %}

> TODO:
> * How can we use a common approved dependencies list.

{% include requirement/MUSTNOT id="ios-dependencies-snapshot" %} include dependencies on pre-released or beta versions of external libraries. All dependencies must be approved for general use.

{% include requirement/SHOULD id="ios-dependencies-vendoring" %} consider copying or linking required code into the client library in order to avoid taking a dependency on another package that could conflict with the ecosystem. Make sure that you are not violating any licensing agreements and consider the maintenance that will be required of the duplicated code. ["A little copying is better than a little dependency"][1] (YouTube).

{% include requirement/MUSTNOT id="ios-dependencies-concrete" %} depend on concrete logging, dependency injection, or configuration technologies (except as implemented in the `AzureCore` library). The client library will be used in applications that might be using the logging, DI, and configuration technologies of their choice.

### Native code

iOS supports the development of platform-specific native code in C++.  These can cause compatibility issues across different versions of iOS and platforms.  You should only include such native code in the iOS library if:

* You distribute full source and it is compiled in the context of the customer code.
* You hide the implementation code behind a Swift-based facade.
* You are doing so for performance reasons.  No other reason is acceptable.

> TODO: Develop and significantly expand upon our guidance for libraries with native (C/C++ or Objective-C) code

### Documentation

> TODO

## Repository Guidelines

### Documentation

#### General guidelines

> TODO

#### Samples

> TODO

## Swift API Best Practices

> TODO

### Naming Patterns

> TODO

{% include refs.md %}
{% include_relative refs.md %}
