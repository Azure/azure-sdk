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

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to announce our March 2021 client library releases.

#### GA
- Core
- Event Grid
- Azure Mixed Reality Authentication

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- App Configuration
- Event Hubs
- Event Hubs - Event Processor

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Communication Chat
- Communication Common
- Communication Identity
- Communication Phone Numbers
- Communication SMS
- Form Recognizer
- Identity
- Service Bus
- Synapse - Artifacts
- Tables
- Text Analytics

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
$> dotnet add package Azure.Communication.PhoneNumbers --version 1.0.0-beta.5
$> dotnet add package Azure.Communication.SMS --version 1.0.0-beta.5
$> dotnet add package Azure.Core --version 1.10.0
$> dotnet add package Azure.Data.AppConfiguration --version 1.1.0-beta.1
$> dotnet add package Azure.Data.Tables --version 12.0.0-beta.6
$> dotnet add package Azure.Identity --version 1.4.0-beta.4
$> dotnet add package Azure.Messaging.EventHubs --version 5.3.1
$> dotnet add package Azure.Messaging.EventHubs.Processor --version 5.3.1
$> dotnet add package Azure.MixedReality.Authentication --version 1.0.0
$> dotnet add package Azure.MixedReality.RemoteRendering --version 1.0.0-beta.3
$> dotnet add package Azure.MixedReality.ObjectAnchors.Conversion --version 0.1.0-beta.1
```

[pattern]: # ($> dotnet install ${PackageName} --version ${PackageVersion})

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

### Azure Communication Chat 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.Chat/CHANGELOG.md#100-beta5-2021-03-09)

#### Breaking Changes

- Added support for communication identifiers instead of raw strings.
- Removed support for nullable reference types.

### Azure Communication Common  1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.Common/CHANGELOG.md#100-beta5-2021-03-09)

#### Breaking Changes

- Updated `CommunicationTokenRefreshOptions(bool refreshProactively, Func<CancellationToken, string> tokenRefresher,  Func<CancellationToken, ValueTask<string>> asyncTokenRefresher = null, string initialToken = null)`
to `CommunicationTokenRefreshOptions(bool refreshProactively, Func<CancellationToken, string> tokenRefresher)`. `AsyncTokenRefresher` and `InitialToken` are updated to become public properties.

### Azure Communication Identity 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.Identity/CHANGELOG.md#100-beta5-2021-03-09)

#### Breaking Changes

- `CommunicationIdentityClient.IssueToken` and `CommunicationIdentityClient.IssueTokenAsync` are renamed to `GetToken` and `GetTokenAsync`, respectively
- `CommunicationIdentityClient.CreateUserWithToken` and `CommunicationIdentityClient.CreateUserWithTokenAsync` are renamed to `CreateUserAndToken` and `CreateUserAndTokenAsync`, respectively. Their return value is also changed from `Tuple<CommunicationUserIdentifier, string>` to `CommunicationUserIdentifierAndToken`.

### Azure Communication Phone Numbers 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.PhoneNumbers/CHANGELOG.md#100-beta5-2021-03-09)

#### New Features

- Added `PhoneNumbersClient` (originally was part of the `Azure.Communication.Administration` package).
- Added support for Azure Active Directory Authentication.

#### Breaking Changes

- `PhoneNumberAdministrationClient` has been replaced with `PhoneNumbersClient`, which has the same functionality but different APIs. To learn more about how PhoneNumbersClient works, refer to the [README.md](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.PhoneNumbers/README.md)

### Azure Communication SMS 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.Sms/CHANGELOG.md#100-beta4-2021-03-09)

#### New Features

- Added support to create SmsClient with AzureKeyCredential.
- Added support to create SmsClient with TokenCredential.
- Added support for 1:N SMS messaging.
- Added support for tagging SMS messages.
- Send method series in SmsClient are idempotent under retry policy.

#### Breaking Changes

- Updated `Task<Response<SendSmsResponse>> SendAsync(PhoneNumberIdentifier from, PhoneNumberIdentifier to, string message, SendSmsOptions sendSmsOptions = null, CancellationToken cancellationToken = default)`
to `Task<Response<SmsSendResult>> SendAsync(string from, string to, string message, SmsSendOptions options = default)`
- Replaced `SendSmsResponse` with `SmsSendResult`

### Core 1.10.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Core_1.10.0/sdk/core/Azure.Core/CHANGELOG.md#1100-2021-03-09)
- Added `CloudEvent` type based on the [CloudEvent spec](https://github.com/cloudevents/spec/blob/master/spec.md).

### App Configuration 1.1.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Data.AppConfiguration_1.1.0-beta.1/sdk/appconfiguration/Azure.Data.AppConfiguration/CHANGELOG.md#110-beta1-2021-03-09)
#### Changes

##### New Features

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

- Update the default value of `ExcludeSharedTokenCacheCredential` on `DefaultAzureCredentialsOptions` to true, to exclude the `SharedTokenCacheCredential` from the `DefaultAzureCredential` by default. See [BREAKING_CHANGES.md](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/identity/Azure.Identity/BREAKING_CHANGES.md#140)

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

[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
