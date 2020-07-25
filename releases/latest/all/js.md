---
title: Azure SDK for JavaScript (All)
layout: default
tags: javascript typescript
sidebar: releases_sidebar
header: true
---
{% if page.header %}
{% include releases/header.md %}
{% endif %}

## JavaScript

{% assign packages = site.data.releases.latest.dotnet-packages %}
{% assign packageType = "" %}

There are {{ packages.size }} total Azure library packages published to npm from the [azure-sdk account](https://www.npmjs.com/~azure-sdk).

[New Libraries]({{ site.baseurl }}{% link releases/latest/js.md %})| [Mgmt Libraries]({{ site.baseurl }}{% link releases/latest/mgmt/js.md %}) | **All Libraries**

{% include js-packages.html %}

{% include refs.md %}
