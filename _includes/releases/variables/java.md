{% assign package_label = "Maven" %}
{% assign package_trim = "azure-" %}
{% assign pre_suffix = "?view=azure-java-preview&preserve-view=true" %}
{% assign package_root_url_template = "https://search.maven.org/artifact/item.GroupId/item.Package" %}
{% assign package_url_template = "https://search.maven.org/artifact/item.GroupId/item.Package/item.Version/jar/" %}
{% assign msdocs_url_template =  "https://docs.microsoft.com/java/api/overview/azure/item.TrimmedPackage-readme" %}
{% assign ghdocs_url_template = "https://azuresdkdocs.blob.core.windows.net/$web/java/item.Package/item.Version/index.html" %}
{% assign source_url_template = "https://github.com/Azure/azure-sdk-for-java/tree/item.Package_item.Version/sdk/item.RepoPath/item.Package/" %}