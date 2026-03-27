## Release highlights

{% include releases/notes/release_highlights.md %}

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

{% assign allPackagesSortedByName = allPackages | sort: 'Name' %}
{%- capture install_instructions -%}
{% for package in allPackagesSortedByName %}
    {%- capture install_instruction -%}
    $> dotnet add package {{ package.Name }} --version {{ package.Version }}
    {%- endcapture -%}
    {{ install_instruction }}
{% endfor %}
{%- endcapture -%}
```
{{ install_instructions | rstrip }}
```
{: .language-bash}

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

{% include refs.md %}
