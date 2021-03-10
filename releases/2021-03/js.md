---
title: Azure SDK for JavaScript (March 2021)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

<!--
@azure/identity:1.2.4-beta.1
@azure/abort-controller:1.0.3
@azure/abort-controller:1.0.4
@azure/keyvault-secrets:4.2.0-beta.3
@azure/keyvault-keys:4.2.0-beta.4

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to make available the March 2021 client library release.

#### GA

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Core - Abort Controller
- Core - Abort Controller

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Identity
- Key Vault - Secrets
- Key Vault - Keys

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/identity@1.2.4-beta.1
$> npm install @azure/abort-controller@1.0.3
$> npm install @azure/abort-controller@1.0.4
$> npm install @azure/keyvault-secrets@4.2.0-beta.3
$> npm install @azure/keyvault-keys@4.2.0-beta.4

```

[pattern]: # ($> npm install ${PackageName}@${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Release highlights
### Identity 1.2.4-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/identity_1.2.4-beta.1/sdk/identity/identity/CHANGELOG.md#124-beta1-2021-02-12)
- Breaking Change: Updated `InteractiveBrowserCredential` to use the Auth Code Flow with PKCE rather than Implicit Grant Flow by default in the browser, to better support browsers with enhanced security restrictions. A new file was added to provide more information about this credential [here](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/identity/identity/interactive-browser-credential.md).

### Core - Abort Controller 1.0.3 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/abort-controller_1.0.3/sdk/core/abort-controller/CHANGELOG.md#103-2021-02-23)
Support Typescript version < 3.6 by down-leveling the type definition files. ([PR 12793](https://github.com/Azure/azure-sdk-for-js/pull/12793))
### Core - Abort Controller 1.0.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/abort-controller_1.0.4/sdk/core/abort-controller/CHANGELOG.md#104-2021-03-04)
Fixes issue [13985](https://github.com/Azure/azure-sdk-for-js/issues/13985) where abort event listeners that removed themselves when invoked could prevent other event listeners from being invoked.
### Key Vault - Secrets 4.2.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/keyvault-secrets_4.2.0-beta.3/sdk/keyvault/keyvault-secrets/CHANGELOG.md#420-beta3-2021-03-09)
- Updated the Latest service version to 7.2.
- Added a `certificateKeyId?: string` secret property to use instead of the deprecated `keyId?: URL` and removed `"lib": ["dom"]` from `tsconfig.json`

### Key Vault - Keys 4.2.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/keyvault-keys_4.2.0-beta.4/sdk/keyvault/keyvault-keys/CHANGELOG.md#420-beta4-2021-03-09)
- Updated the Latest service version to 7.2.
- Added `curve` to `createKeyOptions` to be used when creating an `EC` key.
- Deprecated the current `encrypt` and `decrypt` methods in favor of the more flexible overloads that take an `{Encrypt|Decrypt}Parameters` and allow passing in algorithm specific parameters. This enables support for the various AES algorithms used in Managed HSM. The deprecated methods continue to function and there's no timeline for their removal.
- Added `additionalAuthenticatedData`, `iv`, and `authenticationTag` to `EncryptResult` in order to support AES encryption and decryption.
- Refactored the various cryptography providers and updated the error messages to be clearer and more descriptive.

[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
