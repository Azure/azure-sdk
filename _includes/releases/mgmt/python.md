{% if page.header %}
{% include releases/shared/header.md %}
{% endif %}

## Python

{% assign packages = site.data.releases.mgmt.python-packages %}

{% include releases/nav/tabs.md lang="python" active="mgmt" %}

{% include releases/variables/python.md %}

{% include releases/shared/pkgtable.md %}
