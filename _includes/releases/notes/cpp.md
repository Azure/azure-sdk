## Release highlights

{% include releases/notes/release_highlights.md %}

## Latest Releases

View all the latest versions of C++ packages [here][cpp-latest-releases].

## Installation Instructions

To install the packages, copy and paste the following commands into a terminal:

{% assign allPackagesSortedByName = allPackages | sort: 'Name' | uniq: 'Name' %}
{%- capture install_instructions -%}
{% for package in allPackagesSortedByName %}
    {%- capture install_instruction -%}
    $> vcpkg add port {{ package.Name }}-cpp
    {%- endcapture -%}
    {{ install_instruction }}
{% endfor %}
{%- endcapture -%}
```
{{ install_instructions | rstrip }}
```
{: .language-bash}

You can also install the packages from source:

```bash
# From Source
git clone https://github.com/Azure/azure-sdk-for-cpp
# git checkout <tag_name>
# For example:
git checkout azure-storage-blobs_12.0.0
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/Azure/azure-sdk-for-cpp/issues).

{% include refs.md %}
