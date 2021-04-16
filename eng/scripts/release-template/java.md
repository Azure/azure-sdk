---
title: Azure SDK for Java (%%MMMM yyyy%%)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our %%MMMM yyyy%% client library releases.

{% assign packages = site.data.package_data.%%yyyy-MM%%.java['newEntries'] | where: "versionType" , "GA" | sort: 'service' | sort: 'friendlyName' %}
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

{% assign packages = site.data.package_data.%%yyyy-MM%%.java['newEntries'] | where: "versionType", "Patch" | sort: 'service' | sort: 'friendlyName' %}
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

{% assign packages = site.data.package_data.%%yyyy-MM%%.java['newEntries'] | where: "versionType", "Beta" | sort: 'service' | sort: 'friendlyName' %}
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

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

{% assign packages = site.data.package_data.%%yyyy-MM%%.java['newEntries'] | sort: 'service' | sort: 'name' %}
{%- capture install_instructions -%}
{% for package in packages %}
    {%- capture install_instruction -%}
<dependency>
{{ "  " }}<groupId>{{ package.groupId }}</groupId>
{{ "  " }}<artifactId>{{ package.name }}</artifactId>
{{ "  " }}<version>{{ package.version }}</version>
</dependency>
{{""}}
    {%- endcapture -%}
    {{ install_instruction }}
{% endfor %}
{%- endcapture -%}

```
{{ install_instructions | rstrip }}
```
{: .language-xml}

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights

{% for package in packages %}
### {{ package.friendlyName }} {{ package.version }} [Changelog]({{ package.changelogUrl }})
<p>{{ package.content | markdownify }}</p>
{% endfor %}

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
