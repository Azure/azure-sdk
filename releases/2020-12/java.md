---
title: Azure SDK for Java (December 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our December 2020 client library releases.

#### GA

- Management Library - CDN
- Management Library - Container Instance
- Management Library - Container Registry
- Management Library - Event Hubs
- Management Library - Private DNS
- Management Library - Redis
- Management Library - Service Bus
- Management Library - Spring Cloud
- Management Library - SQL
- Management Library - Traffic Manager

#### Updates

- Management Library - App Services
- Management Library - Resources

#### Beta

- Storage Library - Blobs
- Storage Library - Blob Batch
- Storage Library - Blob Cryptography
- Storage Library - File Datalake
- Storage Library - File Share
- Storage Library - Queue
- Synapse Library - Spark
- Synapse Library - Access Control
- Synapse Library - Artifacts

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-cdn</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerinstance</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerregistry</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-eventhubs</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-privatedns</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-redis</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-servicebus</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-appplatform</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-sql</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-trafficmanager</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-appservice</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-resources</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.10.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-batch</artifactId>
  <version>12.8.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-cryptography</artifactId>
  <version>12..10.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-common</artifactId>
  <version>12.10.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.4.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-share</artifactId>
  <version>12.8.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.8.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-internal-avro</artifactId>
  <version>12.0.2-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-synapse-spark</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-synapse-accesscontrol</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-synapse-artifacts</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>
```

For resource management libraries, we also provide a wrapper package that contains all available services
```xml
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager</artifactId>
  <version>2.1.0</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights

### Management Libraries

We are excited to announce the GA releases of management libraries that follow the [Azure SDK Design Guidelines for Java](https://azure.github.io/azure-sdk/java/guidelines/). In addition, more management libraries are now in Public Preview to provide better Azure service coverage. These new libraries provide a higher-level, object-oriented API for managing Azure resources, that is optimized for ease of use, succinctness and consistency. You can find the list of new packages [on this page](https://azure.github.io/azure-sdk/releases/latest/java.html). Detailed documentation and code samples for these new libraries can be [found here](http://aka.ms/azsdk/java/mgmt)

These new packages share the same groupId ``com.azures.resourcemanager`` and artifactId share the same prefix of ``azure-resourcemanager``
  
### Azure Storage Blob 12.10.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-blob/CHANGELOG.md#12100-beta1-2020-12-07)
#### New Features
- Exposed ClientOptions on all client builders, allowing users to set a custom application id and custom headers.
- Added ability to get container client from blob clients and service client from container clients
- Added a MetadataValidationPolicy to check for leading and trailing whitespace in metadata that would cause Auth failures.
- Added support for the 2020-04-08 service version. 
- Added support to upload block blob from URL.
- Added lease ID parameter to Get and Set Blob Tags.
- Added blob tags to BlobServiceClient.findBlobsByTags() result.

#### Bug Fixes
- Fixed a bug where the error message would not be displayed the exception message of a HEAD request.

### Azure Storage File Datalake 12.4.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-file-datalake/CHANGELOG.md#1240-beta1-2020-12-07)
#### New Features
- Added support to list paths on a directory.
- Exposed ClientOptions on all client builders, allowing users to set a custom application id and custom headers.
- Added a MetadataValidationPolicy to check for leading and trailing whitespace in metadata that would cause Auth failures.

#### Bug Fixes
- Fixed a bug where the error message would not be displayed the exception message of a HEAD request.

### Azure Storage File Share 12.8.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-file-share/CHANGELOG.md#1280-beta1-2020-12-07)
#### New Features
- Exposed ClientOptions on all client builders, allowing users to set a custom application id and custom headers.
- Added a MetadataValidationPolicy to check for leading and trailing whitespace in metadata that would cause Auth failures.
- Added support for the 2020-04-08 service version. 
- Added support for specifying enabled protocols on share creation
- Added support for setting root squash on share creation and through set properties.

#### Bug Fixes
- Fixed a bug where snapshot would be appended to a share snapshot instead of sharesnapshot.
- Fixed a bug where the sharesnapshot query parameter would be ignored in share and share file client builders.
- Fixed a bug where the error message would not be displayed the exception message of a HEAD request.

### Synapse

#### Spark [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/synapse/azure-analytics-synapse-spark/CHANGELOG.md)

- Initial Release.

#### Access Control [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/synapse/azure-analytics-synapse-accesscontrol/CHANGELOG.md)

- Initial Release.

#### Artifacts [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/synapse/azure-analytics-synapse-artifacts/CHANGELOG.md)

- Initial release.

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
