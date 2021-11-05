---
title: Azure SDK for .NET (March 2021)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

<!--
Azure.MixedReality.Authentication:1.0.0
Azure.MixedReality.RemoteRendering:1.0.0-beta.3
Azure.MixedReality.ObjectAnchors.Conversion:0.1.0-beta.1
Microsoft.Azure.CognitiveServices.Language.LUIS.Authoring:3.2.0-preview.4
Azure.Core:1.10.0
Azure.AI.FormRecognizer:3.1.0-beta.3
Azure.AI.TextAnalytics:5.1.0-beta.5
Azure.Data.Tables:12.0.0-beta.6
Azure.Data.AppConfiguration:1.1.0-beta.1
Azure.Messaging.EventHubs:5.3.1
Azure.Messaging.EventHubs.Processor:5.3.1
Azure.Identity:1.4.0-beta.4
Azure.Messaging.EventHubs:5.4.0-beta.1
Azure.Analytics.Synapse.Artifacts:1.0.0-preview.7
Azure.Messaging.EventHubs.Processor:5.4.0-beta.1
Azure.IoT.DeviceUpdate:1.0.0-beta.2
Azure.Core:1.11.0
Microsoft.Azure.WebJobs.Extensions.EventGrid:3.0.0-beta.1
Azure.Messaging.EventGrid:4.1.0
Microsoft.Azure.WebJobs.Extensions.ServiceBus:5.0.0-beta.1
Azure.Communication.Identity:1.0.0
Azure.Communication.Chat:1.0.0
Azure.Communication.PhoneNumbers:1.0.0-beta.6
Azure.Communication.Sms:1.0.0
Azure.Communication.Common:1.0.0
Azure.Storage.Queues:12.6.1
Azure.Storage.Files.DataLake:12.6.1
Azure.Storage.Files.Shares:12.6.1
Azure.Storage.Common:12.7.1
Azure.Storage.Blobs.Batch:12.5.1
Azure.Storage.Blobs:12.8.1
Azure.Quantum.Jobs:1.0.0-beta.2
Azure.IoT.ModelsRepository:1.0.0-preview.2

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to announce our March 2021 client library releases.

#### GA
- Azure Mixed Reality Authentication
- Core
- Event Grid

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- App Configuration
- Event Hubs
- Event Hubs - Event Processor
- Storage - Blobs
- Storage - Blobs Batch
- Storage - Common
- Storage - Files Data Lake
- Storage - Files Shares
- Storage - Queues

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Azure Communication Chat
- Azure Communication Common
- Azure Communication Identity
- Azure Communication Phone Numbers
- Azure Communication SMS
- Form Recognizer
- Identity
- IoT Device Update
- Service Bus
- Synapse - Artifacts
- Tables
- Text Analytics
- WebJobs Extensions - Event Grid
- WebJobs Extensions - Service Bus

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.AI.FormRecognizer --version 3.1.0-beta.3
$> dotnet add package Azure.AI.TextAnalytics --version 5.1.0-beta.5
$> dotnet add package Azure.Analytics.Synapse.Artifacts --version 1.0.0-preview.7
$> dotnet add package Azure.Communication.Chat --version 1.0.0-beta.5
$> dotnet add package Azure.Communication.Common --version 1.0.0-beta.5
$> dotnet add package Azure.Communication.Identity --version 1.0.0-beta.5
$> dotnet add package Azure.Communication.PhoneNumbers --version 1.0.0-beta.6
$> dotnet add package Azure.Communication.SMS --version 1.0.0-beta.4
$> dotnet add package Azure.Core --version 1.10.0
$> dotnet add package Azure.Core --version 1.11.0
$> dotnet add package Azure.Data.AppConfiguration --version 1.1.0-beta.1
$> dotnet add package Azure.Data.Tables --version 12.0.0-beta.6
$> dotnet add package Azure.Identity --version 1.4.0-beta.4
$> dotnet add package Azure.IoT.DeviceUpdate --version 1.0.0-beta.2
$> dotnet add package Azure.IoT.ModelsRepository --version 1.0.0-preview.2
$> dotnet add package Azure.Messaging.EventGrid --version 4.0.0
$> dotnet add package Azure.Messaging.EventGrid --version 4.1.0
$> dotnet add package Microsoft.Azure.Messaging.EventGrid.CloudNativeCloudEvents --version 1.0.0-beta.1
$> dotnet add package Azure.Messaging.EventHubs --version 5.3.1
$> dotnet add package Azure.Messaging.EventHubs.Processor --version 5.3.1
$> dotnet add package Azure.MixedReality.Authentication --version 1.0.0
$> dotnet add package Azure.MixedReality.ObjectAnchors.Conversion --version 0.1.0-beta.1
$> dotnet add package Azure.MixedReality.RemoteRendering --version 1.0.0-beta.3
$> dotnet add package Azure.Storage.Blobs --version 12.8.1
$> dotnet add package Azure.Storage.Blobs.Batch --version 12.5.1
$> dotnet add package Azure.Storage.Common --version 12.7.1
$> dotnet add package Azure.Storage.Files.DataLake --version 12.6.1
$> dotnet add package Azure.Storage.Files.Shares --version 12.6.1
$> dotnet add package Azure.Storage.Queues --version 12.6.1
$> dotnet add package Azure.Quantum.Jobs --version 1.0.0-beta.2
$> dotnet add package Microsoft.Azure.WebJobs.Extensions.EventGrid --version 3.0.0-beta.1
$> dotnet add package Microsoft.Azure.WebJobs.Extensions.ServiceBus --version 5.0.0-beta.1
```

[pattern]: # ($> dotnet add package ${PackageName} --version ${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights
### Form Recognizer 3.1.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.AI.FormRecognizer_3.1.0-beta.3/sdk/formrecognizer/Azure.AI.FormRecognizer/CHANGELOG.md#310-beta3-2021-03-09)
#### New features
- Added protected constructors for mocking to `Operation` types, such as `TrainingOperation` and `RecognizeContentOperation`.

### Text Analytics 5.1.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.AI.TextAnalytics_5.1.0-beta.5/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#510-beta5-2021-03-09)
#### New features
- Added ability to filter the categories returned in a Personally Identifiable Information recognition with the optional parameter `CategoriesFilter` in `RecognizePiiEntitiesOptions`.
- Added the ability to recognize linked entities under `StartAnalyzeBatchActions`.
- Added `RecognizeLinkedEntitiesOptions` to `TextAnalyticsActions`.
- Added `RecognizeLinkedEntitiesActionsResults` to `AnalyzeBatchActionsResult`.
- `AnalyzeHealthcareEntitiesResult`, now exposes the property `EntityRelations`of type `HealthcareEntityRelation`.
- Introduced `HealthcareEntityRelation` class which will determine all the different relations between the entities as `Roles`.
- Added `HealthcareEntityRelationRole`, which exposes `Name` and `Entity` of type `string` and `HealthcareEntity` respectively.
- `HealthcareEntityAssertion` is added to `HealthcareEntity` which further exposes `EntityAssociation`, `EntityCertainity` and `EntityConditionality`.
- Added new types under `HealthcareRelationType` class.

#### Breaking changes
- Renamed `AspectSentiment` to `TargetSentiment`.
- Renamed `MinedOpinion` to `SentenceOpinion`.
- Renamed `OpinionSentiment` to `AssessmentSentiment`.
- For `PiiEntity.Category` the type of the property is now `PiiEntityCategory` instead of `EntityCategory`.
- Removed `RelatedEntities`.
- `RecognizePiiEntitiesOptions.Domain` is now a nullable type.
- In `StartAnalyzeBatchActions` when all actions return status `failed` the SDK will no longer throw an exception. The request will succeed and the errors will be located at the specific action level.

#### Fixes
- `RecognizePiiEntities` and `TextAnalyticsActions.RecognizePiiEntitiesOptions` were always passing `PiiEntityDomainType.PHI`. Now, it is only passed when requested by the user [19086](https://github.com/Azure/azure-sdk-for-net/issues/19086).

### Synapse - Artifacts 1.0.0-preview.7 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Analytics.Synapse.Artifacts_1.0.0-preview.7/sdk/synapse/Azure.Analytics.Synapse.Artifacts/CHANGELOG.md#100-preview7-2021-03-17)
#### Added
- Many models classes now have public getters.
- Added new `LibraryClient` and associated support types.

### Azure Communication Administration is deprecated

- `PhoneNumberAdministrationClient` has moved into the new package `Azure.Communication.PhoneNumbers` and been replaced by `PhoneNumberClient`.

### Azure Communication Chat 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/communication/Azure.Communication.Chat/CHANGELOG.md#100-beta5-2021-03-09)

#### Breaking Changes
- Added support for communication identifiers instead of raw strings.
- Removed support for nullable reference types.

### Azure Communication Common  1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/communication/Azure.Communication.Common/CHANGELOG.md#100-beta5-2021-03-09)

#### Breaking Changes
- Updated `CommunicationTokenRefreshOptions(bool refreshProactively, Func<CancellationToken, string> tokenRefresher,  Func<CancellationToken, ValueTask<string>> asyncTokenRefresher = null, string initialToken = null)`
to `CommunicationTokenRefreshOptions(bool refreshProactively, Func<CancellationToken, string> tokenRefresher)`. `AsyncTokenRefresher` and `InitialToken` are updated to become public properties.

### Azure Communication Identity 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/communication/Azure.Communication.Identity/CHANGELOG.md#100-beta5-2021-03-09)

#### Breaking Changes
- `CommunicationIdentityClient.IssueToken` and `CommunicationIdentityClient.IssueTokenAsync` are renamed to `GetToken` and `GetTokenAsync`, respectively.
- `CommunicationIdentityClient.CreateUserWithToken` and `CommunicationIdentityClient.CreateUserWithTokenAsync` are renamed to `CreateUserAndToken` and `CreateUserAndTokenAsync`, respectively. Their return value is also changed from `Tuple<CommunicationUserIdentifier, string>` to `CommunicationUserIdentifierAndToken`.

### Azure Communication Phone Numbers 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/communication/Azure.Communication.PhoneNumbers/CHANGELOG.md#100-beta5-2021-03-09)

#### New features
- Added `PhoneNumbersClient` (originally was part of the `Azure.Communication.Administration` package).
- Added support for Azure Active Directory Authentication.

#### Breaking Changes
- `PhoneNumberAdministrationClient` has been replaced with `PhoneNumbersClient`, which has the same functionality but different APIs. To learn more about how PhoneNumbersClient works, refer to the [README.md](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/communication/Azure.Communication.PhoneNumbers/README.md)

### Azure Communication SMS 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/communication/Azure.Communication.Sms/CHANGELOG.md#100-beta4-2021-03-09)

#### New features
- Added support to create `SmsClient` with `AzureKeyCredential`.
- Added support to create `SmsClient` with `TokenCredential`.
- Added support for 1:N SMS messaging.
- Added support for tagging SMS messages.
- Send method series in `SmsClient` are idempotent under retry policy.

#### Breaking Changes
- Updated `Task<Response<SendSmsResponse>> SendAsync(PhoneNumberIdentifier from, PhoneNumberIdentifier to, string message, SendSmsOptions sendSmsOptions = null, CancellationToken cancellationToken = default)`
to `Task<Response<SmsSendResult>> SendAsync(string from, string to, string message, SmsSendOptions options = default)`
- Replaced `SendSmsResponse` with `SmsSendResult`

### Core 1.10.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Core_1.10.0/sdk/core/Azure.Core/CHANGELOG.md#1100-2021-03-09)
- Added `CloudEvent` type based on the [CloudEvent spec](https://github.com/cloudevents/spec/blob/v1.0.1/spec.md).

### Core 1.11.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Core_1.11.0/sdk/core/Azure.Core/CHANGELOG.md#1110-2021-03-22)
#### Added

- `Operation` base class for operations that do not return a value.
- Added `Content` property to `Response` which returns the body of the response as a `BinaryData` if the body is buffered.
- `AzureNamedKeyCredential` has been implemented to cover scenarios where services require that a shared key name and the key value be used as a component of the algorithm to form the authorization token.

#### Key Bug Fixes

- Check the `JsonIgnoreAttribute.Condition` property added in .NET 5 when discovering members with `JsonObjectSerializer`.
- `ETag` now returns `string.Empty` if it is constructed with a null value.
- Keep-Alive connections are recycled every 300 seconds to observe DNS changes.

### App Configuration 1.1.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Data.AppConfiguration_1.1.0-beta.1/sdk/appconfiguration/Azure.Data.AppConfiguration/CHANGELOG.md#110-beta1-2021-03-09)
#### Changes

##### New features

- Added `SecretReferenceConfigurationSetting` type to represent a configuration setting that references a KeyVault Secret.
- Added `FeatureFlagConfigurationSetting` type to represent a configuration setting that controls a feature flag.
- Added `AddSyncToken` to `ConfigurationClient` to be able to provide external synchronization tokens.

### Tables 12.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Data.Tables_12.0.0-beta.6/sdk/tables/Azure.Data.Tables/CHANGELOG.md#1200-beta6-2021-03-09)
#### Changed

- Changed major version number to 12 to indicate this is the latest Tables package across all legacy versions and for cross-language consistency.
- `TableClient` and `TableServiceClient` now accept `AzureSasCredential` for SAS token scenarios rather than requiring developers to build the URI manually.

#### Key Bug Fixes

- Fixed an issue that prevented start/end row key and partition key values from being used in Sas tokens

#### Added

- Added `TableUriBuilder`
- Added a constructor to `TableSasBuilder` and `TableAccountSasBuilder` that accepts a Uri with a Sas token

### Identity 1.4.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Identity_1.4.0-beta.4/sdk/identity/Azure.Identity/CHANGELOG.md#140-beta4-2021-03-09)

#### Fixes and Improvements

- Added the `[Serializable]` attribute to all custom exception types.

#### Breaking Changes

- Update the default value of `ExcludeSharedTokenCacheCredential` on `DefaultAzureCredentialsOptions` to true, to exclude the `SharedTokenCacheCredential` from the `DefaultAzureCredential` by default. See [BREAKING_CHANGES.md](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/identity/Azure.Identity/BREAKING_CHANGES.md#140)

### Event Grid 4.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Messaging.EventGrid_4.0.0/sdk/eventgrid/Azure.Messaging.EventGrid/CHANGELOG.md#400-2021-03-09)

#### New features

- Added single send overloads to allow sending a single event for each event type.

#### Breaking Changes

- Moved `CloudEvent` into `Azure.Core` package.
- Changed custom events to be represented as `BinaryData` rather than `Object`s.
- Removed `Serializer` option from `EventGridPublisherOptions` as serialization can be customized through `BinaryData`.

### EventGrid CloudNativeCloudEvents [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.Azure.Messaging.EventGrid.CloudNativeCloudEvents_1.0.0-beta.1/sdk/eventgrid/Microsoft.Azure.Messaging.EventGrid.CloudNativeCloudEvents/CHANGELOG.md)

#### New features

- Added Bridge library to allow sending CloudNative CloudEvents using Azure Event Grid.

### Event Hubs 5.3.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Messaging.EventHubs_5.3.1/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md#531-2021-03-09)

- Minor bug fixes and enhancements.

### Event Hubs - Event Processor 5.3.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Messaging.EventHubs.Processor_5.3.1/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md#531-2021-03-09)

- Minor bug fixes and enhancements.

### Azure Mixed Reality Authentication 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.MixedReality.Authentication_1.0.0/sdk/mixedreality/Azure.MixedReality.Authentication/CHANGELOG.md#100-2021-02-23)
- First stable release.

### Azure Remote Rendering 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.MixedReality.RemoteRendering_1.0.0-beta.3/sdk/remoterendering/Azure.MixedReality.RemoteRendering/CHANGELOG.md#100-beta3-2021-02-24)
- Allow the STS endpoint to be customized.
- Changed constructors to align with guidance.

### Azure Object Anchors Conversion 0.1.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.MixedReality.ObjectAnchors.Conversion_0.1.0-beta.1/sdk/objectanchors/Azure.MixedReality.ObjectAnchors.Conversion/CHANGELOG.md#010-beta1-2021-02-26)
- Initial client

### IoT Device Update 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.IoT.DeviceUpdate_1.0.0-beta.2/sdk/deviceupdate/Azure.Iot.DeviceUpdate/CHANGELOG.md#100-beta2-2021-04-06)
* Update root namespace from Azure.Iot.DeviceUpdate to Azure.IoT.DeviceUpdate
### WebJobs Extensions - Event Grid 3.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.Azure.WebJobs.Extensions.EventGrid_3.0.0-beta.1/sdk/eventgrid/Microsoft.Azure.WebJobs.Extensions.EventGrid/CHANGELOG.md#300-beta1-2021-03-23)
- The initial release of Microsoft.Azure.WebJobs.Extensions.EventGrid 3.0.0

### Event Grid 4.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Messaging.EventGrid_4.1.0/sdk/eventgrid/Azure.Messaging.EventGrid/CHANGELOG.md#410-2021-03-23)
#### New Features
- Added new Azure Communication Services system events.

#### Fixed
- Fixed system mapping for `AcsChatParticipantAddedToThread` and `AcsChatParticipantRemovedFromThread`.

### WebJobs Extensions - Service Bus 5.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.Azure.WebJobs.Extensions.ServiceBus_5.0.0-beta.1/sdk/servicebus/Microsoft.Azure.WebJobs.Extensions.ServiceBus/CHANGELOG.md#500-beta1-2021-03-23)
- The initial release of Microsoft.Azure.WebJobs.Extensions.ServiceBus 5.0.0

### Storage - Queues 12.6.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Storage.Queues_12.6.1/sdk/storage/Azure.Storage.Queues/CHANGELOG.md#1261-2021-03-29)
- Fixed bug where ClientDiagnostics's DiagnosticListener was leaking resources.

### Storage - Files Data Lake 12.6.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Storage.Files.DataLake_12.6.1/sdk/storage/Azure.Storage.Files.DataLake/CHANGELOG.md#1261-2021-03-29)
- Fixed bug where ClientDiagnostics's DiagnosticListener was leaking resources.

### Storage - Files Shares 12.6.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Storage.Files.Shares_12.6.1/sdk/storage/Azure.Storage.Files.Shares/CHANGELOG.md#1261-2021-03-29)
- Fixed bug where ClientDiagnostics's DiagnosticListener was leaking resources.

### Storage - Common 12.7.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Storage.Common_12.7.1/sdk/storage/Azure.Storage.Common/CHANGELOG.md#1271-2021-03-29)
- This release contains bug fixes to improve quality.

### Storage - Blobs Batch 12.5.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Storage.Blobs.Batch_12.5.1/sdk/storage/Azure.Storage.Blobs.Batch/CHANGELOG.md#1251-2021-03-29)
- Fixed bug where ClientDiagnostics's DiagnosticListener was leaking resources.

### Storage - Blobs 12.8.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Storage.Blobs_12.8.1/sdk/storage/Azure.Storage.Blobs/CHANGELOG.md#1281-2021-03-29)
- Fixed bug where ClientDiagnostics's DiagnosticListener was leaking resources.

### Azure.Quantum.Jobs 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Quantum.Jobs_1.0.0-beta.2/sdk/quantum/Azure.Quantum.Jobs/CHANGELOG.md#100-beta2-2021-03-30)
- Fixed a bug where the client was unable to authenticate using Interactive or Service Principal credentials (issue #19588)

### Azure.IoT.ModelsRepository 1.0.0-preview.2 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.IoT.ModelsRepository_1.0.0-preview.2/sdk/modelsrepository/Azure.IoT.ModelsRepository/CHANGELOG.md#100-preview2-2021-03-30)
#### Breaking changes

- Changing the package namespace from `Azure.IoT.ModelsRepository` to `Azure.IoT.ModelsRepository`


[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
