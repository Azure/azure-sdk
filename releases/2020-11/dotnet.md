---
title: Azure SDK for .NET (November 2020)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our November 2020 client library releases.

#### GA

- Digital Twins Core
- Extensions Configuration Secrets
- Identity
- System Memory Data

#### Updates

- _Add packages_

#### Beta

- Azure Monitor
- Core AMQP
- Core NewtonsoftJson
- Event Grid
- Event Hubs
- Extensions Azure
- Key Vault Administration
- Key Vault Certificates
- Key Vault Keys
- Key Vault Secrets
- Metrics Advisor
- Search Documents
- Service Bus
- Tables

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.AI.MetricsAdvisor --version 1.0.0-beta.2

$> dotnet add package Azure.Core.Amqp --version 1.0.0-beta.1

$> dotnet add package Azure.Data.Tables --version 3.0.0-beta.3

$> dotnet add package Azure.DigitalTwins.Core --version 1.0.1

$> dotnet add package Azure.Extensions.AspNetCore.Configuration.Secrets --version 1.0.2

$> dotnet add package Azure.Identity --version 1.3.0

$> dotnet add package Azure.Messaging.EventGrid --version 4.0.0-beta.4

$> dotnet add package Azure.Messaging.EventHubs --version 5.3.0-beta.4
$> dotnet add package Azure.Messaging.EventHubs.Processor --version 5.3.0-beta.4

$> dotnet add package Azure.Messaging.ServiceBus --version 7.0.0-preview.9

$> dotnet add package Azure.Search.Documents --version 11.2.0-beta.2

$> dotnet add package Azure.Security.KeyVault.Administration --version 4.0.0-beta.3
$> dotnet add package Azure.Security.KeyVault.Certificates --version 4.2.0-beta.3
$> dotnet add package Azure.Security.KeyVault.Keys --version 4.2.0-beta.3
$> dotnet add package Azure.Security.KeyVault.Secrets --version 4.2.0-beta.3

$> dotnet add package Microsoft.Azure.Core.NewtonsoftJson --version 1.0.0-preview.2

$> dotnet add package Microsoft.Extensions.Azure --version 1.1.0-beta.1

$> dotnet add package Microsoft.OpenTelemetry.Exporter.AzureMonitor --version 1.0.0-beta.1

$> dotnet add package System.Memory.Data --version 1.0.0
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights

### Azure Monitor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/monitor/Microsoft.OpenTelemetry.Exporter.AzureMonitor/CHANGELOG.md#100-beta1-2020-11-06)

- Initial release of Azure Monitor Exporter for [OpenTelemetry .NET](https://github.com/open-telemetry/opentelemetry-dotnet).

### Core AMQP [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Azure.Core.Amqp/CHANGELOG.md#100-beta1-2020-11-04)

#### New Features

- Added AMQP models.

### Core NewtonsoftJson [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Microsoft.Azure.Core.NewtonsoftJson/CHANGELOG.md#100-preview2-2020-11-10)

#### New Features

- `Newtonsoft.Json.JsonConverter` implementation for the `ETag`.

### Digital Twins Core [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/digitaltwins/Azure.DigitalTwins.Core/CHANGELOG.md#101-2020-11-04)

#### New Features

- Improved deserialization and error reporting for `BasicDigitalTwin` for `DigitalTwinMetadata`.

#### Breaking Changes

- Removed logic to determine authorization scope based on digital twins instance URI.

### Event Grid [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventgrid/Azure.Messaging.EventGrid/CHANGELOG.md#400-beta4-2020-11-10)

#### Key Bug Fixes

- Fixed bug where missing required properties on CloudEvent would cause deserialization to fail.

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md)

This release contains a collection of minor bug fixes, performance improvements, and documentation enhancements.

#### New Features

- Connection strings can now be parsed into their key/value pairs using the `EventHubsConnectionStringProperties` class.

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md)

This release contains a collection of minor bug fixes, performance improvements, and documentation enhancements.

### Extensions Azure [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/extensions/Microsoft.Extensions.Azure/CHANGELOG.md#110-beta1-2020-11-10)

#### New Features

- The `AzureComponentFactory` class that allows creating `TokenCredential`, `ClientOptions` and client instances from configuration.
- The `AzureEventSourceLogForwarder` class that allows manual control over the log forwarding.
- The `AddAzureClientsCore` extension method.

### Extensions Configuration Secrets [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/extensions/Azure.Extensions.AspNetCore.Configuration.Secrets/CHANGELOG.md#102-2020-11-10)

#### New Features

- Added an overload of `AddAzureKeyVault` that takes an `AzureKeyVaultConfigurationOptions` parameter and allows specifying the reload interval.

### Identity [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/identity/Azure.Identity/CHANGELOG.md#130-2020-11-12)

#### New Features

- Added support for Service Fabric managed identity authentication to `ManagedIdentityCredential`.
- Added support for Azure Arc managed identity authentication to `ManagedIdentityCredential`.

#### Breaking Changes

- Removing Application Authentication APIs for GA release. These will be reintroduced in 1.4.0-beta.1.

#### Key Bug Fixes

- Fix `VisualStudioCodeCredential` to raise `CredentialUnavailableException` when reading from VS Code's stored secret ([#16795](https://github.com/Azure/azure-sdk-for-net/issues/16795)).
- Fix deadlock in `ProcessRunner` causing `AzureCliCredential` and `VisualStudioCredential` to fail due to timeout ([#14691](https://github.com/Azure/azure-sdk-for-net/issues/14691), [14207](https://github.com/Azure/azure-sdk-for-net/issues/14207)).
- Fix issue with `AzureCliCredential` incorrectly parsing expires on property returned from `az account get-access-token` ([#15801](https://github.com/Azure/azure-sdk-for-net/issues/15801)).
- Fix cache loading issue in `SharedTokenCacheCredential` on Linux ([#12939](https://github.com/Azure/azure-sdk-for-net/issues/12939)).

### Key Vault Administration [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/keyvault/Azure.Security.KeyVault.Administration/CHANGELOG.md#400-beta3-2020-11-12)

#### Breaking Changes

- Consolidated backup and RBAC client options into a single `KeyVaultAdministrationClientOptions`.
- Refactored `BackupOperation` to return `BackupResult`.
- Refactored `RestoreOperation` to return `RestoreResult`.
- Made `KeyVaultRoleAssignmentProperties` internal and moved its properties to method parameters for `CreateRoleAssignment`.

### Key Vault Certificates [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/keyvault/Azure.Security.KeyVault.Certificates/CHANGELOG.md#420-beta3-2020-11-12)

#### New Features

- Added `DownloadCertificate` and `DownloadCertificateAsync` methods to get `X509Certificate2` with private key if permitted ([#12083](https://github.com/Azure/azure-sdk-for-net/issues/12083)).

### Key Vault Keys [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/keyvault/Azure.Security.KeyVault.Keys/CHANGELOG.md#420-beta3-2020-11-12)

#### New Features

- Added `KeyType.OctHsm` to support "oct-HSM" key operations.
- Added AES-GCM and AES-CBC support for encrypting and decrypting, including new `Encrypt` and `Decrypt` overloads.
- Added support for Secure Key Release including the `Export` method on `KeyClient` and `ReleasePolicy` property on various models.

### Key Vault Secrets [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/keyvault/Azure.Security.KeyVault.Secrets/CHANGELOG.md#420-beta3-2020-11-12)

- This release contains bug fixes to improve quality.

### Metrics Advisor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/metricsadvisor/Azure.AI.MetricsAdvisor/CHANGELOG.md#100-beta2-2020-11-10)

#### New Features

- Added a public constructor to `DataFeed`.
- Added the `DataSource` property to `DataFeed`.

#### Breaking Changes

- In `MetricsAdvisorClient`, changed return types of sync and async `CreateMetricFeedback` methods to a `Response<string>` containing the ID of the created feedback.
- In `MetricsAdvisorClient`, changed return types of sync and async methods `GetIncidentRootCauses`, `GetMetricEnrichedSeriesData`, and `GetMetricSeriesData` to pageables.
- In `MetricsAdvisorAdministrationClient`, updated `CreateDataFeed` and `CreateDataFeedAsync` to take a whole `DataFeed` object as a parameter.
- In `MetricsAdvisorAdministrationClient`, changed return types of sync and async `Create` methods (e.g., `CreateDataFeed`) to a `Response<string>` containing the ID of the created resource.
- In `MetricsAdvisorAdministrationClient`, changed return types of sync and async methods `GetAnomalyAlertConfigurations` and `GetMetricAnomalyDetectionConfigurations` to pageables.
- Removed `DataFeedOptions`. All of its properties were moved directly into `DataFeed`.

#### Key Bug Fixes

- Fixed a bug in sync and async `UpdateDataFeed` methods where a `RequestFailedException` was thrown if a data feed without custom `DataFeedMissingDataPointFillType` was updated.
- Fixed a bug in sync and async `UpdateAlertConfiguration` methods where a `RequestFailedException` was thrown if a configuration with only one `MetricAnomalyAlertConfiguration` was updated.

### Search Documents [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/search/Azure.Search.Documents/CHANGELOG.md#1120-beta2-2020-11-10)

#### New Features

- Added `EncryptionKey` to `SearchIndexer`, `SearchIndexerDataSourceConnection`, and `SearchIndexerSkillset`.
- Added configuration options to tune the performance of `SearchIndexingBufferedSender<T>`.

#### Key Bug Fixes

- Fixed issue calling `SearchIndexClient.GetIndexNames` that threw an exception ([#15590](https://github.com/Azure/azure-sdk-for-net/issues/15590)).
- Fixed issue where `ScoringProfile.FunctionAggregation` did not correctly handle null values ([#16570](https://github.com/Azure/azure-sdk-for-net/issues/16570)).
- Fixed overly permissive date parsing on facets ([#16412](https://github.com/Azure/azure-sdk-for-net/issues/16412)).

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/servicebus/Azure.Messaging.ServiceBus/CHANGELOG.md#700-preview9-2020-11-04)

#### Breaking Changes

- Removed `AmqpMessage` property in favor of a `GetRawMessage` method on `ServiceBusMessage` and `ServiceBusReceivedMessage`.
- Renamed `Properties` to `ApplicationProperties` in `CorrelationRuleFilter`.
- Removed `ServiceBusSenderOptions`.
- Removed `TransactionEntityPath` from `ServiceBusSender`.

### System Memory Data [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/System.Memory.Data/CHANGELOG.md#100-2020-11-03)

- The general availability release of System.Memory.Data package.

### Tables [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/3ff84e738c517daf3c451fd39a6f126855ac3b95/sdk/tables/Azure.Data.Tables/CHANGELOG.md)

### New Features

- Added support for Upsert batch operations.
- Added support for some numeric type coercion for TableEntity properties.
- Added TryGetFailedEntityFromException method on TablesTransactionalBatch to extract the entity that caused a batch failure from a RequestFailedException.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
