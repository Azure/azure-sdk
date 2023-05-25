---
title: Azure SDK (March 2021)
layout: post
tags: release
sidebar: releases_sidebar
---

Thank you for your interest in the new Azure SDKs! We release new features, improvements, and bug fixes every month. Please subscribe to our [Azure SDK Blog RSS Feed](https://devblogs.microsoft.com/azure-sdk/feed) to get notified when a new release is available.

You can find links to packages, code, and docs on our [Azure SDK Releases page](https://aka.ms/azsdk/releases).

## Release Highlights

- Azure Mixed Reality client library for .NET is generally available.
- Event Grid client libraries are now generally available. Read more in this blog post: ["Announcing the new Azure Event Grid Client Libraries"](https://devblogs.microsoft.com/azure-sdk/event-grid-ga)
    - The libraries support the [Cloud Event](https://cloudevents.io/) schema, Custom Event schema, as well as the Event Grid Event schema native to the Event Grid Service.
    - This includes a new [.NET bridge library](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/eventgrid/Microsoft.Azure.Messaging.EventGrid.CloudNativeCloudEvents/README.md) providing integration with the [CNCF CloudEvents package](https://www.nuget.org/packages/CloudNative.CloudEvents/2.0.0-beta.1).
- Azure Cosmos DB client library for Java is generally available.
- Java libraries upgraded to support Jackson from `2.11.3` to `2.12.1`, Reactor from `3.3.12.RELEASE` to `3.4.3` and `reactor-netty` from `3.3.12.RELEASE` to `3.4.3`.
- Java Azure Core library is releasing a new GA.
  - Adds default interface APIs to `SerializerAdapter`, `ObjectSerializer` and `Tracer` classes and introduces `CloudEventModel` which conforms to the [Cloud Event Specification](https://github.com/cloudevents/spec/blob/v1.0.1/spec.md).
- Azure Communication Services Phone Numbers library has added support for Azure Active Directory Authentication.
- JavaScript/TypeScript Azure Core Client 1.0.0 is GA and Azure Core Rest Pipeline 1.0.0 is GA
    * This is the next generation of Azure.Core, which is the foundation of all other SDK libraries. The new version features a more modular design, allows easier customization of the request pipeline, improves the performance of majority usages.

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
