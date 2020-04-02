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

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

    $> dotnet add package Azure.Messaging.ServiceBus --version 7.0.0-preview.1

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Service Bus [Changelog](https://www.nuget.org/packages/Azure.Storage.Files.DataLake/)

- Initial preview of the Azure.Messaging.ServiceBus library enabling you to send/receive/settle messages from queues/topics and session support.

## Latest Releases

{% assign packages = site.data.releases.latest.dotnet-packages %}
{% include dotnet-packages.html %}

{% include refs.md %}
