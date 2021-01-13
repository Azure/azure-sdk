---
title: Azure SDK for JavaScript (January 2021)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the January 2021 client library release.

#### GA

- _Add packages_

#### Updates

- Azure Storage Queue
- Azure Storage Blob
- Azure File Share
- Azure File Datalake
- Azure Service Bus
- _Add packages_

#### Beta

- Azure Data Tables
- Azure Attestation
- _Add packages_

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/package-name
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

### Azure Service Bus

#### @azure/service-bus [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/servicebus/service-bus/CHANGELOG.md)

We're releasing a patch of the Service Bus client that includes some bug fixes.

##### Major Fixes on @azure/service-bus 7.0.1 and 7.0.2

- Fix issue where `receiveMessages` might return fewer messages than were received, causing them to be potentially locked or lost.  
  [#12772](https://github.com/Azure/azure-sdk-for-js/pull/12772) [#12908](https://github.com/Azure/azure-sdk-for-js/pull/12908) [#13073](https://github.com/Azure/azure-sdk-for-js/pull/13073)
- [Bug Fix] Correlation Rule Filter with the "label" set using the `createRule()` method doesn't filter the messages to the subscription or when a subset of properties are set in the correlation filter.  
  [#13069](https://github.com/Azure/azure-sdk-for-js/pull/13069)
- [Bug Fix] Receiving messages from sessions in "receiveAndDelete" mode using the `subscribe()` method stops after receiving 2048 of them and leaves the receiver hanging. The bug has been fixed in [#13178](https://github.com/Azure/azure-sdk-for-js/pull/13178).  
 Also fixes the same issue that is seen with the `receiveMessages` API when large number of messages are requested or if the method is called in a loop.

### Azure Tables 

#### @azure/data-tables [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/tables/data-tables/CHANGELOG.md)

We're releasing a new beta for our Azure Data Tables client that improces the precisssion of the dates being used in the package, and enables this client to communicate with the Azure Storage Emualtor.

##### Breaking Changes on @azure/data-tables@1.0.0-beta.4

- Disabled `Edm.DateTime` deserialization into a JavaScript Date to avoid losing precision [#12650](https://github.com/Azure/azure-sdk-for-js/pull/12650).

##### Major Fixes on @azure/data-tables@1.0.0-beta.4

- Fixed an issue that prevented the use of the SDK against the Azure Storage Emulator and `Azurite@3.9.0-table-alpha.1`
 [#13165](https://github.com/Azure/azure-sdk-for-js/pull/13165).

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
