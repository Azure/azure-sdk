{% if page.header %}
{% include releases/shared/header.md %}
{% endif %}

## JavaScript

{% assign packages = site.data.releases.new.js-packages | where: 'Type', 'Data' %}

{% include releases/nav/tabs.md lang="js" active="data" %}

{% include releases/variables/js.md %}

{% include releases/shared/pkgtable.md %}