## Release highlights

{% include releases/notes/release_highlights.md %}

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

{% assign allPackagesSortedByName = allPackages | sort: 'Name' %}
{%- capture install_instructions -%}
{% for package in allPackagesSortedByName %}
    {%- capture install_instruction -%}
    $> npm install {{ package.Name }}@{{ package.Version }}
    {%- endcapture -%}
    {{ install_instruction }}
{% endfor %}
{%- endcapture -%}
```
{{ install_instructions | rstrip }}
```
{: .language-bash}

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

{% include refs.md %}
