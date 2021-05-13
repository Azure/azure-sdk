{% for package in allPackagesSortedByDisplayName %}
### {{ package.DisplayName }} {{ package.Version }} [Changelog]({{ package.ChangelogUrl }})
{{ package.ChangelogContent }}
{% endfor %}