{% include releases/header.md type=include.type %}

## C++

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.cpp-packages %}
{% elsif include.type == "retired" %}
  {% assign packages = site.data.releases.latest.cpp-packages | where: 'Support', 'retired' %}
{% else %}
  {% assign packages = site.data.releases.latest.cpp-packages | where: 'Type', include.type | where: 'New', 'true' %}
{% endif %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/variables/cpp.md %}

{% include releases/pkgtable.md type=include.type %}