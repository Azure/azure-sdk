{% include releases/header.md type=include.type %}

## C++

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.cpp-packages | where_exp: 'item', "item.Support <> 'deprecated'" %}
{% elsif include.type == "deprecated" %}
  {% assign packages = site.data.releases.latest.cpp-packages | where: 'Support', 'deprecated' | where_exp: 'item', "item.Support <> 'deprecated'" %}
{% else %}
  {% assign packages = site.data.releases.latest.cpp-packages | where: 'Type', include.type | where: 'New', 'true' | where_exp: 'item', "item.Support <> 'deprecated'" %}
{% endif %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/variables/cpp.md %}

{% include releases/pkgtable.md type=include.type %}