---
title: Azure SDK for Java (November 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our November 2020 client library releases.

#### GA

- Storage

#### Updates

- _Add packages_

#### Beta

- Azure Communication Administration
- Azure Communication Chat
- Azure Communication Common
- Azure Communication SMS

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-administration</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-chat</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-common</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.9.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-batch</artifactId>
  <version>12.7.0</version>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-changefeed</artifactId>
  <version>12.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-cryptography</artifactId>
  <version>12.9.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-common</artifactId>
  <version>12.9.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-share</artifactId>
  <version>12.7.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.7.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-internal-avro</artifactId>
  <version>12.0.1</version>
</dependency>
  
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-sms</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights

### Azure Storage Blob [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-blob/CHANGELOG.md)

#### New Features
- GA all features from previous release.
- Added support for move and execute permissions on blob SAS and container SAS, and list permissions on blob SAS.
- Added support to specify a preauthorized user id and correlation id for user delegation SAS.
- Renamed `BlobDownloadToFileOptions.rangeGetContentMd5` to `BlobDownloadToFileOptions.retrieveContentRangeMd5`

#### Bug Fixes
- Fixed a bug where interspersed element types returned by page listing would deserialize incorrectly.
- Fixed a bug where BlobInputStream would not eTag lock on the blob, resulting in undesirable behavior if the blob was modified in the middle of reading.

### Azure Storage File Datalake [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-file-datalake/CHANGELOG.md)

#### New Features
- GA all features from previous release.
- Added support to specify whether or not a pipeline policy should be added per -call or per retry.
- Modified DataLakeAclChangeFailedException to extend AzureException

#### Bug Fixes

- Fixed a bug where the endpoint would be improperly converted if the account name contained the word dfs.

### Azure Storage File Share [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-file-share/CHANGELOG.md)

#### New Features
- GA all features from previous release.
- Added support to specify whether or not a pipeline policy should be added per call or per retry.
- Added support for setting access tier on a share through ShareClient.create, ShareClient.setAccessTier.
- Added support for getting access tier on a share through ShareClient.getProperties, ShareServiceClient.listShares
- Renamed setAccessTier to setProperties and deprecated setQuotaInGb in favor of setProperties.
Renamed DeleteSnapshotsOptionType to ShareSnapshotsDeleteOptionType in ShareClient.delete
Removed ability to create a ShareLeaseClient for a Share or Share Snapshot. This feature has been rescheduled for future release.

#### Bug Fixes
- Fixed a bug where interspersed element types returned by range diff listing would deserialize incorrectly.

### Azure Storage Queue [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-queue/CHANGELOG.md)

#### New Features
- Added support to specify whether or not a pipeline policy should be added per call or per retry.

#### Bug Fixes
- Fixed a bug that would cause a NPE when visibilityTimeout was set to null in QueueClient.updateMessage

### Azure Communication Administration [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-administration/CHANGELOG.md#100-beta3-2020-11-16)

#### New Features

- Support directly passing connection string to the CommunicationIdentityClientBuilder.
- Added support for sync and async long-running operations
    - beginCreateReservation
    - beginPurchaseReservation
    - beginReleasePhoneNumber

#### Breaking Changes

- Removed credential(CommunicationClientCredential credential) and replaced with 
accessKey(String accessKey) within CommunicationIdentityClientBuilder.
- `PhoneNumberSearch` renamed to `PhoneNumberReservation`.
- `SearchStatus` renamed to `ReservationStatus`.
- `CreateSearchOptions` reanamed to `CreateReservationOptions`.
- `CreateSearchResponse` renamed to `CreateReservationResponse`.

##### PhoneNumberReservation

- `searchId` renamed to `reservationId`.
- `getSearchId` renamed to `getReservationId`.
- `setSearchId` renamed to `setReservationId`.

##### Phone Number Clients

- `getSearchId`renamed to `getReservationId`
- `getSearchByIdWithResponse`renamed to `getReservationByIdWithResponse`.
- `createSearchWithResponse`renamed to `createReservationWithResponse`.
- `listAllSearches`renamed to `listAllReservations`.
- `cancelSearch`renamed to `cancelReservation`.
- `cancelSearchWithResponse`renamed to `cancelReservationWithResponse`.
- Replaced`createSearch`with to `beginCreateReservation` which returns a poller for the long-running operation.
- Replaced `purchaseSearch`renamed to `beginPurchaseReservation` which returns a poller for the long-running operation.
- Replaced `releasePhoneNumber`renamed to `beginReleasePhoneNumber` which returns a poller for the long-running operation.

### Azure Communication Chat [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta3-2020-11-16)

This release contains test improvements.

### Azure Communication Common [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-common/CHANGELOG.md#100-beta3-2020-11-16)

This release contains bug fixes to improve quality.

### Azure Communication SMS [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-sms/CHANGELOG.md#100-beta3-2020-11-16)

#### New Features

- Support directly passing connection string to the SmsClientBuilder using connectionString().

#### Breaking Changes

- Removed credential(CommunicationClientCredential credential) and replaced with accessKey(String accessKey) within CommunicationIdentityClientBuilder.
  
## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
