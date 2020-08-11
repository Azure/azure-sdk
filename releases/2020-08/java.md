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

- Azure Core
- Azure Core Http Netty
- Azure Core Http OkHttp
- Azure-Cosmos

#### Preview

- Azure Core Experimental
- Azure Core Management
- Azure Core Tracing OpenTelemetry
- Form Recognizer

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.7.0</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-experimental</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-netty</artifactId>
  <version>1.5.4</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.2.5</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-management</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-tracing-opentelemetry</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.0.0-beta.1</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure Core ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core/CHANGELOG.md#170-2020-08-07))

#### New Features

- Redesigned `SimpleTokenCache` to gracefully attempt a token refresh 5 minutes before actual expiry.
- Added `ObjectSerializer` and `JsonSerializer` APIs to support pluggable serialization within SDKs.
- Added `TypeReference<T>` to enable serialization handling for `Class<T>` and `Type` while retaining generics through a call stack.
- Added `MemberNameConverter` which converts a `Member` type of `Field` or `Method` into its expected serialized JSON property name.
- Updated `reactor-core` version to `3.3.8.RELEASE`.
- Updated `reactor-netty` version to `0.9.10.RELEASE`.
- Updated `netty` version to `4.1.51.Final`.
- Updated `netty-tcnative` version to `2.0.31.Final`.

#### Key Bug Fixes

- Updated handling of `OffsetDateTime` serialization to implicitly convert date strings missing time zone into UTC.
- Updated `PollerFlux` and `SyncPoller` to propagate exceptions when polling instead of only on failed statuses.

### Azure Core Experimental ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-experimental/CHANGELOG.md#100-beta2-2020-08-07))

#### Breaking Changes

- Moved `ObjectSerializer` and some implementation of `JsonSerializer` into `azure-core`.
- Created sub-interface of `JsonSerializer` in `azure-core` to include APIs that weren't moved.

### Azure Core Http Netty ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-http-netty/CHANGELOG.md#154-2020-08-07))

#### New Features

- Updated `reactor-core` version to `3.3.8.RELEASE`.
- Updated `reactor-netty` version to `0.9.10.RELEASE`.
- Updated `netty` version to `4.1.51.Final`.
- Updated `netty-tcnative` version to `2.0.31.Final`.

#### Key Bug Fixes

- Fixed a bug where connections weren't being re-used when using a proxy which lead to a new TCP and SSL session for each request.
- Fixed a bug where a non-shareable proxy handler could be added twice into a `ChannelPipeline`.

### Azure Core Management ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-management/CHANGELOG.md#100-beta3-2020-08-07))

#### New Features

- Added optional `Context` parameter to methods in `PollerFactory` class, which will be shared for all polling requests.
- Added `getResponseHeaders()` method to `PollResult.Error` class.
- Added `AzureProfile` class.
- Added `IdentifierProvider` and `DelayProvider` interfaces.

#### Key Bug Fixes

- Fixed polling status HTTP status code check to include 202.

### Azure Core Tracing OpenTelemetry ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-tracing-opentelemetry/CHANGELOG.md#100-beta6-2020-08-07))

#### New Featues

- Update `opentelemetry-api` dependency version to `0.6.0` and included `io.grpc:grpc-context[1.30.0]` external dependency.

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

### Form Recognizer ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#300-beta1-2020-08-11))

#### Breaking changes
- Bumped package version to 3.0.0-beta.1 and now targets the service's stable v2.0 API
- Changed param ordering for methods `beginRecognizeCustomForms` and `beginRecognizeCustomFormsFromUrl`
- Model and property renamings detailed in the Changelog.

#### New features
- Added support for context passing.

### Key Bug Fixes
- Fixed `getFields()` on `RecognizedForm` to preserve service side ordering of fields.

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
