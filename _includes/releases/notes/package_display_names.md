{% assign allPackagesSortedByDisplayName = allPackages | sort: 'DisplayName' %}
{% assign gaPackages = allPackagesSortedByDisplayName | where: "VersionType" , "GA" | map: 'DisplayName' | uniq %}
{% if gaPackages.size > 0 %}
#### Stable Packages
{% for package in gaPackages %}
- {{ package }}
{% endfor %}

{{ gaPackages.size }} Stable packages
{% endif %}

{% assign patchPackages = allPackagesSortedByDisplayName | where: "VersionType", "Patch" | map: 'DisplayName' | uniq %}
{% if patchPackages.size > 0 %}
#### Patch Updates
{% for package in patchPackages %}
- {{ package }}
{% endfor %}

{{ patchPackages.size }} updated packages
{% endif %}

{% assign betaPackages = allPackagesSortedByDisplayName | where: "VersionType", "Beta" | map: 'DisplayName' | uniq %}
{% if betaPackages.size > 0 %}
#### Beta Packages
{% for package in betaPackages %}
- {{ package }}
{% endfor %}

{{ betaPackages.size }} beta packages
{% endif %}

Total of {{ allPackages.size }} packages released this month.
