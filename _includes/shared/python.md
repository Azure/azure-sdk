{% include shared/header.md %}

## Python

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.python-packages %}
{% else %}
  {% assign packages = site.data.releases.latest.python-packages | where: 'Type', include.type | where: 'New', 'true' %}
{% endif %}

{{ description | replace: 'PackageCount', packages.size }}

{% include shared/tabs.md lang="python" active=include.type %}

{% include shared/variables/python.md %}

{% include {{page.scope}}/pkgtable.md %}