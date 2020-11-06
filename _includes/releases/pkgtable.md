<table>
<tr>
  <th>Display Name</th>
  <th>Package</th>
  <th>Microsoft Docs</th>
  <th>GitHub Docs</th>
  <th>Source</th>
  <th>Notes</th>
</tr>
<tbody id="myTable">
{% for item in packages %}

{% include releases/pkgrow.md %}

{% endfor %}
</tbody>
</table>
