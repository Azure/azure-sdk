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

<tr>
<td class="table-display-text-th">{{ item.DisplayName }}</td>
<td>
    {% assign trimmedPackage = item.Package | remove: package_trim %}
    
    {% assign package_url = package_url_template | replace: 'item.Package', item.Package | replace: 'item.TrimmedPackage', trimmedPackage | replace: 'item.GroupId', item.GroupId | replace: 'item.RepoPath', item.RepoPath %}
    
    {% if item.VersionGA != "" %}
        {% assign url = package_url | replace: 'item.Version', item.VersionGA  %}
        {% include shared/pkgbadge.md  label=package_label url=url version=item.VersionGA %}
    {% elsif item.VersionPreview != "" %}
        {% assign url = package_url | replace: 'item.Version', item.VersionPreview  %}
        {% include shared/pkgbadge.md  label=package_label preview="true" url=url version=item.VersionPreview %}
        <br/>    
        {{item.Notes}}
    {% endif %}
</td>
<td>{{ gaDate }}</td>
<td>

    {% if item.VersionGA != "" %}
        GA
    {% elsif item.VersionPreview != "" %}
        Public Preview
    {% else %}
        In Development
    {% endif%}
</td>

</tr>
{% endif %}
