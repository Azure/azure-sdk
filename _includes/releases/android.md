{% include releases/header.md %}

## Android

{% assign packages = site.data.releases.latest.android-packages %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/variables/android.md %}

{% include releases/pkgtable.md %}