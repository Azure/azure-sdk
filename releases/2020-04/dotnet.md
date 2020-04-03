---
title: Azure SDK for .NET (April 2020)
layout: post
date: April 2020
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our April 2020 client library releases.

#### GA

#### Updates

#### Preview

- Service Bus
- Text Analytics

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

    $> dotnet add package Azure.AI.TextAnalytics --version 1.0.0-preview.4
    
    $> dotnet add package Azure.Messaging.ServiceBus --version 7.0.0-preview.1

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#100-preview4-2020-04-07)

- Remove the `RecognizePiiEntities` endpoint and all related models.
- Add mock support for the Text Analytics client with respective samples.
- Add integration for ASP.NET Core.

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/servicebus/Azure.Messaging.ServiceBus/CHANGELOG.md)

- Initial preview of the Azure.Messaging.ServiceBus library enabling you to send/receive/settle messages from queues/topics and session support.

## Latest Releases

{% assign packages = site.data.releases.latest.dotnet-packages %}
{% include dotnet-packages.html %}

{% include refs.md %}
