{% if include.versions.size > 0 %}
{% assign sortedVersions = include.versions | sort: "Version" | reverse %}
{% assign firstSpec = sortedVersions[0] %}
{% assign firstSpecParts = firstSpec.SpecPath | split: '/' %}
{% assign firstSpecReadmePath = firstSpecParts[0] | append: '/' | append: firstSpecParts[1] | append: '/readme.md' %}
<details>
  <summary>
    <a href="https://github.com/Azure/azure-rest-api-specs/blob/main/specification/{{ firstSpecReadmePath }}">{{ firstSpec.Version }}</a>
  </summary>
  <ul>  
  {% for spec in sortedVersions %}
    {% assign specParts = spec.SpecPath | split: '/' %}
    {% assign specReadmePath = specParts[0] | append: '/' | append: specParts[1] | append: '/readme.md' %}
    <li><a href="https://github.com/Azure/azure-rest-api-specs/blob/main/specification/{{ specReadmePath }}">{{ spec.SpecPath }}{% if spec.SpecReadmeTag <> '' %}/readme.md-[{{ spec.SpecReadmeTag }}]{%endif%}</a> {% if spec.DateCreated <> '' %}<small> - <i>Created on {{ spec.DateCreated }}</i></small>{% endif %}
    </li>
  {% endfor %}
  </ul>
</details>
{% endif %}
