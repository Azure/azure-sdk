---
title: Azure SDK (August 2020)
layout: post
tags: release
sidebar: releases_sidebar
permalink: /releases/2020-08/index.html
---

## Highlights

* Azure Identity GA release with new Developer Credential types, logging enhancements, proactive token refresh, and authority host support.
* Azure Cognitive Search SDK for .NET added `FieldBuilder` to help easily build a search index from a model type.
* Added ObjectSerializer and JsonSerializer APIs to support pluggable serialization within SDKs.
* Added support for Key Vault service version 7.1 for Keys, Secrets, and Certificates
* Java Spring Updates
   - Service Bus JMS starter update underpinning SDK to [Java Message Service (JMS) 2.0 preview for Azure Service Bus premium tier](https://azure.microsoft.com/blog/announcing-preview-of-java-message-service-2-over-amqp-on-azure-service-bus/), which enables more lift and shift scenarios and significantly increased JMS API compatibility.
   - Added to Java Spring Boot starter of Key Vault to support case sensitive keys, connect to multiple Key Vaults from a single app, Spring Boot Actuator and performance improvements when keys are refreshed.
   - Upgraded underpinning Java Key Vault SDK for Azure Spring starter libraries for better performance, consistency, and compatibility.
   - Azure Spring Boot updated to Spring Boot 2.3.2, which addresses many bug fixes and cleans up all warnings at build time.

## Release notes

* [.NET](dotnet.md)
* [Java](java.md)
* [JavaScript](js.md)
* [Python](python.md)
