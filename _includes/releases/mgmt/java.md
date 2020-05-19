{% if page.header %}
{% include releases/shared/header.md %}
{% endif %}


## Java

{% assign packages = site.data.releases.new.java-packages | where: 'Type', 'Mgmt' %}

{% include releases/nav/tabs.md lang="java" active="mgmt" %}

{% include releases/variables/java.md %}

{% assign source_url_template = "https://github.com/Azure/azure-sdk-for-java/tree/item.Package_item.Version/sdk/item.RepoPath/mgmt" %}

{% include releases/shared/pkgtable.md %}