<tr>
  <td>{{ item.Service }}</td>
  <td>
    {% capture label %} 
        {{ package_label }}
    {% endcapture %}

    {% if item.VersionGA != "" %}
        {% assign version = item.VersionGA %}
        {% capture url %}
        {{ package_url_template | replace: 'item.Package', item.Package | replace: 'item.Version', version}}
        {% endcapture %}
        {% include releases/pkgbadge.md  label=label url=url %}
    {% endif %}

    {% if item.VersionPreview != "" %}
        {% assign version = item.VersionPreview %}
        {% capture url %}
        {{ package_url_template | replace: 'item.Package', item.Package | replace: 'item.Version', version}}
        {% endcapture %}
        {% include releases/pkgbadge.md  label=label preview="true" url=url %}
    {% endif %}
  </td>
  <td>
    {% if item.VersionGA != "" %}
        {% assign pkgPath = item.Package | remove: 'Azure.' | remove: 'azure-' %}
        {% assign url = item.MSDocs %}
        {% if item.MSDocs == "" %}
            {% assign url = msdocs_url_template | replace: 'item.Package', pkgPath %}
        {% endif %}
        {% include releases/pkgbadge.md label="msdocs" url=url %}
    {% endif %}

    {% if item.VersionPreview != "" %}
        {% assign pkgPath = item.Package | remove: 'Azure.' | remove: 'azure-' %}
        {% assign url = item.MSDocs %}
        {% if item.MSDocs == "" %}
            {% assign url = msdocs_url_template | replace: 'item.Package', pkgPath %}
        {% endif %}
        {% include releases/pkgbadge.md label="msdocs" preview="true" url=url %}
    {% endif %}
  </td>
  <td>
    {% if item.VersionGA != "" %}
        {% assign version = item.VersionGA %}
        {% assign url = item.GHDocs %}
        {% if item.GHDocs == "" %}
            {% assign url = ghdocs_url_template | replace: 'item.Package', item.Package | replace: 'item.Version', version %}
        {% endif %}
        {% include releases/pkgbadge.md label="ghdocs" url=url %}
    {% endif %}

    {% if item.VersionPreview != "" %}
        {% assign version = item.VersionPreview %}
        {% assign url = item.GHDocs %}
        {% if item.GHDocs == "" %}
            {% assign url = ghdocs_url_template | replace: 'item.Package', item.Package | replace: 'item.Version', version %}
        {% endif %}
        {% include releases/pkgbadge.md label="ghdocs" preview="true" url=url %}
    {% endif %}
  </td>
  <td>
    {% if item.VersionGA != "" %}
        {% assign version = item.VersionGA %}
        {% capture url %}
        {% if item.RepoPath contains "http" %}
            {{item.RepoPath}}
        {% else %}
            {{ source_url_template | replace: 'item.Package', item.Package | replace: 'item.Version', version | replace: 'item.RepoPath', item.RepoPath}}
        {% endif %}
        {% endcapture %}
        {% include releases/pkgbadge.md label="github" url=url %}
    {% endif %}

    {% if item.VersionPreview != "" %}
        {% assign version = item.VersionPreview %}
        {% capture url %}
        {% if item.RepoPath contains "http" %}
            {{item.RepoPath}}
        {% else %}
            {{ source_url_template | replace: 'item.Package', item.Package | replace: 'item.Version', version | replace: 'item.RepoPath', item.RepoPath}}
        {% endif %}
        {% endcapture %}
        {% include releases/pkgbadge.md label="github" preview="true" url=url %}
    {% endif %}
  </td>
</tr>

