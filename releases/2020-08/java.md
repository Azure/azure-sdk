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
  <version>4.2.0</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure Cosmos ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/cosmos/azure-cosmos/CHANGELOG.md#420-2020-07-14))

## 4.2.0 (2020-07-14)

### New Features

- Added script logging enabled API to `CosmosStoredProcedureRequestOptions`.
- Updated `DirectConnectionConfig` default `idleEndpointTimeout` to 1h and default `connectTimeout` to 5s.

### Key Bug Fixes

- Fixed issue where `GatewayConnectionConfig` `idleConnectionTimeout` was overriding `DirectConnectionConfig` `idleConnectionTimeout`.
- Fixed `responseContinuationTokenLimitInKb` get and set APIs in `CosmosQueryRequestOptions`.
- Fixed issue in query and change feed when recreating the collection with same name.
- Fixed issue with top query throwing ClassCastException.
- Fixed issue with order by query throwing NullPointerException.
- Fixed `Operator called default onErrorDropped` when stream got cancelled.
  
## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

{% assign packages = site.data.releases.latest.java-packages %}
{% include java-packages.html %}

{% include refs.md %}
