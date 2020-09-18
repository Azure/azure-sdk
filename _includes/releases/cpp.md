{% include releases/header.md %}

## C++

{% assign packages = site.data.releases.latest.cpp-packages %}

{{ description | replace: 'PackageCount', packages.size }}

{% include releases/variables/cpp.md %}

{% include releases/pkgtable.md %}