{% if page.header %}
{% include releases/header.md %}
{% endif %}

## Java

{% assign packages = site.data.releases.latest.java-packages %}
{% assign packageType = "data" %}

**New Libraries** | [Mgmt Libraries]({{ site.baseurl }}{% link releases/latest/mgmt/java.md %}) | [All Libraries]({{ site.baseurl }}{% link releases/latest/all/java.md %})

{% include java-packages.html %}