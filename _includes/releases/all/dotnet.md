{% if page.header %}
{% include releases/header.md %}
{% endif %}

## .NET

{% assign packages = site.data.allpackages.dotnet-packages %}

There are {{ packages.size }} total Azure library packages published to nuget from the [azure-sdk account](https://www.nuget.org/profiles/azure-sdk).

{% include releases/nav/tabs.md dataurl="/releases/latest/dotnet.html" mgmturl="/releases/latest/mgmt/dotnet.html" allurl="/releases/latest/all/dotnet.html" active="all" %}

{% include dotnet-allpackages.html %}