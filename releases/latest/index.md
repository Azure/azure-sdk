---
title: Azure SDK Latest Releases
layout: default
sidebar: releases_sidebar
permalink: /releases/latest/index.html
---

# Azure SDK Latest Releases

## [.NET packages](dotnet.html)

{% assign packages = site.data.releases[site[latest_version]].dotnet-packages %}
{% include dotnet-packages.html %}

## [Java packages](java.html)

{% assign packages = site.data.releases[site[latest_version]].java-packages %}
{% include java-packages.html %}

## [JavaScript packages](js.html)

{% assign packages = site.data.releases[site[latest_version]].js-packages %}
{% include js-packages.html %}

## [Python packages](python.html)

{% assign packages = site.data.releases[site[latest_version]].python-packages %}
{% include python-packages.html %}
