{% if page.header %}
{% include releases/shared/header.md %}
{% endif %}

## JavaScript

{% assign packages = site.data.releases.mgmt.js-packages %}

{% include releases/nav/tabs.md lang="js" active="mgmt" %}

{% include releases/variables/js.md %}

{% include releases/shared/pkgtable.md %}