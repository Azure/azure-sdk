{% capture label %} 
    {{ package_label }}
{% endcapture %}

<tr>
    {% if item.Hide != "true" %}
        <td>{{ item.Service }}</td>
        <td>
                {% assign version = item.Version %}
                {% capture url %}
                {{ package_url_template | replace: 'item.Package', item.Package | replace: 'item.Version', version}}
                {% endcapture %}
                {% include releases/shared/pkgbadge.md label=label url=url %}
        </td>
        <td>{{ item.Notes }}</td>
    {% endif %}
</tr>