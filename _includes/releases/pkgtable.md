
<table class="table table-bordered">
<tr>
  <th class="table-display-text-th table-display-name-th" scope="col">Name</th>
  <th scope="col">Stable</th>
  <th scope="col">Beta</th>
  <th scope="col">Next Stable</th>
  <th class="table-notes-th" scope="col">Notes</th>
</tr>
<tbody id="myTable">

{% for item in packages %}

{% include releases/pkgrow.md %}

{% endfor %}

</tbody>
</table>