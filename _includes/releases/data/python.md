{% if page.header %}
{% include releases/shared/header.md %}
{% endif %}

## Python

{% assign packages = site.data.releases.new.python-packages | where: 'Type', 'Data' %}

{% include releases/nav/tabs.md lang="python" active="data" %}

{% include releases/variables/python.md %}

{% include releases/shared/pkgtable.md %}