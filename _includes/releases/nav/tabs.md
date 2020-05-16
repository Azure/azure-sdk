<ul class="nav nav-tabs">
  <li class="nav-item {% if include.active == 'data' %}active{% endif %}">
    <a class="nav-link" href="{{ site.baseurl }}{{ include.dataurl }}">Data Plane</a>
  </li>
  <li class="nav-item {% if include.active == 'mgmt' %}active{% endif %}">
    <a class="nav-link" href="{{ site.baseurl }}{{ include.mgmturl }}">Management Plane</a>
  </li>
  <li class="nav-item {% if include.active == 'all' %}active{% endif %}">
    <a class="nav-link" href="{{ site.baseurl }}{{ include.allurl }}">All</a>
  </li>
</ul>
