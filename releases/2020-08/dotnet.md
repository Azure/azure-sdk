---
title: Azure SDK for .NET (August 2020)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our August 2020 client library releases.

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

### Azure.Core (https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Azure.Core/CHANGELOG.md#140-2020-08-06)

#### Added
- Added `ObjectSerializer` base class for serialization.
- Added `IMemberNameConverter` for converting member names to serialized property names.
- Added `JsonObjectSerializer` that implements `ObjectSerializer` for `System.Text.Json`.

#### Fixed
- Connection leak for retried non-buffered requests on .NET Framework.


### Azure.Core.Experimental (https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Azure.Core.Experimental/CHANGELOG.md#010-preview3-2020-08-06)

#### Breaking Changes
- `ObjectSerializer`: Moved to `Azure.Core`.

### _Package name_ 

- Major changes only!!!

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
