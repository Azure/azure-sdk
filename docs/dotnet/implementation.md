---
title: "C#.NET Guidelines: Implementation"
keywords: guidelines dotnet
permalink: dotnet_implementation.html
folder: dotnet
sidebar: dotnet_sidebar
---

## Parameter validation {#dotnet-parameters}

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

## EventSource

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

## Enumeration-like structures {#dotnet-enums}

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

The following example implements these requirements and should be used as a template:

```csharp
/// <summary>
/// An algorithm used for encryption and decryption
/// </summary>
public readonly struct EncryptionAlgorithm : IEquatable<EncryptionAlgorithm>
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

<!-- Links -->

{% include refs.md %}
{% include_relative refs.md %}
