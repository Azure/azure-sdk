---
title: Azure SDK for Java (%%MMMM yyyy%%)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

<!--
azure-ai-formrecognizer:3.0.4
azure-search-documents:11.1.3
azure-security-keyvault-certificates:4.1.4
azure-security-keyvault-secrets:4.2.4
azure-security-keyvault-keys:4.2.4
azure-ai-textanalytics:5.0.2

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to announce our %%MMMM yyyy%% client library releases.

#### GA

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates

- Form Recognizer
- Cognitive Search
- Key Vault - Certificates
- Key Vault - Secrets
- Key Vault - Keys
- Text Analytics

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta

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
  <artifactId>azure-search-documents</artifactId>
  <version>11.1.3</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.1.4</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.2.4</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.2.4</version>
</dependency>

<dependency>
  <groupId></groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>5.0.2</version>
</dependency>

```

[pattern]: # (`n<dependency>`n  <groupId>${GroupId}</groupId>`n  <artifactId>${PackageName}</artifactId>`n  <version>${PackageVersion}</version>`n</dependency>)

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights

### Form Recognizer 3.0.4 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-ai-formrecognizer_3.0.4/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#304-2021-01-14)
#### Dependency Updates
- Update dependency version, `azure-core` to `1.12.0`, `azure-core-http-netty` to `1.7.1` and `azure-identity` to `1.2.2`.

### Cognitive Search 11.1.3 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-search-documents_11.1.3/sdk/search/azure-search-documents/CHANGELOG.md#1113-2021-01-15)
#### Dependency updates

- Updated `azure-core` to `1.12.0`.
- Updated `azure-core-http-netty` to `1.7.1`.

### Key Vault - Certificates 4.1.4 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-security-keyvault-certificates_4.1.4/sdk/keyvault/azure-security-keyvault-certificates/CHANGELOG.md#414-2021-01-15)
#### Dependency Updates
- Upgraded `azure-core` dependency to `1.12.0`
- Upgraded `azure-core-http-netty` dependency to `1.7.1`
- Upgraded `azure-core-http-okhttp` dependency to `1.4.1`
- Upgraded `azure-identity` dependency to `1.2.2`

### Key Vault - Secrets 4.2.4 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-security-keyvault-secrets_4.2.4/sdk/keyvault/azure-security-keyvault-secrets/CHANGELOG.md#424-2021-01-15)
#### Dependency Updates
- Upgraded `azure-core` dependency to `1.12.0`
- Upgraded `azure-core-http-netty` dependency to `1.7.1`
- Upgraded `azure-core-http-okhttp` dependency to `1.4.1`
- Upgraded `azure-identity` dependency to `1.2.2`

### Key Vault - Keys 4.2.4 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-security-keyvault-keys_4.2.4/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#424-2021-01-15)
#### Dependency Updates
- Upgraded `azure-core` dependency to `1.12.0`
- Upgraded `azure-core-http-netty` dependency to `1.7.1`
- Upgraded `azure-core-http-okhttp` dependency to `1.4.1`
- Upgraded `azure-identity` dependency to `1.2.2`

### Text Analytics 5.0.2 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-ai-textanalytics_5.0.2/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#502-2021-01-14)
#### Dependency updates
- Update dependency version, `azure-core` to 1.12.0 and `azure-core-http-netty` to 1.7.1.


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

