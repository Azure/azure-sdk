{% if page.header %}
{% include releases/shared/header.md %}
{% endif %}

## Java

{% assign packages = site.data.releases.all.java-packages %}

There are {{ packages.size }} total Azure library packages published to maven central from the [azure-sdk account](https://search.maven.org/search?q=g:com.microsoft.azure%20OR%20g:com.azure).

{% include releases/nav/tabs.md lang="java" active="all" %}

{% include releases/variables/python.md %}

{% include releases/all/pkgtable.md %}