---
title: Azure SDK for JavaScript (February 2021)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

<!--
@azure/communication-chat:1.0.0-beta.4
@azure/quantum-jobs:1.0.0-beta.1
@azure/event-hubs:5.4.0
@azure/core-https:1.0.0-beta.1
@azure/storage-file-datalake:12.4.0-beta.1
@azure/communication-common:1.0.0-beta.5
@azure/communication-identity:1.0.0-beta.4
@azure/storage-blob:12.4.1
@azure/data-tables:1.0.0-beta.5
@azure/keyvault-admin:4.0.0-beta.2
@azure/keyvault-keys:4.2.0-beta.3
@azure/synapse-spark:1.0.0-beta.2
@azure/core-xml:1.0.0-beta.1
@azure/ai-form-recognizer:3.1.0-beta.2
@azure/synapse-monitoring:1.0.0-beta.2
@azure/synapse-artifacts:1.0.0-beta.2
@azure/keyvault-certificates:4.2.0-beta.2
@azure/monitor-opentelemetry-exporter:1.0.0-beta.3
@azure/core-amqp:2.1.0
@azure/ai-text-analytics:5.1.0-beta.4
@azure/storage-queue:12.3.1
@azure/core-http:1.2.3
@azure/synapse-managed-private-endpoints:1.0.0-beta.2
@azure/core-client:1.0.0-beta.1
@azure/keyvault-secrets:4.2.0-beta.2
@azure/storage-blob:12.5.0-beta.1
@azure/identity:1.2.3
@azure/ai-metrics-advisor:1.0.0-beta.3
@azure/synapse-access-control:1.0.0-beta.2
@azure/core-auth:1.2.0
@azure/storage-file-share:12.4.1
@azure/storage-file-datalake:12.3.1

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to make available the February 2021 client library release.

#### GA
- Event Hubs
- Core - AMQP
- Core - Auth

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Storage - Blobs
- Storage - Queues
- Core - HTTP
- Identity
- Storage - Files Shares
- Storage - Files Data Lake

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Communication Chat
- @azure/quantum-jobs
- Core - Https
- Storage - Files Data Lake
- Communication Common
- Communication Identity
- Tables
- Key Vault - Administration
- Key Vault - Keys
- Synapse - Spark
- Core - XML
- Form Recognizer
- Synapse - Monitoring
- Synapse - Artifacts
- Key Vault - Certificates
- Monitor Exporter for OpenTelemetry
- Text Analytics
- Synapse - Managed Private Endpoints
- Core - Client
- Key Vault - Secrets
- Storage - Blobs
- Metrics Advisor
- Synapse - AccessControl

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/communication-chat@1.0.0-beta.4
$> npm install @azure/quantum-jobs@1.0.0-beta.1
$> npm install @azure/event-hubs@5.4.0
$> npm install @azure/core-https@1.0.0-beta.1
$> npm install @azure/storage-file-datalake@12.4.0-beta.1
$> npm install @azure/communication-common@1.0.0-beta.5
$> npm install @azure/communication-identity@1.0.0-beta.4
$> npm install @azure/storage-blob@12.4.1
$> npm install @azure/data-tables@1.0.0-beta.5
$> npm install @azure/keyvault-admin@4.0.0-beta.2
$> npm install @azure/keyvault-keys@4.2.0-beta.3
$> npm install @azure/synapse-spark@1.0.0-beta.2
$> npm install @azure/core-xml@1.0.0-beta.1
$> npm install @azure/ai-form-recognizer@3.1.0-beta.2
$> npm install @azure/synapse-monitoring@1.0.0-beta.2
$> npm install @azure/synapse-artifacts@1.0.0-beta.2
$> npm install @azure/keyvault-certificates@4.2.0-beta.2
$> npm install @azure/monitor-opentelemetry-exporter@1.0.0-beta.3
$> npm install @azure/core-amqp@2.1.0
$> npm install @azure/ai-text-analytics@5.1.0-beta.4
$> npm install @azure/storage-queue@12.3.1
$> npm install @azure/core-http@1.2.3
$> npm install @azure/synapse-managed-private-endpoints@1.0.0-beta.2
$> npm install @azure/core-client@1.0.0-beta.1
$> npm install @azure/keyvault-secrets@4.2.0-beta.2
$> npm install @azure/storage-blob@12.5.0-beta.1
$> npm install @azure/identity@1.2.3
$> npm install @azure/ai-metrics-advisor@1.0.0-beta.3
$> npm install @azure/synapse-access-control@1.0.0-beta.2
$> npm install @azure/core-auth@1.2.0
$> npm install @azure/storage-file-share@12.4.1
$> npm install @azure/storage-file-datalake@12.3.1

```

[pattern]: # ($> npm install ${PackageName}@${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Release highlights
### Communication Chat 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/communication-chat_1.0.0-beta.4/sdk/communication/@azure/communication-chat/CHANGELOG.md#100-beta4-2021-02-09)
#### Breaking Changes

- Updated to @azure/communication-common@1.0.0-beta.5. Now uses `CommunicationUserIdentifier` in place of `CommunicationUser`, and `CommunicationTokenCredential` instead of `CommunicationUserCredential`.
- Removed `priority` field from `ChatMessage`.

#### Added

- Added support for `CreateChatThreadResult` and `AddChatParticipantsResult` to handle partial errors in batch calls.
- Added idempotency identifier parameter for chat creation calls.
- Added support for `listReadReceipts` and `listParticipants` pagination.
- Added new model for messages an content types : `Text`, `Html`, `ParticipantAdded`, `ParticipantRemoved`, `TopicUpdated`.
- Added new model for errors (`CommunicationError`)
- Added notifications for thread level changes.

### @azure/quantum-jobs 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/quantum-jobs_1.0.0-beta.1/sdk/quantum/@azure/quantum-jobs/CHANGELOG.md#100-beta1-2021-02-05)
Initial public preview of the @azure/quantum-jobs library.

### Event Hubs 5.4.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/event-hubs_5.4.0/sdk/eventhub/@azure/event-hubs/CHANGELOG.md#540-2021-02-09)
- Adds the `customEndpointAddress` field to `EventHubClientOptions`.
  This allows for specifying a custom endpoint to use when communicating
  with the Event Hubs service, which is useful when your network does not
  allow communicating to the standard Event Hubs endpoint.
  Resolves [#12901](https://github.com/Azure/azure-sdk-for-js/issues/12901).

- A helper method `parseEventHubConnectionString` has been added which validates and
  parses a given connection string for Azure Event Hubs.
  Resolves [#11894](https://github.com/Azure/azure-sdk-for-js/issues/11894)

- Re-exports `RetryMode` for use when setting the `RetryOptions.mode` field
  in `EventHubConsumerClientOptions` or `EventHubClientOptions`.
  Resolves [#13166](https://github.com/Azure/azure-sdk-for-js/issues/13166).

- Updates documentation for `EventData` to call out that the `body` field
  must be converted to a byte array or `Buffer` when cross-language
  compatibility while receiving events is required.

### Core - Https 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/core-https_1.0.0-beta.1/sdk/core/@azure/core-https/CHANGELOG.md#100-beta1-2021-02-04)
- Changes from `core-http`:
  - First release of new Pipeline model, see README for details.
  - ServiceClient and related AutoRest functionality moved out to `core-client`.
  - XML functionality moved out to `core-xml`.
  - Removal of node-fetch dependency.
  - Switched to use `https-proxy-agent` for proxy support.
  - Dropped IE support.
  - Stopped exporting various helper/utility methods.
  - All function parameters are now interfaces.
  - Remove rpRegistrationPolicy.
  - Remove keepAlivePolicy
  - Let clients add ndJsonPolicy manually
  - Disable redirects by removing the policy instead of an option
  - Invert response decompression policy
  - Remove request cloning, to optimize pipeline allocations.
- Add ms-cv header used as correlation vector (used for distributed tracing) to list of non-redacted headers so that clients can share this header for debugging purposes. [PR 13541](https://github.com/Azure/azure-sdk-for-js/pull/13541)

### Storage - Files Data Lake 12.4.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/storage-file-datalake_12.4.0-beta.1/sdk/storage/@azure/storage-file-datalake/CHANGELOG.md#1240-beta1-2021-02-09)
- Added support for Container Soft Delete. You can restore a deleted filesystem via `DataLakeServiceClient.undeleteFileSystem()`. And the `DataLakeServiceClient.listFileSystems()` now support an `includeDeleted` option to include soft deleted filesystems in the response.
- Added `fromConnectionString` to `DataLakeServiceClient` to support construction from a connection string. Fixed bug [13396](https://github.com/Azure/azure-sdk-for-js/issues/13396).

### Communication Common 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/communication-common_1.0.0-beta.5/sdk/communication/@azure/communication-common/CHANGELOG.md#100-beta5-2021-02-09)
#### Breaking Changes

- Removed `CallingApplicationIdentifier` and `isCallingApplicationIdentifier`.
- Removed `id` from `CommunicationUserIdentifier`.
- Renamed `id` to `rawId` in `PhoneNumberIdentifier`.
- Renamed `id` to `rawId` in `MicrosoftTeamsUserIdentifier`.

### Communication Identity 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/communication-identity_1.0.0-beta.4/sdk/communication/@azure/communication-identity/CHANGELOG.md#100-beta4-2021-02-09)
#### Added

- Added `CommunicationIdentityClient` (originally part of the `@azure/communication-administration` package).
- `CommunicationIdentityClient` added a constructor that supports `TokenCredential`.
- `CommunicationIdentityClient` added a new method `createUserWithToken`.

#### Breaking Changes

- Replaced `CommunicationUser` with `CommunicationUserIdentifier`.
- `CommunicationIdentityClient` method `revokeTokens` no longer accepts `tokensValidFrom` as an argument.
- `pstn` is removed from `TokenScope`
- `issueToken` no longer returns the `CommunicationUser` alongside the token.

### Storage - Blobs 12.4.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/storage-blob_12.4.1/sdk/storage/@azure/storage-blob/CHANGELOG.md#1241-2021-02-03)
- Fixed a compile failure due to "Can't resolve 'crypto'" in Angular. [Issue #13267](https://github.com/Azure/azure-sdk-for-js/issues/13267).
- Fixed an issue that the download stream returned by `BlobClient.download` won't release underlying resources unless it's fully consumed. [Isssue #11850](https://github.com/Azure/azure-sdk-for-js/issues/11850).
- Fixed an error when listing blob with a metadata key of `_` [issue #9197](https://github.com/Azure/azure-sdk-for-js/issues/9171)
- The `"Unclosed root tag"` XML parser error is now retriable. [PR #13076](https://github.com/Azure/azure-sdk-for-js/pull/13076).

### Tables 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/data-tables_1.0.0-beta.5/sdk/tables/@azure/data-tables/CHANGELOG.md#100-beta5-2021-02-09)
- Move generated client to use @azure/core-https. For more information about Core V2 read [here](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/core#core-v1-and-core-v2). [#12548](https://github.com/Azure/azure-sdk-for-js/pull/12548)

### Key Vault - Administration 4.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/keyvault-admin_4.0.0-beta.2/sdk/keyvault/@azure/keyvault-admin/CHANGELOG.md#400-beta2-2021-02-09)
- [Breaking] Removed `dist-browser` from the published package. To bundle the Azure SDK libraries for the browsers, please read our bundling guide: [link](https://github.com/Azure/azure-sdk-for-js/blob/master/documentation/Bundling.md).
- Updated the Key Vault Admin Long Running Operation Pollers to follow a more compact and meaningful approach moving forward.
- Bug fix: The logging of HTTP requests wasn't properly working - now it has been fixed and tests have been written that verify the fix.
- [Breaking] Return `BackupResult` and `RestoreResult` from backup/restore long running operations which will contain additional information about the operation as well any relevant data.
- Backup / Restore polling will now correctly propagate any errors to the awaited call.
- Add support for custom role definitions - creating, updating, and deleting role definitions are now supported.

### Key Vault - Keys 4.2.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/keyvault-keys_4.2.0-beta.3/sdk/keyvault/@azure/keyvault-keys/CHANGELOG.md#420-beta3-2021-02-09)
- [Breaking] Removed `dist-browser` from the published package. To bundle the Azure SDK libraries for the browsers, please read our bundling guide: [link](https://github.com/Azure/azure-sdk-for-js/blob/master/documentation/Bundling.md).
- Updated the Key Vault Keys Long Running Operation Pollers to follow a more compact and meaningful approach moving forward.
- Bug fix: The logging of HTTP requests wasn't properly working - now it has been fixed and tests have been written that verify the fix.
- Added a constructor overload to `CryptographyClient` that takes a `JsonWebKey` and allows for local-only subset of operations.
- Added `KeyId` to the public API of CryptographyClient.
- [Breaking] Removed `parseKeyVaultKeysId` from the public API and made `KeyOptionsOptions.additionalAuthenticatedData` a readonly property.
- Added a `createOctKey` convenience method to create a key of type `oct` or `oct-HSM` as appropriate.

### Synapse - Spark 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/synapse-spark_1.0.0-beta.2/sdk/synapse/@azure/synapse-spark/CHANGELOG.md#100-beta2-2021-02-09)
- Regenerated from the latest REST API
- Added Spark example to README

### Core - XML 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/core-xml_1.0.0-beta.1/sdk/core/@azure/core-xml/CHANGELOG.md#100-beta1-2021-02-04)
- First release of package. Exported XML helpers for client packages that need XML support, see README.md for details.

### Form Recognizer 3.1.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/ai-form-recognizer_3.1.0-beta.2/sdk/formrecognizer/@azure/ai-form-recognizer/CHANGELOG.md#310-beta2-2021-02-09)
- Renamed `Appearance` to `TextAppearance`, `Style` to `TextStyle` (previously the name of the enum for `Style.name`, and the `TextStyle` enum to `StyleName` for the sake of clarity in the type names.
- Added `KnownStyleName`, `KnownLanguage`, `KnownSelectionMarkState`, and `KnownKeyValueType` enums to access the well-known possible values of the `StyleName`, `Language`, `SelectionMarkState`, and `KeyValueType` parameters/fields respectively.

### Synapse - Monitoring 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/synapse-monitoring_1.0.0-beta.2/sdk/synapse/@azure/synapse-monitoring/CHANGELOG.md#100-beta2-2021-02-09)
- Regenerated from the latest REST API

### Synapse - Artifacts 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/synapse-artifacts_1.0.0-beta.2/sdk/synapse/@azure/synapse-artifacts/CHANGELOG.md#100-beta2-2021-02-09)
- Regenerated from the latest REST API

### Key Vault - Certificates 4.2.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/keyvault-certificates_4.2.0-beta.2/sdk/keyvault/@azure/keyvault-certificates/CHANGELOG.md#420-beta2-2021-02-09)
- [Breaking] Removed `dist-browser` from the published package. To bundle the Azure SDK libraries for the browsers, please read our bundling guide: [link](https://github.com/Azure/azure-sdk-for-js/blob/master/documentation/Bundling.md).
- Updated the Key Vault Certificates Long Running Operation Pollers to follow a more compact and meaningful approach moving forward.
- Bug fix: The logging of HTTP requests wasn't properly working - now it has been fixed and tests have been written that verify the fix.
- [Breaking] Removed `parseKeyVaultCertificatesIdentifier` from the public API.

### Monitor Exporter for OpenTelemetry 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/monitor-opentelemetry-exporter_1.0.0-beta.3/sdk/monitor/@azure/monitor-opentelemetry-exporter/CHANGELOG.md#100-beta3-2021-02-10)
- Rename package to `@azure/monitor-opentelemetry-exporter`
- Added serviceApiVersion config
- Open Telemetry dependency updates

### Core - AMQP 2.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/core-amqp_2.1.0/sdk/core/@azure/core-amqp/CHANGELOG.md#210-2021-02-08)
- Fixes the bug reported in issue [13048](https://github.com/Azure/azure-sdk-for-js/issues/13048).
  Now an informative error is thrown describing the circumstance that led to the error.
- Adds the ability to configure the `amqpHostname` and `port` that a `ConnectionContextBase` will use when connecting to a service.
  The `host` field refers to the DNS host or IP address of the service, whereas the `amqpHostname`
  is the fully qualified host name of the service. Normally `host` and `amqpHostname` will be the same.
  However if your network does not allow connecting to the service via the public host,
  you can specify a custom host (e.g. an application gateway) via the `host` field and continue
  using the public host as the `amqpHostname`.

### Text Analytics 5.1.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/ai-text-analytics_5.1.0-beta.4/sdk/textanalytics/@azure/ai-text-analytics/CHANGELOG.md#510-beta4-2021-02-10)
- [Breaking] `beginAnalyzeHealthcare` is renamed to `beginAnalyzeHealthcareEntities`.
- [Breaking] `beginAnalyze` is renamed to `beginAnalyzeBatchActions`.
- A new option to control how the offset is calculated by the service, `stringIndexType`, is added to `analyzeSentiment`, `recognizeEntities`, `recognizePiiEntities`, and `beginAnalyzeHealthcareEntities`. Furthermore, `stringIndexType` is added to task types `RecognizeEntitiesAction` and `RecognizePiiEntitiesAction`, which are the types of input actions to the `beginAnalyzeBatchActions` method. For more information, see [the Text Analytics documentation](https://docs.microsoft.com/azure/cognitive-services/text-analytics/concepts/text-offsets#offsets-in-api-version-31-preview).
- [Breaking] The healthcare entities returned by `beginAnalyzeHealthcare` are now organized as a directed graph where the edges represent a certain type of healthcare relationship between the source and target entities. Edges are stored in the `relatedEntities` property.
- [Breaking] The `links` property of `HealthcareEntity` is renamed to `dataSources`, a list of objects representing medical databases, where each object has `name` and `entityId` properties.
- The poller for the `beginAnalyzeBatchActions` long-running operation gained the ability to return certain metadata information about the currently running operation (e.g., when the operation was created, will be expired, and last time it was updated, and also how many actions completed and failed so far). Also, the poller for `beginAnalyzeHealthcareEntities` gained a similar ability.
- [Breaking] the words "operation" and "action" are used consistently in our names and documentation instead of "job" and "task" respectively.

### Storage - Queues 12.3.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/storage-queue_12.3.1/sdk/storage/@azure/storage-queue/CHANGELOG.md#1231-2021-02-03)
- The `"Unclosed root tag"` XML parser error is now retriable. [PR #13076](https://github.com/Azure/azure-sdk-for-js/pull/13076).

### Core - HTTP 1.2.3 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/core-http_1.2.3/sdk/core/@azure/core-http/CHANGELOG.md#123-2021-02-04)
- Don't set a default content-type when there is no request body. [PR 13233](https://github.com/Azure/azure-sdk-for-js/pull/13233)
- Clean up abort event handler properly for streaming operations. Fixed [issue 12029](https://github.com/Azure/azure-sdk-for-js/issues/12029)
- Reduce memory usage of the cache in proxy policy. Fixed [issue 13277](https://github.com/Azure/azure-sdk-for-js/issues/13277)
- Fix an issue where non-streaming response body was treated as stream [PR 13192](https://github.com/Azure/azure-sdk-for-js/pull/13192)
- Browser XML parser now lazily load parser error namespace into cache. Fixed [issue 13268](https://github.com/Azure/azure-sdk-for-js/issues/13268)
- Add ms-cv header used as correlation vector (used for distributed tracing) to list of non-redacted headers so that clients can share this header for debugging purposes. [PR 13541](https://github.com/Azure/azure-sdk-for-js/pull/13541)

### Synapse - Managed Private Endpoints 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/synapse-managed-private-endpoints_1.0.0-beta.2/sdk/synapse/@azure/synapse-managed-private-endpoints/CHANGELOG.md#100-beta2-2021-02-09)
- Regenerated from the latest REST API

### Core - Client 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/core-client_1.0.0-beta.1/sdk/core/@azure/core-client/CHANGELOG.md#100-beta1-2021-02-04)
- First release of package, see README.md for details.
- Changes from related functionality in `core-http`:
  - Replace URLBuilder with runtime-supported URL primitive.
  - Rewrite `ServiceClient` on top of `core-https` and remove unused codepaths.
  - Remove `_response` on operation results and replace with `onResponse` callback.

### Key Vault - Secrets 4.2.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/keyvault-secrets_4.2.0-beta.2/sdk/keyvault/@azure/keyvault-secrets/CHANGELOG.md#420-beta2-2021-02-09)
- [Breaking] Removed `dist-browser` from the published package. To bundle the Azure SDK libraries for the browsers, please read our bundling guide: [link](https://github.com/Azure/azure-sdk-for-js/blob/master/documentation/Bundling.md).
- Updated the Key Vault Secrets Long Running Operation Pollers to follow a more compact and meaningful approach moving forward.
- Bug fix: The logging of HTTP requests wasn't properly working - now it has been fixed and tests have been written that verify the fix.

### Storage - Blobs 12.5.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/storage-blob_12.5.0-beta.1/sdk/storage/@azure/storage-blob/CHANGELOG.md#1250-beta1-2021-02-09)
- Now support Batch operations scoped to the Container level. You can use `ContainerClient.getBlobBatchClient()` to get such a `BlobBatchClient`.

### Identity 1.2.3 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/identity_1.2.3/sdk/identity/@azure/identity/CHANGELOG.md#123-2021-02-09)
- Fixed Azure Stack support for the NodeJS version of the `InteractiveBrowserCredential`.
- The 'keytar' dependency has been updated to the latest version.
- No longer overrides global Axios defaults. This includes an update in `@azure/identity`'s source, and an update of the `@azure/msal-node` dependency. Fixes issue [13343](https://github.com/Azure/azure-sdk-for-js/issues/13343).

### Metrics Advisor 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/ai-metrics-advisor_1.0.0-beta.3/sdk/metricsadvisor/@azure/ai-metrics-advisor/CHANGELOG.md#100-beta3-2021-02-09)
- Added AAD authentication support
- Added support for API key and Subscription key rotation
- Added a map property in DataFeed object for mapping of metric name to metric id
- [Breaking] All update methods now return just RestResponse instead of entire objects:
    - `updateAlertConfig()` now returns `RestResponse` instead of `GetAnomalyAlertConfigurationResponse`
    - `updateDatafeed` now returns `RestResponse` instead of `GetDatafeedResponse`
    - `updateHook` now returns `RestResponse` instead of `GetHookResponse`
    - `updateDetectionConfig` now returns `RestResponse` instead of `GetAnomalyDetectionConfigurationResponse`
- [Breaking] Rename function `listDimensionValuesForDetectionConfig()` to `listAnomalyDimensionValues()`

### Synapse - AccessControl 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/synapse-access-control_1.0.0-beta.2/sdk/synapse/@azure/synapse-access-control/CHANGELOG.md#100-beta2-2021-02-09)
- Regenerated from the latest REST API
- Fixed typo in the README example
- Updated `createRoleAssignment` input types

### Core - Auth 1.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/core-auth_1.2.0/sdk/core/@azure/core-auth/CHANGELOG.md#120-2021-02-08)
- Add `AzureSASCredential` and `SASCredential` for use by service clients which allow authenticiation using a shared access signature.

### Storage - Files Shares 12.4.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/storage-file-share_12.4.1/sdk/storage/@azure/storage-file-share/CHANGELOG.md#1241-2021-02-03)
- Fixed a bug where `generateFileSASQueryParameters()` won't correctly set the resource type if `FileSASSignatureValues.permissions` is not specified. Fixed issue [13223](https://github.com/Azure/azure-sdk-for-js/issues/13223).
- The `"Unclosed root tag"` XML parser error is now retriable. [PR #13076](https://github.com/Azure/azure-sdk-for-js/pull/13076).

### Storage - Files Data Lake 12.3.1 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/storage-file-datalake_12.3.1/sdk/storage/@azure/storage-file-datalake/CHANGELOG.md#1231-2021-02-03)
- Fixed a bug where `generateDataLakeSASQueryParameters()` won't correctly set the resource type if `DataLakeSASSignatureValues.permissions` is not specified. Fixed issue [13223](https://github.com/Azure/azure-sdk-for-js/issues/13223).
- Fixed a compile failure due to "Can't resolve 'crypto'" in Angular. [Issue #13267](https://github.com/Azure/azure-sdk-for-js/issues/13267).
- The `"Unclosed root tag"` XML parser error is now retriable. [PR #13076](https://github.com/Azure/azure-sdk-for-js/pull/13076).


[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}

