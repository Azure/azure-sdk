---
title: Azure SDK for JavaScript (March 2021)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

<!--
@azure/identity:1.2.4
@azure/abort-controller:1.0.3
@azure/abort-controller:1.0.4
@azure/core-client:1.0.0
@azure/core-rest-pipeline:1.0.0
@azure/core-rest-pipeline:1.0.1
@azure/core-rest-pipeline:1.0.2
@azure/keyvault-secrets:4.2.0-beta.3
@azure/keyvault-keys:4.2.0-beta.4
@azure/storage-file-share:12.5.0
@azure/storage-blob:12.5.0
@azure/storage-file-datalake:12.4.0
@azure/storage-queue:12.4.0
@azure/cosmos:3.10.2
@azure/cosmos:3.10.3
@azure/ai-text-analytics:5.1.0-beta.5
@azure/eventgrid:4.0.0
@azure/eventgrid:4.1.0
@azure/cosmos:3.10.4
 @azure/cosmos@3.10.5
@azure/app-configuration:1.1.1

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to make available the March 2021 client library release.

#### GA
- Core v2
- Storage - Files Shares
- Storage - Blobs
- Storage - Files Data Lake
- Storage - Queues
- Event Grid

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- App Configuration
- Identity
- Core - Abort Controller
- Core - Client
- Core - Rest-Pipeline
- Cosmos DB
- Event Grid

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Key Vault - Secrets
- Key Vault - Keys
- Azure Communication Common
- Azure Communication Identity
- Azure Communication Chat
- Azure Communication Phone Numbers
- Azure Communication SMS
- Event Hubs
- Azure Data Tables
- Azure Text Analytics

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/app-configuration:1.1.1
$> npm install @azure/identity@1.2.4
$> npm install @azure/core-client@1.0.0
$> npm install @azure/core-rest-pipeline@1.0.0
$> npm install @azure/core-rest-pipeline@1.0.1
$> npm install @azure/core-rest-pipeline@1.0.2
$> npm install @azure/abort-controller@1.0.3
$> npm install @azure/abort-controller:1.0.4
$> npm install @azure/ai-text-analytics@5.1.0-beta.5
$> npm install @azure/keyvault-secrets@4.2.0-beta.3
$> npm install @azure/keyvault-keys@4.2.0-beta.4
$> npm install @azure/communication-common@1.0.0-beta.6
$> npm install @azure/communication-identity@1.0.0-beta.5
$> npm install @azure/communication-chat@1.0.0-beta.5
$> npm install @azure/communication-phone-numbers@1.0.0-beta.4
$> npm install @azure/storage-file-share@12.5.0
$> npm install @azure/storage-blob@12.5.0
$> npm install @azure/storage-file-datalake@12.4.0
$> npm install @azure/storage-queue@12.4.0
$> npm install @azure/cosmos@3.10.2
$> npm install @azure/cosmos@3.10.3
$> npm install @azure/cosmos@3.10.4
$> npm install @azure/cosmos@3.10.5
$> npm install @azure/communication-sms@1.0.0-beta.4
$> npm install @azure/event-hubs@5.5.0-beta.1
$> npm install @azure/eventgrid@4.0.0
$> npm install @azure/eventgrid@4.1.0
$> npm install @azure/data-tables@12.0.0-beta.1
```

[pattern]: # ($> npm install ${PackageName}@${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Release highlights
### App Configuration 1.1.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/app-configuration_1.1.1/sdk/appconfiguration/app-configuration/CHANGELOG.md#111-2021-03-25)
- Fix issues with `select`ing fields to be returned from `listConfigurationSettings`, `listConfigurationRevisions`
  and `getConfigurationSetting` where `last_modified` and `content_type` could not properly be passed in.
  [PR #13258](https://github.com/Azure/azure-sdk-for-js/pull/13258)
### Identity 1.2.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/da08c62c46e40271482c3ae957e04caf7bd2be2d/sdk/identity/identity/CHANGELOG.md#124-2021-03-08)
This release doesn't have the changes from `1.2.4-beta.1`. Those will be present in the next beta release.
- Bug fix: Now if the `managedIdentityClientId` optional parameter is provided to `DefaultAzureCredential`, it will be properly passed through to the underlying `ManagedIdentityCredential`. Related to customer issue: [13872](https://github.com/Azure/azure-sdk-for-js/issues/13872).
- Bug fix: `ManagedIdentityCredential` now also properly handles `EHOSTUNREACH` errors. Fixes issue [13894](https://github.com/Azure/azure-sdk-for-js/issues/13894).
### Event Hubs 5.5.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/%40azure/event-hubs_5.5.0-beta.1/sdk/eventhub/event-hubs/CHANGELOG.md)
- Adds support for enabling idempotent partition event publishing with the EventHubProducerClient.
### Core - Abort Controller 1.0.3 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/abort-controller_1.0.3/sdk/core/abort-controller/CHANGELOG.md#103-2021-02-23)
Support Typescript version < 3.6 by down-leveling the type definition files. ([PR 12793](https://github.com/Azure/azure-sdk-for-js/pull/12793))
### Core - Abort Controller 1.0.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/abort-controller_1.0.4/sdk/core/abort-controller/CHANGELOG.md#104-2021-03-04)
Fixes issue [13985](https://github.com/Azure/azure-sdk-for-js/issues/13985) where abort event listeners that removed themselves when invoked could prevent other event listeners from being invoked.

### Core - Rest Pipeline 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/%40azure/core-rest-pipeline_1.0.0/sdk/core/core-rest-pipeline/CHANGELOG.md)
- Includes all changes in 1.0.0-beta.2 @azure/core-rest-pipeline package

### Core Rest Pipeline 1.0.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/core-rest-pipeline_1.0.1/sdk/core/core-rest-pipeline/CHANGELOG.md#101-2021-03-18)
- Fixed an issue where `timeout` and `abortSignal` of requests was not honored on Node after requests had already been issued to the server. [PR 14359](https://github.com/Azure/azure-sdk-for-js/pull/14359)

### Core Rest Pipeline 1.0.2 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/core-rest-pipeline_1.0.2/sdk/core/core-rest-pipeline/CHANGELOG.md#102-2021-03-25)
- Fixed an issue where chunked HTTP responses would sometimes be decoded incorrectly when multibyte characters were used. [PR 14517](https://github.com/Azure/azure-sdk-for-js/pull/14517)

### Core - Client 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/%40azure/core-client_1.0.0/sdk/core/core-client/CHANGELOG.md)
- Includes all changes in 1.0.0-beta.2 @azure/core-client package
### Key Vault - Secrets 4.2.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/keyvault-secrets_4.2.0-beta.3/sdk/keyvault/keyvault-secrets/CHANGELOG.md#420-beta3-2021-03-09)
- Updated the Latest service version to 7.2.
- Added a `certificateKeyId?: string` secret property to use instead of the deprecated `keyId?: URL` and removed `"lib": ["dom"]` from `tsconfig.json`

### Key Vault - Keys 4.2.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/keyvault-keys_4.2.0-beta.4/sdk/keyvault/keyvault-keys/CHANGELOG.md#420-beta4-2021-03-09)
- Updated the Latest service version to 7.2.
- Added `curve` to `createKeyOptions` to be used when creating an `EC` key.
- Deprecated the current `encrypt` and `decrypt` methods in favor of the more flexible overloads that take an `{Encrypt|Decrypt}Parameters` and allow passing in algorithm specific parameters. This enables support for the various AES algorithms used in Managed HSM. The deprecated methods continue to function and there's no timeline for their removal.
- Added `additionalAuthenticatedData`, `iv`, and `authenticationTag` to `EncryptResult` in order to support AES encryption and decryption.
- Refactored the various cryptography providers and updated the error messages to be clearer and more descriptive.

### Azure Communication Administration is deprecated

- `PhoneNumberAdministrationClient` is moved into the new package @azure/communication-phone-numbers and replaced by `PhoneNumbersClient`.

### Azure Communication Phone Numbers 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/communication/communication-phone-numbers/CHANGELOG.md#100-beta4-2021-03-09)

#### Breaking Changes

-  Removed `dist-browser` from the output folders. To bundle the Azure SDK libraries, please read our [bundling guide.](https://github.com/Azure/azure-sdk-for-js/blob/main/documentation/Bundling.md)

### Azure Communication Chat 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/communication/communication-chat/CHANGELOG.md#100-beta5-2021-03-09)

#### Breaking Changes

- Removed `_response` from returned models.
- Updated to @azure/communication-common@1.0.0-beta.6. Now uses `CommunicationIdentifier` in place of `CommunicationUserIdentifier`.
- Swap the parameter order in `ChatThreadClient` constructor.
- Generates `repeatabilityRequestId` if not populated in `createChatThread` operation.

### Azure Communication Common 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/communication/communication-common/CHANGELOG.md#100-beta6-2021-03-09)

##### New Features

- Updated @azure/communication-common version.

### Azure Communication Identity 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/communication/communication-identity/CHANGELOG.md#100-beta5-2021-03-09)

#### Breaking Changes

- `CommunicationIdentityClient` method `issueToken` renamed to `getToken`.
- `CommunicationIdentityClient` method `createUserWithToken` renamed to `createUserAndToken`.
- Renamed `CommunicationIdentityOptions` to `CommunicationIdentityClientOptions`.
- Removed `_response` from returned models.
- Removed `dist-browser` from the output folders. To bundle the Azure SDK libraries, please read our [bundling guide.](https://github.com/Azure/azure-sdk-for-js/blob/main/documentation/Bundling.md).

### Azure Communication SMS 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/communication/communication-sms/CHANGELOG.md#100-beta4-2021-03-09)

##### New Features

- `SmsClient` added a constructor that supports `TokenCredential`.
- Added support for 1:N SMS messaging.
- Added support for tagging SMS messages.
- `send` method in `SmsClient` is idempotent under retry policy.
-
#### Breaking Changes

- `SendRequest` renamed to `SmsSendRequest`.
- `SendOptions` renamed to `SmsSendOptions` and now has an additional field `tag` to add a custom tag to delivery reports (when enabled).
- `send` no longer returns `RestResponse`, now returns an array of `SmsSendResults`. This contains fields to validate success/failure of each sent message.
### Storage - Files Shares 12.5.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/storage-file-share_12.5.0/sdk/storage/storage-file-share/CHANGELOG.md#1250-2021-03-10)
- Updated Azure Storage Service API version to 2020-06-12.

### Storage - Blobs 12.5.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/storage-blob_12.5.0/sdk/storage/storage-blob/CHANGELOG.md#1250-2021-03-10)
- Includes all features released in 12.5.0-beta.1.

### Storage - Files Data Lake 12.4.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/storage-file-datalake_12.4.0/sdk/storage/storage-file-datalake/CHANGELOG.md#1240-2021-03-10)
- Includes all features released in 12.4.0-beta.1.

### Storage - Queues 12.4.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/storage-queue_12.4.0/sdk/storage/storage-queue/CHANGELOG.md#1240-2021-03-10)
- Updated Azure Storage Service API version to 2020-06-12.

### Cosmos DB 3.10.2 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/cosmos_3.10.2/sdk/cosmosdb/cosmos/CHANGELOG.md#3102-2021-03-11)
- BUGFIX: Fixes @azure/identity dependency in dev deps.

### Cosmos DB 3.10.3 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/cosmos_3.10.3/sdk/cosmosdb/cosmos/CHANGELOG.md#3103-2021-03-12)
- BUGFIX: Removes direct dependency on @azure/identity while retaining compatibility.
### Cosmos DB 3.10.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/cosmos_3.10.4/sdk/cosmosdb/cosmos/CHANGELOG.md#3104-2021-03-23)
- FEATURE: Adds Bulk continueOnError option
### Cosmos DB 3.10.5 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/cosmos_3.10.5/sdk/cosmosdb/cosmos/CHANGELOG.md#3105-2021-03-25)
- BUGFIX: Pins node-abort-controller version as we depend on a type in v1.2.0.
### Azure Data Tables 12.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/%40azure/data-tables_12.0.0-beta.1/sdk/tables/data-tables/CHANGELOG.md#1200-beta1-2021-03-09)
- Exclude browser unsupported headers when building a Batch request in the browser [#13955)](https://github.com/Azure/azure-sdk-for-js/pull/13955)
- Make connection string keys case-insensitive [#13954](https://github.com/Azure/azure-sdk-for-js/pull/13954)

### Azure Text Analytics 5.1.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/textanalytics/ai-text-analytics/CHANGELOG.md#510-beta5-2021-03-11)

##### New Features

- Targets the service's v3.1-preview.4 API as the default instead of v3.1-preview.3.
- `beginAnalyzeHealthcareEntities` returns a list of relations between healthcare entities.
- `recognizePiiEntities` takes a new option, categoriesFilter, that specifies a list of Pii categories to return.

#### Breaking Changes

- Aspects in opinions mining are now called targets and each individual opinion is now called an assessment. The new naming simplifies the naming of different parts of the response.

### Event Grid 4.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/eventgrid_4.0.0/sdk/eventgrid/eventgrid/CHANGELOG.md#400-2021-03-17)
- Update version to 4.0.0 to align with other EventGrid SDKs

#### Breaking Changes

- `EventGridConsumer` no longer applies any conversions to the `data` property of system events. The interfaces that describe the data payload of each
  system event has been updated to reflect this. The most visible impact of this change is that some properties of events are no longer converted into JavaScript `Date` objects, and instead are kepts as strings which contain ISO 8601 timestamps.
- Related to the above, `EventGridConsumer` no longer accepts a set of custom converters that can be used to further transform the `data` property of a specific event type when deserializing events.
- The interfaces which describe the shape of the `data` member of system events have been updated so that properties always included in the event are not typed as optional.

### Event Grid 4.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/eventgrid_4.1.0/sdk/eventgrid/eventgrid/CHANGELOG.md#410-2021-03-23)
- The system event names `Microsoft.Communication.ChatParticipantAddedToThread` and `Microsoft.Communication.ChatParticipantRemovedFromThread` have been removed, and
  `Microsoft.Communication.ChatThreadParticipantAdded` and `Microsoft.Communication.ChatThreadParticipantRemoved` have been added. The old names did not match the
  the type names that Azure Communication Services was using for these events. TypeScript users will now see compliation errors if they are calling `isSystemEvent` with
  either `Microsoft.Communication.ChatParticipantAddedToThread` or `Microsoft.Communication.ChatParticipantRemovedFromThread` as the event name. To fix these issues,
  replace all uses of `Microsoft.Communication.ChatParticipantAddedToThread` with `Microsoft.Communication.ChatThreadParticipantAdded` and
  `Microsoft.Communication.ChatParticipantRemovedFromThread` with `Microsoft.Communication.ChatThreadParticipantRemoved`.
- Add `Microsoft.Communications.RecordingFileStatusUpdated` system event.

[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
