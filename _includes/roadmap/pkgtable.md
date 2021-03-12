<table>
<tr>
  <th class="table-display-text-th table-display-name-th">Name</th>
  <th>Current Version</th>
  <th>Next GA</th>
  <th>Status</th>
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
