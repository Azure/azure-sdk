<div class="table-responsive">
    <table class="table table-bordered table-condensed">
        <tr>
          <th class="table-display-text-th table-display-name-th" scope="col">Name</th>
          <th scope="col">Stable</th>
          <th scope="col">Beta</th>
          <th scope="col">Next Stable</th>
        </tr>
        <tbody id="myTable">

        {% for item in packages %}
        
        {% include releases/pkgrow.md type=include.type %}
        
        {% endfor %}
        
        </tbody>
    </table>
</div>
