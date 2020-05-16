{% if page.header %}
{% include releases/header.md %}
{% endif %}

## Java

{% assign packages = site.data.allpackages.java-packages %}

There are {{ packages.size }} total Azure library packages published to maven central from the [azure-sdk account](https://search.maven.org/search?q=g:com.microsoft.azure%20OR%20g:com.azure).

{% include releases/nav/tabs.md dataurl="/releases/latest/java.html" mgmturl="/releases/latest/mgmt/java.html" allurl="/releases/latest/all/java.html" active="all" %}

{% include java-allpackages.html %}