{% assign versions = item.PlannedVersions | split: "|" %}
{% for version in versions %}
    {% if forloop.last %}
        {% assign versionParts = version | split: "," %}
        {% assign versionNumber = versionParts[0] %}
        {% assign versionDateParts = versionParts[1] | split: "/" %}
        {% assign versionDateQuarter = versionDateParts[0] | divided_by: 3.0 | ceil %}
        {% capture versionDateString %}Q{{versionDateQuarter}}-{{versionDateParts[2]}}{% endcapture %}
        {% unless versionNumber contains "b" || versionNumber contains "p" %}
            {{ versionDateString }}
        {% endunless%}
    {% endif %}
{% endfor %}