---
title: Azure SDK for Java (October 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our October 2020 client library releases.

#### GA

- _Add packages_

#### Updates

- Azure Key Vault Certificates
- Azure Key Vault Keys
- Azure Key Vault Secrets

#### Beta

- Azure Key Vault Administration
- Azure Key Vault Certificates
- Azure Key Vault Keys
- Azure Key Vault Secrets

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-administration</artifactId>
    <version>4.0.0-beta.2</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-certificates</artifactId>
    <version>4.1.2</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-certificates</artifactId>
    <version>4.2.0-beta.2</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-keys</artifactId>
    <version>4.2.2</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-keys</artifactId>
    <version>4.3.0-beta.2</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-secrets</artifactId>
    <version>4.2.2</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-secrets</artifactId>
    <version>4.3.0-beta.2</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure Key Vault Administration 4.0.0-beta.2 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/keyvault/azure-security-keyvault-administration/CHANGELOG.md#400-beta2-2020-10-08))

#### New features
- Added the new public APIs `getBackupOperation` and `getRestoreOperation` for querying the status of long-running operations in `KeyVaultBackupClient` and `KeyVaultBackupAsyncClient`.
- Added API overloads that allow for passing specific polling intervals for long-running operations.
- Added support for `com.azure.core.util.ClientOptions` in client builders.

### Azure Key Vault Certificates 4.3.0-beta.2 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/keyvault/azure-security-keyvault-certificates/CHANGELOG.md#420-beta2-2020-10-08))

#### New features
- Added `KeyVaultCertificateIdentifier`, which allows parsing the different elements of certificate identifiers.
- Added API overloads that allow for passing specific polling intervals for long-running operations.
- Added support for `com.azure.core.util.ClientOptions` in client builders.

### Azure Key Vault Keys 4.3.0-beta.2 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#430-beta2-2020-10-08))

#### New features
- Added `KeyVaultKeyIdentifier`, which allows parsing the different elements of key identifiers.
- Added API overloads that allow for passing specific polling intervals for long-running operations.
- Added support for `com.azure.core.util.ClientOptions` in client builders.

### Azure Key Vault Secrets 4.3.0-beta.2 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/keyvault/azure-security-keyvault-secrets/CHANGELOG.md#430-beta2-2020-10-08))

#### New features
- Added `KeyVaultSecretIdentifier`, which allows parsing the different elements of secret identifiers.
- Added API overloads that allow for passing specific polling intervals for long-running operations.
- Added support for `com.azure.core.util.ClientOptions` in client builders.
  
## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
