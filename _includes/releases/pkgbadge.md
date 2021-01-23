{% if include.url != "NA" %}
<a href="{{ include.url }}"><button type="button" class="btn btn-primary {% if include.preview == 'true' %}btn-preview{% endif %}">{{ include.label }} <span class="badge {% if include.preview == 'true' %}badge-preview{% endif %}">{{ include.version }}</span></button></a>
{% endif %}