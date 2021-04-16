---
title: Azure SDK for Python (%%MMMM yyyy%%)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the %%MMMM yyyy%% client library release.

{% assign packages = site.data.package_data.%%yyyy-MM%%.python['newEntries'] | where: "versionType" , "GA" | sort: 'service' | sort: 'friendlyName' %}
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

{% assign packages = site.data.package_data.%%yyyy-MM%%.python['newEntries'] | where: "versionType", "Patch" | sort: 'service' | sort: 'friendlyName' %}
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

{% assign packages = site.data.package_data.%%yyyy-MM%%.python['newEntries'] | where: "versionType", "Beta" | sort: 'service' | sort: 'friendlyName' %}
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

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

{% assign packages = site.data.package_data.%%yyyy-MM%%.python['newEntries'] | sort: 'service' | sort: 'name' %}
{%- capture install_instructions -%}
{% for package in packages %}
    {%- capture install_instruction -%}
    $> pip install {{ package.name }}=={{ package.version }}
    {%- endcapture -%}
    {{ install_instruction }}
{% endfor %}
{%- endcapture -%}
```
{{ install_instructions | rstrip }}
```
{: .language-bash}

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights

{% for package in packages %}
### {{ package.friendlyName }} {{ package.version }} [Changelog]({{ package.changelogUrl }})
<p>{{ package.content | markdownify }}</p>
{% endfor %}

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
