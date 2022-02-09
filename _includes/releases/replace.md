{% if item.Replace != "" %}
    {% if item.New != "true" %}
    <div class="replacement"><small>Replaced By:
    {% assign replaceItems = item.Replace | split: "," %}
    <ul>
    {% for replaceItem in replaceItems %}
        {% assign replaceItemS = replaceItem | strip %}
        {% assign package_root_url = package_root_url_template | replace: 'item.GroupId/item.Package', replaceItemS | replace: 'item.Package', replaceItemS %}
        <li><a href="{{ package_root_url }}">{{ replaceItemS }}</a></li>
    {% endfor %}
    </ul>
    {% if item.ReplaceGuide != "" %}
    See <a href="{{ item.ReplaceGuide }}">migration guide</a>.
    {% endif %}
    </small>
    </div>
    {% endif%}
{% endif %}