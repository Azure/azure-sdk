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
```

[pattern]: # ($> npm install ${PackageName}@${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Release highlights

### Azure Event Hubs

We're releasing a new GA for the Azure Event Hubs client with new features and a major fix.

#### @azure/event-hubs [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/eventhub/event-hubs/CHANGELOG.md#540-2021-02-09)

##### New Features in @azure/event-hubs@5.4.0

- You can now specify custom endpoint address as a client constructor option to use when communicating with the Event Hubs service, which is useful when your network does not allow communicating to the standard Event Hubs endpoint.
- Added a helper method `parseEventHubConnectionString` that can be used to validate and parse a given connection string for Azure Event Hubs.

##### Major Fixes in @azure/event-hubs@5.4.0

- Fixes an issue where the `RetryMode` enum for use when setting the RetryOptions.mode field in `EventHubConsumerClientOptions` or `EventHubClientOptions` wasn't exported by the package.

### Azure Identity

Identity is releasing a patch with a dependency fix and a bug fix, and a beta that includes MSAL 2.0 with PKCE support.

#### @azure/identity [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/identity/identity/CHANGELOG.md)

##### Major Fixes in @azure/identity@1.2.3 ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/identity/identity/CHANGELOG.md#123-2021-02-09))

- Fixed Azure Stack support for the NodeJS version of the `InteractiveBrowserCredential`.
- The 'keytar' dependency has been updated to the latest version.

##### Changes in @azure/identity@1.2.4-beta.1

- In this beta we've updated `InteractiveBrowserCredential` to use the Auth Code Flow with PKCE rather than Implicit Grant Flow by default in the browser, to better support browsers with enhanced security restrictions.

### Azure Key Vault

We're releasing some beta updates for the clients of the Key Vault service with small updates and breaking changes only from the last beta updates released.

#### @azure/keyvault-admin [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/keyvault/keyvault-admin/CHANGELOG.md#400-beta2-2021-02-09)

##### Changes on @azure/keyvault-admin@4.0.0-beta.2

- Backup and restore operations will now return a `BackupResult` and `RestoreResult` as appropriate.

##### New Features on @azure/keyvault-admin@4.0.0-beta.2

- In this beta release we added support for custom role definitions which includes creating, updating, and deleting custom role definitions.

##### Major Fixes on @azure/keyvault-admin@4.0.0-beta.2

-  The logging of HTTP requests wasn't properly working - now it has been fixed and tests have been written that verify the fix.
- Backup / Restore polling will now correctly propagate any errors to the awaited call.

#### @azure/keyvault-keys [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/keyvault/keyvault-keys/CHANGELOG.md#420-beta3-2021-02-09)

##### New Features on @azure/keyvault-keys@4.2.0-beta.3

- A new `createOctKey` method to support easily creating oct / oct-HSM keys.
- `CryptographyClient` can now support "local only" mode by instantiating it with only a `JsonWebKey`, a new constructor overload was added to support this.
- Users can now get the `keyId` property from a `CryptographyClient`.

### Azure Text Analytics

We're releasing a new beta for the Text Analytics service including new features and some renamed properties and methods.

#### @azure/ai-text-analytics [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/textanalytics/ai-text-analytics/CHANGELOG.md#510-beta4-2021-02-10)

##### New Features in @azure/ai-text-analytics@5.1.0-beta.4

- A new option to control how the offset is calculated by the service. For more information, see [the Text Analytics documentation](https://docs.microsoft.com/azure/cognitive-services/text-analytics/concepts/text-offsets#offsets-in-api-version-31-preview).

##### Breaking Changes on @azure/ai-text-analytics@5.1.0-beta.4

- The healthcare entities returned by `beginAnalyzeHealthcareEntities` are now organized as a directed graph where the edges represent a certain type of healthcare relationship between the source and target entities. Edges are stored in the `relatedEntities` property.

### Azure Metrics Advisor

We are releasing a new  preview version for metrics advisor with AAD support feature

#### @azure/ai-metrics-advisor [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/metricsadvisor/ai-metrics-advisor/CHANGELOG.md#100-beta3-2021-02-09)

##### New Features in @azure/ai-metrics-advisor@1.0.0@beta.3

- Metrics Advisor is releasing support for Azure Active Directory Authentication and the rotation of the API and Subscription Keys.

##### Breaking Changes in @azure/ai-metrics-advisor@1.0.0@beta.3

- Renamed a method `listDimensionValuesForDetectionConfig()` to `listAnomalyDimensionValues()`.
- Changed the response types for update methods.
- Added mapping of metric id to metric name in Datafeed object.

### Azure Form Recognizer

We're releasing a new beta client for the Azure Form Recognizer service with an upgrade for one TypeScript type.

#### @azure/ai-form-recognizer [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/formrecognizer/ai-form-recognizer/CHANGELOG.md#310-beta2-2021-02-09)

##### Breaking Changes in @azure/ai-form-recognizer@3.1.0-beta.2

- Reworked the type of the `appearance` field and its children of the `FormLine` type to have more specific names.

### Azure Storage

We released hot fix versions and also beta versions for new service features in Azure Storage Service API version 2020-06-10.

#### @azure/storage-blob [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-blob/CHANGELOG.md)

##### Major Fixes in @azure/storage-blob@12.4.1 ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-blob/CHANGELOG.md#1241-2021-02-03))

- Fixed a compile time failure in resolving the crypto module in Angular projects which got introduced in a previous update. 
- Fixed an issue where the download stream returned by `BlobClient.download` method would not release underlying resources unless it's fully consumed.

##### New Features in @azure/storage-blob@12.5.0-beta.1 ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-blob/CHANGELOG.md#1250-beta1-2021-02-09))

- Now support Batch operations scoped to the Container level. You can use `ContainerClient.getBlobBatchClient()` to get such a `BlobBatchClient`.

#### @azure/storage-file-datalake [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-file-datalake/CHANGELOG.md)

##### Major Fixes in @azure/storage-file-datalake@12.3.1 ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-file-datalake/CHANGELOG.md#1231-2021-02-03))

- Fixed a compile time failure in resolving the crypto module in Angular projects which got introduced in a previous update.

##### New Features in @azure/storage-file-datalake@12.4.0-beta.1 ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-file-datalake/CHANGELOG.md#1240-beta1-2021-02-09))

- Added support for Container Soft Delete. You can restore a deleted filesystem via `DataLakeServiceClient.undeleteFileSystem()`. And the `DataLakeServiceClient.listFileSystems()` now support an `includeDeleted` option to include soft deleted filesystems in the response.

#### storage-file-share [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-file-share/CHANGELOG.md#1241-2021-02-03)

##### @azure/storage-file-share@12.4.1

This release contains bug fixes to improve quality.

#### storage-queue [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-queue/CHANGELOG.md#1231-2021-02-03)

##### @azure/storage-queue@12.3.1

This release contains bug fixes to improve quality.

### Azure Event Grid

We released a new beta package for the Event Grid service.

#### @azure/eventgrid [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/eventgrid/eventgrid/CHANGELOG.md#300-beta3-2020-10-06)

##### Breaking changes in @azure/eventgrid@3.0.0-beta.3

- The type definitions for SMS events sent by Azure Communication Services have been renamed, to use the prefix "AcsSms" instead of "Acssms". If you are using TypeScript and explicitly referencing these interfaces, you will need to update your code to use the new names. The payload of the events is unchanged.
- `EventGridSharedAccessCredential` has been removed, in favor of `AzureSASCredential`. Code which is using `EventGridSharedAccessCredential` should now use `AzureSASCredential` instead.
- When constructing the client, you must now include the schema type your topic is configured to expect (one of "EventGrid", "CloudEvent" or "Custom").
- The `sendEvents` methods have been collapsed into a single method on the client called `send` which uses the input schema that was configured on the client.

##### New Features in @azure/eventgrid@3.0.0-beta.3

- Added distributed tracing support. `EventGridProducerClient` will now create spans when sending events to Event Grid.

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
