{% if page.header %}
{% include releases/shared/header.md %}
{% endif %}

## JavaScript

{% assign packages = site.data.releases.all.js-packages %}

There are {{ packages.size }} total Azure library packages published to npm from the [azure-sdk account](https://www.npmjs.com/~azure-sdk).

{% include releases/nav/tabs.md lang="js" active="all" %}

{% include releases/variables/js.md %}
{% assign package_url_template = "https://www.npmjs.com/package/item.Package/v/item.Version" %}
{% include releases/all/pkgtable.md %}