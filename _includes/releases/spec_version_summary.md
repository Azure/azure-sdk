{% if include.versions.size > 0 %}
{% assign sortedVersions = include.versions | sort: "Version" | reverse %}
{% assign firstSpec = sortedVersions[0] %}
<details>
  <summary>
    <a href="https://github.com/Azure/azure-rest-api-specs/tree/main/specification/{{ firstSpec.SpecPath }}">{{ firstSpec.Version }}</a>
  </summary>
  <ul>  
  {% for spec in sortedVersions %}
    <li><a href="https://github.com/Azure/azure-rest-api-specs/blob/main/specification/{{ spec.SpecPath }}">{{ spec.SpecPath }} </a></li>
  {% endfor %}
  </ul>
</details>
{% endif %}