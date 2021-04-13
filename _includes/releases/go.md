{% include releases/header.md %}

## Go

{% assign packages = site.data.releases.latest.go-packages %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/variables/go.md %}

{% include releases/pkgtable.md type=include.type %}