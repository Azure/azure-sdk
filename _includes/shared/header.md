{% if header_included != 'true' %}
# Azure SDK {{ page.scope | capitalize }}

<input class="form-control" id="myInput" type="text" placeholder="Search...">
<br>
{% assign header_included = 'true' %}
{% endif %}