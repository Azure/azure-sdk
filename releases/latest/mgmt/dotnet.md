---
title: Azure SDK for .NET (Mgmt)
layout: default
tags: dotnet
sidebar: releases_sidebar
header: true
---
{% if page.header %}
{% include releases/header.md %}
{% endif %}

## .NET

{% assign packages = site.data.releases.latest.dotnet-packages %}
{% assign packageType = "mgmt" %}

[New Libraries]({{ site.baseurl }}{% link releases/latest/dotnet.md %}) | **Mgmt Libraries** | [All Libraries]({{ site.baseurl }}{% link releases/latest/all/dotnet.md %})

{% include dotnet-packages.html %}