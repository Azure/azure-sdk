<tr>
    {% if item.Hide != "true" %}
        <td>{{ item.DisplayName }}</td>
        <td>
            {% assign url = package_url_template | replace: 'item.Package', item.Package | replace: 'item.Version', item.Version | replace: 'item.GroupId', item.GroupId %}
            {% include releases/pkgbadge.md label=package_label url=url version=item.Version %}
        </td>
        <td>{{ item.Notes }}</td>
    {% endif %}
</tr>