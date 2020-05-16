{% if page.header %}
{% include releases/shared/header.md %}
{% endif %}

## Java

{% assign packages = site.data.releases.data.java-packages %}

{% include releases/nav/tabs.md lang="java" active="data" %}

{% include releases/variables/java.md %}

{% include releases/shared/pkgtable.md %}