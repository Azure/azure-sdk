# Azure Rest API Specifications

This page provides an inventory of all Azure Rest API Specifications from [azure-rest-api-specs](https://github.com/Azure/azure-rest-api-specs) repo. The **Data plane TypeSpec** and **Management TypeSpecs** only show services that have a TypeSpec defined. The **all** table shows all the specs both TypeSpec and OpenAPI. 

{% if include.type == "all" %}
  {% assign specs = site.data.releases.latest.specs %}
{% else %}
  {% assign specs = site.data.releases.latest.specs | where: 'Type', include.type | where: 'IsTypeSpec', 'True' %}
{% endif %}

{% include releases/header_search.md %}

<ul class="nav nav-tabs">
  <li class="nav-item {% if include.type == 'data' %}active{% endif %}">
    <a class="nav-link" href="{{ site.baseurl }}/releases/latest/specs.html">Dataplane TypeSpecs{% if include.type == 'data' %} ({{specs.size}}){% endif %}</a>
  </li>
  <li class="nav-item {% if include.type == 'mgmt' %}active{% endif %}">
    <a class="nav-link" href="{{ site.baseurl }}/releases/latest/mgmt/specs.html">Management TypeSpecs{% if include.type == 'mgmt' %} ({{specs.size}}){% endif %}</a>
  </li>
  <li class="nav-item {% if include.type == 'all' %}active{% endif %}">
    <a class="nav-link" href="{{ site.baseurl }}/releases/latest/all/specs.html">All{% if include.type == 'all' %} ({{specs.size}}){% endif %}</a>
  </li>
</ul>

<div class="table-responsive">
  <table class="table table-bordered table-condensed">
    <tr>
      <th scope="col" style="width: 25%;">Service</th>
      <th scope="col">Stable</th>
      <th scope="col">Preview</th>
    </tr>
    <tbody id="myTable">

    {% assign serviceFamilies = specs | group_by: "ServiceFamily" %}
    {% for serviceFamily in serviceFamilies %}
      {% assign resourceNames = serviceFamily.items | group_by: "ResourcePath" %}
      {% for resourceName in resourceNames %}
        {% assign typeSpecs = resourceName.items | where: 'IsTypeSpec', 'True' %}
        <tr scope="row">
          <td>{{ serviceFamily.name }} - {{ resourceName.name }} {% if typeSpecs.size > 0 %}<small><i>(TypeSpec)</i></small>{%endif%}</td>
          <td>
            {% assign stables = resourceName.items | where: 'VersionType', 'stable' %}
            {% include releases/spec_version_summary.md versions=stables %}
          </td>
          <td>
            {% assign previews = resourceName.items | where: 'VersionType', 'preview' %}
            {% include releases/spec_version_summary.md versions=previews %}
          </td>
        </tr>
      {% endfor %}
    {% endfor %}
    </tbody>
  </table>
</div>
