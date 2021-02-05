---
title: Azure SDK for JavaScript (%%MMMM yyyy%%)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

<!--
@azure/identity:1.2.1
@azure/storage-blob:12.4.0
@azure/storage-queue:12.3.0
@azure/service-bus:7.0.1
@azure/storage-file-datalake:12.3.0
@azure/digital-twins-core:1.0.1
@azure/opentelemetry-exporter-azure-monitor:1.0.0-beta.1
@azure/attestation:1.0.0-beta.1
@azure/service-bus:7.0.2
@azure/digital-twins-core:1.0.2
@azure/storage-file-share:12.4.0

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to make available the %%MMMM yyyy%% client library release.

#### GA
- Storage - Blobs
- Storage - Queues
- Storage - Files Data Lake
- Storage - Files Shares

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Identity
- Service Bus
- Digital Twins - Core
- Service Bus
- Digital Twins - Core

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Monitor Exporter for OpenTelemetry
- Azure Security Attestation

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/identity@1.2.1
$> npm install @azure/storage-blob@12.4.0
$> npm install @azure/storage-queue@12.3.0
$> npm install @azure/service-bus@7.0.1
$> npm install @azure/storage-file-datalake@12.3.0
$> npm install @azure/digital-twins-core@1.0.1
$> npm install @azure/opentelemetry-exporter-azure-monitor@1.0.0-beta.1
$> npm install @azure/attestation@1.0.0-beta.1
$> npm install @azure/service-bus@7.0.2
$> npm install @azure/digital-twins-core@1.0.2
$> npm install @azure/storage-file-share@12.4.0

```

[pattern]: # ($> npm install ${PackageName}@${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Release highlights
### Identity 1.2.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/identity_1.2.1/sdk/identity/@azure/identity/CHANGELOG.md#121-2021-01-07)
- Upgrading to Axios 0.21.1 due to a severe vulnerability in Axios. Link to the documented vulnerability: [link](https://npmjs.com/advisories/1594). Fixes issue [13088](https://github.com/Azure/azure-sdk-for-js/issues/13088).

### Storage - Blobs 12.4.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/storage-blob_12.4.0/sdk/storage/@azure/storage-blob/CHANGELOG.md#1240-2021-01-12)
- Added a new `from(permissionLike)` function to `AccountSASPermissions`, `BlobSASPermissions` and `ContainerSASPermissions` for creating such a permission from a raw permission-like object. Addressed issue [9714](https://github.com/Azure/azure-sdk-for-js/issues/9714).

### Storage - Queues 12.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/storage-queue_12.3.0/sdk/storage/@azure/storage-queue/CHANGELOG.md#1230-2021-01-12)
- This release contains bug fixes to improve quality.

### Service Bus 7.0.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/service-bus_7.0.1/sdk/servicebus/@azure/service-bus/CHANGELOG.md#701-2021-01-11)
- Fix the `isNode` check to allow the package to be usable in Electron. [Bug 12983](https://github.com/Azure/azure-sdk-for-js/issues/12983)
- Fix issue where receiveMessages might return fewer messages than were received, causing them to be potentially locked or lost.
  [PR 12772](https://github.com/Azure/azure-sdk-for-js/pull/12772)
  [PR 12908](https://github.com/Azure/azure-sdk-for-js/pull/12908)
  [PR 13073](https://github.com/Azure/azure-sdk-for-js/pull/13073)
- Updates documentation for `ServiceBusMessage` to call out that the `body` field
  must be converted to a byte array or `Buffer` when cross-language
  compatibility while receiving events is required.
- [Bug Fix] Correlation Rule Filter with the "label" set using the `createRule()` method doesn't filter the messages to the subscription.
  The bug has been fixed in [PR 13069](https://github.com/Azure/azure-sdk-for-js/pull/13069), also fixes the related issues where the messages are not filtered when a subset of properties are set in the correlation filter.

### Storage - Files Data Lake 12.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/storage-file-datalake_12.3.0/sdk/storage/@azure/storage-file-datalake/CHANGELOG.md#1230-2021-01-12)
- Bug fix - `DataLakePathClient.move()` now supports source and destination authenticated with SAS. Fixed bug [12758](https://github.com/Azure/azure-sdk-for-js/issues/12758).
- Now you can get the functionality of the root directory via the `DataLakeDirectoryClient` created via `FileSystemClient.getDirectoryClient("")`. Fixed bug [12813](https://github.com/Azure/azure-sdk-for-js/issues/12813).

### Digital Twins - Core 1.0.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/digital-twins-core_1.0.1/sdk/digitaltwins/@azure/digital-twins-core/CHANGELOG.md#101-2021-01-12)
- This release is an update the GA release containing the following changes:
  - Fix publishComponentTelemetry API to follow the convention, now messageId is a mandatory argument
  - Add E2E live and record/playback tests
  - Add samples of delete digitaltwins and models for convenience

### Monitor Exporter for OpenTelemetry 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/opentelemetry-exporter-azure-monitor_1.0.0-beta.1/sdk/monitor/@azure/opentelemetry-exporter-azure-monitor/CHANGELOG.md#100-beta1-2021-01-13)
- OT Exporter retry when there are network issues
- OpenTelemetry Exporter using Resources API to get service properties
- Rename package to `@azure/opentelemetry-exporter-azure-monitor`
- [BREAKING] Deprecate all configuration options except for `connectionString`
- [BREAKING] Removed support for `TelemetryProcessor`
- (internal) Migrate to autorest generated HttpClient and Envelope Interfaces
- Migrate to Azure SDK for JS repository
- Adds support for Event Hubs Distributed Tracing [#10575](https://github.com/Azure/azure-sdk-for-js/pull/10575)

### Azure Security Attestation 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/attestation_1.0.0-beta.1/sdk/attestation/@azure/attestation/CHANGELOG.md#100-beta1-2021-01-15)
Initial early preview release for MAA Data Plane SDK Demonstrates use of the machine generated MAA APIs.

- Initial Release

### Service Bus 7.0.2 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/service-bus_7.0.2/sdk/servicebus/@azure/service-bus/CHANGELOG.md#702-2021-01-13)
- [Bug Fix] Receiving messages from sessions in "receiveAndDelete" mode using the `subscribe()` method stops after receiving 2048 of them and leaves the receiver hanging. The bug has been fixed in [PR 13178](https://github.com/Azure/azure-sdk-for-js/pull/13178). Also fixes the same issue that is seen with the `receiveMessages` API when large number of messages are requested or if the API is called in a loop.

### Digital Twins - Core 1.0.2 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/digital-twins-core_1.0.2/sdk/digitaltwins/@azure/digital-twins-core/CHANGELOG.md#102-2021-01-14)
- Bug Fix: include the types definition file in the shipped package

### Storage - Files Shares 12.4.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/storage-file-share_12.4.0/sdk/storage/@azure/storage-file-share/CHANGELOG.md#1240-2021-01-12)
- This release contains bug fixes to improve quality.

[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
