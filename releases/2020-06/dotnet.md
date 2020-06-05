---
title: Azure SDK for .NET (June 2020)
layout: post
date: 2020-06-09
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our {{ page.date | date: "%B %Y" }} client library releases.

#### GA

- Text Analytics


#### Updates


#### Preview

- Text Analytics

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
 $> dotnet add package Azure.AI.TextAnalytics
 $> dotnet add package Azure.AI.TextAnalytics --version 1.0.0-preview.5
 $> dotnet add package Azure.Extensions.AspNetCore.Configuration.Secrets
 $> dotnet add package Azure.Extensions.AspNetCore.DataProtection.Keys
 $> dotnet add package Azure.Extensions.AspNetCore.DataProtection.Blobs
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Text Analytics 

#### 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#100-2020-06-09)

- General availability release.

#### 1.0.0-preview.5 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#100-preview5-2020-05-27)

##### Breaking Changes
- Updated the models to correspond with service changes.

##### New Features
- Client library now targets the service's v3.0 API, instead of the v3.0-preview.1 API.

### Core Experimental [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Core.Experimental_0.1.0-preview.1/sdk/core/Azure.Core.Experimental/CHANGELOG.md)

#### New Features
- Added serialization primitives: `ObjectSerializer`,`JsonObjectSerializer`
- Added spatial geometry types.
- Added `BinaryData` type.

### Core [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Core_1.2.2/sdk/core/Azure.Core/CHANGELOG.md)

#### Key Bug Fixes
- Retry server timeouts on .NET Framework.

### Azure.Extensions.AspNetCore.Configuration.Secrets [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Extensions.AspNetCore.Configuration.Secrets_1.0.0/sdk/extensions/Azure.Extensions.AspNetCore.Configuration.Secrets/CHANGELOG.md)

- General availability release.

### Azure.Extensions.AspNetCore.DataProtection.Keys [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Extensions.AspNetCore.DataProtection.Keys_1.0.0/sdk/extensions/Azure.Extensions.AspNetCore.DataProtection.Keys/CHANGELOG.md)

- General availability release.

### Azure.Extensions.AspNetCore.DataProtection.Blobs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Extensions.AspNetCore.DataProtection.Blobs_1.0.0/sdk/extensions/Azure.Extensions.AspNetCore.DataProtection.Blobs/CHANGELOG.md)

- General availability release.

## Latest Releases

{% assign packages = site.data.releases.latest.dotnet-packages %}
{% include dotnet-packages.html %}

{% include refs.md %}
