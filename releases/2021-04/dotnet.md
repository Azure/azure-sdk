---
title: Azure SDK for .NET (April 2021)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

<!--
Azure.Core:1.12.0
Azure.IoT.DeviceUpdate:1.0.0-beta.2
Azure.Storage.Common:12.7.2
Azure.Messaging.EventHubs:5.4.0
Azure.Messaging.EventHubs.Processor:5.4.0

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to announce our April 2021 client library releases.

#### GA
- Core
- Event Hubs
- Event Hubs - Event Processor

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Storage - Common

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- IoT Device Update

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.Core --version 1.12.0
$> dotnet add package Azure.IoT.DeviceUpdate --version 1.0.0-beta.2
$> dotnet add package Azure.Storage.Common --version 12.7.2
$> dotnet add package Azure.Messaging.EventHubs --version 5.4.0
$> dotnet add package Azure.Messaging.EventHubs.Processor --version 5.4.0

```

[pattern]: # ($> dotnet add package ${PackageName} --version ${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights
### Core 1.12.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Core_1.12.0/sdk/core/Azure.Core/CHANGELOG.md#1120-2021-04-06)
#### Added

- Added `HttpPipeline.CreateHttpMessagePropertiesScope` that can be used to inject scoped properties into `HttpMessage`.

### IoT Device Update 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.IoT.DeviceUpdate_1.0.0-beta.2/sdk/deviceupdate/Azure.Iot.DeviceUpdate/CHANGELOG.md#100-beta2-2021-04-06)
* Update root namespace from Azure.Iot.DeviceUpdate to Azure.IoT.DeviceUpdate

### Storage - Common 12.7.2 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Storage.Common_12.7.2/sdk/storage/Azure.Storage.Common/CHANGELOG.md#1272-2021-04-02)
- Fixed bug in SasQueryParameters causing services (ss) reorder when parsing externally provided URI.

### Event Hubs 5.4.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Messaging.EventHubs_5.4.0/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md#540-2021-04-05)
#### Acknowledgments

Thank you to our developer community members who helped to make the Event Hubs client libraries better with their contributions to this release:

- Daniel Marbach _([GitHub](https://github.com/danielmarbach))_

#### Changes

##### New Features

- The Event Hubs clients now support shared key and shared access signature authentication using the `AzureNamedKeyCredential` and `AzureSasCredential` types in addition to the connection string.  Use of the credential allows the shared key or SAS to be updated without the need to create a new Event Hubs client.

- The `Properties` collection used by `EventData` is now lazily allocated, avoiding memory bloat when not used.

- The `SystemProperties` collection used by `EventData` will not use a shared empty set for events that have not been read from the Event Hubs service, reducing memory allocation.

- Multiple enhancements were made to the transport paths for publishing and reading events to reduce memory allocations and increase performance.  (A community contribution, courtesy of _[danielmarbach](https://github.com/danielmarbach))_

##### Key Bug Fixes

- The AMQP library used for transport has been updated, fixing several issues including a potential unobserved   `ObjectDisposedException` that could cause the host process to crash.  _(see: [release notes](https://github.com/Azure/azure-amqp/releases/tag/v2.4.13))_

### Event Hubs - Event Processor 5.4.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Messaging.EventHubs.Processor_5.4.0/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md#540-2021-04-05)
#### Acknowledgments

Thank you to our developer community members who helped to make the Event Hubs client libraries better with their contributions to this release:

- Daniel Marbach _([GitHub](https://github.com/danielmarbach))_

#### Changes

##### New Features

- The `EventProcessorClient` now supports shared key and shared access signature authentication using the `AzureNamedKeyCredential` and `AzureSasCredential` types in addition to the connection string.  Use of the credential allows the shared key or SAS to be updated without the need to create a new processor.

- Multiple enhancements were made to the AMQP transport paths for reading events to reduce memory allocations and increase performance.  (A community contribution, courtesy of _[danielmarbach](https://github.com/danielmarbach))_

##### Key Bug Fixes

- The AMQP library used for transport has been updated, fixing several issues including a potential unobserved   `ObjectDisposedException` that could cause the host process to crash.  _(see: [release notes](https://github.com/Azure/azure-amqp/releases/tag/v2.4.13))_


[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
