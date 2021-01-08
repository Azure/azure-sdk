{% assign package_label = "nuget" %}
{% assign package_trim = "Azure." %}
{% assign pre_suffix = "-pre" %}
{% assign package_url_template = "https://www.nuget.org/packages/item.Package/item.Version" %}
{% assign msdocs_url_template = "https://docs.microsoft.com/dotnet/api/overview/azure/item.TrimmedPackage-readme" %}
{% assign ghdocs_url_template = "https://azuresdkdocs.blob.core.windows.net/$web/dotnet/item.Package/item.Version/index.html" %}
{% assign source_url_template = "https://github.com/Azure/azure-sdk-for-net/tree/item.Package_item.Version/sdk/item.RepoPath/item.Package/" %}