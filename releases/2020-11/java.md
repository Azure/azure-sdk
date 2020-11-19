---
title: Azure SDK for Java (November 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our November 2020 client library releases.

#### GA

- _Add packages_

#### Updates

- _Add packages_

#### Beta

- Azure Communication Administration
- Azure Communication Chat
- Azure Communication Common
- Azure Communication SMS

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-administration</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-chat</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-common</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-sms</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights

### Azure Communication Administration [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-administration/CHANGELOG.md#100-beta3-2020-11-16)

#### New Features

- Support directly passing connection string to the CommunicationIdentityClientBuilder.
- Added support for sync and async long-running operations
    - beginCreateReservation
    - beginPurchaseReservation
    - beginReleasePhoneNumber

#### Breaking Changes

- Removed credential(CommunicationClientCredential credential) and replaced with 
accessKey(String accessKey) within CommunicationIdentityClientBuilder.
- `PhoneNumberSearch` renamed to `PhoneNumberReservation`.
- `SearchStatus` renamed to `ReservationStatus`.
- `CreateSearchOptions` reanamed to `CreateReservationOptions`.
- `CreateSearchResponse` renamed to `CreateReservationResponse`.

##### PhoneNumberReservation

- `searchId` renamed to `reservationId`.
- `getSearchId` renamed to `getReservationId`.
- `setSearchId` renamed to `setReservationId`.

##### Phone Number Clients

- `getSearchId`renamed to `getReservationId`
- `getSearchByIdWithResponse`renamed to `getReservationByIdWithResponse`.
- `createSearchWithResponse`renamed to `createReservationWithResponse`.
- `listAllSearches`renamed to `listAllReservations`.
- `cancelSearch`renamed to `cancelReservation`.
- `cancelSearchWithResponse`renamed to `cancelReservationWithResponse`.
- Replaced`createSearch`with to `beginCreateReservation` which returns a poller for the long-running operation.
- Replaced `purchaseSearch`renamed to `beginPurchaseReservation` which returns a poller for the long-running operation.
- Replaced `releasePhoneNumber`renamed to `beginReleasePhoneNumber` which returns a poller for the long-running operation.

### Azure Communication Chat [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta3-2020-11-16)

This release contains test improvements.

### Azure Communication Common [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-common/CHANGELOG.md#100-beta3-2020-11-16)

This release contains bug fixes to improve quality.

### Azure Communication SMS [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-sms/CHANGELOG.md#100-beta3-2020-11-16)

#### New Features

- Support directly passing connection string to the SmsClientBuilder using connectionString().

#### Breaking Changes

- Removed credential(CommunicationClientCredential credential) and replaced with accessKey(String accessKey) within CommunicationIdentityClientBuilder.
  
## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
