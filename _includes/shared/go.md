{% include shared/header.md %}

## Go

{% assign packages = site.data.releases.latest.go-packages %}

{{ description | replace: 'PackageCount', packages.size }}

{% include shared/variables/go.md %}

{% include {{page.scope}}/pkgtable.md %}