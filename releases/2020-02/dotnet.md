---
title: Azure SDK for .NET (February 2020)
layout: post
date: February 2020
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our February 2020 client library releases.

#### GA

- Event Hubs
- Key Vault (Certificates)

#### Updates

- Key Vault (Keys, Secrets)
- Storage (Blobs, Blobs Batch, Queues, File Shares, DataLake)

#### Preview

- Text Analytics

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

    $> dotnet add package Azure.AI.TextAnalytics --version 1.0.0-preview.2

    $> dotnet add package Azure.Cosmos --version 4.0.0-preview

    $> dotnet add package Azure.Data.AppConfiguration --version 1.0.0-preview.4

    $> dotnet add package Azure.Identity

    $> dotnet add package Azure.Messaging.EventHubs 
    $> dotnet add package Azure.Messaging.EventHubs.Processor 

    $> dotnet add package Azure.Security.KeyVault.Certificates
    $> dotnet add package Azure.Security.KeyVault.Key
    $> dotnet add package Azure.Security.KeyVault.Secrets

    $> dotnet add package Azure.Storage.Blobs
    $> dotnet add package Azure.Storage.Blobs.Batch
    $> dotnet add package Azure.Storage.Files.DataLake --version 12.0.0-preview.8
    $> dotnet add package Azure.Storage.Files.Shares
    $> dotnet add package Azure.Storage.Queues

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Text Analytics

- Added the ability to create a TextAnalitycs client with a credential that can be updated in long-lived clients.
- The `TextAnalyticsError` model has been simplified and now collection objects include a `HasError` property that allows to check if an operation on a particular document succeeded or failed.
- All batch overload methods have been renamed by adding the suffix `Batch` or `BatchAsync` accordingly.
- All single text operation methods now return an atomic type of the operation result.
- Various types have been renamed. See the Text Analytics [changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#100-preview2-2020-02-11) for details.


## Latest Releases

{% assign packages = site.data.releases.latest.dotnet-packages %}
{% include dotnet-packages.html %}

{% include refs.md %}
