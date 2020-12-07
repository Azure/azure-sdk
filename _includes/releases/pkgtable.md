<table>
<tr>
  <th class="table-display-text-th table-display-name-th">Display Name</th>
  <th>Package</th>
  <th>Microsoft Docs</th>
  <th>GitHub Docs</th>
  <th>Source</th>
  <th class="table-display-text-th">Notes</th>
</tr>
<tbody id="myTable">
{% for item in packages %}

{% include releases/pkgrow.md %}

{% endfor %}
</tbody>
</table>
