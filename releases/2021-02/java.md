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
- Azure Security Key Vault Certificates
- Azure Security Key Vault Keys
- Azure Security Key Vault Secrets

#### Beta

- Azure Communication Common (1.0.0-beta.4)
- Azure Communication Identity (1.0.0-beta.4)
- Azure Communication Chat (1.0.0-beta.4)
- Azure Security Key Vault Administration
- Azure Security Key Vault Certificates
- Azure Security Key Vault Keys
- Azure Security Key Vault Secrets

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

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-tables</artifactId>
  <version>12.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-administration</artifactId>
  <version>4.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.1.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.3.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.2.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.3.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.2.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.3.0-beta.3</version>
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

### Azure Communication Administration will be deprecated

- Identity client is moved to new package Azure Communication Identity.
- Phone number administration will be moved into a new package Azure Communication Phone Numbers.

### Azure Communication Common 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-common_1.0.0-beta.4/sdk/communication/azure-communication-common/CHANGELOG.md#100-beta4-2021-02-09)

#### Breaking Changes

- Renamed `CommunicationUserCredential` to `CommunicationTokenCredential`.
- Replaced constructor `CommunicationTokenCredential(TokenRefresher tokenRefresher, String initialToken, boolean refreshProactively)` and `CommunicationTokenCredential(TokenRefresher tokenRefresher)` with `CommunicationTokenCredential(CommunicationTokenRefreshOptions tokenRefreshOptions)`.
- Renamed `PhoneNumber` to `PhoneNumberIdentifier`.
- Renamed `CommunicationUser` to `CommunicationUserIdentifier`.
- Renamed `CallingApplication` to `CallingApplicationIdentifier`.

#### New Features

- Added `MicrosoftTeamsUserIdentifier`

### Azure Communication Identity 1.0.0-beta.4 [ChangeLog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-identity_1.0.0-beta.4/sdk/communication/azure-communication-identity/CHANGELOG.md#100-beta4-2021-02-09)

#### Breaking Changes

- `pstn` token scope is removed.
- `revokeTokens` now revoke all the currently issued tokens instead of revoking tokens issued prior to a given time.
- `issueToken` returns an instance of `core.credential.AccessToken` instead of `CommunicationUserToken`.

#### New Features

- Added CommunicationIdentityClient and CommunicationIdentityAsyncClient (originally was part of the azure-communication-aministration package).
- Added support for Azure Active Directory Authentication.
- Added ability to create a user and issue token for it at the same time.

### Azure Communication Chat 1.0.0-beta.4 [ChangeLog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-chat_1.0.0-beta.4/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta4-2021-02-09)

#### Breaking Changes

- Updated to azure-communication-common version 1.0.0-beta.4. Now uses `CommunicationUserIdentifier` and `CommunicationIdentifier` in place of `CommunicationUser`, and `CommunicationTokenCredential` instead of `CommunicationUserCredential`.
- Removed `Priority` field from `ChatMessage`.

#### New Features

- Added support for `CreateChatThreadResult` and `AddChatParticipantsResult` to handle partial errors in batch calls.
- Added pagination support for `listReadReceipts` and `listParticipants`.
- Added new model for messages and content types: `Text`, `Html`, `ParticipantAdded`, `ParticipantRemoved`, `TopicUpdated`.
- Added new model for errors (`CommunicationError`).
- Added notifications for 'ChatThread' level changes.

### Azure Security Key Vault Keys 4.3.0-beta.4 [ChangeLog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#430-beta4-2021-02-11)

#### Key Bug Fixes

- Fixed issue where cryptographic operations would be attempted locally for symmetric keys that were missing their key material ('k' component). 

### Azure Security Key Vault Keys 4.2.5 [ChangeLog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#425-2021-02-11)

#### Key Bug Fixes

- Fixed issue where cryptographic operations would be attempted locally for symmetric keys that were missing their key material ('k' component).

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
