<table>
<tr>
  <th class="table-display-text-th table-display-name-th">Name</th>
  <th>Latest GA</th>
  <th>Latest Beta</th>
  <th>Next GA</th>
  <th>Notes</th>
</tr>
<tbody id="myTable">

{% for item in packages %}

{% include roadmap/pkgrow.md %}

{% endfor %}

</tbody>
</table>
