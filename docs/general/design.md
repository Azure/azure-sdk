---
title: "General Guidelines: API Design"
keywords: guidelines
permalink: general_design.html
folder: general
sidebar: general_sidebar
---

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.

## Namespaces

Some languages have a concept of namespaces to group related types.  Grouping services within a cloud infrastructure is common since it aids discoverability and provides structure to the reference documentation.

{% include requirement/SHOULD id="general-namespaces-support" %} support namespaces if namespace usage is common within the language ecosystem.

{% include requirement/MUST id="general-namespaces-naming" %} use a root namespace of the form `<AZURE>.<group>.<service>`.  All consumer-facing APIs that are commonly used should exist within this namespace.  The namespace is comprised of three parts:

- `<AZURE>` indicates a common prefix for all Azure services.  This may be `Azure` or `com.azure` or similiar, depending on the common form within the language.
- `<group>` is the group for the service.  See the list below.
- `<service>` is the shortened service name.

{% include requirement/MUST id="general-namespaces-shortened-name" %} pick a shortened service name that allows the consumer to tie the package to the service being used.  As a default, use the compressed service name.  The namespace does **NOT** change when the branding of the product changes, so avoid the use of marketing names that may change.

A compressed service name is the service name without spaces.  It may further be shortened if the shortened version is well known in the community.  For example, "Azure Media Analytics" would have a compressed service name of `MediaAnalytics`, whereas "Azure Service Bus" would become `ServiceBus`.

{% include requirement/MUST id="general-namespaces-approved-list" %} use the following list as the group of services (if the target language supports namespaces):

{% include tables/data_namespaces.md %}

If the client library does not seem to fit into the group list, contact the [Architecture Board] to discuss the namespace requirements.

{% include requirement/MUST id="general-namespaces-mgmt" %} place the management (Azure Resource Manager) API in the `management` group.  Use the grouping `<AZURE>.management.<group>.<service>` for the namespace. Since more services require control plane APIs than data plane APIs, other namespaces may be used explicitly for control plane only.  Data plane usage is by exception only.  Additional namespaces that can be used for control plane SDKs include:

{% include tables/mgmt_namespaces.md %}

Many `management` APIs do not have a data plane because they deal with management of the Azure account. Place the management library in the `<AZURE>.management` namespace.  For example, use `azure.management.costanalysis` instead of `azure.management.management.costanalysis`.

{% include requirement/MUSTNOT id="general-namespaces-similar-names" %} choose similar names for clients that do different things.

{% include requirement/MUST id="general-namespaces-registration" %} register the chosen namespace with the [Architecture Board].  Open an issue to request the namespace.  See [the registered namespace list](registered_namespaces.html) for a list of the currently registered namespaces.

### Example Namespaces

Here are some examples of namespaces that meet these guidelines:

- `Azure.Data.Cosmos`
- `Azure.Identity.ActiveDirectory`
- `Azure.IoT.DeviceProvisioning`
- `Azure.Storage.Blobs`
- `Azure.Messaging.NotificationHubs` (the client library for Notification Hubs)
- `Azure.Management.Messaging.NotificationHubs` (the management library for Notification Hubs)

Here are some namespaces that do not meet the guidelines:

- `Microsoft.Azure.CosmosDB` (not in the `Azure` namespace and does not use grouping)
- `Azure.MixedReality.Kinect` (the grouping is not in the approved list)
- `Azure.IoT.IoTHub.DeviceProvisioning` (too many levels in the group)

## Client interface

The API surface will consist of one of more _service clients_ that the consumer will instantiate to connect to your service, plus a set of supporting types.

The number of service clients in a client library should be minimized to provide consumers a clear starting point for using the library. However, multiple service clients may be appropriate in the following situations:

- The service supports two distinct use cases, such as "authoring" and "inference", or "administration" and "runtime", that are unlikely to be used together.
- The service has a small subset of methods that are needed for its hero scenarios.
- A subset of service requests require special/different permissions.

When a client library has multiple service clients, these must have descriptive names so that the consumer can quickly determine which client to use to accomplish their task.

{% include requirement/MUST id="general-client-naming" %} name service client types with the `client` suffix.

There are times when operations require the addition of optional data, provided in what is colloquially known as an "options bag".  Libraries should strive for consistent naming.

{% include requirement/SHOULD id="general-client-options-naming" %} name the type for service client option bags with the `client_options` suffix.

{% include requirement/SHOULD id="general-client-options-param-naming" %} name operation option bag types with the `options` suffix.  For example, if the operation is `get_secret`, then the type of the options bag would be called `get_secret_options`.

{% include requirement/MUST id="general-client-in-namespace" %} place service client types that the consumer is most likely to interact with in the root namespace of the client library (assuming namespaces are supported in the target language).  Specialized service clients may be placed in sub-namespaces.

{% include requirement/MUST id="general-client-minimal-constructor" %} allow the consumer to construct a service client with the minimal information needed to connect and authenticate to the service.

{% include requirement/MUST id="general-client-standardize-verbs" %} standardize verb prefixes within a set of client libraries for a service.  The service must be able to speak about a specific operation in a cross-language manner within outbound materials (such as documentation, blogs, and public speaking).  They cannot do this if the same operation is referred to by different verbs in different languages.

The following are standard verb prefixes.  You should have a good (articulated) reason to have an alternate verb for one of these operations.  For example, .NET uses `Get<noun>s` instead of `List<noun>s` since it is idiomatic to the language.

{% include tables/standard_verbs.md %}

{% include requirement/MUST id="general-client-feature-support" %} support 100% of the features provided by the Azure service the client library represents. Gaps in functionality cause confusion and frustration among developers.

## Service API versions

The purposes of the client library is to communicate with an Azure service.  Azure services support multiple API versions.  To understand the capabilities of the service, the client library must be able to support multiple service API versions.

{% include requirement/MUST id="general-service-apiversion-1" %} only target generally available service API versions when releasing a stable version of the client library.

{% include requirement/MUST id="general-service-apiversion-8" %} allow the consumer to explicitly select a supported service API version when instantiating the client.

{% include requirement/MUST id="general-service-apiversion-2" %} target the latest generally available service API version by default in stable versions of the client library.

{% include requirement/MUST id="general-service-apiversion-5" %} document the service API version that is used by default.

{% include requirement/MUST id="general-service-apiversion-3" %} target the latest public preview API version by default when releasing a public beta version of the client library.

{% include requirement/MUST id="general-service-apiversion-4" %} include all service API versions that are supported by the client library in a `ServiceVersion` enumerated value.

{% include requirement/MUST id="general-service-apiversion-6" %} ensure that the values of the `ServiceVersion` enumerated value "match" the version strings in the service Swagger definition.

{% include requirement/MUST id="general-service-apiversion-7" %} add or replace the `api-version` query parameter on any URI returned by the service e.g., `Operation-Location`, next page links, etc., with the service version passed configured on the client.

For the purposes of this requirement, semantic changes are allowed.  For instance, many version strings are based on SemVer, which allows dots and dashes.  However, these characters are not allowed in identifiers.  The developer **MUST** be able to clearly understand what service API version will be used when the service version is set to each value in the `ServiceVersion` enumerated value.

## Model types

Client libraries represent entities transferred to and from Azure services as model types.   Certain types are used for round-trips to the service.  They can be sent to the service (as an addition or update operation) and retrieved from the service (as a get operation).  These should be named according to the type.  For example, a `ConfigurationSetting` in App Configuration, or an `Event` on Event Grid.

Data within the model type can generally be split into two parts - data used to support one of the champion scenarios for the service, and less important data.  Given a type `Foo`, the less important details can be gathered in a type called `FooDetails` and attached to `Foo` as the `details` property.

For example:

{% highlight csharp %}
class ConfigurationSettingDetails {
    DateTimeOffset lastModifiedDate;
    DateTimeOffset receivedDate;
    ETag eTag;
}

class ConfigurationSetting {
    String key;
    String value;
    ConfigurationSettingDetails details;
}
{% endhighlight %}

Optional parameters and settings to an operation should be collected into an options bag named `<operation>Options`. For example, the `GetConfigurationSetting` method might take a `GetConfigurationSettingOptions` class for specifying optional parameters.

Results should use the model type (e.g. `ConfigurationSetting`) where the return value is a complete set of data for the model.  However, in cases where a partial schema is returned, use the following types:

* `<model>Item` for each item in an enumeration if the enumeration returns a partial schema for the model.  For example, `GetBlobs()` return an enumeration of `BlobItem`, which contains the blob name and metadata, but not the content of the blob.
* `<operation>Result` for the result of an operation.  The `<operation>` is tied to a specific service operation.  If the same result can be used for multiple operations, use a suitable noun-verb phrase instead.  For example, use `UploadBlobResult` for the result from `UploadBlob`, but `ContainerChangeResult` for results from the various methods that change a blob container.

The following table enumerates the various models you might create:

| Type | Example | Usage |
| `<model>` | `Secret` | The full data for a resource |
| `<model>Details` | `SecretDetails` | Less important details about a resource.  Attached to `<model>.details` |
| `<model>Item` | `SecretItem` | A partial set of data returned for enumeration |
| `<operation>Options` | `AddSecretOptions` | Optional parameters to a single operation |
| `<operation>Result` | `AddSecretResult` | A partial or different set of data for a single operation |
| `<model><verb>Result` | `SecretChangeResult` | A partial or different set of data for multiple operations on a model |

## Network requests

Since the client library generally wraps one or more HTTP requests, it is important to support standard network capabilities.  Asynchronous programming techniques are not widely understood, although such techniques are essential in developing scalable web services and required in certain environments (such as mobile or Node environments).  Many developers prefer synchronous method calls for their easy semantics when learning how to use a technology.  In addition, consumers have come to expect certain capabilities in a network stack - capabilities such as call cancellation, automatic retry, and logging.

{% include requirement/MUST id="general-network-support-sync-and-async" %} support both synchronous and asynchronous method calls, except where the language or default runtime does not support one or the other.

{% include requirement/MUST id="general-network-identify-sync-methods" %} ensure that the consumer can identify which methods are async and which are synchronous.

When an application makes a network request, the network infrastructure (like routers) and the called service may take a long time to respond and, in fact, may never respond. A well-written application SHOULD NEVER give up its control to the network infrastucture or service. Here are some examples as to why this is so important:

- When an orchestrator needs to terminate a service (due to scale in, reconfiguration, or upgrading to a new version), the orchestrator typically notifies a running service instance by sending the Posix SIGINT. When the service receives this signal, it should terminate as quickly and gracefully as possible by setting a cancellation mechanism which is honored by all network operations that are currently in progress.
- When a consumer's web server receives a request, it may set a time limit indicating how much time it is allowing before it must give a response to the user.
- When a consumer's GUI application makes a request to an Azure service via our SDK, the GUI might offer a cancel button so that the end user can indicate that they are no longer in waiting for an operation or operations to complete.

The best way for consumers to work with cancellation is to think of cancellation objects as forming a tree. For example:

- Cancelling a parent automatically cancels its children.
- Children can time out sooner than their parent but cannot extend the total time.
- Cancellation can happen due to timeout or due to a manual/explicit cancel.

Here is an example of how an application would use the tree of cancellations:

- When an application starts, it should create a cancellation object that represents the entire application; this object is explicitly terminated in response to the application receiving a SIGINT notification.
- When a web server receives an incoming request, it would create a new cancellation object that is a child of the application node. The new cancellation object would specify a maximum time that the web server is allowed to operate on the request.
- As part of operating on the incoming request, the web server might need to make multiple requests to other services (like a database). If these requests can be made serially or in parallel, then they might share the previously created cancellation object. However, if the web server wants to limit the time spent on 1 or more of the requests, it can create a new cancellation object (with the desired timeout value) and make this object a child of the incoming node; this way, the individual request times out either when the overall request times out or when the maximum time for this operation is exceeded - whichever happens first.
- Note that if multiple requests are made in parallel, it is common for the consumer to want to cancel all of them if any one of them fails. This should be a supported scenario.

{% include requirement/MUST id="general-network-accept-cancellation" %} accept platform-native cancellation tokens (that implement a timeout) on all asynchronous calls.

{% include requirement/SHOULD id="general-network-check-cancellation" %} check cancellation tokens only on I/O calls (such as network requests and file loads).  Do not check cancellation tokens in between I/O calls within the client library (for example, when processing data between I/O calls).

{% include requirement/MUSTNOT id="general-network-no-leakage" %} leak the underlying protocol transport implementation details to the consumer.  All types from the protocol transport implementation must be appropriately abstracted.

## Authentication
Azure services use a variety of different authentication schemes to allow clients to access the service.  Conceptually, there are two entities responsible in this process: a credential and an authentication policy.  Credentials provide confidential authentication data.  Authentication policies use the data provided by a credential to authenticate requests to the service.

Primarily, all Azure services should support Azure Active Directory OAuth token authentication, and all clients must support authenticating requests in this manner.

{% include requirement/MUST id="general-auth-provide-token-client-constructor" %} provide a service client constructor or factory that accepts an instance of the TokenCredential abstraction from Azure Core.

{% include requirement/MUSTNOT id="auth-client-no-token-persistence" %} persist, cache, or reuse tokens returned from the token credential. This is __CRITICAL__ as credentials generally have a short validity period and the token credential is responsible for refreshing these.

{% include requirement/MUST id="general-auth-use-core" %} use authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="general-auth-reserve-when-not-suported" %} reserve the API surface needed for TokenCredential authentication, in the rare case that a service does not yet support Azure Active Directory authentication.

In addition to Azure Active Directory OAuth, services may provide custom authentication schemes. In this case the following guidelines apply.

{% include requirement/MUST id="general-auth-support" %} support all authentication schemes that the service supports.

{% include requirement/MUST id="general-auth-provide-credential-types" %} define a public custom credential type which enables clients to authenticate requests using the custom scheme.

{% include requirement/SHOULDNOT id="general-auth-credential-type-base" %} define custom credential types extending or implementing the TokenCredential abstraction from Azure Core. This is especially true in type safe languages where extending or implementing this abstraction would break the type safety of other service clients, allowing users to instantiate them with the custom credential of the wrong service.

{% include requirement/MUST id="general-auth-credential-type-placement" %} define custom credential types in the same namespace and package as the client, or in a service group namespace and shared package, not in Azure Core or Azure Identity.

{% include requirement/MUST id="general-auth-credential-type-prefix" %} prepend custom credential type names with the service name or service group name to provide clear context to its intended scope and usage.

{% include requirement/MUST id="general-auth-credential-type-suffix" %} append Credential to the end of the custom credential type name. Note this must be singular not plural.

{% include requirement/MUST id="general-auth-provide-credential-constructor" %} define a constructor or factory for the custom credential type which takes in ALL data needed for the custom authentication protocol.

{% include requirement/MUST id="general-auth-provide-update-method" %} define an update method which accepts all mutable credential data, and updates the credential in an atomic, thread safe manner.

{% include requirement/MUSTNOT id="general-auth-credential-set-properties" %} define public settable properties or fields which allow users to update the authentication data directly in a non-atomic manner.

{% include requirement/SHOULDNOT id="general-auth-credential-get-properties" %} define public properties or fields which allow users to access the authentication data directly. They are most often not needed by end users, and are difficult to use in a thread safe manner. In the case that exposing the authentication data is necessary, all the data needed to authenticate requests should be returned from a single API which guarantees the data returned is in a consistent state.

{% include requirement/MUST id="general-auth-provide-client-constructor" %} provide service client constructors or factories that accept all supported credential types.

Client libraries may support providing credential data via a connection string __ONLY IF__ the service provides a connection string to users via the portal or other tooling.   Connection strings are generally good for getting started as they are easily integrated into an application by copy/paste from the portal.  However, connection strings are considered a lesser form of authentication because the credentials cannot be rotated within a running process.

{% include requirement/MUSTNOT id="general-auth-connection-strings" %} support constructing a service client with a connection string unless such connection string is available within tooling (for copy/paste operations).

## Response formats

Requests to the service fall into two basic groups - methods that make a single logical request, or a deterministic sequence of requests.  An example of a *single logical request* is a request that may be retried inside the operation.  An example of a *deterministic sequence of requests* is a paged operation.

The *logical entity* is a protocol neutral representation of a response. For HTTP, the logical entity may combine data from headers, body and the status line. A common example is exposing an ETag header as a property on the logical entity in addition to any deserialized content from the body.

{% include requirement/MUST id="general-response-logical-entity" %} optimize for returning the logical entity for a given request. The logical entity must represent the information needed in the 99%+ case.

{% include requirement/MUST id="general-response-complete" %} allow a consumer to access the complete response, including the status line, headers and body. The client library must follow the language specific guidance for accomplishing this.

{% include requirement/MUST id="general-response-streaming" %} provide examples on how to access the raw and streamed response for a given request, where exposed by the client library.  We do not expect all methods to expose a streamed response.

{% include requirement/MUST id="general-response-enumeration" %} provide a language idiomatic way to enumerate all logical entities for a paged operation, automatically fetching new pages as needed.

For example, in Python:

```python
# Yes:
for instance in client.list_instances():
    print(instance)

# No - don't force the caller of the library to do paging:
next_page = None
while not done:
    list_instance_result = client.list_instances(page=next_page):
    for instance ln list_instance_result.response():
        print(instance)
    next_page = list_instance_result.next_page
    done = next_page is None
```

For methods that combine multiple requests into a single call:

{% include requirement/MUST id="general-response-return-headers" %} return headers and other per-request metadata unless it is obvious as to which specific HTTP request the methods return value corresponds to.

{% include requirement/MUST id="general-response-failure-cases" %} provide enough information in failure cases for an application to take appropriate corrective action.

{% include requirement/SHOULDNOT id="general-response-no-reserved-words" %} use common reserved words as a property name within the models returned within the logical entity.  For example:

- `object`
- `value`

Such usage can cause confusion and will inevitably have to be changed on a per-language basis, which can cause consistency problems.

## Conditional requests

[Conditional requests](https://developer.mozilla.org/en-US/docs/Web/HTTP/Conditional_requests) are normally performed using HTTP headers.  The primary usage provides headers that match the `ETag` to some known value.  The `ETag` is an opaque identifier that represents a single version of a resource. For example, adding the following header will translate to "if the record's version, specified by the `ETag`, is not the same".

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
If the library developer doens't need to support advanced usage of precondition headers, they can add a boolean parameter that is set to true to establish the condition.  For example, use one of the following boolean names instead of the conditions operator:

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

## Pagination

Azure client libraries eschew low-level pagination APIs in favor of high-level abstractions that implement per-item iterators. High-level APIs are easy for developers to use for the majority of use cases but can be more confusing when finer-grained control is required (for example, over-quota/throttling) and debugging when things go wrong. Other guidelines in this document work to mitigate this limitation, for example by providing robust logging, tracing, and pipeline customization options.

{% include requirement/MUST id="general-pagination-use-async-iterators" %} expose paginated collections using language-canonical iterators over items within pages. The APIs used to expose the async iterators are language-dependent but should align with any existing common practices in your ecosystem.

{% include requirement/MUST id="general-pagination-use-iterators" %} expose paginated collections using an iterator or cursor pattern if async iterators aren't a built-in feature of your language.

{% include requirement/MUST id="general-pagination-expose-lists-equally" %} expose non-paginated list endpoints identically to paginated list endpoints. Users shouldn't need to appreciate the difference.

{% include requirement/MUST id="general-pagination-use-distinct-types" %} use distinct types for entities in a list endpoint and an entity returned from a get endpoint if these are different types, and otherwise you must use the same types in these situations.

{% include important.html content="Services should refrain from having a difference between the type of a particular entity as it exists in a list versus the result of a GET request for that individual item as it makes the client library's surface area simpler." %}

{% include requirement/MUSTNOT id="general-pagination-expose-individual-items" %} expose an iterator over each individual item if getting each item requires a corresponding GET request to the service. One GET per item is often too expensive and so not an action we want to take on behalf of users.

{% include requirement/MUSTNOT id="general-pagination-no-arrays" %} expose an API to get a paginated collection into an array. This is a dangerous capability for services which may return many pages.

{% include requirement/MUST id="general-pagination-expose-paging-apis" %} expose paging APIs when iterating over a collection. Paging APIs must accept a continuation token (from a prior run) and a maximum number of items to return, and must return a continuation token as part of the response so that the iterator may continue, potentially on a different machine.

## Long running operations

Long-running operations are operations which consist of an initial request to start the operation followed by polling to determine when the operation has completed or failed. Long-running operations in Azure tend to follow the [REST API guidelines for Long-running Operations][rest-lro], but there are exceptions.

{% include requirement/MUST id="general-lro-expose-poller" %} represent long-running operations with some object that encapsulates the polling and the operation status. This object, called a *poller*, must provide APIs for:

1. querying the current operation state (either asynchronously, which may consult the service, or synchronously which must not)
2. requesting an asynchronous notification when the operation has completed
3. cancelling the operation if cancellation is supported by the service
4. registering disinterest in the operation so polling stops
5. triggering a poll operation manually (automatic polling must be disabled)
6. progress reporting (if supported by the service)

{% include requirement/MUST id="general-lro-polling-config" %} support the following polling configuration options:

* `pollInterval`

Polling configuration may be used only in the absence of relevant retry-after headers from service, and otherwise should be ignored.

{% include requirement/MUST id="general-lro-prefix" %} prefix method names which return a poller with either `begin` or `start`.  Language-specific guidelines will dictate which verb to use.

{% include requirement/MUST id="general-lro-continuation" %} provide a way to instantiate a poller with the serialized state of another poller to begin where it left off, for example by passing the state as a parameter to the same method which started the operation, or by directly instantiating a poller with that state.

{% include requirement/MUSTNOT id="general-lro-cancellation" %} cancel the long-running operation when cancellation is requested via a cancellation token. The cancellation token is cancelling the polling operation and should not have any effect on the service.

{% include requirement/MUST id="general-lro-logging" %} log polling status at the `Info` level (including time to next retry)

{% include requirement/MUST id="general-lro-progress-reporting" %} expose a progress reporting mechanism to the consumer if the service reports progress as part of the polling operation.  Language-dependent guidelines will present additional guidance on how to expose progress reporting in this case.

## Repeatable requests

The ability to retry failed requests for which a client never received a response greatly simplifies the ability to write resilient distributed applications. When the method on the service is not idempotent, the service may support safe retry by supporting repeatability headers as defined in [OASIS Repeatable Requests Version 1.0](https://docs.oasis-open.org/odata/repeatable-requests/v1.0/repeatable-requests-v1.0.html).

{% include requirement/MUST id="general-repeatable-requests-request-headers" %} add the `Repeatability-Request-ID` (a uuid) and `Repeatability-First-Sent` (IMF fixdate) request headers before sending the HTTP request to the pipeline in any client method that directly invokes a single service operation. These header values remain the same cross all retries.

{% include requirement/SHOULDNOT id="general-repeatable-requests-parameters" %} offer explicit parameters on client methods allowing the consumer to explicitly set the repeatability headers value.

NOTE: If the client method allows the consumer to set arbitrary headers, then any values for these two headers should be used and must not be overwritten by the client method code.

{% include requirement/MUST id="general-repeatable-requests-support-response-headers" %} expose the Repeatability-Result response header in the response model for the method.

## Support for non-HTTP protocols

Most Azure services expose a RESTful API over HTTPS.  However, a few services use other protocols, such as [AMQP](https://www.amqp.org/), [MQTT](https://mqtt.org/), or [WebRTC](https://webrtc.org/). In these cases, the operation of the protocol can be split into two phases:

* Per-connection (surrounding when the connection is initiated and terminated)
* Per-operation (surrounding when an operation is sent through the open connection)

The policies that are added to a HTTP request/response (authentication, unique request ID, telemetry, distributed tracing, and logging) are still valid on both a per-connection and per-operation basis.  However, the methods by which these policies are implemented are protocol dependent.

{% include requirement/MUST id="general-proto-policies" %} implement as many of the policies as possible on a per-connection and per-operation basis.

For example, MQTT over WebSockets provides the ability to add headers during the initiation of the WebSockets connection, so this is a good place to add authentication, telemetry, and distributed tracing policies.  However, MQTT has no metadata (the equivalent of HTTP headers), so per-operation policies are not possible.  AMQP, by contract, does have per-operation metadata.  Unique request ID, and distributed tracing headers can be provided on a per-operation basis with AMQP.

{% include requirement/MUST id="general-proto-adparch" %} consult the [Architecture Board] on policy decisions for non-HTTP protocols.  Implementation of all policies is expected.  If the protocol cannot support a policy, obtain an exception from the [Architecture Board].

{% include requirement/MUST id="general-proto-config" %} use the global configuration established in the Azure Core library to configure policies for non-HTTP protocols.  Consumers don't necessarily know what protocol is used by the client library.  They will expect the client library to honor global configuration that they have established for the entire Azure SDK.

{% include refs.md %}
