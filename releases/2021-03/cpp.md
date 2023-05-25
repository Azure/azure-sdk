---
title: Azure SDK for C++ (March 2021)
layout: post
tags: C++ cpp
sidebar: releases_sidebar
repository: Azure/azure-sdk-for-cpp
---

The Azure SDK team is pleased to make available the March 2021 client library release.

#### Beta

- Azure Core
- Azure Identity

## Installation Instructions

To install any of our packages, copy and paste the following commands into a terminal:

```bash

# From Source
git clone https://github.com/Azure/azure-sdk-for-cpp
# git checkout <tag_name>
# For example:
git checkout azure-core_1.0.0-beta.7
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/Azure/azure-sdk-for-cpp/issues).

## Release highlights

### azure-core [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/azure-core_1.0.0-beta.7/sdk/core/azure-core/CHANGELOG.md#100-beta7-2021-03-11)

#### New Features

- Added `HttpPolicyOrder` for adding custom Http policies to SDK clients.
- Added `Azure::Core::Operation<T>::GetRawResponse()`.
- Added `Azure::Core::PackageVersion`.
- Added support for logging to console when `AZURE_LOG_LEVEL` environment variable is set.

#### Breaking Changes

- Changes to `Azure::Core` namespace:
  - Removed `Response<void>`, `ValueBase`, and `ContextValue`.
  - Removed `Context::operator[]`, `Get()` introduced instead.
  - Renamed `Uuid::GetUuidString()` to `ToString()`.
  - Changed return type of `Operation<T>::Poll()` from `std::unique_ptr<RawResponse>` to `RawResponse const&`.
  - Moved `GetApplicationContext()` to `Context::GetApplicationContext()`
  - Moved the `Base64Encode()` and `Base64Decode()` functions to be static members of a `Convert` class.
  - Moved `Logging` namespace entities to `Diagnostics::Logger` class.
  - Moved `AccessToken`, `TokenCredential`, and `AuthenticationException` to `Credentials` namespace.
  - Moved `Context` to be the last parameter for consistency, instead of first in various azure-core types. For example:
    - `BodyStream::Read(uint8_t* buffer, int64_t count, Context const& context)`
    - `BodyStream::ReadToEnd(BodyStream& body, Context const& context)`
    - `HttpPolicy::Send(Request& request, NextHttpPolicy policy, Context const& context)`
    - `Operation<T>::PollUntilDone(std::chrono::milliseconds period, Context& context)`
    - `TokenCredential::GetToken(Http::TokenRequestOptions const& tokenRequestOptions, Context const& context)`
  - Moved from `Azure::Core` to `Azure` namespace:
    - `Response<T>`, `ETag`, and `Nullable<T>`.
    - Split `RequestConditions` into `MatchConditions` and `ModifiedConditions`.
    - Renamed `DateTime::GetString()` to `ToString()`, and removed `DateTime::GetRfc3339String()`.
- Changes to `Azure::Core::Http` namespace:
  - Removed `HttpPipeline`, `TransportKind`, `NullBodyStream`, and `LimitBodyStream`.
  - Removed `Request::StartTry()`.
  - Removed `InvalidHeaderException` and throw `std::invalid_argument` if the user provides invalid header arguments.
  - Renamed `CurlTransportSSLOptions::NoRevoke` to `EnableCertificateRevocationListCheck`.
  - Renamed `Range` to `HttpRange`.
  - Renamed `TokenRequestOptions` to `TokenRequestContext`, and moved it to `Azure::Core::Credentials` namespace.
  - Moved `Url` to `Azure::Core` namespace.
  - `Request` and `RawResponse`:
    - Renamed `AddHeader()` to `SetHeader()`.
    - Introduced `Azure::Core::CaseInsensitiveMap` which is now used to store headers.
  - `BodyStream` and the types that derive from it:
    - Moved to `Azure::Core::IO` namespace.
    - Changed the static methods `BodyStream::ReadToCount()` and `BodyStream::ReadToEnd()` into instance methods.
    - Changed the constructor of `FileBodyStream` to accept a file name directly and take ownership of opening/closing the file, instead of accepting a file descriptor, offset, and length.
  - HTTP policies and their options:
    - Moved to `Policies` namespace.
    - Renamed `TransportPolicyOptions` to `TransportOptions`.
    - Renamed `TelemetryPolicyOptions` to `TelemetryOptions`.
    - Changed type of `RetryOptions::StatusCodes` from `std::vector` to `std::set`.
    - Renamed `LoggingPolicy` to `LogPolicy`, and introduced `LogOptions` as mandatory parameter for the constructor.
- Moved header files:
  - Renamed `azure/core/credentials.hpp` to `azure/core/credentials/credentials.hpp`.
  - Renamed `azure/core/logger.hpp` to `azure/core/diagnostics/logger.hpp`.
  - Renamed `azure/core/http/body_stream.hpp` to `azure/core/io/body_stream.hpp`.
  - Renamed `azure/core/http/policy.hpp` to `azure/core/http/policies/policy.hpp`.
  - Renamed `azure/core/http/curl/curl.hpp` to `azure/core/http/curl_transport.hpp`.
  - Renamed `azure/core/http/winhttp/win_http_client.hpp` to `azure/core/http/win_http_transport.hpp`.

#### Bug Fixes

- Make sure to rewind the body stream at the start of each request retry attempt, including the first.
- Connection pool resets when all connections are closed.
- Fix `Azure::Context` to support `std::unique_ptr`.
- Throw `std::runtime_error` from `Response<T>::GetRawResponse()` if the response was already extracted.


### azure-identity [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/azure-identity_1.0.0-beta.4/sdk/identity/azure-identity/CHANGELOG.md#100-beta4-2021-03-11)

#### New Features

- Added `Azure::Identity::PackageVersion`.

#### Breaking Changes

- Removed `TransportPolicyOptions` from `ClientSecretCredentialOptions`. Updated the options to derive from `ClientOptions`.

## Latest Releases

View all the latest versions of C++ packages [here][cpp-latest-releases].

{% include refs.md %}
