<tr>
  <td>{{ item.DisplayName }}</td>
  <td>
    {% assign trimmedPackage = item.Package | remove: package_trim %}

    {% assign package_url = package_url_template | replace: 'item.Package', item.Package | replace: 'item.TrimmedPackage', trimmedPackage | replace: 'item.GroupId', item.GroupId %}
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
    {% endif %}

    {% if item.VersionGA != "" %}
        {% assign url = msdocs_url | replace: 'item.Version', item.VersionGA %}
        {% include releases/pkgbadge.md label="msdocs" url=url version=item.VersionGA %}
    {% endif %}

    {% if item.VersionPreview != "" %}
        {% if item.MSDocs != "NA" %}
            {% assign pre_suffix = '-pre' | append: msdocs_preview_moniker_suffix %}
            {% assign url = msdocs_url | replace: 'item.Version', item.VersionPreview | append: pre_suffix %}
            {% include releases/pkgbadge.md label="msdocs" preview="true" url=url version=item.VersionPreview %}
        {% endif %}
    {% endif %}
  </td>
  <td>
    {% assign ghdocs_url = item.GHDocs %}
    {% if item.GHDocs == "" %}
        {% assign ghdocs_url = ghdocs_url_template | replace: 'item.Package', item.Package | replace: 'item.TrimmedPackage', trimmedPackage %}
    {% endif %}

    {% if item.VersionGA != "" %}
        {% assign url = ghdocs_url | replace: 'item.Version', item.VersionGA %}
        {% include releases/pkgbadge.md label="ghdocs" url=url version=item.VersionGA %}
    {% endif %}

    {% if item.VersionPreview != "" %}
        {% assign url = ghdocs_url | replace: 'item.Version', item.VersionPreview %}
        {% include releases/pkgbadge.md label="ghdocs" preview="true" url=url version=item.VersionPreview %}
    {% endif %}
  </td>
  <td>
    {% if item.RepoPath contains "http" %}
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
</tr>

