{% include releases/header.md type=include.type %}

## Rust

{% if include.type == "all" %}
  {% assign packages = site.data.releases.latest.rust-packages | where_exp: 'item', "item.Support <> 'deprecated'" %}
{% elsif include.type == "deprecated" %}
  {% assign packages = site.data.releases.latest.rust-packages | where: 'Support', 'deprecated' | where_exp: 'item', "item.Support <> 'deprecated'" %}
{% else %}
  {% assign packages = site.data.releases.latest.rust-packages | where: 'Type', include.type | where: 'New', 'true' | where_exp: 'item', "item.Support <> 'deprecated'" %}
{% endif %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/variables/rust.md %}

{% include releases/pkgtable.md type=include.type %}