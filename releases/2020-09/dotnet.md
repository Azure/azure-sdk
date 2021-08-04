---
title: Azure SDK for .NET (September 2020)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our September 2020 client library releases.

#### GA

- App Configuration
- Event Hubs
- Form Recognizer
- Identity

#### Updates

- Storage

#### Preview

- Anomaly Detector
- Event Grid
- Identity
- Key Vault (Administration, Certificates, Keys, Secrets)
- Service Bus
- Tables
- Text Analytics

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.AI.AnomalyDetector --version 3.0.0-preview.2

$> dotnet add package Azure.AI.FormRecognizer --version 3.0.0

$> dotnet add package Azure.AI.TextAnalytics --version 5.1.0-beta.1

$> dotnet add package Azure.Data.AppConfiguration --version 1.0.2

$> dotnet add package Azure.Data.Tables --version 3.0.0-beta.1

$> dotnet add package Azure.Extensions.AspNetCore.DataProtection.Keys --version 1.0.2

$> dotnet add package Azure.Identity --version 1.3.0-beta.1
$> dotnet add package Azure.Identity --version 1.2.3

$> dotnet add package Azure.Messaging.EventGrid --version 4.0.0-beta.1

$> dotnet add package Azure.Messaging.EventHubs
$> dotnet add package Azure.Messaging.EventHubs.Processor

$> dotnet add package Azure.Messaging.ServiceBus --version 7.0.0-preview.7

$> dotnet add package Azure.Security.KeyVault.Administration --version 4.0.0-beta.1
$> dotnet add package Azure.Security.KeyVault.Certificates --version 4.2.0-beta.1
$> dotnet add package Azure.Security.KeyVault.Keys --version 4.2.0-beta.1
$> dotnet add package Azure.Security.KeyVault.Secrets --version 4.2.0-beta.1

$> dotnet add package Azure.Storage.Blobs --version 12.6.0
$> dotnet add package Azure.Storage.Blobs.Batch --version 12.3.1
$> dotnet add package Azure.Storage.Blobs.ChangeFeed --version 12.0.0-preview.4
$> dotnet add package Azure.Storage.Files.DataLake --version 12.4.0
$> dotnet add package Azure.Storage.Files.Shares --version 12.4.0
$> dotnet add package Azure.Storage.Queues --version 12.4.2
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

### Azure.Core [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/core/Azure.Core/CHANGELOG.md#150-2020-09-03)

#### New Features

- HttpWebRequest-based transport implementation. Enabled by-default on .NET Framework. Can be disabled using `AZURE_CORE_DISABLE_HTTPWEBREQUESTTRANSPORT` environment variable or `Azure.Core.Pipeline.DisableHttpWebRequestTransport` AppContext switch.

#### Breaking Changes

- `ETag` now supports weak ETags and implements an overload for `ToString` that accepts a format string.

### Azure.Core.Experimental [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/core/Azure.Core.Experimental/CHANGELOG.md#010-preview5-2020-09-03)

#### New Features

- `JsonPatchDocument` type to represent JSON Path document.
- `BinaryData`: FromString method.
- `BinaryData`: FromBytes method taking ReadOnlySpan.
- `BinaryData`: constructor taking ReadOnlyMemory.

#### Breaking Changes

- `BinaryData`: Renamed `Serialize` to `FromObject`.
- `BinaryData`: Renamed `Deserialize` to `ToObject`.
- `BinaryData`: Renamed `FromMemory` to `FromBytes`.

### Azure.Data.AppConfiguration [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/appconfiguration/Azure.Data.AppConfiguration/CHANGELOG.md#102-2020-09-10)

#### New Features

- Provide AddConfigurationClient with support for TokenCredential

### Azure.Data.Tables [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/tables/Azure.Data.Tables/CHANGELOG.md#300-beta1-2020-09-08)

- Initial beta release of Azure Data Tables client library

### Azure.Extensions.AspNetCore.DataProtection.Keys [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/extensions/Azure.Extensions.AspNetCore.DataProtection.Keys/CHANGELOG.md#102-2020-09-01)

#### Key Bug Fixes

- Support reading keys created by a previous version of Azure KeyVault Keys DataProtection library.

### Azure.Security.KeyVault.Administration [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/keyvault/Azure.Security.KeyVault.Administration/CHANGELOG.md#400-beta1-2020-09-08)

#### New Features

- Add `KeyVaultAccessControlClient`.
- Add `KeyVaultBackupClient`.

### Azure.Security.KeyVault.Certificates [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/keyvault/Azure.Security.KeyVault.Certificates/CHANGELOG.md#420-beta1-2020-09-08)

#### New Features

- Added `KeyVaultCertificateIdentifier` to parse certificate URIs.
- Added link to sample on `KeyVaultCertificate.Cer` to the private key.

### Azure.Security.KeyVault.Keys [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/keyvault/Azure.Security.KeyVault.Keys/CHANGELOG.md#420-beta1-2020-09-08)

#### New Features

- Added `KeyVaultKeyIdentifier` to parse key URIs.
- Added `LocalCryptographyClient` to do cryptography operations locally using a `JsonWebKey`.

### Azure.Security.KeyVault.Secrets [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/keyvault/Azure.Security.KeyVault.Secrets/CHANGELOG.md#420-beta1-2020-09-08)

#### New Features

- Added `KeyVaultSecretIdentifier` to parse secret URIs.


### Azure Storage Blobs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Blobs/CHANGELOG.md)

#### Key Bug Fixes

- `BlobClient.Upload()`, `BlockBlobClient.Upload()`, `AppendBlobClient.AppendBlock()`, and `PageBlobClient.UploadPages()` will not deadlock anymore if the content stream's position is not 0.
- Fixed bug in `BlobBaseClient.OpenRead()` which was causing more downloads than necessary.
- Fixed bug where `PageBlobWriteStream` would advance Position 2 times the number of written bytes.

### Azure Storage Files DataLake [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Files.DataLake/CHANGELOG.md)

#### Key Bug Fixes
- `DataLakeFileClient.Upload()` will not deadlock anymore if the content stream's position is not 0.
- Fixed bug in `DataLakeFileClient.OpenRead()` which was causing more downloads than necessary.

### Azure Storage Files Shares [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Files.Shares/CHANGELOG.md)

#### Key Bug Fixes
- Fixed bug where `ShareFileClient.Upload()` and `ShareFileClient.UploadRange()` would deadlock if the content stream's position was not set to 0.
- Fixed bug in `ShareFileClient.OpenRead()` which was causing more downloads than necessary.
- Fixed bug where `ShareClient.Delete()` could not delete Share Snapshots unless the `includeSnapshots` parameter was set to false.

### Azure Storage Queues [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Queues/CHANGELOG.md)

#### Key Bug Fixes
- Fixed a bug where `QueueClient.UpdateMessage` and `QueueClient.UpdateMessageAsync` were erasing message content if only `visibilityTimeout` was provided

### Event Grid [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/eventgrid/Azure.Messaging.EventGrid/CHANGELOG.md)

- Initial beta release of Azure Event Grid client library

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md)

#### New Features

- The `EventProcessor<TPartition>` now supports a configurable strategy for load balancing, allowing control over whether it claims ownership of partitions in a balanced manner _(default)_ or more aggressively.  The strategy may be set in the `EventProcessorOptions` when creating the processor.  More details about strategies can be found in the associated [documentation](https://docs.microsoft.com/dotnet/api/azure.messaging.eventhubs.processor.loadbalancingstrategy).

- The `EventHubConsumerClient` now allows for performance tuning by setting the `PrefetchCount` and `CacheEventCount` values in its associated options.

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md)

#### New Features

- The `EventProcessorClient` now supports a configurable strategy for load balancing, allowing control over whether it claims ownership of partitions in a balanced manner _(default)_ or more aggressively.  The strategy may be set in the `EventProcessorClientOptions` when creating the processor.  More details about strategies can be found in the associated [documentation](https://docs.microsoft.com/dotnet/api/azure.messaging.eventhubs.processor.loadbalancingstrategy).

- The `EventProcessorClient` now allows for performance tuning by setting the `PrefetchCount` and `CacheEventCount` values in its associated options.

#### Key Bug Fixes

- The approach used for creation of checkpoints has been updated to interact with Azure Blob storage more efficiently.  This will yield major performance improvements when soft delete was enabled and minor improvements otherwise.

### Identity [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/identity/Azure.Identity/CHANGELOG.md#130-beta1-2020-09-11)

#### New Features

- Restoring Application Authentication APIs from 1.2.0-preview.6
- Added support for App Service Managed Identity API version `2019-08-01` ([#13687](https://github.com/Azure/azure-sdk-for-net/issues/13687))
- Added `IncludeX5CClaimHeader` to `ClientCertificateCredentialOptions` to enable subject name / issuer authentication with the `ClientCertificateCredential`.
- Added `RedirectUri` to `InteractiveBrowserCredentialOptions` to enable authentication with user specified application with a custom redirect url.
- Added `IdentityModelFactory` to enable constructing models from the Azure.Identity library for mocking.
- Unify exception handling between `DefaultAzureCredential` and `ChainedTokenCredential` ([#14408](https://github.com/Azure/azure-sdk-for-net/issues/14408))

#### Key Bug Fixes

- Updated `MsalPublicClient` and `MsalConfidentialClient` to respect `CancellationToken` during initialization ([#13201](https://github.com/Azure/azure-sdk-for-net/issues/13201))
- Fixed `VisualStudioCodeCredential` crashes on macOS (Issue [#14362](https://github.com/Azure/azure-sdk-for-net/issues/14362))
- Fixed issue with non GUID Client Ids (Issue [#14585](https://github.com/Azure/azure-sdk-for-net/issues/14585))
- Update `VisualStudioCredential` and `VisualStudioCodeCredential` to throw `CredentialUnavailableException` for ADFS tenant (Issue [#14639](https://github.com/Azure/azure-sdk-for-net/issues/14639))


### Identity [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/identity/Azure.Identity/CHANGELOG.md#123-2020-09-11)

#### Key Bug Fixes

- Fixed issue with `DefaultAzureCredential` incorrectly catching `AuthenticationFailedException` (Issue [#14974](https://github.com/Azure/azure-sdk-for-net/issues/14974))
- Fixed issue with `DefaultAzureCredential` throwing exceptions during concurrent calls (Issue [#15013](https://github.com/Azure/azure-sdk-for-net/issues/15013))

### Azure.Messaging.ServiceBus [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/servicebus/Azure.Messaging.ServiceBus/CHANGELOG.md#700-preview7-2020-09-10)

#### New Features

- Added AmqpMessage property on `ServiceBusMessage` and `ServiceBusReceivedMessage` that gives full access to underlying AMQP details.
- Added explicit Close methods on `ServiceBusReceiver`, `ServiceBusSessionReceiver`, `ServiceBusSender`, `ServiceBusProcessor`, and `ServiceBusSessionProcessor`.

#### Breaking Changes

- Renamed `ServiceBusManagementClient` to `ServiceBusAdministrationClient`.
- Renamed `ServiceBusManagementClientOptions` to `ServiceBusAdministrationClientOptions`.
- Renamed `IsDisposed` to `IsClosed` on `ServiceBusSender`, `ServiceBusReceiver`, and `ServiceBusSessionReceiver`.
- Made `ServiceBusProcessor` and `ServiceBusSessionProcessor` implement `IAsyncDisposable`
- Removed public constructors for `QueueProperties` and `RuleProperties`.
- Added `version` parameter to `ServiceBusAdministrationClientOptions` constructor.
- Removed `CreateDeadLetterReceiver` methods in favor of new `SubQueue` property on `ServiceBusReceiverOptions`.
- Made `EntityNameFormatter` internal.
- Made settlement methods on `ProcessMessageEventArgs` and `ProcessSessionMessageEventArgs` virtual for mocking.
- Made all Create methods on `ServiceBusClient` virtual for mocking.

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/formrecognizer/Azure.AI.FormRecognizer/CHANGELOG.md#300-2020-08-20)

- First stable release of the Azure.AI.FormRecognizer package, targeting Azure Form Recognizer service API version 2.0.

#### New Features

- Added `FormRecognizerModelFactory` static class to support mocking model types.

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#510-beta1-2020-09-17)

#### New Features
- It defaults to the latest supported API version, which currently is `3.1-preview.2`.
- `ErrorCode` value returned from the service is now surfaced in `RequestFailedException`.
- Added the `RecognizePiiEntities` endpoint which returns entities containing Personally Identifiable Information. This feature is available in the Text Analytics service v3.1-preview.1 and above.
- Support added for Opinion Mining. This feature is available in the Text Analytics service v3.1-preview.1 and above.
- Added `Offset` and `Length` properties for `CategorizedEntity`, `SentenceSentiment`, and `LinkedEntityMatch`. The default encoding is UTF-16 code units. For additional information see https://aka.ms/text-analytics-offsets
- `TextAnalyticsError` and `TextAnalyticsWarning` now are marked as immutable.
-Added property `BingEntitySearchApiId` to the `LinkedEntity` class. This property is only available for v3.1-preview.2 and up, and it is to be used in conjunction with the Bing Entity Search API to fetch additional relevant information about the returned entity.


## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].
{% include refs.md %}
