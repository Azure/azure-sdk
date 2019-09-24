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




<!-- Links -->

{% include refs.md %}
{% include_relative refs.md %}
