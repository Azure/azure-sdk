---
title: Azure SDK for JavaScript (February 2021)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the February 2021 client library release.

#### GA

- Azure Search Documents
- Azure Event Hubs

#### Updates

- Azure Storage Blob
- Azure Storage Queue
- Azure File Datalake
- Azure File Share
- Azure Identity

#### Beta

- Azure Text Analytics
- Azure Metrics Advisor
- Azure Form Recognizer
- Azure Identity
- Azure Key Vault Keys
- Azure Key Vault Admin
- Azure Storage Blob
- Azure File Datalake
- Azure Event Grid
- Azure Data Tables
- Azure Communication Common
- Azure Communication Identity
- Azure Communication Chat

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/search-documents
$> npm install @azure/event-hubs
$> npm install @azure/storage-blob
$> npm install @azure/storage-file-datalake
$> npm install @azure/storage-file-share
$> npm install @azure/storage-queue
$> npm install @azure/ai-text-analytics@next
$> npm install @azure/ai-metrics-advisor@next
$> npm install @azure/ai-form-recognizer@next
$> npm install @azure/identity@next
$> npm install @azure/keyvault-keys@next
$> npm install @azure/keyvault-admin@next
$> npm install @azure/storage-blob@next
$> npm install @azure/storage-file-datalake@next
$> npm install @azure/eventgrid@next
$> npm install @azure/data-tables@next
$> npm install @azure/communication-common@next
$> npm install @azure/communication-identity@next
$> npm install @azure/communication-chat@next
```

[pattern]: # ($> npm install ${PackageName}@${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Release highlights

### Azure Search Documents

We're releasing a new GA for the Azure Search Documents client.

#### @azure/search-documents [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/search/search-documents/CHANGELOG.md#1110-2021-02-11)

##### New Features in @azure/search-documents@11.1.0

- Adds support for indexing search documents with intelligent batching, automatic flushing, and retries for failed indexing actions.

### Azure Event Hubs

We're releasing a new GA for the Azure Event Hubs client with new features and a major fix.

#### @azure/event-hubs [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/eventhub/event-hubs/CHANGELOG.md#540-2021-02-09)

##### New Features in @azure/event-hubs@5.4.0

- You can now specify custom endpoint address as a client constructor option to use when communicating with the Event Hubs service, which is useful when your network does not allow communicating to the standard Event Hubs endpoint.
- Added a helper method `parseEventHubConnectionString` that can be used to validate and parse a given connection string for Azure Event Hubs.

### Azure Identity

Identity is releasing a patch with a dependency fix and a bug fix, and a beta that includes MSAL 2.0 with PKCE support.

#### @azure/identity [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/identity/identity/CHANGELOG.md)

##### Major Fixes in @azure/identity@1.2.3 ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/identity/identity/CHANGELOG.md#123-2021-02-09))

- Fixed a bug that appeared while using `InteractiveBrowserCredential` to authenticate against Azure Stack from NodeJS (for local apps that would ask for authentication using a browser window). Azure Stack has specific authentication requirements that were missed on our previous `InteractiveBrowserCredential` release.

##### Changes in @azure/identity@1.2.4-beta.1 ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/identity/identity/CHANGELOG.md#124-beta1-2021-02-12))

- In this beta we've updated `InteractiveBrowserCredential` to use by default the [Auth Code Flow with PKCE](https://docs.microsoft.com/azure/active-directory/develop/v2-oauth2-auth-code-flow) rather than the [Implicit Grant Flow](https://docs.microsoft.com/azure/active-directory/develop/v2-oauth2-implicit-grant-flow) to better support browsers with enhanced security restrictions.

### Azure Key Vault

We're releasing some beta updates for the clients of the Key Vault service with small updates and breaking changes only from the last beta updates released.

#### @azure/keyvault-admin [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/keyvault/keyvault-admin/CHANGELOG.md#400-beta2-2021-02-09)

##### Changes on @azure/keyvault-admin@4.0.0-beta.2

- Backup and restore operations will now return a `BackupResult` and `RestoreResult` as appropriate.

##### New Features on @azure/keyvault-admin@4.0.0-beta.2

- In this beta release we added support for custom role definitions which includes creating, updating, and deleting custom role definitions.

##### Major Fixes on @azure/keyvault-admin@4.0.0-beta.2

-  The logging of HTTP requests wasn't properly working - now it has been fixed and tests have been written that verify the fix.
- Backup / Restore polling will now correctly propagate any errors to the awaited call.

#### @azure/keyvault-keys [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/keyvault/keyvault-keys/CHANGELOG.md#420-beta3-2021-02-09)

##### New Features on @azure/keyvault-keys@4.2.0-beta.3

- A new `createOctKey` method to support easily creating oct / oct-HSM keys.
- `CryptographyClient` can now support "local only" mode by instantiating it with only a `JsonWebKey`, a new constructor overload was added to support this.
- Users can now get the `keyId` property from a `CryptographyClient`.

### Azure Text Analytics

We're releasing a new beta for the Text Analytics service including new features and some renamed properties and methods.

#### @azure/ai-text-analytics [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/textanalytics/ai-text-analytics/CHANGELOG.md#510-beta4-2021-02-10)

##### New Features in @azure/ai-text-analytics@5.1.0-beta.4

- A new option to control how the offset is calculated by the service. For more information, see [the Text Analytics documentation](https://docs.microsoft.com/azure/cognitive-services/text-analytics/concepts/text-offsets#offsets-in-api-version-31-preview).

##### Breaking Changes on @azure/ai-text-analytics@5.1.0-beta.4

- The healthcare entities returned by `beginAnalyzeHealthcareEntities` are now organized as a directed graph where the edges represent a certain type of healthcare relationship between the source and target entities. Edges are stored in the `relatedEntities` property.

### Azure Metrics Advisor

We are releasing a new  preview version for metrics advisor with AAD support feature

#### @azure/ai-metrics-advisor [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/metricsadvisor/ai-metrics-advisor/CHANGELOG.md#100-beta3-2021-02-09)

##### New Features in @azure/ai-metrics-advisor@1.0.0@beta.3

- Metrics Advisor is releasing support for Azure Active Directory Authentication and the rotation of the API and Subscription Keys.

##### Breaking Changes in @azure/ai-metrics-advisor@1.0.0@beta.3

- Renamed a method `listDimensionValuesForDetectionConfig()` to `listAnomalyDimensionValues()`.
- Changed the response types for update methods.
- Added mapping of metric id to metric name in Datafeed object.

### Azure Form Recognizer

We're releasing a new beta client for the Azure Form Recognizer service with an upgrade for one TypeScript type.

#### @azure/ai-form-recognizer [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/formrecognizer/ai-form-recognizer/CHANGELOG.md#310-beta2-2021-02-09)

##### Breaking Changes in @azure/ai-form-recognizer@3.1.0-beta.2

- Reworked the type of the `appearance` field and its children of the `FormLine` type to have more specific names.

### Azure Storage

We released hot fix versions and also beta versions for new service features in Azure Storage Service API version 2020-06-10.

#### @azure/storage-blob [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-blob/CHANGELOG.md)

##### Major Fixes in @azure/storage-blob@12.4.1 ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-blob/CHANGELOG.md#1241-2021-02-03))

- Fixed a compile time failure in resolving the crypto module in Angular projects which got introduced in a previous update.
- Fixed an issue where the download stream returned by `BlobClient.download` method would not release underlying resources unless it's fully consumed.

##### New Features in @azure/storage-blob@12.5.0-beta.1 ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-blob/CHANGELOG.md#1250-beta1-2021-02-09))

- Now support Batch operations scoped to the Container level. You can use `ContainerClient.getBlobBatchClient()` to get such a `BlobBatchClient`.

#### @azure/storage-file-datalake [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-file-datalake/CHANGELOG.md)

##### Major Fixes in @azure/storage-file-datalake@12.3.1 ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-file-datalake/CHANGELOG.md#1231-2021-02-03))

- Fixed a compile time failure in resolving the crypto module in Angular projects which got introduced in a previous update.

##### New Features in @azure/storage-file-datalake@12.4.0-beta.1 ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-file-datalake/CHANGELOG.md#1240-beta1-2021-02-09))

- Added support for Container Soft Delete. You can restore a deleted filesystem via `DataLakeServiceClient.undeleteFileSystem()`. And the `DataLakeServiceClient.listFileSystems()` now support an `includeDeleted` option to include soft deleted filesystems in the response.

#### storage-file-share [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-file-share/CHANGELOG.md#1241-2021-02-03)

##### @azure/storage-file-share@12.4.1

This release contains bug fixes to improve quality.

#### storage-queue [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-queue/CHANGELOG.md#1231-2021-02-03)

##### @azure/storage-queue@12.3.1

This release contains bug fixes to improve quality.

### Azure Event Grid

We released a new beta package for the Event Grid service.

#### @azure/eventgrid [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/eventgrid/eventgrid/CHANGELOG.md#300-beta3-2020-10-06)

##### Breaking changes in @azure/eventgrid@3.0.0-beta.3

- The type definitions for SMS events sent by Azure Communication Services have been renamed, to use the prefix "AcsSms" instead of "Acssms". If you are using TypeScript and explicitly referencing these interfaces, you will need to update your code to use the new names. The payload of the events is unchanged.
- `EventGridSharedAccessCredential` has been removed, in favor of `AzureSASCredential`. Code which is using `EventGridSharedAccessCredential` should now use `AzureSASCredential` instead.
- When constructing the client, you must now include the schema type your topic is configured to expect (one of "EventGrid", "CloudEvent" or "Custom").
- The `sendEvents` methods have been collapsed into a single method on the client called `send` which uses the input schema that was configured on the client.

##### New Features in @azure/eventgrid@3.0.0-beta.3

- Added distributed tracing support. `EventGridProducerClient` will now create spans when sending events to Event Grid.

### Azure Data Tables

We released a new beta package for the Data Tables service.

#### @azure/data-tables [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/tables/data-tables/CHANGELOG.md#100-beta5-2021-02-09)

##### Breaking changes in @azure/data-tables@1.0.0-beta.5

- Migrated from  Core V1 (`@azure/core-http`) to Core v2 (`@azure/core-https` & `@azure/core-client`). With this change, the response types no longer contain the raw response `_response`. To access the raw response, an `onResponse` callback has to be passed in the request options bag.

### Azure Communication

Azure Communication Administration will be deprecated:

- Identity client is moved to new package Azure Communication Identity.
- Phone number administration will be moved into a new package Azure Communication Phone Numbers.

#### Azure Communication Common [ChangeLog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/communication-common_1.0.0-beta.5/sdk/communication/communication-common/CHANGELOG.md#100-beta5-2021-02-09)

##### Breaking Changes in @azure/communication-common@1.0.0-beta.5

- Removed `CallingApplicationIdentifier` and `isCallingApplicationIdentifier`.
- Removed `id` from `CommunicationUserIdentifier`.
- Renamed `id` to `rawId` in `PhoneNumberIdentifier`.
- Renamed `id` to `rawId` in `MicrosoftTeamsUserIdentifier`.

#### Azure Communication Identity [ChangeLog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/communication-identity_1.0.0-beta.4/sdk/communication/communication-identity/CHANGELOG.md#100-beta4-2021-02-09)

##### New Features in @azure/communication-identity@1.0.0-beta.4

- Added `CommunicationIdentityClient` (originally part of the `@azure/communication-administration` package).
- `CommunicationIdentityClient` added a constructor that supports `TokenCredential`.
- `CommunicationIdentityClient` added a new method `createUserWithToken`.

##### Breaking Changes in @azure/communication-identity@1.0.0-beta.4

- Replaced `CommunicationUser` with `CommunicationUserIdentifier`.
- `CommunicationIdentityClient` method `revokeTokens` no longer accepts `tokensValidFrom` as an argument.
- `pstn` is removed from `TokenScope`
- `issueToken` no longer returns the `CommunicationUser` alongside the token.

#### Azure Communication Chat [ChangeLog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/communication-chat_1.0.0-beta.4/sdk/communication/communication-chat/CHANGELOG.md#100-beta4-2021-02-09)

##### New Features in @azure/communication-chat@1.0.0-beta.4

- Added support for `CreateChatThreadResult` and `AddChatParticipantsResult` to handle partial errors in batch calls.
- Added idempotency identifier parameter for chat creation calls.
- Added support for `listReadReceipts` and `listParticipants` pagination.
- Added new model for messages an content types : `Text`, `Html`, `ParticipantAdded`, `ParticipantRemoved`, `TopicUpdated`.
- Added new model for errors (`CommunicationError`)
- Added notifications for thread level changes.

##### Breaking Changes in @azure/communication-chat@1.0.0-beta.4

- Updated to @azure/communication-common@1.0.0-beta.5. Now uses `CommunicationUserIdentifier` in place of `CommunicationUser`, and `CommunicationTokenCredential` instead of `CommunicationUserCredential`.
- Removed `priority` field from `ChatMessage`.

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
