{% if item.Replace != "" and item.Replace != "NA" %}
    <div class="replacement"><small>Replaced By:
    {% assign replaceItems = item.Replace | split: "," %}
    <ul>
    {% for replaceItem in replaceItems %}
        {% assign replaceItemS = replaceItem | strip %}
        {% assign package_root_url = package_root_url_template | replace: 'item.GroupId/item.Package', replaceItemS | replace: 'item.Package', replaceItemS %}
        <li><a href="{{ package_root_url }}">{{ replaceItemS }}</a></li>
    {% endfor %}
    </ul>
    {% if item.ReplaceGuide != "" and item.ReplaceGuide != "NA" %}
    See <a href="{{ item.ReplaceGuide }}">migration guide</a>.
    {% endif %}
    </small>
    </div>
{% endif %}
