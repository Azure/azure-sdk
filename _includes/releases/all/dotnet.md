{% if page.header %}
{% include releases/shared/header.md %}
{% endif %}

## .NET

{% assign packages = site.data.releases.all.dotnet-packages %}

There are {{ packages.size }} total Azure library packages published to nuget from the [azure-sdk account](https://www.nuget.org/profiles/azure-sdk).

{% include releases/nav/tabs.md lang="dotnet" active="all" %}

{% include releases/variables/dotnet.md %}

{% include releases/all/pkgtable.md %}