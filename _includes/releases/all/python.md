{% if page.header %}
{% include releases/header.md %}
{% endif %}

## Python

{% assign packages = site.data.allpackages.python-packages %}

There are {{ packages.size }} total Azure library packages published to PyPI from the [azure-sdk account](https://pypi.org/user/azure-sdk/).

{% include releases/nav/tabs.md dataurl="/releases/latest/python.html" mgmturl="/releases/latest/mgmt/python.html" allurl="/releases/latest/all/python.html" active="all" %}

{% include python-allpackages.html %}

