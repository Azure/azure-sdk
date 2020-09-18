{% include releases/header.md %}

## Embedded C

{% assign packages = site.data.releases.latest.c-packages %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/variables/c.md %}

{% include releases/pkgtable.md %}