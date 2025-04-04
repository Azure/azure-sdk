---
title: ".NET Azure SDK Design Guidelines"
keywords: guidelines dotnet
permalink: dotnet_introduction.html
folder: dotnet
sidebar: general_sidebar
---

## Introduction

The following document describes .NET specific guidelines for designing Azure SDK client libraries. These guidelines complement general [.NET Framework Design Guidelines](https://aka.ms/fxdg3) with design considerations specific to the Azure SDK. These guidelines also expand on and simplify language-independent [General Azure SDK Guidelines][general-guidelines]. More specific guidelines take precedence over more general guidelines.

Throughout this document, we'll use the client library for the [Azure Application Configuration service](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/appconfiguration/Azure.Data.AppConfiguration) to illustrate various design concepts.

### Design Principles {#dotnet-principles}

The main value of the Azure SDK is **productivity** building applications with Azure services. Other qualities, such as completeness, extensibility, and performance are important but secondary.  We ensure our customers can be highly productive when using our libraries by ensuring these libraries are:

**Idiomatic**

* Azure SDK libraries follow [.NET Framework Design Guidelines](https://aka.ms/fxdg3).
* Azure SDK libraries feel like designed by the designers of the .NET Standard libraries.
* Azure SDK libraries version just like the .NET Standard libraries.

> We are not trying to fix bad parts of the language ecosystem; we embrace the ecosystem with its strengths and its flaws.

**Consistent**

* The Azure SDK feels like a single product of a single team, not a set of unrelated NuGet packages.
* Users learn common concepts once; apply the knowledge across all SDK components.
* All differences from the guidelines must have good reasons.

**Approachable**

* Small number of steps to get started; power knobs for advanced users
* Small number of concepts; small number of types; small number of members
* Approachable by our users, not only by engineers designing the SDK components
* Easy to find great _getting started_ guides and samples
* Easy to acquire

**Dependable**

* 100% backward compatible
* Great logging, tracing, and error messages
* Predictable support lifecycle, feature coverage, and quality

### General Guidelines {#dotnet-general}

{% include requirement/MUST id="dotnet-general-follow-framework-guidelines" %} follow the official [.NET Framework Design Guidelines](https://aka.ms/fxdg3).

At the end of this document, you can find a section with [the most commonly overlooked guidelines](#dotnet-appendix-overlookedguidelines) in existing Azure SDK libraries.

{% include requirement/MUST id="dotnet-general-follow-general-guidelines" %} follow the [General Azure SDK Guidelines][general-guidelines].

The guidelines provide a robust methodology for communicating with Azure services. The easiest way to ensure that your component meets these requirements is to use the [Azure.Core] package to call Azure services. Details of these helper APIs and their usage are described in the [Using HttpPipeline](implementation.md#dotnet-usage-httppipeline) section.

{% include requirement/MUST id="dotnet-general-use-http-pipeline" %} use `HttpPipeline` to implement all methods that call Azure REST services.

The pipeline can be found in the [Azure.Core] package, and it takes care of many [General Azure SDK Guidelines][general-guidelines]. Details of the pipeline design and usage are described in section [Using HttpPipeline](implementation.md#dotnet-usage-httppipeline) below. If you can't use the pipeline, you must implement [all the general requirements of Azure SDK]({{ "/general_azurecore.html" | relative_url }}) manually.

### Support for non-HTTP Protocols

This document contains guidelines developed primarily for typical Azure REST services, i.e. stateless services with request-response based interaction model. Many of the guidelines in this document are more broadly applicable, but some might be specific to such REST services.

## Azure SDK API Design {#dotnet-api}

Azure services are exposed to .NET developers as one or more [service client](#dotnet-client) types and a set of [supporting types](#supporting-types).  The supporting types may include various [subclients](#dotnet-subclients), which give structure to the API by organizing groups of related service operations, and [model types](#dotnet-model-types), which represent resources on the service.

### The Service Client {#dotnet-client}

Service clients are the main starting points for developers calling Azure services with the Azure SDK.  Each client library should have at least one client in its main namespace, so it's easy to discover.  The guidelines in this section describe patterns for the design of a service client.

A service client should have the same shape as this code snippet:

```csharp
namespace Azure.<group>.<service_name> {

    // main service client class
    public class <service_name>Client {

        // simple constructors; don't use default parameters
        public <service_name>Client(<simple_binding_parameters>);
        public <service_name>Client(<simple_binding_parameters>, <service_name>ClientOptions options);

        // 0 or more advanced constructors
        public <service_name>Client(<advanced_binding_parameters>, <service_name>ClientOptions options = default);

        // mocking constructor
        protected <service_name>Client();

        // service methods (synchronous and asynchronous)
        public virtual Task<Response<<model>> <service_operation>Async(<parameters>, CancellationToken cancellationToken = default);
        public virtual Response<model> <service_operation>(<parameters>, CancellationToken cancellationToken = default);

        // other members
    }

    // options for configuring the client
    public class <service_name>ClientOptions : ClientOptions {

    }
}
```

For example, the Application Configuration Service client looks like this code snippet:

```csharp
namespace Azure.Data.Configuration {

    public class ConfigurationClient {

        public ConfigurationClient(string connectionString);
        public ConfigurationClient(string connectionString, ConfigurationClientOptions options);

        protected ConfigurationClient(); // for mocking

        public virtual Task<Response<<ConfigurationSetting>> GetConfigurationSettingAsync(string key, CancellationToken cancellationToken = default);
        public virtual Response<ConfigurationSetting> GetConfigurationSetting(string key, CancellationToken cancellationToken = default);

        // other members
        …
    }

    // options for configuring the client
    public class ConfigurationClientOptions : ClientOptions {
        ...
    }
}
```

You can find the full sources of [here](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/appconfiguration/Azure.Data.AppConfiguration/src/ConfigurationClient.cs).

{% include requirement/MUST id="dotnet-client-naming" %} name service client types with the _Client_ suffix.

For example, the service client for the Application Configuration service is called `ConfigurationClient`.

{% include requirement/MUST id="dotnet-client-location" %} place at least one service client in the root namespace of their corresponding component.

{% include requirement/MUST id="dotnet-client-type" %} make service clients classes (reference types), not structs (value types).

{% include requirement/MUST id="dotnet-client-immutable" %} make service clients immutable.

Client instances are often shared between threads (stored in application statics) and it should be difficult, if not impossible, for one of these threads to affect others.

{% include requirement/MUST id="dotnet-client-namespace" %} see [Namespace Naming](#dotnet-namespace-naming) guidelines for how to choose the namespace for the client types.

#### Service Client Constructors {#dotnet-client-ctor}

{% include requirement/MUST id="dotnet-client-constructor-minimal" %} provide a minimal constructor that takes only the parameters required to connect to the service.

For example, you may use a connection string, or host name and authentication.  It should be easy to start using the client without extensive customization.

```csharp
public class ConfigurationClient {
    public ConfigurationClient(string connectionString);
}
```

{% include requirement/MUSTNOT id="dotnet-client-constructor-no-default-params" %} use default parameters in the simplest constructor.

{% include requirement/MUST id="dotnet-client-constructor-overloads" %} provide constructor overloads that allow specifying additional options such as credentials, a custom HTTP pipeline, or advanced configuration.

Custom pipeline and client-specific configuration are represented by an `options` parameter. The type of the parameter is typically a subclass of ```ClientOptions``` type, shown below.

##### Using ClientOptions {#dotnet-usage-options}

{% include requirement/MUST id="dotnet-http-pipeline-options" %} name subclasses of ```ClientOptions``` by adding _Options_ suffix to the name of the client type the options subclass is configuring.

```csharp
// options for configuring ConfigurationClient
public class ConfigurationClientOptions : ClientOptions {
    ...
}

public class ConfigurationClient {

    public ConfigurationClient(string connectionString, ConfigurationClientOptions options);
    ...
}
```

If the options type can be shared by multiple client types, name it with a more general name, such as `<library_name>ClientOptions`.  For example, the `BlobClientOptions` class can be used by `BlobClient`, `BlobContainerClient`, and `BlobAccountClient`.

{% include requirement/MUSTNOT id="dotnet-options-no-default-constructor" %} have a default constructor on the options type.

Each overload constructor should take at least `version` parameter to specify the service version. See [Versioning](#dotnet-service-version-option) guidelines for details.

For example, the `ConfigurationClient` type and its public constructors look as follows:

```csharp
public class ConfigurationClient {
    public ConfigurationClient(string connectionString);
    public ConfigurationClient(string connectionString, ConfigurationClientOptions options);
    public ConfigurationClient(Uri uri, TokenCredential credential, ConfigurationClientOptions options = default);
}
```

##### Service Versions {#dotnet-service-version-option}

{% include requirement/MUST id="dotnet-versioning-highest-api" %} call the highest supported service API version by default.

{% include requirement/MUST id="dotnet-versioning-select-api-version" %} allow the consumer to explicitly select a supported service API version when instantiating the service client.

Use a constructor parameter called `version` on the client options type.

* The `version` parameter must be the first parameter to all constructor overloads.
* The `version` parameter must be required, and default to the latest supported service version.
* The type of the `version` parameter must be `ServiceVersion`; an enum nested in the options type.
* The `ServiceVersion` enum must use explicit values starting from 1.
* `ServiceVersion` enum value 0 is reserved. When 0 is passed into APIs, ArgumentException should be thrown.

For example, the following is a code snippet from the `ConfigurationClientOptions`:

```csharp
public class ConfigurationClientOptions : ClientOptions {

    public ConfigurationClientOptions(ServiceVersion version = ServiceVersion.V2019_05_09) {
        if (version == default)
            throw new ArgumentException($"The service version {version} is not supported by this library.");
        }
    }

    public enum ServiceVersion {
        V2019_05_09 = 1,
    }
    ...
}
```

{% include note.html content="Third-party reusable libraries shouldn't change behavior without an explicit decision by the developer.  When developing libraries that are based on the Azure SDK, lock the library to a specific service version to avoid changes in behavior." %}

{% include requirement/MUSTNOT id="dotnet-versioning-feature-flags" %} force consumers to test service API versions to check support for a feature.  Use the _tester-doer_ .NET pattern to implement feature flags, or use `Nullable<T>`.

For example, if the client library supports two service versions, only one of which can return batches, the consumer might write the following code:

```csharp
if (client.CanBatch) {
    Response<SettingBatch> response = await client.GetBatch("some_key*");
    Guid? Guid = response.Result.Guid;
} else {
    Response<ConfigurationSetting> response1 = await client.GetAsync("some_key1");
    Response<ConfigurationSetting> response2 = await client.GetAsync("some_key2");
    Response<ConfigurationSetting> response3 = await client.GetAsync("some_key3");
}
```

##### Mocking

{% include requirement/MUST id="dotnet-client-constructor-for-mocking" %} provide protected parameterless constructor for mocking.

```csharp
public class ConfigurationClient {
    protected ConfigurationClient();
}
```

{% include requirement/MUSTNOT id="dotnet-client-constructor-use-params" %} reference virtual properties of the client class as parameters to other methods or constructors within the client constructor. This violates the [.NET Framework Constructor Design] because a field to which a virtual property refers may not be initialized yet, or a mocked virtual property may not be set up yet. Use parameters or local variables instead:

```csharp
public class ConfigurationClient {
    private readonly ConfigurationRestClient _client;
    public ConfigurationClient(string connectionString) {
        ConnectionString = connectionString;
        // Use parameter below instead of the class-defined virtual property.
        _client = new ConfigurationRestClient(connectionString);
    }
    public virtual string ConnectionString { get; }
}
```

In mocks, using the virtual property instead of the parameter requires the property to be mocked to return the value before the constructor is called when the mock is created. In [Moq] this requires using the delegate parameter to create the mock, which may not be an obvious workaround.

See [Support for Mocking](#dotnet-mocking) for details.

#### Subclients {#dotnet-subclients}

There are two categories of clients: _service clients_ and their _subclients_. Service clients can be instantiated and [have the `Client` suffix](#dotnet-client-naming).  Subclients can only be created by calling factory methods on other clients (commonly on service clients) and do not have the client suffix.

As discussed above, the [service client](#dotnet-client) is the entry point to the API for an Azure service -- from it, library users can invoke all operations the service provides and can easily implement the most common scenarios.  Where it will simplify an API's design, groups of service calls can be organized around smaller subclient types.

{% include requirement/MUST id="dotnet-service-client-entry-point" %} use service clients to indicate the starting point(s) for the most common customer scenarios.

{% include requirement/SHOULD id="dotnet-use-subclients" %} use subclients to group operations related to a service resource or functional area to improve API usability.

There are a variety of types of subclients.  These include:

* _Resource Clients_, which group methods bound to a specific resource, along with information about the resource.
* _Operation Group Clients_, which are not bound to a resource but group related operations.  If referring to a specific resource, these would take a resource identifier as a parameter.
* Subclasses of ```Operation<T>```, which manage service calls related to [long running operations](#dotnet-longrunning).
* ```Pageable<T>``` types returned from [paging methods](#dotnet-paging), which manage service calls to retrieve pages of elements in a collection.

For example, in the Azure Container Registry API, a `ContainerRegistryClient` service client provides an entry point for communicating with the service, and a `ContainerRepository` resource client organizes operations related to a specific repository resource:

```C#
public class ContainerRegistryClient {
    // ...
    public virtual ContainerRepository GetRepository(string name);
}
 
public class ContainerRepository {
    protected ContainerRepository();
    public virtual string Name { get; }
    public virtual Response Delete(CancellationToken cancellationToken = default);
    public virtual Response<ContainerRepositoryProperties> GetProperties(CancellationToken cancellationToken = default);
    public virtual Response<ContainerRepositoryProperties> UpdateProperties(ContainerRepositoryProperties value, CancellationToken cancellationToken = default);
    // ...
}
```

`ServiceBusSender` groups operations for sending messages to a specific entity with properties that identify that entity.

```C#
    public class ServiceBusSender {
        protected ServiceBusSender();
        public virtual string EntityPath { get; }
        public virtual Task CancelScheduledMessageAsync(long sequenceNumber, CancellationToken cancellationToken = default);
        public virtual ValueTask<ServiceBusMessageBatch> CreateMessageBatchAsync(CancellationToken cancellationToken = default);
        public virtual Task<long> ScheduleMessageAsync(ServiceBusMessage message, DateTimeOffset scheduledEnqueueTime, CancellationToken cancellationToken = default);
        public virtual Task SendMessageAsync(ServiceBusMessage message, CancellationToken cancellationToken = default);
        // ...
    }
```

{% include requirement/MUST id="dotnet-subclient-factory-methods" %} provide factory methods to create a subclient.

{% include requirement/MAY id="dotnet-subclient-factory-methods-suffix" %} include a suffix the method that creates a subclient, according to the table below:

| Client Type            | Naming Convention  | Factory Method Naming Convention                 |
|------------------------|--------------------|--------------------------------------------------|
| Service Client         | `Client` Suffix    | Get\<client\>Client()                            |
| Resource Client        | No Suffix          | Get\<resource\>()                                |
| Operation Group Client | No Suffix          | Get\<group\>Client()                             |
| [Long Running Operation](#dotnet-longrunning) | `Operation` Suffix | (long LRO) `Start` prefix; (short LRO) no prefix |
| [Pageable](#dotnet-paging)                    | ```Pageable<T>```  | Get\<resource\>s                                 |

{% include requirement/SHOULD id="dotnet-subclient-factory-methods-parameters" %} take a resource identifier as a parameter to the resource client factory method.

{% include requirement/SHOULD id="dotnet-subclient-properties" %} expose resource identifiers as properties on the resource client.

{% include requirement/MAY id="dotnet-subclient-collections" %} place operations on collections of resources a separate subclient to avoid cluttering the parent client with too many methods.

While API usability is the primary reason for subclients, another motivating factor is resource efficiency.  [Clients need to be cached](https://devblogs.microsoft.com/azure-sdk/lifetime-management-and-thread-safety-guarantees-of-azure-sdk-net-clients/), so if the set of client instances is large or unlimited (in case the client takes a scoping parameter, like a hub, or a container), using subclients allows an application to cache the top level client and create instances of subclients on demand.  In addition, if there is an expensive shared resource (e.g. an AMQP connection), subclients are preferred, as they naturally lead to resource sharing.

{% include requirement/SHOULD id="dotnet-service-client-" %} use the `HttpPipeline` that belongs to the type providing the factory method to make network calls to the service from the subclient.  An exception to this might be if subclient needs different pipeline policies than the parent client.

{% include requirement/MUSTNOT id="dotnet-subclient-no-constructor" %} provide a public constructor on a subclient.  Subclients are non-instantiable by design.

{% include requirement/MUST id="dotnet-subclient-mocking" %} provide a protected parameterless constructor on subclients for mocking.

##### Choosing between Service Clients and Subclients {#dotnet-choosing-client-types}

In many cases, an Azure SDK API should contain one service client and zero or more subclients.  Both service clients and subclients have [service methods](#dotnet-client-methods).  Consider adding more than one service client to the API in the following cases:

{% include requirement/MAY id="dotnet-service-client-multiple-target-customers" %} consider providing an additional service client in an API when the service has different common scenarios for multiple target users, such as a service administrator and an end-user of the entities the administrator creates.

For example, the Azure Form Recognizer library provides a `FormRecognizerClient` for application developers to read form fields in their applications, and a `FormTrainingClient` for data scientist customers to train the form recognition models.

{% include requirement/MAY id="dotnet-service-client-advanced-scenarios" %} consider providing an additional service client when a service has advanced scenarios you want to keep separate from the types that support the most common scenarios.  In this case, consider using a `.Specialized` namespace to contain the additional clients.  

For example, the Azure Storage Blobs library provides a `BlockBlobClient` in the `Azure.Storage.Blobs.Specialized` namespace that gives finer grained control of how blobs are uploaded.  For further discussion of designing APIs for advanced scenarios, please see the [.NET Framework Guidelines](https://aka.ms/fxdg3) sections on progressive frameworks and the principle of layered architecture.

{% include requirement/MAY id="dotnet-service-client-direct-resource-urls" %} consider providing an additional service client for a service resource that is commonly referenced with a URL that points to it directly.  This will allow users to instantiate a client directly from the resource endpoint, without needing to parse the URL to obtain the root service endpoint.

{% include requirement/MAY id="dotnet-service-client-resource-hierarchy" %} consider providing additional service clients for each level in a resource hierarchy.  For service clients representing resources in a hierarchy, you should also provide a `<parent>.Get<child>Client(...)` method to retrieve the client for the named child.

For example, the Azure Storage service provides an account that contains zero or more containers, which in turn contain zero or more blobs. The Azure SDK storage library provides service clients for each level: `BlobServiceClient`, `BlobContainerClient`, and `BlobClient`.  

```C#
public class BlobServiceClient {
    // ...
    public virtual BlobContainerClient GetBlobContainerClient(string blobContainerName);
    // ...
}

public class BlobContainerClient {
    // ...
    public virtual BlobClient GetBlobClient(string blobName);
    // ...
}

public class BlobClient {
    // ...
}

```

#### Service Methods {#dotnet-client-methods}

 _Service methods_ are the methods on the client that invoke operations on the service.

Here are the main service methods in the `ConfigurationClient`.  They meet all the guidelines that are discussed below.

```csharp
public class ConfigurationClient {

    public virtual Task<Response<ConfigurationSetting>> AddAsync(ConfigurationSetting setting, CancellationToken cancellationToken = default);
    public virtual Response<ConfigurationSetting> Add(ConfigurationSetting setting, CancellationToken cancellationToken = default);

    public virtual Task<Response<ConfigurationSetting>> SetAsync(ConfigurationSetting setting, CancellationToken cancellationToken = default);
    public virtual Response<ConfigurationSetting> Set(ConfigurationSetting setting, CancellationToken cancellationToken = default);

    public virtual Task<Response<ConfigurationSetting>> GetAsync(string key, SettingFilter filter = default, CancellationToken cancellationToken = default);
    public virtual Response<ConfigurationSetting> Get(string key, SettingFilter filter = default, CancellationToken cancellationToken = default);

    public virtual Task<Response<ConfigurationSetting>> DeleteAsync(string key, SettingFilter filter = default, CancellationToken cancellationToken = default);
    public virtual Response<ConfigurationSetting> Delete(string key, SettingFilter filter = default, CancellationToken cancellationToken = default);
}
```

##### Sync and Async

{% include requirement/MUST id="dotnet-service-methods-sync-and-async" %} provide both asynchronous and synchronous variants for all service methods.

Many developers want to port existing applications to the Cloud. These applications are often synchronous, and the cost of rewriting them to be asynchronous is usually prohibitive. Calling asynchronous APIs from synchronous methods can only be done through a technique called [_sync-over-async_, which can cause deadlocks](https://devblogs.microsoft.com/pfxteam/should-i-expose-synchronous-wrappers-for-asynchronous-methods/).  The Azure SDK provides synchronous APIs to minimize friction when porting existing application to Azure.

{% include requirement/MUST id="dotnet-service-methods-naming" %} ensure that the names of the asynchronous and the synchronous variants differ only by the _Async_ suffix.

##### Naming

Most methods in Azure SDK libraries should be named following the typical .NET method naming conventions. The Azure SDK Design Guidelines add special conventions for methods that access and manipulate server resources.

{% include requirement/SHOULD id="general-client-standardize-verbs" %} use standard verbs for methods that access or manipulate server resources.

<!-- The table data is in yaml format on _data/tables/net_standard_verbs -->
{% assign data = site.data.tables.net_standard_verbs.entries %}
{% include tables/standard_verbs_template.html %}

##### Cancellation

{% include requirement/MUST id="dotnet-service-methods-cancellation" %} ensure all service methods, both asynchronous and synchronous, take an optional `CancellationToken` parameter called _cancellationToken_ or, in case of protocol methods, an optional `RequestContext` parameter called _context_.

The token should be further passed to all calls that take a cancellation token. DO NOT check the token manually, except when running a significant amount of CPU-bound work within the library, e.g. a loop that can take more than a typical network call.

##### Mocking

{% include requirement/MUST id="dotnet-service-methods-virtual" %} make service methods virtual.

Virtual methods are used to support mocking. See [Support for Mocking](#dotnet-mocking) for details.

##### Return Types

{% include requirement/MUST id="dotnet-service-methods-response-sync" %} return `Response<T>` or `Response` from synchronous methods.

`T` represents the content of the response, as described below.

{% include requirement/MUST id="dotnet-service-methods-response-async" %} return `Task<Response<T>>` or `Task<Response>` from asynchronous methods that make network requests.

There are two possible return types from asynchronous methods: `Task` and `ValueTask`. Your code will be doing a network request in the majority of cases.  The `Task` variant is more appropriate for this use case. For more information, see [this blog post](https://devblogs.microsoft.com/dotnet/understanding-the-whys-whats-and-whens-of-valuetask/#user-content-should-every-new-asynchronous-api-return-valuetask--valuetasktresult).

`T` represents the content of the response, as described below.

The `T` can be either an unstructured payload (e.g. bytes of a storage blob) or a _model type_ representing deserialized response content.

{% include requirement/MUST id="dotnet-service-return-unstructured-type" %} use one of the following return types to represent an unstructured payload:

* `System.IO.Stream` - for large payloads
* `byte[]` - for small payloads
* `ReadOnlyMemory<byte>` - for slices of small payloads

{% include requirement/MUST id="dotnet-service-return-model-type" %} return a _model type_ if the content has a schema and can be deserialized.

For more information, see [Model Types](#dotnet-model-types)

##### Thread Safety

{% include requirement/MUST id="dotnet-service-methods-thread-safety" %} be thread-safe. All public members of the client type must be safe to call from multiple threads concurrently.

#### Service Method Parameters {#dotnet-parameters}

Service methods fall into two main groups when it comes to the number and complexity of parameters they accept:

- Service Methods with Simple Inputs, _simple methods_ for short
- Service Methods with Complex Inputs, _complex methods_ for short

_Simple methods_ are methods that take up to six parameters, with most of the parameters being simple BCL primitives. _Complex methods_ are methods that take large number of parameters and typically correspond to REST APIs with complex request payloads.

_Simple methods_ should follow standard [.NET Framework Design Guidelines](https://aka.ms/fxdg3) for parameter list and overload design.

_Complex methods_ should use _option parameter_ to represent the request payload, and consider providing convenience simple overloads for most common scenarios.

```csharp
public class BlobContainerClient {

    // simple service method
    public virtual Response<BlobInfo> UploadBlob(string blobName, Stream content, CancellationToken cancellationToken = default);

    // complex service method
    public virtual Response<BlobInfo> CreateBlob(BlobCreateOptions options = null, CancellationToken cancellationToken = default);

    // convinience overload[s]
    public virtual Response<BlobContainerInfo> CreateBlob(string blobName, CancellationToken cancellationToken = default);
}

public class BlobCreateOptions {
    public PublicAccessType Access { get; set; }
    public IDictionary<string, string> Metadata { get; }
    public BlobContainerEncryptionScopeOptions Encryption { get; set; }
    ...
}
```

The _Options_ class is designed similarly to .NET custom attributes, where required service method parameters are modeled as _Options_ class constructor parameters and get-only properties, and optional parameters are get-set properties.

{% include requirement/MUST id="dotnet-params-complex-methods" %} use the _options_ parameter pattern for complex service methods.

{% include requirement/MAY id="dotnet-params-growing-methods" %} use the _options_ parameter pattern for simple service methods that you expect to `grow` in the future.

{% include requirement/MAY id="dotnet-params-simple-overloads" %} add simple overloads of methods using the _options_ parameter pattern.

If in common scenarios, users are likely to pass just a small subset of what the _options_ parameter represents, consider adding an overload with a parameter list representing just this subset.

```csharp
    // main overload taking the options property bag
    public virtual Response<BlobInfo> CreateBlob(BlobCreateOptions options = null, CancellationToken cancellationToken = default);

    // simple overload with a subset of parameters of the options bag
    public virtual Response<BlobContainerInfo> CreateBlob(string blobName, CancellationToken cancellationToken = default);
}
```

{% include requirement/MAY id="dotnet-params-options" %} name the _option parameter_ type with the 'Options' suffix.

##### Parameter Validation

Service methods take two kinds of parameters: _service parameters_ and _client parameters_. _Service parameters_ are sent across the wire to the service as URL segments, query parameters, request header values, and request bodies (typically JSON or XML).  _Client parameters_ are used solely within the client library and are not sent to the service; examples are path parameters, CancellationTokens or file paths.

{% include requirement/MUST id="dotnet-params-client-validation" %} validate client parameters.

{% include requirement/MUSTNOT id="dotnet-params-service-validation" %} validate service parameters.

Common parameter validations include null checks, empty string checks, and range checks. Let the service validate its parameters.

{% include requirement/MUST id="dotnet-params-test-devex" %} test the developer experience when invalid service parameters are passed in. Ensure clear error messages are generated by the client. If the developer experience is inadequate, work with the service team to correct the problem.

#### Methods Returning Collections (Paging) {#dotnet-paging}

Many Azure REST APIs return collections of data in batches or pages. A client library will expose such APIs as special enumerable types ```Pageable<T>``` or ```AsyncPageable<T>```.
These types are located in the ```Azure.Core``` package.

For example, the configuration service returns collections of items as follows:

```csharp
public class ConfigurationClient {

    // asynchronous API returning a collection of items
    public virtual AsyncPageable<Response<ConfigurationSetting>> GetConfigurationSettingsAsync(...);

    // synchronous variant of the method above
    public virtual Pageable<ConfigurationSetting> GetConfigurationSettings(...);
    ...
}
```

{% include requirement/MUST id="dotnet-pagination-ienumerable" %} return ```Pageable<T>``` or ```AsyncPageable<T>``` from service methods that return a collection of items.

#### Methods Invoking Long Running Operations {#dotnet-longrunning}

Some service operations, known as _Long Running Operations_ or _LROs_ take a long time (up to hours or days). Such operations do not return their result immediately, but rather are started, their progress is polled, and finally the result of the operation is retrieved.

Azure.Core library exposes an abstract type called ```Operation<T>```, which represents such LROs and supports operations for polling and waiting for status changes, and retrieving the final operation result.  A service method invoking a long running operation will return a subclass of `Operation<T>`, as shown below.

Note that some older libraries use a slightly different, older LRO pattern. In the old pattern, LRO methods started with the prefix 'Start' and did not take the ```WaitUntil``` parameter. Such libraries are free to continue using this older pattern, or they can transition to the new pattern.

```csharp
// the following type is located in Azure.Core
public abstract class Operation<T> : Operation {

    public abstract bool HasCompleted { get; }
    public abstract bool HasValue { get; }

    public abstract string Id { get; }

    public abstract T Value { get; } // throws if CachedStatus != Succeeded
    public abstract Response GetRawResponse();

    public abstract Response UpdateStatus(CancellationToken cancellationToken = default);
    public abstract ValueTask<Response> UpdateStatusAsync(CancellationToken cancellationToken = default);

    public virtual Response<T> WaitForCompletion(CancellationToken cancellationToken = default);
    public virtual Response<T> WaitForCompletion(TimeSpan pollingInterval, CancellationToken cancellationToken);	
    public virtual ValueTask<Response<T>> WaitForCompletionAsync(CancellationToken cancellationToken = default);	
    public virtual ValueTask<Response<T>> WaitForCompletionAsync(TimeSpan pollingInterval, CancellationToken cancellationToken = default);

    // inherited  members returning untyped responses
    public virtual Response WaitForCompletionResponse(CancellationToken cancellationToken = default);	
    public virtual Response WaitForCompletionResponse(TimeSpan pollingInterval, CancellationToken cancellationToken = default);	
    public virtual ValueTask<Response> WaitForCompletionResponseAsync(CancellationToken cancellationToken = default);	
    public virtual ValueTask<Response> WaitForCompletionResponseAsync(TimeSpan pollingInterval, CancellationToken cancellationToken = default);
}
```

Client libraries need to inherit from ```Operation<T>``` not only to implement all abstract members, but also to provide a constructor required to access an existing LRO (an LRO initiated by a different process).

```csharp
public class CopyFromUriOperation : Operation<long> {
    public CopyFromUriOperation(string id, BlobBaseClient client);
    ...
}

public class BlobBaseClient {

    public virtual CopyFromUriOperation CopyFromUri(WaitUntil wait, ..., CancellationToken cancellationToken = default);
    public virtual Task<CopyFromUriOperation> CopyFromUriAsync(WaitUntil wait, ..., CancellationToken cancellationToken = default);
}
```

The following code snippet shows how an SDK consumer would use the `Operation` to poll for a response.

```csharp
BlobBaseClient client = ...

// automatic polling
{
    Operation<long> operation = await client.CopyFromUri(WaitUntil.Completed, ...);
    Console.WriteLine(operation.Value);
}

// manual polling
{
    CopyFromUriOperation operation = await client.CopyFromUriAsync(WaitUntil.Started, ...);
    while (true)
    {
        await operation.UpdateStatusAsync();
        if (operation.HasCompleted) break;
        await Task.Delay(1000); // play some elevator music
    }
    if (operation.HasValue) Console.WriteLine(operation.Value);
}

// saving operation ID
{
    CopyFromUriOperation operation = await client.CopyFromUriAsync(WaitUntil.Started, ...);
    string operationId = operation.Id;

    // two days later
    var operation2 = new CopyFromUriOperation(operationId, client);
    long value = await operation2.WaitForCompletionAsync();
}
```

{% include requirement/MUST id="dotnet-lro-return" %} return a subclass of ```Operation<T>``` from LRO methods.

{% include requirement/MUST id="dotnet-lro-waituntil" %} take ```WaitUntil``` as the first parameter to LRO methods.

{% include requirement/MUST id="dotnet-lro-subclass-operations" %} put methods that cannot be called until after the long-running operation has started on the subclass of ```Operation<T>```.  For example, if a service provides an API to cancel an operation, the ```Cancel``` method should appear on the subclass of ```Operation```.

{% include requirement/MAY id="dotnet-lro-subclass" %} add additional APIs to subclasses of ```Operation<T>```.
For example, some subclasses add a constructor allowing to create an operation instance from a previously saved operation ID.  Some service operations have intermediate states they pass through prior to completion.  These can be represented with an added ```Status``` property to augment the ```HasCompleted``` property on the base ```Operation``` type.

{% include requirement/MUST id="dotnet-lro-constructor" %} provide a public constructor on subclasses of ```Operation<T>``` to allow users to access an existing LRO.

{% include requirement/MUST id="dotnet-lro-constructor-for-mocking" %} provide protected parameterless constructor for mocking in subclasses of ```Operation<T>```.

```csharp
public class CopyFromUriOperation {
    protected CopyFromUriOperation();
}
```

{% include requirement/MUST id="dotnet-lro-mocking-properties" %} make all properties virtual to allow mocking.

```csharp
public class CopyFromUriOperation {
    public virtual Uri SourceUri { get; }
}
```

##### Conditional Request Methods

Some services support conditional requests that are used to implement optimistic concurrency control. In Azure, optimistic concurency is typically implemented using `If-Match` headers and ETags. See [Managing Concurrency in Blob Storage](https://learn.microsoft.com/azure/storage/blobs/concurrency-manage?tabs=dotnet) as a good example.

{% include requirement/MUST id="dotnet-conditional-etag" %} use Azure.Core ETag to represent ETags.

{% include requirement/MAY id="dotnet-conditional-matchcondition" %} take [MatchConditions](https://learn.microsoft.com/dotnet/api/azure.matchconditions?view=azure-dotnet), [RequestConditions](https://learn.microsoft.com/dotnet/api/azure.requestconditions?view=azure-dotnet), (or a custom subclass) as a parameter to conditional service call methods.

TODO: more guidelines comming. see https://github.com/Azure/azure-sdk/issues/2154

### Supporting Types

In addition to service client types, Azure SDK APIs provide and use other supporting types as well.

#### Model Types {#dotnet-model-types}

This section describes guidelines for the design _model types_ and all their transitive closure of public dependencies (i.e. the _model graph_).  A model type is a representation of a REST service's resource.

For example, review the configuration service _model type_ below:

```csharp
public sealed class ConfigurationSetting : IEquatable<ConfigurationSetting> {

    public ConfigurationSetting(string key, string value, string label = default);

    public string ContentType { get; set; }
    public string ETag { get; internal set; }
    public string Key { get; set; }
    public string Label { get; set; }
    public DateTimeOffset LastModified { get; internal set; }
    public bool Locked { get; internal set; }
    public IDictionary<string, string> Tags { get; }
    public string Value { get; set; }

    public bool Equals(ConfigurationSetting other);

    [EditorBrowsable(EditorBrowsableState.Never)]
    public override bool Equals(object obj);
    [EditorBrowsable(EditorBrowsableState.Never)]
    public override int GetHashCode();
    [EditorBrowsable(EditorBrowsableState.Never)]
    public override string ToString();
}
```

This model is returned from service methods as follows:

```csharp
public class ConfigurationClient {
    public virtual Task<Response<ConfigurationSetting>> GetAsync(...);
    public virtual Response<ConfigurationSetting> Get(...);
    ...
}
```

{% include requirement/MUST id="dotnet-service-return-model-public-getters" %} ensure model public properties are get-only if they aren't intended to be changed by the user.

Most output-only models can be fully read-only. Models that are used as both outputs and inputs (i.e. received from and sent to the service) typically have a mixture of read-only and read-write properties.

For example, the `Locked` property of `ConfigurationSetting` is controlled by the service.  It shouldn't be changed by the user.  The `ContentType` property, by contrast, can be modified by the user.

```csharp
public sealed class ConfigurationSetting : IEquatable<ConfigurationSetting> {

    public string ContentType { get; set; }

    public bool Locked { get; internal set; }
}
```

Ensure you include an internal setter to allow for deserialization.  For more information, see [JSON Serialization](implementation.md#dotnet-usage-json).

{% include requirement/MUST id="dotnet-service-models-prefer-structs" %} ensure model types are structs, if they meet the criteria for being structs.

Good candidates for struct are types that are small and immutable, especially if they are often stored in arrays. See [.NET Framework Design Guidelines](https://aka.ms/fxdg3) for details.

{% include requirement/SHOULD id="dotnet-service-models-basic-data-interfaces" %} implement basic data type interfaces on model types, per [.NET Framework Design Guidelines](https://aka.ms/fxdg3).

For example, implement `IEquatable<T>`, `IComparable<T>`, `IEnumerable<T>`, etc. if applicable.

{% include requirement/SHOULD id="dotnet-service-return-model-collections" %} use the following collection types for properties of model types:

- ```IReadOnlyList<T>``` and ```IList<T>``` for most collections
- ```IReadOnlyDictionary<T>``` and ```IDictionary<T>``` for lookup tables
- ```T[]```, ```Memory<T>```, and ```ReadOnlyMemory<T>``` when low allocations and performance are critical

Note that this guidance does not apply to input parameters. Input parameters representing collections should follow standard [.NET Framework Design Guidelines](https://aka.ms/fxdg3), e.g. use ```IEnumerable<T>``` is allowed.
Also, this guidance does not apply to return types of service method calls. These should be using ```Pageable<T>``` and ```AsyncPageable<T>``` discussed in [Methods Returning Collections](#dotnet-paging).

{% include requirement/MAY id="dotnet-service-models-namespace" %} place output model types in _.Models_ subnamespace to avoid cluttering the main namespace with too many types.

It is important for the main namespace of a client library to be clutter free. Some client libraries have a relatively small number of model types, and these should keep the model types in the main namespace. For example, model types of `Azure.Data.AppConfiguration` package are in the main namespace. On the other hand, model types of `Azure.Storage.Blobs` package are in _.Models_ subnamespace.

```csharp
namespace Azure.Storage.Blobs {
    public class BlobClient { ... }
    public class BlobClientOptions { ... }
    ...
}
namespace Azure.Storage.Blobs.Models {
    ...
    public class BlobContainerItem { ... }
    public class BlobContainerProperties { ...}
    ...
}
```

{% include requirement/SHOULD id="dotnet-service-editor-browsable-state" %} apply the `[EditorBrowsable(EditorBrowsableState.Never)]` attribute to methods on the model type that the user isn't meant to call.

Adding this attribute will hide the methods from being shown with IntelliSense.  A user will almost never call `GetHashCode()` directly.  `Equals(object)` is almost never called if the type implements `IEquatable<T>` (which is preferred).  Hide the `ToString()` method if it isn't overridden.

```csharp
public sealed class ConfigurationSetting : IEquatable<ConfigurationSetting> {
    [EditorBrowsable(EditorBrowsableState.Never)]
    public override bool Equals(object obj);
    [EditorBrowsable(EditorBrowsableState.Never)]
    public override int GetHashCode();
}
```

{% include note.html content="Unlike service clients, model types aren't required to be thread-safe, as they're rarely shared between threads." %}

{% include requirement/MUST id="dotnet-models-in-mocks" %} ensure all model types can be used in mocks.

In practice, you need to provide public APIs to construct _model graphs_. See [Support for Mocking](#dotnet-mocking) for details.

##### Model Type Naming

TODO: issue #2298

#### Enumerations

{% include requirement/MUST id="dotnet-enums" %} use an `enum` for parameters, properties, and return types when values are known.

{% include requirement/MAY id="dotnet-enums-exception" %} use a `readonly struct` in place of an `enum` that declares well-known fields but can contain unknown values returned from the service, or user-defined values passed to the service.

See [enumeration-like structure documentation](implementation.md#dotnet-enums) for implementation details.

#### Using Azure Core Types {#dotnet-commontypes}

The `Azure.Core` package provides common functionality for client libraries.  Documentation and usage examples can be found in the [azure/azure-sdk-for-net](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/core/Azure.Core) repository.

#### Using Primitive Types

{% include requirement/MUST id="dotnet-primitives-etag" %} use `Azure.ETag` to represent ETags.

The `Azure.ETag` type is located in `Azure.Core` package.

{% include requirement/MUST id="dotnet-primitives-uri" %} use `System.Uri` to represent URIs.

### Exceptions {#dotnet-errors}

In .NET, throwing exceptions is how we communicate to library consumers that the services returned an error.

{% include requirement/MUST id="dotnet-errors-response-failed" %} throw `RequestFailedException` or its subtype when a service method fails with non-success status code.

The exception is available in ```Azure.Core``` package:

```csharp
public class RequestFailedException : Exception {

    public RequestFailedException(Response response);
    public RequestFailedException(Response response, Exception innerException);
    public RequestFailedException(Response response, Exception innerException, RequestFailedDetailsParser detailsParser);

    public int Status { get; }
}
```

The exception message will be formed from the passed in `Response` content. For example:

```csharp
if (response.Status != 200) {
    throw new RequestFailedException(response);
}
```

{% include requirement/MUST id="dotnet-errors-use-response-failed-when-possible" %} use `RequestFailedException` or one of its subtypes where possible.

{% include requirement/MUST id="dotnet-request-failed-details-parser" %} provide `RequestFailedDetailsParser` for non-standard error formats.

If customization is required to parse the response content, e.g. because the service does not adhere to the standard error format as represented by the `ResponseError` type, libraries can must implement a `RequestFailedDetailsParser` and pass the parser into the construction of the `HttpPipeline` via the `HttpPipelineOptions` type. If more granular control is required than associating the parser per pipeline, there is a constructor of `RequestFailedException` that takes a `RequestFailedDetailsParser` that may be used.

Don't introduce new exception types unless there's a programmatic scenario for handling the new exception that's different than `RequestFailedException`

### Authentication {#dotnet-authentication}

The client library consumer should construct a service client using just the constructor.  After construction, service methods can successfully invoke service operations.  The constructor parameters must take all parameters required to create a functioning client, including all information needed to authenticate with the service.

The general constructor pattern refers to _binding parameters_.

```csharp
// simple constructors
public <service_name>Client(<simple_binding_parameters>);
public <service_name>Client(<simple_binding_parameters>, <service_name>ClientOptions options);

// 0 or more advanced constructors
public <service_name>Client(<advanced_binding_parameters>, <service_name>ClientOptions options = default);
```

Typically, _binding parameters_ would include a URI to the service endpoint and authorization credentials. For example, the blob service client can be bound using any of:

* a connection string (which contains both endpoint information and credentials),
* an endpoint (for anonymous access),
* an endpoint and credentials (for authenticated access).

```csharp
// hello world constructors using the main authentication method on the service's Azure Portal (typically a connection string)
// we don't want to use default parameters here; all other overloads can use default parameters
public BlobServiceClient(string connectionString)
public BlobServiceClient(string connectionString, BlobClientOptions options)

// anonymous access
public BlobServiceClient(Uri uri, BlobClientOptions options = default)

// using credential types
public BlobServiceClient(Uri uri, StorageSharedKeyCredential credential, BlobClientOptions options = default)
public BlobServiceClient(Uri uri, TokenCredential credential, BlobClientOptions options = default)
```

{% include requirement/SHOULD id="dotnet-auth-azure-core" %} use credential types provided in the `Azure.Core` package.

Currently, `Azure.Core` provides `TokenCredential` for OAuth style tokens, including MSI credentials.

{% include requirement/MUST id="dotnet-auth-rolling-credentials" %} support changing credentials without having to create a new client instance.

Credentials passed to the constructors must be read before every request (for example, by calling `TokenCredential.GetToken()`).

{% include requirement/MUST id="dotnet-auth-arch-review" %} contact [adparch] if you want to add a new credential type.

{% include requirement/MAY id="dotnet-auth-connection-strings" %} offer a way to create credentials from a connection string only if the service offers a connection string via the Azure portal.

Don't ask users to compose connection strings manually if they aren't available through the Azure portal. Connection strings are immutable.  It's impossible for an application to roll over credentials when using connection strings.

### Namespaces {#dotnet-namespace-naming}

{% include requirement/MUST id="dotnet-namespaces-naming" %} adhere to the following scheme when choosing a namespace: `Azure.<group>.<service>[.<feature>]`

For example, `Azure.Storage.Blobs`.

{% include requirement/MUST id="dotnet-namespaces-approved-list" %} use one of the following pre-approved namespace groups:

- `Azure.AI` for artificial intelligence, including machine learning
- `Azure.Analytics` for client libraries that gather or process analytics data
- `Azure.Communication` communication services
- `Azure.Core` for libraries that aren't service specific
- `Azure.Cosmos` for object database technologies
- `Azure.Data` for client libraries that handle databases or structured data stores
- `Azure.DigitalTwins` for DigitalTwins related technologies
- `Azure.Identity` for authentication and authorization client libraries
- `Azure.IoT` for client libraries dealing with the Internet of Things.
    - Use `Iot` for Pascal cased compound words, such as `IotClient`, otherwise follow language conventions.
    - Do not use `IoT` more than once in a namespace.
- `Azure.Media` for client libraries that deal with audio, video, or mixed reality
- `Azure.Messaging` for client libraries that provide messaging services, such as push notifications or pub/sub.
- `Azure.Monitor` for observability and Azure Monitor client libraries.
- `Azure.ResourceManager.[ResourceProvider]` for management plane client libraries for a given resource provider.
    - For example the compute management plane namespace would be Azure.ResourceManager.Compute.
- `Azure.Search` for search technologies
- `Azure.Security` for client libraries dealing with security
- `Azure.Storage` for client libraries that handle unstructured data

If you think a new group should be added to the list, contact [adparch].

{% include requirement/MUST id="dotnet-namespaces-registration" %} register all namespaces with [adparch].

{% include requirement/MUSTNOT id="dotnet-namespaces-location" %} place APIs in the second-level namespace (directly under the `Azure` namespace).

{% include requirement/SHOULD id="dotnet-namespaces-models" %} consider placing model types in a `.Models` namespace if number of model types is or might become large.

See [model type guidelines](#dotnet-service-models-namespace) for details.

### Support for Mocking {#dotnet-mocking}

All client libraries must support mocking to enable non-live testing of service clients by customers.

Here is an example of how the `ConfigurationClient` can be mocked using [Moq] (a popular .NET mocking library):

```csharp
// Create a mock response
var mockResponse = new Mock<Response>();
// Create a client mock
var mock = new Mock<ConfigurationClient>();
// Setup client method
mock.Setup(c => c.Get("Key", It.IsAny<string>(), It.IsAny<DateTimeOffset>(), It.IsAny<CancellationToken>()))
    .Returns(new Response<ConfigurationSetting>(mockResponse.Object, ConfigurationModelFactory.ConfigurationSetting("Key", "Value")));

// Use the client mock
ConfigurationClient client = mock.Object;
ConfigurationSetting setting = client.Get("Key");
Assert.AreEqual("Value", setting.Value);
```

For more details on mocking, see [Unit testing and mocking with the Azure SDK for .NET](https://learn.microsoft.com/dotnet/azure/sdk/unit-testing-mocking).

{% include requirement/MUST id="dotnet-mocking-constructor" %} provide protected parameterless constructor for mocking.

{% include requirement/MUST id="dotnet-mocking-virtual-method" %} make all service methods virtual.

{% include requirement/MUST id="dotnet-mocking-virtual-properties" %} make all properties virtual.

```csharp
    public class BlobContainerClient {
        public virtual string Name { get; }
        public virtual Uri Uri { get; }
    }
```

{% include requirement/MUST id="dotnet-mocking-virtual-getclient-method" %} make methods returning other clients virtual.

```csharp
public class BlobContainerClient
{
    public virtual BlobClient GetBlobClient();
}
```

{% include requirement/MUST id="dotnet-mocking-extensions" %} use instance methods instead of extension methods when defined in the same assembly. The instance methods are simpler to mock.

```csharp
public class BlobContainerClient
{
    // This method is possible to mock
    public virtual AppendBlobClient GetAppendBlobClient() {}
}

public class BlobContainerClientExtensions
{
    // This method is impossible to mock
    public static AppendBlobClient GetAppendBlobClient(this BlobContainerClient containerClient) {}
}
```

{% include requirement/MUST id="dotnet-mocking-factory-builder" %} provide factory or builder for constructing model graphs returned from virtual service methods.

Model types shouldn't have public constructors.  Instances of the model are typically returned from the client library, and are not constructed by the consumer of the library.  Mock implementations need to create instances of model types.  Implement a static class called `<service>ModelFactory` in the same namespace as the model types:

```csharp
public static class ConfigurationModelFactory {
    public static ConfigurationSetting ConfigurationSetting(string key, string value, string label=default, string contentType=default, ETag eTag=default, DateTimeOffset? lastModified=default, bool? locked=default);
    public static SettingBatch SettingBatch(ConfigurationSetting[] settings, string link, SettingSelector selector);
}
```

{% include requirement/MUST id="dotnet-mocking-factory-builder-methods" %} hide older overloads and avoid ambiguity.

When read-only properties are added to models and factory methods must be added to optionally set these properties,
you must hide the previous method and remove all default parameter values to avoid ambiguity:

```csharp
public static class ConfigurationModelFactory {
    [EditorBrowsable(EditorBrowsableState.Never)]
    public static ConfigurationSetting ConfigurationSetting(string key, string value, string label, string contentType, ETag eTag, DateTimeOffset? lastModified, bool? locked) =>
        ConfigurationSetting(key, value, label, contentType, eTag, lastModified, locked, default);
    public static ConfigurationSetting ConfigurationSetting(string key, string value, string label=default, string contentType=default, ETag eTag=default, DateTimeOffset? lastModified=default, bool? locked=default, int? ttl=default);
}
```

## Azure SDK Library Design

### Packaging {#dotnet-packaging}

{% include requirement/MUST id="dotnet-packaging-nuget" %} package all components as NuGet packages.

If your client library is built by the Azure SDK engineering systems, all packaging requirements will be met automatically. Follow the [.NET packaging guidelines](https://learn.microsoft.com/dotnet/standard/library-guidance/nuget) if you're self-publishing. For Microsoft-owned packages, we need to support both Windows (for Windows dump diagnostics) and portable (for cross-platform debugging) pdb formats. This means you need to publish them to the Microsoft symbol server and not the NuGet symbol server which only supports portable pdbs.

{% include requirement/MUST id="dotnet-packaging-naming" %} name the package based on the name of the main namespace of the component.

For example, if the component is in the `Azure.Storage.Blobs` namespace, the component DLL will be `Azure.Storage.Blobs.dll` and the NuGet package will be `Azure.Storage.Blobs`.

{% include requirement/SHOULD id="dotnet-packaging-granularity" %} place small related components that evolve together in a single NuGet package.

### Versioning {#dotnet-versioning}

#### Client Versions

{% include requirement/MUST id="dotnet-versioning-backwards-compatibility" %} be 100% backwards compatible with older versions of the same package.

For detailed rules, see [.NET Breaking Changes](https://github.com/dotnet/runtime/blob/master/docs/coding-guidelines/breaking-change-rules.md).

{% include requirement/MUST id="dotnet-versioning-new-package" %} introduce a new package (with new assembly names, new namespace names, and new type names) if you must do an API breaking change.

Breaking changes should happen rarely, if ever.  Register your intent to do a breaking change with [adparch]. You'll need to have a discussion with the language architect before approval.

#### Package Version Numbers {#dotnet-versionnumbers}

Consistent version number scheme allows consumers to determine what to expect from a new version of the library.

{% include requirement/MUST id="dotnet-version-semver" %} use _MAJOR_._MINOR_._PATCH_ format for the version of the library `.dll` and the NuGet package.

Use _-beta._N_ suffix for beta package versions. For example, _1.0.0-beta.2_.

{% include requirement/MUST id="dotnet-version-change-on-release" %} change the version number of the client library when **ANYTHING** changes in the client library.

{% include requirement/MUST id="dotnet-version-patching" %} increment the patch version when fixing a bug.

{% include requirement/MUSTNOT id="dotnet-version-features-in-patch" %} include new APIs in a patch release.

{% include requirement/MUST id="dotnet-version-add-feature" %} increment the major or minor version when adding support for a service API version.

{% include requirement/MUST id="dotnet-version-add-api" %} increment the major or minor version when adding a new method to the public API.

{% include requirement/SHOULD id="dotnet-version-major-changes" %} increment the major version when making large feature changes.

{% include requirement/MUST id="dotnet-version-change-from-track-1" %} select a version number greater than the highest version number of any other released Track 1 package for the service in any other scope or language.

### Target Frameworks

All Azure SDK libraries must include a target for [.NET Standard 2.0]. This ensures that they are compatible with all supported versions of .NET, covering both modern .NET and the .NET Framework.  

Libraries built by the Azure SDK engineering system will also target the oldest supported [long term support (LTS)] version of .NET. This enables them to take advantage of modern runtime features, allows applications to fully benefit from modern runtimes, and obviates the need for applications to download polyfill shim packages for functionality already built-into modern runtimes. It is strongly encouraged that self-published libraries also include this target framework.

For projects built by the Azure SDK engineering system, use the following target setting in the `.csproj` file:

```xml
<TargetFrameworks>$(RequiredTargetFrameworks)</TargetFrameworks>
```

{% include requirement/MUST id="dotnet-build-net-standard" %} build all libraries for [.NET Standard 2.0].

If not building with the Azure SDK engineering system, use the following target setting in the `.csproj` file:

```xml
<TargetFrameworks>netstandard2.0</TargetFrameworks>
```

{% include requirement/SHOULD id="dotnet-build-net-oldest-lts" %} build libraries for the oldest supported LTS version of .NET.

For example, if the oldest supported LTS version of .NET is `8.0`, use the following target setting in the `.csproj` file if not building with the Azure SDK engineering system:

```xml
<TargetFrameworks>netstandard2.0;net8.0</TargetFrameworks>
```

{% include requirement/MUST id="dotnet-build-multi-targeting-api" %} define the same APIs for all [target framework monikers (TFMs)][.NET Target Framework Monikers].

The public API of client libraries must be the same for all targets including class, interface, parameter, and return types.

{% include requirement/MUST id="dotnet-specialtfm-approval" %} engage the [Architecture Board] if your client library has special needs for targeting additional frameworks or is unable to target the required set.

#### Target Framework Retirement

When a new [long term support (LTS)] version of .NET is released and the previous version retired, Azure SDK libraries will add the new LTS target. Libraries will continue to target the previous LTS package for 6 months after it has reached end-of-life to minimize the impact to developers and allow time for migration. After that transition period, Azure SDK libraries will no longer target the retired LTS.  

After 6 months, the retired LTS will be removed from the target frameworks. Because the `netstandard2.0` target will always be present, removal of the target should not break applications still using an unsupported runtime as they will fall back to the standard target. They will, however, gain a dependency on polyfill packages and lose performance improvements specific to modern runtimes. It is possible that the fallback will introduce an unintended break, but this risk is implicitly assumed by the application as they have chosen to rely on a runtime no longer supported by Microsoft.

### Dependencies {#dotnet-dependencies}

{% include requirement/SHOULD id="dotnet-dependencies-minimize" %} minimize dependencies outside of the .NET Standard and `Azure.Core` packages.

{% include requirement/MUSTNOT id="dotnet-dependencies-list" %} depend on any NuGet package except the following:

* `Azure.*` packages from the [azure/azure-sdk-for-net] repository.
* `System.*` packages published by the Microsoft .NET team.
* `Microsoft.*` packages approved by the [Architecture Board]. 
* Third-party packages explicitly approved by the [Architecture Board] for specific scenarios with special needs.
* Packages produced by your own team.

In the past, [JSON.NET](https://www.newtonsoft.com/json), aka Newtonsoft.Json, was commonly used for serialization and deserialization. Use the [System.Text.Json](https://www.nuget.org/packages/System.Text.Json/)
package that is now a part of the .NET platform instead. If you are using `Azure.Core`, there is no need for a direct reference to the `System.Text.Json` package. Your client library will have access to it automatically.

{% include requirement/MUSTNOT id="dotnet-dependencies-exposing" %} publicly expose types from dependencies unless the types follow these guidelines as well.

#### Package Dependency Versions

For libraries using the Azure SDK for .NET repository, dependency versions are [managed centrally](https://github.com/Azure/azure-sdk-for-net/blob/main/eng/Packages.Data.props) and will automatically be applied to your library as part of the Azure SDK engineering system builds.

{% include requirement/MUST id="dotnet-runtime-package-versions" %} align versions of Microsoft [.NET runtime libraries] with the oldest supported [long term support (LTS)] version of .NET. For example, if the oldest supported LTS version of .NET is `8.0`, references to runtime libraries such as `System.Text.Json` should target the minor and patch version with a major version of `8`.

{% include requirement/MUST id="dotnet-dependency-supported-versions" %} ensure all dependencies reference a version supported by the publisher that is not marked as deprecated or flagged by NuGet for vulnerabilities. 

{% include requirement/MUST id="dotnet-dependency-compatibile-versions" %} consider all platforms that your library will run on and ensure dependencies/versions are compatible. For example, the Azure Functions host and Azure PowerShell have explicit version requirements for dependencies shared between the host and applications.  _(see: [Packages.Data.props](https://github.com/Azure/azure-sdk-for-net/blob/main/eng/Packages.Data.props#L57-L83) for more information.)_

#### Common Libraries

There are occasions when common code needs to be shared between several client libraries. For example, a set of cooperating client libraries may wish to share a set of exceptions or models.

{% include requirement/MUST id="dotnet-commonlib-approval" %} engage the [Architecture Board] to discuss how to design such common library.

#### .NET Runtime Polyfill Packages

To ensure consistency across runtimes, the Microsoft .NET team publishes polyfill packages on NuGet for some features built into modern .NET runtimes. On runtimes where these features are missing, such as .NET Framework, the polyfill packages provide them. On runtimes where the features are natively available, the polyfill packages pass through the calls and do nothing.
 
{% include requirement/SHOULD id="dotnet-trim-polyfills" %} reference the .NET runtime polyfill packages only for `netstandard2.0` and legacy target frameworks. For libraries using the Azure SDK for .NET repository, these dependencies are automatically trimmed from your library for modern target frameworks as part of the Azure SDK engineering system builds.

Some commonly used examples of .NET runtime polyfill packages are:
- `Microsoft.Bcl.AsyncInterfaces`
- `System.Buffers`
- `System.Diagnostics.DiagnosticSource`
- `System.Net.Http`
- `System.Numerics.Vectors`
- `System.Text.Encodings.Web`
- `System.Text.Json`
- `System.Threading.Channels`
- `System.Threading.Tasks.Extensions`

### Native Code

Native dependencies introduce lots of complexities to .NET libraries and so they should be avoided.

{% include requirement/SHOULDNOT id="dotnet-problems-native-dependencies" %} have native dependencies.

### Documentation Comments {#dotnet-documentation}

{% include requirement/MUST id="dotnet-docs-document-everything" %} document every exposed (public or protected) type and member within your library's code.

{% include requirement/MUST id="dotnet-docs-docstrings" %} use [C# documentation comments](https://learn.microsoft.com/dotnet/csharp/language-reference/language-specification/documentation-comments) for reference documentation.

See the [documentation guidelines]({{ site.baseurl }}/general_documentation.html) for language-independent guidelines for how to provide good documentation.

## Repository Guidelines {#dotnet-repository}

{% include requirement/MUST id="dotnet-general-repository" %} locate all source code and README in the [azure/azure-sdk-for-net] GitHub repository.

{% include requirement/MUST id="dotnet-general-engsys" %} follow Azure SDK engineering systems guidelines for working in the [azure/azure-sdk-for-net] GitHub repository.

### Documentation Style

TODO: issue #2338

### README {#dotnet-repository-readme}

{% include requirement/MUST id="dotnet-docs-readme" %} have a README.md file in the component root folder.

An example of a good `README.md` file can be found [here](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/appconfiguration/Azure.Data.AppConfiguration/README.md).

{% include requirement/MUST id="dotnet-docs-readme-consumer" %} optimize the `README.md` for the consumer of the client library.

The contributor guide (`CONTRIBUTING.md`) should be a separate file linked to from the main component `README.md`.

### Samples {#dotnet-samples}

Each client library should have a quickstart guide with code samples.  Developers like to learn about a library by looking at sample code; not by reading in-depth technology papers.

{% include requirement/MUST id="dotnet-samples-location" %} have usage samples in `samples` subdirectory of main library directory.

For a complete example, see the [Configuration Service samples](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/appconfiguration/Azure.Data.AppConfiguration/samples).

{% include requirement/MUST id="dotnet-samples-readme" %} have a `README.md` file with the following front matter:

```yml
---
page_type: sample
languages:
- csharp
products:
- azure
- azure-app-configuration
name: Azure.Data.AppConfiguration samples for .NET
description: Samples for the Azure.Data.AppConfiguration client library
---
```

The `README.md` file should be written as a getting started guide. See [the ServiceBus README](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/servicebus/Azure.Messaging.ServiceBus/README.md) for a good example.

{% include requirement/MUST id="dotnet-samples-readme-links" %} link to each of the samples files using a brief description as the link text.

{% include requirement/MUST id="dotnet-samples-naming" %} have a sample file called `Sample1_HelloWorld.md`. All other samples are ordered from simplest to most complex using the `Sample<number>_` prefix.

{% include requirement/MUST id="dotnet-sync-samples-naming" %} use synchronous APIs in the `Sample1_HelloWorld.md` sample.  Add a second sample named `Sample1_HelloWorldAsync.md` that does the same thing as `Sample1_HelloWorld.md` using asynchronous code.

{% include requirement/MUST id="dotnet-samples-source-snippets" %} use `#region`s in source with a unique identifier starting with "Snippet:" like `Snippet:AzConfigSample1_CreateConfigurationClient`. This must be unique within the entire repo.

{% include requirement/MUST id="dotnet-samples-snippets" %} C# code fences with the corresponding `#region` name like so:

````markdown
```C# Snippet:AzConfigSample1_CreateConfigurationClient
var client = new ConfigurationClient(connectionString);
```
````

{% include requirement/MUST id="dotnet-samples-build" %} make sure all the samples build and run as part of the CI process.

## Package Publishing

{% include requirement/SHOULDNOT id="dotnet-empty-release" %} publish new package releases just to keep to a regular cadence. Generally, it is recommended that packages only be published when bugs are fixed or new features are added.

{% include requirement/SHOULD id="dotnet-dependency-release" %} publish dependency-only releases when no active work is taking place on the library, but a dependency addressed a vulnerability or the .NET runtime package dependencies have been updated to a new major version.

## Commonly Overlooked .NET API Design Guidelines {#dotnet-appendix-overlookedguidelines}

Some [.NET Framework Design Guidelines](https://aka.ms/fxdg3) have been notoriously overlooked in earlier Azure SDKs. This section serves as a way to highlight these guidelines.

{% include requirement/SHOULDNOT id="dotnet-problems-too-many-types" %} have many types in the main namespace. Number of types is directly proportional to the perceived complexity of a library.

{% include requirement/MUSTNOT id="dotnet-problems-abstractions" %} use abstractions unless the Azure SDK both returns and consumes the abstraction.  An abstraction is either an interface or abstract class.

{% include requirement/MUSTNOT id="dotnet-problems-interfaces" %} use interfaces if you can use abstract classes. The only reasons to use an interface are: a) you need to "multiple-inherit", b) you want structs to implement an abstraction.

{% include requirement/MUSTNOT id="dotnet-problems-generic-words" %} use generic words and terms for type names.  For example, do not use names like `OperationResponse` or `DataCollection`.

{% include requirement/SHOULDNOT id="dotnet-problems-valid-values" %} use parameter types where it's not clear what valid values are supported.  For example, do not use strings but only accept certain values in the string.

{% include requirement/MUSTNOT id="dotnet-problems-empty-types" %} have empty types (types with no members).

<!-- Links -->

{% include refs.md %}
{% include_relative refs.md %}
