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

{% for item in packages %}

{% include {{page.scope}}/pkgrow.md %}

{% endfor %}
</tbody>
</table>
