---
title: Azure SDK for Python (All)
layout: default
tags: python
sidebar: releases_sidebar
header: true
---
{% if page.header %}
{% include releases/header.md %}
{% endif %}

## Python

{% assign packages = site.data.releases.latest.dotnet-packages %}
{% assign packageType = "" %}

There are {{ packages.size }} total Azure library packages published to PyPI from the [azure-sdk account](https://pypi.org/user/azure-sdk/).

[New Libraries]({{ site.baseurl }}{% link releases/latest/python.md %})| [Mgmt Libraries]({{ site.baseurl }}{% link releases/latest/mgmt/python.md %}) | **All Libraries**

{% include python-packages.html %}

{% include refs.md %}
