{% if page.header %}
{% include releases/header.md %}
{% endif %}

## .NET

{% assign packages = site.data.releases.latest.dotnet-packages %}

{% include releases/nav/tabs.md dataurl="/releases/latest/dotnet.html" mgmturl="/releases/latest/mgmt/dotnet.html" allurl="/releases/latest/all/dotnet.html" active="data" %}

{% include dotnet-packages.html %}