---
title: Azure SDK for JavaScript (March 2021)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

<!--
@azure/abort-controller:1.0.3
@azure/identity:1.2.4-beta.1

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to make available the March 2021 client library release.

#### GA

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Core - Abort Controller

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Identity

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/abort-controller@1.0.3
$> npm install @azure/identity@1.2.4-beta.1

```

[pattern]: # ($> npm install ${PackageName}@${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Release highlights
### Core - Abort Controller 1.0.3 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/abort-controller_1.0.3/sdk/core/@azure/abort-controller/CHANGELOG.md#103-2021-02-23)
Support Typescript version < 3.6 by down-leveling the type definition files. ([PR 12793](https://github.com/Azure/azure-sdk-for-js/pull/12793))

### Identity 1.2.4-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/identity_1.2.4-beta.1/sdk/identity/@azure/identity/CHANGELOG.md#124-beta1-2021-02-12)
- Breaking Change: Updated `InteractiveBrowserCredential` to use the Auth Code Flow with PKCE rather than Implicit Grant Flow by default in the browser, to better support browsers with enhanced security restrictions. A new file was added to provide more information about this credential [here](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/identity/identity/interactive-browser-credential.md).


[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
