{% if page.header %}
{% include releases/header.md %}
{% endif %}

## JavaScript

{% assign packages = site.data.allpackages.js-packages %}

There are {{ packages.size }} total Azure library packages published to npm from the [azure-sdk account](https://www.npmjs.com/~azure-sdk).

[New Libraries]({% link releases/latest/js.md %}) | **All Libraries**

{% include js-allpackages.html %}