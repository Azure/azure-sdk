{% include releases/header.md %}

## Android

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.android-packages %}
{% elsif include.type == "retired" %}
  {% assign packages = site.data.releases.latest.android-packages | where: 'Support', 'maintenance' %}
{% else %}
  {% assign packages = site.data.releases.latest.android-packages | where: 'Type', include.type | where: 'New', 'true' %}
{% endif %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/variables/android.md %}

{% include releases/pkgtable.md type=include.type %}