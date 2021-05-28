{% include releases/header.md %}

## Go

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.go-packages %}
{% else %}
  {% assign packages = site.data.releases.latest.go-packages | where: 'Type', include.type | where: 'New', 'true' %}
{% endif %}

{% assign packages = site.data.releases.latest.go-packages %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/tabs.md lang="go" active=include.type %}

{% include releases/variables/go.md %}

{% include releases/pkgtable.md type=include.type %}