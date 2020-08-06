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
$> npm install @azure/service-bus
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Identity

#### [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/identity/identity/CHANGELOG.md)

##### New Features
- Extended DefaultAzureCredential with an experimental credential that uses the login credential from Azure CLI.
- Extended DefaultAzureCredential with an experimental credential that uses the login credential from VSCode's Azure Account extension.
- Add the ability to read AZURE_AUTHORITY_HOST from the environment.
- Made all the developer credentials public as well as the list of credentials used by DefaultAzureCredential.
- Make the keytar dependency optional, allowing for building and running on platforms not supported by keytar.

### Azure Event Hubs

#### [Azure Event Hubs Checkpoint Store's Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/eventhub/eventhubs-checkpointstore-blob/CHANGELOG.md)

##### Breaking Changes

[TODO]

##### New Features

[TODO]

##### Major Fixes

[TODO]

### Azure Form Recognizer

#### [Azure Form Recognizer's Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/formrecognizer/ai-form-recognizer/CHANGELOG.md)

##### Breaking Changes

[TODO]

##### New Features

[TODO]

##### Major Fixes

[TODO]

### Azure Key Vault

#### [Azure Key Vault Keys' Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/keyvault/keyvault-keys/CHANGELOG.md)

##### Breaking Changes

[TODO]

##### New Features

[TODO]

##### Major Fixes

[TODO]

#### [Azure Key Vault Secrets' Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/keyvault/keyvault-secrets/CHANGELOG.md)

##### Breaking Changes

[TODO]

##### New Features

[TODO]

##### Major Fixes

[TODO]

#### [Azure Key Vault Certificates' Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/keyvault/keyvault-certificates/CHANGELOG.md)

##### Breaking Changes

[TODO]

##### New Features

[TODO]

##### Major Fixes

[TODO]

### Azure Service Bus

#### [Azure Service Bus' Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/servicebus/service-bus/CHANGELOG.md)

##### Breaking Changes

[TODO]

##### New Features

[TODO]

##### Major Fixes

[TODO]

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
