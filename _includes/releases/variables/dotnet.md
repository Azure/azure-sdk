{% assign package_label = "NuGet" %}
{% assign package_trim = "Azure." %}
{% assign pre_suffix = "?view=azure-dotnet-preview&amp;preserve-view=true" %}
{% assign package_root_url_template = "https://www.nuget.org/packages/item.Package" %}
{% assign package_url_template = "https://www.nuget.org/packages/item.Package/item.Version" %}
{% assign msdocs_url_template = "https://learn.microsoft.com/dotnet/api/overview/azure/item.TrimmedPackage-readme" %}
{% assign ghdocs_url_template = "https://azuresdkdocs.z19.web.core.windows.net/dotnet/item.Package/item.Version/index.html" %}
{% assign source_url_template = "https://github.com/Azure/azure-sdk-for-net/tree/item.Package_item.Version/sdk/item.RepoPath/item.Package/" %}
{% assign nuget_service_index_url = "https://api.nuget.org/v3/index.json" %}
{% assign nuget_registration_service = "RegistrationsBaseUrl/3.6.0" %}
{% assign nuget_deprecation_service = "PackagePublish/2.0.0" %}
{% assign nuget_package_content_service = "PackageBaseAddress/3.0.0" %}

