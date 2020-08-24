---
title: Azure SDK for .NET (September 2020)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our September 2020 client library releases.

#### GA

- Form Recognizer

#### Updates

- _Add packages_

#### Preview

- _Add packages_

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet install Azure.AI.FormRecognizer --version 3.0.0
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/formrecognizer/Azure.AI.FormRecognizer/CHANGELOG.md#300-2020-08-20)

- First stable release of the Azure.AI.FormRecognizer package.

#### New Features

- Added `FormRecognizerModelFactory` static class to support mocking model types.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
