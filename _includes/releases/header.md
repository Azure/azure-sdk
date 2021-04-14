{% if header_included != 'true' %}
# Azure SDK Releases

This page contains links to all of the Azure SDK library packages, code, and documentation.  The "Client and Management Libraries" tabs contain libraries that follow the new [Azure SDK Guidelines](https://aka.ms/azsdk/guide).  The "All" tab also contains libraries that do not yet follow the new guidelines.

<small>Last updated: {{ 'now' | date: "%b %Y" }}</small>

<input class="form-control" id="myInput" type="text" placeholder="Search...">

{% assign header_included = 'true' %}
{% endif %}