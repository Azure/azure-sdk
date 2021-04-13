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
Azure.Security.Attestation:1.0.0-beta.2
Azure.AI.TextAnalytics:5.1.0-beta.6
Azure.Data.Tables:12.0.0-beta.7
Azure.Analytics.Synapse.Artifacts:1.0.0-preview.8
Azure.Data.AppConfiguration:1.1.0-beta.2
Azure.AI.Translation.Document:1.0.0-beta.1
Azure.Search.Documents:11.3.0-beta.1
Azure.AI.FormRecognizer:3.1.0-beta.4
Azure.Identity:1.4.0-beta.5
Azure.Core.Amqp:1.1.0-beta.1
Microsoft.Azure.WebJobs.Extensions.EventHubs:5.0.0-beta.4
System.Memory.Data:1.0.2
Azure.Core:1.13.0
Microsoft.Azure.CognitiveServices.Vision.ComputerVision:7.0.0
Azure.Storage.Files.Shares:12.7.0-beta.3
Azure.Storage.Blobs:12.9.0-beta.3
Azure.Storage.Blobs.Batch:12.6.0-beta.3
Azure.Storage.Common:12.8.0-beta.3
Azure.Storage.Blobs.ChangeFeed:12.0.0-preview.11
Azure.Storage.Queues:12.7.0-beta.3
Azure.Storage.Files.DataLake:12.7.0-beta.3
Azure.IoT.ModelsRepository:1.0.0-preview.3
Azure.DigitalTwins.Core:1.2.2

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to announce our April 2021 client library releases.

#### GA
- Azure Communication Chat
- Azure Communication Common
- Azure Communication Identity
- Azure Communication SMS
- Computer Vision
- Core
- Event Hubs
- Event Hubs - Event Processor
- Resource Management - Communication

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Storage - Common
- System Memory Data
- Digital Twins - Core

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- App Configuration
- Attestation
- Azure.AI.Translation.Document
- Azure Communication Phone Numbers
- Cognitive Search
- Core - AMQP
- Form Recognizer
- Identity
- IoT Device Update
- Synapse - Artifacts
- Tables
- Text Analytics
- Translation Document
- WebJobs Extensions - Event Hubs
- Storage - Files Shares
- Storage - Blobs
- Storage - Blobs Batch
- Storage - Common
- Storage - Blobs ChangeFeed
- Storage - Queues
- Storage - Files Data Lake
- Azure.IoT.ModelsRepository

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.AI.FormRecognizer --version 3.1.0-beta.4
$> dotnet add package Azure.AI.TextAnalytics --version 5.1.0-beta.6
$> dotnet add package Azure.AI.Translation.Document --version 1.0.0-beta.1
$> dotnet add package Azure.Analytics.Synapse.Artifacts --version 1.0.0-preview.8
$> dotnet add package Azure.Communication.Chat --version 1.0.0
$> dotnet add package Azure.Communication.Common --version 1.0.0
$> dotnet add package Azure.Communication.Identity --version 1.0.0
$> dotnet add package Azure.Communication.PhoneNumbers --version 1.0.0-beta.6
$> dotnet add package Azure.Communication.SMS --version 1.0.0
$> dotnet add package Azure.Core --version 1.12.0
$> dotnet add package Azure.Core --version 1.13.0
$> dotnet add package Azure.Core.Amqp --version 1.1.0-beta.1
$> dotnet add package Azure.Data.AppConfiguration --version 1.1.0-beta.2
$> dotnet add package Azure.Data.Tables --version 12.0.0-beta.7
$> dotnet add package Azure.Identity --version 1.4.0-beta.5
$> dotnet add package Azure.IoT.DeviceUpdate --version 1.0.0-beta.2
$> dotnet add package Azure.Messaging.EventHubs --version 5.4.0
$> dotnet add package Azure.Messaging.EventHubs.Processor --version 5.4.0
$> dotnet add package Azure.ResourceManager.Communication --version 1.0.0
$> dotnet add package Azure.Search.Documents --version 11.3.0-beta.1
$> dotnet add package Azure.Security.Attestation --version 1.0.0-beta.2
$> dotnet add package Azure.Storage.Common --version 12.7.2
$> dotnet add package Microsoft.Azure.CognitiveServices.Vision.ComputerVision --version 7.0.0
$> dotnet add package Microsoft.Azure.WebJobs.Extensions.EventHubs --version 5.0.0-beta.4
$> dotnet add package Azure.Storage.Files.Shares --version 12.7.0-beta.3
$> dotnet add package Azure.Storage.Blobs --version 12.9.0-beta.3
$> dotnet add package Azure.Storage.Blobs.Batch --version 12.6.0-beta.3
$> dotnet add package Azure.Storage.Common --version 12.8.0-beta.3
$> dotnet add package Azure.Storage.Blobs.ChangeFeed --version 12.0.0-preview.11
$> dotnet add package Azure.Storage.Queues --version 12.7.0-beta.3
$> dotnet add package Azure.Storage.Files.DataLake --version 12.7.0-beta.3
$> dotnet add package Azure.IoT.ModelsRepository --version 1.0.0-preview.3
$> dotnet add package Azure.DigitalTwins.Core --version 1.2.2
$> dotnet add package System.Memory.Data --version 1.0.2
```

[pattern]: # ($> dotnet add package ${PackageName} --version ${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights
### Core 1.12.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Core_1.12.0/sdk/core/Azure.Core/CHANGELOG.md#1120-2021-04-06)
#### Added

- Added `HttpPipeline.CreateHttpMessagePropertiesScope` that can be used to inject scoped properties into `HttpMessage`.

### IoT Device Update 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.IoT.DeviceUpdate_1.0.0-beta.2/sdk/deviceupdate/Azure.IoT.DeviceUpdate/CHANGELOG.md#100-beta2-2021-04-06)
* Update root namespace from Azure.Iot.DeviceUpdate to Azure.IoT.DeviceUpdate

### Storage - Common 12.7.2 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Storage.Common_12.7.2/sdk/storage/Azure.Storage.Common/CHANGELOG.md#1272-2021-04-02)
- Fixed bug in SasQueryParameters causing services (ss) reorder when parsing externally provided URI.

### Event Hubs 5.4.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Messaging.EventHubs_5.4.0/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md#540-2021-04-05)

#### New Features

- The Event Hubs clients now support shared key and shared access signature authentication using the `AzureNamedKeyCredential` and `AzureSasCredential` types in addition to the connection string.  Use of the credential allows the shared key or SAS to be updated without the need to create a new Event Hubs client.

- The `Properties` collection used by `EventData` is now lazily allocated, avoiding memory bloat when not used.

- The `SystemProperties` collection used by `EventData` will not use a shared empty set for events that have not been read from the Event Hubs service, reducing memory allocation.

- Multiple enhancements were made to the transport paths for publishing and reading events to reduce memory allocations and increase performance.  (A community contribution, courtesy of _[danielmarbach](https://github.com/danielmarbach))_

#### Key Bug Fixes

- The AMQP library used for transport has been updated, fixing several issues including a potential unobserved   `ObjectDisposedException` that could cause the host process to crash.  _(see: [release notes](https://github.com/Azure/azure-amqp/releases/tag/v2.4.13))_

### Event Hubs - Event Processor 5.4.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Messaging.EventHubs.Processor_5.4.0/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md#540-2021-04-05)

#### New Features

- The `EventProcessorClient` now supports shared key and shared access signature authentication using the `AzureNamedKeyCredential` and `AzureSasCredential` types in addition to the connection string.  Use of the credential allows the shared key or SAS to be updated without the need to create a new processor.

- Multiple enhancements were made to the AMQP transport paths for reading events to reduce memory allocations and increase performance.  (A community contribution, courtesy of _[danielmarbach](https://github.com/danielmarbach))_

#### Key Bug Fixes

- The AMQP library used for transport has been updated, fixing several issues including a potential unobserved   `ObjectDisposedException` that could cause the host process to crash.  _(see: [release notes](https://github.com/Azure/azure-amqp/releases/tag/v2.4.13))_

### Attestation 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Security.Attestation_1.0.0-beta.2/sdk/attestation/Azure.Security.Attestation/CHANGELOG.md#100-beta2-2021-04-06)
- Fixed bug #19708, handle JSON values that are not just simple integers.
- Fixed bug #18183, Significant cleanup of README.md.
- Fixed bug #18739, reference the readme.md file in the azure-rest-apis directory instead of referencing the attestation JSON file directly. Also updated to the most recent version of the dataplane swagger files.

### Text Analytics 5.1.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.AI.TextAnalytics_5.1.0-beta.6/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#510-beta6-2021-04-06)
#### New features
- Add overloads to `ExtractKeyPhrasesBatch` and `ExtractKeyPhrasesBatchAsync` to on `TextAnalyticsClient` to accept `ExtractKeyPhrasesOptions` and hid the previous methods (non-breaking change).
- Add overloads to `RecognizeEntitiesBatch` and `RecognizeEntitiesBatchAsync` to on `TextAnalyticsClient` to accept `RecognizeEntitiesOptions` and hid the previous methods (non-breaking change).
- Add overloads to `RecognizeLinkedEntitiesBatch` and `RecognizeLinkedEntitiesBatch` to on `TextAnalyticsClient` to accept `RecognizeLinkedEntitiesOptions` and hid the previous methods (non-breaking change).

#### Breaking changes
- Renamed `TotalActions` to `ActionsTotal`.

### Tables 12.0.0-beta.7 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Data.Tables_12.0.0-beta.7/sdk/tables/Azure.Data.Tables/CHANGELOG.md#1200-beta7-2021-04-06)
#### Acknowledgments

Thank you to our developer community members who helped to make Azure Tables better with their contributions to this release:

- Joel Verhagen _([GitHub](https://github.com/joelverhagen))_

#### Added

- Added the `TableErrorCode` type which allows comparison of the `ErrorCode` on `RequestFailedException`s thrown from client operations with a known error value.
- `TableEntity` and custom entity types now support `BinaryData` properties.

#### Key Bug Fixes

- Fixed handling of paging headers when Table Storage returned a `x-ms-continuation-NextPartitionKey` but no `x-ms-continuation-NextRowKey`. This was causing an HTTP 400 on the subsequent page query (A community contribution, courtesy of _[joelverhagen](https://github.com/joelverhagen)_)

#### Changed

- Removed the `Timestamp` property from the serialized entity when sending it to the service as it is ignored by the service (A community contribution, courtesy of _[joelverhagen](https://github.com/joelverhagen)_)

### Synapse - Artifacts 1.0.0-preview.8 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Analytics.Synapse.Artifacts_1.0.0-preview.8/sdk/synapse/Azure.Analytics.Synapse.Artifacts/CHANGELOG.md#100-preview8-2021-04-06)
#### Added
- Many additional model classes

#### Changed
- Exposed Serialization and Deserialization methods.

### App Configuration 1.1.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Data.AppConfiguration_1.1.0-beta.2/sdk/appconfiguration/Azure.Data.AppConfiguration/CHANGELOG.md#110-beta2-2021-04-06)
#### Breaking changes

- The `AddSyncToken` method renamed to `UpdateSyncToken`.

### Translation Document 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.AI.Translation.Document_1.0.0-beta.1/sdk/translation/Azure.AI.Translation.Document/CHANGELOG.md#100-beta1-2021-04-06)
This is the first beta package of the Azure.AI.Translation.Document client library that targets the service version `1.0-preview.1`.
This package's documentation and samples demonstrate the new API.

### Cognitive Search 11.3.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Search.Documents_11.3.0-beta.1/sdk/search/Azure.Search.Documents/CHANGELOG.md#1130-beta1-2021-04-06)
#### Added
- Added support for [`Azure.Core.GeoJson`](https://docs.microsoft.com/dotnet/api/azure.core.geojson) types in `SearchDocument`, `SearchFilter` and `FieldBuilder`.
- Added [`EventSource`](https://docs.microsoft.com/dotnet/api/system.diagnostics.tracing.eventsource) based logging. Event source name is **Azure-Search-Documents**. Current set of events are focused on tuning batch sizes for [`SearchIndexingBufferedSender`](https://docs.microsoft.com/dotnet/api/azure.search.documents.searchindexingbufferedsender-1).
- Added [`CustomEntityLookupSkill`](https://docs.microsoft.com/azure/search/cognitive-search-skill-custom-entity-lookup) and [`DocumentExtractionSkill`](https://docs.microsoft.com/azure/search/cognitive-search-skill-document-extraction). Added `DefaultCountryHint` in [`LanguageDetectionSkill`](https://docs.microsoft.com/azure/search/cognitive-search-skill-language-detection).
- Added [`LexicalNormalizer`](https://docs.microsoft.com/azure/search/search-normalizers#predefined-normalizers) to include predefined set of normalizers. See [here](https://docs.microsoft.com/azure/search/search-normalizers) for more details on search normalizers. Added `Normalizer` as a [`SearchField`](https://docs.microsoft.com/dotnet/api/azure.search.documents.indexes.models.searchfield) in an index definition.
- Added support for Azure Data Lake Storage Gen2 - [`AdlsGen2`](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-introduction) in [`SearchIndexerDataSourceType`](https://docs.microsoft.com/dotnet/api/azure.search.documents.indexes.models.searchindexerdatasourcetype).

### Form Recognizer 3.1.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.AI.FormRecognizer_3.1.0-beta.4/sdk/formrecognizer/Azure.AI.FormRecognizer/CHANGELOG.md#310-beta4-2021-04-06)
#### New Features
- Added support for pre-built passports and US driver licenses recognition with the `StartRecognizeIdDocuments` API.
- Expanded the set of document languages that can be provided to the `StartRecognizeContent` API.
- Added property `Pages` to `RecognizeBusinessCardsOptions`, `RecognizeCustomFormsOptions`, `RecognizeInvoicesOptions`, and `RecognizeReceiptsOptions` to specify the page numbers to recognize.
- Added property `ReadingOrder` to `RecognizeContentOptions` to specify the order in which recognized text lines are returned.

#### Breaking changes
- The client defaults to the latest supported service version, which currently is `2.1-preview.3`.
- `StartRecognizeCustomForms` now throws a `RequestFailedException` when an invalid file is passed.

### Identity 1.4.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Identity_1.4.0-beta.5/sdk/identity/Azure.Identity/CHANGELOG.md#140-beta5-2021-04-06)
#### Acknowledgments

Thank you to our developer community members who helped to make Azure Identity better with their contributions to this release:

- Marco Mansi _([GitHub](https://github.com/olandese))_

#### New Features

- Added `AzurePowerShellCredential` to `DefaultAzureCredential` (A community contribution, courtesy of _[olandese](https://github.com/olandese))_

#### Fixes and improvements

- When logging is enabled, the log output from MSAL is also logged.
- Fixed an issue where an account credential fails to load from the cache when EnableGuestTenantAuthentication is true and the account found in the cache has multiple matching tenantIds ([#18276](https://github.com/Azure/azure-sdk-for-net/issues/18276)).
- Fixed deadlock issue in `InteractiveBrowserCredential` when running in a UI application ([#18418](https://github.com/Azure/azure-sdk-for-net/issues/18418)).

#### Breaking Changes

- `TokenCache` class is moved removed from the public API surface and has been replaced by `TokenCachePersistenceOptions` for configuration of disk based persistence of the token cache.

### Core - AMQP 1.1.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Core.Amqp_1.1.0-beta.1/sdk/core/Azure.Core.Amqp/CHANGELOG.md#110-beta1-2021-04-06)
#### Added
- Added support for Sequence and Value body messages.

### WebJobs Extensions - Event Hubs 5.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.Azure.WebJobs.Extensions.EventHubs_5.0.0-beta.4/sdk/eventhub/Microsoft.Azure.WebJobs.Extensions.EventHubs/CHANGELOG.md#500-beta4-2021-04-06)
#### Changes

- Single dispatch triggers were disabled.

### System Memory Data 1.0.2 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/System.Memory.Data_1.0.2/sdk/core/System.Memory.Data/CHANGELOG.md#102-2021-04-07)
- Add System.Text.Encodings.Web dependency

### Core 1.13.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Core_1.13.0/sdk/core/Azure.Core/CHANGELOG.md#1130-2021-04-07)
#### Key Bug Fixes

- Fixed `NotSupportedException` when running using Blazor in the browser.
- Disable the response caching and enable the streaming when running using Blazor in the browser.

### Computer Vision 7.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.Azure.CognitiveServices.Vision.ComputerVision_7.0.0/sdk/cognitiveservices/Vision.ComputerVision/CHANGELOG.md#700-2021-04-12)
Supports v3.2 Cognitive Services Computer Vision API endpoints.

#### Added

* Added model versioning support

#### Changed

* Updated the Adult visual feature for Analyze Image operation
* Updated the Tags visual feature for Analyze Image operation and the Tag Image operation
* Updated the error response format

### Azure Communication Chat 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.Chat/CHANGELOG.md#100-2021-03-29)
**Includes all changes from 1.0.0-beta.1 to  1.0.0.beta.5**

#### Breaking Changes
- Renamed client constructors URL variable to `endpoint`.
- Renamed `ChatThread` model to `ChatThreadProperties`.
- Renamed `GetChatThread` operation to `GetPropertie`s and moved it to `ChatThreadClient`.
- Renamed `ChatThreadInfo` model to `ChatThreadItem`.
- Renamed `GetChatThreadsInfo` operation to `GetChatThreads`.
- Made `AddParticipant` throw exception when request fails.
- Renamed parameter `repeatabilityRequestId` to `idempotencyToken`.
- Updated `SendMessage` to use `SendChatMessageResult` instead of `string` for the request result.
- Exposed the list of `invalidparticipants` directly and removed `AddChatParticipantsErrors` and `CreateChatThreadErrors` models for `AddChatParticipantsResult` and `CreateChatThreadResult`.

#### Added
- Made list of participants optional for `CreateChatThread`.
- Made `ChatThreadClient` constructor public.

### Azure Communication Common 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.Common/CHANGELOG.md#100-2021-03-29)
**Includes all changes from 1.0.0-beta.1 to  1.0.0.beta.5**

### Azure Communication Identity 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.Identity/CHANGELOG.md#100-2021-03-29)
**Includes all changes from 1.0.0-beta.1 to  1.0.0.beta.5**

### Azure Communication Phone Numbers 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.PhoneNumbers/CHANGELOG.md#100-beta6-2021-03-29)

### Added
- Added protected constructor to `PurchasePhoneNumbersOperation` and `ReleasePhoneNumberOperation` for mocking.

### Breaking Changes
- All models are moved from `Azure.Communication.PhoneNumbers.Models` namespace to `Azure.Communication.PhoneNumbers`.
- `AcquiredPhoneNumber` class is renamed to `PurchasedPhoneNumber`.
- `PhoneNumbersClient` methods renamed:
  - `GetPhoneNumber` -> `GetPurchasedPhoneNumber`.
  - `GetPhoneNumberAsync` -> `GetPurchasedPhoneNumberAsync`.
  - `GetPhoneNumbers` -> `GetPurchasedPhoneNumbers`.
  - `GetPhoneNumbersAsyn`c -> `GetPurchasedPhoneNumbersAsync`.
- `PhoneNumbersModelFactory` static method `AcquiredPhoneNumber` is renamed to `PurchasedPhoneNumber`.
- `PurchasePhoneNumbersOperation` and `ReleasePhoneNumberOperation` extend `Operation` instead of `Operation<Response>`.
- Removed `PhoneNumberOperationStatus` and `PhoneNumberOperationType`.
- Renamed `ISOCurrencySymbol` property to `IsoCurrencySymbol` in `PhoneNumberCost`.
- Renamed `threeLetterISOCountryName` parameter to `twoLetterIsoCountryName`` in `PhoneNumbersClient.StartSearchAvailablePhoneNumbers` and `PhoneNumbersClient.StartSearchAvailablePhoneNumbersAsync`.

### Azure Communication SMS 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.Sms/CHANGELOG.md#100-2021-03-29)
**Includes all changes from 1.0.0-beta.1 to  1.0.0.beta4**

### Resource Management - Communication 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.ResourceManager.Communication/CHANGELOG.md#100-2021-03-29)
This is the first stable release of the management library for `Azure Communication Services`. 

Minor changes since the public preview release:
- `CheckNameAvailability` has been added
- `CommunicationServiceResource` Update now requires a `CommunicationServiceResource` parameter instead of a `TaggedResource`
- `RegenerateKeyParameters` is now a required parameter to `RegenerateKey`
- `CommunicationServiceResource` now includes the property `SystemData`
- `OperationList` has been changed to use the common type for its response
- `ErrorResponse` has been changed to use the common type for `ErrorResponse`
### Storage - Files Shares 12.7.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Storage.Files.Shares_12.7.0-beta.3/sdk/storage/Azure.Storage.Files.Shares/CHANGELOG.md#1270-beta3-2021-04-09)
- This release contains bug fixes to improve quality.

### Storage - Blobs 12.9.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Storage.Blobs_12.9.0-beta.3/sdk/storage/Azure.Storage.Blobs/CHANGELOG.md#1290-beta3-2021-04-09)
- This release contains bug fixes to improve quality.

### Storage - Blobs Batch 12.6.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Storage.Blobs.Batch_12.6.0-beta.3/sdk/storage/Azure.Storage.Blobs.Batch/CHANGELOG.md#1260-beta3-2021-04-09)
- This release contains bug fixes to improve quality.

### Storage - Common 12.8.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Storage.Common_12.8.0-beta.3/sdk/storage/Azure.Storage.Common/CHANGELOG.md#1280-beta3-2021-04-09)
- Fixed bug in SasQueryParameters causing services (ss) reorder when parsing externally provided URI.

### Storage - Blobs ChangeFeed 12.0.0-preview.11 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Storage.Blobs.ChangeFeed_12.0.0-preview.11/sdk/storage/Azure.Storage.Blobs.ChangeFeed/CHANGELOG.md#1200-preview11-2021-04-09)
- This release contains bug fixes to improve quality.

### Storage - Queues 12.7.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Storage.Queues_12.7.0-beta.3/sdk/storage/Azure.Storage.Queues/CHANGELOG.md#1270-beta3-2021-04-09)
- This preview contains bug fixes to improve quality.

### Storage - Files Data Lake 12.7.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Storage.Files.DataLake_12.7.0-beta.3/sdk/storage/Azure.Storage.Files.DataLake/CHANGELOG.md#1270-beta3-2021-04-09)
- Aligned storage URL parsing with other platforms.

### Azure.IoT.ModelsRepository 1.0.0-preview.3 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.IoT.ModelsRepository_1.0.0-preview.3/sdk/modelsrepository/Azure.IoT.ModelsRepository/CHANGELOG.md#100-preview3-2021-04-12)
- Updated core dependencies to bring in security vulnerability fixes that are addressed in `Azure.Core v1.13.0` and `System.Memory.Data v1.0.2`

### Digital Twins - Core 1.2.2 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.DigitalTwins.Core_1.2.2/sdk/digitaltwins/Azure.DigitalTwins.Core/CHANGELOG.md#122-2021-04-12)
#### Fixes and improvements

- Updated core dependencies to bring in security vulnerability fixes that are addressed in `Azure.Core v1.13.0` and `System.Memory.Data v1.0.2`


[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
