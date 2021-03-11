{% include shared/header.md %}

## Android

{% assign packages = site.data.releases.latest.android-packages %}

{{ description | replace: 'PackageCount', packages.size }}

{% include shared/variables/android.md %}

{% include {{page.scope}}/pkgtable.md %}