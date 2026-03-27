{% if item.Hide != "true" %}

    <!-- Add simple begin marker to mimic supporting beginning of word regex syntax -->
    {% assign trimmedPackage = item.Package | prepend: "^" %}
    {% assign packageTrim = package_trim | prepend: "^" %}

    {% assign trimmedPackage = trimmedPackage | remove: packageTrim | remove: "^" %}

    {% if package_url_template contains "item.RepoPath" and item.RepoPath contains "http" %}
        {% assign package_url = item.RepoPath %}
    {% else %}
        {% assign package_url = package_url_template | replace: 'item.Package', item.Package | replace: 'item.TrimmedPackage', trimmedPackage | replace: 'item.GroupId', item.GroupId | replace: 'item.RepoPath', item.RepoPath %}
    {% endif %}

    <tr scope="row">
        <td title="{{ item.Package }}">
            <div><strong>{{ item.DisplayName }} {% if include.type == "all" and item.New == "true" %}<i>(New)</i>{%endif%}</strong></div>
            <div><small>{{item.Package}}</small></div>
            <div>{% include releases/replace.md %}</div>
        </td>
    {% if include.type != "deprecated" %}
        <td>{% include releases/links.md version="VersionGA" %}</td>
        <td>{% include releases/links.md version="VersionPreview" preview="true" %}</td>
        <td class="text-nowrap">{% include releases/roadmap.md %}</td>
    {% else %}
        <!-- For deprecated packages we just want whichever version we have it doesn't matter if it is GA or preview -->
        {% if item.VersionGA != "" %}
            <td>{% include releases/links.md version="VersionGA" %}</td>
        {% else %}
            <td>{% include releases/links.md version="VersionPreview" %}</td>
        {% endif %}
    {% endif %}
    </tr>

{% endif %}
