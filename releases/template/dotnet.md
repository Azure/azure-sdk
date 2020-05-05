---
title: Azure SDK for .NET (%%MONTH%% %%YEAR%%)
layout: post
date: %%RELEASEDATE%%
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our {{ page.date | date: "%B %Y" }} client library releases.

#### GA

- _Add packages_

#### Updates

- _Add packages_

#### Preview

- _Add packages_

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet install PACKAGE --version whatever
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### _Package name_ [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/LINK/CHANGELOG.md)

- Major changes only!!!

## Latest Releases

{% assign packages = site.data.releases.latest.dotnet-packages %}
{% include dotnet-packages.html %}

{% include refs.md %}
