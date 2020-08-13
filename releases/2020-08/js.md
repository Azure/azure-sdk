---
title: Azure SDK for JavaScript (August 2020)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the August 2020 client library release.

#### Updates

- Core libraries.
- Identity.
- Azure Event Hubs.
- Azure Form Recognizer.
- Azure Key Vault.

#### Preview

- Azure Service Bus.

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/identity
$> npm install @azure/eventhubs-checkpointstore-blob
$> npm install @azure/ai-form-recognizer
$> npm install @azure/keyvault-keys
$> npm install @azure/keyvault-secrets
$> npm install @azure/keyvault-certificates
$> npm install @azure/service-bus@next
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Identity

#### [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/identity/identity/CHANGELOG.md)

##### New Features
- With 1.1.0, new developer credentials are now available: `VisualStudioCodeCredential` and `AzureCliCredential`.
  - `VisualStudioCodeCredential` allows developers to log into Azure using the credentials available after logging in through the Azure Account extension in Visual Studio Code.
  - `AzureCliCredential` allows developers to log into Azure using the login credentials after an "az login" call.
- Both `VisualStudioCodeCredential` and `AzureCliCredential` may be used directly or indirectly as part of `DefaultAzureCredential`.
- Added the ability to configure the Managed Identity with a user-assigned client ID via a new option available in the `DefaultAzureCredential` constructor options: `managedIdentityClientId`.
- Made a list of known authorities is now available via a new top-level constant: `AzureAuthorityHosts`.
- Introduced the `CredentialUnavailable` error, which allows developers to differentiate between a credential not being available and an error happening during authentication.### Azure Event Hubs

### Event Hubs

#### [Azure Event Hubs Checkpoint Store's Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/eventhub/eventhubs-checkpointstore-blob/CHANGELOG.md)

##### Major Fixes

- Fixes issue [#10132](https://github.com/Azure/azure-sdk-for-js/issues/10132)
  where using an Azure Storage Account with soft-deletes or blob versioning enabled
  would cause `listCheckpoints` to suffer performance penalties proportional to the
  number of times `updateCheckpoint` was called.

### Azure Form Recognizer

#### Form Recognizer's [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/formrecognizer/ai-form-recognizer/CHANGELOG.md)

##### Breaking Changes

[TODO]

##### New Features

[TODO]

##### Major Fixes

[TODO]

### Azure Key Vault Keys, Secrets and Certificates

#### Changelogs

- [Key Vault Keys](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/keyvault/keyvault-keys/CHANGELOG.md).
- [Key Vault Secrets](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/keyvault/keyvault-secrets/CHANGELOG.md).
- [Key Vault Certificates](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/keyvault/keyvault-certificates/CHANGELOG.md).

##### New Features on Keys, Secrets and Certificates

- Added the optional `serviceVersion` property to the `CertificateClient`, `SecretClient`, `KeyClient` and `CryptographyClient` optional parameters to control the version of the Key Vault service being used by the clients.
    - It defaults to the latest supported API version, which currently is `7.1`.
    - Other supported service version at the moment is `7.0`.
- Added `recoverableDays` as an optional property to `KeyProperties`, `SecretProperties` and `CertificateProperties`, which denotes the number of days in which the key, secret or certificate can be recovered after deletion. This is only applicable for Azure Key Vaults with the soft-delete setting enabled.

##### New Features on Key Vault Keys

- Added `import` to the list of possible values for `KeyOperation`.

##### Major Fixes on Key Vault Keys

- Fixed [bug 10352](https://github.com/Azure/azure-sdk-for-js/issues/10352), which caused cryptography operations on RSA-HSM keys to fail.

### Azure Service Bus

#### Service Bus' [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/servicebus/service-bus/CHANGELOG.md)

##### Breaking Changes from Last Preview


- `receiveMode` parameter in the `createReceiver()`, `createSessionReceiver()` and `createDeadletterReceiver()` methods has been moved into the options bag with the default value `"peekLock"` mode.

  Example:

  - OLD: `createReceiver(<queue-name>, "peekLock")` and `createReceiver(<queue-name>, "receiveAndDelete")`
  - NEW: `createReceiver(<queue-name>)` and `createReceiver(<queue-name>, {receiveMode: "receiveAndDelete"})`

- Added Async iterable iterators with pagination support for all the listing methods like `getQueues()`, `getTopics()`, `getQueuesRuntimeInfo()`, etc. and renamed them to use the `list` verb.
  - Please refer to the examples in the `samples` folder - [listingEntities](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/servicebus/service-bus/samples/typescript/src/advanced/listingEntities.ts)
- `receiveMessages()`'s optional `maxWaitTimeInMs` parameter now controls how long to wait for the _first_ message, rather than how long to wait for an entire set of messages. This change allows for a faster return of messages to your application.
- `userProperties` attribute under the `ServiceBusMessage`(and `ReceivedMessage`, `ReceivedMessageWithLock`) has been renamed to `properties`. Same change has been made to the `userProperties` attribute in the correlation-rule filter.
- The terms `RuntimeInfo` and `Description` are replaced with `RuntimeProperties` and `Properties` to better align with guidelines around the kind of suffixes we use for naming methods and interfaces.

##### New Features

- User agent details can now be added to the outgoing requests by passing the user-agent prefixes to the `ServiceBusClient` and the `ServiceBusManagementClient` through options.
  Example user-agent string if the prefix `SampleApp` is provided to `ServiceBusManagementClient`:
  `SampleApp azsdk-js-azureservicebus/7.0.0-preview.5 core-http/1.1.5 Node/v12.16.0 OS/(x64-Windows_NT-10.0.18363)`
- Added `deadLetterErrorDescription` and `deadLetterReason` properties on the received messages. Previously, they were under the `properties` in the message.

  OLD: `message.properties["DeadLetterReason"]` and `message.properties["DeadLetterErrorDescription"]`
  NEW: `message.deadLetterReason` and `message.deadLetterErrorDescription`

- Added tracing support to the methods under `ServiceBusManagementClient`.

##### Bug Fixes

- Fixes [bug 9926](https://github.com/Azure/azure-sdk-for-js/issues/9926)
  where attempting to create AMQP links when the AMQP connection was in the
  process of closing resulted in a `TypeError` in an uncaught exception.


[TODO]

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
