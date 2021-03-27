{% assign trimmedPackage = item.Package | remove: package_trim %}

{% assign package_url = package_url_template | replace: 'item.Package', item.Package | replace: 'item.TrimmedPackage', trimmedPackage | replace: 'item.GroupId', item.GroupId | replace: 'item.RepoPath', item.RepoPath %}

{% assign version = item[include.version] %}

{% if item.RepoPath == "NA" or item.RepoPath contains "http" %}
    {% assign source_url = item.RepoPath %}
{% else %}
    {% assign source_url = source_url_template | replace: 'item.Package', item.Package | replace: 'item.TrimmedPackage', trimmedPackage | replace: 'item.RepoPath', item.RepoPath %}
{% endif %}

{% if version != "" %}
    {% assign url = package_url | replace: 'item.Version', version  %}
    {% include releases/pkgbadge.md  label=package_label url=url version=version preview=include.preview %}

    {% assign url = source_url | replace: 'item.Version', version %}
    {% include releases/pkgbadge.md label="Code" url=url version=version preview=include.preview %}
    
    {% if include.version == "VersionGA" %}
        {% assign msdocs_url = item.MSDocs %}
        {% if item.MSDocs == "" %}
            {% assign msdocs_url = msdocs_url_template | replace: 'item.Package', item.Package | replace: 'item.TrimmedPackage', trimmedPackage %}
            {% if item.VersionGA == "" and item.VersionPreview != "" and pre_suffix.size > 0 %}
                {% assign msdocs_url = msdocs_url | append: pre_suffix %}
            {% endif %}
        {% endif %}
        {% assign url = msdocs_url | replace: 'item.Version', version %}
        {% include releases/pkgbadge.md label="Docs" url=url version=version %}  
    {% else %}
        {% assign ghdocs_url = item.GHDocs %}
        {% if item.GHDocs == "" %}
            {% assign ghdocs_url = ghdocs_url_template | replace: 'item.Package', item.Package | replace: 'item.TrimmedPackage', trimmedPackage %}
        {% endif %}
    
        {% assign url = ghdocs_url | replace: 'item.Version', version %}
        {% include releases/pkgbadge.md label="Docs" url=url version=version preview="true" %}        
    {% endif %}
{% endif %}