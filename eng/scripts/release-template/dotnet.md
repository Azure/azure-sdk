---
title: Azure SDK for .NET (%%MMMM yyyy%%)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our %%MMMM yyyy%% client library releases.

{% assign packages = site.data.package_data.%%yyyy-MM%%.dotnet['newEntries'] | where: "versionType" , "GA" | sort: 'service' | sort: 'friendlyName' %}
{% if packages.size > 0 %}
<p>{{ '#### GA' | markdownify }}</p>
{% endif %}
<ul>
{% for package in packages %}
    <li>
    {{ package.friendlyName }}
    </li>
{% endfor %}
</ul>

{% assign packages = site.data.package_data.%%yyyy-MM%%.dotnet['newEntries'] | where: "versionType", "Patch" | sort: 'service' | sort: 'friendlyName' %}
{% if packages.size > 0 %}
{{ '#### Updates' | markdownify }}
{% endif %}
<ul>
{% for package in packages %}
    <li>
    {{ package.friendlyName }}
    </li>
{% endfor %}
</ul>

{% assign packages = site.data.package_data.%%yyyy-MM%%.dotnet['newEntries'] | where: "versionType", "Beta" | sort: 'service' | sort: 'friendlyName' %}
{% if packages.size > 0 %}
<p>{{ '#### Beta' | markdownify }}</p>
{% endif %}
<ul>
{% for package in packages %}
    <li>
    {{ package.friendlyName }}
    </li>
{% endfor %}
</ul>

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

% assign packages = site.data.package_data.%%yyyy-MM%%.dotnet['newEntries'] | sort: 'service' | sort: 'name' %}
{%- capture install_instructions -%}
{% for package in packages %}
    {%- capture install_instruction -%}
    $> dotnet add package {{ package.name }} --version {{ package.version }}
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

## Release highlights

{% for package in packages %}
### {{ package.friendlyName }} {{ package.version }} [Changelog]({{ package.changelogUrl }})
<p>{{ package.content | markdownify }}</p>
{% endfor %}

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
