---
title: Azure SDK (May 2021)
layout: post
tags: release
sidebar: releases_sidebar
---

Thank you for your interest in the new Azure SDKs! We release new features, improvements, and bug fixes every month. Please subscribe to our [Azure SDK Blog RSS Feed](https://devblogs.microsoft.com/azure-sdk/feed) to get notified when a new release is available.

You can find links to packages, code, and docs on our [Azure SDK Releases page](https://aka.ms/azsdk/releases).

## Release Highlights

- Azure Cosmos DB client library for Java is releasing a new GA.
    - Adds `backendLatencyInMs` in `CosmosDiagnostics` for `DIRECT` connection mode and `retryContext` in `CosmosDiagnostics` for query operations.
- Java Azure Core library is releasing a new GA.
    - Adds support for Challenge Based Authentication in BearerTokenAuthenticationPolicy.
    - Updated logic to eagerly read response bodies to include return types void and Void.
- Java Azure Messaging EventGrid library is releasing a new GA.
    - Adds new Storage system events `StorageAsyncOperationInitiatedEventData`,  `StorageBlobTierChangedEventData` and new Policy Insights system events `PolicyInsightsPolicyStateCreatedEventData`, `PolicyInsightsPolicyStateChangedEventData`,  `PolicyInsightsPolicyStateDeletedEventData`.
- Java Azure Identity library is releasing a new GA.
    - Adds support for Continuous Access Evaluation (CAE)
    - Adds `AzurePowerShellCredential` to support authentication using Powershell on development platforms.
- Releasing an initial preview/beta SDK release of Azure Purview Scanning, Azure Purview Catalog, Azure FarmBeats, Azure Confidential Ledger

## Release Notes

* [All release notes](index.md)
* [.NET release notes](dotnet.md)
* [Java release notes](java.md)
* [JavaScript/TypeScript release notes](js.md)
* [Python release notes](python.md)
* [C++ release notes](cpp.md)
* [Embedded C release notes](c.md)
* [Android release notes](android.md)
* [iOS release notes](ios.md)
* [Go release notes](go.md)
