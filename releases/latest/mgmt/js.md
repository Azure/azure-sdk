---
title: Azure SDK for JavaScript (Latest)
layout: default
tags: javascript typescript
sidebar: releases_sidebar
header: true
---
{% if page.header %}
{% include releases/header.md %}
{% endif %}

## JavaScript

{% assign packages = site.data.releases.latest.js-packages %}
{% assign packageType = "mgmt" %}

[New Libraries]({{ site.baseurl }}{% link releases/latest/js.md %}) | **Mgmt Libraries** | [All Libraries]({{ site.baseurl }}{% link releases/latest/all/js.md %})

{% include js-packages.html %}

{% include refs.md %}
