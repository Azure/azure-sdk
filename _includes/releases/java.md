{% if page.header %}
{% include releases/header.md %}
{% endif %}

## Java

{% assign packages = site.data.releases.latest.java-packages %}

{% include releases/nav/tabs.md dataurl="/releases/latest/java.html" mgmturl="/releases/latest/mgmt/java.html" allurl="/releases/latest/all/java.html" active="data" %}

{% include java-packages.html %}