<table>
<tr>
  <th>Service</th>
  <th>Package</th>
  <th>Documentation</th>
  <th>Source</th>
</tr>
<tbody id="myTable">
{% for item in packages %}

{% include releases/pkgrow.md %}

{% endfor %}
</tbody>
</table>