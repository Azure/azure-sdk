---
title: Azure SDK for .NET (September 2020)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our September 2020 client library releases.

#### GA

- Event Hubs
- Form Recognizer

#### Updates

- _Add packages_

#### Preview

- Anomaly Detector
- Event Grid

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.AI.AnomalyDetector --version 3.0.0-preview.2

$> dotnet install Azure.AI.FormRecognizer --version 3.0.0

$> dotnet add package Azure.Messaging.EventGrid --version 4.0.0-beta.1

$> dotnet add package Azure.Messaging.EventHubs
$> dotnet add package Azure.Messaging.EventHubs.Processor
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Anomaly Detector [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.AI.AnomalyDetector_3.0.0-preview.2/sdk/anomalydetector/Azure.AI.AnomalyDetector/CHANGELOG.md#300-preview2-2020-09-03)

#### Breaking Changes

- Renamed `AnomalyDetectorClient.EntireDetectAsync` and `AnomalyDetectorClient.EntireDetect` to `AnomalyDetectorClient.DetectEntireSeriesAsync` and `AnomalyDetectorClient.DetectEntireSeries`.
- Renamed `AnomalyDetectorClient.LastDetectAsync` and `AnomalyDetectorClient.LastDetect` to `AnomalyDetectorClient.DetectLastPointAsync` and `AnomalyDetectorClient.DetectLastPoint`.
- Renamed `AnomalyDetectorClient.ChangePointDetectAsync` and `AnomalyDetectorClient.ChangePointDetect` to `AnomalyDetectorClient.DetectChangePointAsync` and `AnomalyDetectorClient.DetectChangePoint`.
- Renamed `Request` to `DetectRequest`.
- Renamed `Point` to `TimeSeriesPoint`.
### Event Grid [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventgrid/Azure.Messaging.EventGrid/CHANGELOG.md)

- Initial beta release of Azure Event Grid client library

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md)

#### New Features

- The `EventProcessor<TPartition>` now supports a configurable strategy for load balancing, allowing control over whether it claims ownership of partitions in a balanced manner _(default)_ or more aggressively.  The strategy may be set in the `EventProcessorOptions` when creating the processor.  More details about strategies can be found in the associated [documentation](https://docs.microsoft.com/dotnet/api/azure.messaging.eventhubs.processor.loadbalancingstrategy?view=azure-dotnet).

- The `EventHubConsumerClient` now allows for performance tuning by setting the `PrefetchCount` and `CacheEventCount` values in its associated options.

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md)

#### New Features

- The `EventProcessorClient` now supports a configurable strategy for load balancing, allowing control over whether it claims ownership of partitions in a balanced manner _(default)_ or more aggressively.  The strategy may be set in the `EventProcessorClientOptions` when creating the processor.  More details about strategies can be found in the associated [documentation](https://docs.microsoft.com/dotnet/api/azure.messaging.eventhubs.processor.loadbalancingstrategy?view=azure-dotnet).

- The `EventProcessorClient` now allows for performance tuning by setting the `PrefetchCount` and `CacheEventCount` values in its associated options.

#### Key Bug Fixes

- The approach used for creation of checkpoints has been updated to interact with Azure Blob storage more efficiently.  This will yield major performance improvements when soft delete was enabled and minor improvements otherwise.

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/formrecognizer/Azure.AI.FormRecognizer/CHANGELOG.md#300-2020-08-20)

- First stable release of the Azure.AI.FormRecognizer package, targeting Azure Form Recognizer service API version 2.0.

#### New Features

- Added `FormRecognizerModelFactory` static class to support mocking model types.
## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
