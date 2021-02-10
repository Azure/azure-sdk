---
title: Azure SDK for Java (%%MMMM yyyy%%)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

<!--
azure-ai-formrecognizer:3.0.4
azure-security-keyvault-secrets:4.2.4
azure-core-test:1.5.2
azure-security-keyvault-keys:4.2.4
azure-core-experimental:1.0.0-beta.9
azure-core-serializer-avro-apache:1.0.0-beta.6
azure-search-documents:11.1.3
azure-ai-textanalytics:5.0.2
azure-core-serializer-json-jackson:1.1.1
azure-core-http-okhttp:1.4.1
azure-core-serializer-json-gson:1.0.4
azure-core-amqp:2.0.1
azure-identity:1.2.2
azure-core-http-netty:1.7.1
azure-security-keyvault-certificates:4.1.4
azure-core:1.12.0
azure-core-management:1.1.0

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to announce our %%MMMM yyyy%% client library releases.

#### GA
- Core
- Management - Core

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Form Recognizer
- Key Vault - Secrets
- Core - Test
- Key Vault - Keys
- Cognitive Search
- Text Analytics
- Core Serializer Jackson JSON
- Core - HTTP OkHttp
- Core Serializer GSON JSON
- Core - AMQP
- Identity
- Core - HTTP Netty
- Key Vault - Certificates

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Core Experimental
- Core Serializer Apache Avro

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml

<dependency>
  <groupId></groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.0.4</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.2.4</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-core-test</artifactId>
  <version>1.5.2</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.2.4</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-core-experimental</artifactId>
  <version>1.0.0-beta.9</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-core-serializer-avro-apache</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.1.3</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>5.0.2</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-core-serializer-json-jackson</artifactId>
  <version>1.1.1</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.4.1</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-core-serializer-json-gson</artifactId>
  <version>1.0.4</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-core-amqp</artifactId>
  <version>2.0.1</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.2.2</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-core-http-netty</artifactId>
  <version>1.7.1</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.1.4</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-core</artifactId>
  <version>1.12.0</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-core-management</artifactId>
  <version>1.1.0</version>
</dependency>

```

[pattern]: # (`n<dependency>`n  <groupId>${GroupId}</groupId>`n  <artifactId>${PackageName}</artifactId>`n  <version>${PackageVersion}</version>`n</dependency>)

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights
### Form Recognizer 3.0.4 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-ai-formrecognizer_3.0.4/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#304-2021-01-14)
#### Dependency Updates
- Update dependency version, `azure-core` to `1.12.0`, `azure-core-http-netty` to `1.7.1` and `azure-identity` to `1.2.2`.

### Key Vault - Secrets 4.2.4 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-security-keyvault-secrets_4.2.4/sdk/keyvault/azure-security-keyvault-secrets/CHANGELOG.md#424-2021-01-15)
#### Dependency Updates
- Upgraded `azure-core` dependency to `1.12.0`
- Upgraded `azure-core-http-netty` dependency to `1.7.1`
- Upgraded `azure-core-http-okhttp` dependency to `1.4.1`
- Upgraded `azure-identity` dependency to `1.2.2`

### Core - Test 1.5.2 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-core-test_1.5.2/sdk/core/azure-core-test/CHANGELOG.md#152-2021-01-11)
#### Dependency Updates

- Updated `azure-core` from `1.10.0` to `1.12.0`.

### Key Vault - Keys 4.2.4 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-security-keyvault-keys_4.2.4/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#424-2021-01-15)
#### Dependency Updates
- Upgraded `azure-core` dependency to `1.12.0`
- Upgraded `azure-core-http-netty` dependency to `1.7.1`
- Upgraded `azure-core-http-okhttp` dependency to `1.4.1`
- Upgraded `azure-identity` dependency to `1.2.2`

### Core Experimental 1.0.0-beta.9 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-core-experimental_1.0.0-beta.9/sdk/core/azure-core-experimental/CHANGELOG.md#100-beta9-2021-01-11)
#### Breaking Changes

- Moved `BinaryData` to `azure-core`.

### Core Serializer Apache Avro 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-core-serializer-avro-apache_1.0.0-beta.6/sdk/core/azure-core-serializer-avro-apache/CHANGELOG.md#100-beta6-2021-01-11)
#### Dependency Updates

- Updated `azure-core` from `1.10.0` to `1.12.0`.

### Cognitive Search 11.1.3 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-search-documents_11.1.3/sdk/search/azure-search-documents/CHANGELOG.md#1113-2021-01-15)
#### Dependency updates

- Updated `azure-core` to `1.12.0`.
- Updated `azure-core-http-netty` to `1.7.1`.

### Text Analytics 5.0.2 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-ai-textanalytics_5.0.2/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#502-2021-01-14)
#### Dependency updates
- Update dependency version, `azure-core` to 1.12.0 and `azure-core-http-netty` to 1.7.1.

### Core Serializer Jackson JSON 1.1.1 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-core-serializer-json-jackson_1.1.1/sdk/core/azure-core-serializer-json-jackson/CHANGELOG.md#111-2021-01-11)
#### Dependency Updates

- Updated `azure-core` from `1.10.0` to `1.12.0`.

### Core - HTTP OkHttp 1.4.1 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-core-http-okhttp_1.4.1/sdk/core/azure-core-http-okhttp/CHANGELOG.md#141-2021-01-11)
#### Bug Fixes

- Fixed a bug where environment proxy configurations were not sanitizing the non-proxy host string into a valid `Pattern` format. [#18156](https://github.com/Azure/azure-sdk-for-java/issues/18156)

### Core Serializer GSON JSON 1.0.4 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-core-serializer-json-gson_1.0.4/sdk/core/azure-core-serializer-json-gson/CHANGELOG.md#104-2021-01-11)
#### Dependency Updates

- Updated `azure-core` from `1.10.0` to `1.12.0`.

### Core - AMQP 2.0.1 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-core-amqp_2.0.1/sdk/core/azure-core-amqp/CHANGELOG.md#201-2021-01-11)
#### New Features

- Changed connections from sharing the global `Schedulers.single()` to having a `Scheduler.newSingle()` per connection to improve performance.

### Identity 1.2.2 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-identity_1.2.2/sdk/identity/azure-identity/CHANGELOG.md#122-2021-01-12)
#### Dependency Updates
- Upgraded `azure-core` dependency to 1.12.0

### Core - HTTP Netty 1.7.1 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-core-http-netty_1.7.1/sdk/core/azure-core-http-netty/CHANGELOG.md#171-2021-01-11)
#### Bug Fixes

- Fixed a bug where environment proxy configurations were not sanitizing the non-proxy host string into a valid `Pattern` format. [#18156](https://github.com/Azure/azure-sdk-for-java/issues/18156)

#### Dependency Updates

- Upgraded Netty from `4.1.53.Final` to `4.1.54.Final`.
- Upgraded `reactor-netty` from `0.9.13.RELEASE` to `0.9.15.RELEASE`.

### Key Vault - Certificates 4.1.4 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-security-keyvault-certificates_4.1.4/sdk/keyvault/azure-security-keyvault-certificates/CHANGELOG.md#414-2021-01-15)
#### Dependency Updates
- Upgraded `azure-core` dependency to `1.12.0`
- Upgraded `azure-core-http-netty` dependency to `1.7.1`
- Upgraded `azure-core-http-okhttp` dependency to `1.4.1`
- Upgraded `azure-identity` dependency to `1.2.2`

### Core 1.12.0 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-core_1.12.0/sdk/core/azure-core/CHANGELOG.md#1120-2021-01-11)
#### New Features

- Added `AzureSasCredential` and `AzureSasCredentialPolicy` to standardize the ability to add SAS tokens to HTTP requests.

#### Bug Fixes

- Fixed a bug where environment proxy configurations were not sanitizing the non-proxy host string into a valid `Pattern` format. [#18156](https://github.com/Azure/azure-sdk-for-java/issues/18156)

#### Dependency Updates

- Updated `reactor-core` from `3.3.11.RELEASE` to `3.3.12.RELEASE`.
- Updated `netty-tcnative-boringssl-static` from `2.0.34.Final` to `2.0.35.Final`.

### Management - Core 1.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-core-management_1.1.0/sdk/core/azure-core-management/CHANGELOG.md#110-2021-01-11)
#### New Features

- Added `MICROSOFT_GRAPH` to `AzureEnvironment`.

#### Bug Fixes

- Fixed long-running operation, PUT method, response 201 and Location, succeeded without poll.


[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
