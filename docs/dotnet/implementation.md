---
title: "C#.NET Guidelines: Implementation"
keywords: guidelines dotnet
permalink: dotnet_implementation.html
folder: dotnet
sidebar: dotnet_sidebar
---

## Parameter validation

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

{% include requirement/MAY id="dotnet-tracing-eventsource" %} use `EventSource` to produce diagnostic events.

{% include requirement/MUST id="dotnet-tracing-eventsource-single" %} have a single `EventSource` type per library.

{% include requirement/MUST id="dotnet-tracing-eventsource-internal" %} define `EventSource` class as `internal sealed`.

{% include requirement/MUST id="dotnet-tracing-eventsource-singleton" %} define and use a singleton instance of `EventSource`:

{% include requirement/MUST id="dotnet-tracing-eventsource-traits" %} define `AzureEventSource` trait with value `true` to make the `EventSource` discoverable by listeners (you can use `AzureEventSourceListener.TraitName` `AzureEventSourceListener.TraitValue` constants):

{% include requirement/MUST id="dotnet-tracing-eventsource-name" %} set `EventSource` name to package name replacing `.` with `-` (i.e. . `Azure-Core` for `Azure.Core` package)

{% include requirement/MUST id="dotnet-tracing-eventsource-event-message" %} have `Message` set for all events.

{% include requirement/MUST id="dotnet-tracing-eventsource-public-api" %} treat `EventSource` name, guid, event id and parameters as public API and follow the appropriate versioning rules.

{% include requirement/SHOULD id="dotnet-tracing-eventsource-is-enabled" %} check IsEnabled property before doing expensive work (formatting parameters, calling ToString, etc.)

{% include requirement/MUST-NOT id="dotnet-tracing-eventsource-event-param-exception" %} define events with `Exception` parameters as they are not supported by `EventSource`.

{% include requirement/MUST id="dotnet-tracing-eventsource-test" %} have a test that asserts `EventSource` name, guid and generates the manifest to verify that event source is correctly defined.

```
[Test]
public void MatchesNameAndGuid()
{
    // Arrange & Act
    var eventSourceType = typeof(AzureCoreEventSource);

    // Assert
    Assert.NotNull(eventSourceType);
    Assert.AreEqual("Azure.Core", EventSource.GetName(eventSourceType));
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
    
    [Event(Id = MessageSentEventId, Level = EventLevel.Informational, Message = "Client {0} sent message with body '{1}'")]
    private void MessageSent(string clientId, string messageBody)
    {
        WriteEvent(clientId, messageBody);
    }
}
```

<!-- Links -->

{% include refs.md %}
{% include_relative refs.md %}
