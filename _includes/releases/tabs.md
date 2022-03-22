{% if packages.size > 0 %}
{% if include.active != "deprecated" %}
<ul class="nav nav-tabs">
  <li class="nav-item {% if include.active == 'client' %}active{% endif %}">
    <a class="nav-link" href="{{ site.baseurl }}/releases/latest/{{ include.lang }}.html">Client Libraries</a>
  </li>
  <li class="nav-item {% if include.active == 'mgmt' %}active{% endif %}">
    <a class="nav-link" href="{{ site.baseurl }}/releases/latest/mgmt/{{ include.lang }}.html">Management Libraries</a>
  </li>
  <li class="nav-item {% if include.active == 'all' %}active{% endif %}">
    <a class="nav-link" href="{{ site.baseurl }}/releases/latest/all/{{ include.lang }}.html">All</a>
  </li>
</ul>
{% else %}
<ul class="nav nav-tabs">
  <li class="nav-item active">
    <a class="nav-link" href="{{ site.baseurl }}/releases/deprecated/{{ include.lang }}.html">Deprecated Libraries</a>
  </li>
</ul>
{% endif %}
{% endif %}