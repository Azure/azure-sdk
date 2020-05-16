{% if page.header %}
{% include releases/shared/header.md %}
{% endif %}

## Python

{% assign packages = site.data.releases.all.python-packages %}

There are {{ packages.size }} total Azure library packages published to PyPI from the [azure-sdk account](https://pypi.org/user/azure-sdk/).

{% include releases/nav/tabs.md lang="python" active="all" %}

{% include releases/variables/python.md %}

{% include releases/all/pkgtable.md %}
