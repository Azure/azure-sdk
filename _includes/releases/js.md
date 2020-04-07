{% if page.header %}
{% include releases/header.md %}
{% endif %}

## JavaScript

{% assign packages = site.data.releases.latest.js-packages %}

**New Libraries** | [All Libraries]({{ site.baseurl }}{% link releases/latest/all/js.md %})

{% include js-packages.html %}