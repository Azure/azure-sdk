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
        {% include releases/shared/pkgbadge.md  label=label url=url %}
    {% endif %}

    {% if item.VersionPreview != "" %}
        {% assign version = item.VersionPreview %}
        {% capture url %}
        {{ package_url_template | replace: 'item.Package', item.Package | replace: 'item.Version', version}}
        {% endcapture %}
        {% include releases/shared/pkgbadge.md  label=label preview="true" url=url %}
    {% endif %}
  </td>
  <td>
    {% if item.VersionGA != "" %}
        {% assign version = item.VersionGA %}
        {% capture url %}
        {% if item.DocsPath contains "http" %}
            {{item.DocsPath}}
        {% else %}
            {{ docs_url_template | replace: 'item.Package', item.Package | replace: 'item.Version', version}}
        {% endif %}
        {% endcapture %}
        {% include releases/shared/pkgbadge.md label="docs" url=url %}
    {% endif %}

    {% if item.VersionPreview != "" %}
        {% assign version = item.VersionPreview %}
        {% capture url %}
        {% if item.DocsPath contains "http" %}
            {{item.DocsPath}}
        {% else %}
            {{ docs_url_template | replace: 'item.Package', item.Package | replace: 'item.Version', version}}
        {% endif %}
        {% endcapture %}
        {% include releases/shared/pkgbadge.md label="docs" preview="true" url=url %}
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
        {% include releases/shared/pkgbadge.md label="github" url=url %}
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
        {% include releases/shared/pkgbadge.md label="github" preview="true" url=url %}
    {% endif %}
  </td>
</tr>

