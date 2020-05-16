{% if page.header %}
{% include releases/shared/header.md %}
{% endif %}

## Java

{% assign packages = site.data.releases.mgmt.java-packages %}

{% include releases/nav/tabs.md lang="java" active="mgmt" %}

{% include releases/variables/java.md %}

{% include releases/shared/pkgtable.md %}