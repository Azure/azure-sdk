{% if page.header %}
{% include releases/header.md %}
{% endif %}

## JavaScript

{% assign packages = site.data.allpackages.js-packages %}

There are {{ packages.size }} total Azure library packages published to npm from the [azure-sdk account](https://www.npmjs.com/~azure-sdk).

{% include releases/nav/tabs.md dataurl="/releases/latest/js.html" mgmturl="/releases/latest/mgmt/js.html" allurl="/releases/latest/all/js.html" active="all" %}

{% include js-allpackages.html %}
