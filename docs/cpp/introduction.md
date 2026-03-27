---
title: "C++ Guidelines: Introduction"
keywords: guidelines cpp
permalink: cpp_introduction.html
folder: cpp
sidebar: general_sidebar
---

## Introduction

The C++ guidelines are for the benefit of client library designers targeting service applications written in C++.  You do not have to write a client library for C++ if your service is not normally accessed from C++.

### Design Principles {#cpp-principles}

The Azure SDK should be designed to enhance the productivity of developers connecting to Azure services. Other qualities (such as completeness, extensibility, and performance) are important but secondary. Productivity is achieved by adhering to the principles described below:

**Idiomatic**

* The SDK should follow the general design guidelines and conventions for the target language. It should feel natural to a developer in the target language.
* We embrace the ecosystem with its strengths and its flaws.
* We work with the ecosystem to improve it for all developers.

**Consistent**

* Client libraries should be consistent within the language, consistent with the service and consistent between all target languages. In cases of conflict, consistency within the language is the highest priority and consistency between all target languages is the lowest priority.
* Service-agnostic concepts such as logging, HTTP communication, and error handling should be consistent. The developer should not have to relearn service-agnostic concepts as they move between client libraries.
* Consistency of terminology between the client library and the service is a good thing that aids in diagnosability.
* All differences between the service and client library must have a good (articulated) reason for existing, rooted in idiomatic usage rather than whim.
* The Azure SDK for each target language feels like a single product developed by a single team.
* There should be feature parity across target languages. This is more important than feature parity with the service.

**Approachable**

* We are experts in the supported technologies so our customers, the developers, don't have to be.
* Developers should find great documentation (hero tutorial, how to articles, samples, and API documentation) that makes it easy to be successful with the Azure service.
* Getting off the ground should be easy through the use of predictable defaults that implement best practices. Think about progressive concept disclosure.
* The SDK should be easily acquired through the most normal mechanisms in the target language and ecosystem.
* Developers can be overwhelmed when learning new service concepts. The core use cases should be discoverable.

**Diagnosable**

* The developer should be able to understand what is going on.
* It should be discoverable when and under what circumstances a network call is made.
* Defaults are discoverable and their intent is clear.
* Logging, tracing, and exception handling are fundamental and should be thoughtful.
* Error messages should be concise, correlated with the service, actionable, and human readable. Ideally, the error message should lead the consumer to a useful action that they can take.
* Integrating with the preferred debugger for the target language should be easy.

**Dependable**

* Breaking changes are more harmful to a user's experience than most new features and improvements are beneficial.
* Incompatibilities should never be introduced deliberately without thorough review and very strong justification.
* Do not rely on dependencies that can force our hand on compatibility.

### General Guidelines {#cpp-general}

{% include requirement/MUST id="cpp-general-follow-general-guidelines" %} follow the [General Azure SDK Guidelines].

### Support for non-HTTP Protocols

This document contains guidelines developed primarily for typical Azure REST services, i.e. stateless services with request-response based interaction model. Many of the guidelines in this document are more broadly applicable, but some might be specific to such REST services.

## Azure SDK API Design {#cpp-api}

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.

{% include requirement/MUST id="cpp-design-naming-concise" %} use clear, concise, and meaningful names.

{% include requirement/SHOULDNOT id="cpp-design-naming-abbrev" %} use abbreviations unless necessary or when they are commonly used and understood.  For example, `az` is allowed since it is commonly used to mean `Azure`, and `iot` is used since it is a commonly understood industry term.  However, using `kv` for Key Vault would not be allowed since `kv` is not commonly used to refer to Key Vault.

{% include requirement/MUST id="cpp-design-dependencies-adparch" %} consult the [Architecture Board] if you wish to use a dependency that is not on the list of approved dependencies.


### Service Client {#cpp-client}

Service clients are the main starting points for developers calling Azure services with the Azure SDK. Each client library should have at least one client in its main namespace, so it’s easy to discover. The guidelines in this section describe patterns for the design of a service client.

There exists a distinction that must be made clear with service clients: not all classes that perform HTTP (or otherwise) requests to a service are automatically designated as a service client. A service client designation is only applied to classes that are able to be directly constructed because they are uniquely represented on the service. Additionally, a service client designation is only applied if there is a specific scenario that applies where the direct creation of the client is appropriate. If a resource can not be uniquely identified or there is no need for direct creation of the type, then the service client designation should not apply.

{% include requirement/MUST id="cpp-service-client-name" %} name service client types with the _Client_ suffix (for example, `ConfigurationClient`).

{% include requirement/MUST id="cpp-service-client-namespace" %} place service client types that the consumer is most likely to interact with in the root namespace of the client library (for example, `Azure::<group>::<service>`). Specialized service clients should be placed in sub-packages.

{% include requirement/MUST id="cpp-service-client-type" %} make service clients `classes`, not `structs`.

{% include requirement/MUST id="cpp-service-client-immutable" %} ensure that all service client classes thread safe (usually by making them immutable and stateless).

{% include requirement/MUST id="cpp-service-client-geturl" %} expose a `GetUrl()` method which returns the URL.

#### Service Client Constructors {#cpp-client-ctor}

{% include requirement/MUST id="cpp-service-client-constructor-minimal" %} provide a minimal constructor that takes only the parameters required to connect to the service.

{% include requirement/MUSTNOT id="cpp-client-constructor-no-default-params" %} use default parameters in the simplest constructor.

{% include requirement/MUST id="cpp-client-constructor-overloads" %} provide constructor overloads that allow specifying additional options via  an `options` parameter. The type of the parameter is typically a subclass of ```ClientOptions``` type, shown below.

{% highlight cpp %}
ExampleClient ExampleClient(
  const std::string& url,
  const ExampleClientOptions& options)
{
    ...

    return ExampleClient(......, options);
}
{% endhighlight %}

{% include requirement/MAY id="cpp-service-client-constructor-connectionstring" %} provide a constructor that takes a connection if the service supports it.

{% highlight cpp %}
ExampleClient ExampleClient::CreateFromConnectionString(
  const std::string& connectionString,
  const ExampleClientOptions& options)
{
    ...

    return ExampleClient(......, options);
}
{% endhighlight %}

{% include requirement/SHOULD id="cpp-service-client-constructor-passwordless" %} recommend customers use passwordless authentication methods to connect to the service.

##### Client Configuration

{% include requirement/MUST id="cpp-config-global-config" %} use relevant global configuration settings either by default or when explicitly requested to by the user, for example by passing in a configuration object to a client constructor.

{% include requirement/MUST id="cpp-config-for-different-clients" %} allow different clients of the same type to use different configurations.

{% include requirement/MUST id="cpp-config-optout" %} allow consumers of your service clients to opt out of all global configuration settings at once.

{% include requirement/MUST id="cpp-config-global-overrides" %} allow all global configuration settings to be overridden by client-provided options. The names of these options should align with any user-facing global configuration keys.

{% include requirement/MUSTNOT id="cpp-config-defaults-nochange" %} Change the default values of client
configuration options based on system or program state.

{% include requirement/MUSTNOT id="cpp-config-defaults-nobuildchange" %} Change default values of
client configuration options based on how the client library was built.

{% include requirement/MUSTNOT id="cpp-config-behaviour-changes" %} change behavior based on configuration changes that occur after the client is constructed. Hierarchies of clients inherit parent client configuration unless explicitly changed or overridden. Exceptions to this requirement are as follows:

1. Log level, which must take effect immediately across the Azure SDK.
2. Tracing on/off, which must take effect immediately across the Azure SDK.

{% include requirement/MUSTNOT id="cpp-config-noruntime" %} use client library specific runtime
configuration such as environment variables or a config file. Keep in mind that many IoT devices
won't have a filesystem or an "environment block" to read from.

##### Using ClientOptions {#cpp-usage-options}

##### Service Versions

{% include requirement/MUST id="cpp-versioning-highest-api" %} call the highest supported service API version by default.

{% include requirement/MUST id="cpp-versioning-select-api-version" %} allow the consumer to explicitly select a supported service API version when instantiating the service client.

Use a constructor parameter called `version` on the client options type.

* The `version` parameter must be the first parameter to all constructor overloads.
* The `version` parameter must be required, and default to the latest supported service version.
* The type of the `version` parameter must be `ServiceVersion`; an enum nested in the options type.
* The `ServiceVersion` enum must use explicit values starting from 1.
* `ServiceVersion` enum value 0 is reserved. When 0 is passed into APIs, ArgumentException should be thrown.

##### Mocking

#### Service Methods {#cpp-client-methods}

_Service methods_ are the methods on the client that invoke operations on the service.

##### Sync and Async

The C++ SDK is designed for synchronous api calls.

{% include requirement/MUST id="cpp-design-client-sync-api" %} provide a synchronous programming model.

{% include requirement/MUSTNOT id="cpp-design-client-no-async-api" %} provide an async programming model.

##### Naming

- **PascalCase** identifiers start with an uppercase letter and then use additional capital letters to divide words. Acronyms and initialisms are capitalized if they are 2 letters or shorter; otherwise only the first letter is capitalized. For example, `PascalCase`, `HttpRequest`, `JsonParser`, or `IOContext`.

- **camelCase** identifiers start with a lowercase letter and then use additional capital letters to divide words. Acronyms and initialisms that start an identifier are all lowercase if they begin an identifier, otherwise they follow the same 2 letters rule as PascalCase. For example, `camelCase`, `httpRequest`, `processHttp`, `ioContext`, `startIO`.

- **ALL_CAPITAL_SNAKE_CASE** identifiers are composed of entirely capital letters and divide words with underscores.

{% include requirement/MUST id="cpp-design-naming-functions" %} name functions with **PascalCase**. For example:

{% highlight cpp %}
namespace Azure { namespace Group { namespace Service {
namespace _detail {
// Part of the private API
[[nodiscard]] int64_t ComputeHash(int32_t a, int32_t b) noexcept;
} // namespace _detail

// Part of the public API
[[nodiscard]] CatHerdClient CatHerdCreateClient(char* herdName);

// Bad - private API in public namespace.
[[nodiscard]] int64_t ComputeHash(int32_t a, int32_t b) noexcept;
}}} // namespace Azure::Group::Service
{% endhighlight %}

{% include requirement/SHOULD id="cpp-design-naming-functions-noexcept" %} declare all functions that can never throw exceptions `noexcept`.

{% include requirement/MUST id="cpp-design-naming-functions-const" %} declare all client functions as `const` since service clients are intended to be immutable.

{% include requirement/MUST id="cpp-design-naming-variables-public-global" %} name namespace scope variables intended for user consumption with **PascalCase**.

{% include requirement/MUST id="cpp-design-naming-variables-constants" %} name namespace scope `const` or `constexpr` variables intended for user consumption with **PascalCase**.

{% include requirement/MUST id="cpp-design-naming-variables-public-global-internal" %} name namespace scope non-constant variables intended only for internal consumption with a `g_` prefix followed by **camelCase**. For example, `g_applicationContext`. Note that all such cases will be in a `_detail` namespace or an unnamed namespace.

{% include requirement/MUSTNOT id="cpp-design-types-or-methods-in-global-namespace" %} create types in the global namespace. All Azure SDK types MUST be in a namespace.

{% include requirement/MUST id="cpp-design-naming-variables-local" %} name local variables and parameters with **camelCase**.

{% highlight cpp %}
// Examples of the above naming rules:

namespace Azure { namespace Group { namespace Service {
int PublicNamespaceScopeVariable; // these should be used sparingly
const int PublicNamespaceScopeConstant = 42;
constexpr int OtherPublicNamespaceScopeConstant = 42;
constexpr char * PublicNamespaceScopeConstantPointer = nullptr; // const pointer to modifiable

void Function(int parameterName) {
    int localName;
}

namespace _detail {
    extern int g_internalUseGlobal;
} // namespace _detail

}}} // namespace Azure::Group::Service
{% endhighlight %}

{% include requirement/MUST id="cpp-design-naming-variables-typing-units" %} use types to enforce units where possible. For example, the C++ standard library provides `std::chrono` which makes time conversions automatic.
{% highlight cpp %}
// Bad
uint32 Timeout;

// Good
std::chrono::milliseconds Timeout;
{% endhighlight %}

{% include requirement/MUST id="cpp-design-naming-naming-units" %} include units in names when a type based solution to enforce units is not present.  If a variable represents weight, or some other unit, then include the unit in the name so developers can more easily spot problems.  For example:

{% highlight cpp %}
// Bad
uint32 Timeout;
uint32 MyWeight;

// Good
std::chrono::milliseconds Timeout;
uint32 MyWeightKg;
{% endhighlight %}

{% include requirement/MUST id="cpp-design-naming-variables-one-per-line" %} Declare or define each variable on its own line, except when declaring bitfields. An exception can be made when declaring bitfields (to clarify that the variable is a part of one bitfield). The use of bitfields in general is discouraged.

##### Cancellation

{% include requirement/MUST id="cpp-service-methods-cancellation" %} ensure all service methods, both asynchronous and synchronous, have a final parameter of type `const Azure::Core::Context &` initialized to `= {}`

The context should be further passed by reference (preferably as a `const` reference) to all calls that take a context. DO NOT check the context manually, except when running a significant amount of CPU-bound work within the library, e.g. a loop that can take more than a typical network call.

Note that cancellation is a *application developer* construct, Azure SDK clients MUST NOT cancel the `Context` object provided by the client. 

##### Mocking

##### Return Types

{% include requirement/MUST id="cpp-design-client-return-types" %} return `Response<T>` or `Response` from synchronous methods.

`T` represents the content of the response, as described below.

The `T` can be either an unstructured payload (e.g. bytes of a storage blob) or a _model type_ representing deserialized response content.

{% include requirement/MUST id="cpp-design-client-return-unstructured-type" %} use one of the following return types to represent an unstructured payload:

> TODO: What type should be used for large streaming payloads?

* `TODO` - for large payloads
* `byte[]` - for small payloads

{% include requirement/MUST id="cpp-design-client-return-model-type" %} return a _model type_ if the content has a schema and can be deserialized.

For more information, see [Model Types](#cpp-model-types)

Requests to the service fall into two basic groups - methods that make a single logical request, or a deterministic sequence of requests.  An example of a *single logical request* is a request that may be retried inside the operation.  An example of a *deterministic sequence of requests* is a paged operation.

The *logical entity* is a protocol neutral representation of a response. For HTTP, the logical entity may combine data from headers, body and the status line. A common example is exposing an ETag header as a property on the logical entity in addition to any deserialized content from the body.

{% include requirement/MUST id="cpp-design-logical-client-return-logical-entities" %} optimize for returning the logical entity for a given request. The logical entity MUST represent the information needed in the 99%+ case.

{% include requirement/MUST id="cpp-design-logical-client-expose-raw" %} *make it possible* for a developer to get access to the complete response, including the status line, headers and body. The client library MUST follow the language specific guidance for accomplishing this.

For example, you may choose to do something similar to the following:

{% highlight cpp %}
namespace Azure { namespace Group { namespace Service {
struct JsonShortItem {
    // JSON decoded structure.
};

struct JsonShortPagedResults {
    uint32 Size;
    JsonShortItem* Items;
};

struct JsonShortRawPagedResults {
    HTTP_HEADERS* Headers;
    uint16 StatusCode;
    byte* RawBody;
    JsonShortPagedResults* Results;
};

class ShortItemsClient {
    JsonShortPagedResults* JsonGetShortListItems() const;
    JsonShortRawPagedResults* JsonGetShortListItemsWithResponse(client, /* extra params */);
};
}}} // namespace Azure::Group::Service
{% endhighlight %}

{% include requirement/MUST id="cpp-design-logical-client-document-raw-stream" %} document and provide examples on how to access the raw and streamed response for a given request, where exposed by the client library.  We do not expect all methods to expose a streamed response.

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="cpp-design-logical-client-no-headers-if-confusing" %} return headers and other per-request metadata unless it is obvious as to which specific HTTP request the methods return value corresponds to.

{% include requirement/MUST id="cpp-design-logical-client-expose-data-for-composite-failures" %} provide enough information in failure cases for an application to take appropriate corrective action.

##### Thread Safety

{% include requirement/MUST id="cpp-design-client-methods-thread-safety" %} be thread-safe. All public members of the client type must be safe to call from multiple threads concurrently.

#### Service Method Parameters {#cpp-parameters}

##### Parameter Validation

The service client will have several methods that perform requests on the service.  _Service parameters_ are directly passed across the wire to an Azure service.  _Client parameters_ are not passed directly to the service, but used within the client library to fulfill the request.  Examples of client parameters include values that are used to construct a URI, or a file that needs to be uploaded to storage.

{% include requirement/MUST id="cpp-params-client-validation" %} validate client parameters.

{% include requirement/MUSTNOT id="cpp-params-server-validation" %} validate service parameters.  This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUST id="cpp-params-check-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service.  If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

#### Methods Returning Collections (Paging) {#cpp-paging}

Although object-orientated languages can eschew low-level pagination APIs in favor of high-level abstractions, C acts as a lower level language and thus embraces pagination APIs provided by the service.  You should work within the confines of the paging system provided by the service.

{% include requirement/MUST id="cpp-design-logical-client-pagination-use-paging" %} export the same paging API as the service provides.

{% include requirement/MUST id="cpp-design-logical-client-pagination-cpp-last-page" %} indicate in the return type if the consumer has reached the end of the result set.

{% include requirement/MUST id="cpp-design-logical-client-pagination-size-of-page" %} indicate in the return type how many items were returned by the service, and have a list of those items for the consumer to iterate over.

#### Methods Invoking Long Running Operations {#cpp-longrunning}

Some service operations, known as _Long Running Operations_ or _LROs_ take a long time (up to hours or days). Such operations do not return their result immediately, but rather are started, their progress is polled, and finally the result of the operation is retrieved.

Azure::Core library exposes an abstract type called `Operation<T>`, which represents such LROs and supports operations for polling and waiting for status changes, and retrieving the final operation result.  A service method invoking a long running operation will return a subclass of `Operation<T>`, as shown below.

{% include requirement/MUST id="cpp-lro-prefix" %} name all methods that start an LRO with the `Start` prefix.

{% include requirement/MUST id="cpp-lro-return" %} return a subclass of `Operation<T>` from LRO methods.

{% include requirement/MAY id="cpp-lro-subclass" %} add additional APIs to subclasses of `Operation<T>`.
For example, some subclasses add a constructor allowing to create an operation instance from a previously saved operation ID. Also, some subclasses are more granular states besides the `IsDone` and `HasValue` states that are present on the base class.

##### Conditional Request Methods

{% include requirement/MUST id="cpp-conditional-request-methods-etag-options" %} define ETag-related options e.g., `IfMatch`, `IfNoneMatch`, etc., in the service method options.

##### Hierarchical Clients

{% include requirement/MAY id="cpp-hierarchical-clients-subclients-return" %} return clients from other clients e.g., a `DatabaseClient` from a `CosmosClient`.

### Supporting Types

In addition to service client types, Azure SDK APIs provide and use other supporting types as well.

#### Model Types {#cpp-model-types}

This section describes guidelines for the design _model types_ and all their transitive closure of public dependencies (i.e. the _model graph_).  A model type is a representation of a REST service's resource.

{% include requirement/MUST id="cpp-design-model-public-getters" %} ensure model public properties are const if they aren't intended to be changed by the user.

Most output-only models can be fully read-only. Models that are used as both outputs and inputs (i.e. received from and sent to the service) typically have a mixture of read-only and read-write properties.

##### Model Type Naming

{% include requirement/MUST id="cpp-model-type-naming-collision" %} define models using the names from TypeSpec unless those names conflict with keywords or common types from `std`, `Azure::Core`, or other common dependencies.

If name collisions are likely and the TypeSpec cannot be changed, you can either use the `@clientName` TypeSpec decorator or update a client `.tsp` file.

{% include requirement/MUST id="cpp-model-names-fields-casing" %} define model fields using "PascalCase".

{% include requirement/SHOULD id="cpp-design-naming-context" %} consider the context associated with structure fields when naming structure fields. Customers have expressed confusion when they encounter constructs like `secret.Value.Value()` or `options.TransationcalContentHash.Value().Value`.


#### Enumerations

{% include requirement/MUST id="cpp-design-enums" %} use an `enum` for parameters, properties, and return types when values are known.

{% include requirement/MAY id="cpp-design-enums-exception" %} use a `struct` in place of an `enum class` that declares well-known fields but can contain unknown values returned from the service, or user-defined values passed to the service.

See [enumeration-like structure documentation](implementation.md#cpp-enums) for implementation details.

#### Using Azure Core Types {#cpp-commontypes}

The `azure-core` package provides common functionality for client libraries.  Documentation and usage examples can be found in the [azure/azure-sdk-for-cpp](https://github.com/Azure/azure-sdk-for-cpp/tree/main/sdk/core/azure-core) repository.

#### Using Primitive Types

{% include requirement/MUST id="cpp-primitives-etag" %} use `Azure::Core::ETag` to represent ETags.

The `Azure::Core::ETag` type is located in `azure-core` package.

{% include requirement/MUST id="cpp-primitives-uri" %} use `Azure::Core::Uri` to represent URIs.

The `Azure::Core::Uri` type is located in `azure-core` package.

### Exceptions {#cpp-errors}

Error handling is an important aspect of implementing a client library. It is the primary method by which problems are communicated to the consumer. Because we intend for the C client libraries to be used on a wide range of devices with a wide range of reliability requirements, it's important to provide robust error handling.

We distinguish between several different types of errors:

* Exhaustion / Act of God
    : errors like running out of stack space, or dealing with power failure that, in general, can not be anticipated and after which it may be hard to execute any more code, let alone recover. Code handling these errors needs to be written to *very* specific requirements, for example not doing any allocations and never growing the stack.
* Pre-Conditions
    : Pre-Condition errors occur when a caller violates the expectations of a function, for example by passing an out-of-range value or a null pointer. These are always avoidable by the direct caller, and will always require a source code change (by the caller) to fix.
* Post-Conditions
    : Post-Condition violations happen when some function didn't do the correct thing, these are _always_ bugs in the function itself, and users shouldn't be expected to handle them.
* Heap Exhaustion (Out of Memory)
    : Running out of memory.
* Recoverable Error
    : Things like trying to open a file that doesn't exist, or trying to write to a full disk. These kinds of errors can usually be handled by a function's caller directly, and need to be considered by callers that want to be robust.

**Exhaustion / Act of God**

{% include requirement/MUSTNOT id="cpp-design-logical-errorhandling-actofgod-no-return" %} return an error to the caller.

{% include requirement/MUST id="cpp-design-logical-errorhandling-actofgod-crash" %} crash, if possible. This means calling some form of fast failing function, like `abort`.

Note: if your client library needs to be resilient to these kinds of errors you must either provide a fallback system, or construct your code in a way to facilitate proving that such errors can not occur.

**Pre-conditions**

{% include requirement/MAY id="cpp-design-logical-errorhandling-prec-check" %} check preconditions on function entry.

{% include requirement/MAY id="cpp-design-logical-errorhandling-prec-disablecheck" %} provide a means to disable precondition checks in release / optimized builds.

{% include requirement/MUST id="cpp-design-logical-errorhandling-prec-crash" %} crash, if possible. This means calling some form of fast failing function, like `abort`.

{% include requirement/MUSTNOT id="cpp-design-logical-errorhandling-prec-exceptions" %} throw a C++ exception.

**Post Conditions**

{% include requirement/SHOULDNOT id="cpp-design-logical-errorhandling-postc-check" %} check post-conditions in a way that changes the computational complexity of the function.

{% include requirement/MUST id="cpp-design-logical-errorhandling-postc-disablecheck" %} provide a way to disable postcondition checks, and omit checking code from built binaries.

{% include requirement/MUST id="cpp-design-logical-errorhandling-postc-crash" %} crash, if possible. This means calling some form of fast failing function, like `abort`.

{% include requirement/MUSTNOT id="cpp-design-logical-errorhandling-postc-exceptions" %} throw a C++ exception.

**Heap Exhaustion (Out of Memory)**

{% include requirement/MAY id="cpp-design-logical-errorhandling-oom-crash" %} crash. For example, this may mean dereferencing a nullptr returned by malloc, or explicitly checking and calling abort.

Note that on some comonly deployed platforms like Linux, handling heap exhaustion from user mode is not possible in a default configuration.

{% include requirement/MAY id="cpp-design-logical-errorhandling-oom-bad-alloc" %} propagate a C++ exception of type `std::bad_alloc` when encountering an out of memory condition. We do not expect the program to continue in a recoverable state after this occurs. Note that most standard library facilities and the built in `operator new` do this automatically, and we want to allow use of other facilities that may throw here.

{% include requirement/MUSTNOT id="cpp-design-logical-errorhandling-oom-throw" %} throw bad_alloc from the SDK code itself.

**Recoverable errors**

{% include requirement/MUST id="cpp-design-logical-errorhandling-recov-reporting" %} report errors by throwing C++ exceptions defined in the Azure C++ Core Library.

For example:

{% highlight cpp %}
class Herd {
  bool m_hasShyCats;
  int m_numCats;
public:
  void CountCats(int* cats) {
    if(m_hasShyCats) {
      throw std::runtime_error("shy cats are not allowed");
    }
    *cats = m_numCats;
  }
};
{% endhighlight %}

{% include requirement/MUST id="cpp-design-logical-errorhandling-recov-error" %} produce a recoverable error when any HTTP request fails with an HTTP status code that is not defined by the service/Swagger as a successful status code.

{% include requirement/MUST id="cpp-design-logical-errorhandling-recov-document" %} document all exceptions each function and its transitive dependencies may throw, except for `std::bad_alloc`.

#### C++ Exceptions

{% include requirement/MUSTNOT id="cpp-design-logical-errorhandling-exceptions-other" %} `throw` exceptions, except those from the Azure C++ Core library as described in the error handling section.

{% include requirement/MUST id="cpp-design-logical-errorhandling-exceptions" %} propagate exceptions thrown by user code, callbacks, or dependencies. Assume any user-provided callback will propagate C++ exceptions unless the SDK documents that the callback must be completely non-throwing.

{% highlight cpp %}
template<class Callback>
void ApiFunc(const Callback& c) {
    // best
    c();

    // allowed, but results in a less pretty debugging experience for customers
    try {
        c();
    } catch (...) {
        // clean up
        throw; // throw; rethrows the original exception object
    }

    // prohibited
    try {
        c();
    } catch (...) {
        // missing throw;
    }
}
{% endhighlight %}

### Authentication {#cpp-authentication}

Azure services use a variety of different authentication schemes to allow clients to access the service. Conceptually, there are two entities responsible in this process: a credential and an authentication policy.  Credentials provide confidential authentication data.  Authentication policies use the data provided by a credential to authenticate requests to the service.

{% include requirement/MUST id="cpp-design-logical-client-support-all-auth-techniques" %} support all authentication techniques that the service supports and are available to a client application (as opposed to service side).  C is used only for client applications when talking to Azure, so some authentication techniques may not be valid.

{% include requirement/MUST id="cpp-design-logical-client-use-azure-core" %} use credential and authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="cpp-design-logical-client-prefer-token-auth" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service in a non-blocking atomic manner for each authentication scheme that does not have an implementation in Azure Core.

{% include requirement/MUST id="cpp-apisurface-auth-in-constructors" %} provide service client constructors or factories that accept any supported authentication credentials.

#### Service Clients Created after 1/1/2024

{% include requirement/MUSTNOT id="cpp-design-no-connection-strings" %} provide any authentication mechanism other than managed identity.

{% include requirement/MUSTNOT id="cpp-design-no-custom-authentication" %} provide any non-standard authentication mechanism.


#### Service Clients Created before 1/1/2024

{% include requirement/SHOULDNOT id="cpp-design-logical-client-surface-no-connection-strings" %} support providing credential data via a connection string. Connection string interfaces should be provided __ONLY IF__ the service provides a connection string to users via the portal or other tooling.

{% include requirement/MUSTNOT id="cpp-design-logical-client-surface-no-connection-string-ctors" %} support constructing a service client with a connection string unless such connection string. Provide a `CreateFromConnectionString` static member function which returns a client instead to encourage customers to choose non-connection-string-based authentication.

When implementing authentication, don't open up the consumer to security holes like PII (personally identifiable information) leakage or credential leakage. Credentials are generally issued with a time limit, and must be refreshed periodically to ensure that the service connection continues to function as expected.  Ensure your client library follows all current security recommendations and consider an independent security review of the client library to ensure you're not introducing potential security problems for the consumer.

{% include requirement/MUSTNOT id="cpp-implementing-no-persistence-auth" %}
persist, cache, or reuse security credentials. Security credentials should be considered short lived to cover both security concerns and credential refresh situations.

If your service implements a non-standard credential system (one that is not supported by Azure Core), then you need to produce an authentication policy for the HTTP pipeline that can authenticate requests given the alternative credential types provided by the client library.

{% include requirement/MUST id="cpp-implementing-secure-auth-erase" %} Use a "secure" function to zero authentication or authorization credentials as soon as possible once they are no longer needed. Examples of such functions
include: `SecureZeroMemory`, `memset_s`, and `explicit_bzero`. Examples of insecure functions include `memset`. An optimizer may notice that the credentials are
never accessed again, and optimize away the call to `memset`, resulting in the credentials remaining in memory.

{% include requirement/MUST id="cpp-implementing-auth-policy" %}
provide a suitable authentication policy that authenticates the HTTP request in the HTTP pipeline when using non-standard credentials. This includes custom connection strings, if supported.

### Namespaces {#cpp-namespace-naming}

Grouping services within a cloud infrastructure is common since it aids discoverability and provides structure to the reference documentation.

{% include requirement/MUST id="cpp-design-naming-namespaces" %} name namespaces using **PascalCase**.

{% include requirement/MUST id="cpp-design-naming-namespaces-hierarchy" %} use a root namespace of the form `Azure::<Group>::<Service>[::<Feature>]`.

For example, `Azure::Storage::Blobs` or `Azure::Storage::Files::Shares`

{% include requirement/MUST id="cpp-namespaces-approved-list" %} use one of the following pre-approved namespace groups:

- `Azure::AI` for artificial intelligence, including machine learning
- `Azure::Analytics` for client libraries that gather or process analytics data
- `Azure::Communication` communication services
- `Azure::Core` for libraries that aren't service specific
- `Azure::Cosmos` for object database technologies
- `Azure::Data` for client libraries that handle databases or structured data stores
- `Azure::DigitalTwins` for DigitalTwins related technologies
- `Azure::Identity` for authentication and authorization client libraries
- `Azure::IoT` for client libraries dealing with the Internet of Things.
    - Use `Iot` for Pascal cased compound words, such as `IotClient`, otherwise follow language conventions.
    - Do not use `IoT` more than once in a namespace.
- `Azure::Management` for client libraries accessing the control plane (Azure Resource Manager)
- `Azure::Media` for client libraries that deal with audio, video, or mixed reality
- `Azure::Messaging` for client libraries that provide messaging services, such as push notifications or pub-sub.
- `Azure::Search` for search technologies
- `Azure::Security` for client libraries dealing with security
- `Azure::Storage` for client libraries that handle unstructured data

If you think a new group should be added to the list, contact [adparch].

{% include requirement/MUST id="general-namespaces-shortened-name" %} pick a shortened service name that allows the consumer to tie the package to the service being used.  As a default, use the compressed service name.  The namespace does **NOT** change when the branding of the product changes, so avoid the use of marketing names that may change.

A compressed service name is the service name without spaces.  It may further be shortened if the shortened version is well known in the community.  For example, "Azure Media Analytics" would have a compressed service name of `MediaAnalytics`, whereas "Azure Service Bus" would become `ServiceBus`.

{% include requirement/MUST id="general-namespaces-approved-list" %} use the following list as the group of services:

{% include tables/data_namespaces_pascal_case.md %}

If the client library does not seem to fit into the group list, contact the [Architecture Board] to discuss the namespace requirements.

{% include requirement/MUST id="general-namespaces-mgmt" %} place the management (Azure Resource Manager) API in the `Management` group.  Use the grouping `Azure::Management::<Group>::<Service>` for the namespace. Since more services require control plane APIs than data plane APIs, other namespaces may be used explicitly for control plane only.  Data plane usage is by exception only.  Additional namespaces that can be used for control plane SDKs include:

{% include tables/mgmt_namespaces_pascal_case.md %}

Many `management` APIs do not have a data plane because they deal with management of the Azure account. Place the management library in the `Azure::Management` namespace.  For example, use `Azure::Management::CostAnalysis` instead of `Azure::Management::Management::CostAnalysis`.

{% include requirement/MUSTNOT id="general-namespaces-similar-names" %} choose similar names for clients that do different things.

{% include requirement/MUST id="general-namespaces-registration" %} register the chosen namespace with the [Architecture Board].  Open an issue to request the namespace.  See [the registered namespace list](registered_namespaces.html) for a list of the currently registered namespaces.

{% include requirement/MUST id="cpp-design-naming-namespaces-internal" %} place types and functions intended for use in other Azure SDK Clients in a `_internal` namespace. Note that this *only* applies to types in the `Azure::Core` namespace.

{% include requirement/MUST id="cpp-design-naming-namespaces-details" %} place private implementation details in a `_detail` namespace.

{% highlight cpp %}
namespace Azure { namespace Group { namespace Service {
namespace _detail {
// Part of the private API
struct HashComputation {
    int InternalBookkeeping;
};

const int g_privateConstant = 1729;
} // namespace _detail

// Part of the public API
struct UploadBlobRequest {
    unsigned char* Data;
    size_t DataLength;
};

// Bad - private API in public namespace.
struct HashComputation {
    int InternalBookkeeping;
};
const int g_privateConstant = 1729;
}}} // namespace Azure::Group::Service
{% endhighlight %}

#### Namespace stability contract

##### Public types

Types in the Public API surface (types not in an `_internal` or `_detail` namespace) form the public API surface of an Azure SDK package.

{% include requirement/MUST id="cpp-design-public-types-semver" %} follow [semantic versioning](https://semver.org/) rules.

##### Internal types

Types in the Internal API surface (types in an `_internal` namespace) are not designed to be called from outside the Azure SDK repository.

{% include requirement/MUSTNOT id="cpp-design-internal-types-no-public" %} define internal types in public Azure SDK headers. 

{% include requirement/MUST id="cpp-design-internal-types-header-location" %} define internal types in headers located in an `internal` directory alongside existing public Azure SDK headers.

{% include requirement/MAY id="cpp-design-internal-types-change" %} introduce breaking changes to internal types as long as those breaking changes will not break existing Azure SDK clients.

{% include requirement/MAY id="cpp-design-internal-types-public-exception1" %} *reference* internal types in public headers.

{% include requirement/MAY id="cpp-design-internal-types-public-exception2" %} include template specializations for internal templates in public headers to simplify the implementation.

NOTE: Since these types are typically located in the `azure-core` package, care must be made when introducing breaking changes to these types, and when adding new internal types. For changes to the types, the `azure-core` implementation typically has to be released *before* any Azure SDK packages can take dependencies on those types.

In addition, it is critical to realize that the only dependencies between Azure SDK packages is a >= dependency. That means that a particular version of an existing Azure SDK package is expected to work with any future versions of other Azure SDK packages, even of those packages on which it depends. That means that any breaking changes to internal types MUST be upward compatible.

##### Private types

Private types  are types located in a `_detail` namespace. Private types are only intended to be called within a single package, and follow the following requirements:

{% include requirement/MUSTNOT id="cpp-design-private-types-in-headers" %} define private types in public Azure SDK headers.

{% include requirement/MUSTNOT id="cpp-design-private-types-private" %} consume internal types outside the package in which they are defined.

{% include requirement/SHOULD id="cpp-design-private-types-private-location" %} declare and/or define private types under a `private` directory.

{% include requirement/MAY id="cpp-design-private-types-private-no-guarantees" %} modify private types without fear of introducing breaking changes.

{% include requirement/MAY id="cpp-design-private-types-public-exception1" %} *reference* private types in public headers.

{% include requirement/MAY id="cpp-design-private-types-public-exception2" %} include template specializations for private templates in public headers to simplify the implementation.

**Example Namespaces**

Here are some examples of namespaces that meet these guidelines:

- `Azure::Data::Cosmos`
- `Azure::Identity::ActiveDirectory`
- `Azure::IoT::DeviceProvisioning`
- `Azure::Storage::Blobs`
- `Azure::Messaging::NotificationHubs` (the client library for Notification Hubs)
- `Azure::Management::Messaging::NotificationHubs` (the management library for Notification Hubs)

Here are some namespaces that do not meet the guidelines:

- `microsoft::azure::CosmosDB` (not in the `Azure` namespace and does not use grouping, uses lowercase letters)
- `azure::mixed_reality::kinect` (the grouping is not in the approved list and uses snake_case)
- `Azure::IoT::IoTHub::DeviceProvisioning` (too many levels in the group)

### Support for Mocking {#cpp-mocking}

> TODO: This section needs to be driven by code in the Core library.

## Azure SDK Library Design

### Packaging {#cpp-packaging}

{% include requirement/SHOULD id="cpp-package-dynamic" %} provide both dynamic and static linking options for your library.  Each has its own merits and use cases.

{% include requirement/MUST id="cpp-package-source" %} publish your package in source code format.  Due to differences in platforms, this is the most common publishing mechanism for C libraries.

{% include requirement/MUST id="cpp-package-vcpkg" %} publish your package to [vcpkg](https://github.com/Microsoft/vcpkg), a C++ library manager supporting Windows, Linux, and MacOS.

#### Common Libraries

### Versioning {#cpp-versioning}

#### Client Versions

{% include requirement/MUST id="cpp-versioning-backwards-compatibility" %} be 100% backwards compatible with older versions of the same package.

{% include requirement/MUST id="cpp-versioning-new-package" %} introduce a new package (with new assembly names, new namespace names, and new type names) if you must do an API breaking change.

Breaking changes should happen rarely, if ever.  Register your intent to do a breaking change with [adparch]. You'll need to have a discussion with the language architect before approval.

##### Package Version Numbers {#cpp-versionnumbers}

Consistent version number scheme allows consumers to determine what to expect from a new version of the library.

{% include requirement/MUST id="cpp-version-semver" %} use _MAJOR_._MINOR_._PATCH_ format for the version of the library dll and the NuGet package.

Use _-beta._N_ suffix for beta package versions. For example, _1.0.0-beta.2_.

{% include requirement/MUST id="cpp-version-change-on-release" %} change the version number of the client library when **ANYTHING** changes in the client library.

{% include requirement/MUST id="cpp-version-patching" %} increment the patch version when fixing a bug.

{% include requirement/MUSTNOT id="cpp-version-features-in-patch" %} include new APIs in a patch release.

{% include requirement/MUST id="cpp-version-add-feature" %} increment the major or minor version when adding support for a service API version.

{% include requirement/MUST id="cpp-version-add-api" %} increment the major or minor version when adding a new method to the public API.

{% include requirement/SHOULD id="cpp-version-major-changes" %} increment the major version when making large feature changes.

{% include requirement/MUST id="cpp-version-change-from-track-1" %} select a version number greater than the highest version number of any other released Track 1 package for the service in any other scope or language.

### Dependencies {#cpp-dependencies}

Dependencies bring in many considerations that are often easily avoided by avoiding the
dependency.

- **Versioning** - Many programming languages do not allow a consumer to load multiple versions of the same package. So, if we have an client library that requires v3 of package Foo and the consumer wants to use v5 of package Foo, then the consumer cannot build their application. This means that client libraries should not have dependencies by default.
- **Size** - Consumer applications must be able to deploy as fast as possible into the cloud and move in various ways across networks. Removing additional code (like dependencies) improves deployment performance.
- **Licensing** - You must be conscious of the licensing restrictions of a dependency and often provide proper attribution and notices when using them.
- **Compatibility** - Often times you do not control a dependency and it may choose to evolve in a direction that is incompatible with your original use.
- **Security** - If a security vulnerability is discovered in a dependency, it may be difficult or time consuming to get the vulnerability corrected if Microsoft does not control the dependencies code base.

{% include requirement/MUST id="cpp-dependencies-stdlibcpp" %} use the [C++ standard library](https://en.cppreference.com/w/).

{% include requirement/MUST id="cpp-dependencies-azure-core" %} depend on the Azure Core library for functionality that is common across all client libraries.  This library includes APIs for HTTP connectivity, global configuration, and credential handling.

{% include requirement/MUSTNOT id="cpp-dependencies-approved-only" %} be dependent on any other packages within the client library distribution package. Dependencies are by-exception and need a thorough vetting through architecture review.  This does not apply to build dependencies, which are acceptable and commonly used.

{% include requirement/SHOULD id="cpp-dependencies-vendoring" %} consider copying or linking required code into the client library in order to avoid taking a dependency on another package that could conflict with the ecosystem. Make sure that you are not violating any licensing agreements and consider the maintenance that will be required of the duplicated code. ["A little copying is better than a little dependency"][1] (YouTube).

{% include requirement/MUSTNOT id="cpp-dependencies-concrete" %} depend on concrete logging, dependency injection, or configuration technologies (except as implemented in the Azure Core library).  The client library will be used in applications that might be using the logging, DI, and configuration technologies of their choice.

### Documentation Comments {#cpp-documentation}

{% include requirement/MUST id="cpp-docs-document-everything" %} document every exposed (public or protected) type and member within your library's code.

{% include requirement/MUST id="cpp-docs-docstrings" %} use [doxygen](https://www.doxygen.nl/index.html) comments for reference documentation.

See the [documentation guidelines]({{ site.baseurl }}/general_documentation.html) for language-independent guidelines for how to provide good documentation.

## Repository Guidelines {#cpp-repository}

{% include requirement/MUST id="cpp-general-repository" %} locate all source code and README in the [azure/azure-sdk-for-cpp] GitHub repository.

{% include requirement/MUST id="cpp-general-engsys" %} follow Azure SDK engineering systems guidelines for working in the [azure/azure-sdk-for-cpp] GitHub repository.

{% include requirement/MUST id="cpp-style-clang-format" %} format your source code with `clang-format`, using the configuration file located in [the azure-sdk-for-cpp repo](https://github.com/Azure/azure-sdk-for-cpp/blob/main/.clang-format).

{% include requirement/MUST id="cpp-style-filenaming" %} name all files as lowercase, in a directory of the service short name. Separate words with underscores, and end with the appropriate extension (`.cpp` or `.hpp`). For example, `iot_credential.cpp` is valid, while `IoTCredential.cl` is not.

{% include requirement/MUST id="cpp-style-privateapi-hdr" %} place an include file that is not part of the public API in an `internal` directory.  Do not include the service short name.  For example, `<azure/internal/credential.hpp>`.

{% include requirement/MUST id="cpp-style-filenames" %} use characters in the range `[a-z0-9_]` for the name portion (before the file extension).  No other characters are permitted.

Filenames should be concise, but convey what role the file plays within the library.

{% include requirement/MUST id="cpp-style-headerguards" %} use `#pragma once`

{% highlight cpp %}
#pragma once

// Contents of a given header
{% endhighlight %}

{% include requirement/MAY id="cpp-style-whole-sdk-header" %} have a header file that includes an entire client library. For example, `<azure/speech.hpp>`.

{% include requirement/SHOULD id="cpp-style-sub-sdk-header" %} have headers for smaller components that make sense to be used together. For example, `<azure/speech/translation.hpp>`.

{% include requirement/MUSTNOT id="cpp-style-change-headers" %} substantially change the names exposed by the header in response to macros or other controls. For example, `NOMINMAX` or `WIN32_LEAN_AND_MEAN` from `<Windows.h>`.

{% include requirement/MUSTNOT id="cpp-style-define-non-azure-types" %} declare types which are not a part of the Azure SDK. This requirement precludes Azure headers from including 3rd party headers like `openssl.h` or `windows.h` since all of these headers define types which are not a part of the Azure SDK.

### Source code layout

{% include requirement/MUST id="cpp-docs-source-layout" %} lay out package source code as follows:

- `<repository root>/sdk/`
  - `<package namespace group>/`
    - `<package name>/` - component root folder.
        - `CHANGELOG.md` - Changelog for the component.
        - `README.md` - Readme for the component.
        - `inc/` - include files for the component.
        - `src/` - source files for the component.
        - `test/` - tests for the component.
        - `samples/` - samples for the component.
        - `vcpkg/` - vcpkg package for the component.

{% include requirement/SHOULD id="cpp-docs-source-layout-exception" %} align the `<package namespace group>` element in the hierarchy to roughly conform to the other Azure SDK. For instance, the "eventhubs" service lives under the `messaging` package namespace group, but in most Azure SDKs, the "eventhubs" service client implementation lives in the `eventhubs` directory under the source root.

{% include requirement/MUST id="cpp-docs-source-layout-inc" %} lay out directories under the `inc` directory as follows:

- `inc/`
    - `azure/`
        - `<package namespace group>/` - eg `keyvault`, `messaging`, etc.
            - `<package short name>/` - eg `certificates`, `blobs`, `datalake`, etc.
                - `<package specific headers>`

{% include requirement/MUST id="cpp-client-name" %} base the file name for the service client on the name of the service client.

For example, the class declaration for the `AttestationClient` class should be contained in a file named `attestation_client.hpp`.

{% include requirement/SHOULD id="cpp-docs-file-contents-exception" %} have at most one service client declaration per include file.

{% include requirement/MUST id="cpp-docs-source-layout-src" %} lay out directories under the `src` directory as follows:

- `src/`
    - `private/` - private headers and source files.
    - `<package specific source files and headers>` - package implementation files.

{% include requirement/MUST id="cpp-docs-source-layout-test" %} lay out directories under the `test` directory as follows:

- `test/`
    - `ut/` - unit tests for the package.
    - `perf/` - performance tests for the package.
    - `stress/` - stress/reliability tests for the package.

### Documentation Style

There are several documentation deliverables that must be included in or as a companion to your client library. Beyond complete and helpful API documentation within the code itself (docstrings), you need a great README and other supporting documentation.

* `README.md` - Resides in the root of your library's directory within the SDK repository; includes package installation and client library usage information. ([example][README-EXAMPLE])
* `API reference` - Generated from the docstrings in your code; published on docs.microsoft.com.
* `Code snippets` - Short code examples that demonstrate single (atomic) operations for the champion scenarios you've identified for your library; included in your README, docstrings, and Quickstart.
* `Quickstart` - Article on docs.microsoft.com that is similar to but expands on the README content; typically written by your service's content developer.
* `Conceptual` - Long-form documentation like Quickstarts, Tutorials, How-to guides, and other content on docs.microsoft.com; typically written by your service's content developer.

{% include requirement/MUST id="cpp-docs-contentdev" %} include your service's content developer in the Architecture Board review for your library. To find the content developer you should work with, check with your team's Program Manager.

{% include requirement/MUST id="cpp-docs-contributors-guide" %} follow the [Azure SDK Contributors Guide]. (MICROSOFT INTERNAL)

{% include requirement/MUST id="cpp-docs-style-guide" %} adhere to the specifications set forth in the Microsoft style guides when you write public-facing documentation. This applies to both long-form documentation like a README and the docstrings in your code. (MICROSOFT INTERNAL)

* [Microsoft Writing Style Guide].
* [Microsoft Cloud Style Guide].

{% include requirement/SHOULD id="cpp-docs-to-silence" %} attempt to document your library into silence. Preempt developers' usage questions and minimize GitHub issues by clearly explaining your API in the docstrings. Include information on service limits and errors they might hit, and how to avoid and recover from those errors.

As you write your code, *doc it so you never hear about it again.* The less questions you have to answer about your client library, the more time you have to build new features for your service.

**Docstrings**

{% include requirement/MUST id="cpp-docs-doxygen" %} include docstrings compatible with the [doxygen](https://www.doxygen.nl/index.html) tool for generating reference documentation.

For example, a (very) simple docstring might look like:
{% highlight cpp %}
/**
 *   @class client
 *   @brief The client represents the resources required for a connection to an Azure AppcConfiguration resource.
 */
{% endhighlight %}

{% include requirement/MUST id="cpp-docs-doxygen-cmd" %} use doxygen's `@cmd` style docstrings

{% include requirement/MUST id="cpp-docs-doxygen-params" %} format parameter documentation like the following:

{% highlight cpp %}
/* <....documentation....>
* @param[<direction>] <param_name> description
* <....documentation....>
*/
{% endhighlight %}

For example:
{% highlight cpp %}
namespace azure::storage::blob {
/**
 * @brief execute a blocking get request
 *
 * @param[in] client
 * @param[in] path_and_query The query to execute relative to the base url of the client
 * @param[out] result
 * @param[out] result_sz size of the result
 */
void req_get(client* client, const char* path_and_query, unsigned char** result, size_t* result_sz);
} // namespace azure::storage::blob
{% endhighlight %}

{% include requirement/MUST id="cpp-docs-doxygen-nullable" %} document what happens to parameters that are set to null.

For example:

{% highlight cpp %}
namespace azure::animals::cats {
/**
 * @brief get properties of a cat (e.g. hair color, weight, floof)
 *
 * @param[in] our_cat the cat to operate on
 * @param[out] props pointer to an array of num_props, or null
 * @param[in,out] num_props pointer to the number of properties to retrieve or to a location to store the number of
 *                          properties queried as described below
 *
 * If @p props is NULL then return the number of properties available in @p num_props,
 * otherwise return @p num_props into the array at @p props
 */
void get_cat_properties(cat* our_cat, cat_properties* props, size_t* num_props);
} // namespace azure::animals::cats
{% endhighlight %}

{% include requirement/MUST id="cpp-docs-doxygen-failure" %} document which exceptions your function can propagate.

**Code snippets**

{% include requirement/MUST id="cpp-docs-include-snippets" %} include example code snippets alongside your library's code within the repository. The snippets should clearly and succinctly demonstrate the operations most developers need to perform with your library. Include snippets for every common operation, and especially for those that are complex or might otherwise be difficult for new users of your library. At a bare minimum, include snippets for the champion scenarios you've identified for the library.

{% include requirement/MUST id="cpp-docs-build-snippets" %} build and test your example code snippets using the repository's continuous integration (CI) to ensure they remain functional.

{% include requirement/MUST id="cpp-docs-snippets-in-docstrings" %} include the example code snippets in your library's docstrings so they appear in its API reference. If the language and its tools support it, ingest these snippets directly into the API reference from within the docstrings.

For example, consider a function called `do_something_or_other`:
{% highlight cpp %}
namespace azure::sdks::example {
/**
 * @brief some class type
 */
struct some_class {
    int member;

    /**
    * @brief do something, or maybe do some other thing
    */
    void do_something_or_other();
};
} // azure::sdks::example
{% endhighlight %}
It can be used as follows:
{% highlight cpp %}
/**
 * @example example_1.cpp
 */
int main() {
    using azure::sdks::example::some_class;
    some_class a;
    a.do_something_or_other();
    return 1;
}
{% endhighlight %}
When doxygen processes these files, it will see the `@example` command in example_1.cpp and
add it to the "examples" section of the documentation, it will also see the usage of
`some_struct` in the example and add a link from the documentation of `some_struct` to the
documentation (including source code) for `example_1.cpp`.

Use `@include` or `@snippet` to include examples directly in the documentation for a function or structure.
For example:

{% highlight cpp %}
//
// @brief some structure type
//
struct some_struct {
    int member;
};

//
// @brief do something, or maybe do some other thing
// see @snippet example_1.cpp use some_struct
//
void do_something_or_other(some_struct* s);
{% endhighlight %}
It can be used as follows:
{% highlight cpp %}
/**
 * @example example_1.cpp
 */
int main() {
    /** [use some_struct] */
    some_struct a;
    do_something_or_other(&a);
    /** [use some_struct] */
    return 1;
}
{% endhighlight %}

Note that automatic links from documentation to examples will only be generated in struct documentation,
not in function documentation. To generate a link from a function's documentation to an example use `@dontinclude`. For example:

{% highlight cpp %}
/**
 * @brief do something, or maybe do some other thing
 * @dontinclude example_1.cpp
 */
void do_something_or_other(const some_struct& s);
{% endhighlight %}

{% include requirement/MUSTNOT id="cpp-docs-operation-combinations" %} combine more than one operation in a code snippet unless it's required for demonstrating the type or member, or it's *in addition to* existing snippets that demonstrate atomic operations. For example, a Cosmos DB code snippet should not include both account and container creation operations--create two different snippets, one for account creation, and one for container creation.

Combined operations cause unnecessary friction for a library consumer by requiring knowledge of additional operations which might be outside their current focus. It requires them to first understand the tangential code surrounding the operation they're working on, then carefully extract just the code they need for their task. The developer can no longer simply copy and paste the code snippet into their project.

**Buildsystem integration**

{% include requirement/MUST id="cpp-docs-buildsystem" %} Provide a buildsystem target called "docs" to build
    the documentation

{% include requirement/MUST id="cpp-docs-buildsystem-option" %} Provide an option `BUILD_DOCS` to control
    building of the docs, this should default to `OFF`

To provide this you can use the CMake `FindDoxygen` module as follows:

{% highlight cmake %}
option(BUILD_DOCS "Build documentation" OFF)
if(BUILD_DOCS)
    find_package(Doxygen REQUIRED doxygen)

    # note: DOXYGEN_ options are strings to cmake, not
    # booleans, thus use only YES and NO
    set(DOXYGEN_GENERATE_XML YES)
    set(DOXYGEN_GENERATE_HTML YES)

    set(DOXYGEN_EXTRACT_PACKAGE YES)
    set(DOXYGEN_INLINE_SIMPLE_STRUCTS YES)
    set(DOXYGEN_TYPEDEF_HIDES_STRUCT YES)
    doxygen_add_docs(docs
        ${PROJECT_SOURCE_DIR}/inc
        ${PROJECT_SOURCE_DIR}/doc
        ${PROJECT_SOURCE_DIR}/src
        COMMENT "Generate Documentation")
endif()
{% endhighlight %}

**Formatting**

{% include requirement/MUST id="cpp-format-cpp" %} use [cpp-format](https://clang.llvm.org/docs/ClangFormat.html) for formatting your code. Use the [.clang-format](https://github.com/Azure/azure-sdk-for-cpp/blob/main/.clang-format) options.

In general, cpp-format will format your code correctly and ensure consistency. However, these are few additional  rules to keep in mind.

{% include requirement/MUST id="cpp-format-cpp-loops" %} place all conditional or loop statements on one line, or add braces to identify the conditional/looping block.

{%highlight c %}
if (meow == 0) purr += 1; // OK
if (meow == 0) {
    purr += 1; // OK
}
if (meow == 0) { purr += 1; } // OK (although will probably be changed by cpp-format)
if (meow == 0)
    purr += 1; // NOT OK
{% endhighlight %}

{% include requirement/MUST id="cpp-format-cpp-closing-braces" %} add comments to closing braces.  Adding a comment to closing braces can help when you are reading code because you don't have to find the begin brace to know what is going on.

{% highlight cpp %}
while (1) {
    if (valid) {
        ...
    } /* if valid */
    else {

    } /* not valid */
} /* end forever */
{% endhighlight %}

{% include requirement/MUST id="cpp-format-cpp-closing-endif" %} add comments to closing preprocessor directives to make them easier to understand.  For example:

{% highlight cpp %}
#if _BEGIN_CODE_

#ifndef _INTERNAL_CODE_

#endif /* _INTERNAL_CODE_ */

#endif /* _BEGIN_CODE_ */
{% endhighlight %}


{% include requirement/SHOULDNOT id="cpp-format-cpp-space-return" %} use parens in return statements when it isn't necessary.

{% include requirement/MUST id="cpp-format-cpp-no-yoda" %} place constants on the right of comparisons. For example `if (a == 0)` and not `if (0 == a)`

{% include requirement/MUST id="cpp-format-cpp-comment-fallthru" %} include a comment for falling through a non-empty `case` statement.  For example:

{% highlight cpp %}
switch (...) {
    case 1:
        DoSomething();
        break;
    case 2:
        DoSomethingElse();
        /* fall through */
    case 3:
        {
            int v;

            DoSomethingMore(v);
        }
        break;
    default:
        Log(LOG_DEBUG, "default case reached");
}
{% endhighlight %}

{% include requirement/SHOULDNOT id="cpp-format-cpp-no-goto" %} use `goto` statements.  The main place where `goto` statements can be usefully employed is to break out of several levels of `switch`, `for`, or `while` nesting, although the need to do such a thing may indicate that the inner constructs should be broken out into a separate function with a success/failure return code.  When a `goto` is necessary, the accompanying label should be alone on a line and to the left of the code that follows.  The `goto` should be commented as to its utility and purpose.

### README {#cpp-repository-readme}

{% include requirement/MUST id="cpp-docs-readme" %} have a README.md file in the component root folder.

An example of a good `README.md` file can be found [here](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/core/azure-core/README.md).

{% include requirement/MUST id="cpp-docs-readme-consumer" %} optimize the `README.md` for the consumer of the client library.

The contributor guide (`CONTRIBUTING.md`) should be a separate file linked to from the main component `README.md`.

### Samples {#cpp-samples}

{% include requirement/MUST id="cpp-repo-samples-examples" %} include runnable examples using `Azure::Identity::DefaultAzureCredential` and library-specific environment variables e.g., `AZURE_KEYVAULT_URL`.

{% include requirement/MUST id="cpp-repo-samples-unique" %} use unique example file names within the `samples` folder.

{% include requirement/MUST id="cpp-repo-samples-in-samples" %} locate the sample code within the `samples` folder.

## Commonly Overlooked C++ API Design Guidelines {#cpp-appendix-overlookedguidelines}

{% include requirement/SHOULDNOT id="cpp-format-cpp-no-goto" %} use `goto` statements.  The main place where `goto` statements can be usefully employed is to break out of several levels of `switch`, `for`, or `while` nesting, although the need to do such a thing may indicate that the inner constructs should be broken out into a separate function with a success/failure return code.  When a `goto` is necessary, the accompanying label should be alone on a line and to the left of the code that follows.  The `goto` should be commented as to its utility and purpose.

<!-- Links -->

{% include refs.md %}
{% include_relative refs.md %}
