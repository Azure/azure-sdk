---
title: Azure SDK for Java (August 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our August 2020 client library releases.

#### GA

- _Add packages_

#### Updates

- Azure-Cosmos

#### Preview

- _Add packages_

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.3.0</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure Cosmos ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/cosmos/azure-cosmos/CHANGELOG.md#430-2020-07-29))

#### 4.3.0 (2020-07-29)

#### New Features

- Updated reactor-core library version to `3.3.8.RELEASE`. 
- Updated reactor-netty library version to `0.9.10.RELEASE`. 
- Updated netty library version to `4.1.51.Final`. 
- Added new overload APIs for `upsertItem` with `partitionKey`. 
- Added open telemetry tracing support. 

#### Key Bug Fixes

- Fixed issue where SSLException gets thrown in case of cancellation of requests in GATEWAY mode.
- Fixed resource throttle retry policy on stored procedures execution.
- Fixed issue where SDK hangs in log level DEBUG mode. 
- Fixed periodic spikes in latency in Direct mode. 
- Fixed high client initialization time issue. 
- Fixed http proxy bug when customizing client with direct mode and gateway mode. 
- Fixed potential NPE in users passes null options. 
- Added timeUnit to `requestLatency` in diagnostics string.
- Removed duplicate uri string from diagnostics string. 
- Fixed diagnostics string in proper JSON format for point operations.
- Fixed issue with `.single()` operator causing the reactor chain to blow up in case of Not Found exception. 

### _Package name_

- Major changes only!
  
## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
