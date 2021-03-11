{% include shared/header.md %}

## Embedded C

{% assign packages = site.data.releases.latest.c-packages %}

{{ description | replace: 'PackageCount', packages.size }}

{% include shared/variables/c.md %}

{% include {{page.scope}}/pkgtable.md %}