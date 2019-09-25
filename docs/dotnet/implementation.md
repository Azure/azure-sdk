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

## Enumeration-like structures {#dotnet-enums}

As described in [general enumeration guidelines](introduction.md#dotnet-enums), you should use `enum` types whenever passing or deserializing a well-known set of values to or from the service.
There may be times, however, where a `readonly struct` is necessary to capture an extensible value from the service even if well-known values are defined,
or to pass back to the service those same or other user-supplied values. In those cases, you should define a structure that adheres to the following example:

```csharp
public readonly struct Example : IEquatable<Example>
{
    private readonly string _value;

    /// <summary>
    /// Initializes a new instance of the <see cref="Example"/> structure.
    /// </summary>
    /// <param name="value"></param>
    public Example(string value)
    {
        _value = value ?? throw new ArgumentNullException(nameof(value));
    }

    // TODO: Define internal or private string constants here if you want to use them in switch statements:
    // internal const string s_value1 = "value1";

    // TODO: Define well-known values here (use constant values from above if defined):
    // public static readonly Example Value1 = new Example(s_value1);
    // public static readonly Example Value2 = new Example("value2");

    /// <summary>
    /// Determines if two <see cref="Example"/> values are the same.
    /// </summary>
    /// <param name="left">The first <see cref="Example"/> to compare.</param>
    /// <param name="right">The second <see cref="Example"/> to compare.</param>
    /// <returns>True if <paramref name="left"/> and <paramref name="right"/> are the same; otherwise, false.</returns>
    public static bool operator ==(Example left, Example right) => left.Equals(right);

    /// <summary>
    /// Determines if two <see cref="Example"/> values are different.
    /// </summary>
    /// <param name="left">The first <see cref="Example"/> to compare.</param>
    /// <param name="right">The second <see cref="Example"/> to compare.</param>
    /// <returns>True if <paramref name="left"/> and <paramref name="right"/> are different; otherwise, false.</returns>
    public static bool operator !=(Example left, Example right) => !left.Equals(right);

    /// <summary>
    /// Converts a string to a <see cref="Example"/>.
    /// </summary>
    /// <param name="value">The string value to convert.</param>
    public static implicit operator Example(string value) => new Example(value);

    /// <inheritdoc/>
    [EditorBrowsable(EditorBrowsableState.Never)]
    public override bool Equals(object obj) => obj is Example other && Equals(other);

    /// <inheritdoc/>
    public bool Equals(Example other) => string.Equals(_value, other._value, StringComparison.Ordinal);

    /// <inheritdoc/>
    [EditorBrowsable(EditorBrowsableState.Never)]
    public override int GetHashCode() => _value?.GetHashCode() ?? 0;

    /// <inheritdoc/>
    public override string ToString() => _value;

    // TODO: If you need to attach other data to the struct value, follow the pattern below:
    // internal int GetNumberValue() => _value switch
    // {
    //     s_value1 => 1,
    //     _ => 0,
    // };
}
```

<!-- Links -->

{% include refs.md %}
{% include_relative refs.md %}
