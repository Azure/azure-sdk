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

* The SDK should follow the general design guidelines and conventions for iOS libraries written in Swift, as described in the [Swift API design guidelines](https://swift.org/documentation/). It should feel natural to a Swift developer.
* We embrace the ecosystem with its strengths and its flaws.
* We use industry-standard tooling like SwiftLint and SwiftFormat to ensure our code follows a consistent style with the rest of the ecosystem and to avoid bikeshedding about stylistic choices.

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

{% include requirement/MUST id="ios-general-follow-general-guidelines" %} follow the [General Azure SDK Guidelines].

{% include requirement/SHOULD id="ios-language-swift" %} write the client library in Swift 5.

{% include requirement/MUST id="ios-language-swift-idiomatic" %} ensure the library is idiomatic in its Swift usage.

{% include requirement/MAY id="ios-language-objc" %} write the client library in Objective-C. A library written in Objective-C must prioritize being idiomatic in its Swift usage. It need not be idiomatic in its Objective-C usage.

{% include requirement/SHOULDNOT id="ios-language-objc-compatibility" %} make specific accommodations to support Objective-C applications, unless a business case exists.

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

{% include requirement/SHOULD id="ios-service-client-feature-support" %} support only those features provided by the Azure service that would make sense for a mobile app to access. Mobile apps are inherently consumer applications, and only a subset of Azure services and features are intended for use by consumer applications. While completeness is valuable and gaps in functionality can cause frustration, a smaller binary size and an opinionated stance of only providing consumer-facing functionality will make our libraries easier and more desirable for app developers to use.

{% include requirement/MUST id="ios-service-client-mobile-consistency" %} provide a public API whose shape matches the public API shape provided in the equivalent Android library as closely as possible. Clients should have the same names and provide the same functionality as their public APIs, and while method naming should be idiomatic to each platform, consistency in naming between the two platforms is the next most important consideration.

#### Service Client Creation

{% include requirement/MUST id="ios-client-initializer-minimal" %} allow the consumer to initialize a service client with the minimal information needed to connect and authenticate to the service.

{% include requirement/MUST id="ios-client-options-parameter" %} accept all optional initializer arguments via an [options struct](#option-parameters) provided as a single, final parameter labeled `withOptions`. Do not accept individual initializer options as separate parameters.

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

{% include requirement/MUSTNOT id="ios-versioning-no-previews-in-stable" %} include preview API versions in a stable SDK release's API version enum.

{% include requirement/MUST id="ios-versioning-previews-only-in-beta" %} expose preview API versions only in beta SDKs.

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

{% include requirement/MUST id="ios-versioning-latest-service-property" %} include a `latest` property from the client's API version enum which returns the latest preview API version for beta SDKs and the latest GA API version for stable SDKs.

#### Service Methods

Service methods are the methods on the client that invoke operations on the service.

{% include requirement/MUST id="ios-async-service-methods" %} provide only async service methods, as async is the most common paradigm on iOS.

{% include requirement/MUSTNOT id="ios-async-no-blocking" %} include blocking calls inside service methods or any code called by a service method.

{% include requirement/MUSTNOT id="ios-async-framework" %} use a third-party library to provide an async API. Use only one of the approved methods described below.

{% include requirement/MUSTNOT id="ios-async-use-azure-core" %} write custom APIs for streaming or async operations. Make use of the existing functionality offered in the Azure Core library. Discuss proposed changes to the Azure Core library with the [Architecture Board].

##### Closures

{% include requirement/MUST id="ios-network-closure-final" %} accept a closure as the final parameter for service methods, allowing developers to take advantage of Swift's trailing closure syntax. For example:

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

{% include requirement/SHOULD id="ios-network-closure-single" %} accept only a single closure for any given service method.

Providing a method that accepts multiple closure leads to unnecessarily cluttered code, and only the final callback parameter can make use of the trailing closure syntax.

{% include requirement/MUST id="ios-network-closure-suffix" %} use the suffix `Handler` for all closure parameter names, e.g. `completionHandler`, `progressHandler`.

{% include requirement/SHOULD id="ios-network-closure-type" %} use `HTTPResultHandler` as the type of the closure to expose both the result (or error) and the raw response data.

#### Event Handling

iOS applications commonly need to react to events from the UI or service. The following guidelines apply to SDKs that expose events to the customer.

##### Closures

{% include requirement/MUST id="ios-event-closures-required" %} expose event handlers as closures.

{% include requirement/SHOULD id="ios-event-properties" %} group related events together in a `struct` whose definition is enclosed within the client. This struct should be named `Events` (if there is only one collection) or end with the `Events` suffix and should contain no other properties or methods besides the event handlers themselves. Event collections must be exposed directly on the client as a property that is either named `events` (if there is only one collection) or ends with the `Events` suffix. For example:

{% highlight swift %}
public class CatClient: PipelineClient {

    public struct UnicastEvents {
        public var onCatMeow: ((String) -> Void)? = nil
        public var onCatSleep: ((String) -> Void)? = nil
        ...
    }
    
    public struct MulticastEvents {
        public var onCatMeow: MulticastEventsCollection<((String) -> Void)>
        public var onCatSleep: MulticastEventsCollection<((String) -> Void)>
        ...
    }

    public var unicastEvents = Events()
    public var multicastEvents = MulticastEvents()
    ...
}
{% endhighlight %}
    
{% include requirement/MAY id="ios-event-mutable" %} mutate individual event handlers after client instantiation, unlike most client configuration which is required to be immutable.

{% include requirement/SHOULDNOT id="ios-closure-typealias" %} provide a public typealias event signatures because they do not aid in Intellisense and pollute the public API surface area. If you feel you need to expose a public typealias, contact the SDK team. 

{% include requirement/MUST id="ios-closure-naming-convention" %} name event properties using the Swift UI naming convention. For example, a delegate method called "cat(didMeow:)" would translate to an closure-based event named "onCatMeow".

{% include requirement/MUST id="ios-event-multicast" %} expose multicast event handlers using the `MulticastEventCollection` generic type from `Azure.Core`. This type contains a `register` method which accepts the event as a trailing closure and returns a UUID string identifier which can be used to unregister the handler. SDKs which cannot use `Azure.Core` (for example, ObjC-based SDKs) should work with the Azure SDK team to ensure their multicast solution projects to the same Swift interface.

{% highlight swift %}
// SDK code
public class CatClient: PipelineClient {
    public struct Events {
        public var onCatMeow: MulticastEventsCollection<((String) -> Void)>
        public var onCatSleep: MulticastEventsCollection<((String) -> Void)>
        ...
    }
    public var events = MulticastEvents()
    ...
}

// Customer Code
let client = CatClient(...)
let event1 = client.events.onCatMeow.register { ... }
let event 2 = client.events.onCatMeow.register { ... }
client.events.unregister(event1)
{% endhighlight %}

##### Delegates

{% include requirement/MAY id="ios-network-delegate" %} expose events as one or more delegate protocols that the developer can conform to. This pattern may be more familiar to Objective-C developers.


{% include requirement/MUST id="ios-delegate-property" %} include an optional weak `delegate` property on the client if delegates are implemented. For example:

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
    // Provide a property on the client to which a delegate can be attached
    public weak var delegate: ConfigurationSettingDelegate? = nil

    public func getChanges(forConfigurationSettingsWithPrefix prefix: String) {
        ...
    }
}
{% endhighlight %}

{% highlight swift %}
// Consumer Code

public func registerForChanges() {
    let client = ConfigurationClient(...)

    // Attach delegate to the client
    client.configurationSettingDelegate = self
    client.getChanges(forConfigurationSettingsWithPrefix: "Foo")
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

{% include requirement/MUST id="ios-network-delegate-name" %} follow the [Swift naming conventions](https://swift.org/documentation/) when providing a delegate protocol.

Protocols that describe what something is should read as nouns (e.g. `Collection`), protocols that describe a capability should be named using the suffixes `able`, `ible`, or `ing` (e.g. `Equatable`, `ProgressReporting`). In most cases, a delegate protocol should be named after the delegating object, with the suffix `Delegate` (e.g. `ConfigurationSettingDelegate`).

{% include requirement/MUST id="ios-network-delegate-method-names" %} use a consistent prefix for each method defined by the delegate so that the developer can easily locate the delegate methods via code completion.

The name of the delegating object is commonly used as as the prefix. For example, a `ConfigurationSettingDelegate` protocol used to notify about events coming from `ConfigurationSetting` objects might define delegate methods that start with `configurationSetting`, e.g. `configurationSetting(_:didChangeFrom:to:)`, `configurationSettingDidClear(_:)`.

{% include requirement/SHOULD id="ios-network-delegate-method-param" %} accept the delegating object as the first unnamed parameter to delegate methods when using the delegating object's name as the prefix for the delegate method. This parameter should use the `_` syntax for its external label.

{% include requirement/MUST id="ios-network-delegate-method-impls" %} provide empty (do-nothing) default implementations for all delegate methods.

{% include requirement/SHOULD id="ios-delegate-closure-parity" %} expose the same level of functionality through delegates as through event closures if delegates are implemented; however, there does not need to be a one-to-one match between delegate methods and event closures. Delegate methods are often verbose and it is acceptable to use fewer closures to represent the same set of delegate methods.

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

{% include requirement/SHOULD id="ios-service-client-method-parameter-unnamed" %} use the `_` syntax to avoid requiring a parameter label for the first parameter of delegate methods and other scenarios where doing so is idiomatic to Swift naming conventions.

{% include requirement/SHOULD id="ios-service-client-flexibility" %} remain flexible and use names best suited for developer experience. Don't let the naming rules result in non-idiomatic naming patterns. For example, naming methods `download(blob:)` and `upload(blob:)` provides more semantic meaning and would be more idiomatic than naming them `get(blob:)` and `put(blob:)`.

{% include requirement/MUSTNOT id="ios-async-suffix" %} use the suffix `Async` for service methods or other methods that do operations asynchronously, since async is the default and expected mode of operation within the SDK.

##### Cancellation

{% include requirement/MUST id="ios-async-cancellation" %} support an optional `CancellationToken` object in conformance with the [`RequestOptions` protocol](#option-parameters). This object allows the developer to call `.cancel()` on the token or set a timeout, after which a best-effort attempt is made to cancel the request.

{% include requirement/MUST id="ios-async-cancellation-implementation" %} cancel any in-flight requests when a developer calls `cancel()` on the `CancellationToken`. If the body of the client method includes multiple, sequential operations, you must check for cancellation before executing any operations after the first. Since the underlying iOS network APIs do not permit cancellation of in-flight requests, you must also check for cancellation immediately after receiving any response. If cancellation has been requested, indicate that the call has been cancelled and do not return or otherwise further process the response.

{% include requirement/MUST id="ios-async-cancellation-triggers-error" %} return an `AzureError.client` error when cancellation is requested stating that the request was canceled, even if the request was successful.

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

{% include requirement/MUST id="ios-request-options-single" %} accept a single `Options` struct as an optional parameter for all service client methods. This parameter should be labeled `withOptions`.

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

{% include requirement/MUST id="general-params-check-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service. If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

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

{% highlight swift %}
public func listCats(
    withOptions options: ListCatOptions? = nil,
    completionHandler: @escaping HTTPResultHandler<PagedCollection<Cat>>
) {
    ...
    // Construct request
    let urlTemplate = "/cat/list"
    ...
    client.request(request, context: context) { result, httpResponse in
        ...
        switch result {
        case .success:
            guard let statusCode = httpResponse?.statusCode else {
                let noStatusCodeError = AzureError.client("Expected a status code in response but didn't find one.")
                dispatchQueue.async {
                    completionHandler(.failure(noStatusCodeError), httpResponse)
                }
                return
            }
            if [
                200
            ].contains(statusCode) {
                do {
                    let decoder = JSONDecoder()
                    let codingKeys = PagedCodingKeys(
                        items: "value",
                        continuationToken: "nextLink"
                    )
                    let paged = try PagedCollection<Cat>(
                        client: self.client,
                        request: request,
                        context: context,
                        data: data,
                        codingKeys: codingKeys,
                        decoder: decoder
                    )
                    dispatchQueue.async {
                        completionHandler(.success(paged), httpResponse)
                    }
                } catch {
                    dispatchQueue.async {
                        completionHandler(.failure(AzureError.client("Decoding error.", error)), httpResponse)
                    }
                }
            }
        ...
        case let .failure(error):
            dispatchQueue.async {
                completionHandler(.failure(error), httpResponse)
            }
        }
    }
}
{% endhighlight %}

{% include requirement/MUST id="ios-pagination-distinct-types" %} use the same type for entities returned from a list operation vs. a get operation if those operations return different views of the same result. For example a list operation may provide only a minimal representation of each result, with the expectation that a get operation must be performed for each result to access the full representation. If the representations are compatible, reuse the same type for both the list and the get operation. Otherwise, it is permissable to use distinct types for each operation.

{% include important.html content="Services should refrain from having a difference between the type of a particular entity as it exists in a list versus the result of a GET request for that individual item as it makes the client library's surface area simpler." %}

{% include requirement/MUSTNOT id="ios-pagination-large-get-iterator" %} expose an iterator over each individual item if getting each item requires a corresponding GET request to the service. One GET per item is often too expensive and so not an action we want to take on behalf of users.

{% include requirement/MUSTNOT id="ios-pagination-array-support" %} expose an API to get a paginated collection into an array. This is a dangerous capability for services which may return many, many pages.

{% include requirement/MUSTNOT id="ios-pagination-paging-api" %} expose pagination internals when iterating over a collection. Consumers should work with only the `PagedCollection`, not the underlying Paging APIs.

#### Methods Invoking Long Running Operations

Long-running operations are uncommon in a mobile context. If you feel like you need long running operations, contact the [Azure SDK mobile team](mailto:azuresdkmobileteam@microsoft.com) for advice.

> TODO: Expand upon why LROs are uncommon in a mobile context.

#### Conditional Request Methods

Conditional requests are normally performed using HTTP headers. The primary usage provides headers that match the ETag to some known value. The ETag is an opaque identifier that represents a single version of a resource. For example, adding the following header will translate to "if the record's version, specified by the ETag, is not the same".

{% highlight text %} If-Not-Match: "etag-value" {% endhighlight %}

With headers, tests are possible for the following:

Unconditionally (no additional headers)
If (not) modified since a version (If-Match and If-Not-Match)
If (not) modified since a date (If-Modified-Since and If-Unmodified-Since)
If (not) present (If-Match and If-Not-Match with a ETag=* value)
Not all services support all of these semantics and may not support any of them. Developers have varying levels of understanding of the ETag and conditional requests, so it is best to abstract this concept from the API surface. There are two types of conditional requests we need to be concerned with:

Safe conditional requests (e.g. GET)

These are typically used to save bandwidth in an "update cache" scenario, i.e. I have a cached value, only send me the data if what the service has is newer than my copy. These return either a 200 or a 304 status code, indicating the value was not modified, which tells the caller that their cached value is up to date.

Unsafe conditional requests (e.g. POST, PUT, or DELETE)

These are typically used to prevent losing updates in an optimistic concurrency scenario, i.e. I've modified the cached value I'm holding, but don't update the service version unless it has the same copy I've got. These return either a success or a 412 error status code, indicating the value was modified, to indicate to the caller that they'll need to retry their update if they want it to succeed.

These two cases are handled differently in client libraries. However, the form of the call is the same in both cases. The signature of the method should be:

{% highlight text %} client.method(..., withOptions: RequestOptions) {% endhighlight %}

The `withOptions` field provides preconditions to the HTTP request. The Etag value will be retrieved from the item that is passed into the method where possible, and method arguments where not possible. The form of the method will be modified based on idiomatic usage patterns in the language of choice. In cases where the ETag value is not known, the operation cannot be conditional. If the library developer does not need to support advanced usage of precondition headers, they can add a boolean parameter that is set to true to establish the condition. For example, use one of the following boolean names instead of the conditions operator:

`onlyIfChanged`
`onlyIfUnchanged`
`onlyIfMissing`
`onlyIfPresent`
    
In all cases, the conditional expression is "opt-in", and the default is to perform the operation unconditionally.

The return value from a conditional operation must be carefully considered. For safe operators (e.g. GET), return a response that will throw if the value is accessed (or follow the same convention used for a 204 No Content response), since there is no value in the body to reference. For unsafe operators (e.g. PUT, DELETE, or POST), throw a specific error when a Precondition Failed or Conflict result is received. This allows the consumer to do something different in the case of conflicting results.

{% include requirement/SHOULD %} accept a conditions parameter (which takes an enumerated type) on service methods that allow a conditional check on the service.

{% include requirement/SHOULD %} accept an additional boolean or enum parameter on service methods as necessary to enable conditional checks using ETag.

{% include requirement/SHOULD %} include the ETag field as part of the object model when conditional operations are supported.

{% include requirement/SHOULDNOT %} throw an error when a 304 Not Modified response is received from the service.

{% include requirement/SHOULD %} throw a distinct error when a 412 Precondition Failed response or a 409 Conflict response is received from the service due to a conditional check.

### Supporting Types

#### Model Types

Models are objects (structs and classes) that consumers use to provide required information into client library methods. These structures typically represent the domain model or *logical entity*, a protocol-neutral representation of a response.

{% include requirement/SHOULD id="ios-client-model-object" %} express client models as immutable structs rather than classes. Such a struct must express all properties of the model as `let` values, and have an initializer that accepts all properties of the model as parameters, with defaults provided for all optional parameters. For example:

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

{% include requirement/MUST id="ios-enums" %} use an `enum` for parameters, properties, and return types when values are known.

{% include requirement/MUST id="ios-enums-request-string-convertible" %} conform to the `RequestStringConvertible` protocol provided in Azure Core.
    
{% include requirement/MUST id="ios-naming-enum-camelcase" %} use camel casing names for enum values. `EnumType.foo` and `EnumType.twoWords` are valid, whereas `EnumType.Foo` and `EnumType.TWO_WORDS` are not.

{% include requirement/MAY id="ios-expandable-enums" %} define an enum-like API that declares well-known fields but which can also contain unknown values returned from the service, or user-defined values passed to the service. An example expandable enum is shown below:

```swift
public struct Shape: Equatable, RequestStringConvertible {

    // the internal enum is a normal Swift enum
    internal enum ShapeKV {
        case circle
        case square
        case unknown(String)

        var rawValue: String {
            switch self {
            case .circle:
                return "circle"
            case .square:
                return "square"
            case .unknown(let value):
                return value
            }
        }

        init(rawValue: String) {
            switch rawValue.lowercased() {
            case "circle":
                self = .circle
            case "square":
                self = .square
            default:
                self = .unknown(rawValue.lowercase())
            }
        }
    }

    private let value: ShapeKV

    public var requestString: String {
        return value.rawValue
    }

    private init(rawValue: String) {
        self.value = ShapeKV(rawValue: rawValue)
    }

    public static func == (lhs: Shape, rhs: Shape) -> Bool {
        return lhs.requestString == rhs.requestString
    }

    // declare public static constants using the internal enum of known values
    public static let circle: Shape = .init(value: .circle)
    public static let square: Shape = .init(value: .square)
}
```

{% include requirement/MUST id="ios-enums-no-future-growth" %} use an regular `enum` ONLY if the enum values are known to not change like days of a week, months in a year etc. 

{% include requirement/MUST id="ios-enums-future-growth" %} define an expandable enum for enumerations if the values could expand in the future. An expandable enum forces customers who `switch` on the value to declare a `default` case, preventing the addition of a known case from causing a breaking change.

#### Using Azure Core Types

{% include requirement/MUST id="ios-core-types" %} make use of packages in Azure Core to provide behavior consistent across all Azure SDK libraries. This includes, but is not limited to:

* `PipelineClient`, `PipelineRequest`, `PipelineResponse`, etc. for http client, pipeline and related functionality.
* `ClientLogger` for logging.
* `PagedCollection` and `PagedItemSyncIterator` for returning paged results.

See the [Azure Core README][Azure Core] for more details.

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

#### Example Modules

> TODO

### Support for Mocking

> TODO

## Azure SDK Library Design

### Supported Platforms

iOS developers need to concern themselves with the runtime environment they are running in.  The iOS ecosystem enjoys little fragmentation, but multiple versions and form factors are still prevalent.

{% include requirement/MUST id="ios-library-support" %} support the following versions of iOS:

* All currently available patch builds in the minor release
* The last patch build for the previous minor release.
* The last patch build for the previous major release.

{% include requirement/MUST id="ipados-library-support" %} support the following versions of iPadOS:

* All currently available patch builds in the minor release
* The last patch build for the previous minor release.
* The last patch build for the previous major release.

{% include requirement/SHOULD id="macos-library-support" %} support MacOS in order to permit customers to use our libraries within Apple universal apps. Support the following versions of macOS: 

* All currently available patch builds in the minor release
* The last patch build for the previous minor release.
* The last patch build for the previous major release.

{% include requirement/MAY id="otheros-library-support" %} support other platforms such as watchOS and tvOS.

{% include requirement/MUST id="ios-swift-support" %} support Swift 5.  This ensures the maximum ABI compatibility going forward.

{% include requirement/MAY id="ios-swift4-support" %} support Swift 4.

{% include requirement/MAY id="ios-objc-support" %} support Objective-C.

{% include requirement/MUST id="ios-arch-support" %} support all architectures in $ARCH_STANDARD.

{% include requirement/MUSTNOT id="ios-bitcode-enabled" %} support bitcode enabled. Apple has marked this [deprecated](https://developer.apple.com/documentation/Xcode-Release-Notes/xcode-14-release-notes) from XCode 14 onwards.

{% include requirement/MUST id="ios-platform-support" %} support iPhone and iPad form factors.

Only support Objective-C and Swift 4 if you have a business justification for doing so. One such justification would be to package C++ code, which is only accessible via Objective-C. Optimize for applications written using Swift 5.

### Packaging

#### Swift Package Manager

[Swift Package manager link](https://swift.org/package-manager/) is the offical distribution channel for Swift packages created and endorsed by Apple. Accordingly, this is the primary distribution channel for the Azure SDK for iOS. Swift Package Manager follows a "one-repo-one-version" model that is not conducive to working in a mono-repo that hosts multiple independently versioning packages. To work around this limitation while preserving the benefits of working in a mono-repo, each service branch that is supported on Swift Package Manager is mirrored to its own repo that Swift Package Manager users target to acquire necessary packages.

{% include requirement/MUST id="ios-spm-packageswift" %} support Swift Package Manager by supplying a `Package.swift` manifest at the root of the service directory.

{% include requirement/MUST id="ios-spm-target" %} include a target in the `Package.swift` file that matches the names of the module.

{% include requirement/MUST id="ios-spm-test-target" %} include a test target in the `Package.swift` file that matches the names of the module with the `Tests` suffix.

For example, to register the "AzureCatHerding" service:

{% highlight swift %}
let package = Package(
    name: "AzureSDK",
    platforms: [...],
    products: [
        ...,
        .library(name: "AzureCatHerding", targets: ["AzureCatHerding"])
    ],
    dependencies: [...],
    targets: [
        ...,
        .target(
            name: "AzureCatHerding",
            dependencies: [],
            path: "sdk/catherding/AzureCatHerding",
            exclude: ["Source/Supporting Files"],
            sources: ["Source"]
        ),
        .testTarget(
            name: "AzureCatHerdingTests",
            dependencies: ["AzureCatHerding"],
            path: "sdk/catherding/AzureCatHerding",
            exclude: [
                "Tests/Info.plist",
                ...
            ],
            sources: ["Tests"]
        )
    ],
    swiftLanguageVersions: [...]
)
{% endhighlight %}

{% include requirement/MUSTNOT id="ios-spm-private-preview" %} provide private previews via Swift Package Manager.

{% include requirement/MAY id="ios-spm-binary" %} publish a module as a precompiled binary framework rather than source. This is appropriate for Objective-C-based libraries or closed-source libraries.

The following apply when publishing a pre-compiled framework:

{% include requirement/MUST id="ios-spm-xcframework" %} publish the framework in `.xcframework` format, as this is the only format that is compatbile with XCode version 12.3+.

{% include requirement/MAY id="ios-spm-framework" %} also publish the framework in `.framework` format for compatibility with older versions of XCode or iOS, if there is business justification for doing so.

#### CocoaPods

[CocoaPods](https://cocoapods.org/) is a popular, community-supported dependency manager for Swift and Objective-C libraries.

{% include requirement/MUST id="ios-cocoapods" %} support CocoaPods release by including a podspec file at the root of the service directory.

{% include requirement/MUST id="ios-cocoapods-json" %} specify the podspec in JSON format.

{% include requirement/MUST id="ios-cocoapods-podspec-name" %} name the podspec according to the following format: `<ModuleName>.podspec.json`.

{% include requirement/MUSTNOT id="ios-cocoapods-multiple-podspec" %} create multiple podspecs for the same logical package.

{% include requirement/MUSTNOT id="ios-cocoapods-support-scenarios" %} complicate the podspec to support customer support scenarios for older versions of XCode or iOS.

{% include requirement/MAY id="ios-cocoapods-private-preview" %} release private preview libraries or support older mechanisms by publishing private podspecs to the [Azure Private Podspecs](https://github.com/Azure/AzurePrivatePodspecs) repository. **Note** This repository is _public_ and thus not appropriate for non-public services.

#### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a community-supported dependency manager for Swift and Objective-C that builds binary frameworks without modifying project structure. Unlike CocoaPods and Swift Package Manager, Carthage requires no special metadata files.

{% include requirement/SHOULD id="ios-carthage-examples" %} include examples in the libary's README.md file for directions on how to integrate the library using Carthage.

{% include requirement/SHOULD id="ios-carthage-support-scenarios" %} provide specific guidance for customer support scenarios where business justifcation exists. An example would be supporting older versions of iOS or XCode that are not possible with Swift Package Manager or CocoaPods.

#### Service-Specific Common Libraries

There are occasions when common code needs to be shared between several client libraries.  For example, a set of cooperating client libraries may wish to share a set of exceptions or models.

{% include requirement/MUST id="general-commonlib-approval" %} gain [Architecture Board] approval prior to implementing a common library.

{% include requirement/MUST id="general-commonlib-minimize-code" %} minimize the code within a common library.  Code within the common library is available to the consumer of the client library and shared by multiple client libraries within the same namespace.

{% include requirement/SHOULD id="general-commonlib-suffix" %} use the `Common` suffix for the common library. For example, if Azure Storage has a common library, it would be called `AzureStorageCommon`.

A common library will only be approved if:

* The consumer of the non-shared library will consume the objects within the common library directly, AND
* The information will be shared between multiple client libraries.

Let's take two examples:

1. Implementing two Cognitive Services client libraries, we find a model is required that is produced by one Cognitive Services client library and consumed by another Coginitive Services client library, or the same model is produced by two client libraries.  The consumer is required to do the passing of the model in their code, or may need to compare the model produced by one client library vs. that produced by another client library.  This is a good candidate for choosing a common library.

2. Two Cognitive Services client libraries throw an `ObjectNotFound` exception to indicate that an object was not detected in an image.  The user might trap the exception, but otherwise will not operate on the exception.  There is no linkage between the `ObjectNotFound` exception in each client library.  This is not a good candidate for creation of a common library (although you may wish to place this exception in a common library if one exists for the namespace already).  Instead, produce two different exceptions - one in each client library.

### Versioning

{% include requirement/MUST id="ios-versioning-backwards-compatibility" %} be 100% backwards compatible with older versions of the Azure SDK.

{% include requirement/MUST id="ios-versioning-highest-api" %} call the highest supported service API version by default.

{% include requirement/MUST id="ios-versioning-select-api-version" %} allow the consumer to explicitly select a supported service API version when instantiating the service client, by using the `apiVersion` property of the service client `options` object.

{% include requirement/MUST id="ios-versioning-apiversion-change" %} increment the minor version if the default REST API version is changed, even if there's no public API change to the library.

{% include requirement/MUST id="ios-versioning-enum-latest" %} offer a `latest` option on the enum that returns the latest service version. If a consumer doesn't specify a service version the `latest` value will be used.

{% include requirement/MUST id="ios-versioning-enum--value-naming" %} use the version naming used by the service itself in naming the version values in the enum, stripping any non alphanumeric characters such as `_` and `-`. The standard approach takes the form `<year>_<month>_<day>`. For example, apiVersion `2019_01_01_preview` would translate to `20190101preview`. Being consistent with the service naming enables easier cross-referencing between service versions and the availability of features in the client library.

#### Client Version Numbers

Consistent version number scheme allows consumers to determine what to expect from a new version of the library.

{% include requirement/MUST id="ios-versioning-semver" %} use [semantic versioning](https://semver.org) for the Azure SDK.

{% include requirement/MUST id="ios-versioning-beta" %} use the `-beta.N` pre-release suffix for beta releases. For beta releases, you need only increment the beta number regardless of the type of change in the SDK, regardless of whether it is breaking or not.

{% include requirement/MUST id="ios-version-beta-dependencies" %} target specific versions of beta dependencies to ensure that subsequent, incompatible versions do not break. The is because beta versions do not follow semantic versioning. 

{% include requirement/MUST id="ios-versioning-changes" %} change the version number if *anything* changes in the Azure SDK.

{% include requirement/MUST id="ios-versioning-patch" %} increment the patch version if only bug fixes are added to the Azure SDK.

{% include requirement/MUST id="ios-verioning-minor" %} increment the minor version if any new functionality is added to the Azure SDK.

{% include requirement/MUSTNOT id="ios-version-features-in-patch" %} include new functionality in a patch release.

{% include requirement/MUSTNOT id="python-versioning-api-major" %} increment the major version for a new REST API version unless it requires breaking API changes in the Azure SDK library itself.

{% include requirement/MUST id="ios-versioning-major" %} increment the major version if there are breaking changes in the Azure SDK. Breaking changes require prior approval from the [Architecture Board].

The bar to make a breaking change is extremely high for stable client libraries. We may create a new package with a different name to avoid diamond dependency issues.

### Dependencies

{% include requirement/MUST id="ios-dependencies-azure-core" %} depend on the iOS `AzureCore` library for functionality that is common across all client libraries. This library includes APIs for HTTP connectivity, global configuration, logging, and credential handling.

{% include requirement/MUSTNOT id="ios-dependencies-approved" %} be dependent on any other packages within the client library distribution package, with the exception of the following:

{% include_relative approved_dependencies.md %}

> TODO:
> * How can we use a common approved dependencies list.

{% include requirement/MUSTNOT id="ios-dependencies-snapshot" %} take dependencies on pre-released or beta versions of external libraries. All dependencies must be approved for general use.

{% include requirement/SHOULD id="ios-dependencies-vendoring" %} consider copying or linking required code into the client library in order to avoid taking a dependency on another package that could conflict with the ecosystem. Make sure that you are not violating any licensing agreements and consider the maintenance that will be required of the duplicated code. ["A little copying is better than a little dependency"][1] (YouTube).

{% include requirement/MUSTNOT id="ios-dependencies-concrete" %} depend on concrete logging, dependency injection, or configuration technologies (except as implemented in the `AzureCore` library). The client library will be used in applications that might be using the logging, DI, and configuration technologies of their choice.

### Native code

iOS supports the development of platform-specific native code in C++.  These can cause compatibility issues across different versions of iOS and platforms.  You should only include such native code in the iOS library if:

* You distribute full source and it is compiled in the context of the customer code.
* You hide the implementation code behind a Swift-based facade.
* You are doing so for performance reasons. No other reason is acceptable.

> TODO: Develop and significantly expand upon our guidance for libraries with native (C/C++ or Objective-C) code

### Documentation

{% include requirement/MUST id="ios-jazzy-docs" %} ensure that anybody can clone the Azure SDK repo and execute `jazzy <library>` to generate the full and complete docs for the code, without any need for additional processing steps.

{% include requirement/MUST id="ios-jazzy-full-docs" %} include descriptive text of the method, as well as all parameters, the returned value (if any), and error thrown.

{% include requirement/MUST id="ios-jazzy-samples" %} include code samples in all class-level docs, and in relevant method-level docs.

{% include requirement/MUSTNOT id="ios-jazzy-hard-coding" %} hard-code the sample within the doc (where it may become stale). Put code samples in `/src/samples/ios` and use the available tooling to reference them.

{% include requirement/MUST id="ios-jazzy-naming-samples" %} follow the naming convention outlined below for naming samples tags:

 * If a new instance of the class is created through `init()` constructor: `<packagename>.<classname>.instantiation`
 * For other methods in the class: `<packagename>.<classname>.<methodName>`
 * For overloaded methods, or methods with arguments: `<packagename>.<classname>.<methodName>#<argType1>-<argType2>`
 * Camel casing for the method name and argument types is valid, but not required.

## Repository Guidelines

{% include requirement/MUST id="ios-general-repository" %} locate all source code in the [Azure/azure-sdk-for-ios] GitHub repository.

{% include requirement/MUST id="ios-spm-repository-name" %} name mirror repositories for Swift Package Manager releases in accordance with the format `SwiftPM_<PackageName>` (ex: `SwiftPM-AzureCatHerding`).

{% include requirement/MUSTNOT id="ios-spm-repository-contributions" %} manage issues or accept pull requests to Swift Package Manager mirror repositories. All contributions should be make to the [mono-repo](https://github.com/Azure/azure-sdk-for-ios).

{% include requirement/MUST id="ios-mono-repo-release-tags" %} tag releases in the mono-repo according to the format `<PackageName>_<version>`.

{% include requirement/MUST id="ios-mirror-repo-release-tags" %} tag releases in the Swift Package Manager mirror repos according to the format `<version>`. A tag to a Swift Package Manager mirror repository must always be accompanied by a corresponding tag in the mono-repo.

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
