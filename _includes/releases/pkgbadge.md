{% if include.url != "NA" %}
<a href="{{ include.url }}"><button type="button" class="btn btn-primary {% if include.preview == 'true' %}btn-preview{% endif %}">{{ include.label }} <span class="badge">{{version}}</span></button></a>
{% else %}
<button type="button" class="btn btn-primary {% if include.preview == 'true' %}btn-preview{% endif %}">{{ include.label }}<span class="badge">NA</span></button>
{% endif %}