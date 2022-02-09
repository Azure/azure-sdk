{% include releases/header.md type=include.type %}

## Embedded C

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.c-packages %}
{% elsif include.type == "retired" %}
  {% assign packages = site.data.releases.latest.c-packages | where: 'Support', 'retired' %}
{% else %}
  {% assign packages = site.data.releases.latest.c-packages | where: 'Type', include.type | where: 'New', 'true' %}
{% endif %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/variables/c.md %}

{% include releases/pkgtable.md type=include.type %}