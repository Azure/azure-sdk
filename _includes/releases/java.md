{% if page.header %}
{% include releases/header.md %}
{% endif %}

## Java

{% assign packages = site.data.releases.latest.java-packages %}

**New Libraries** | [All Libraries]({{ site.baseurl }}{% link releases/latest/all/java.md %})

{% include java-packages.html %}