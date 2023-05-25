---
title: Azure SDK (February 2021)
layout: post
tags: release
sidebar: releases_sidebar
---

Thank you for your interest in the new Azure SDKs! We release new features, improvements, and bug fixes every month. Please subscribe to our [Azure SDK Blog RSS Feed](https://devblogs.microsoft.com/azure-sdk/feed) to get notified when a new release is available.

You can find links to packages, code, and docs on our [Azure SDK Releases page](https://aka.ms/azsdk/releases).

## Release Highlights

* Metrics advisor libraries now have AAD authentication support. 
* Azure Search Documents is releasing a new GA.
  * Adds support for indexing search documents with intelligent batching, automatic flushing, and retries for failed indexing actions.
* Azure Event Hubs is releasing a new GA.
  * You can now specify custom endpoint address as a client constructor option to use when communicating with the Event Hubs service, which is useful when your network does not allow communicating to the standard Event Hubs endpoint.
* Java Cosmos Library is releasing a new GA
  * Contains supports of Connection Endpoint Discovery feature which helps to reduce and spread-out high latency spikes. This release also exposes Beta APIs for Change Feed Pull model, resuming query from pre-split continuation token, and caching query plan for single partition queries with filters and orderby.
* Java Azure Core library is releasing a new GA 
  * Adds support to allow configurability of polling interval on Long Running Operation APIs and also introduces `HttpClientOptions` to allow reusability of `HttpClient` passed to SPIs and client builders.
  
## Release Notes

* [All release notes](index.md)
* [.NET release notes](dotnet.md)
* [Java release notes](java.md)
* [JavaScript/TypeScript release notes](js.md)
* [Python release notes](python.md)
* [C++ release notes](cpp.md)
* [Android release notes](android.md)
* [iOS release notes](ios.md)
* [Go release notes](go.md)
