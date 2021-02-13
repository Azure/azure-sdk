<table>
<tr>
  <th>Verb</th>
  <th>Parameters</th>
  <th>Returns</th>
  <th>Comments</th>
</tr>
<tbody id="verbsTable">
{% for item in data %}

{% include tables/standard_verbs_row.md %}

{% endfor %}
</tbody>
</table>
