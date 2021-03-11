{% include shared/header.md %}

## JavaScript

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.js-packages %}
{% else %}
  {% assign packages = site.data.releases.latest.js-packages | where: 'Type', include.type | where: 'New', 'true' %}
{% endif %}

{{ description | replace: 'PackageCount', packages.size }}

{% include shared/tabs.md lang="js" active=include.type %}

{% include shared/variables/js.md %}

{% include {{page.scope}}/pkgtable.md %}