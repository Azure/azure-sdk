{% include releases/header.md %}

## iOS

{% assign packages = site.data.releases.latest.ios-packages %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/variables/ios.md %}

{% include releases/pkgtable.md %}