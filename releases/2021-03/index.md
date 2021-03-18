---
title: Azure SDK (March 2021)
layout: post
tags: release
sidebar: releases_sidebar
---

Thank you for your interest in the new Azure SDKs! We release new features, improvements, and bug fixes every month. Please subscribe to our [Azure SDK Blog RSS Feed](https://devblogs.microsoft.com/azure-sdk/feed) to get notified when a new release is available.

You can find links to packages, code, and docs on our [Azure SDK Releases page](https://aka.ms/azsdk/releases).

## Release Highlights

* Python Event grid 4.0.0 is GAed
* This release is the the last version to officially support Python 3.5, future versions of Python packages will require Python 2.7 or Python 3.6+.
* Java Event Grid Library is releasing a first ever GA.
* Java Azure Core library is releasing a new GA.
  * Adds default interface APIs to `SerializerAdapter`, `ObjectSerializer` and `Tracer` classes and introduces `CloudEventModel` which conforms to the [Cloud Event Specification](https://github.com/cloudevents/spec/blob/v1.0.1/spec.md).
* Java Cosmos Library is releasing a new GA.
  * Introduces the beta feature of Throughput Control which allows Client side RU Limiting and adds the Beta APIs for `FeedRange` based query and `Conditional` Patch.
* Java libraries upgraded to support Jackson from `2.11.3` to `2.12.1`, `reactor-core` from `3.3.12.RELEASE` to `3.4.3`, and `reactor-netty` from `0.9.15.RELEASE` to `1.0.4`.
* 'Azure Communication Phone Numbers' library has added support for Azure Active Directory Authentication.
* JS Azure Core Client 1.0.0 is GA and Azure Core Rest Pipeline 1.0.0 is GA
    * This is the next generation of Azure.Core, which is the foundation of all other SDK libraries. The new version features a more modular design, allows easier customization of the request pipeline, improves the performance of majority usages.
* .NET 'Event Grid' library is releasing its next stable release - 4.0.0
* .NET 'Mixed Reality Authentication' library is releasing its first stable release - 1.0.0

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
