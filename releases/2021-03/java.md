---
title: Azure SDK for Java (March 2021)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

<!--
[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to announce our March 2021 client library releases.

#### GA

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta

- Azure Communication Common
- Azure Communication Identity
- Azure Communication Chat
- Azure Communication Phone Numbers
- Azure Communication SMS

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-chat</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-common</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-identity</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-phonenumbers</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-sms</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>


```

[pattern]: # (<dependency>`n  <groupId>${GroupId}</groupId>`n  <artifactId>${PackageName}</artifactId>`n  <version>${PackageVersion}</version>`n</dependency>`n`n)

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights

### Azure Communication Administration is deprecated

- Phone number administration will be moved into a new package Azure Communication Phone Numbers.

### Azure Communication Phone Numbers 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-phonenumbers/CHANGELOG.md#100-beta6-2021-03-09)

#### New Features

- Added `PhoneNumbersClient` and `PhoneNumbersAsyncClient` (originally was part of the `azure.communication.administration` package).
- Added support for Azure Active Directory Authentication.

#### Breaking Changes

- `PhoneNumberAsyncClient` has been replaced with `PhoneNumbersAsyncClient`, which has the same functionality but different APIs. To learn more about how PhoneNumbersAsyncClient works, refer to the [README.md](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-phonenumbers/README.md).
- `PhoneNumberClient` has been replaced with `PhoneNumbersClient`, which has the same functionality but different APIs. To learn more about how PhoneNumbersClient works, refer to the [README.md](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-phonenumbers/README.md).





### Azure Communication Common 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-common/CHANGELOG.md#100-beta6-2021-03-09)

#### Breaking Changes

- Renamed `CommunicationTokenRefreshOptions.getRefreshProactively()` to `CommunicationTokenRefreshOptions.isRefreshProactively()`
- Constructor for `CommunicationCloudEnvironment` has been removed and now to set an environment value, the `fromString()` method must be called
- `CommunicationCloudEnvironment`, `CommunicationTokenRefreshOptions `, `CommunicationUserIdentifier`, `MicrosoftTeamsUserIdentifier`,
`PhoneNumberIdentifier`, `UnknownIdentifier`, are all final classes now.

### Azure Communication Chat  1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta6-2021-03-09)

#### New Features

- Updated azure-communication-chat version


### Azure Communication Identity 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-identity/CHANGELOG.md#100-beta6-2021-03-09)

#### New Features

- Added a retryPolicy() chain method to the `CommunicationIdentityClientBuilder`.

#### Breaking Changes

- `CommunicationIdentityClient.createUserWithToken` and `CommunicationIdentityAsyncClient.createUserWithToken` have been renamed to
`CommunicationIdentityClient.createUserAndToken` and `CommunicationIdentityAsyncClient.createUserAndToken`.
- `CommunicationIdentityClient.createUserWithTokenWithResponse` and `CommunicationIdentityAsyncClient.createUserWithTokenWithResponse` have been renamed to
`CommunicationIdentityClient.createUserAndTokenWithResponse` and `CommunicationIdentityAsyncClient.createUserAndTokenWithResponse`.
- `CommunicationUserIdentifierWithTokenResult` class has been renamed to `CommunicationUserIdentifierAndToken`.


### Azure Communication SMS 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-sms/CHANGELOG.md#100-beta4-2021-03-09)

#### New Features

- Added Azure Active Directory authentication support
- Support for creating SmsClient with TokenCredential.
- Added support for 1:N SMS messaging.
- Added support for tagging SMS messages.
- Send method series in SmsClient are idempotent under retry policy.
- Added `SmsOptions`

#### Breaking Changes

- Updated `public Mono<SendSmsResponse> sendMessage(PhoneNumberIdentifier from, PhoneNumberIdentifier to, String message)` to `public Mono<SendSmsResponse> send(String from, String to, String message)`.
- Updated `public Mono<Response<SendSmsResponse>> sendMessageWithResponse(PhoneNumberIdentifier from,List<PhoneNumberIdentifier> to, String message, SendSmsOptions smsOptions, Context context)` to `Mono<Response<SmsSendResult>> sendWithResponse(String from, String to, String message, SmsSendOptions options, Context context)`.
- Replaced `SendSmsResponse` with `SmsSendResult`.



## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
