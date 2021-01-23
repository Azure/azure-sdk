{% include releases/header.md %}

## JavaScript

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.js-packages %}
{% else %}
  {% assign packages = site.data.releases.latest.js-packages | where: 'Type', include.type | where: 'New', 'true' %}
{% endif %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/tabs.md lang="js" active=include.type %}

{% include releases/variables/js.md %}

{% include releases/pkgtable.md %}