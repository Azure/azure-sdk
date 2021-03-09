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

- Identity
- Tables

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash

$> dotnet add package Azure.Identity
$> dotnet add package Azure.Data.Tables

```

[pattern]: # ($> dotnet install ${PackageName} --version ${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights

- Identity [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Identity_1.4.0-beta.4/sdk/identity/Azure.Identity/CHANGELOG.md)
- Tables [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Data.Tables_12.0.0-beta.6/sdk/tables/Azure.Data.Tables/CHANGELOG.md)

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
