---
title: Azure SDK for .NET (October 2020)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our October 2020 client library releases.

#### GA

- _Add packages_

#### Updates

- Management Library - Compute
- Management Library - Network
- Management Library - Resources
- Management Library - Storage

#### Beta

- Management Library - CosmosDB
- Management Library - DNS
- Management Library - Insight

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet install PACKAGE --version whatever

$> dotnet install Azure.ResourceManager.Compute --version 1.0.0-preview.2
$> dotnet install Azure.ResourceManager.Network --version 1.0.0-preview.2
$> dotnet install Azure.ResourceManager.Resources --version 1.0.0-preview.2
$> dotnet install Azure.ResourceManager.Storage --version 1.0.0-preview.2

$> dotnet install Azure.ResourceManager.CosmosDB --version 1.0.0-preview.1
$> dotnet install Azure.ResourceManager.Dns --version 1.0.0-preview.1
$> dotnet install Azure.ResourceManager.Insights --version 1.0.0-preview.1
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### New Management Libraries
A new set of management libraries that follow the [Azure SDK Design Guidelines for .NET](https://azure.github.io/azure-sdk/dotnet_introduction.html) and based on [Azure.Core libraries](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/core/Azure.Core) are now in Public Preview. These new libraries provide a number of core capabilities that are shared amongst all Azure SDKs, including the intuitive Azure Identity library, an HTTP Pipeline with custom policies, error-handling, distributed tracing, and much more. You can find the list of new packages [on this page](https://aka.ms/azsdk/releases).

To get started with these new libraries, please see the [quickstart guide here](http://aka.ms/azsdk/net/mgmt). These new libraries can be identifed by namespaces that start with `Azure.ResourceManager`, e.g. `Azure.ResourceManager.Network`

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
