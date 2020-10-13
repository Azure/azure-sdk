---
title: Azure SDK for JavaScript (October 2020)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the October 2020 client library release.

#### GA

- _REMEMBER TO ADD YOUR GA PACKAGES_

#### Updates

- _REMEMBER TO ADD YOUR UPDATE PACKAGES_

#### Beta

- Azure Identity.
- Azure Metrics Advisor.
- Azure Tables.
- Azure Service Bus.
- Azure Search.
- Azure Text Analytics.
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
$> npm install @azure/ai-text-analytics@next
$> npm install @azure/storage-blob-changefeed@next
$> npm install @azure/storage-queue@next
$> npm install @azure/storage-file-share@next
$> npm install @azure/storage-datalake@next
$> npm install @azure/storage-blob@next

```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

---

=== COPY THIS AND ADD THE INFORMATION OF YOUR PACKAGE: ===

Keep in mind that:

- Including the package name in the headers makes the URL links work for multiple packages.
- The format of this file will be cleaned up once all of your proposals are in.

---

### _Package name_

#### _Package name_ [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/<service-folder>/<package-folder>/CHANGELOG.md)

(leave blank)

##### Breaking Changes on _Package name_

- _Add one or more, or remove the "Breaking Changes on ..." entire section._

##### New Features on _Package name_

- _Add one or more, or remove the "New Features on ..." section._

##### Major Fixes on _Package name_

- _Add one or more, or remove the "Major Fixes on ..." section._

---

### Azure Identity

#### @azure/identity  [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/identity/identity/CHANGELOG.md)

Our authentication library is being released with some minor changes and fixes to the existing authentication methods.

##### New Features on @azure/identity@1.2.0-beta.2

- `DefaultAzureCredential` now by default shows the Device Code message on the console. This can still be overwritten with a custom behavior by specifying a function as the third parameter, `userPromptCallback`.
- Added Active Directory Federation Services authority host support to the node credentials.

##### Major Fixes on @azure/identity@1.2.0-beta.2

- Added support for multiple clouds on `VisualStudioCodeCredential`. Fixes customer issue [11452](https://github.com/Azure/azure-sdk-for-js/issues/11452).
- `ManagedIdentityCredential` has been aligned with other languages, now treating expected errors properly. This fixes customer issue [11451](https://github.com/Azure/azure-sdk-for-js/issues/11451)

### Azure Metrics Advisor

#### @azure/ai-metrics-advisor [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/metricsadvisor/ai-metrics-advisor/CHANGELOG.md)

(leave blank)

- This is the inital preview of client library that supports the newly announced preview of the Azure Metrics Advisor service.
- This library has been designed based on the [Azure SDK Design Guidelines for TypeScript]({{ site.baseurl }}{% link docs/typescript/introduction.md %}) to ensure consistency, idiomatic design, and excellent developer experience and productivity.
- It supports all services APIs, including but not limited to
  - Manage data feeds.
  - Configure anomaly detection and alerting configurations.
  - Query anomaly detection results, for example, incidents, anomalies, alerts, enriched series data, etc.
  - Diagnose incident root causes.


### Azure Service Bus

#### @azure/service-bus@7.0.0-preview.7 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/servicebus/service-bus/CHANGELOG.md)

##### New Features on @azure/service-bus@7.0.0-preview.7

- Message locks can be auto-renewed in all receive methods (receiver.receiveMessages, receiver.subcribe
  and receiver.getMessageIterator). This can be configured in options when calling `ServiceBusClient.createReceiver()`.
  [PR 11658](https://github.com/Azure/azure-sdk-for-js/pull/11658)
- `ServiceBusClient` now supports authentication with AAD credentials in the browser(can use `InteractiveBrowserCredential` from `@azure/identity`).
  [PR 11250](https://github.com/Azure/azure-sdk-for-js/pull/11250)


### Azure Tables

#### @azure/data-tables [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/tables/data-tables/CHANGELOG.md)

##### New Features on @azure/data-tables@1.0.0-beta.2

- Implemented support for batch operations. This allows sending multiple create, delete and update operations in a single atomic transaction.


### Azure Search

TODO

### Azure Text Analytics.

TODO




### Azure Storage

Updated Azure Storage Service API version to 2020-02-10.

#### @azure/storage-blob [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-blob/CHANGELOG.md)

##### New Features on @azure/storage-blob@12.3.0-beta.1

- Added support for Container Soft Delete. Added a new API `BlobServiceClient.undeleteContainer()` to restore a previously deleted blob container.

#### @azure/storage-file-datalake [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-file-datalake/CHANGELOG.md)

##### New Features on @azure/storage-file-datalake@12.2.0-beta.1

- Added support for directory SAS and delegation SAS v2. Now supports generate SAS on directory level. Also added support for `saoid`, `suoid` and `scid` for delegation SAS. See the user delegation SAS [document](https://docs.microsoft.com/en-us/rest/api/storageservices/create-user-delegation-sas#specify-a-signed-object-id-for-a-security-principal-preview) for more details.
- Added support for File Set Expiry. Now can call `DataLakeFileClient.setExpiry()` to schedule the deletion of a file.
- Added `DataLakePathClient.setAccessControlRecursive()` to support setting access control recursively. 

#### storage-file-share [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-file-share/CHANGELOG.md)

##### New Features on @azure/storage-file-share@12.3.0-beta.1

- Added support for Share and Share Snapshot Leases. Now can initialize a `ShareLeaseClient` with a `ShareClient` to manage leases for a share or share snapshot. Most operations on share now also support lease conditions.
- Added support for Get File Range Diff. Added `ShareFileClient.getRangeListDiff()` for getting the list of ranges that differ between a previous share snapshot and the file.
- Added support for Set Share Tier. Added `ShareClient.setAccessTier()` for setting the access tier of the share.






## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
