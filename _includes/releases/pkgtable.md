<table>
<tr>
  <th class="table-display-text-th table-display-name-th">Name</th>
  <th>Package</th>
  <th>Microsoft Docs</th>
  {% if docs_header_label == undefined || docs_header_label == "" %}
    {% assign docs_header_label = "GitHub Docs" %}
  {% endif %}
  <th>{{ docs_header_label }}</th>
  <th>Source</th>
  <th class="table-display-text-th">Notes</th>
</tr>
<tbody id="myTable">

{% if page.scope == "roadmap" %}
    {% assign packages = packages | where_exp: "item", "item.PlannedVersions != ''" %}
{% endif %}

{% for item in packages %}

{% include {{page.scope}}/pkgrow.md %}

{% endfor %}
</tbody>
</table>
