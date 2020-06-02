<table>
<tr>
  <th>Service</th>
  <th>Package</th>
  <th>Notes</th>
</tr>
<tbody id="myTable">
{% for item in packages %}

{% include releases/all/pkgrow.md %}

{% endfor %}
</tbody>
</table>