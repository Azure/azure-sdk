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
- Service Bus
- Search

#### Updates

- Synapse

#### Beta

- Form Recognizer
- Metrics Advisor
- Text Analytics
- Event Grid
- Key Vault
- Storage

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.AI.FormRecognizer --version 3.1.0-beta.2
$> dotnet add package Azure.AI.MetricsAdvisor --version 1.0.0-beta.3
$> dotnet add package Azure.AI.TextAnalytics --version 5.1.0-beta.4

$> dotnet add package Azure.Messaging.EventGrid --version 4.0.0-beta.5
$> dotnet add package Azure.Messaging.EventHubs
$> dotnet add package Azure.Messaging.EventHubs.Processor
$> dotnet add package Azure.Messaging.ServiceBus

$> dotnet add package Azure.Search.Documents

$> dotnet add package Azure.Analytics.Synapse.AccessControl --version 1.0.0-preview.3
$> dotnet add package Azure.Analytics.Synapse.Artifacts --version 1.0.0-preview.6
$> dotnet add package Azure.Analytics.Synapse.ManagedPrivateEndpoints --version 1.0.0-beta.2
$> dotnet add package Azure.Analytics.Synapse.Monitoring --version 1.0.0-beta.2
$> dotnet add package Azure.Analytics.Synapse.Spark --version 1.0.0-preview.5

$> dotnet add package Azure.Security.KeyVault.Administration --version 4.0.0-beta.4
$> dotnet add package Azure.Security.KeyVault.Certificates --version 4.2.0-beta.4
$> dotnet add package Azure.Security.KeyVault.Keys --version 4.2.0-beta.4
$> dotnet add package Azure.Security.KeyVault.Secrets --version 4.2.0-beta.4

$> dotnet add package Azure.Storage.Blobs --version 12.9.0-beta.1
$> dotnet add package Azure.Storage.Blobs.Batch --version 12.6.0-beta.1
$> dotnet add package Azure.Storage.Blobs.ChangeFeed --version 12.0.0-preview.9
$> dotnet add package Azure.Storage.Common --version 12.8.0-beta.1
$> dotnet add package Azure.Storage.Files.DataLake --version 12.7.0-beta.1
$> dotnet add package Azure.Storage.Files.Shares --version 12.7.0-beta.1
$> dotnet add package Azure.Storage.Queues --version 12.7.0-beta.1
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.AI.FormRecognizer_3.1.0-beta.2/sdk/formrecognizer/Azure.AI.FormRecognizer/CHANGELOG.md#310-beta2-2021-02-09)

#### Breaking Changes

- Renamed the model `Appearance` to `TextAppearance`.
- Renamed the model `Style` to `TextStyle`.
- Renamed the extensible enum `TextStyle` to `TextStyleName`.
- Changed object type for property `Pages` under `RecognizeContentOptions` from `IEnumerable` to `IList`.
- Changed model type of `Locale` from `string` to `FormRecognizerLocale` in `RecognizeBusinessCardsOptions`, `RecognizeInvoicesOptions`, and `RecognizeReceiptsOptions`.
- Changed model type of `Language` from `string` to `FormRecognizerLanguage` in `RecognizeContentOptions`.

### Metrics Advisor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.AI.MetricsAdvisor_1.0.0-beta.3/sdk/metricsadvisor/Azure.AI.MetricsAdvisor/CHANGELOG.md#100-beta3-2021-02-09)

#### New Features

- Added support for AAD authentication in `MetricsAdvisorClient` and `MetricsAdvisorAdministrationClient`.

#### Breaking Changes

- The constructors of multiple classes, including `DataFeed`, `AnomalyDetectionConfiguration`, `AnomalyAlertConfiguration`, `EmailNotificationHook`, and `WebNotificationHook` are now parameterless. To see the full list of constructors affected, please check the Changelog.
- Collection properties are not settable anymore.
- `Create` and `Add` methods won't return the ID of the created entity anymore. A full object will be returned instead.

#### Key Bug Fixes

- Fixed a bug in which setting `WebNotificationHook.CertificatePassword` would actually set the property `Username` instead.
- Fixed a bug in which an `ArgumentNullException` was thrown when getting a data feed from the service as a viewer.
- Fixed a bug in which a data feed's administrators and viewers could not be set during creation.

### Text Analytics  [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.AI.TextAnalytics_5.1.0-beta.4/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#510-beta4-2021-02-10)

#### New Features

- Added property `Length` to `CategorizedEntity`, `SentenceSentiment`, `LinkedEntityMatch`, `AspectSentiment`, `OpinionSentiment`, and `PiiEntity`.
- `StringIndexType` has been added to all endpoints that expose the new properties `Offset` and `Length` to determine the encoding the service should use. It is added into the `TextAnalyticsRequestOptions` class and default for this SDK is `UTF-16`.
- `AnalyzeHealthcareEntitiesOperation` now exposes the properties `CreatedOn`, `ExpiresOn`, `LastModified`, and `Status`.
- `AnalyzeBatchActionsOperation ` now exposes the properties `CreatedOn`, `ExpiresOn`, `LastModified`, `Status`, `ActionsFailed`, `ActionsInProgress`,  `ActionsSucceeded`, `DisplayName` and `TotalActions`.

#### Breaking Changes

- Analyze healthcare was redesigned. It can be accessed now by calling the `StartHealthcareEntities` and `StartHealthcareEntitiesAsync` methods. All operations now support result pagination. Renames and structure overall changed. For more information, please see the changelog notes.
- Analyze operation batch was redesigned. It can be accessed now by calling the `StartAnalyzeBatchActions` and `StartAnalyzeBatchActionsAsync` methods. All operations now support result pagination. Renames and structure overall changed. For more information, please see the changelog notes.

### EventGrid [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Messaging.EventGrid_4.0.0-beta.5/sdk/eventgrid/Azure.Messaging.EventGrid/CHANGELOG.md#400-beta5-2021-02-09)

#### New Features
- Added `TryGetSystemEventData` that attempts to deserialize event data into a known system event.
- Added `EventGridSasBuilder` for constructing SAS tokens.
- Added `SystemEventNames` that contain the names that will be stamped into the event Type for system events.

#### Breaking Changes
- Updated `GetData` method to always return `BinaryData` instead of `object`. It no longer deserializes system events.
- Removed the `CloudEvent` constructor overload that took `BinaryData` and replaced with an overload that accepts `ReadOnlyMemory<byte>`
- Replaced use of `EventGridSasCredential` with `AzureSasCredential`.
- Removed `GenerateSharedAccessSignature` in favor of `EventGridSasBuilder`.

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Messaging.EventHubs_5.3.0/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md#530-2021-02-09)

#### New Features

- Connection strings can now be parsed into their key/value pairs using the `EventHubsConnectionStringProperties` class.
- The body of an event has been moved to the `EventData.EventBody` property and makes use of the new `BinaryData` type.  To preserve backwards compatibility, the existing `EventData.Body` property has been preserved with the current semantics.
- It is now possible to specify a custom endpoint to use for establishing the connection to the Event Hubs service in the `EventHubConnectionOptions` used by each of the clients.

#### Key Bug Fixes

- Upgraded the `Microsoft.Azure.Amqp` library to resolve crashes occurring in .NET 5.

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Messaging.EventHubs.Processor_5.3.0/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md#530-2021-02-09)

#### New Features

- Additional options for tuning load balancing have been added to the `EventProcessorClientOptions`.
- It is now possible to specify a custom endpoint to use for establishing the connection to the Event Hubs service in the `EventHubConnectionOptions` for the processor.
- Interactions with Blob Storage have been tuned for better performance and more efficient resource use.  This will also improve start-up time, especially when using the `Greedy` load balancing strategy.

#### Key Bug Fixes

- Upgraded the `Microsoft.Azure.Amqp` library to resolve crashes occurring in .NET 5.

### ServiceBus [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Messaging.ServiceBus_7.1.0/sdk/servicebus/Azure.Messaging.ServiceBus/CHANGELOG.md#710-2021-02-09)

#### Acknowledgments
Thank you to our developer community members who helped to make the Service Bus client library better with their contributions to this release:

- Aaron Dandy _([GitHub](https://github.com/aarondandy))_

#### Added
- Added virtual keyword to all client properties to enable mocking scenarios.
- Added `ServiceBusModelFactory.ServiceBusMessageBatch` to allow mocking a `ServiceBusMessageBatch`.

#### Key Bug Fixes
- Fixed an issue with the `ServiceBusProcessor` where closing and disposing or disposing multiple times resulted in an exception.  (A community contribution, courtesy of _[aarondandy](https://github.com/aarondandy)_)
- Fixed issue with batch size calculation when using `ServiceBusMessageBatch`.

### Search [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Search.Documents_11.2.0/sdk/search/Azure.Search.Documents/CHANGELOG.md#1120-2021-02-10)

#### New Features
- Added setters for `MaxLength` and `MinLength` in `LengthTokenFilter`.
- Added a public constructor for `SearchIndexingBufferedSender<T>`.
- Added `IndexActionEventArgs<T>` to track indexing actions.
- Added `IndexActionCompletedEventArgs<T>` to track the completion of an indexing action.
- Added `IndexActionFailedEventArgs<T>` to track the failure of an indexing action.

#### Breaking Changes

- Renamed `SearchIndexingBufferedSenderOptions<T>.MaxRetries` to `SearchIndexingBufferedSenderOptions<T>.MaxRetriesPerIndexAction`.
- Renamed `SearchIndexingBufferedSenderOptions<T>.MaxRetryDelay` to `SearchIndexingBufferedSenderOptions<T>.MaxThrottlingDelay`.
- Renamed `SearchIndexingBufferedSenderOptions<T>.RetryDelay` to `SearchIndexingBufferedSenderOptions<T>.ThrottlingDelay`.
- Removed the helper method `SearchClient.CreateIndexingBufferedSender<T>()`. Instead, callers are expected to use the public constructor of `SearchIndexingBufferedSender<T>`.

### Azure Communication Administration will be deprecated

- Identity client is moved to new package Azure Communication Identity.
- Phone number administration will be moved into a new package Azure Communication Phone Numbers.

### Azure Communication Common 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Communication.Common_1.0.0-beta.4/sdk/communication/Azure.Communication.Common/CHANGELOG.md#100-beta4-2021-02-09)

#### New Features

- Added MicrosoftTeamsUserIdentifier.

#### Breaking Changes

- Renamed CommunicationUserCredential to CommunicationTokenCredential.
- Replaced CommunicationTokenCredential(bool refreshProactively, Func<CancellationToken, string> tokenRefresher,Func<CancellationToken, ValueTask<string>>? asyncTokenRefresher = null, string? initialToken = null). with CommunicationTokenCredential(CommunicationTokenRefreshOptions tokenRefreshOptions).
- Renamed PhoneNumber to PhoneNumberIdentifier.
- Renamed CommunicationUser to CommunicationUserIdentifier.
- Removed CallingApplication.
- Renamed Id to RawId in PhoneNumberIdentifier.

### Azure Communication Identity 1.0.0-beta.4 [ChangeLog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Communication.Identity_1.0.0-beta.4/sdk/communication/Azure.Communication.Identity/CHANGELOG.md#100-beta4-2021-02-09)

### New Features

- Added CommunicationIdentityClient (originally was part of the Azure.Communication.Administration package).
- Added support to create CommunicationIdentityClient with TokenCredential.
- Added support to create CommunicationIdentityClient with AzureKeyCredential.
- Added ability to create a user and issue token for it at the same time.

### Breaking Changes

- CommunicationTokenScope.Pstn is removed.
- CommunicationIdentityClient.RevokeTokens now revoke all the currently issued tokens instead of revoking tokens issued prior to a given time.
- CommunicationIdentityClient.IssueToken returns an instance of `Azure.Core.AccessToken` instead of `CommunicationUserToken`.

### Azure Communication Chat (1.0.0-beta.4) [ChangeLog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-chat_1.0.0-beta.4/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta4-2021-02-09)

#### New Features

- Added support for `CreateChatThreadResult` and `AddChatParticipantsResult` to handle partial errors in batch calls.
- Added idempotency identifier parameter for chat creation calls.
- Added pagination support for `GetReadReceipts`, `GetReadReceiptsAsync` and `GetParticipants`, `GetParticipantsAsync`.
- Added new model for messages and content types: `Text`, `Html`, `ParticipantAdded`, `ParticipantRemoved`, `TopicUpdated`.
- Added new model for errors (`CommunicationError`).
- Added notifications for thread level changes.

#### Breaking Changes

- Updated to Azure.Communication.Common version 1.0.0-beta.4. Now uses `CommunicationUserIdentifier` and `CommunicationIdentifier` in place of `CommunicationUser`, and `CommunicationTokenCredential` instead of `CommunicationUserCredential`.
- Removed `Priority` field from `ChatMessage`.

### Synapse Artifacts [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Analytics.Synapse.Artifacts_1.0.0-preview.6/sdk/synapse/Azure.Analytics.Synapse.Artifacts/CHANGELOG.md#100-preview6-2021-02-10)

#### New Features
- Changed APIs on SparkJobDefinitionClient and SqlScriptClient to provide a Long Running Operation (LRO) when operations can be long in duration.
- Many models classes are now public.
- Added BigDataPoolsClient, IntegrationRuntimesClient, SqlPoolsClient, WorkspaceClient and associated support types.
- Support List/Get Synapse resources through data plane APIs.
- Support Rename operations.
- Support CICD operations.

### Synapse Spark [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Analytics.Synapse.Spark_1.0.0-preview.5/sdk/synapse/Azure.Analytics.Synapse.Spark/CHANGELOG.md#100-preview5-2021-02-11)

#### New Features
- Changed APIs on SparkBatchClient and SparkSessionClient to provide a Long Running Operation (LRO) when operations can be long in duration.

### Key Vault [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Security.KeyVault.Secrets_4.2.0-beta.4/sdk/keyvault/Azure.Security.KeyVault.Secrets/CHANGELOG.md#420-beta4-2021-02-10)

#### New features

- Secure Key Release has been removed from this release.

### Azure Storage Blobs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Blobs/CHANGELOG.md#1290-beta1-2021-02-09)

#### Key Bug Fixes
- Fixed bug where `BlobBaseClient.CanGenerateSasUri`, `BlobContainerClient.CanGenerateSasUri`, `BlobServiceClient.CanGenerateSasUri` were not mockable

### Azure Storage Blobs Batch [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Blobs.Batch/CHANGELOG.md#1260-beta1-2021-02-09)

#### New Features
- Added support for Batch Scoping subrequests to a specific container (`BlobBatchClient(BlobContainerClient)`, `BlobContainerClient.GetBlobBatchClient()`) (available in storage service version 2020-06-12 and newer).

### Azure Storage Common [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Common/CHANGELOG.md#1280-beta1-2021-02-09)

#### Key Bug Fixes
- Aligned storage URL parsing with other platforms.

### Azure Storage Files DataLake [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Files.DataLake/CHANGELOG.md#1270-beta1-2021-02-09)

#### New Features
- Added support for listing deleted file systems and restoring deleted file systems (available in storage service version 2020-06-12 and newer).

#### Key Bug Fixes
- Fixed bug where `DataLakeFileSystemClient.CanGenerateSasUri`, `DataLakeDirectoryClient.CanGenerateSasUri`, `DataLakeFileClient.CanGenerateSasUri`, `DataLakePathClient.CanGenerateSasUri`, `DataLakeServiceClient.CanGenerateSasUri` were not mockable

### Azure Storage Files Shares [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Files.Shares/CHANGELOG.md#1270-beta1-2021-02-09)

#### Key Bug Fixes
- - Fixed bug where `ShareFileClient.CanGenerateSasUri`, `ShareDirectoryClient.CanGenerateSasUri`, `ShareClient.CanGenerateSasUri`, `ShareServiceClient.CanGenerateSasUri` were not mockable

### Azure Storage Queues [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Queues/CHANGELOG.md#1270-beta1-2021-02-09)

#### New Features
- Added `MessageDecodingFailed` event to `QueueClientOptions`.

#### Key Bug Fixes
- Fixed bug where `QueueClient.CanGenerateSasUri` and `QueueServiceClient.CanGenerateSasUri` were not mockable.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
