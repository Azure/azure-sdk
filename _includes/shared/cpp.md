{% include shared/header.md %}

## C++

{% assign packages = site.data.releases.latest.cpp-packages %}

{{ description | replace: 'PackageCount', packages.size }}

{% include shared/variables/cpp.md %}

{% include {{page.scope}}/pkgtable.md %}