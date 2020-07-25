---
title: Azure SDK for Java (All)
layout: default
tags: java
sidebar: releases_sidebar
header: true
---
{% if page.header %}
{% include releases/header.md %}
{% endif %}

## Java

{% assign packages = site.data.releases.latest.dotnet-packages %}
{% assign packageType = "" %}

There are {{ packages.size }} total Azure library packages published to maven central from the [azure-sdk account](https://search.maven.org/search?q=g:com.microsoft.azure%20OR%20g:com.azure).

[New Libraries]({{ site.baseurl }}{% link releases/latest/java.md %})| [Mgmt Libraries]({{ site.baseurl }}{% link releases/latest/mgmt/java.md %}) | **All Libraries**

{% include java-packages.html %}

{% include refs.md %}
