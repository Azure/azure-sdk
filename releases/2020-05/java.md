---
title: Azure SDK for Java (May 2020)
layout: post
date: 2020-05-01
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our {{ page.date | date: "%B %Y" }} client library releases.

#### Updates


#### Preview

- Form Recognizer
- Service Bus

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.1.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.0.1-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs</artifactId>
  <version>5.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs-checkpointstore-blob</artifactId>
  <version>1.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.0.6</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.1.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.0.2</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.1.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.1.2</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.2.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.1.2</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.2.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>1.0.0-beta.3</search>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-servicebus</artifactId>
  <version>7.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.6.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-batch</artifactId>
  <version>12.5.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-cryptography</artifactId>
  <version>12.6.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-share</artifactId>
  <version>12.4.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.5.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

### Event Hubs ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-messaging-eventhubs_5.1.0/sdk/eventhubs/azure-messaging-eventhubs/CHANGELOG.md))

Here are some of the highlights:

#### New Features

- Added support for sending a collection of events as a single batch from `EventHubProducerClient` and `EventHubProducerAsyncClient`.
- Added support for heartbeat for single process event function in Event Processor Client.
- Added support for receiving events in batches in Event Processor Client.

### Identity

#### 1.0.6 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-identity_1.0.6/sdk/identity/azure-identity/CHANGELOG.md#106-2020-05-05))

- Update azure-core dependency to version 1.5.0.
- Fix `MSIToken` expiry time parsing for Azure App Service platforms.

#### 1.1.0-beta.4 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-identity_1.1.0-beta.4/sdk/identity/azure-identity/CHANGELOG.md#110-beta4-2020-05-06))

- Added `IntelliJCredential` support in `DefaultAzureCredential`.
- Added `VsCodeCredential` support in `DefaultAzureCredential`.
- Added support to disable specific credentials in `DefaultAzureCredential` authentication flow.
- Added Shared Token cache support for MacOS Keychain, Gnome Keyring, and plain text for other Linux environments
- Added option to write to shared token cache from `InteractiveBrowserCredential`, `AuthorizationCodeCredential`, `UsernamePasswordCredential` and `DeviceCodeCredential`


### Service Bus ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/servicebus/azure-messaging-servicebus/CHANGELOG.md#700-beta2-2020-05-07))

Here are some of the highlights:
#### New Features 
- Allow receiving from first available single and multiple sessions through ServiceBusReceiverAsyncClient.
- Add send overload that accepts an Iterable of ServiceBusMessage.

### Search ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/search/azure-search-documents/CHANGELOG.md#100-beta3-2020-05-05))
Here are some of the highlights:
#### New Features 
- Changed Azure Search service version from `2019-05-06` to `2019-05-06-Preview`
- Added helper class `FieldBuilder` which converts a strongly-typed model class to `List<Field>`. 

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

{% assign packages = site.data.releases.latest.java-packages %}
{% include java-packages.html %}

{% include refs.md %}
