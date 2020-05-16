{% if page.header %}
{% include releases/header.md %}
{% endif %}

## Python

{% assign packages = site.data.releases.latest.python-packages %}

{% include releases/nav/tabs.md dataurl="/releases/latest/python.html" mgmturl="/releases/latest/mgmt/python.html" allurl="/releases/latest/all/python.html" active="data" %}

{% include python-packages.html %}
