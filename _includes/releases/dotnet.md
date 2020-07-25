{% if page.header %}
{% include releases/header.md %}
{% endif %}

## .NET

{% assign packages = site.data.releases.latest.dotnet-packages %}
{% assign packageType = "data" %}

**New Libraries** | [Mgmt Libraries]({{ site.baseurl }}{% link releases/latest/mgmt/dotnet.md %}) | [All Libraries]({{ site.baseurl }}{% link releases/latest/all/dotnet.md %})

{% include dotnet-packages.html %}