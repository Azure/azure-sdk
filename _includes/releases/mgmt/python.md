{% if page.header %}
{% include releases/shared/header.md %}
{% endif %}

## Python

{% assign packages = site.data.releases.new.python-packages | where: 'Type', 'Mgmt' %}

{% include releases/nav/tabs.md lang="python" active="mgmt" %}

{% include releases/variables/python.md %}

{% include releases/shared/pkgtable.md %}
