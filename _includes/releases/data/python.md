{% if page.header %}
{% include releases/shared/header.md %}
{% endif %}

## Python

{% assign packages = site.data.releases.data.python-packages %}

{% include releases/nav/tabs.md lang="python" active="data" %}

{% include releases/variables/python.md %}

{% include releases/shared/pkgtable.md %}