{% if item.Replace != "" %}
    {% if item.New != "true" %}
    <div class="replacement"><small>Replaced By:
    {% assign replaceItems = item.Replace | split: "," %}
    <ul>
    {% for replaceItem in replaceItems %}
        {% assign replaceItem = replaceItem | strip %}
        {% assign package_root_url = package_root_url_template | replace: 'item.GroupId/item.Package', replaceItem | replace: 'item.Package', replaceItem %}
        <li><a href="{{ package_root_url }}">{{ replaceItem }}</a></li>
    {% endfor %}
    </ul>
    </small></div>
    {% endif%}
{% endif %}