{% if page.header %}
{% include releases/header.md %}
{% endif %}

## JavaScript

{% assign packages = site.data.releases.latest.js-packages %}

{% include releases/nav/tabs.md dataurl="/releases/latest/js.html" mgmturl="/releases/latest/mgmt/js.html" allurl="/releases/latest/all/js.html" active="data" %}

{% include js-packages.html %}