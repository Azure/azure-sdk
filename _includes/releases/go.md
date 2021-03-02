{% include releases/header.md %}

## Go

{% assign packages = site.data.releases.latest.go-packages %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/tabs.md lang="go" active=include.type %}

{% include releases/variables/go.md %}

{% include releases/pkgtable.md %}
