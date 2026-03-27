{% include releases/header.md type=include.type %}

## Go

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.go-packages | where_exp: 'item', "item.Support <> 'deprecated'" %}
{% elsif include.type == "deprecated" %}
  {% assign packages = site.data.releases.latest.go-packages | where: 'Support', 'deprecated' %}
{% else %}
  {% assign packages = site.data.releases.latest.go-packages | where: 'Type', include.type | where: 'New', 'true' | where_exp: 'item', "item.Support <> 'deprecated'" %}
{% endif %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/tabs.md lang="go" active=include.type %}

{% include releases/variables/go.md %}

{% include releases/pkgtable.md type=include.type %}
