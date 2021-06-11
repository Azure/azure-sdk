---
title: Azure SDK (June 2021)
layout: post
tags: release
sidebar: releases_sidebar
---

Thank you for your interest in the new Azure SDKs! We release new features, improvements, and bug fixes every month. Please subscribe to our [Azure SDK Blog RSS Feed](https://devblogs.microsoft.com/azure-sdk/feed) to get notified when a new release is available.

You can find links to packages, code, and docs on our [Azure SDK Releases page](https://aka.ms/azsdk/releases).

## Release Highlights

- Video Analyzer SDKs released a first beta. The client SDKs allow you to interact with the direct methods of a Video Analyzer edge module. These SDKs are designed to be used with the Azure IoT Hub SDKs. They support constructing objects that represent the direct methods that can then be sent to the edge module using the IoT Hub SDKs
- FarmBeats SDKs released a first beta. The client SDKs allow AgriFood companies to build intelligent digital agriculture solutions. The users can -
  - Create & update farmers, farms, fields, seasonal fields and boundaries.
  - Ingest satellite and weather data for areas of interest.
  - Ingest farm operations data covering tilling, planting, harvesting and application of farm inputs.
- Form Recognizer SDK for JS released a new GA version 3.1.0. This General Availability (GA) release marks the stability of the changes introduced in package versions 3.1.0-beta.1 through 3.1.0-beta.3.
- Communication Relay has released a first beta for JS package @azure/communication-network-traversal. Azure Communication Network Traversal is managing tokens for Azure Communication Services.
- Monitor Query (`@azure/monitor-query`) has released 1.0.0-beta.1, which allows you to query Log Analytics Workspaces for logs and metrics.
- Models Repository service has released a first beta for JS package @azure/iot-modelsrepository. This package contains the `ModelsRepositoryClient` to talk to the Azure Models Repository service, with initial support for getting models and helper functions for working with DTMIs.
- Cognitive Search SDK for JS (`@azure/search-documents`) has released a new GA version: 11.2.0.
- Eventgrid SDK for JS (`@azure/eventgrid`) has released a new GA version: 4.3.0.
- Storage has released new GA versions for `@azure/storage-file-share`, `@azure/storage-blob`, `@azure/storage-file-datalake`, `@azure/storage-queue` SDKs with Azure Storage Service API version 2020-08-04.
- Tables SDK for JS (`@azure/data-tables`) has released a new GA version: 12.0.0. It has fixes for transaction issues when there are multiple transactions and date serializations, added support for generating SAS tokens.
- Service Bus SDK for JS has released a new GA version: 7.2.0. It enables encoding the body of a message using native AMQP serialization for supported primitives or sequences. In addition, cancellation support has been improved when sending messages or initializing a connection to the service.

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
