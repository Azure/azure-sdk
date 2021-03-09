---
title: Azure SDK for .NET (March 2021)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

<!--
[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to announce our March 2021 client library releases.

#### GA

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta

[pattern.beta]: # (- ${PackageFriendlyName})

- Form Recognizer

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet install Azure.AI.FormRecognizer --version 3.1.0-beta.3
```

[pattern]: # ($> dotnet install ${PackageName} --version ${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights

[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

### Form Recognizer 3.1.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/formrecognizer/Azure.AI.FormRecognizer/CHANGELOG.md#310-beta3-2021-03-09)

#### New features
- Added protected constructors for mocking to `Operation` types, such as `TrainingOperation` and `RecognizeContentOperation`.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
