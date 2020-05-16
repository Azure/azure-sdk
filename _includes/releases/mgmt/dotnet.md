{% if page.header %}
{% include releases/shared/header.md %}
{% endif %}

## .NET

{% assign packages = site.data.releases.mgmt.dotnet-packages %}

{% include releases/nav/tabs.md lang="dotnet" active="mgmt" %}

{% include releases/variables/dotnet.md %}

{% include releases/shared/pkgtable.md %}