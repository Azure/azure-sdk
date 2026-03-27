{% include releases/header.md type=include.type %}

## iOS

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.ios-packages | where_exp: 'item', "item.Support <> 'deprecated'" %}
{% elsif include.type == "deprecated" %}
  {% assign packages = site.data.releases.latest.ios-packages | where: 'Support', 'deprecated' %}
{% else %}
  {% assign packages = site.data.releases.latest.ios-packages | where: 'Type', include.type | where: 'New', 'true' | where_exp: 'item', "item.Support <> 'deprecated'" %}
{% endif %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/variables/ios.md %}

{% include releases/pkgtable.md type=include.type %}