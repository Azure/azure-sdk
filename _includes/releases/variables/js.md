{% assign package_label = "npm" %}
{% assign package_trim = "@azure/" %}
{% assign pre_suffix = ?view=azure-node-preview&amp;preserve-view=true" %}
{% assign package_root_url_template = "https://www.npmjs.com/package/item.Package" %}
{% assign package_url_template = "https://www.npmjs.com/package/item.Package/v/item.Version" %}
{% assign msdocs_url_template = "https://docs.microsoft.com/javascript/api/overview/azure/item.TrimmedPackage-readme" %}
{% assign ghdocs_url_template = "https://azuresdkdocs.blob.core.windows.net/$web/javascript/azure-item.TrimmedPackage/item.Version/index.html" %}
{% assign source_url_template = "https://github.com/Azure/azure-sdk-for-js/tree/item.Package_item.Version/sdk/item.RepoPath/item.TrimmedPackage/" %}