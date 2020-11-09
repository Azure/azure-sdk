---
title: Azure SDK for .NET (November 2020)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our November 2020 client library releases.

#### GA

- _Add packages_

#### Updates

- _Add packages_

#### Beta

- Tables

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.Data.Tables --version 3.0.0-beta.3
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights

### Tables [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/3ff84e738c517daf3c451fd39a6f126855ac3b95/sdk/tables/Azure.Data.Tables/CHANGELOG.md)

### New Features

- Added support for Upsert batch operations.
- Added support for some numeric type coercion for TableEntity properties.
- Added TryGetFailedEntityFromException method on TablesTransactionalBatch to extract the entity that caused a batch failure from a RequestFailedException.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
