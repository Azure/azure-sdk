---
title: Azure SDK for JavaScript (April 2021)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

<!--
@azure/communication-phone-numbers:1.0.0-beta.5
@azure/core-auth:1.3.0
@azure/communication-identity:1.0.0
@azure/core-rest-pipeline:1.0.3
@azure/core-lro:1.0.4
@azure/core-lro:1.0.5
@azure/communication-common:1.0.0
@azure/core-client:1.1.0
@azure/communication-chat:1.0.0
@azure/identity:2.0.0-beta.1
@azure/identity:2.0.0-beta.2
@azure/identity:1.3.0
@azure/cosmos:3.10.6
@azure/core-http:1.2.4
@azure/communication-sms:1.0.0
@azure/core-amqp:2.2.0
@azure/service-bus:7.0.4
@azure/core-tracing:1.0.0-preview.11
@azure/keyvault-admin:4.0.0-beta.3
@azure/keyvault-keys:4.2.0-beta.5
@azure/keyvault-certificates:4.2.0-beta.3
@azure/keyvault-secrets:4.2.0-beta.4
@azure/event-hubs:5.5.0
@azure/ai-form-recognizer:3.1.0-beta.3
@azure/app-configuration:1.2.0-beta.1
@azure/search-documents:11.2.0-beta.1
@azure/synapse-artifacts:1.0.0-beta.4
@azure/container-registry:1.0.0-beta.1
@azure/data-tables:12.0.0-beta.2
@azure/ai-anomaly-detector:3.0.0-beta.3

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to make available the April 2021 client library release.

#### GA
- Core - Auth
- Azure Communication Chat
- Azure Communication Common
- Azure Communication Identity
- Azure Communication SMS
- Core - Client
- Core - AMQP
- Event Hubs
- Identity
- Cosmos

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Core Rest Pipeline
- Core - LRO
- Core - HTTP
- Service Bus
- Cosmos DB

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Anomaly Detector
- Azure Communication Phone Numbers
- Identity
- Core - Tracing
- Key Vault - Administration
- Key Vault - Keys
- Key Vault - Certificates
- Key Vault - Secrets
- Form Recognizer
- App Configuration
- Cognitive Search
- Synapse - Artifacts
- Container Registry
- Tables

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/ai-anomaly-detector@3.0.0-beta.3
$> npm install @azure/communication-phone-numbers@1.0.0-beta.5
$> npm install @azure/core-auth@1.3.0
$> npm install @azure/communication-identity@1.0.0
$> npm install @azure/core-rest-pipeline@1.0.3
$> npm install @azure/core-lro@1.0.4
$> npm install @azure/core-lro@1.0.5
$> npm install @azure/communication-common@1.0.0
$> npm install @azure/core-client@1.1.0
$> npm install @azure/communication-chat@1.0.0
$> npm install @azure/identity@2.0.0-beta.1
$> npm install @azure/identity@2.0.0-beta.2
$> npm install @azure/identity@1.3.0
$> npm install @azure/cosmos@3.10.6
$> npm install @azure/cosmos@3.11.0
$> npm install @azure/core-rest-pipeline@1.0.2
$> npm install @azure/core-http@1.2.4
$> npm install @azure/communication-sms@1.0.0
$> npm install @azure/core-amqp@2.2.0
$> npm install @azure/service-bus@7.0.4
$> npm install @azure/core-tracing@1.0.0-preview.11
$> npm install @azure/keyvault-admin@4.0.0-beta.3
$> npm install @azure/keyvault-keys@4.2.0-beta.5
$> npm install @azure/keyvault-certificates@4.2.0-beta.3
$> npm install @azure/keyvault-secrets@4.2.0-beta.4
$> npm install @azure/event-hubs@5.5.0
$> npm install @azure/ai-form-recognizer@3.1.0-beta.3
$> npm install @azure/app-configuration@1.2.0-beta.1
$> npm install @azure/search-documents@11.2.0-beta.1
$> npm install @azure/synapse-artifacts@1.0.0-beta.4
$> npm install @azure/container-registry@1.0.0-beta.1
$> npm install @azure/data-tables@12.0.0-beta.2

```

[pattern]: # ($> npm install ${PackageName}@${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

### Anomaly Detector 3.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/ai-anomaly-detector_3.0.0-beta.3/sdk/anomalydetector/ai-anomaly-detector/CHANGELOG.md#300-beta3-2021-04-16)
- Introduced the following new APIs related to Mutivariate Models:trainMultivariateModel, getMultivariateModel, deleteMultivariateModel, detectAnomaly, getDetectionResult, exportModel, listMultivariateModel, listMultivariateModelNext.
### Core - Auth 1.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/core-auth_1.3.0/sdk/core/core-auth/CHANGELOG.md#130-2021-03-30)
- Adds the `AzureNamedKeyCredential` class which supports credential rotation and a corresponding `NamedKeyCredential` interface to support the use of static string-based names and keys in Azure clients.
- Adds the `isNamedKeyCredential` and `isSASCredential` typeguard functions similar to the existing `isTokenCredential`.

### Azure Communication Chat 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/communication-chat_1.0.0/sdk/communication/communication-chat/CHANGELOG.md#100-2021-03-29)
#### Breaking Changes

- Renamed `url` to `endpoint` in the constructors of `ChatClient` and `ChatThreadClient`.
- Renamed `ChatThread` model to `ChatThreadProperties`. Renamed `GetChatThread` operation to `GetProperties` and move to `ChatThreadClient`.
- Renamed `ChatThreadInfo` model to `ChatThreadItem`.
- Renamed parameter `repeatabilityRequestId` to `idempotencyToken`.
- Uses `ChatError` instead of `CommunicationError` in operation result.
- Move `participants` from `CreateChatThreadRequest` to `CreateChatThreadOptions`
- Updated to @azure/communication-signaling@1.0.0-beta.3.

### Azure Communication Common 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/communication-common_1.0.0/sdk/communication/communication-common/CHANGELOG.md#100-2021-03-22)
Updated `@azure/communication-common` version.

### Azure Communication Identity 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/communication-identity_1.0.0/sdk/communication/communication-identity/CHANGELOG.md#100-2021-03-29)
- Stable release of `@azure/communication-identity`.

## Release highlights
### Azure Communication Phone Numbers 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/communication-phone-numbers_1.0.0-beta.5/sdk/communication/communication-phone-numbers/CHANGELOG.md#100-beta5-2021-03-29)
#### Breaking Changes

- Renamed `AcquiredPhoneNumber` to `PurchasedPhoneNumber`.
- Renamed `getPhoneNumber` to `getPurchasedPhoneNumber` on `PhoneNumbersClient`.
- Renamed `listPhoneNumbers` to `listPurchasedPhoneNumbers` on `PhoneNumbersClient`.
- Replaced `VoidResult` with method specific interfaces `PurchasePhoneNumbersResult` and `ReleasePhoneNumberResult`.

### Azure Communication SMS 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/communication-sms_1.0.0/sdk/communication/communication-sms/CHANGELOG.md#100-2021-03-29)
- Stable release of `@azure/communication-sms`.

### Core Rest Pipeline 1.0.3 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/core-rest-pipeline_1.0.3/sdk/core/core-rest-pipeline/CHANGELOG.md#103-2021-03-30)
#### Breaking Changes

- Updated @azure/core-tracing to version `1.0.0-preview.11`. See [@azure/core-tracing CHANGELOG](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/core/core-tracing/CHANGELOG.md) for details about breaking changes with tracing.

### Core - LRO 1.0.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/core-lro_1.0.4/sdk/core/core-lro/CHANGELOG.md#104-2021-03-30)
- Bug fix: Fix an issue where we might return stale state if the `update` implementation reassigns `operation.state`.

#### Breaking Changes

- Updated @azure/core-tracing to version `1.0.0-preview.11`. See [@azure/core-tracing CHANGELOG](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/core/core-tracing/CHANGELOG.md) for details about breaking changes with tracing.

### Core - LRO 1.0.5 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/core-lro_1.0.5/sdk/core/core-lro/CHANGELOG.md#105-2021-04-12)
- No functionality changes from 1.0.4. This release is to correct an issue where 1.0.4 shipped with modules in the wrong format (cjs instead of es6.)

### Core - Client 1.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/core-client_1.1.0/sdk/core/core-client/CHANGELOG.md#110-2021-03-30)
#### Breaking Changes

- If the response body is empty and the mapper for it says it is nullable, then a null is returned.
- Updated @azure/core-tracing to version `1.0.0-preview.11`. See [@azure/core-tracing CHANGELOG](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/core/core-tracing/CHANGELOG.md) for details about breaking changes with tracing.

### CosmosDB - 3.10.6 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/cosmos_3.10.6/sdk/cosmosdb/cosmos/CHANGELOG.md#3106-2021-04-14)
#### Bugfix
- Adds partitionKey parameter to `container.conflicts.delete`'

### Cosmos DB 3.11.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/cosmos_3.11.0/sdk/cosmosdb/cosmos/CHANGELOG.md#3110-2021-04-21)
- FEATURE: Internal client update. No user facing changes, but major version bump to be safe.
### Identity 2.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/identity_2.0.0-beta.1/sdk/identity/identity/CHANGELOG.md#200-beta1-2021-03-24)
This update marks the preview for the first major version update of the `@azure/identity` package since the first stable version was released in October, 2019. This is mainly driven by the improvements we are making for the `InteractiveBrowserCredential` when used in browser applications by updating it to use the new `@azure/msal-browser` which is replacing the older `msal` package.

#### Breaking changes

- Changes to `InteractiveBrowserCredential`
  - When used in browser applications, the `InteractiveBrowserCredential` has been updated to use the [Auth Code Flow](https://docs.microsoft.com/azure/active-directory/develop/v2-oauth2-auth-code-flow) with [PKCE](https://tools.ietf.org/html/rfc7636) rather than [Implicit Grant Flow](https://docs.microsoft.com/azure/active-directory/develop/v2-oauth2-implicit-grant-flow) by default to better support browsers with enhanced security restrictions. Please note that this credential always used the Auth Code Flow when used in Node.js applications. Read more on this in our [docs on Interactive Browser Credential](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/identity/identity/interactive-browser-credential.md).
  - The default client ID used for `InteractiveBrowserCredential` was viable only in Node.js and not for the browser. Therefore, client Id is now a required parameter when constructing this credential in browser applications.
  - The `loginStyle` and `flow` options to the constructor for `InteractiveBrowserCredential` will now show up only when used in browser applications as these were never applicable to Node.js
  - Removed the `postLogoutRedirectUri` from the options to the constructor for `InteractiveBrowserCredential`. This option was not being used since we don't have a way for users to log out yet.
- When a token is not available, some credentials had the promise returned by the `getToken` method resolve with `null`, others had the `getToken` method throw the `CredentialUnavailable` error. This behavior is now made consistent across all credentials to throw the `CredentialUnavailable` error.
  - This change has no bearing on the user if all they ever did was create the credentials and pass it to the Azure SDKs.
  - This change affects only those users who called the `getToken()` method directly and did not handle resulting errors.
- The constructor for `DeviceCodeCredential` always had multiple optional parameters and no required ones. As per our guidelines, this has now been simplified to take a single optional bag of parameters.

#### New features

- Changes to `InteractiveBrowserCredential`, `DeviceCodeCredential`, `ClientSecretCredential`, `ClientCertificateCredential` and `UsernamePasswordCredential`:
  - Migrated to use the latest MSAL. This update improves caching of tokens, significantly reducing the number of network requests.
  - Added the feature of persistence caching of credentials. This is driven by the new `tokenCachePersistenceOptions` option available in the options you pass to the credential constructors.
     - For now, to use this feature, users will need to install `@azure/msal-node-extensions` [1.0.0-alpha.6](https://www.npmjs.com/package/@azure/msal-node-extensions/v/1.0.0-alpha.6) on their own. This experience will be improved in the next update.
    - This feature uses DPAPI on Windows, it tries to use the Keychain on OSX and the Keyring on Linux.
    - To learn more on the usage, please refer to our docs on the `TokenCachePersistenceOptions` interface.
    - **IMPORTANT:** As part of this beta, this feature is only supported in Node 10, 12 and 14.
- Changes to `InteractiveBrowserCredential`, `DeviceCodeCredential`, and `UsernamePasswordCredential`:
  - You can now control when the credential requests user input with the new `disableAutomaticAuthentication` option added to the options you pass to the credential constructors.
    - When enabled, this option stops the `getToken()` method from requesting user input in case the credential is unable to authenticate silently.
    - If `getToken()` fails to authenticate without user interaction, and `disableAutomaticAuthentication` has been set to true, a new error will be thrown: `AuthenticationRequired`. You may use this error to identify scenarios when manual authentication needs to be triggered (with `authenticate()`, as described in the next point).
  - A new method `authenticate()` is added to these credentials which is similar to `getToken()`, but it does not read the `disableAutomaticAuthentication` option described above.
    - Use this to get an `AuthenticationRecord` which you can then use to create new credentials that will re-use the token information.
    - The `AuthenticationRecord` object has a `serialize()` method that allows an authenticated account to be stored as a string and re-used in another credential at any time. Use the new helper function `deserializeAuthenticationRecord` to de-serialize this string.
    - `authenticate()` might succeed and still return `undefined` if we're unable to pick just one account record from the cache. This might happen if the cache is being used by more than one credential, or if multiple users have authenticated using the same Client ID and Tenant ID. To ensure consistency on a program with many users, please keep track of the `AuthenticationRecord` and provide them in the constructors of the credentials on initialization.

#### Other changes

- Updated the `@azure/msal-node` dependency to `^1.0.0`.
- `DefaultAzureCredential`'s implementation for browsers is simplified to throw the `BrowserNotSupportedError` in its constructor. Previously, we relied on getting the same error from trying to instantiate the different  credentials that `DefaultAzureCredential` supports in Node.js.
  - As before, please use only the `InteractiveBrowserCredential` in your browser applications.
- For the `InteractiveBrowserCredential` for node, replaced the use of the `express` module with a native http server for Node, shrinking the resulting identity module considerably.

### Identity 2.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/identity_2.0.0-beta.2/sdk/identity/identity/CHANGELOG.md#200-beta2-2021-04-06)

#### Breaking Changes
-  Renamed errors `CredentialUnavailable` to `CredentialUnavailableError`, and `AuthenticationRequired` to `AuthenticationRequiredError`, to align with the naming convention used for error classes in the Azure SDKs in JavaScript.
- Added `clientId` to the `AuthenticationRecord` type, alongsides the `tenantId` that this interface already had. Together they can be used to re-authenticate after recovering a previously serialized `AuthenticationRecord`.
- The `serialize()` method on the `AuthenticationRecord` object that allows an authenticated account to be stored as a string and re-used in another credential at any time, is removed in favor of a standalone function `serializeAuthenticationRecord` similar to how we have the `deserializeAuthenticationRecord` function.
- `serializeAuthenticationRecord` now serializes into a JSON string with camel case properties. This makes it re-usable across languages.
- Removed the interface `PersistentCredentialOptions` (introduced in `2.0.0-beta.1`) and instead inlined the options for the persistent cache feature in the options of individual credentials.
- Added properties `scopes` and `getTokenOptions` to the AuthenticationRequired error. These properties hold the values used by the `getToken()` method on your credential to fetch the access token. You should pass these to the `authenticate()` method on your credential if you wanted to do manual authentication after catching the `AuthenticationRequired` error.
- `InteractiveBrowserCredential` no longer supports [Implicit Grant Flow](https://docs.microsoft.com/azure/active-directory/develop/v2-oauth2-implicit-grant-flow) and will only support [Auth Code Flow](https://docs.microsoft.com/azure/active-directory/develop/v2-oauth2-auth-code-flow) instead. Therefore the `flow` option introduced in `1.2.4-beta.1` has been removed. More information from the documentation on Implicit Grant Flow:
> With the plans for [third party cookies to be removed from browsers](https://docs.microsoft.com/azure/active-directory/develop/reference-third-party-cookies-spas), the **implicit grant flow is no longer a suitable authentication method**. The [silent SSO features](https://docs.microsoft.com/azure/active-directory/develop/v2-oauth2-implicit-grant-flow#getting-access-tokens-silently-in-the-background) of the implicit flow do not work without third party cookies, causing applications to break when they attempt to get a new token. We strongly recommend that all new applications use the authorization code flow that now supports single page apps in place of the implicit flow, and that [existing single page apps begin migrating to the authorization code flow](https://docs.microsoft.com/azure/active-directory/develop/migrate-spa-implicit-to-auth-code) as well.

### Identity 1.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/identity_1.3.0/sdk/identity/identity/CHANGELOG.md#130-2021-04-05)
#### Tracing Changes
    - Updated @azure/core-tracing to version `1.0.0-preview.11`. See [@azure/core-tracing CHANGELOG](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/core/core-tracing/CHANGELOG.md) for details about breaking changes with tracing.

### Core - HTTP 1.2.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/core-http_1.2.4/sdk/core/core-http/CHANGELOG.md#124-2021-03-30)
- Rewrote `bearerTokenAuthenticationPolicy` to use a new backend that refreshes tokens only when they're about to expire and not multiple times before. This fixes the issue: [13369](https://github.com/Azure/azure-sdk-for-js/issues/13369).

#### Breaking Changes

- Updated @azure/core-tracing to version `1.0.0-preview.11`. See [@azure/core-tracing CHANGELOG](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/core/core-tracing/CHANGELOG.md) for details about breaking changes with tracing.

### Core - AMQP 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/core-amqp_2.2.0/sdk/core/core-amqp/CHANGELOG.md#220-2021-03-30)
- Updates `translateError` to convert non-object type parameters to errors.
  The parameter will be part of the error's `message` property unless the parameter is null or undefined.
  Fixes issue [14499](https://github.com/Azure/azure-sdk-for-js/issues/14499).

- Addresses issue [9988](https://github.com/Azure/azure-sdk-for-js/issues/9988)
  by updating the following operations to accept an `abortSignal` to allow cancellation:
  - CbsClient.init()
  - CbsClient.negotiateClaim()
  - RequestResponseLink.create()
- Exporting `StandardAbortMessage` that is the standard error message accompanying the `AbortError`.

### Service Bus 7.0.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/service-bus_7.0.4/sdk/servicebus/service-bus/CHANGELOG.md#704-2021-03-31)
#### Bug fixes

- `ServiceBusSessionReceiver.receiveMessages` and `ServiceBusSessionReceiver.subscribe` methods are updated to handle errors on the AMQP connection like a network disconnect in [#13956](https://github.com/Azure/azure-sdk-for-js/pull/13956). Previously, these methods only handled errors on the AMQP link or session.

  - This previously resulted in the promise returned by the `receiveMessages` method never getting fulfilled and the `subscribe` method not calling the user provided error handler.
  - The `receiveMessages` method will now throw `SessionLockLostError` when used in `peekLock` mode and return messages collected so far when used in `receiveAndDelete` mode to avoid data loss if errors on the AMQP connection are encountered.
  - When using the `subscribe`, the user provided `processError` callback will now be called with `SessionLockLostError` if errors on the AMQP connection are encountered.

- Allow null as a value for the properties in `ServiceBusMessage.applicationProperties`.
  Fixes [#14329](https://github.com/Azure/azure-sdk-for-js/issues/14329)
- Re-exports `RetryMode` for use when setting the `RetryOptions.mode` field
  in `ServiceBusClientOptions`.
  Resolves [#13166](https://github.com/Azure/azure-sdk-for-js/issues/13166).

#### Tracing updates

- Tracing options for `ServiceBusMessageBatch.tryAdd` now match the shape of `OperationOptions`.

### Core - Tracing 1.0.0-preview.11 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/core-tracing_1.0.0-preview.11/sdk/core/core-tracing/CHANGELOG.md#100-preview11-2021-03-30)
#### Breaking Changes

- Update @azure/core-tracing to version 1.0.0-preview.11. This brings core-tracing up to date with @opentelemetry/api@1.0.0-rc.0.
  There are two scenarios that will require changes if you are using tracing:
  - Previously, you would pass a parent span using the `OperationOptions.tracingOptions.spanOptions.parentSpan` property. This has been
    changed so that you now specify a parent `Context` using the `OperationOptions.tracingOptions.tracingContext` property instead.
  - The status code for Spans is no longer of type `CanonicalCode`. Instead, it's now `SpanStatusCode`, which also has a smaller range of values.
### Key Vault - Administration 4.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/keyvault-admin_4.0.0-beta.3/sdk/keyvault/keyvault-admin/CHANGELOG.md#400-beta3-2021-04-06)
- Updated the Latest service version to 7.2.
- Long Running Operations will now use the `status` field to determine whether the operation failed.
- Improved tracing across the various KeyVault libraries. By switching to a consistent naming convention, ensuring spans are always closed appropriately, and setting the correct status when an operation errors developers can expect an improved experience when enabling distributed tracing.
  - We now ensure tracing spans are properly closed with an appropriate status when an operation throws an exception.
  - If a traced operation throws an exception we will now properly record the exception message in the tracing span.
  - Finally, naming conventions have been standardized across the KeyVault libraries taking the format of `Azure.KeyVault.<PACKAGE NAME>.<CLIENT NAME>`.
- Fixed an issue where retrying a failed initial Key Vault request may result in an empty body.

### Key Vault - Keys 4.2.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/keyvault-keys_4.2.0-beta.5/sdk/keyvault/keyvault-keys/CHANGELOG.md#420-beta5-2021-04-06)
- Added local cryptography support for encryption / decryption for `A128CBCPAD`, `A192CBCPAD`, and `A256CBCPAD`.
- For AES-CBC encryption we will now generate an IV if the user did not pass it in, making `iv` optional for those parameters.
- Improved tracing across the various KeyVault libraries. By switching to a consistent naming convention, ensuring spans are always closed appropriately, and setting the correct status when an operation errors developers can expect an improved experience when enabling distributed tracing.
  - We now ensure tracing spans are properly closed with an appropriate status when an operation throws an exception.
  - If a traced operation throws an exception we will now properly record the exception message in the tracing span.
  - Finally, naming conventions have been standardized across the KeyVault libraries taking the format of `Azure.KeyVault.<PACKAGE NAME>.<CLIENT NAME>`.
- Fixed an issue where retrying a failed initial Key Vault request may result in an empty body.
- [Breaking] Removed the now unused `LocalCryptographyAlgorithmName` type (Added in 4.2.0-beta.1 to support `LocalCryptographyClient` and unused since 4.2.0-beta.4)
- Updated `CryptographyClient` to ensure that any local cryptography error is properly handled. We will now try to perform the operation locally where we can but fallback to KeyVault if the local operation fails.

### Key Vault - Certificates 4.2.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/keyvault-certificates_4.2.0-beta.3/sdk/keyvault/keyvault-certificates/CHANGELOG.md#420-beta3-2021-04-06)
- Updated the Latest service version to 7.2.
- Added a sample demonstrating how to import PFX / PEM certificates.
- Fixed an issue where importing a certificate incorrectly required a Subject or Subject Alternative Name.
- Improved tracing across the various KeyVault libraries. By switching to a consistent naming convention, ensuring spans are always closed appropriately, and setting the correct status when an operation errors developers can expect an improved experience when enabling distributed tracing.
  - We now ensure tracing spans are properly closed with an appropriate status when an operation throws an exception.
  - If a traced operation throws an exception we will now properly record the exception message in the tracing span.
  - Finally, naming conventions have been standardized across the KeyVault libraries taking the format of `Azure.KeyVault.<PACKAGE NAME>.<CLIENT NAME>`.
- Fixed an issue where retrying a failed initial Key Vault request may result in an empty body.

### Key Vault - Secrets 4.2.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/keyvault-secrets_4.2.0-beta.4/sdk/keyvault/keyvault-secrets/CHANGELOG.md#420-beta4-2021-04-06)
- Improved tracing across the various KeyVault libraries. By switching to a consistent naming convention, ensuring spans are always closed appropriately, and setting the correct status when an operation errors developers can expect an improved experience when enabling distributed tracing.
  - We now ensure tracing spans are properly closed with an appropriate status when an operation throws an exception.
  - If a traced operation throws an exception we will now properly record the exception message in the tracing span.
  - Finally, naming conventions have been standardized across the KeyVault libraries taking the format of `Azure.KeyVault.<PACKAGE NAME>.<CLIENT NAME>`.
- Fixed an issue where retrying a failed initial Key Vault request may result in an empty body.

### Event Hubs 5.5.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/event-hubs_5.5.0/sdk/eventhub/event-hubs/CHANGELOG.md#550-2021-04-06)
- Updates the methods on the `CheckpointStore` interface to accept
  an optional `options` parameter that can be used to pass in an
  `abortSignal` and `tracingOptions`.

#### New features:

- Allows passing `NamedKeyCredential` and `SASCredential` as the credential type to `EventHubConsumerClient` and `EventHubProducerClient`.
  These credential types support rotation via their `update` methods and are an alternative to using the `SharedAccessKeyName/SharedAccessKey` or `SharedAccessSignature` properties in a connection string.

#### Tracing updates

- Tracing options for `EventDataBatch.tryAdd` now match the shape of `OperationOptions`.

### Form Recognizer 3.1.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/ai-form-recognizer_3.1.0-beta.3/sdk/formrecognizer/ai-form-recognizer/CHANGELOG.md#310-beta3-2021-04-06)
- Split `FormField` into several different interfaces. This should not cause any API compatibility issues except in certain edge cases (undefined `valueType`), but should result in more accurate type refinement when dealing with FormField values and should significantly improve documentation and code hinting of these values through IntelliSense.
- Added support for recognizing identity documents (such as driver licenses and passports) through the `beginRecognizeIdDocuments` method and its URL-based counterpart `beginRecognizeIdDocumentsFromUrl`. The identity document model is prebuilt and may be used without training a model.
- Introduced two new form field value types: `"gender"` and `"country"`. These value types appear in the identity document recognition responses.
  - The `"gender"` value type signifies the gender or sex of an individual and is represented by a string that is one of three values: "M", "F", or "X".
  - The `"country"` value type indicates a specific country and is represented by a three-letter country code string (ISO 3166-1 alpha-3).
- Added support for the `pages` option to all form recognition methods (custom forms and all prebuilt models). This option works the same as in the content recognition methods, and allows for the specification of which pages within a multi-page document (PDF or TIFF formats) should be considered during analysis and included in the response.
- Added support for a `readingOrder` option to the content recognition methods. This option enables you to control the algorithm that the service uses to determine how recognized lines of text should be ordered.
- Custom model recognition now supports bitmap images through the "image/bmp" content-type (content recognition and all prebuilt models already support this content type).
- Migrated to the 2.1-preview.3 Form Recognizer service endpoint for all REST API calls.

### App Configuration 1.2.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/app-configuration_1.2.0-beta.1/sdk/appconfiguration/app-configuration/CHANGELOG.md#120-beta1-2021-04-06)
#### New Features

- New `SecretReferenceConfigurationSetting` and `FeatureFlagConfigurationSetting`types to represent configuration settings that references KeyVault Secret reference and feature flag respectively.
  [#14342](https://github.com/Azure/azure-sdk-for-js/pull/14342)
- Added `updateSyncToken` method to `AppConfigurationClient` to be able to provide external synchronization tokens.
  [#14507](https://github.com/Azure/azure-sdk-for-js/pull/14507)

### Cognitive Search 11.2.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/search-documents_11.2.0-beta.1/sdk/search/search-documents/CHANGELOG.md#1120-beta1-2021-04-06)
- Added Support for new skills such as `CustomEntityLookupSkill`, `DocumentExtractionSkill`, etc. Please refer [#14620](https://github.com/Azure/azure-sdk-for-js/pull/14620) for further details.
- Added Support for new datasource `adlsgen2`. Please refer [#14620](https://github.com/Azure/azure-sdk-for-js/pull/14620) for further details.
- Added Support for normalizers `LexicalNormalizer` & `CustomNormalizer`. Please refer [#14620](https://github.com/Azure/azure-sdk-for-js/pull/14620) for further details.

### Synapse - Artifacts 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/synapse-artifacts_1.0.0-beta.4/sdk/synapse/synapse-artifacts/CHANGELOG.md#100-beta4-2021-04-06)
- Adds ADF support
- Consume latest Code Generator changes

### Container Registry 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/container-registry_1.0.0-beta.1/sdk/containerregistry/container-registry/CHANGELOG.md#100-beta1-2021-04-06)
- Initial version of Azure Container Registry client SDK library.
- This release is a preview of our efforts to create a client library that is user friendly and
  idiomatic to the JavaScript ecosystem. The reasons for most of the changes in this update can be found in the
  [Azure SDK Design Guidelines for TypeScript](https://azure.github.io/azure-sdk/typescript_introduction.html).

### Tables 12.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/data-tables_12.0.0-beta.2/sdk/tables/data-tables/CHANGELOG.md#1200-beta2-2021-04-06)
- Update open-telemetry dependency to 1.0.0-rc.0 [#14208](https://github.com/Azure/azure-sdk-for-js/pull/14208)
- Update @azure/core-client and @azure/core-rest-pipeline dependencies to 1.0.0 [#14318](https://github.com/Azure/azure-sdk-for-js/pull/14318)


[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
