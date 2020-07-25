{% if page.header %}
{% include releases/header.md %}
{% endif %}

## Python

{% assign packages = site.data.releases.latest.python-packages %}
{% assign packageType = "data" %}

**New Libraries** | [Mgmt Libraries]({{ site.baseurl }}{% link releases/latest/mgmt/python.md %}) | [All Libraries]({{ site.baseurl }}{% link releases/latest/all/python.md %})

{% include python-packages.html %}
