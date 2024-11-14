{% include releases/header.md type=include.type %}

## .NET

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.dotnet-packages | where_exp: 'item', "item.Support <> 'deprecated'"  %}
{% elsif include.type == "deprecated" %}
  {% assign packages = site.data.releases.latest.dotnet-packages | where: 'Support', 'deprecated' %}
{% else %}
  {% assign packages = site.data.releases.latest.dotnet-packages | where: 'Type', include.type | where: 'New', 'true' | where_exp: 'item', "item.Support <> 'deprecated'" %}
{% endif %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/tabs.md lang="dotnet" active=include.type %}

{% include releases/variables/dotnet.md %}

{% include releases/pkgtable.md type=include.type %}
