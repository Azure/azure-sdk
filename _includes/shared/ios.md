{% include shared/header.md %}

## iOS

{% assign packages = site.data.releases.latest.ios-packages %}

{{ description | replace: 'PackageCount', packages.size }}

{% include shared/variables/ios.md %}

{% include {{page.scope}}/pkgtable.md %}