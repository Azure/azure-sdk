---
title: Azure SDK for JavaScript (January 2021)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the January 2021 client library release.

#### Updates

- Azure Storage Queue
- Azure Storage Blob
- Azure Storage Data Lake
- Azure Storage File Share
- Azure Service Bus

#### Beta

- Azure Data Tables
- Azure Attestation

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/storage-blob
$> npm install @azure/storage-file-datalake
$> npm install @azure/storage-file-share
$> npm install @azure/storage-queue
$> npm install @azure/data-tables@next
$> npm install @azure/attestation@next
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Release highlights

### Azure Storage

#### @azure/storage-blob [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-blob/CHANGELOG.md)

We are releasing to add support for new service features in Azure Storage Service API version 2020-04-08.

##### New Features on @azure/storage-blob@12.4.0

- Added a new `from(permissionLike)` function to `AccountSASPermissions`, `BlobSASPermissions` and `ContainerSASPermissions` for creating such permissions from raw permission-like objects. Addressed issue [9714](https://github.com/Azure/azure-sdk-for-js/issues/9714).

#### @azure/storage-file-datalake [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-file-datalake/CHANGELOG.md)

##### Major Fixes on @azure/storage-file-datalake@12.3.0

- `DataLakePathClient.move()` now supports source and destination authenticated with SAS. Fixed bug [12758](https://github.com/Azure/azure-sdk-for-js/issues/12758).
- Now you can get the functionality of the root directory via the `DataLakeDirectoryClient` created via `FileSystemClient.getDirectoryClient("")`. Fixed bug [12813](https://github.com/Azure/azure-sdk-for-js/issues/12813).

#### storage-file-share [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-file-share/CHANGELOG.md)

This release contains bug fixes to improve quality.

#### storage-queue [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-queue/CHANGELOG.md)

This release contains bug fixes to improve quality.

### Azure Service Bus

#### @azure/service-bus [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/servicebus/service-bus/CHANGELOG.md)

We're releasing a patch of the Service Bus client that includes some bug fixes.

##### Major Fixes on @azure/service-bus 7.0.1 and 7.0.2

- Improved reliability of the `receiveMessages()` method on the receiver when dealing with large number of messages or slow network connectivity.
- Resolved the issue of hanging receivers when receiving more than 2048 messages from sessions in `receiveAndDelete` mode.
- Fix the use of correlation rule filter when a subset of properties are set.

### Azure Tables

#### @azure/data-tables [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/tables/data-tables/CHANGELOG.md)

We're releasing a new beta for our Azure Data Tables client that improves the precision of the dates being used in the package, and enables this client to communicate with the Azure Storage Emulator.

##### Breaking Changes on @azure/data-tables@1.0.0-beta.4

- Disabled `Edm.DateTime` deserialization into a JavaScript Date to avoid losing precision [#12650](https://github.com/Azure/azure-sdk-for-js/pull/12650).

##### Major Fixes on @azure/data-tables@1.0.0-beta.4

- Fixed an issue that prevented the use of the SDK against the Azure Storage Emulator and `Azurite@3.9.0-table-alpha.1`
 [#13165](https://github.com/Azure/azure-sdk-for-js/pull/13165).

### Azure Attestation

#### @azure/attestation [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/attestation/attestation/CHANGELOG.md)

We're introducing our JavaScript and TypeScript client for Microsoft Azure Attestation through an initial beta release.

This beta client provides the following functionality for the Microsoft Azure Attestation Service:

- Microsoft Azure Attestation Enclave Attestation.
- Attestation Policy Management APIs.
- Attestation Policy Management Certificate Management APIs.

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
