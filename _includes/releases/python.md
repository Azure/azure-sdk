{% if page.header %}
{% include releases/header.md %}
{% endif %}

## Python

{% assign packages = site.data.releases.latest.python-packages %}

**New Libraries** | [All Libraries]({% link releases/latest/all/python.md %})

{% include python-packages.html %}
