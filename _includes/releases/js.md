{% include releases/header.md type=include.type %}

## JavaScript

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.js-packages | where_exp: 'item', "item.Support <> 'deprecated'" %}
{% elsif include.type == "deprecated" %}
  {% assign packages = site.data.releases.latest.js-packages | where: 'Support', 'deprecated' %}
{% else %}
  {% assign packages = site.data.releases.latest.js-packages | where: 'Type', include.type | where: 'New', 'true' | where_exp: 'item', "item.Support <> 'deprecated'" %}
{% endif %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/tabs.md lang="js" active=include.type %}

{% include releases/variables/js.md %}

{% include releases/pkgtable.md type=include.type %}