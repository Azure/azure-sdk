{% if page.header %}
{% include releases/shared/header.md %}
{% endif %}

## Java

{% assign packages = site.data.releases.new.java-packages | where: 'Type', 'Data' %}

{% include releases/nav/tabs.md lang="java" active="data" %}

{% include releases/variables/java.md %}

{% include releases/shared/pkgtable.md %}