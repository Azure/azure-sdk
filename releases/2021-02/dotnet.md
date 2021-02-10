---
title: Azure SDK for .NET (February 2021)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our February 2021 client library releases.

#### GA

- Event Hubs

#### Updates

+- Synapse

#### Beta

- _Add packages_

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.Messaging.EventHubs
$> dotnet add package Azure.Messaging.EventHubs.Processor

$> dotnet add package Azure.Analytics.Synapse.AccessControl --version 1.0.0-preview.3
$> dotnet add package Azure.Analytics.Synapse.Artifacts --version 1.0.0-preview.6
$> dotnet add package Azure.Analytics.Synapse.ManagedPrivateEndpoints --version 1.0.0-beta.2
$> dotnet add package Azure.Analytics.Synapse.Monitoring --version 1.0.0-beta.2
$> dotnet add package Azure.Analytics.Synapse.Spark --version 1.0.0-preview.4
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md)

#### New Features

- Connection strings can now be parsed into their key/value pairs using the `EventHubsConnectionStringProperties` class.

- The body of an event has been moved to the `EventData.EventBody` property and makes use of the new `BinaryData` type.  To preserve backwards compatibility, the existing `EventData.Body` property has been preserved with the current semantics.

- It is now possible to specify a custom endpoint to use for establishing the connection to the Event Hubs service in the `EventHubConnectionOptions` used by each of the clients.

#### Key Bug Fixes

- Upgraded the `Microsoft.Azure.Amqp` library to resolve crashes occurring in .NET 5.

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md)

#### New Features

- Additional options for tuning load balancing have been added to the `EventProcessorClientOptions`.

- It is now possible to specify a custom endpoint to use for establishing the connection to the Event Hubs service in the `EventHubConnectionOptions` for the processor.

- Interactions with Blob Storage have been tuned for better performance and more efficient resource use.  This will also improve start-up time, especially when using the `Greedy` load balancing strategy.

#### Key Bug Fixes

- Upgraded the `Microsoft.Azure.Amqp` library to resolve crashes occurring in .NET 5.

### Synapse Artifacts [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/synapse/Azure.Analytics.Synapse.Artifacts/CHANGELOG.md)
- Changed APIs on SparkJobDefinitionClient and SqlScriptClient to provide a Long Running Operation (LRO) when operations can be long in duration.
- Many models classes are now public.
- Added BigDataPoolsClient, IntegrationRuntimesClient, SqlPoolsClient, WorkspaceClient and associated support types.
- Support List/Get Synapse resources through data plane APIs.
- Support Rename operations.
- Support CICD operations.

### Synapse Spark [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/synapse/Azure.Analytics.Synapse.Spark/CHANGELOG.md)
- Changed APIs on SparkBatchClient and SparkSessionClient to provide a Long Running Operation (LRO) when operations can be long in duration.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
