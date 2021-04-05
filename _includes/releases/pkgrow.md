{% if item.Hide != "true" %}

    {% assign trimmedPackage = item.Package | remove: package_trim %}
        
    {% assign package_url = package_url_template | replace: 'item.Package', item.Package | replace: 'item.TrimmedPackage', trimmedPackage | replace: 'item.GroupId', item.GroupId | replace: 'item.RepoPath', item.RepoPath %}
    
    <tr scope="row">
        <td title="{{ item.Package }}">
            <div>{{ item.DisplayName }} {% if include.type == "all" and item.New == "true" %}<i>(New)</i>{%endif%}</div>
            <div><small class="text-muted">{{item.Package}}</small></div>
            <div>{% include releases/replace.md %}</div>
        </td>
        <td>{% include releases/links.md version="VersionGA" %}</td>
        <td>{% include releases/links.md version="VersionPreview" preview="true" %}</td>
        <td class="text-nowrap">{% include releases/roadmap.md %}</td>
    </tr>

{% endif %}