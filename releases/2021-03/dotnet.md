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

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to announce our March 2021 client library releases.

#### GA
- Azure Mixed Reality Authentication
- Core

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Event Hubs
- Event Hubs - Event Processor

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Azure Remote Rendering
- Azure Object Anchors Conversion
- Form Recognizer
- LUIS - Authoring
- Text Analytics
- Tables
- App Configuration
- Identity

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet install Azure.Core --version 1.10.0
$> dotnet add package Azure.Data.Tables --version 12.0.0-beta.6
$> dotnet add package Azure.Identity --version 1.4.0-beta.4
$> dotnet install Azure.MixedReality.Authentication --version 1.0.0
$> dotnet install Azure.MixedReality.RemoteRendering --version 1.0.0-beta.3
$> dotnet install Azure.MixedReality.ObjectAnchors.Conversion --version 0.1.0-beta.1
$> dotnet install Microsoft.Azure.CognitiveServices.Language.LUIS.Authoring --version 3.2.0-preview.4
$> dotnet install Azure.AI.FormRecognizer --version 3.1.0-beta.3
$> dotnet install Azure.AI.TextAnalytics --version 5.1.0-beta.5
$> dotnet install Azure.Data.Tables --version 12.0.0-beta.6
$> dotnet install Azure.Data.AppConfiguration --version 1.1.0-beta.1
$> dotnet install Azure.Messaging.EventHubs --version 5.3.1
$> dotnet install Azure.Messaging.EventHubs.Processor --version 5.3.1
$> dotnet install Azure.Identity --version 1.4.0-beta.4

```

[pattern]: # ($> dotnet install ${PackageName} --version ${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights
### Azure Mixed Reality Authentication 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.MixedReality.Authentication_1.0.0/sdk/mixedreality/Azure.MixedReality.Authentication/CHANGELOG.md#100-2021-02-23)
- First stable release.

### Azure Remote Rendering 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.MixedReality.RemoteRendering_1.0.0-beta.3/sdk/remoterendering/Azure.MixedReality.RemoteRendering/CHANGELOG.md#100-beta3-2021-02-24)
- Allow the STS endpoint to be customized.
- Changed constructors to align with guidance.

### Azure Object Anchors Conversion 0.1.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.MixedReality.ObjectAnchors.Conversion_0.1.0-beta.1/sdk/objectanchors/Azure.MixedReality.ObjectAnchors.Conversion/CHANGELOG.md#010-beta1-2021-02-26)
- Initial client

### Form Recognizer 3.1.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.AI.FormRecognizer_3.1.0-beta.3/sdk/formrecognizer/Azure.AI.FormRecognizer/CHANGELOG.md#310-beta3-2021-03-09)
#### New features
- Added protected constructors for mocking to `Operation` types, such as `TrainingOperation` and `RecognizeContentOperation`.

### Identity 1.4.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Identity_1.4.0-beta.4/sdk/identity/Azure.Identity/CHANGELOG.md)
- Added the `[Serializable]` attribute to all custom exception types.
- Update the default value of ExcludeSharedTokenCacheCredential on DefaultAzureCredentialsOptions to true, to exclude the SharedTokenCacheCredential from the DefaultAzureCredential by default. See BREAKING_CHANGES.md

### Tables 12.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Data.Tables_12.0.0-beta.6/sdk/tables/Azure.Data.Tables/CHANGELOG.md)
- Changed major version number to 12 to indicate this is the latest Tables package across all legacy versions and for cross language consistency.
- TableClient and TableServiceClient now accept AzureSasCredential for SAS token scenarios rather than requiring developers to build the URI manually.
- Added TableUriBuilder
- Added a constructor to TableSasBuilder and TableAccountSasBuilder that accepts a Uri with a Sas token
- Fixed an issue that prevented start/end row key and partition key values from being used in Sas tokens

### LUIS - Authoring 3.2.0-preview.4 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.Azure.CognitiveServices.Language.LUIS.Authoring_3.2.0-preview.4/sdk/cognitiveservices/Microsoft.Azure.CognitiveServices.Language.LUIS.Authoring/CHANGELOG.md#320-preview4-2021-02-25)
#### Fixed
- ExampleId attribute in label APIs could not hold int values
- ArmTokenParameter parameter name had a typo
### Core 1.10.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Core_1.10.0/sdk/core/Azure.Core/CHANGELOG.md#1100-2021-03-09)
- Added `CloudEvent` type based on the [CloudEvent spec](https://github.com/cloudevents/spec/blob/master/spec.md).

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

### Tables 12.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Data.Tables_12.0.0-beta.6/sdk/tables/Azure.Data.Tables/CHANGELOG.md#1200-beta6-2021-03-09)
#### Changed

- Changed major version number to 12 to indicate this is the latest Tables package across all legacy versions and for cross language consistency.
- `TableClient` and `TableServiceClient` now accept `AzureSasCredential` for SAS token scenarios rather than requiring developers to build the URI manually.

#### Key Bug Fixes

- Fixed an issue that prevented start/end row key and partition key values from being used in Sas tokens

#### Added

- Added TableUriBuilder
- Added a constructor to `TableSasBuilder` and `TableAccountSasBuilder` that accepts a Uri with a Sas token

### App Configuration 1.1.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Data.AppConfiguration_1.1.0-beta.1/sdk/appconfiguration/Azure.Data.AppConfiguration/CHANGELOG.md#110-beta1-2021-03-09)
#### Changes

##### New Features

- Added `SecretReferenceConfigurationSetting` type to represent a configuration setting that references a KeyVault Secret. 
- Added `FeatureFlagConfigurationSetting` type to represent a configuration setting that controls a feature flag.
- Added `AddSyncToken` to `ConfigurationClient` to be able to provide external synchronization tokens.

### Event Hubs 5.3.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Messaging.EventHubs_5.3.1/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md#531-2021-03-09)
#### Changes

##### Key Bug Fixes

- Fixed an issue where long-lived credentials (more than 49 days) were overflowing refresh timer limits and being rejected.

- Added detection and recovery for a race condition that occurred when the Event Hubs service closed a connection or link after the client had validated its state and was performing an operation; this will now be properly retried with a fresh connection/link.

- Extended retry scenarios to include generic I/O exceptions, as they are typically transient network failures.

- Extended retry scenarios to include authorization failures, as the Event Hubs services do not differentiate between authentication and authorization, callers cannot reason about whether an `Unauthorized` return from an operation indicates that the call will never succeed or may trigger a credential renewal that may allow success.

### Event Hubs - Event Processor 5.3.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Messaging.EventHubs.Processor_5.3.1/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md#531-2021-03-09)
#### Changes

##### Key Bug Fixes

- Fixed an issue where long-lived credentials (more than 49 days) were overflowing refresh timer limits and being rejected.

- Added detection and recovery for a race condition that occurred when the Event Hubs service closed a connection or link after the client had validated its state and was performing an operation; this will now be properly retried with a fresh connection/link.

- Extended retry scenarios to include generic I/O exceptions, as they are typically transient network failures.

- Extended retry scenarios to include authorization failures, as the Event Hubs services do not differentiate between authentication and authorization, callers cannot reason about whether an `Unauthorized` return from an operation indicates that the call will never succeed or may trigger a credential renewal that may allow success.

### Identity 1.4.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Identity_1.4.0-beta.4/sdk/identity/Azure.Identity/CHANGELOG.md#140-beta4-2021-03-09)
#### Fixes and Improvements

- Added the `[Serializable]` attribute to all custom exception types.

#### Breaking Changes

- Update the default value of `ExcludeSharedTokenCacheCredential` on `DefaultAzureCredentialsOptions` to true, to exclude the `SharedTokenCacheCredential` from the `DefaultAzureCredential` by default. See [BREAKING_CHANGES.md](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/identity/Azure.Identity/BREAKING_CHANGES.md#140)

[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
