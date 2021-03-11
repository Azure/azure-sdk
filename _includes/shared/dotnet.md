{% include shared/header.md %}

## .NET

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.dotnet-packages %}
{% else %}
  {% assign packages = site.data.releases.latest.dotnet-packages | where: 'Type', include.type | where: 'New', 'true' %}
{% endif %}

{{ description | replace: 'PackageCount', packages.size }}

{% include shared/tabs.md lang="dotnet" active=include.type %}

{% include shared/variables/dotnet.md %}

{% include {{page.scope}}/pkgtable.md %}