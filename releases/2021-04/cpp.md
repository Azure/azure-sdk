---
title: Azure SDK for C++ (April 2021)
layout: post
tags: C++ cpp
sidebar: releases_sidebar
repository: Azure/azure-sdk-for-cpp
---

The Azure SDK team is pleased to make available the April 2021 client library release.

#### Beta

- Azure Core
- Azure Identity
- Azure Key Vault Common
- Azure Key Vault

## Installation Instructions

To install any of our packages, copy and paste the following commands into a terminal:

```bash

# From Source
git clone https://github.com/Azure/azure-sdk-for-cpp
# git checkout <tag_name>
# For example:
git checkout azure-security-keyvault-keys_4.0.0-beta.1
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/Azure/azure-sdk-for-cpp/issues).

## Release highlights

### azure-core [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/core/azure-core/CHANGELOG.md#100-beta8-2021-04-07)

#### New Features

- Added `Azure::Core::Url::GetScheme()`.
- Added `Azure::Core::Context::TryGetValue()`.
- Added `Azure::Core::Context::GetDeadline()`.
- Added `Azure::Core::Credentials::TokenCredentialOptions`.
- Added useful fields to the `Azure::Core::RequestFailedException` class such as `StatusCode`, `ReasonPhrase`, and the `RawResponse`, for better diagnosis of errors.

#### Breaking Changes

- Simplified the `Response<T>` API surface to expose two public fields with direct access: `T Value` and a `unique_ptr` to an `Azure::Core::Http::RawResponse`.
- Renamed `Azure::Nullable<T>::GetValue()` to `Value()`.
- Removed from `Azure::Core::Http::Request`:
  - `SetUploadChunkSize()`.
  - `GetHTTPMessagePreBody()`.
  - `GetUploadChunkSize()`.
  - `GetHeadersAsString()`.
- Changes to `Azure::Core::Http::RawResponse`:
  - Removed `SetHeader(std::string const& header)`
  - Removed `SetHeader(uint8_t const* const first, uint8_t const* const last)`.
  - Removed `GetMajorVersion()`.
  - Removed `GetMinorVersion()`.
  - Renamed `GetBodyStream()` to `ExtractBodyStream()`.
- Changes to `Azure::Core::Context`:
  - Removed `Get()` and `HasKey()` in favor of a new method `TryGetValue()`.
  - Changed input parameter type of `WithDeadline()` to `Azure::DateTime`.
- Removed `Azure::Core::PackageVersion`.
- Removed from `Azure::Core::Http::Policies` namespace: `HttpPolicyOrder`, `TransportPolicy`, `RetryPolicy`, `RequestIdPolicy`, `TelemetryPolicy`, `BearerTokenAuthenticationPolicy`, `LogPolicy`.
- Removed `AppendQueryParameters()`, `GetUrlWithoutQuery()` and `GetUrlAuthorityWithScheme()` from `Azure::Core::Url`.
- Changed the `Azure::Core::Http::HttpMethod` regular enum into an extensible enum class and removed the `HttpMethodToString()` helper method.
- Introduced `Azure::Core::Context::Key` class which takes place of `std::string` used for `Azure::Core::Context` keys previously.
- Changed the casing of `SSL` in API names to `Ssl`:
  - Renamed type `Azure::Core::Http::CurlTransportSSLOptions` to `CurlTransportSslOptions`.
  - Renamed member `Azure::Core::Http::CurlTransportOptions::SSLOptions` to `SslOptions`.
  - Renamed member `Azure::Core::Http::CurlTransportOptions::SSLVerifyPeer` to `SslVerifyPeer`.

#### Other Changes and Improvements

- Moved `Azure::Core::Http::Request` to its own header file from `http.hpp` to `inc/azure/core/http/raw_response.hpp`.
- Moved `Azure::Core::Http::HttpStatusCode` to its own header file from `http.hpp` to `inc/azure/core/http/http_status_code.hpp`.

### azure-identity [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/identity/azure-identity/CHANGELOG.md#100-beta5-2021-04-07)

#### New Features

- Add Active Directory Federation Service (ADFS) support to `ClientSecretCredential`.

#### Breaking Changes

- Removed `Azure::Identity::PackageVersion`.

### azure-security-keyvault-common [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/azure-security-keyvault-common_4.0.0-beta.1/sdk/keyvault/azure-security-keyvault-common/CHANGELOG.md#400-beta1-2021-04-07)

#### New Features

- KeyVaultException.

### azure-security-keyvault-keys [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#400-beta1-2021-04-07)

#### New Features

- Added `Azure::Security::KeyVault::Keys::KeyClient` for get, create, list, delete, backup, restore, and import key operations.
- Added high-level and simplified `key_vault.hpp` file for simpler include experience for customers.
- Added model types which are returned from the `KeyClient` operations, such as `Azure::Security::KeyVault::Keys::KeyVaultKey`.

## Latest Releases

View all the latest versions of C++ packages [here][cpp-latest-releases].

{% include refs.md %}
