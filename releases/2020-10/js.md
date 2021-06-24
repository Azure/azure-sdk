---
title: Azure SDK for JavaScript (October 2020)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the October 2020 client library release.

#### Beta releases

- Azure Identity.
- Azure Metrics Advisor.
- Azure Tables.
- Azure Service Bus.
- Azure Search.
- Azure Storage File Share.
- Azure Storage Data Lake.
- Azure Storage Blob.

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/identity@next
$> npm install @azure/ai-metrics-advisor@next
$> npm install @azure/data-tables@next
$> npm install @azure/service-bus@next
$> npm install @azure/search@next
$> npm install @azure/storage-blob-changefeed@next
$> npm install @azure/storage-queue@next
$> npm install @azure/storage-file-share@next
$> npm install @azure/storage-datalake@next
$> npm install @azure/storage-blob@next

```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

### Azure Identity

#### @azure/identity  [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/identity/identity/CHANGELOG.md)

Our authentication library is being released with some minor changes and fixes to the existing authentication methods.

##### New Features on @azure/identity@1.2.0-beta.2

- `DefaultAzureCredential` now by default shows the Device Code message on the console. This can still be overwritten with a custom behavior by specifying a function as the third parameter, `userPromptCallback`.
- Added Active Directory Federation Services authority host support to the node credentials.

##### Major Fixes on @azure/identity@1.2.0-beta.2

- Added support for multiple clouds on `VisualStudioCodeCredential`.


### Azure Metrics Advisor

#### @azure/ai-metrics-advisor [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/metricsadvisor/ai-metrics-advisor/CHANGELOG.md#100-beta1-2020-10-07)

We're happy to announce an initial preview of a client library that supports the newly announced preview of the Azure Metrics Advisor service. This library has been designed based on the [Azure SDK Design Guidelines for TypeScript]({{ site.baseurl }}{% link docs/typescript/introduction.md %}) to ensure consistency, idiomatic design, and excellent developer experience and productivity.

##### Features on @azure/ai-metrics-advisor@1.0.0-beta.1

- It supports all services APIs, including but not limited to:
  - The management of data feeds.
  - Configuring anomaly detection and alerting configurations.
  - Querying anomaly detection results, for example, incidents, anomalies, alerts, enriched series data, etc.
  - Diagnosing incident root causes.


### Azure Service Bus

#### @azure/service-bus@7.0.0-preview.7 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/servicebus/service-bus/CHANGELOG.md)

We're releasing a new preview of our Azure Service Bus library. This includes updates to the message locks and the support of browser authentication through AAD credentials.

##### New Features on @azure/service-bus@7.0.0-preview.7

- Message locks can be auto-renewed in all receive methods (`receiver.receiveMessages`, `receiver.subcribe`
  and `receiver.getMessageIterator`). This can be configured in options when calling `ServiceBusClient.createReceiver()`.
- `ServiceBusClient` now supports authentication with AAD credentials in the browser (you can use `InteractiveBrowserCredential` from `@azure/identity`).


### Azure Tables

#### @azure/data-tables [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/tables/data-tables/CHANGELOG.md)

We're releasing a new preview of our Azure Tables library. This update adds support for batch operations.

##### New Features on @azure/data-tables@1.0.0-beta.2

- Implemented support for batch operations. This allows sending multiple create, delete and update operations in a single atomic transaction.


### Azure Search

#### @azure/search [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/search/search-documents/CHANGELOG.md#1110-beta1-2020-10-05)

We're releasing a new preview of our Azure Search library. This update adds support for batch operations.

##### New Features on @azure/search@11.1.0-beta.1

- Azure Search SDK now supports batching. The document actions (`upload`, `merge`, `mergeupload`, `delete`) could be done in batch format with autoFlush set to true or false.
- Azure Search SDK has been regenerated using the latest swaggers. This enables new properties for IndexParameters.


### Azure Storage

Updated Azure Storage Service API version to 2020-02-10.

#### @azure/storage-blob [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-blob/CHANGELOG.md)

##### New Features on @azure/storage-blob@12.3.0-beta.1

- Added support for Container Soft Delete. Added a new API `BlobServiceClient.undeleteContainer()` to restore a previously deleted blob container.

#### @azure/storage-file-datalake [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-file-datalake/CHANGELOG.md)

##### New Features on @azure/storage-file-datalake@12.2.0-beta.1

- Added support for directory SAS and delegation SAS v2. Now supports generate SAS on directory level. Also added support for `saoid`, `suoid` and `scid` for delegation SAS. See the user delegation SAS [document](https://docs.microsoft.com/en-us/rest/api/storageservices/create-user-delegation-sas#specify-a-signed-object-id-for-a-security-principal-preview) for more details.
- Added support for File Set Expiry. Now can call `DataLakeFileClient.setExpiry()` to schedule the deletion of a file.
- Added `DataLakePathClient.setAccessControlRecursive()` to support setting access control recursively.

#### storage-file-share [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-file-share/CHANGELOG.md)

##### New Features on @azure/storage-file-share@12.3.0-beta.1

- Added support for Share and Share Snapshot Leases. Now can initialize a `ShareLeaseClient` with a `ShareClient` to manage leases for a share or share snapshot. Most operations on share now also support lease conditions.
- Added support for Get File Range Diff. Added `ShareFileClient.getRangeListDiff()` for getting the list of ranges that differ between a previous share snapshot and the file.
- Added support for Set Share Tier. Added `ShareClient.setAccessTier()` for setting the access tier of the share.


## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
