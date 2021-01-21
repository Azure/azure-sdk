{% if item.Hide != "true" %}
<tr>
  <td class="table-display-text-th">{{ item.DisplayName }}</td>
  <td>
    {% assign trimmedPackage = item.Package | remove: package_trim %}

    {% assign package_url = package_url_template | replace: 'item.Package', item.Package | replace: 'item.TrimmedPackage', trimmedPackage | replace: 'item.GroupId', item.GroupId | replace: 'item.RepoPath', item.RepoPath %}
    {% if item.VersionGA != "" %}
        {% assign url = package_url | replace: 'item.Version', item.VersionGA  %}
        {% include releases/pkgbadge.md  label=package_label url=url version=item.VersionGA %}
    {% endif %}

    {% if item.VersionPreview != "" %}
        {% assign url = package_url | replace: 'item.Version', item.VersionPreview  %}
        {% include releases/pkgbadge.md  label=package_label preview="true" url=url version=item.VersionPreview %}
    {% endif %}
  </td>
  <td>
    {% assign msdocs_url = item.MSDocs %}
    {% if item.MSDocs == "" %}
        {% assign msdocs_url = msdocs_url_template | replace: 'item.Package', item.Package | replace: 'item.TrimmedPackage', trimmedPackage %}
        {% if item.VersionGA == "" and item.VersionPreview != "" and pre_suffix.size > 0 %}
            {% assign msdocs_url = msdocs_url | append: pre_suffix %}
        {% endif %}
    {% endif %}

    {% if item.VersionGA != "" %}
        {% assign url = msdocs_url | replace: 'item.Version', item.VersionGA %}
        {% include releases/pkgbadge.md label="msdocs" url=url version=item.VersionGA %}
    {% endif %}

    {% if item.VersionGA == "" and item.VersionPreview != "" %}
        {% assign url = msdocs_url | replace: 'item.Version', item.VersionPreview %}
        {% include releases/pkgbadge.md label="msdocs" preview="true" url=url version=item.VersionPreview %}
    {% endif %}
  </td>
  <td>
    {% assign ghdocs_url = item.GHDocs %}
    {% if item.GHDocs == "" %}
        {% assign ghdocs_url = ghdocs_url_template | replace: 'item.Package', item.Package | replace: 'item.TrimmedPackage', trimmedPackage %}
    {% endif %}

    {% if item.VersionGA != "" %}
        {% assign url = ghdocs_url | replace: 'item.Version', item.VersionGA %}
        {% if docs_label == undefined || docs_label == "" %}
            {% assign docs_label = "ghdocs" %}
        {% endif %}
        {% include releases/pkgbadge.md label=docs_label url=url version=item.VersionGA %}
    {% endif %}

    {% if item.VersionPreview != "" %}
        {% assign url = ghdocs_url | replace: 'item.Version', item.VersionPreview %}
        {% if docs_label != "" %}
            {% include releases/pkgbadge.md label=docs_label preview="true" url=url version=item.VersionPreview %}
        {% else %}
            {% include releases/pkgbadge.md label="ghdocs" preview="true" url=url version=item.VersionPreview %}
        {% endif %}
    {% endif %}
  </td>
  <td>
    {% if item.RepoPath == "NA" or item.RepoPath contains "http" %}
        {% assign source_url = item.RepoPath %}
    {% else %}
        {% assign source_url = source_url_template | replace: 'item.Package', item.Package | replace: 'item.TrimmedPackage', trimmedPackage | replace: 'item.RepoPath', item.RepoPath %}
    {% endif %}

    {% if item.VersionGA != "" %}
        {% assign url = source_url | replace: 'item.Version', item.VersionGA %}
        {% include releases/pkgbadge.md label="github" url=url version=item.VersionGA %}
    {% endif %}

    {% if item.VersionPreview != "" %}
        {% assign url = source_url | replace: 'item.Version', item.VersionPreview %}
        {% include releases/pkgbadge.md label="github" preview="true" url=url version=item.VersionPreview %}
    {% endif %}
  </td>
  <td class="table-display-text-th">{{ item.Notes }}</td>
</tr>
{% endif %}