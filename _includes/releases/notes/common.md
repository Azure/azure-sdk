{% assign releaseData = site.data.releases.[include.date].[include.language] %}
{% if releaseData.content %}
{% capture releaseReferences %}{% include refs.md %}{% endcapture %}
{% assign releaseMonth = page.date | date: "%B %Y" %}
{{ releaseData.content | replace: "%%RELEASE_REFERENCES%%", releaseReferences | replace: "%%SITE_BASEURL%%", site.baseurl | replace: "%%PAGE_MONTH%%", releaseMonth }}
{% else %}
{% assign allPackages = releaseData.entries %}
{% if allPackages %}
The Azure SDK team is pleased to announce our {{ include.displayDate }} client library releases.

{% assign allPackages = allPackages | where: "Hidden", false | sort: 'ServiceName' %}
{{ allPackages.size }} packages released this month.

{% include releases/notes/package_display_names.md %}
{% include releases/notes/{{ include.language }}.md %}

{% else %}
No packages released this month.
{% endif %}
{% endif %}
