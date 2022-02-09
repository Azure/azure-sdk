{% include releases/header.md type=include.type %}

## Go

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.go-packages %}
{% elsif include.type == "retired" %}
  {% assign packages = site.data.releases.latest.go-packages | where: 'Support', 'retired' %}
{% else %}
  {% assign packages = site.data.releases.latest.go-packages | where: 'Type', include.type | where: 'New', 'true' %}
{% endif %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/tabs.md lang="go" active=include.type %}

{% include releases/variables/go.md %}

{% include releases/pkgtable.md type=include.type %}
