{% include releases/header.md %}

## Python

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.python-packages %}
{% elsif include.type == "deprecated" %}
  {% assign packages = site.data.releases.latest.python-packages | where: 'Support', 'deprecated' %}
{% else %}
  {% assign packages = site.data.releases.latest.python-packages | where: 'Type', include.type | where: 'New', 'true' %}
{% endif %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/tabs.md lang="python" active=include.type %}

{% include releases/variables/python.md %}

{% include releases/pkgtable.md type=include.type %}