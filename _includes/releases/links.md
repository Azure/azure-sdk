{% assign version = item[include.version] %}

{% if version != "" %}
    {% assign url = package_url | replace: 'item.Version', version  %}
    <div>
    {% include releases/pkgbadge.md  label=package_label url=url version=version preview=include.preview %}
    </div>
    <div>

    {% if item.RepoPath == "NA" or item.RepoPath contains "http" %}
        {% assign source_url = item.RepoPath %}
    {% else %}
        {% assign source_url = source_url_template  | replace: 'item.RepoPath', item.RepoPath %}
    {% endif %}

    {% assign code_url = source_url | replace: 'item.Package', item.Package | replace: 'item.TrimmedPackage', trimmedPackage | replace: 'item.Version', version | replace: 'item.GroupId', item.GroupId %}
    {% include releases/pkgbadge.md label="Code" url=code_url version=version preview=include.preview %}

    {% if item.MSDocs != "NA" %}
        {% assign msdocs_url = item.MSDocs %}
        {% if item.MSDocs == "" %}
            {% assign msdocs_url = msdocs_url_template | replace: 'item.Package', item.Package | replace: 'item.TrimmedPackage', trimmedPackage %}
            {% if item.VersionGA == "" and item.VersionPreview != "" and pre_suffix.size > 0 %}
                {% assign msdocs_url = msdocs_url | append: pre_suffix %}
            {% endif %}
        {% endif %}
        {% if code_url != "" and code_url != "NA" and msdocs_url != "" and msdocs_url != "NA" %}
            &nbsp;|&nbsp;
        {% endif %}
        {% include releases/pkgbadge.md label="Docs" url=msdocs_url version=version %}
    {% else %}
        {% assign ghdocs_url = item.GHDocs %}
        {% if item.GHDocs == "" %}
            {% assign ghdocs_url = ghdocs_url_template | replace: 'item.Package', item.Package | replace: 'item.TrimmedPackage', trimmedPackage %}
        {% endif %}

        {% assign ghdocs_url = ghdocs_url | replace: 'item.Version', version %}
         {% if code_url != "" and code_url != "NA" and ghdocs_url != "" and ghdocs_url != "NA" %}
            &nbsp;|&nbsp;
        {% endif %}
        {% include releases/pkgbadge.md label="Docs" url=ghdocs_url version=version preview="true" %}
    {% endif %}
    </div>
    {% if item.Support != "" and include.version == "VersionGA" %}
        <div>Support: <a href="https://aka.ms/azsdk/policies/support">{{ item.Support | capitalize }}</a></div>
        {% if item.Support == "deprecated" and item.EOLDate != "" %}
        <div>Support ends on {{ item.EOLDate }}</div>
        {% endif %}
    {% endif %}
{% endif %}
