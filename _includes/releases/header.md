{% if header_included != 'true' %}
# Azure SDK Releases

This page contains links to all of the Azure SDK library packages, code, and documentation.  The "Client and Management Libraries" tabs contain libraries that follow the new [Azure SDK Guidelines](https://aka.ms/azsdk/guide).  The "All" tab also contains libraries that do not yet follow the new guidelines.

<small>Last updated: {{ 'now' | date: "%b %Y" }}</small>

<div class="search-group">
    <input class="form-control" id="myInput" type="text" placeholder="Search...">
    <img
        alt="Copy filter to clipboard"
        class="search-share search-share-hide"
        id="searchShare"
        title="Copy filter link to clipboard"
        src="{{ "/images/share.png" | relative_url }}"
        tabindex=0
        >
</div>

{% assign header_included = 'true' %}
{% endif %}