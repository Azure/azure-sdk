<table>
<tr>
  <th>Service</th>
  <th>Package</th>
  <th>Notes</th>
</tr>

{% for item in packages %}

{% include releases/all/pkgrow.md %}

{% endfor %}

</table>