{% if page.header %}
{% include releases/header.md %}
{% endif %}

## .NET

{% assign packages = site.data.releases.latest.dotnet-packages %}

**New Libraries** | [All Libraries]({{ site.baseurl }}{% link releases/latest/all/dotnet.md %})

{% include dotnet-packages.html %}