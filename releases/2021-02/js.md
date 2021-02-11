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
- Azure Key Vault Secrets
- Azure Key Vault Certificates
- Azure Key Vault Admin
- Azure Storage Blob
- Azure File Datalake
- Azure Event Grid

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
$> npm install @azure/keyvault-secrets@next
$> npm install @azure/keyvault-certificates@next
$> npm install @azure/keyvault-admin@next
$> npm install @azure/storage-blob@next
$> npm install @azure/storage-file-datalake@next
$> npm install @azure/eventgrid@next
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Release highlights

### Event Hubs

We're releasing a new GA for the Azure Event Hubs client with new features and a major fix.

#### @azure/event-hubs [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/eventhub/event-hubs/CHANGELOG.md)

##### New Features in @azure/event-hubs@5.4.0

- You can now specify custom endpoint address as a client constructor option to use when communicating with the Event Hubs service, which is useful when your network does not allow communicating to the standard Event Hubs endpoint.
- Added a helper method `parseEventHubConnectionString` that can be used to validate and parse a given connection string for Azure Event Hubs.

##### Major Fixes in @azure/event-hubs@5.4.0

- Fixes an issue where the `RetryMode` enum for use when setting the RetryOptions.mode field in `EventHubConsumerClientOptions` or `EventHubClientOptions` wasn't exported by the package.

### Azure Identity

Identity is releasing a patch with a dependency fix and a bug fix, and a beta that includes MSAL 2.0 with PKCE support.

#### @azure/identity [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/identity/identity/CHANGELOG.md)

##### Major Fixes in @azure/identity@1.2.3

- Fixed Azure Stack support for the NodeJS version of the `InteractiveBrowserCredential`.
- The 'keytar' dependency has been updated to the latest version.

##### Changes in @azure/identity@1.2.4-beta.1

- In this beta we've updated `InteractiveBrowserCredential` to use the Auth Code Flow with PKCE rather than Implicit Grant Flow by default in the browser, to better support browsers with enhanced security restrictions.

### Azure Text Analytics

We're releasing a new beta for the Text Analytics service including new features and some renamed properties and methods.

#### @azure/ai-text-analytics [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/textanalytics/ai-text-analytics/CHANGELOG.md)

##### New Features in @azure/ai-text-analytics@5.1.0-beta.4

- A new option to control how the offset is calculated by the service, `stringIndexType`, is added to `analyzeSentiment`, `recognizeEntities`, `recognizePiiEntities`, and `beginAnalyzeHealthcareEntities`. Furthermore, `stringIndexType` is added to task types `RecognizeEntitiesAction` and `RecognizePiiEntitiesAction`, which are the types of input actions to the `beginAnalyzeBatchActions` method. For more information, see [the Text Analytics documentation](https://docs.microsoft.com/azure/cognitive-services/text-analytics/concepts/text-offsets#offsets-in-api-version-31-preview).
- The poller for the `beginAnalyzeBatchActions` long-running operation gained the ability to return certain metadata information about the currently running operation (e.g., when the operation was created, will be expired, and last time it was updated, and also how many actions completed and failed so far). Also, the poller for `beginAnalyzeHealthcareEntities` gained a similar ability.

##### Breaking Changes on @azure/ai-text-analytics@5.1.0-beta.4

- `beginAnalyzeHealthcare` is renamed to `beginAnalyzeHealthcareEntities`.
- `beginAnalyze` is renamed to `beginAnalyzeBatchActions`.
- The healthcare entities returned by `beginAnalyzeHealthcare` are now organized as a directed graph where the edges represent a certain type of healthcare relationship between the source and target entities. Edges are stored in the `relatedEntities` property.
- The `links` property of `HealthcareEntity` is renamed to `dataSources`, a list of objects representing medical databases, where each object has `name` and `entityId` properties.
- the words "operation" and "action" are used consistently in our names and documentation instead of "job" and "task" respectively.

### Azure Form Recognizer

We're releasing a new beta client for the Azure Form Recognizer service with an upgrade for one TypeScript type.

#### @azure/ai-form-recognizer [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/formrecognizer/ai-form-recognizer/CHANGELOG.md)

##### Breaking Changes in @azure/ai-form-recognizer@3.1.0-beta.2

- Reworked the type of the `appearance` field and its children of the `FormLine` type to have more specific names.

### Azure Storage

We released hot fix versions and also beta versions for new service features in Azure Storage Service API version 2020-06-10.

#### @azure/storage-blob [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-blob/CHANGELOG.md)

##### Major Fixes in @azure/storage-blob@12.4.1

- Fixed a compile failure due to "Can't resolve 'crypto'" in Angular. [Issue #13267](https://github.com/Azure/azure-sdk-for-js/issues/13267).
- Fixed an issue that the download stream returned by `BlobClient.download` won't release underlying resources unless it's fully consumed. [Isssue #11850](https://github.com/Azure/azure-sdk-for-js/issues/11850).

##### New Features in @azure/storage-blob@12.5.0-beta.1

- Now support Batch operations scoped to the Container level. You can use `ContainerClient.getBlobBatchClient()` to get such a `BlobBatchClient`.

#### @azure/storage-file-datalake [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-file-datalake/CHANGELOG.md)

##### Major Fixes in @azure/storage-file-datalake@12.3.1

- Fixed a compile failure due to "Can't resolve 'crypto'" in Angular. [Issue #13267](https://github.com/Azure/azure-sdk-for-js/issues/13267).

##### New Features in @azure/storage-file-datalake@12.4.0-beta.1

- Added support for Container Soft Delete. You can restore a deleted filesystem via `DataLakeServiceClient.undeleteFileSystem()`. And the `DataLakeServiceClient.listFileSystems()` now support an `includeDeleted` option to include soft deleted filesystems in the response.

#### storage-file-share [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-file-share/CHANGELOG.md)

##### @azure/storage-file-share@12.4.1

This release contains bug fixes to improve quality.

#### storage-queue [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-queue/CHANGELOG.md)

##### @azure/storage-queue@12.3.1

This release contains bug fixes to improve quality.

### Azure Event Grid

We released a new beta package for the Event Grid service.

#### @azure/eventgrid [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/eventgrid/eventgrid/CHANGELOG.md)

##### Breaking changes in @azure/eventgrid@3.0.0-beta.3

- The type definitions for SMS events sent by Azure Communication Services have been renamed, to use the prefix "AcsSms" instead of "Acssms". If you are using TypeScript and explicitly referencing these interfaces, you will need to update your code to use the new names. The payload of the events is unchanged.
- `EventGridSharedAccessCredential` has been removed, in favor of `AzureSASCredential`. Code which is using `EventGridSharedAccessCredential` should now use `AzureSASCredential` instead.
- When constructing the client, you must now include the schema type your topic is configured to expect (one of "EventGrid", "CloudEvent" or "Custom").
- The `sendEvents` methods have been collapsed into a single method on the client called `send` which uses the input schema that was configured on the client.

##### New Features in @azure/eventgrid@3.0.0-beta.3

- Added distributed tracing support. EventGridProducerClient will now create spans when sending events to Event Grid.

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
