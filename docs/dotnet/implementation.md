---
title: "C#.NET Guidelines: Implementation"
keywords: guidelines dotnet
permalink: dotnet_implementation.html
folder: dotnet
sidebar: general_sidebar
---

## API Implementation

This section describes guidelines for implementing Azure SDK client libraries. Please note that some of these guidelines are automatically enforced by code generation tools. 

### The Service Client

TODO: add a brief mention of the approach to implementing service clients. 

#### Service Methods

TODO: Briefly introduce that service methods are implemented via an `HttpPipeline` instance.  Mention that much of this is done for you using code generation.

##### Using HttpPipeline {#dotnet-usage-httppipeline}

The following example shows a typical way of using `HttpPipeline` to implement a service call method. The `HttpPipeline` will handle common HTTP requirements such as the user agent, logging, distributed tracing, retries, and proxy configuration.

```csharp
public virtual async Task<Response<ConfigurationSetting>> AddAsync(ConfigurationSetting setting, CancellationToken cancellationToken = default)
{
    if (setting == null) throw new ArgumentNullException(nameof(setting));
    ... // validate other preconditions

    // Use HttpPipeline _pipeline filed of the client type to create new HTTP request
    using (Request request = _pipeline.CreateRequest()) {

        // specify HTTP request line
        request.Method = RequestMethod.Put;
        request.Uri.Reset(_endpoint);
        request.Uri.AppendPath(KvRoute, escape: false);
        requast.Uri.AppendPath(key);

        // add headers
        request.Headers.Add(IfNoneMatchWildcard);
        request.Headers.Add(MediaTypeKeyValueApplicationHeader);
        request.Headers.Add(HttpHeader.Common.JsonContentType);
        request.Headers.Add(HttpHeader.Common.CreateContentLength(content.Length));

        // add content
        ReadOnlyMemory<byte> content = Serialize(setting);
        request.Content = HttpPipelineRequestContent.Create(content);

        // send the request
        var response = await Pipeline.SendRequestAsync(request).ConfigureAwait(false);

        if (response.Status == 200) {
            // deserialize content
            Response<ConfigurationSetting> result = await CreateResponse(response, cancellationToken);
        }
        else
        {
            throw await response.CreateRequestFailedExceptionAsync(message);
        }
    }
}
```

TODO: do we still want this code sample now that we're encouraging moving to Code Gen?

For a more complete example, see the [configuration client](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/appconfiguration/Azure.Data.AppConfiguration/src/ConfigurationClient.cs) implementation.

##### Using HttpPipelinePolicy

The HTTP pipeline includes a number of policies that all requests pass through.  Examples of policies include setting required headers, authentication, generating a request ID, and implementing proxy authentication.  `HttpPipelinePolicy` is the base type of all policies (plugins) of the `HttpPipeline`. This section describes guidelines for designing custom policies.

{% include requirement/MUST id="dotnet-http-pipeline-policy-inherit" %} inherit from `HttpPipelinePolicy` if the policy implementation calls asynchronous APIs.

See an example [here](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Azure.Core/src/Pipeline/BearerTokenAuthenticationPolicy.cs).

{% include requirement/MUST id="dotnet-sync-http-pipeline-policy-inherit" %} inherit from `HttpPipelineSynchronousPolicy` if the policy implementation calls only synchronous APIs.

See an example [here](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Azure.Core/src/Pipeline/Internal/ClientRequestIdPolicy.cs).

{% include requirement/MUST id="dotnet-http-pipeline-thread-safety" %} ensure `ProcessAsync` and `Process` methods are thread safe.

`HttpMessage`, `Request`, and `Response` don't have to be thread-safe.

#### Service Method Parameters

##### Parameter validation {#dotnet-parameters}

In addition to [general parameter validation guidelines](introduction.md#dotnet-parameters):

{% include requirement/MUSTNOT id="dotnet-parameter-validation-class" %} define your own parameter validation class.

Use the `Argument` class in Azure.Core or even "extend" it (it's a partial class included as source) with project-specific argument assertions.
Just add the following to your project to include it:

```xml
<!-- Import Azure.Core properties if not already imported. -->
<Import Project="$(MSBuildThisFileDirectory)..\..\..\core\Azure.Core\src\Azure.Core.props" />
<ItemGroup>
    <Compile Include="$(AzureCoreSharedSources)Argument.cs" />
</ItemGroup>
```

See remarks on the `Argument` class for more detail.

### Supporting Types

#### Serialization {#dotnet-usage-json}

##### JSON Serialization

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

#### Enumeration-like structures {#dotnet-enums}

As described in [general enumeration guidelines](introduction.md#dotnet-enums), you should use `enum` types whenever passing or deserializing a well-known set of values to or from the service.
There may be times, however, where a `readonly struct` is necessary to capture an extensible value from the service even if well-known values are defined,
or to pass back to the service those same or other user-supplied values:

- The value is retrieved and deserialized from service, and may contain a value not supported by the client library.
- The value is roundtripped: the value is retrieved and deserialized from the service, and may later be serialized and sent back to the server.

In those cases, you should define a structure that:

- Is `readonly`.
- Implements `IEquatable<T>` that compares only the string value.
- Stores only the string value.
- Defines `static` properties with well-known values.
- Defines equality, inequality, and an implicit cast-from-string operators.
- Overrides `Equals`, `GetHashCode`, and `ToString` methods.
- `Equals(object)` and `GetHashCode` should be attributed with `EditorBrowsable(EditorBrowsableState.Never)`.

Type of value comparison should be selected on per-service basis, if the service is inconsistent with how string values are returned the case-insensitive comparison is allowed.

The following example implements these requirements and should be used as a template:

```csharp
/// <summary>
/// An algorithm used for encryption and decryption
/// </summary>
public partial readonly struct EncryptionAlgorithm : IEquatable<EncryptionAlgorithm>
{
    internal const string Rsa15Value = "RSA1_5";
    internal const string RsaOaepValue = "RSA-OAEP";
    internal const string RsaOaep256Value = "RSA-OAEP-256";

    private readonly string _value;

    /// <summary>
    /// Initializes a new instance of the <see cref="EncryptionAlgorithm"/> structure.
    /// </summary>
    /// <param name="value">The string value of the instance.</param>
    public EncryptionAlgorithm(string value)
    {
        _value = value ?? throw new ArgumentNullException(nameof(value));
    }

    /// <summary>
    /// RSA1_5
    /// </summary>
    public static EncryptionAlgorithm Rsa15 { get; } = new EncryptionAlgorithm(Rsa15Value);

    /// <summary>
    /// RSA-OAEP
    /// </summary>
    public static EncryptionAlgorithm RsaOaep { get; } = new EncryptionAlgorithm(RsaOaepValue);

    /// <summary>
    /// RSA-OAEP256
    /// </summary>
    public static EncryptionAlgorithm RsaOaep256 { get; } = new EncryptionAlgorithm(RsaOaep256Value);

    /// <summary>
    /// Determines if two <see cref="EncryptionAlgorithm"/> values are the same.
    /// </summary>
    /// <param name="left">The first <see cref="EncryptionAlgorithm"/> to compare.</param>
    /// <param name="right">The second <see cref="EncryptionAlgorithm"/> to compare.</param>
    /// <returns>True if <paramref name="left"/> and <paramref name="right"/> are the same; otherwise, false.</returns>
    public static bool operator ==(EncryptionAlgorithm left, EncryptionAlgorithm right) => left.Equals(right);

    /// <summary>
    /// Determines if two <see cref="EncryptionAlgorithm"/> values are different.
    /// </summary>
    /// <param name="left">The first <see cref="EncryptionAlgorithm"/> to compare.</param>
    /// <param name="right">The second <see cref="EncryptionAlgorithm"/> to compare.</param>
    /// <returns>True if <paramref name="left"/> and <paramref name="right"/> are different; otherwise, false.</returns>
    public static bool operator !=(EncryptionAlgorithm left, EncryptionAlgorithm right) => !left.Equals(right);

    /// <summary>
    /// Converts a string to a <see cref="EncryptionAlgorithm"/>.
    /// </summary>
    /// <param name="value">The string value to convert.</param>
    public static implicit operator EncryptionAlgorithm(string value) => new EncryptionAlgorithm(value);

    /// <inheritdoc/>
    [EditorBrowsable(EditorBrowsableState.Never)]
    public override bool Equals(object obj) => obj is EncryptionAlgorithm other && Equals(other);

    /// <inheritdoc/>
    public bool Equals(EncryptionAlgorithm other) => string.Equals(_value, other._value, StringComparison.Ordinal);

    /// <inheritdoc/>
    [EditorBrowsable(EditorBrowsableState.Never)]
    public override int GetHashCode() => _value?.GetHashCode() ?? 0;

    /// <inheritdoc/>
    public override string ToString() => _value;

    // Attach extra information to to structs using factory methods:
    internal RSAEncryptionPadding GetRsaEncryptionPadding() => _value switch
    {
        Rsa15Value => RSAEncryptionPadding.Pkcs1,
        RsaOaepValue => RSAEncryptionPadding.OaepSHA1,
        RsaOaep256Value => RSAEncryptionPadding.OaepSHA256,
        _ => null,
    };
}
```

##### Constant values for enumeration-like structures {#dotnet-enums-values}

{% include requirement/SHOULD id="dotnet-enums-values-define" %} define a nested static class named `Values` with public constants if and only if extensible enum values *must* be used as constant expressions, for example:

- Attribute values
- Default parameter values
- Switch statements and expressions

```csharp
public partial readonly struct EncryptionAlgorithm : IEquatable<EncryptionAlgorithm>
{
    /// <summary>
    /// The values of all declared <see cref="EncryptionAlgorithm"/> properties as string constants.
    /// </summary>
    public static class Values
    {
        /// <summary>
        /// RSA1_5
        /// </summary>
        public const string Rsa15 = EncryptionAlgorithm.Rsa15Value;

        /// <summary>
        /// RSA-OAEP
        /// </summary>
        public const string RsaOaep = EncryptionAlgorithm.RsaOaepValue;

        /// <summary>
        /// RSA-OAEP256
        /// </summary>
        public const string RsaOaep256 = EncryptionAlgorithm.RsaOaep256Value;
    }
}
```

{% include requirement/MUST id="dotnet-enums-values-test" %} define tests to ensure extensible enum properties and defined `Values` constants declare the same names and define the same values. See [here](https://github.com/Azure/azure-sdk-for-net/blob/322f6952e4946229949bd3375f5eb6120895fd2f/sdk/search/Azure.Search.Documents/tests/Models/LexicalAnalyzerNameTests.cs#L14-L29) for an example.

#### Using Azure Core Types

##### Implementing Subtypes of Operation\<T\> {#dotnet-implement-operation}

Subtypes of `Operation<T>` are returned from service client methods invoking long running operations (LROs), as described in [Methods Invoking Long Running Operations](introduction.md#dotnet-longrunning).

{% include requirement/MUST id="dotnet-lro-return" %} check the value of `HasCompleted` in subclass implementations of `UpdateStatus` and `UpdateStatusAsync` and immediately return the result of `GetRawResponse` if it is true.

```csharp
public override Response UpdateStatus(
    CancellationToken cancellationToken = default) =>
    UpdateStatusAsync(false, cancellationToken).EnsureCompleted();

public override async ValueTask<Response> UpdateStatusAsync(
    CancellationToken cancellationToken = default) =>
    await UpdateStatusAsync(true, cancellationToken).ConfigureAwait(false);

private async Task<Response> UpdateStatusAsync(bool async, CancellationToken cancellationToken)
{
    // Short-circuit when already completed (which improves mocking scenarios that won't have a client).
    if (HasCompleted)
    {
        return GetRawResponse();
    }

    // some service operation call here, which the above check avoids if the operation has already completed.
    ...
```

{% include requirement/MUST id="dotnet-lro-return" %} throw from methods on `Operation<T>` subclasses in the following scenarios.

- If an underlying service operation call from `UpdateStatus`, `WaitForCompletion`, or `WaitForCompletionAsync` throws, re-throw `RequestFailedException` or its subtype.
- If the operation completes with a non-success result, throw `RequestFailedException` or its subtype from `UpdateStatus`, `WaitForCompletion`, or `WaitForCompletionAsync`.
  - Include any relevant error state information in the exception details.

```csharp
private async ValueTask<Response> UpdateStatusAsync(bool async, CancellationToken cancellationToken)
{
    ...

        try
        {
            Response<ExampleOperationResult> update = async
                ? await _serviceClient.GetExampleResultAsync(new Guid(Id), cancellationToken).ConfigureAwait(false)
                : _serviceClient.GetExampleResult(new Guid(Id), cancellationToken);

            _response = update.GetRawResponse();

            if (update.Value.Status == OperationStatus.Succeeded)
            {
                // we need to first assign a value and then mark the operation as completed to avoid race conditions
                _value = ConvertValue(update.Value.ExampleResult.PageResults, update.Value.ExampleResult.ReadResults);
                _hasCompleted = true;
            }
            else if (update.Value.Status == OperationStatus.Failed)
            {
                _requestFailedException = await ClientCommon
                    .CreateExceptionForFailedOperationAsync(async, _diagnostics, _response, update.Value.AnalyzeResult.Errors)
                    .ConfigureAwait(false);
                _hasCompleted = true;

                // the operation didn't throw, but it completed with a non-success result.
                throw _requestFailedException;
            }
        }
        catch (Exception e)
        {
            scope.Failed(e);
            throw;
        }
    }

    return GetRawResponse();
}
```

- If the ```Value``` property is evaluated after the operation failed (```HasValue``` is false and ```HasCompleted``` is true) throw the same exception as the one thrown when the operation failed.

```csharp
public override FooResult Value
{
    get
    {
        if (HasCompleted && !HasValue)
#pragma warning disable CA1065 // Do not raise exceptions in unexpected locations

            // throw the exception captured when the operation failed.
            throw _requestFailedException;

#pragma warning restore CA1065 // Do not raise exceptions in unexpected locations
        else
            return OperationHelpers.GetValue(ref _value);
    }
}
```

- If the ```Value``` property is evaluated before the operation is complete (```HasCompleted``` is false) throw ```InvalidOperationException```.
  - The exception message should be: "The operation has not yet completed."

```csharp
// start the operation.
ExampleOperation operation = await client.StartExampleOperationAsync(someParameter);

if (!operation.HasCompleted)
{
    // attempt to get the Value property before the operation has completed.
    ExampleOperationResult myResult = operation.Value;  //throws InvalidOperationException.
}
else if (!operation.HasValue)
{
    // attempt to get the Value property after the operation has completed unsuccessfully.
    ExampleOperationResult myResult = operation.Value;  //throws RequestFailedException.
}
```

## SDK Feature Implementation

### Configuration

TODO: Add discussion on configuration environment variables to parallel that of other languages

### Logging

Request logging will be done automatically by the `HttpPipeline`.  If a client library needs to add custom logging, follow the [same guidelines](implementation.md#general-logging) and mechanisms as the pipeline logging mechanism.  If a client library wants to do custom logging, the designer of the library must ensure that the logging mechanism is pluggable in the same way as the `HttpPipeline` logging policy.

{% include requirement/MUST id="dotnet-logging-follow-guidelines" %} follow [the logging section of the Azure SDK General Guidelines](implementation.md#general-logging) if logging directly (as opposed to through the `HttpPipeline`).

#### EventSource

{% include requirement/MUST id="dotnet-tracing-eventsource" %} use `EventSource` to produce diagnostic events.

{% include requirement/MUST id="dotnet-tracing-eventsource-logging-guidelines" %} follow the logging guidelines when implementing an `EventSource`.

{% include requirement/MUST id="dotnet-tracing-eventsource-single" %} have a single `EventSource` type per library.

{% include requirement/MUST id="dotnet-tracing-eventsource-internal" %} define `EventSource` class as `internal sealed`.

{% include requirement/MUST id="dotnet-tracing-eventsource-singleton" %} define and use a singleton instance of `EventSource`:

{% include requirement/MUST id="dotnet-tracing-eventsource-traits" %} define `AzureEventSource` trait with value `true` to make the `EventSource` discoverable by listeners (you can use `AzureEventSourceListener.TraitName` `AzureEventSourceListener.TraitValue` constants):

{% include requirement/MUST id="dotnet-tracing-eventsource-name" %} set `EventSource` name to package name replacing `.` with `-` (i.e. . `Azure-Core` for `Azure.Core` package)

{% include requirement/MUST id="dotnet-tracing-eventsource-event-message" %} have `Message` property of EventAttribute set for all events.

{% include requirement/MUST id="dotnet-tracing-eventsource-public-api" %} treat `EventSource` name, guid, event id and parameters as public API and follow the appropriate versioning rules.

{% include requirement/SHOULD id="dotnet-tracing-eventsource-is-enabled" %} check IsEnabled property before doing expensive work (formatting parameters, calling ToString, allocations etc.)

{% include requirement/MUSTNOT id="dotnet-tracing-eventsource-event-param-exception" %} define events with `Exception` parameters as they are not supported by `EventSource`.

{% include requirement/MUST id="dotnet-tracing-eventsource-test" %} have a test that asserts `EventSource` name, guid and generates the manifest to verify that event source is correctly defined.

{% include requirement/MUST id="dotnet-tracing-eventsource-test-events" %} test that expected events are produced when appropriate. `TestEventListener` class can be used to collect events. Make sure you mark the test as `[NonParallelizable]`.

{% include requirement/SHOULD id="dotnet-tracing-eventsource-thrown-exceptions" %} avoid logging exceptions that are going to get thrown to user code anyway.

{% include requirement/SHOULD id="dotnet-tracing-eventsource-event-size-limit" %} be aware of event size limit of 64K.

```
[Test]
public void MatchesNameAndGuid()
{
    // Arrange & Act
    var eventSourceType = typeof(AzureCoreEventSource);

    // Assert
    Assert.NotNull(eventSourceType);
    Assert.AreEqual("Azure-Core", EventSource.GetName(eventSourceType));
    Assert.AreEqual(Guid.Parse("1015ab6c-4cd8-53d6-aec3-9b937011fa95"), EventSource.GetGuid(eventSourceType));
    Assert.IsNotEmpty(EventSource.GenerateManifest(eventSourceType, "assemblyPathToIncludeInManifest"));
}
```

Sample `EventSource` declaration:

``` C#

[EventSource(Name = EventSourceName)]
internal sealed class AzureCoreEventSource : EventSource
{
    private const string EventSourceName = "Azure-Core";
    
    // Having event ids defined as const makes it easy to keep track of them
    private const int MessageSentEventId = 0;
    private const int ClientClosingEventId = 1;
    
    public static AzureCoreEventSource Shared { get; } = new AzureCoreEventSource();
    
    private AzureCoreEventSource() : base(EventSourceName, EventSourceSettings.Default, AzureEventSourceListener.TraitName, AzureEventSourceListener.TraitValue) { }
    
    [NonEvent]
    public void MessageSent(Guid clientId, string messageBody)
    {
        // We are calling Guid.ToString make sure anyone is listening before spending resources
        if (IsEnabled(EventLevel.Informational, EventKeywords.None))
        {
            MessageSent(clientId.ToString("N"), messageBody);
        }
    }
    
    // In this example we don't do any expensive parameter formatting so we can avoid extra method and IsEnabled check
    
    [Event(ClientClosingEventId, Level = EventLevel.Informational, Message = "Client {0} is closing the connection.")]
    public void ClientClosing(string clientId)
    {
        WriteEvent(ClientClosingEventId, clientId);
    }
    
    [Event(MessageSentEventId, Level = EventLevel.Informational, Message = "Client {0} sent message with body '{1}'")]
    private void MessageSent(string clientId, string messageBody)
    {
        WriteEvent(MessageSentEventId, clientId, messageBody);
    }    
}
```

### Distributed Tracing {#dotnet-distributedtracing}

{% include draft.html content="Guidance coming soon ..." %}

TODO: Add guidance for distributed tracing implementation

### Telemetry

TODO: Add guidance regarding user agent strings

## Ecosystem Integration

### Integration with ASP.NET Core

All Azure client libraries ship with a set of extension methods that provide integration with ASP.NET Core applications by registering clients with DependencyInjection container, flowing Azure SDK logs to ASP.NET Core logging subsystem and providing ability to use configuration subsystem for client configuration (for more examples see https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/core/Microsoft.Extensions.Azure)

{% include requirement/MUST id="dotnet-builder-class-name" %} provide a single `*ClientBuilderExtensions` class for every Azure SDK client library that contains client types. Name of the type should use the same prefix as the `*ClientOptions` class used across the library. For example: `SecretClientBuilderExtensions`, `BlobClientBuilderExtensions`

{% include requirement/MUST id="dotnet-client-builder-class-namespace" %} use `Microsoft.Extensions.Azure` as a namespace.

{% include requirement/MUST id="dotnet-client-builder-class-service-client" %} provide integration extension methods for every top level client type users are expected to start with in the main namespace. Do not include integration extension methods for secondary clients, child clients, or clients in advanced namespaces.

{% include requirement/MUST id="dotnet-client-builder-extension-name" %} name extension methods as `Add[ClientName]` for example. Add `AddSecretsClient`, `AddBlobServiceClient`.

{% include requirement/MUST id="dotnet-client-builder-overloads" %} provide an overload for every set of constructor parameters.

{% include requirement/MUST id="dotnet-client-builder-overload-normal" %} provide extension method for `IAzureClientFactoryBuilder` interface for constructors that don't take `TokenCredentials`. Extension method should take same set of parameters as constructor and call into `builder.RegisterClientFactory`

Sample implementation:

``` C#
public static IAzureClientBuilder<ConfigurationClient, ConfigurationClientOptions> AddConfigurationClient<TBuilder>(this TBuilder builder, string connectionString)
    where TBuilder : IAzureClientFactoryBuilder
{
    return builder.RegisterClientFactory<ConfigurationClient, ConfigurationClientOptions>(options => new ConfigurationClient(connectionString, options));
}
```

{% include requirement/MUST id="dotnet-client-builder-overload-tokencredential" %} provide extension method for `IAzureClientFactoryBuilderWithCredential` interface for constructors that take `TokenCredentials`. Extension method should take same set of parameters as constructor except the `TokenCredential` and call into `builder.RegisterClientFactory` overload that provides the token credential as part of factory lambda. 

Sample implementation:

``` C#
public static IAzureClientBuilder<SecretClient, SecretClientOptions> AddSecretClient<TBuilder>(this TBuilder builder, Uri vaultUri)
     where TBuilder : IAzureClientFactoryBuilderWithCredential
{
    return builder.RegisterClientFactory<SecretClient, SecretClientOptions>((options, cred) => new SecretClient(vaultUri, cred, options));
}
```

{% include requirement/MUST id="dotnet-client-builder-overload-configuration" %} provide extension method for `IAzureClientFactoryBuilderWithConfiguration<TConfiguration>` that takes `TConfiguration configuration`. This overload would allow customers to pass in a `IConfiguration` object and create client dynamically based on configuration values.

Sample implementation:
``` C#
public static IAzureClientBuilder<SecretClient, SecretClientOptions> AddSecretClient<TBuilder, TConfiguration>(this TBuilder builder, TConfiguration configuration)
    where TBuilder : IAzureClientFactoryBuilderWithConfiguration<TConfiguration>
{
    return builder.RegisterClientFactory<SecretClient, SecretClientOptions>(configuration);
}
```

<!-- Links -->

{% include shared/refs.md %}
{% include_relative refs.md %}
