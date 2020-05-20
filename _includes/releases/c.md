{% if page.header %}
{% include releases/header.md %}
{% endif %}

## C

{% assign packages = site.data.releases.latest.c-packages %}

{% include c-packages.html %}