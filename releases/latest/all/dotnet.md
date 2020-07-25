---
title: Azure SDK for .NET (All)
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
{% assign packageType = "" %}

There are {{ packages.size }} total Azure library packages published to nuget from the [azure-sdk account](https://www.nuget.org/profiles/azure-sdk).

[New Libraries]({{ site.baseurl }}{% link releases/latest/dotnet.md %})| [Mgmt Libraries]({{ site.baseurl }}{% link releases/latest/mgmt/dotnet.md %}) | **All Libraries**

{% include dotnet-packages.html %}