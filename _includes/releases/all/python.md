{% if page.header %}
{% include releases/header.md %}
{% endif %}

## Python

{% assign packages = site.data.allpackages.python-packages %}

There are {{ packages.size }} total Azure library packages published to PyPI from the [azure-sdk account](https://pypi.org/user/azure-sdk/).

[New Libraries]({{ site.baseurl }}{% link releases/latest/python.md %}) | **All Libraries**

{% include python-allpackages.html %}
