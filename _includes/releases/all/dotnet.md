{% if page.header %}
{% include releases/header.md %}
{% endif %}

## .NET

{% assign packages = site.data.allpackages.dotnet-packages %}

There are {{ packages.size }} total Azure library packages published to nuget from the [azure-sdk account](https://www.nuget.org/profiles/azure-sdk).

[New Libraries]({% link releases/latest/dotnet.md %}) | **All Libraries**

{% include dotnet-allpackages.html %}