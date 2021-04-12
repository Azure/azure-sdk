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
- App Configuration
- Attestation
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

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.AI.FormRecognizer --version 3.1.0-beta.4
$> dotnet add package Azure.AI.TextAnalytics --version 5.1.0-beta.6
$> dotnet add package Azure.AI.Translation.Document --version 1.0.0-beta.1
$> dotnet add package Azure.Analytics.Synapse.Artifacts --version 1.0.0-preview.8
$> dotnet add package Azure.Core --version 1.12.0
$> dotnet add package Azure.Core.Amqp --version 1.1.0-beta.1
$> dotnet add package Azure.Data.AppConfiguration --version 1.1.0-beta.2
$> dotnet add package Azure.Data.Tables --version 12.0.0-beta.7
$> dotnet add package Azure.Identity --version 1.4.0-beta.5
$> dotnet add package Azure.IoT.DeviceUpdate --version 1.0.0-beta.2
$> dotnet add package Azure.Messaging.EventHubs --version 5.4.0
$> dotnet add package Azure.Messaging.EventHubs.Processor --version 5.4.0
$> dotnet add package Azure.Search.Documents --version 11.3.0-beta.1
$> dotnet add package Azure.Security.Attestation --version 1.0.0-beta.2
$> dotnet add package Azure.Storage.Common --version 12.7.2
$> dotnet add package Microsoft.Azure.WebJobs.Extensions.EventHubs --version 5.0.0-beta.4
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


[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
