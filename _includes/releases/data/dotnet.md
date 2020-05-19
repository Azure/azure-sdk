{% if page.header %}
{% include releases/shared/header.md %}
{% endif %}

## .NET

{% assign packages = site.data.releases.new.dotnet-packages | where: 'Type', 'Data' %}

{% include releases/nav/tabs.md lang="dotnet" active="data" %}

{% include releases/variables/dotnet.md %}

{% include releases/shared/pkgtable.md %}