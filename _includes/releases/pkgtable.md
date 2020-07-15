<table>
<tr>
  <th>Display Name</th>
  <th>Package</th>
  <th>MS Docs</th>
  <th>GH Docs</th>
  <th>Source</th>
</tr>
<tbody id="myTable">
{% for item in packages %}

{% include releases/pkgrow.md %}

{% endfor %}
</tbody>
</table>