{% if page.header %}
{% include releases/header.md %}
{% endif %}

## JavaScript

{% assign packages = site.data.releases.latest.js-packages %}
{% assign packageType = "data" %}

**New Libraries** | [Mgmt Libraries]({{ site.baseurl }}{% link releases/latest/mgmt/js.md %}) | [All Libraries]({{ site.baseurl }}{% link releases/latest/all/js.md %})

{% include js-packages.html %}