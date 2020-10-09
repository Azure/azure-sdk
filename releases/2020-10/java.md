---
title: Azure SDK for Java (October 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our October 2020 client library releases.

#### GA

- _Add packages_

#### Updates

- _Add packages_

#### Beta

- Azure Storage

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.9.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-changefeed</artifactId>
  <version>12.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.3.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-share</artifactId>
  <version>12.7.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.7.0-beta.1</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### _Package name_

- Major changes only!

### Azure Storage Blob [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-blob/CHANGELOG.md)

#### New Features
- Added support to undelete a container.
- Added support to specify Arrow Output Serialization when querying a blob.
- Added support to set `BlobParallelUploadOptions.computeMd5` so the service can perform an md5 verification.
- Added support to specify block size when using `BlobInputStream`

#### Key Bug Fixes
- Fixed bug where users could not download more than 5000MB of data in one shot in the `downloadToFile` API.
- Fixed but where the TokenCredential scope would be incorrect for custom URLs.
- Fixed a bug where Default Azure Credential would not work with Azurite.
- Fixed a bug where a custom application ID in `HttpLogOptions` would not be added to the User Agent String.
- Fixed a bug where `BlockBlobOutputStream` would not handle certain errors.

### Azure Storage File DataLake [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-file-datalake/CHANGELOG.md)

#### New Features
- Added support for setting, modifying, and removing ACLs recursively.
- Added support to schedule file expiration.
- Added support to specify Arrow Output Serialization when querying a file.
- Added support to generate directory SAS and added support to specify additional user ids and correlation ids for user delegation SAS.
- Added support to upload data to a file from an InputStream.
- Added support to specify permissions and umask when uploading a file.

#### Key Bug Fixes
- Fixed a bug where users could not download more than 5000MB of data in one shot in the `readToFile` API.
- Fixed a bug where the TokenCredential scope would be incorrect for custom URLs.
- Fixed a bug where an empty string would be sent with the x-ms-properties header when metadata was null or empty.
- Fixed a bug where a custom application id in HttpLogOptions would not be added to the User Agent String.

### Azure Storage File Share [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-file-share/CHANGELOG.md)

#### New Features
- Added support for the 2020-02-10 service version.
- Added support to getFileRanges on a previous snapshot by adding the `getFileRangesDiff` API.
- Added support to set whether or not SMB multichannel is enabled.
- Added support to lease shares and snapshot shares.
- Added support to specify a lease id for share operations.

#### Key Bug Fixes
- Fixed a bug where getProperties on a file client would throw a HttpResponseException instead of ShareStorageException.
- Fixed a bug where snapshot would be appended to a share snapshot instead of sharesnapshot.
- Fixed a bug that would cause authentication failures when building a client by passing an endpoint which had a SAS token with protocol set to https,http
- Fixed a bug where a custom application ID in HttpLogOptions would not be added to the User Agent String.


## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
