---
title: Azure SDK for JavaScript (February 2021)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the February 2021 client library release.

#### GA

- Azure Search Documents

#### Updates

- Azure Storage Blob
- Azure Storage Queue
- Azure File Datalake
- Azure File Share

#### Beta

- Azure AI Text Analytics
- Azure AI Metrics Advisor
- Azure AI Form Recognizer
- Azure Identity
- Azure Key Vault Keys
- Azure Key Vault Secrets
- Azure Key Vault Certificates
- Azure Key Vault Admin
- Azure Event Hubs
- Azure Synapse
- Azure Storage Blob
- Azure Event Grid

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/search-documents
$> npm install @azure/storage-blob
$> npm install @azure/storage-file-datalake
$> npm install @azure/storage-file-share
$> npm install @azure/storage-queue
$> npm install @azure/ai-text-analytics@next
$> npm install @azure/ai-metrics-advisor@next
$> npm install @azure/ai-form-recognizer@next
$> npm install @azure/identity@next
$> npm install @azure/keyvault-keys@next
$> npm install @azure/keyvault-secrets@next
$> npm install @azure/keyvault-certificates@next
$> npm install @azure/keyvault-admin@next
$> npm install @azure/event-hubs@next
$> npm install @azure/synapse@next
$> npm install @azure/storage-blob@next
$> npm install @azure/event-grid@next
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Release highlights

---

=== COPY THIS AND ADD THE INFORMATION OF YOUR PACKAGE: ===

Keep in mind that:

- Including the package name in the headers makes the URL links work for multiple packages.
- The format of this file will be cleaned up once all of your proposals are in.

---

### _Project name_ 

#### @azure/_package-name_ [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/<service-folder>/<package-folder>/CHANGELOG.md)

(leave blank)

##### Breaking Changes on @azure/_package-name_@_version_

- _Add one or more, or remove the "Breaking Changes on ..." entire section._

##### New Features on @azure/_package-name_@_version_

- _Add one or more, or remove the "New Features on ..." section._

##### Major Fixes on @azure/_package-name_@_version_

- _Add one or more, or remove the "Major Fixes on ..." section._

---

### Azure Identity

#### @azure/identity [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/identity/identity/CHANGELOG.md)

Identity is releasing a patch with a dependency fix and a bug fix, and a beta that includes MSAL 2.0 with PKCE support.

##### Major Fixes on @azure/identity@1.2.3

- Fixed Azure Stack support for the NodeJS version of the `InteractiveBrowserCredential`.
- The 'keytar' dependency has been updated to the latest version.

##### Breaking Changes on @azure/identity@1.2.4-beta.1

- In this beta we've updated `InteractiveBrowserCredential` to use the Auth Code Flow with PKCE rather than Implicit Grant Flow by default in the browser, to better support browsers with enhanced security restrictions.

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
