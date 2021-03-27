{% if include.url != "NA" %}
<a href="{{ include.url }}" class="text-nowrap">

    {% if include.label == package_label %}
        <button type="button" class="btn btn-primary {% if include.preview == 'true' %}btn-preview{% endif %}" title="{{ item.Package }}">{{ include.label }} <span class="badge {% if include.preview == 'true' %}badge-preview{% endif %}" >{{ include.version }}</span></button>
    {% else %}
        {{ include.label }}
    {% endif %}

</a>
{% endif %}