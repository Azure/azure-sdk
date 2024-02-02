{% assign allPackages = site.data.releases.[include.date].[include.language].entries %}
{% if allPackages %}
The Azure SDK team is pleased to announce our {{ include.displayDate }} client library releases.

{{ allPackages.size }} packages released this month.
{% assign allPackages = allPackages | where: "Hidden", false | sort: 'ServiceName' %}

{% include releases/notes/package_display_names.md %}
{% include releases/notes/{{ include.language }}.md %}

{% else %}
No packages released this month.
{% endif %}
