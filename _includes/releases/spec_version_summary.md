{% if include.versions.size > 0 %}
{% assign sortedVersions = include.versions | sort: "Version" | reverse %}
{% assign firstSpec = sortedVersions[0] %}
{% assign firstSpecParts = firstSpec.SpecPath | split: '/' %}
{% if firstSpecParts.size > 1 %}
  {% assign firstSpecReadmePath = firstSpecParts[0] | append: '/' | append: firstSpecParts[1] | append: '/readme.md' %}
{% else %}
  {% assign firstSpecReadmePath = firstSpec.SpecPath %}
{% endif %}
<details>
  <summary>
    <a href="https://github.com/Azure/azure-rest-api-specs/blob/main/specification/{{ firstSpecReadmePath }}">{{ firstSpec.Version }}</a>
  </summary>
  <ul>  
  {% for spec in sortedVersions %}
    {% assign specParts = spec.SpecPath | split: '/' %}
    {% if specParts.size > 1 %}
      {% assign specReadmePath = specParts[0] | append: '/' | append: specParts[1] | append: '/readme.md' %}
    {% else %}
      {% assign specReadmePath = spec.SpecPath %}
    {% endif %}
    <li><a href="https://github.com/Azure/azure-rest-api-specs/blob/main/specification/{{ specReadmePath }}">{{ spec.SpecPath }}</a> {% if spec.DateCreated <> '' %}<small> - <i>Created on {{ spec.DateCreated }}</i></small>{% endif %}
    </li>
  {% endfor %}
  </ul>
</details>
{% endif %}
