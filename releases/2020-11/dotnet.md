---
title: Azure SDK for .NET (November 2020)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our November 2020 client library releases.

#### GA

- Storage
- Core AMQP
- Digital Twins Core
- Extensions Configuration Secrets
- Identity
- Service Bus
- System Memory Data

#### Updates

- _Add packages_

#### Beta

- Azure Monitor
- Communication Administration
- Communication Chat
- Communication Common
- Communication SMS
- Core AMQP
- Core NewtonsoftJson
- Event Grid
- Event Hubs
- Extensions Azure
- Form Recognizer
- Key Vault Administration
- Key Vault Certificates
- Key Vault Keys
- Key Vault Secrets
- Management Library - Communication
- Metrics Advisor
- Search Documents
- Service Bus
- Tables
- Text Analytics

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.AI.FormRecognizer --version 3.1.0-beta.1

$> dotnet add package Azure.AI.MetricsAdvisor --version 1.0.0-beta.2

$> dotnet add package Azure.AI.TextAnalytics --version 5.1.0-beta.3

$> dotnet add package Azure.Communication.Administration --version 1.0.0-beta.3
$> dotnet add package Azure.Communication.Chat --version 1.0.0-beta.3
$> dotnet add package Azure.Communication.Common --version 1.0.0-beta.3
$> dotnet add package Azure.Communication.Sms --version 1.0.0-beta.3

$> dotnet add package Azure.Core.Amqp --version 1.0.0

$> dotnet add package Azure.Data.Tables --version 3.0.0-beta.3

$> dotnet add package Azure.DigitalTwins.Core --version 1.0.1

$> dotnet add package Azure.Extensions.AspNetCore.Configuration.Secrets --version 1.0.2

$> dotnet add package Azure.Identity --version 1.3.0

$> dotnet add package Azure.Messaging.EventGrid --version 4.0.0-beta.4

$> dotnet add package Azure.Messaging.EventHubs --version 5.3.0-beta.4
$> dotnet add package Azure.Messaging.EventHubs.Processor --version 5.3.0-beta.4

$> dotnet add package Azure.Messaging.ServiceBus --version 7.0.0

$> dotnet add package Azure.Search.Documents --version 11.2.0-beta.2

$> dotnet add package Azure.Security.KeyVault.Administration --version 4.0.0-beta.3
$> dotnet add package Azure.Security.KeyVault.Certificates --version 4.2.0-beta.3
$> dotnet add package Azure.Security.KeyVault.Keys --version 4.2.0-beta.3
$> dotnet add package Azure.Security.KeyVault.Secrets --version 4.2.0-beta.3

$> dotnet add package Azure.Storage.Blobs --version 12.7.0
$> dotnet add package Azure.Storage.Blobs.Batch --version 12.4.0
$> dotnet add package Azure.Storage.Blobs.ChangeFeed --version 12.0.0-preview.6
$> dotnet add package Azure.Storage.Files.DataLake --version 12.5.0
$> dotnet add package Azure.Storage.Files.Shares --version 12.5.0
$> dotnet add package Azure.Storage.Queues --version 12.5.0

$> dotnet add package Microsoft.Azure.Core.NewtonsoftJson --version 1.0.0-preview.2

$> dotnet add package Microsoft.Extensions.Azure --version 1.1.0-beta.1

$> dotnet add package Microsoft.OpenTelemetry.Exporter.AzureMonitor --version 1.0.0-beta.1

$> dotnet add package System.Memory.Data --version 1.0.1
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights

### Azure Monitor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.OpenTelemetry.Exporter.AzureMonitor_1.0.0-beta.1/sdk/monitor/Microsoft.OpenTelemetry.Exporter.AzureMonitor/CHANGELOG.md#100-beta1-2020-11-06)

- Initial release of Azure Monitor Exporter for [OpenTelemetry .NET](https://github.com/open-telemetry/opentelemetry-dotnet).

### Communication Administration [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Communication.Administration_1.0.0-beta.3/sdk/communication/Azure.Communication.Administration/CHANGELOG.md#100-beta3-2020-11-16)

#### New Features

- Support for mocking all client methods that use models with internal constructors.
- Added support for long-running operations. More detail under Breaking Changes.

#### Breaking Changes

##### Model Types

- Renamed `CreateSearchOptions` to `CreateReservationOptions`.
- Renamed `CreateSearchResponse` to `CreateReservationResponse`.
- Renamed `ReleaseResponse` to `PhoneNumberReleaseResponse`.
- Renamed `SearchStatus` to `ReservationStatus`.
- Added `PhoneNumberReservationOperation`.
- Added `PhoneNumberReservationPurchaseOperation`.
- Added `ReleasePhoneNumberOperation`.
- Renamed `PhoneNumberSearch` to `PhoneNumberReservation`.

##### PhoneNumberReservation

- Renamed `searchId` to `reservationId`.

##### PhoneNumberAdministrationClient

- Renamed `CancelSearch` to `CancelReservation`.
- Renamed `CancelSearchAsync` to `CancelReservationAsync`.
- Renamed `GetAllSearches` to `GetAllReservations`.
- Renamed `GetAllSearchesAsync` to `GetAllReservationsAsync`.
- Renamed `GetSearchByIdAsync` to `GetReservationByIdAsync`.
- Renamed `GetSearchById` to `GetReservationById`.
- Renamed `CancelSearch` to `CancelReservation`.
- Renamed `CancelSearchAsync` to `CancelReservationAsync`.
- Replaced `CreateSearchAsync` with `StartReservationAsync` which returns a poller for the long-running operation.
- Replaced `CreateSearch` with `StartReservation` which is a long-running operation.
- Replaced `PurchaseSearchAsync` with `StartPurchaseReservationAsync` which returns a poller for the long-running operation.
- Replaced `PurchaseSearch` with `StartPurchaseReservation` which is a long-running operation.
- Replaced `ReleasePhoneNumbersAsync` with `StartReleasePhoneNumbersAsync` which returns a poller for the long-running operation.
- Replaced `ReleasePhoneNumbers` with `StartReleasePhoneNumbers` which is a long-running operation.

### Communication Chat [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/communication/Azure.Communication.Chat/CHANGELOG.md#100-beta3-2020-11-16)

#### New Features

- Support for mocking all client methods that use models with internal constructors.
- Added unit test for pagination.

### Communication Common [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/communication/Azure.Communication.Common/CHANGELOG.md#100-beta3-2020-11-16)

This release contains test improvements and documentation enhancements.

### Communication SMS [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/communication/Azure.Communication.Sms/CHANGELOG.md#100-beta3-2020-11-16)

#### New Features

Support for mocking all client methods that use models with internal constructors.

### Core AMQP (1.0.0) [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/core/Azure.Core.Amqp/CHANGELOG.md#100-2020-11-23)

- General availability release of Azure.Core.Amqp.

### Core AMQP (1.0.0-beta.1) [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/core/Azure.Core.Amqp/CHANGELOG.md#100-beta1-2020-11-04)

#### New Features

- Added AMQP models.

### Core NewtonsoftJson [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/core/Microsoft.Azure.Core.NewtonsoftJson/CHANGELOG.md#100-preview2-2020-11-10)

#### New Features

- `Newtonsoft.Json.JsonConverter` implementation for the `ETag`.

### Digital Twins Core [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/digitaltwins/Azure.DigitalTwins.Core/CHANGELOG.md#101-2020-11-04)

#### New Features

- Improved deserialization and error reporting for `BasicDigitalTwin` for `DigitalTwinMetadata`.

#### Breaking Changes

- Removed logic to determine authorization scope based on digital twins instance URI.

### Event Grid [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/eventgrid/Azure.Messaging.EventGrid/CHANGELOG.md#400-beta4-2020-11-10)

#### Key Bug Fixes

- Fixed bug where missing required properties on CloudEvent would cause deserialization to fail.

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md#530-beta4-2020-11-10)

This release contains a collection of minor bug fixes, performance improvements, and documentation enhancements.

#### New Features

- Connection strings can now be parsed into their key/value pairs using the `EventHubsConnectionStringProperties` class.

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md#530-beta4-2020-11-10)

This release contains a collection of minor bug fixes, performance improvements, and documentation enhancements.

### Extensions Azure [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/extensions/Microsoft.Extensions.Azure/CHANGELOG.md#110-beta1-2020-11-10)

#### New Features

- The `AzureComponentFactory` class that allows creating `TokenCredential`, `ClientOptions` and client instances from configuration.
- The `AzureEventSourceLogForwarder` class that allows manual control over the log forwarding.
- The `AddAzureClientsCore` extension method.

### Extensions Configuration Secrets [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/extensions/Azure.Extensions.AspNetCore.Configuration.Secrets/CHANGELOG.md#102-2020-11-10)

#### New Features

- Added an overload of `AddAzureKeyVault` that takes an `AzureKeyVaultConfigurationOptions` parameter and allows specifying the reload interval.

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/formrecognizer/Azure.AI.FormRecognizer/CHANGELOG.md#310-beta1-2020-11-23)

This release of the SDK defaults to the latest supported API version, which currently is v2.1-preview.2

#### New Features

- Added integration for ASP.NET Core.
- Support for two new prebuilt recognition models for invoices and business cards.
- Support for selection marks as a new fundamental form element. This type is supported in content recognition and in
training/recognizing custom forms (labeled only).
- Support for creating composed models from a collection of existing models (trained with labels).
- A `ModelName` property added for model training that can specify a human-readable name for a model.
- Support for the bitmap image format (with content type "image/bmp") in prebuilt model recognition and content recognition.
- A `locale` keyword argument added for all prebuilt model methods, allowing for the specification of a document's origin to assist the
service with correct analysis of the document's content.
- A `language` keyword argument added for the content recognition method `StartRecognizeContent()` that specifies which language to process the document in.
- Additional properties added to response models - see Changelog for detailed information.

### Identity [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/identity/Azure.Identity/CHANGELOG.md#130-2020-11-12)

#### New Features

- Added support for Service Fabric managed identity authentication to `ManagedIdentityCredential`.
- Added support for Azure Arc managed identity authentication to `ManagedIdentityCredential`.

#### Breaking Changes

- Removing Application Authentication APIs for GA release. These will be reintroduced in 1.4.0-beta.1.

#### Key Bug Fixes

- Fix `VisualStudioCodeCredential` to raise `CredentialUnavailableException` when reading from VS Code's stored secret ([#16795](https://github.com/Azure/azure-sdk-for-net/issues/16795)).
- Fix deadlock in `ProcessRunner` causing `AzureCliCredential` and `VisualStudioCredential` to fail due to timeout ([#14691](https://github.com/Azure/azure-sdk-for-net/issues/14691), [14207](https://github.com/Azure/azure-sdk-for-net/issues/14207)).
- Fix issue with `AzureCliCredential` incorrectly parsing expires on property returned from `az account get-access-token` ([#15801](https://github.com/Azure/azure-sdk-for-net/issues/15801)).
- Fix cache loading issue in `SharedTokenCacheCredential` on Linux ([#12939](https://github.com/Azure/azure-sdk-for-net/issues/12939)).

### Key Vault Administration [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/keyvault/Azure.Security.KeyVault.Administration/CHANGELOG.md#400-beta3-2020-11-12)

#### Breaking Changes

- Both `BackupOperation` and `RestoreOperation` return a result containing the `Uri` instead of just the `Uri` itself for future possible expansion.
- Changed `NotActions` and `NotDataActions` to `DenyActions` and `DenyDataActions` respectively.
- Consolidated `KeyVaultAccessControlClientOptions` and `KeyVaultBackupClientOptions` into `KeyVaultAdministrationClientOptions`.

### Key Vault Certificates [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/keyvault/Azure.Security.KeyVault.Certificates/CHANGELOG.md#420-beta3-2020-11-12)

#### New Features

- Documentation improvements.

### Key Vault Keys [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/keyvault/Azure.Security.KeyVault.Keys/CHANGELOG.md#420-beta3-2020-11-12)

#### New Features

- Added support for "oct-HSM" for Managed HSM.
- Added support for AES-CBC and AES-GCM - locally when possible on the client.
- Added support for key export on Managed HSM, including early preview support for Secure Key Release.

### Azure Storage Blobs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Blobs/CHANGELOG.md)

#### New Features
- GA all features in previous release.
- Added ability to get parent `BlobContainerClient` from `BlobBaseClient` and to get parent `BlobServiceClient` from `BlobContainerClient`.
- Added seekability to `BaseBlobClient.OpenRead()`.
- Added additional info to exception messages.
- Added ability to set Position on streams created with `BlobBaseClient.OpenRead()`.
- Added CanGenerateSasUri property and `GenerateSasUri()` to `BlobBaseClient`, `BlobClient`, `BlockBlobClient`, `AppendBlobClient`, `PageBlobClient` and `BlobContainerClient`.
- Added CanAccountGenerateSasUri property and `GenerateAccountSasUri()` to `BlobServiceClient`.
- Restored single upload threshold for parallel uploads from 5 TB to 256 MB.

#### Key Bug Fixes
- Fixed bug where Blobs SDK couldn't handle SASs with start and expiry time in format other than yyyy-MM-ddTHH:mm:ssZ.
- Fixed bug where `BlobContainerClient.SetAccessPolicy()` would throw an exception if signed identifier permissions were not in the correct order.

### Azure Storage Files DataLake [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Files.DataLake/CHANGELOG.md)

#### New Features
- GA all features in previous release.
- Added additional info to exception messages.
- Added `DataLakeDirectoryClient.GetPaths()`.
- Added ability to set Position on streams created with `DataLakeFileClient.OpenRead()`.
- Added CanGenerateSasUri property and `GenerateSasUri()` to `DataLakePathClient`, `DataLakeFileClient`, `DataLakeDirectoryClient` and `DataLakeFileSystemClient`.
- Added CanGenerateAccountSasUri property and `GenerateAccountSasUri()` to `DataLakeServiceClient`.
- Restored single upload threshold for parallel uploads from 5 TB to 256 MB.

#### Key Bug Fixes
- Fixed bug where `DataLakeFileSystem.SetAccessPolicy()` would throw an exception if signed identifier permissions were not in the correct order.
- Fixed bug where DataLake SDK couldn't handle SASs with start and expiry time in format other than yyyy-MM-ddTHH:mm:ssZ.

### Azure Storage Files Shares [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Files.Shares/CHANGELOG.md)

#### New Features
- GA all features from previous release.
- Renamed `ShareClient.SetTier()` -> `ShareClient.SetProperties()`. `SetProperties()` can be used to set both Share Tier and Share Quota.
- Changed `ShareDeleteOptions.IncludeSnapshots` -> `.ShareSnapshotsDeleteOption`, and added option to also delete Share Snapshots that have been leased.
- Added additional info to exception messages.
- Removed ability to create a `ShareLeaseClient` for a Share or Share Snapshot. This feature has been rescheduled for future release.
- Added ability to set Position on streams created with `ShareFileClient.OpenRead()`.
- Added CanGenerateSasUri property and `GenerateSasUri()` to `ShareFileClient`, `ShareDirectoryClient` and `ShareClient`.
- Added CanGenerateSasUri property and` GenerateAccountSasUri()` to `ShareServiceClient`.
- Changed default constructor for FileSmbProperties from internal to public.

#### Key Bug Fixes
- Fixed bug where `ShareDirectoryClient.Exists()`, `.DeleteIfExists()` and `ShareFileClient.Exists()`, `.DeleteIfExists()` would thrown an exception when the directory or file's parent directory didn't exist.
- Fixed bug where File Share SDK coudn't handle SASs with start and expiry time in format other than yyyy-MM-ddTHH:mm:ssZ.

### Azure Storage Queues [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Queues/CHANGELOG.md)

#### New Features
- GA all features from previous release.
- Added CanGenerateSasUri property and `GenerateSasUri()` to `QueueClient`.
- Added CanGenerateAccountSasUri property and `GenerateAccountSasUri()` to `QueueServiceClient`.

#### Key Bug Fixes
- Fixed a bug where `QueueServiceClient.SetProperties` and `QueueService.GetProperties` where the creating/parsing XML Service Queue Properties CorsRules incorrectly causing Invalid XML Errors
- Fixed bug where Queues SDK coudn't handle SASs with start and expiry time in format other than yyyy-MM-ddTHH:mm:ssZ.

### Key Vault Secrets [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/keyvault/Azure.Security.KeyVault.Secrets/CHANGELOG.md#420-beta3-2020-11-12)

- This release contains bug fixes to improve quality.

### Metrics Advisor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/metricsadvisor/Azure.AI.MetricsAdvisor/CHANGELOG.md#100-beta2-2020-11-10)

#### New Features

- Added a public constructor to `DataFeed`.
- Added the `DataSource` property to `DataFeed`.

#### Breaking Changes

- In `MetricsAdvisorClient`, changed return types of sync and async `CreateMetricFeedback` methods to a `Response<string>` containing the ID of the created feedback.
- In `MetricsAdvisorClient`, changed return types of sync and async methods `GetIncidentRootCauses`, `GetMetricEnrichedSeriesData`, and `GetMetricSeriesData` to pageables.
- In `MetricsAdvisorAdministrationClient`, updated `CreateDataFeed` and `CreateDataFeedAsync` to take a whole `DataFeed` object as a parameter.
- In `MetricsAdvisorAdministrationClient`, changed return types of sync and async `Create` methods (e.g., `CreateDataFeed`) to a `Response<string>` containing the ID of the created resource.
- In `MetricsAdvisorAdministrationClient`, changed return types of sync and async methods `GetAnomalyAlertConfigurations` and `GetMetricAnomalyDetectionConfigurations` to pageables.
- Removed `DataFeedOptions`. All of its properties were moved directly into `DataFeed`.

#### Key Bug Fixes

- Fixed a bug in sync and async `UpdateDataFeed` methods where a `RequestFailedException` was thrown if a data feed without custom `DataFeedMissingDataPointFillType` was updated.
- Fixed a bug in sync and async `UpdateAlertConfiguration` methods where a `RequestFailedException` was thrown if a configuration with only one `MetricAnomalyAlertConfiguration` was updated.

### Search Documents [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/search/Azure.Search.Documents/CHANGELOG.md#1120-beta2-2020-11-10)

#### New Features

- Added `EncryptionKey` to `SearchIndexer`, `SearchIndexerDataSourceConnection`, and `SearchIndexerSkillset`.
- Added configuration options to tune the performance of `SearchIndexingBufferedSender<T>`.

#### Key Bug Fixes

- Fixed issue calling `SearchIndexClient.GetIndexNames` that threw an exception ([#15590](https://github.com/Azure/azure-sdk-for-net/issues/15590)).
- Fixed issue where `ScoringProfile.FunctionAggregation` did not correctly handle null values ([#16570](https://github.com/Azure/azure-sdk-for-net/issues/16570)).
- Fixed overly permissive date parsing on facets ([#16412](https://github.com/Azure/azure-sdk-for-net/issues/16412)).

### Service Bus (7.0.0) [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/servicebus/Azure.Messaging.ServiceBus/CHANGELOG.md#700-2020-11-23)

#### Breaking Changes

- Renamed `GetRawMessage` method to `GetRawAmqpMessage`.
- Removed `LinkCloseMode`.
- Rename `ReceiveMode` type to `ServiceBusReceiveMode`.
- Remove `ServiceBusFailureReason` of `Unauthorized` in favor of using `UnauthorizedAccessException`.

### Service Bus (7.0.0-preview.9) [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/servicebus/Azure.Messaging.ServiceBus/CHANGELOG.md#700-preview9-2020-11-04)

#### Breaking Changes

- Removed `AmqpMessage` property in favor of a `GetRawMessage` method on `ServiceBusMessage` and `ServiceBusReceivedMessage`.
- Renamed `Properties` to `ApplicationProperties` in `CorrelationRuleFilter`.
- Removed `ServiceBusSenderOptions`.
- Removed `TransactionEntityPath` from `ServiceBusSender`.

### Management Library - Communication [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/communication/Azure.ResourceManager.Communication/CHANGELOG.md#100-beta3-2020-11-16)

This release contains test improvements.

### Tables [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/tables/Azure.Data.Tables/CHANGELOG.md#300-beta3-2020-11-12)

#### New Features

- Added support for Upsert batch operations.
- Added support for some numeric type coercion for TableEntity properties.
- Added TryGetFailedEntityFromException method on TablesTransactionalBatch to extract the entity that caused a batch failure from a RequestFailedException.

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#510-beta3-2020-11-19)

#### New Features
- Added support for new asynchronous Text Analytics for Health API. Note this is a currently in a gated preview where AAD is not supported. More information [here](https://docs.microsoft.com/azure/cognitive-services/text-analytics/how-tos/text-analytics-for-health?tabs=ner#request-access-to-the-public-preview).
- Added support for new asynchronous Analyze API to support the execution of multiples task in one or more documents. Current task support include: Named entity recognition, Personally Identifiable Information, and Key phrase extraction.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
