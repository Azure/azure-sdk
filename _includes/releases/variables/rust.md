{% assign package_label = "crate" %}
{% assign pre_suffix = "" %}
{% assign package_root_url_template = "https://crates.io/crates/item.Package" %}
{% assign package_url_template = "https://crates.io/crates/item.Package/item.Version" %}
<!-- Currently for rust we don't have any docs published -->
{% assign msdocs_url_template = "https://docs.rs/item.Package/item.Version" %}
<!-- {% assign ghdocs_url_template = "https://azuresdkdocs.z19.web.core.windows.net/rust/item.Package/item.Version/index.html" %} -->
{% assign source_url_template = "https://github.com/Azure/azure-sdk-for-rust/tree/item.Package@item.Version/sdk/item.RepoPath/item.Package" %}
