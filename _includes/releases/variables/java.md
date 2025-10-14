{% assign package_label = "Maven" %}
{% assign package_trim = "azure-" %}
{% assign pre_suffix = "?view=azure-java-preview&amp;preserve-view=true" %}
{% assign package_root_url_template = "https://central.sonatype.com/artifact/item.GroupId/item.Package" %}
{% assign package_url_template = "https://central.sonatype.com/artifact/item.GroupId/item.Package/item.Version" %}
{% assign msdocs_url_template =  "https://learn.microsoft.com/java/api/overview/azure/item.TrimmedPackage-readme" %}
{% assign ghdocs_url_template = "https://azuresdkdocs.z19.web.core.windows.net/java/item.Package/item.Version/index.html" %}
{% assign source_url_template = "https://github.com/Azure/azure-sdk-for-java/tree/item.Package_item.Version/sdk/item.RepoPath/item.Package/" %}
<!--
    TODO: How do we pick the correct link template? 
    - convert all existing tags to the new format?
    - hard-code a template for the existing versions until the next ship with the new template?
{% assign source_url_template = "https://github.com/Azure/azure-sdk-for-java/tree/item.GroupId+item.Package_item.Version/sdk/item.RepoPath/item.Package/" %}
-->
