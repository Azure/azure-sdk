{% include shared/header.md %}

## Java

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.java-packages %}
{% else %}
  {% assign packages = site.data.releases.latest.java-packages | where: 'Type', include.type | where: 'New', 'true' %}
{% endif %}

{{ description | replace: 'PackageCount', packages.size }}

{% include shared/tabs.md lang="java" active=include.type %}

{% include shared/variables/java.md %}

{% include {{page.scope}}/pkgtable.md %}