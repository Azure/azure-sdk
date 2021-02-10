---
title: Azure SDK for Java (February 2021)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our February 2021 client library releases.

#### GA

- Azure Core AMQP
- Azure Event Hubs

#### Updates

- Azure Event Hubs Checkpoint Store for Storage Blob

#### Beta

- Azure Communication Common (1.0.0-beta.4)
- Azure Communication Identity (1.0.0-beta.4)
- Azure Communication Chat (1.0.0-beta.4)

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<!-- Insert dependencies -->
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-amqp</artifactId>
  <version>2.0.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs</artifactId>
  <version>5.5.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs-checkpointstore-blob</artifactId>
  <version>1.5.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-common</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-identity</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-chat</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights

### Azure Core Amqp 2.0.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-amqp/CHANGELOG.md#202-2021-02-05)

#### New Features

- Add support for connecting to an alternative hostname for the AMQP message broker.

### Azure Messaging Event Hubs 5.5.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/eventhubs/azure-messaging-eventhubs/CHANGELOG.md#550-2020-02-15)

#### New Features

- Expose BinaryData in EventData.
- Expose EventHubClientBuilder.customEndpointAddress to connect to an alternative endpoint.

### Azure Messaging Event Hubs Checkpoint Store Blob 1.5.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/eventhubs/azure-messaging-eventhubs-checkpointstore-blob/CHANGELOG.md#150-2020-02-15)

- Updates dependencies for azure-core-amqp and azure-storage-blob.

### Azure Communication Common  1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-common/CHANGELOG.md#100-beta4-2021-02-09)

#### New Features

- Added support for Microsoft Teams User identifier.

### Azure Communication Identity (1.0.0-beta.4) [ChangeLog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-identity/CHANGELOG.md#100-beta4-2021-02-09)

#### New Features

- Split Identity client into synchronous client and asynchronous client.
- Added support for Azure Active Directory Authentication.

### Azure Communication Chat (1.0.0-beta.4) [ChangeLog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta4-2021-02-09)

#### New Features

- Added pagination support for listReadReceipts and listParticipants.
- Added notifications for chat thread level changes.
- Added support for html content in chat messages.

### Azure Communication Administration is deprecated

- Identity clients are moved to new package Azure Communication Identity.
- Phone number adminstration will be moved into a new package Azure Communication Phone Numbers.

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
