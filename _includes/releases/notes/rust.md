## Release highlights

{% include releases/notes/release_highlights.md %}

## Latest Releases

View all the latest versions of Rust crates [here][rust-latest-releases].

## Installation Instructions

To install any of our crates, copy and paste the following commands into a terminal:

{% assign allPackagesSortedByName = allPackages | sort: 'Name' %}
{%- capture install_instructions -%}
{% for package in allPackagesSortedByName %}
    {%- capture install_instruction -%}
    $> cargo add {{ package.Name }}@{{ package.Version }}
    {%- endcapture -%}
    {{ install_instruction }}
{% endfor %}
{%- endcapture -%}
```
{{ install_instructions | rstrip }}
```
{: .language-bash}

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/Azure/azure-sdk-for-rust/issues).

{% include refs.md %}
