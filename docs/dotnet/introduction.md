---
title: "C#.NET Guidelines"
keywords: guidelines dotnet
permalink: dotnet_introduction.html
folder: dotnet
sidebar: dotnet_sidebar
---

## Introduction

The following document describes .NET specific guidelines for designing Azure SDK client libraries. These guidelines complement general [.NET Framework Design Guidelines] with design considerations specific to the Azure SDK. These guidelines also expand on and simplify language-independent [General Azure SDK Guidelines][general-guidelines]. More specific guidelines take precedence over more general guidelines.

Currently, the document describes guidelines for client libraries exposing HTTP/REST services. It may be expanded in the future to cover other, non-REST, services.

We'll use the client library for the [Azure Application Configuration service] to illustrate various design concepts.

## Design Principles {#dotnet-principles}

The main value of the Azure SDK is productivity. Other qualities, such as completeness, extensibility, and performance are important but secondary.  We ensure our customers can be highly productive when using our libraries by ensuring these libraries are:

**Idiomatic**

* Azure SDK libraries follow .NET Framework Design Guidelines.
* Azure SDK libraries feel like designed by the designers of the .NET Standard libraries.
* Azure SDK libraries version just like the .NET Standard libraries.

> We are not trying to fix bad parts of the language ecosystem; we embrace the ecosystem with its strengths and its flaws.

**Consistent**

* The Azure SDK feels like a single product of a single team, not a set of NuGet packages.
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
* Great logging, tracing, and error messages
* Predictable support lifecycle, feature coverage, and quality

## General Guidelines {#dotnet-general}

{% include requirement/MUST id="dotnet-general-follow-framework-guidelines" %} follow the official [.NET Framework Design Guidelines].

At the end of this document, you can find a section with [the most commonly overlooked guidelines](#dotnet-appendix-overlookedguidelines) in existing Azure SDK libraries.

{% include requirement/MUST id="dotnet-general-follow-general-guidelines" %} follow the [General Azure SDK Guidelines][general-guidelines].

The guidelines provide a robust methodology for communicating with Azure services. The easiest way to ensure that your component meets these requirements is to use the [Azure.Core] package to call Azure services. Details of these helper APIs and their usage are described in the [Using HttpPipeline](#dotnet-usage-httppipeline) section.

{% include requirement/MUST id="dotnet-general-use-http-pipeline" %} use `HttpPipeline` to implement all methods that call Azure REST services.

The pipeline can be found in the [Azure.Core] package, and it takes care of many [General Azure SDK Guidelines][general-guidelines]. Details of the pipeline design and usage are described in section [Using HttpPipeline](#dotnet-usage-httppipeline) below. If you can't use the pipeline, you must implement [all the general requirements of Azure SDK]({{ "/general_azurecore.html" | relative_url }}) manually.

# API Design {#dotnet-api}

## Service Client Design {#dotnet-client}

Azure services will be exposed to .NET developers as one or more _service client_ types, and a set of _supporting types_. The guidelines in this section describe patterns for the design of a service client.  A service client should look like this code snippet:

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
    public class <service_name>ClientOptions : HttpPipelineOptions {

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

        public virtual Task<Response<<ConfigurationSetting>> GetAsync(string key, CancellationToken cancellationToken = default);
        public virtual Response<ConfigurationSetting> Get(string key, CancellationToken cancellationToken = default);

        // other members
        …
    }

    // options for configuring the client
    public class ConfigurationClientOptions : HttpPipelineOptions {
        ...
    }
}
```

{% include requirement/MUST id="dotnet-client-naming" %} name service client types with the _Client_ suffix.

For example, the service client for the Application Configuration service is called `ConfigurationClient`.

{% include requirement/MUST id="dotnet-client-location" %} place at least one service client in the root namespace of their corresponding component.

{% include requirement/MUST id="dotnet-client-type" %} make service clients classes (reference types), not structs (value types).

{% include requirement/MUST id="dotnet-client-namespace" %} see [Namespace Naming](#dotnet-namespace-naming) guidelines for how to choose the namespace for the client types.

### Service Client Constructors {#dotnet-client-ctor}

{% include requirement/MUST id="dotnet-client-constructor-minimal" %} provide a minimal constructor that takes only the parameters required to connect to the service.

For example, you may use a connection string, or host name and authentication.  It should be easy to start using the client without extensive customization.

```csharp
public class ConfigurationClient {
    public ConfigurationClient(string connectionString);
}
```

{% include requirement/MUSTNOT id="dotnet-client-constructor-no-default-params" %} use default parameters in the _hello world_ constructor.

{% include requirement/MUST id="dotnet-client-constructor-overloads" %} provide constructor overloads that allow specifying additional options such as credentials, a custom HTTP pipeline, or advanced configuration.

Custom pipeline and client-specific configuration are represented by an `options` parameter. Guidelines for using `HttpPipelineOptions` can be found in [Extending and Using HttpPipelineOptions](#dotnet-usage-options) section below.

For example, the `ConfigurationClient` type and its public constructors look as follows:

```csharp
public class ConfigurationClient {
    public ConfigurationClient(string connectionString);
    public ConfigurationClient(string connectionString, ConfigurationClientOptions options);
    public ConfigurationClient(Uri uri, TokenCredential credential, ConfigurationClientOptions options = default);
}
```

{% include requirement/MUST id="dotnet-client-constructor-for-mocking" %} provide protected parameterless constructor for mocking.

```csharp
public class ConfigurationClient {
    protected ConfigurationClient();
}
```

See [Supporting Mocking](#dotnet-mocking) for details.

### Service Methods {#dotnet-client-methods}

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

{% include requirement/MUST id="dotnet-service-methods-sync-and-async" %} provide both asynchronous and synchronous variants for all service methods.

{% include requirement/MUST id="dotnet-service-methods-naming" %} ensure that the names of the asynchronous and the synchronous variants differ only by the _Async_ suffix.

{% include requirement/MUST id="dotnet-service-methods-cancellation" %} ensure all service methods, both asynchronous and synchronous, take an optional `CancellationToken` parameter called _cancellationToken_.

The token should be passed to all I/O calls.  Don't check the token manually.

{% include requirement/MUST id="dotnet-service-methods-virtual" %} make service methods virtual.

Virtual methods are used to support mocking. See [Supporting Mocking](#dotnet-mocking) for details.

{% include requirement/MUST id="dotnet-service-methods-response-sync" %} return `Response<T>` or `Response` from synchronous methods.

`T` represents the content of the response. For more information, see [Service Method Return Types](#dotnet-method-return).

{% include requirement/MUST id="dotnet-service-methods-response-async" %} return `Task<Response<T>>` or `Task<Response>` from asynchronous methods that make network requests.

There are two possible return types from asynchronous methods: `Task` and `ValueTask`. Your code will be doing a network request in the majority of cases.  The `Task` variant is more appropriate for this use case. For more information, see [this blog post](https://devblogs.microsoft.com/dotnet/understanding-the-whys-whats-and-whens-of-valuetask/#user-content-should-every-new-asynchronous-api-return-valuetask--valuetasktresult).

`T` represents the content of the response. For more information, see [Service Method Return Types](#dotnet-method-return).

{% include requirement/MUST id="dotnet-service-methods-thread-safety" %} be thread-safe. All public members of the client type must be safe to call from multiple threads concurrently.

### Service Method Return Types {#dotnet-method-return}

As mentioned above, service methods will often return `Response<T>`. The `T``can be either an unstructured payload (bytes of a storage blob) or a _model type_ representing deserialized response content. This section describes guidelines for the design of unstructured return types, _model types_, and all their transitive closure of dependencies (the _model graph_).

{% include requirement/MUST id="dotnet-service-return-unstructured-type" %} use one of the following return types to represent an unstructured payload:

* `System.IO.Stream` - for large payloads
* `byte[]` - for small payloads
* `ReadOnlyMemory<byte>` - for slices of small payloads

{% include requirement/MUST id="dotnet-service-return-model-type" %} return a _model type_ if the content has a schema and can be deserialized.

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

For example, the `Locked` property of `ConfigurationSetting` is controlled by the service.  It shouldn't be changed by the user.  The `ContentType` property, by contrast, can be modified by the user.

```csharp
public sealed class ConfigurationSetting : IEquatable<ConfigurationSetting> {

    public string ContentType { get; set; }

    public bool Locked { get; internal set; }
}
```

Ensure you include an internal setter to allow for deserialization.  For more information, see [Serialization](#dotnet-usage-serialization).

{% include requirement/MUST id="dotnet-service-models-prefer-structs" %} ensure model types are structs if they're small, and classes if they're large, per [.NET Framework Design Guidelines](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/choosing-between-class-and-struct).

{% include requirement/MUST id="dotnet-service-models-basic-data-interfaces" %} implement basic data type interfaces on model types, per .NET Framework Design Guidelines.

TODO: Find reference in the .NET Framework Design Guidelines for this!
For example, implement `IEquatable<T>`, `IComparable<T>`, `IEnumerable<T>`, etc. if applicable.

{% include requirement/SHOULD id="dotnet-service-editor-browsable-state" %} apply the `[EditorBrowsable(EditorBrowsableState.Never)]` attribute to methods that the user isn't meant to call.

Adding this attribute will hide the methods from being shown with IntelliSense.  A user will almost never call `GetHashCode()` directly.  `Equals(object)` is almost never called if the type implements `IEquatable<T>` (which is preferred).  Hide the `ToString()` method if it isn't overridden.

```csharp
public sealed class ConfigurationSetting : IEquatable<ConfigurationSetting> {
    [EditorBrowsable(EditorBrowsableState.Never)]
    public override bool Equals(object obj);
    [EditorBrowsable(EditorBrowsableState.Never)]
    public override int GetHashCode();
}
```

{% include note.html content="Unlike client APIs, model type APIs aren't required to be thread-safe, as they're rarely shared between threads." %}

{% include requirement/MUST id="dotnet-models-in-mocks" %} ensure all model types can be used in mocks.

In practice, you need to provide public APIs to construct _model graphs_. See [Supporting Mocking](#dotnet-mocking) for details.

### Returning Collections {#dotnet-paging}

Many Azure REST APIs return collections of data in batches or pages. A client library will expose such APIs as an enumerable type.  For example, the configuration service returns collections of items as follows:

```csharp
public class ConfigurationClient {

    // asynchronous API returning a collection of items
    public virtual IAsyncEnumerable<Response<ConfigurationSetting>> GetAllAsync(...);

    // synchronous variant of the method above
    public virtual IEnumerable<Response<ConfigurationSetting>> GetAll(...);
    ...
}
```

{% include requirement/MUST id="dotnet-pagination-ienumerable" %} return `IEnumerable<Response<T>>` or `IAsyncEnumerable<Response<T>>` from service methods that return a collection of items.

The ```Response<T>.Raw``` will contain response content related to several individual items.

The ```IAsyncEnumerable<T>``` interface is available in the [Microsoft.BCL.AsyncInterfaces](https://www.nuget.org/packages/Microsoft.Bcl.AsyncInterfaces) package.

TODO: Include a code snippet example on how the user of the library would use this concept.

{% include requirement/SHOULD id="dotnet-pagination-raw-paging" %} expose raw paging APIs through custom enumerable types with a `ByPage()` method.

These APIs should be async only. Synchronous collection APIs must not support paging.

```csharp
public class <Service>Client {
    public AsyncEnumerator<Item> GetItemsAsync(...);

    public class AsyncEnumerator : IAsyncEnumerator<T> {
        public PageAsyncEnumerator<T> ByPage(string continuationToken = default);
    }
}

// Azure.Core Package
namespace Azure.Core {
    public class  PageAsyncEnumerator : IAsyncEnumerator<Page<T>> {
        public int PageSizeHint { get; set; }
        ... // interface implementations
    }

    public struct Page<T> {
        public string ContinuationToken { get; }
        public T[] Values { get; }
        public Response GetRawResponse();
    }
}
```

TODO: Include a code snippet example on how the user of the library would use this concept.

### Service Method Parameters {#dotnet-parameters}

#### Parameter Validation

Service methods take two kinds of parameters: _service parameters_ and _client parameters_. _Service parameters_ are directly passed across the wire to the service.  _Client parameters_ are used within the client library and aren't passed directly to the service.

{% include requirement/MUST id="dotnet-params-client-validation" %} validate client parameters.

{% include requirement/MUSTNOT id="dotnet-params-service-validation" %} validate service parameters.

Common parameter validations include null checks, empty string checks, and range checks. Let the service validate its parameters.

{% include requirement/MUST id="dotnet-params-test-devex" %} test the developer experience when invalid service parameters are passed in. Ensure clear error messages are generated by the client. If the developer experience is inadequate, work with the service team to correct the problem.

### Long Running Operations {#dotnet-longrunning}

Some service operations, known as _Long Running Operations_ or _LROs_ take a long time (hours or days). Such operations are started with a service call.  Their progress is monitored with one or more separate calls. The LRO pattern looks like this code snippet:

```csharp
public class <Service>Client {

    // Operation<T> is a type in Azure.Core
    // Note that LROs are exposed as asynchronous methods only
    public Task<Operation<Model>> Start<OperationName>Async(...);

    // this overload lets users access an existing operation
    public Task<Operation<Model>> Start<OperationName>Async(string operationId);

    // synchronous versions
    public Operation<Model> Start<OperationName>(...);
    public Operation<Model> Start<OperationName>(string operationId);
}

// the following types are in Azure.Core package
public abstract class Operation<T>
{
    // will use cached value withing polling interval
    public ValueTask<Response<OperationStatus>> GetStatusAsync(CancellationToken cancellationToken = default);
    public Response<OperationStatus> GetStatus(CancellationToken cancellationToken = default);

    public ValueTask<Response<T>> WaitAsync(CancellationToken cancellationToken = default);

    public Response GetRawResponse();
    public T Value; // throws if CachedStatus != Succeeded
    public OperationStatus CachedStatus;

    public string Id { get; }
    public TimeSpan PollingInterval { get; set; }
}

public enum OperationStatus
{
    Running,
    Succeeded,
    Cancelled,
    Failed,
}
```

The `Operation` object can be used to poll for a response.

```csharp
var client = new ServiceClient();

// automatic polling
{
    Model value = await client.StartOperationAsync().WaitAsync();
    Console.WriteLine(value);
}

// manual polling
{
    Operation<Model> operation = await client.StartOperationAsync();
    while ((await operation.GetStatusAsync(cancel.Token)) == Status.Running)
    {
        await Task.Delay(1000); // play some elevator music
    }
    Console.WriteLine(operation.Value);
}

// saving operation ID
{
    Operation<Model> operation1 = await client.StartOperationAsync();
    string operationId = operation.Id;

    // two days later
    Operation<Model> operation2 = await client.StartOperationAsync(operationId);
    Model value = await operation2.WaitAsync();
}
```

{% include requirement/MUST id="dotnet-lro-prefix" %} name all methods that start an LRO with the `Start` prefix.

{% include requirement/SHOULD id="dotnet-lro-continuation" %} provide an overload of the method that starts the LRO taking operationId parameter.

This overload is used to access an in-progress LRO.

### Supporting Mocking {#dotnet-mocking}

All client libraries must support mocking. Here is an example of how the `ConfigurationClient` can be mocked using [Moq] (a popular .NET mocking library):

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

Review the [full sample](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/appconfiguration/Azure.Data.AppConfiguration/samples/Sample7_MockClient.cs) in the GitHub repository.

{% include requirement/MUST id="dotnet-mocking-virtual-method" %} make all service methods virtual.

{% include requirement/MUST id="dotnet-mocking-constructor" %} provide protected parameterless constructor for mocking.

{% include requirement/MUST id="dotnet-mocking-factory-builder" %} provide factory or builder for constructing model graphs returned from virtual service methods.

Model types shouldn't have public constructors.  Instances of the model are typically returned from the client library, and are not constructed by the consumer of the library.  Mock implementations need to create instances of model types.  Implement a static class called `<service>ModelFactory` in the same namespace as the model types:

```csharp
public static class ConfigurationModelFactory {
    public static ConfigurationSetting ConfigurationSetting(string key, string value, string label=default, string contentType=default, ETag eTag=default, Nullable<DateTimeOffset> lastModified=default, Nullable<bool> locked=default);
    public static SettingBatch SettingBatch(ConfigurationSetting[] settings, string link, SettingSelector selector);
}
```

### Authentication {#dotnet-authentication}

The client library consumer should construct a service client using just the constructor.  After construction, service methods can be called successfully.  The constructor parameters must take all parameters required to create a functioning client, including all information needed to authenticate with the service.

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

### Enumerations

{% include requirement/MUST id="dotnet-enums" %} use an `enum` for parameters, properties, and return types when values are known.

{% include requirement/MAY id="dotnet-enums-exception" %} use a `readonly struct` in place of an `enum` that declares well-known fields but can contain unknown values returned from the service, or user-defined values passed to the service.

See [enumeration-like structure documentation](implementation.md#dotnet-enums) for implementation details.

## General Azure SDK Library Design

### Namespace Naming {#dotnet-namespace-naming}

{% include requirement/MUST id="dotnet-namespaces-naming" %} adhere to the following scheme when choosing a namespace: `Azure.<group>.<service>[.<feature>]`

For example, `Azure.Storage.Blobs`.

{% include requirement/MUST id="dotnet-namespaces-approved-list" %} use one of the following pre-approved namespace groups:

- `Azure.AI` for artificial intelligence, including machine learning
- `Azure.Analytics` for client libraries that gather or process analytics data
- `Azure.Core` for libraries that aren't service specific
- `Azure.Data` for client libraries that handle databases or structured data stores
- `Azure.Diagnostics` for client libraries that gather data for diagnostics, including logging
- `Azure.Identity` for authentication and authorization client libraries
- `Azure.Iot` for client libraries dealing with the Internet of Things
- `Azure.Management` for client libraries accessing the control plane (Azure Resource Manager)
- `Azure.Media` for client libraries that deal with audio, video, or mixed reality
- `Azure.Messaging` for client libraries that provide messaging services, such as push notifications or pub-sub.
- `Azure.Search` for search technologies
- `Azure.Security` for client libraries dealing with security
- `Azure.Storage` for client libraries that handle unstructured data

If you think a new group should be added to the list, contact [adparch].

{% include requirement/MUST id="dotnet-namespaces-registration" %} register all namespaces with [adparch].

{% include requirement/MUSTNOT id="dotnet-namespaces-location" %} place APIs in the second-level namespace (directly under the `Azure` namespace).

{% include requirement/SHOULD id="dotnet-namespaces-models" %} consider placing model types in a `.Models` namespace if number of model types is or might become large.

Consider 5+ models to be "large".  The types that the user needs should be easy to find when using IntelliSense in the main namespace.

### Error Reporting {#dotnet-errors}

{% include requirement/MUST id="dotnet-errors-response-failed" %} throw ```ResponseFailedException``` or its subtype when a service method fails with non-success status code.

The exception is available in ```Azure.Core``` package:
```csharp
public class RequestFailedException : Exception {

    public RequestFailedException(int status, string message);
    public RequestFailedException(int status, string message, Exception innerException);

    public int Status { get; }
}
```

{% include requirement/SHOULD id="dotnet-errors-response-exception-extensions" %} use `ResponseExceptionExtensions` to create `RequestFailedException` instances.

The exception message should contain detailed response information.  For example:

```csharp
if (response.Status != 200) {
    ResponseFailedException e = await response.CreateRequestFailedExceptionAsync(message);
    throw e;
}
```

{% include requirement/MUST id="dotnet-errors-use-response-failed-when-possible" %} use `ResponseFailedException` or one of its subtypes where possible.

Don't introduce new exception types unless there's a programmatic scenario for handling the new exception that's different than `ResponseFailedException`

### Logging

Request logging will be done automatically by the `HttpPipeline`.  If a client library needs to add custom logging, follow the [same guidelines](../implementation.md#general-logging) and mechanisms as the pipeline logging mechanism.  If a client library wants to do custom logging, the designer of the library must ensure that the logging mechanism is pluggable in the same way as the `HttpPipeline` logging policy.

{% include requirement/MUST id="dotnet-logging-follow-guidelines" %} follow [the logging section of the Azure SDK General Guidelines](../implementation.md#general-logging) if logging directly (as opposed to through the `HttpPipeline`).

#### Distributed Tracing {#dotnet-distributedtracing}

{% include draft.html content="Guidance coming soon ..." %}

### Packaging {#dotnet-packaging}

{% include requirement/MUST id="dotnet-packaging-nuget" %} package all components as NuGet packages.

If your client library is built by the Azure SDK engineering systems, all packaging requirements will be met automatically. Follow the [.NET packaging guidelines](https://docs.microsoft.com/en-us/dotnet/standard/library-guidance/nuget) if you're self-publishing.

{% include requirement/MUST id="dotnet-packaging-naming" %} name the package based on the name of the main namespace of the component.

For example, if the component is in the `Azure.Storage.Blobs` namespace, the component DLL will be `Azure.Storage.Blobs.dll` and the NuGet package will b`Azure.Storage.Blobs```.

{% include requirement/SHOULD id="dotnet-packaging-granularity" %} place small related components that evolve together in a single NuGet package.

{% include requirement/MUST id="dotnet-build-net-standard" %} build all libraries for [.NET Standard 2.0].

Use the following target setting in the `.csproj` file:

```
<TargetFramework>netstandard2.0</TargetFramework>
```

### Dependencies {#dotnet-dependencies}

{% include requirement/SHOULD id="dotnet-dependencies-minimize" %} minimize dependencies outside of the .NET Standard and `Azure.Core` packages.

{% include requirement/MUSTNOT id="dotnet-dependencies-list" %} depend on any NuGet package except the following packages:

* `Azure.*` packages from the [azure/azure-sdk-for-net] repository.
* `System.Text.Json`.
* `Microsoft.BCL.AsyncInterfaces`.
* packages produced by your own team.

In the past, [JSON.NET] was commonly used for serialization and deserialization. Use the [System.Text.Json](https://www.nuget.org/packages/System.Text.Json/)
package that is now a part of the .NET platform instead.

{% include requirement/MUSTNOT id="dotnet-dependencies-exposing" %} publicly expose types from dependencies unless the types follow these guidelines as well.

### Versioning {#dotnet-versioning}

{% include requirement/MUST id="dotnet-versioning-backwards-compatibility" %} be 100% backwards compatible with older versions of the same package.

For detailed rules, see [.NET Breaking Changes](https://github.com/dotnet/corefx/blob/master/Documentation/coding-guidelines/breaking-change-rules.md).

{% include requirement/MUST id="dotnet-versioning-highest-api" %} call the highest supported service API version by default.

{% include requirement/MUST id="dotnet-versioning-select-api-version" %} allow the consumer to explicitly select a supported service API version when instantiating the service client.

Use a constructor parameter called `version` on the client options type.

* The `version` parameter must be the first parameter to all constructor overloads.
* The `version` parameter must be required, and default to the latest supported service version.
* The type of the `version` parameter must be `ServiceVersion`; an enum nested in the options type.
* The `ServiceVersion` enum must use explicit values.

For example, the following is a code snippet from the `ConfigurationClientOptions`:

```csharp
public class ConfigurationClientOptions : HttpPipelineOptions {

    public ConfigurationClientOptions(ServiceVersion version = ServiceVersion.V2019_05_09)

    public enum ServiceVersion {
        V2019_05_09 = 0,
    }
    ...
}
```

{% include note.html content="Third-party reusable libraries shouldn't change behavior without an explicit decision by the developer.  When developing libraries that are based on the Azure SDK, lock the library to a specific service version to avoid changes in behavior." %}

{% include requirement/MUST id="dotnet-versioning-new-package" %} introduce a new package (with new assembly names, new namespace names, and new type names) if you must do an API breaking change.

Breaking changes should happen rarely, if ever.  Register your intent to do a breaking change with [adparch]. You'll need to have a discussion with the language architect before approval.

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

#### Version Numbers {#dotnet-versionnumbers}

Consistent version number scheme allows consumers to determine what to expect from a new version of the library.

{% include requirement/MUST id="dotnet-version-semver" %} use _MAJOR_._MINOR_._PATCH_ format for the version of the library dll and the NuGet package.

Use _-preview_._N_ suffix for preview package versions. For example, _1.0.0-preview.2_.

{% include requirement/MUST id="dotnet-version-change-on-release" %} change the version number of the client library when **ANYTHING** changes in the client library.

{% include requirement/MUST id="dotnet-version-patching" %} increment the patch version when fixing a bug.

{% include requirement/MUSTNOT id="dotnet-version-features-in-patch" %} include new APIs in a patch release.

{% include requirement/MUST id="dotnet-version-add-feature" %} increment the major or minor version when adding support for a service API version.

{% include requirement/MUST id="dotnet-version-add-api" %} increment the major or minor version when adding a new method to the public API.

{% include requirement/SHOULD id="dotnet-version-major-changes" %} increment the major version when making large feature changes.

### Documentation {#dotnet-documentation}

{% include requirement/MUST id="dotnet-docs-document-everything" %} document every exposed (public or protected) type and member within your library's code.

{% include requirement/MUST id="dotnet-docs-docstrings" %} use [C# documentation comments](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/documentation-comments) for reference documentation.

See the [documentation guidelines]({{ site.baseurl }}/general_documentation.html) for language-independent guidelines for how to provide good documentation.

## Common Type Usage {#dotnet-commontypes}

### HttpPipelineOptions {#dotnet-usage-options}

{% include requirement/MUST id="dotnet-http-pipeline-options" %} name subclasses of ```HttpPipelineOptions``` by adding _Client_ suffix to the name of the client type the options subclass is configuring.

```csharp
// options for configuring ConfigurationClient
public class ConfigurationClientOptions : HttpPipelineOptions {
    ...
}

public class ConfigurationClient {

    public ConfigurationClient(string connectionString, ConfigurationClientOptions options);
    ...
}
```

If the options type can be shared by multiple client types, name it with a plural or more general name.  For example, the `BlobClientsOptions` class can be used by `BlobClient`, `BlobContainerClient`, and `BlobAccountClient`.

{% include requirement/MUSTNOT id="dotnet-options-no-default-constructor" %} have a default constructor on the options type.

Each overload constructor should take at least `version` parameter to specify the service version. See [Versioning](#dotnet-service-version-option) guidelines for details.

### HttpPipeline {#dotnet-usage-httppipeline}

The following example shows a typical way of using `HttpPipeline` to implement a service call method. The `HttpPipeline` will handle common HTTP requirements such as the user agent, logging, distributed tracing, retries, and proxy configuration.

```csharp
public virtual async Task<Response<ConfigurationSetting>> AddAsync(ConfigurationSetting setting, CancellationToken cancellationToken = default)
{
    if (setting == null) throw new ArgumentNullException(nameof(setting));
    ... // validate other preconditions

    // Use HttpPipeline _pipeline filed of the client type to create new HTTP request
    using (Request request = _pipeline.CreateRequest()) {

        // specify HTTP request line
        request.Method = PipelineMethod.Put;
        request.UriBuilder = ...;

        // add headers
        request.Headers.Add(IfNoneMatchWildcard);
        request.Headers.Add(MediaTypeKeyValueApplicationHeader);
        request.Headers.Add(HttpHeader.Common.JsonContentType);
        request.Headers.Add(HttpHeader.Common.CreateContentLength(content.Length));

        // add content
        ReadOnlyMemory<byte> content = Serialize(setting);
        request.Content = HttpPipelineRequestContent.Create(content);

        // send the request
        await Pipeline.SendRequestAsync(request).ConfigureAwait(false);

        // get response
        Response response = message.Response;
        if (response.Status == 200) {
            // deserialize content
            Response<ConfigurationSetting> result = await CreateResponse(response, cancellationToken);
        }
        else throw new ResponseFailedException(response);
    }
}
```

For a more complete example, see the [configuration client](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/appconfiguration/Azure.Data.AppConfiguration/src/ConfigurationClient.cs) implementation.

### HttpPipelinePolicy

The HTTP pipeline includes a number of policies that all requests pass through.  Examples of policies include setting required headers, authentication, generating a request ID, and implementing proxy authentication.  `HttpPipelinePolicy` is the base type of all policies (plugins) of the `HttpPipeline`. This section describes guidelines for designing custom policies.

{% include requirement/MUST id="dotnet-http-pipeline-policy-inherit" %} inherit from `HttpPipelinePolicy` if the policy implementation calls asynchronous APIs.

See an example [here](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Azure.Core/src/Pipeline/BearerTokenAuthenticationPolicy.cs).

{% include requirement/MUST id="dotnet-sync-http-pipeline-policy-inherit" %} inherit from `SynchronousHttpPipelinePolicy` if the policy implementation calls only synchronous APIs.

See an example [here](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Azure.Core/src/Pipeline/Internal/ClientRequestIdPolicy.cs).

{% include requirement/MUST id="dotnet-http-pipeline-thread-safety" %} be thread-safe. The `ProcessAsync` and `Process` methods must be safe to invoke from multiple threads concurrently.

`HttpPipelineMessage`, `Request`, and `Response` don't have to be thread-safe.

### JSON {#dotnet-usage-json}

{% include requirement/MUST id="dotnet-json-use-system-text-json" %} use [`System.Text.Json`](https://www.nuget.org/packages/System.Text.Json) package to write and read JSON content.

{% include requirement/SHOULD id="dotnet-json-use-utf8jsonwriter" %} use `Utf8JsonWriter` to write JSON payloads:

```csharp
var json = new Utf8JsonWriter(writer);
json.WriteStartObject();
json.WriteString("value", setting.Value);
json.WriteString("content_type", setting.ContentType);
json.WriteEndObject();
json.Flush();
written = (int)json.BytesWritten;
```

{% include requirement/SHOULD id="dotnet-json-use-jsondocument" %} use `JsonDocument` to read JSON payloads:

```csharp
using (JsonDocument json = await JsonDocument.ParseAsync(content, default, cancellationToken).ConfigureAwait(false))
{
    JsonElement root = json.RootElement;

    var setting = new ConfigurationSetting();

    // required property
    setting.Key = root.GetProperty("key").GetString();

    // optional property
    if (root.TryGetProperty("last_modified", out var lastModified)) {
        if(lastModified.Type == JsonValueType.Null) {
            setting.LastModified = null;
        }
        else {
            setting.LastModified = DateTimeOffset.Parse(lastModified.GetString());
        }
    }
    ...

    return setting;
}
```

{% include requirement/SHOULD id="dotnet-json-use-utf8jsonreader" %} consider using `Utf8JsonReader` to read JSON payloads.

`Utf8JsonReader` is faster than `JsonDocument` but much less convenient to use.

{% include requirement/MUST id="dotnet-json-serialization-resilience" %} make your serialization and deserialization code version resilient.

Optional JSON properties should be deserialized into nullable model properties.

### Primitive Types

{% include requirement/MUST id="dotnet-primitives-etag" %} use `Azure.ETag` to represent ETags.

The `Azure.ETag` type is located in `Azure.Core` package.

{% include requirement/MUST id="dotnet-primitives-uri" %} use `System.Uri` to represent URIs.

# Repository Guidelines {#dotnet-repository}

{% include requirement/MUST id="dotnet-general-repository" %} locate all source code and README in the [azure/azure-sdk-for-net] GitHub repository.

{% include requirement/MUST id="dotnet-general-engsys" %} follow Azure SDK engineering systems guidelines for working in the [azure/azure-sdk-for-net] GitHub repository.

## README {#dotnet-repository-readme}

{% include requirement/MUST id="dotnet-docs-readme" %} have a README.md file in the component root folder.

An example of a good `README.md` file can be found [here](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/appconfiguration/Azure.Data.AppConfiguration/README.md).

{% include requirement/MUST id="dotnet-docs-readme-consumer" %} optimize the `README.md` for the consumer of the client library.

The contributor guide (`CONTRIBUTING.md`) should be a separate file linked to from the main component `README.md`.

## Samples {#dotnet-samples}

Each client library should have a quickstart guide with code samples.  Developers like to learn about a library by looking at sample code; not by reading in-depth technology papers.

{% include requirement/MUST id="dotnet-samples-location" %} have usage samples in `samples` subdirectory of main library directory.

For a complete example, see the [Configuration Service samples](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/appconfiguration/Azure.Data.AppConfiguration/samples).

{% include requirement/MUST id="dotnet-samples-naming" %} have a sample file called `S1_HelloWorld.cs`. All other samples are ordered from simplest to most complex using the `S<number>_` prefix.

{% include requirement/MUST id="dotnet-sync-samples-naming" %} use synchronous APIs in the `S1_HelloWorld.cs` sample.  Add a second sample (named `S2_HelloWorldAsync.cs`) that does the same thing as `S1_HelloWorld.cs` using asynchronous code.

{% include requirement/MUST id="dotnet-samples-build" %} make sure all the samples build and run as part of the CI process.

# Commonly Overlooked .NET API Design Guidelines {#dotnet-appendix-overlookedguidelines}

Some .NET Design Guidelines have been notoriously overlooked in existing Azure SDKs. This section serves as a way to highlight these guidelines.

{% include requirement/SHOULDNOT id="dotnet-problems-too-many-types" %} have many types in the main namespace. Number of types is directly proportional to the perceived complexity of a library.

{% include requirement/MUSTNOT id="dotnet-problems-abstractions" %} use abstractions unless the Azure SDK both returns and consumes the abstraction.  An abstraction is either an interface or abstract class.

{% include requirement/MUSTNOT id="dotnet-problems-interfaces" %} use interfaces if you can use abstract classes. The only reasons to use an interface are: a) you need to “multiple-inherit”, b) you want structs to implement an abstraction.

{% include requirement/MUSTNOT id="dotnet-problems-generic-words" %} use generic words and terms for type names.  For example, do not use names like `OperationResponse` or `DataCollection`.

{% include requirement/SHOULDNOT id="dotnet-problems-valid-values" %} use parameter types where it’s not clear what valid values are supported.  For example, do not use strings but only accept certain values in the string.

{% include requirement/MUSTNOT id="dotnet-problems-empty-types" %} have empty types (types with no members).

<!-- Links -->

{% include refs.md %}
{% include_relative refs.md %}
