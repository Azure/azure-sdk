---
title: Azure SDK for .NET (July 2020)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our July 2020 client library releases.

#### GA

- Text Analytics

#### Updates

- _Add packages_

#### Preview

- _Add packages_

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
 $> dotnet add package Azure.AI.TextAnalytics 
```


## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Text Analytics 

#### 1.0.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#101-2020-06-23)

#### Key Bug Fixes
- The document confidence scores for analyze sentiment now contains the values the Text Analytics service returns. (Issue [#12889](https://github.com/Azure/azure-sdk-for-net/issues/12889)).

## Latest Releases

{% assign packages = site.data.releases.latest.dotnet-packages %}
{% include dotnet-packages.html %}

{% include refs.md %}
