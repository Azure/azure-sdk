---
title: Azure SDK for JavaScript (December 2020)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the December 2020 client library release.

#### Beta

- Azure Synapse Access Control
- Azure Synapse Artifacts
- Azure Synapse Spark
- Azure Synapse Managed Private Endpoints
- Azure Synapse Monitoring
- Azure Storage Blob
- Azure Storage File Shares
- Azure Storage Files Data Lake
- Azure Storage Queues

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/synapse-access-control@next
$> npm install @azure/synapse-artifacts@next
$> npm install @azure/synapse-spark@next
$> npm install @azure/synapse-managed-private-endpoints@next
$> npm install @azure/synapse-monitoring@next
$> npm install @azure/storage-blob@next
$> npm install @azure/storage-file-share@next
$> npm install @azure/storage-file-datalake@next
$> npm install @azure/storage-queue@next
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Release highlights

### Synapse

This is the first release of the Synapse packages to support the new [Azure Synapse Analytics service](https://azure.microsoft.com/en-us/services/synapse-analytics/).

The packages released under the Synapse name are as follow:

- Azure Synapse Access Control: [@azure/synapse-access-control](https://www.npmjs.com/package/@azure/synapse-access-control/v/1.0.0-beta.1)
- Azure Synapse Artifacts: [@azure/synapse-artifacts](https://www.npmjs.com/package/@azure/synapse-artifacts/v/1.0.0-beta.1)
- Azure Synapse Spark: [@azure/synapse-spark](https://www.npmjs.com/package/@azure/synapse-spark/v/1.0.0-beta.1)
- Azure Synapse Managed Private Endpoints: [@azure/synapse-managed-private-endpoints](https://www.npmjs.com/package/@azure/synapse-managed-private-endpoints/v/1.0.0-beta.1)
- Azure Synapse Monitoring: [@azure/synapse-monitoring](https://www.npmjs.com/package/@azure/synapse-monitoring/v/1.0.0-beta.1)

### Azure Storage

#### @azure/storage-blob [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-blob/CHANGELOG.md)

We are releasing to add support for new service features in Azure Storage Service API version 2020-04-08.

##### New Features on @azure/storage-blob@12.4.0-beta.1

- Added a new interface `BlockBlobClient.syncUploadFromURL()` to support creating a new Block Blob where the contents of the blob are read from a given URL.
- `BlobClient.setTags()` and `BlobClient.getTags()` now support the `LeaseAccessConditions` and `BlobServiceClient.findBlobsByTags()` will return all matching tags for each blob.
- Added `generateSasUrl` to `BlobClient` and `ContainerClient` to generate a service-level SAS URI for the client.
- Added `generateAccountSasUrl` to `BlobServiceClient` to generate an account-level SAS URI for the client.

#### @azure/storage-file-datalake [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-file-datalake/CHANGELOG.md)

##### New Features on @azure/storage-blob@12.3.0-beta.1

- Added `generateSasUrl` to `DataLakeFileSystemClient`, `DataLakeDirectoryClient` and `DataLakeFileClient` to generate a service-level SAS URI for the client.
- Added `generateAccountSasUrl` to `DataLakeServiceClient` to generate an account-level SAS URI for the client.

#### @azure/storage-file-share [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-file-share/CHANGELOG.md)

##### New Features on @azure/storage-file-share@12.4.0-beta.1

- Share now supports for NFS. User can specify the `protocols` when creating a Share via `ShareClient.create()`. Also added an `rootSquash` option for NFS shares.
- Added `generateSasUrl` to `ShareClient` and `ShareFileClient` to generate a service-level SAS URI for the client.
- Added `generateAccountSasUrl` to `ShareServiceClient` to generate an account-level SAS URI for the client.

#### storage-queue [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-queue/CHANGELOG.md)

##### New Features on @azure/storage-queue@12.3.0-beta.1
- Added `generateSasUrl` to `QueueClient` to generate a service-level SAS URI for the client.
- Added `generateAccountSasUrl` to `QueueServiceClient` to generate an account-level SAS URI for the client.

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
