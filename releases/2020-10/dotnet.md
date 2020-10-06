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

- _Add packages_

#### Beta

- Event Hubs
- Tables

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.Data.Tables --version 3.0.0-beta.2
$> dotnet add package Azure.Messaging.EventHubs --version 5.3.0-beta.3
$> dotnet add package Azure.Messaging.EventHubs.Processor --version 5.3.0-beta.3
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure.Data.Tables [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/tables/Azure.Data.Tables/CHANGELOG.md#300-beta2-2020-10-06)

#### New Features

- Implemented batch operations.
- `TableClient`'s `GetEntity` method now exposes the `select` query option to allow for more efficient existence checks for a table entity.

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md)

#### New Features

- `EventData` has been integrated with the new Schema Registry service, via use of the `SchemaRegistryAvroObjectSerializer` with the `BodyAsBinaryData` member.

- The `EventHubProducerClient` now offers the ability to opt-into idempotent publishing, reducing the potential for duplication when a publishing operation encounters timeouts or other transient failures.

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md)

#### New Features

- `EventData` has been integrated with the new Schema Registry service, via use of the `SchemaRegistryAvroObjectSerializer` with the `BodyAsBinaryData` member.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
