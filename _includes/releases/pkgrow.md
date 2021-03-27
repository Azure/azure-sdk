{% if item.Hide != "true" %}

{% assign versions = item.PlannedVersions | split: "|" %}
{% for version in versions %}
    {% if forloop.last %}
        {% assign versionParts = version | split: "," %}
        {% assign versionNumber = versionParts[0] %}
        {% assign versionDateParts = versionParts[1] | split: "/" %}
        {% assign versionDateQuarter = versionDateParts[0] | divided_by: 3.0 | ceil %}
        {% capture versionDateString %}Q{{versionDateQuarter}}-{{versionDateParts[2]}}{% endcapture %}
        {% unless versionNumber contains "b" || versionNumber contains "p" %}
            {% assign gaDate = versionDateString %}
        {% endunless%}
    {% endif %}
{% endfor %}

<tr scope="row">
    <td class="table-display-text-th" title="{{ item.Package }}">{{ item.DisplayName }}</td>
    <td>{% include releases/links.md version="VersionGA" %}</td>
    <td>{% include releases/links.md version="VersionPreview" preview="true" %}</td>
    <td class="text-nowrap">{{ gaDate }}</td>
    <td style="max-width: 100px">{{item.Notes}}</td>
</tr>

{% endif %}

