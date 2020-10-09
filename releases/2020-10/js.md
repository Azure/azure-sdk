---
title: Azure SDK for JavaScript (October 2020)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the October 2020 client library release.

#### GA

- _REMEMBER TO ADD YOUR GA PACKAGES_

#### Updates

- _REMEMBER TO ADD YOUR UPDATE PACKAGES_

#### Beta

- Azure Identity.
- Azure Metrics Advisor.
- Azure Tables.
Azure Service Bus
- _REMEMBER TO ADD YOUR BETA PACKAGES_

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/identity@next
$> npm install @azure/data-tables@next
$> npm install @azure/ai-metrics-advisor
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

---

=== COPY THIS AND ADD THE INFORMATION OF YOUR PACKAGE: ===

Keep in mind that:

- Including the package name in the headers makes the URL links work for multiple packages.
- The format of this file will be cleaned up once all of your proposals are in.

---

#### @azure/service-bus@7.0.0-preview.7 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/servicebus/service-bus/CHANGELOG.md)

##### New Features on @azure/service-bus@7.0.0-preview.7

- Message locks can be auto-renewed in all receive methods (receiver.receiveMessages, receiver.subcribe
  and receiver.getMessageIterator). This can be configured in options when calling `ServiceBusClient.createReceiver()`.
  [PR 11658](https://github.com/Azure/azure-sdk-for-js/pull/11658)
- `ServiceBusClient` now supports authentication with AAD credentials in the browser(can use `InteractiveBrowserCredential` from `@azure/identity`).
  [PR 11250](https://github.com/Azure/azure-sdk-for-js/pull/11250)

#### _Package name_ [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/<service-folder>/<package-folder>/CHANGELOG.md)

(leave blank)

##### Breaking Changes on _Package name_

- _Add one or more, or remove the "Breaking Changes on ..." entire section._

##### New Features on _Package name_

- _Add one or more, or remove the "New Features on ..." section._

##### Major Fixes on _Package name_

- _Add one or more, or remove the "Major Fixes on ..." section._

### Azure Tables

#### @azure/data-tables [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/tables/data-tables/CHANGELOG.md)

##### New Features on @azure/data-tables@1.0.0-beta.2

- Implemented batch operations.

### Azure Metrics Advisor

#### @azure/ai-metrics-advisor [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/metricsadvisor/ai-metrics-advisor/CHANGELOG.md)

(leave blank)

- This is the inital preview of client library that supports the newly announced preview of the Azure Metrics Advisor service.
- This library has been designed based on the [Azure SDK Design Guidelines for TypeScript]({{ site.baseurl }}{% link docs/typescript/introduction.md %}) to ensure consistency, idiomatic design, and excellent developer experience and productivity.
- It supports all services APIs, including but not limited to
  - Manage data feeds.
  - Configure anomaly detection and alerting configurations.
  - Query anomaly detection results, for example, incidents, anomalies, alerts, enriched series data, etc.
  - Diagnose incident root causes.

### Azure Identity

#### @azure/identity  [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/identity/identity/CHANGELOG.md)

Our authentication library is being released with some minor changes and fixes to the existing authentication methods.

##### New Features on @azure/identity@1.2.0-beta.2

- `DefaultAzureCredential` now by default shows the Device Code message on the console. This can still be overwritten with a custom behavior by specifying a function as the third parameter, `userPromptCallback`.
- Added Active Directory Federation Services authority host support to the node credentials.

##### Major Fixes on @azure/identity@1.2.0-beta.2

- Added support for multiple clouds on `VisualStudioCodeCredential`. Fixes customer issue [11452](https://github.com/Azure/azure-sdk-for-js/issues/11452).
- `ManagedIdentityCredential` has been aligned with other languages, now treating expected errors properly. This fixes customer issue [11451](https://github.com/Azure/azure-sdk-for-js/issues/11451).


## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
