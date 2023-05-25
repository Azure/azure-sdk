---
title: Azure SDK for Python (April 2021)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

<!--
azure-keyvault-keys:4.4.0b1
azure-keyvault-keys:4.4.0b3
azure-mgmt-datadog:1.0.0
azure-mgmt-netapp:2.0.0
azure-mgmt-databricks:1.0.0
azure-mgmt-deviceupdate:1.0.0b2
azure-mgmt-alertsmanagement:1.0.0
azure-mgmt-automation:1.1.0b1
azure-mgmt-rdbms:8.1.0b1
azure-mgmt-databox:1.0.0
azure-mgmt-support:6.0.0
azure-mgmt-attestation:1.0.0
azure-mgmt-timeseriesinsights:1.0.0
azure-keyvault-keys:4.4.0b2
azure-common:1.1.27
azure-mgmt-marketplaceordering:1.1.0
azure-mgmt-cdn:11.0.0
azure-mgmt-extendedlocation:1.0.0b1
azure-eventgrid:4.1.0
azure-mgmt-privatedns:1.0.0
azure-mgmt-communication:1.0.0
azure-mgmt-rdbms:8.1.0b2
azure-mgmt-frontdoor:1.0.0
azure-mgmt-powerbidedicated:1.0.0
azure-core:1.13.0
azure-search-documents:11.2.0b1
azure-appconfiguration:1.2.0b1
azure-synapse-artifacts:0.6.0
azure-data-tables:12.0.0b6
azure-ai-formrecognizer:3.1.0b4
azure-containerregistry:1.0.0b1
azure-ai-translation-nspkg:1.0.0
azure-keyvault-keys:4.4.0b4
azure-ai-translation-document:1.0.0b1
azure-identity:1.6.0b3
azure-monitor-opentelemetry-exporter:1.0.0b4
azure-mgmt-compute:20.0.0
azure-core-tracing-opentelemetry:1.0.0b9
azure-servicebus:7.1.1
azure-servicebus:7.2.0b1
azure-eventhub-checkpointstoreblob-aio:1.1.4
azure-eventhub-checkpointstoreblob:1.1.4
azure-eventhub:5.4.0
azure-eventgrid:4.1.1
azure-mgmt-datamigration:9.0.0
azure-mgmt-synapse:2.0.0
azure-mgmt-containerservice:15.1.0
azure-core-tracing-opencensus:1.0.0b7
azure-mgmt-customproviders:1.0.0
azure-mgmt-azurestack:1.0.0
azure-mgmt-appplatform:6.0.0
azure-mgmt-datashare:1.0.0
azure-mgmt-hanaonazure:1.0.0
azure-mgmt-healthcareapis:1.0.0
azure-search-documents:11.2.0b2

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to make available the April 2021 client library release.

#### GA
- Azure Communication Chat
- Azure Communication Identity
- Azure Communication SMS
- Core
- Resource Management - Alerts Management
- Resource Management - App Platform
- Resource Management - Attestation
- Resource Management - Azure Stack
- Resource Management - Communication
- Resource Management - Compute
- Resource Management - Container Service
- Resource Management - Content Delivery Network
- Resource Management - Custom Providers
- Resource Management - Data Box
- Resource Management - Data Migration
- Resource Management - Data Share
- Resource Management - Databricks
- Resource Management - Datadog
- Resource Management - Frontdoor
- Resource Management - HANA on Azure
- Resource Management - Healthcare APIs
- Resource Management - Marketplace Ordering
- Resource Management - NetApp
- Resource Management - Power BI Dedicated
- Resource Management - Private DNS
- Resource Management - Support
- Resource Management - Time Series Insights
- Resource Management - Synapse
- Synapse - Artifacts
- Event Hubs

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Common
- Event Hubs - Azure Blob Storage Checkpoint Store
- Event Hubs - Azure Blob Storage Checkpoint Store AIO
- Event Grid
- Service Bus

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- App Configuration
- Azure Communication Phone Numbers
- Cognitive Search
- Container Registry
- Core Tracing Opencensus
- Core Tracing Opentelemetry
- Device Update
- Extended Location
- Form Recognizer
- Identity
- Key Vault - Keys
- Monitor OpenTelemetry Exporter
- Resource Management - Automation
- Resource Management - Rdbms
- Service Bus
- Tables
- Translation Document
- Cognitive Search

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
$> pip install azure-ai-formrecognizer==3.1.0b4
$> pip install azure-ai-translation-document==1.0.0b1
$> pip install azure-appconfiguration==1.2.0b1
$> pip install azure-common==1.1.27
$> pip install azure-communication-identity
$> pip install azure-communication-chat
$> pip install azure-communication-sms
$> pip install azure-communication-phonenumbers
$> pip install azure-containerregistry==1.0.0b1
$> pip install azure-core==1.13.0
$> pip install azure-core-tracing-opencensus==1.0.0b7
$> pip install azure-core-tracing-opentelemetry==1.0.0b9
$> pip install azure-data-tables==12.0.0b6
$> pip install azure-eventhub==5.4.0
$> pip install azure-eventhub-checkpointstoreblob==1.1.4
$> pip install azure-eventhub-checkpointstoreblob-aio==1.1.4
$> pip install azure-eventgrid==4.1.1
$> pip install azure-identity==1.6.0b3
$> pip install azure-keyvault-keys==4.4.0b4
$> pip install azure-mgmt-alertsmanagement==1.0.0
$> pip install azure-mgmt-appplatform==6.0.0
$> pip install azure-mgmt-attestation==1.0.0
$> pip install azure-mgmt-automation==1.1.0b1
$> pip install azure-mgmt-azurestack==1.0.0
$> pip install azure-mgmt-cdn==11.0.0
$> pip install azure-mgmt-communication==1.0.0
$> pip install azure-mgmt-compute==20.0.0
$> pip install azure-mgmt-containerservice==15.1.0
$> pip install azure-mgmt-customproviders==1.0.0
$> pip install azure-mgmt-databricks==1.0.0
$> pip install azure-mgmt-datadog==1.0.0
$> pip install azure-mgmt-datamigration==9.0.0
$> pip install azure-mgmt-datashare==1.0.0
$> pip install azure-mgmt-deviceupdate==1.0.0b2
$> pip install azure-mgmt-extendedlocation==1.0.0b1
$> pip install azure-mgmt-frontdoor==1.0.0
$> pip install azure-mgmt-hanaonazure==1.0.0
$> pip install azure-mgmt-healthcareapis==1.0.0
$> pip install azure-mgmt-marketplaceordering==1.1.0
$> pip install azure-mgmt-netapp==2.0.0
$> pip install azure-mgmt-rdbms==8.1.0b2
$> pip install azure-mgmt-databox==1.0.0
$> pip install azure-mgmt-powerbidedicated==1.0.0
$> pip install azure-mgmt-privatedns==1.0.0
$> pip install azure-mgmt-support==6.0.0
$> pip install azure-mgmt-timeseriesinsights==1.0.0
$> pip install azure-mgmt-synapse==2.0.0
$> pip install azure-monitor-opentelemetry-exporter==1.0.0b4
$> pip install azure-search-documents==11.2.0b1
$> pip install azure-servicebus==7.1.1
$> pip install azure-servicebus==7.2.0b1
$> pip install azure-synapse-artifacts==0.6.0
$> pip install azure-search-documents==11.2.0b2

```

[pattern]: # ($> pip install ${PackageName}==${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights
### App Configuration 1.2.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-appconfiguration_1.2.0b1/sdk/appconfiguration/azure-appconfiguration/CHANGELOG.md#120b1-2021-04-06)
#### Features

- Adds method `update_sync_token` to include sync tokens from EventGrid notifications.
- Added `SecretReferenceConfigurationSetting` type to represent a configuration setting that references a KeyVault Secret.
Added `FeatureFlagConfigurationSetting` type to represent a configuration setting that controls a feature flag.

### Azure Communication Chat 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/communication/azure-communication-chat/CHANGELOG.md#100-2021-03-29)

**Includes all changes from 1.0.0-beta.1 to  1.0.0.beta.5**

### Breaking Changes

- Renamed `ChatThread` to `ChatThreadProperties`.
- Renamed `get_chat_thread` to `get_properties`.
- Moved `get_properties` under `ChatThreadClient`.
- Renamed `ChatThreadInfo` to `ChatThreadItem`.
- Removed `ChatThreadClient.add_participant` method.
- Renamed `repeatability_request_id` to `idempotency_token`.
- Changed return type of `send_message` to `SendChatMessageResult`.
- Replaced `CommunicationError` with `ChatError`.
- Refactored `CommunicationTokenCredential` constructor to accept `token` instead of `CommunicationTokenRefreshOptions`.

### Azure Communication Identity 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/communication/azure-communication-identity/CHANGELOG.md#100-2021-03-29)

**Includes all changes from 1.0.0-beta.1 to  1.0.0.beta.5**
- Stable release of `azure-communication-identity`.

### Azure Communication Phone Numbers 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/communication/azure-communication-phonenumbers/CHANGELOG.md#100b5-2021-03-29)

#### Breaking Changes

- Renamed `AcquiredPhoneNumber` to `PurchasedPhoneNumber`
- Renamed `PhoneNumbersClient.get_phone_number` and `PhoneNumbersAsyncClient.get_phone_number` to `PhoneNumbersClient.get_purchased_phone_number`
and `PhoneNumbersAsyncClient.get_purchased_phone_number`
-` Renamed PhoneNumbersClient.list_acquired_phone_numbers` and `PhoneNumbersAsyncClient.list_acquired_phone_numbers` to `PhoneNumbersClient.list_purchased_phone_numbers`
and `PhoneNumbersAsyncClient.list_purchased_phone_numbers`

### Azure Communication SMS 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/communication/azure-communication-sms/CHANGELOG.md#100-2021-03-29)

**Includes all changes from 1.0.0-beta.1 to  1.0.0.beta.6**

- Stable release of `azure-communication-sms`.

### Cognitive Search 11.2.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-search-documents_11.2.0b1/sdk/search/azure-search-documents/CHANGELOG.md#1120b1-2021-04-06)
#### New features

- Added new data source type ADLS gen2  #16852
- Added normalizer support  #17579

### Common 1.1.27 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-common_1.1.27/sdk/core/azure-common/CHANGELOG.md#1127-2021-03-23)
- Deprecate JSON and auth file client factory  #15075
- Add 2020-09-01-hybrid profile definition  #14642

### Container Registry 1.0.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-containerregistry_1.0.0b1/sdk/containerregistry/azure-containerregistry/CHANGELOG.md#100b1-2021-04-06)
* First release of the Azure Container Registry library for Python

### Core 1.13.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-core_1.13.0/sdk/core/azure-core/CHANGELOG.md#1130-2021-04-02)
Azure core requires Python 2.7 or Python 3.6+ since this release.

#### New Features

- Added `azure.core.utils.parse_connection_string` function to parse connection strings across SDKs, with common validation and support for case insensitive keys.
- Supported adding custom policies  #16519
- Added `~azure.core.tracing.Link` that should be used while passing `Links` to  `AbstractSpan`.
- `AbstractSpan` constructor can now take in additional keyword only args.

#### Bug fixes

- Make NetworkTraceLoggingPolicy show the auth token in plain text. #14191
- Fixed RetryPolicy overriding default connection timeout with an extreme value #17481

### Core Tracing Opencensus 1.0.0b7 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-core-tracing-opencensus_1.0.0b7/sdk/core/azure-core-tracing-opencensus/CHANGELOG.md#100b7-2021-04-08)
- `Link` and `SpanKind` can now be added while creating the span instance.

### Core Tracing Opentelemetry 1.0.0b9 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-core-tracing-opentelemetry_1.0.0b9/sdk/core/azure-core-tracing-opentelemetry/CHANGELOG.md#100b9-2021-04-06)
- Updated opentelemetry-api to version 1.0.0
- `Link` and `SpanKind` can now be added while creating the span instance.

### Event Grid 4.1.1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-eventgrid_4.1.1/sdk/eventgrid/azure-eventgrid/CHANGELOG.md#411-2021-04-07)
**Bug Fixes**
  - Improved the `repr` on `EventGridEvent` to show more meaningful text.

### Event Hubs 5.4.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-eventhub_5.4.0/sdk/eventhub/azure-eventhub/CHANGELOG.md#540-2021-04-07)
This version follows from version 5.3.1, rather than 5.4.0b1 so that the preview idempotent producer feature is not included.

**New Features**

- Added support for using `azure.core.credentials.AzureSasCredential` as credential for authenticating producer and consumer clients.
- Updated `list_ownership`, `claim_ownership`, `update_checkpoint`, `list_checkpoints` on sync and async `CheckpointStore` to support taking `**kwargs`.
  - WARNING: Implementing a custom checkpointstore that does not support taking `**kwargs` in the methods listed previously will result in the following pylint error: `W0221: Parameters differ from overridden ________ method (arguments-differ)`.
- Updated `update_checkpoint` on sync and async `PartitionContext` to support taking `**kwargs`.

**Bug Fixes**

* Updated uAMQP dependency to 1.3.0.
  - Fixed bug that sending message of large size triggering segmentation fault when the underlying socket connection is lost (#13739, #14543).
  - Fixed bug in link flow control where link credit and delivery count should be calculated based on per message instead of per transfer frame (#16934).

**Notes**

- Updated azure-core dependency to 1.13.0.

### Event Hubs - Azure Blob Storage Checkpoint Store 1.1.4 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-eventhub-checkpointstoreblob_1.1.4/sdk/eventhub/azure-eventhub-checkpointstoreblob/CHANGELOG.md#114-2021-04-07)
This version and all future versions will require Python 2.7 or Python 3.6+, Python 3.5 is no longer supported.

**New features**
- Updated `list_ownership`, `claim_ownership`, `update_checkpoint`, `list_checkpoints` on `BlobCheckpointStore` to support taking `**kwargs`.

### Event Hubs - Azure Blob Storage Checkpoint Store AIO 1.1.4 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-eventhub-checkpointstoreblob-aio_1.1.4/sdk/eventhub/azure-eventhub-checkpointstoreblob-aio/CHANGELOG.md#114-2021-04-07)
This version and all future versions will require Python 2.7 or Python 3.6+, Python 3.5 is no longer supported.

**New features**
- Updated `list_ownership`, `claim_ownership`, `update_checkpoint`, `list_checkpoints` on `BlobCheckpointStore` to support taking `**kwargs`.

### Form Recognizer 3.1.0b4 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-ai-formrecognizer_3.1.0b4/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#310b4-2021-04-06)
**New features**

- New methods `begin_recognize_id_documents` and `begin_recognize_id_documents_from_url` introduced to the SDK. Use these methods to recognize data from identity documents.
- New field value types "gender" and "country" described in the `FieldValueType` enum.
- Content-type `image/bmp` now supported by custom forms and training methods.
- Added keyword argument `pages` for business cards, receipts, custom forms, and invoices
to specify which page to process of the document.
- Added keyword argument `reading_order` to `begin_recognize_content` and `begin_recognize_content_from_url`.

**Dependency Updates**

- Bumped `msrest` requirement from `0.6.12` to `0.6.21`.

### Identity 1.6.0b3 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-identity_1.6.0b3/sdk/identity/azure-identity/CHANGELOG.md#160b3-2021-04-06)
#### Breaking Changes
> These changes do not impact the API of stable versions such as 1.5.0.
> Only code written against a beta version such as 1.6.0b1 may be affected.
- Removed property `AuthenticationRequiredError.error_details`

#### Fixed
- Credentials consistently retry token requests after connection failures, or
  when instructed to by a Retry-After header
- ManagedIdentityCredential caches tokens correctly

#### Added
- `InteractiveBrowserCredential` functions in more WSL environments
  ([#17615](https://github.com/Azure/azure-sdk-for-python/issues/17615))

### Key Vault - Keys 4.4.0b4 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-keyvault-keys_4.4.0b4/sdk/keyvault/azure-keyvault-keys/CHANGELOG.md#440b4-2021-04-06)
#### Added
- `CryptographyClient` can perform AES-CBCPAD encryption and decryption locally
  ([#17762](https://github.com/Azure/azure-sdk-for-python/pull/17762))

### Monitor OpenTelemetry Exporter 1.0.0b4 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-monitor-opentelemetry-exporter_1.0.0b4/sdk/monitor/azure-monitor-opentelemetry-exporter/CHANGELOG.md#100b4-2021-04-06)
**Features**
  - Add `from_connection_string` method to instantiate exporters
      ([#16818](https://github.com/Azure/azure-sdk-for-python/pull/16818))

  - Remove support for Python 3.5
      ([#17747](https://github.com/Azure/azure-sdk-for-python/pull/17747))

### Resource Management - Alerts Management 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-alertsmanagement_1.0.0/sdk/alertsmanagement/azure-mgmt-alertsmanagement/CHANGELOG.md#100-2021-03-16)
- GA release

### Resource Management - App Platform 6.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-appplatform_6.0.0/sdk/appplatform/azure-mgmt-appplatform/CHANGELOG.md#600-2021-04-08)
**Features**

  - Model MonitoringSettingProperties has a new parameter app_insights_agent_versions
  - Model MonitoringSettingProperties has a new parameter app_insights_sampling_rate
  - Model AppResourceProperties has a new parameter enable_end_to_end_tls
  - Model NetworkProfile has a new parameter required_traffics

### Resource Management - Attestation 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-attestation_1.0.0/sdk/attestation/azure-mgmt-attestation/CHANGELOG.md#100-2021-03-16)
* GA release

### Resource Management - Automation 1.1.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-automation_1.1.0b1/sdk/automation/azure-mgmt-automation/CHANGELOG.md#110b1-2021-03-16)
**Features**

  - Model SoftwareUpdateConfigurationCollectionItem has a new parameter tasks

### Resource Management - Azure Stack 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-azurestack_1.0.0/sdk/azurestack/azure-mgmt-azurestack/CHANGELOG.md#100-2021-04-08)
**Features**

  - Model Registration has a new parameter system_data
  - Model Registration has a new parameter kind
  - Model TrackedResource has a new parameter system_data
  - Model TrackedResource has a new parameter kind
  - Model CustomerSubscription has a new parameter system_data
  - Model Product has a new parameter system_data
  - Added operation RegistrationsOperations.enable_remote_management
  - Added operation group LinkedSubscriptionsOperations

**Breaking changes**

  - Operation ProductsOperations.get_products has a new signature

### Resource Management - Communication 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-communication_1.0.0/sdk/communication/azure-mgmt-communication/CHANGELOG.md#100-2021-03-29)
**Features**

  - Model CommunicationServiceResource has a new parameter system_data
  - Model Operation has a new parameter action_type
  - Model Operation has a new parameter is_data_action
  - Added operation CommunicationServiceOperations.check_name_availability

**Breaking changes**

  - Model Operation no longer has parameter properties

### Resource Management - Compute 20.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-compute_20.0.0/sdk/compute/azure-mgmt-compute/CHANGELOG.md#2000-2021-04-06)
**Features**

  - Model PurchasePlan has a new parameter promotion_code
  - Model DiskUpdate has a new parameter supports_hibernation
  - Model DiskUpdate has a new parameter property_updates_in_progress
  - Model SnapshotUpdate has a new parameter supports_hibernation
  - Model DiskRestorePoint has a new parameter supports_hibernation
  - Model DiskEncryptionSetUpdate has a new parameter identity
  - Model DiskEncryptionSetUpdate has a new parameter rotation_to_latest_key_version_enabled
  - Model CloudServiceProperties has a new parameter allow_model_override
  - Model LoadBalancerConfiguration has a new parameter id
  - Model CloudServiceInstanceView has a new parameter private_ids
  - Model Snapshot has a new parameter supports_hibernation
  - Model DiskEncryptionSet has a new parameter last_key_rotation_timestamp
  - Model DiskEncryptionSet has a new parameter rotation_to_latest_key_version_enabled
  - Model Disk has a new parameter security_profile
  - Model Disk has a new parameter supports_hibernation
  - Model Disk has a new parameter property_updates_in_progress
  - Added operation group CloudServiceOperatingSystemsOperations

**Breaking changes**

  - Parameter name of model LoadBalancerConfiguration is now required
  - Parameter properties of model LoadBalancerConfiguration is now required
  - Parameter frontend_ip_configurations of model LoadBalancerConfigurationProperties is now required
  - Parameter name of model LoadBalancerFrontendIPConfiguration is now required
  - Parameter properties of model LoadBalancerFrontendIPConfiguration is now required

### Resource Management - Container Service 15.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-containerservice_15.1.0/sdk/containerservice/azure-mgmt-containerservice/CHANGELOG.md#1510-2021-04-07)
**Features**

  - Model Components1Q1Og48SchemasManagedclusterAllof1 has a new parameter private_link_resources
  - Model Components1Q1Og48SchemasManagedclusterAllof1 has a new parameter disable_local_accounts
  - Model Components1Q1Og48SchemasManagedclusterAllof1 has a new parameter http_proxy_config
  - Model ManagedClusterPodIdentity has a new parameter binding_selector
  - Model ManagedClusterAgentPoolProfileProperties has a new parameter gpu_instance_profile
  - Model ManagedClusterAgentPoolProfileProperties has a new parameter enable_fips
  - Model ManagedClusterAgentPoolProfileProperties has a new parameter os_sku
  - Model AgentPool has a new parameter gpu_instance_profile
  - Model AgentPool has a new parameter enable_fips
  - Model AgentPool has a new parameter os_sku
  - Model ManagedCluster has a new parameter extended_location
  - Model ManagedCluster has a new parameter private_link_resources
  - Model ManagedCluster has a new parameter disable_local_accounts
  - Model ManagedCluster has a new parameter http_proxy_config
  - Model ManagedClusterAgentPoolProfile has a new parameter gpu_instance_profile
  - Model ManagedClusterAgentPoolProfile has a new parameter enable_fips
  - Model ManagedClusterAgentPoolProfile has a new parameter os_sku
  - Model ManagedClusterWindowsProfile has a new parameter enable_csi_proxy
  - Added operation ManagedClustersOperations.get_command_result
  - Added operation ManagedClustersOperations.begin_run_command
  - Added operation ManagedClustersOperations.get_os_options

### Resource Management - Content Delivery Network 11.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-cdn_11.0.0/sdk/cdn/azure-mgmt-cdn/CHANGELOG.md#1100-2021-03-29)
**Features**

  - Model ManagedRuleSetDefinition has a new parameter system_data
  - Model Resource has a new parameter system_data

**Breaking changes**

  - Operation SecurityPoliciesOperations.begin_patch has a new signature
  - Operation RuleSetsOperations.begin_create has a new signature
  - Model RouteUpdatePropertiesParameters no longer has parameter optimization_type
  - Model CustomerCertificateParameters no longer has parameter thumbprint
  - Model CustomerCertificateParameters no longer has parameter subject
  - Model CustomerCertificateParameters no longer has parameter expiration_date
  - Model RouteProperties no longer has parameter optimization_type
  - Model Route no longer has parameter optimization_type
  - Model RouteUpdateParameters no longer has parameter optimization_type
  - Operation LogAnalyticsOperations.get_log_analytics_metrics has a new signature
  - Model ManagedCertificateParameters has a new signature

### Resource Management - Custom Providers 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-customproviders_1.0.0/sdk/customproviders/azure-mgmt-customproviders/CHANGELOG.md#100-2021-04-08)
- GA release

### Resource Management - Data Box 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-databox_1.0.0/sdk/databox/azure-mgmt-databox/CHANGELOG.md#100-2021-03-18)
- GA release

### Resource Management - Data Migration 9.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-datamigration_9.0.0/sdk/datamigration/azure-mgmt-datamigration/CHANGELOG.md#900-2021-04-07)
**Features**

  - Model AvailableServiceSku has a new parameter sku

**Breaking changes**

  - Operation ServiceTasksOperations.update has a new signature
  - Operation TasksOperations.create_or_update has a new signature
  - Operation TasksOperations.update has a new signature
  - Operation FilesOperations.create_or_update has a new signature
  - Operation FilesOperations.update has a new signature
  - Operation TasksOperations.update has a new signature
  - Operation TasksOperations.create_or_update has a new signature
  - Operation ServiceTasksOperations.update has a new signature
  - Operation FilesOperations.update has a new signature
  - Operation FilesOperations.create_or_update has a new signature
  - Operation ServicesOperations.check_children_name_availability has a new signature
  - Operation ServicesOperations.check_name_availability has a new signature
  - Operation ServiceTasksOperations.create_or_update has a new signature
  - Model AvailableServiceSku no longer has parameter available_service_sku

### Resource Management - Data Share 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-datashare_1.0.0/sdk/datashare/azure-mgmt-datashare/CHANGELOG.md#100-2021-04-12)
**Features**

  - Model BlobContainerDataSetMapping has a new parameter system_data
  - Model SqlDWTableDataSet has a new parameter system_data
  - Model ADLSGen1FolderDataSet has a new parameter system_data
  - Model KustoDatabaseDataSetMapping has a new parameter system_data
  - Model ConsumerSourceDataSet has a new parameter system_data
  - Model ScheduledTrigger has a new parameter system_data
  - Model DataSet has a new parameter system_data
  - Model KustoClusterDataSetMapping has a new parameter system_data
  - Model BlobDataSet has a new parameter system_data
  - Model SynchronizationSetting has a new parameter system_data
  - Model BlobFolderDataSetMapping has a new parameter system_data
  - Model OperationMetaMetricSpecification has a new parameter fill_gap_with_zero
  - Model ConsumerInvitation has a new parameter expiration_date
  - Model ConsumerInvitation has a new parameter system_data
  - Model ProviderShareSubscription has a new parameter expiration_date
  - Model ProviderShareSubscription has a new parameter system_data
  - Model ProxyDto has a new parameter system_data
  - Model BlobFolderDataSet has a new parameter system_data
  - Model ADLSGen2FolderDataSet has a new parameter system_data
  - Model ScheduledSynchronizationSetting has a new parameter system_data
  - Model SqlDBTableDataSet has a new parameter system_data
  - Model Trigger has a new parameter system_data
  - Model ADLSGen2FileDataSetMapping has a new parameter system_data
  - Model BlobContainerDataSet has a new parameter system_data
  - Model BlobDataSetMapping has a new parameter system_data
  - Model DefaultDto has a new parameter system_data
  - Model DataSetMapping has a new parameter system_data
  - Model KustoDatabaseDataSet has a new parameter system_data
  - Model ShareSubscription has a new parameter expiration_date
  - Model ShareSubscription has a new parameter system_data
  - Model KustoClusterDataSet has a new parameter system_data
  - Model SqlDBTableDataSetMapping has a new parameter system_data
  - Model SqlDWTableDataSetMapping has a new parameter system_data
  - Model Account has a new parameter system_data
  - Model Share has a new parameter system_data
  - Model Invitation has a new parameter expiration_date
  - Model Invitation has a new parameter system_data
  - Model ADLSGen2FileSystemDataSetMapping has a new parameter system_data
  - Model ADLSGen2FolderDataSetMapping has a new parameter system_data
  - Model ADLSGen2FileDataSet has a new parameter system_data
  - Model ADLSGen1FileDataSet has a new parameter system_data
  - Model ADLSGen2FileSystemDataSet has a new parameter system_data
  - Added operation ProviderShareSubscriptionsOperations.adjust

**Breaking changes**

  - Operation ProviderShareSubscriptionsOperations.reinstate has a new signature

### Resource Management - Databricks 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-databricks_1.0.0/sdk/databricks/azure-mgmt-databricks/CHANGELOG.md#100-2021-03-19)
- GA release

### Resource Management - Datadog 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-datadog_1.0.0/sdk/datadog/azure-mgmt-datadog/CHANGELOG.md#100-2021-03-22)
**Features**

  - Model DatadogAgreementResource has a new parameter system_data
  - Model MonitoringTagRules has a new parameter system_data
  - Model DatadogSingleSignOnResource has a new parameter system_data
  - Model DatadogMonitorResource has a new parameter system_data

### Resource Management - Device Update 1.0.0b2 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-deviceupdate_1.0.0b2/sdk/deviceupdate/azure-mgmt-deviceupdate/CHANGELOG.md#100b2-2021-03-24)
**Breaking changes**

  - Removed operation InstancesOperations.list_by_subscription
  - Model ErrorResponse has a new signature
  - Model ErrorDefinition has a new signature

### Resource Management - Extended Location 1.0.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-extendedlocation_1.0.0b1/sdk/extendedlocation/azure-mgmt-extendedlocation/CHANGELOG.md#100b1-2021-03-25)
* Initial Release

### Resource Management - Frontdoor 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-frontdoor_1.0.0/sdk/network/azure-mgmt-frontdoor/CHANGELOG.md#100-2021-03-26)
- GA release

### Resource Management - HANA on Azure 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-hanaonazure_1.0.0/sdk/hanaonazure/azure-mgmt-hanaonazure/CHANGELOG.md#100-2021-04-12)
**Breaking changes**

  - Model ErrorResponse has a new signature

### Resource Management - Healthcare APIs 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-healthcareapis_1.0.0/sdk/healthcareapis/azure-mgmt-healthcareapis/CHANGELOG.md#100-2021-04-12)
**Features**

  - Model ServicesDescription has a new parameter system_data
  - Model ServicesProperties has a new parameter acr_configuration

### Resource Management - Marketplace Ordering 1.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-marketplaceordering_1.1.0/sdk/marketplaceordering/azure-mgmt-marketplaceordering/CHANGELOG.md#110-2021-03-17)
**Features**

  - Model AgreementTerms has a new parameter system_data
  - Model AgreementTerms has a new parameter marketplace_terms_link

### Resource Management - NetApp 2.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-netapp_2.0.0/sdk/netapp/azure-mgmt-netapp/CHANGELOG.md#200-2021-03-16)
**Features**

  - Model Volume has a new parameter ldap_enabled
  - Model Backup has a new parameter volume_name
  - Model ActiveDirectory has a new parameter allow_local_nfs_users_with_ldap
  - Model BackupPatch has a new parameter volume_name
  - Added operation BackupsOperations.begin_update
  - Added operation group VolumeBackupStatusOperations

**Breaking changes**

  - Model SnapshotPolicyDetails no longer has parameter name_properties_name
  - Model SnapshotPolicyPatch no longer has parameter name_properties_name
  - Model Volume no longer has parameter name_properties_name
  - Model SnapshotPolicy no longer has parameter name_properties_name
  - Removed operation BackupsOperations.update

### Resource Management - Power BI Dedicated 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-powerbidedicated_1.0.0/sdk/powerbidedicated/azure-mgmt-powerbidedicated/CHANGELOG.md#100-2021-03-26)
**Features**

  - Model DedicatedCapacityProperties has a new parameter mode
  - Model DedicatedCapacityMutableProperties has a new parameter mode
  - Model DedicatedCapacityUpdateParameters has a new parameter mode
  - Model DedicatedCapacity has a new parameter system_data
  - Model DedicatedCapacity has a new parameter mode
  - Model Resource has a new parameter system_data
  - Added operation group AutoScaleVCoresOperations

**Breaking changes**

  - Model Resource no longer has parameter sku
  - Model ErrorResponse has a new signature

### Resource Management - Private DNS 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-privatedns_1.0.0/sdk/network/azure-mgmt-privatedns/CHANGELOG.md#100-2021-03-25)
- GA release

### Resource Management - Rdbms 8.1.0b2 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-rdbms_8.1.0b2/sdk/rdbms/azure-mgmt-rdbms/CHANGELOG.md#810b2-2021-03-19)
**Features**

  - Model Server has a new parameter source_subscription_id
  - Model Server has a new parameter source_resource_group_name

### Resource Management - Support 6.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-support_6.0.0/sdk/support/azure-mgmt-support/CHANGELOG.md#600-2021-03-29)
- GA release

### Resource Management - Synapse 2.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-synapse_2.0.0/sdk/synapse/azure-mgmt-synapse/CHANGELOG.md#200-2021-04-07)
**Features**

  - Model WorkspacePatchInfo has a new parameter public_network_access
  - Model Workspace has a new parameter public_network_access

**Breaking changes**

  - Model WorkspacePatchInfo no longer has parameter network_settings
  - Model Workspace no longer has parameter network_settings

### Resource Management - Time Series Insights 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-timeseriesinsights_1.0.0/sdk/timeseriesinsights/azure-mgmt-timeseriesinsights/CHANGELOG.md#100-2021-03-26)
**Features**

  - Model EventHubEventSourceUpdateParameters has a new parameter kind
  - Model IoTHubEventSourceUpdateParameters has a new parameter kind
  - Model Gen1EnvironmentUpdateParameters has a new parameter kind
  - Model EventSourceUpdateParameters has a new parameter kind
  - Model Gen2EnvironmentUpdateParameters has a new parameter kind
  - Model EnvironmentUpdateParameters has a new parameter kind

**Breaking changes**

  - Operation AccessPoliciesOperations.update has a new signature
  - Operation EventSourcesOperations.update has a new signature
  - Operation EnvironmentsOperations.begin_update has a new signature
  - Operation ReferenceDataSetsOperations.update has a new signature
  - Operation AccessPoliciesOperations.update has a new signature

### Service Bus 7.1.1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-servicebus_7.1.1/sdk/servicebus/azure-servicebus/CHANGELOG.md#711-2021-04-07)
This version and all future versions will require Python 2.7 or Python 3.6+, Python 3.5 is no longer supported.

**New Features**

* Updated `forward_to` and `forward_dead_lettered_messages_to` parameters in `create_queue`, `update_queue`, `create_subscription`, and `update_subscription` methods on sync and async `ServiceBusAdministrationClient` to accept entities as well, rather than only full paths. In the case that an entity is passed in, it is assumed that the entity exists within the same namespace used for constructing the `ServiceBusAdministrationClient`.

**Bug Fixes**

* Updated uAMQP dependency to 1.3.0.
  - Fixed bug that sending message of large size triggering segmentation fault when the underlying socket connection is lost (#13739, #14543).
  - Fixed bug in link flow control where link credit and delivery count should be calculated based on per message instead of per transfer frame (#16934).

### Service Bus 7.2.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-servicebus_7.2.0b1/sdk/servicebus/azure-servicebus/CHANGELOG.md#720b1-2021-04-07)

**New Features**

* Added support for using `azure.core.credentials.AzureSasCredential` as credential for authenticating the clients.
* Added support for sending AMQP annotated message which allows full access to the AMQP message fields.
  -`azure.servicebus.AMQPAnnotatedMessage` is now made public and could be instantiated for sending.
* Added new enum class `azure.servicebus.AMQPMessageBodyType` to represent the body type of the message message which includes:
  - `DATA`: The body of message consists of one or more data sections and each section contains opaque binary data.
  - `SEQUENCE`: The body of message consists of one or more sequence sections and each section contains an arbitrary number of structured data elements.
  - `VALUE`: The body of message consists of one amqp-value section and the section contains a single AMQP value.
* Added new property `body_type` on `azure.servicebus.ServiceBusMessage` and `azure.servicebus.ReceivedMessage` which returns `azure.servicebus.AMQPMessageBodyType`.

### Synapse - Artifacts 0.6.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-synapse-artifacts_0.6.0/sdk/synapse/azure-synapse-artifacts/CHANGELOG.md#060-2021-04-06)
#### New Features

- Add ADF support

### Tables 12.0.0b6 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-data-tables_12.0.0b6/sdk/tables/azure-data-tables/CHANGELOG.md#1200b6-2021-04-06)
* Updated deserialization of datetime fields in entities to support preservation of the service format with additional decimal place.
* Passing a string parameter into a query filter will now be escaped to protect against injection.
* Fixed bug in incrementing retries in async retry policy

### Translation Document 1.0.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-ai-translation-document_1.0.0b1/sdk/translation/azure-ai-translation-document/CHANGELOG.md#100b1-2021-04-06)
This is the first beta package of the azure-ai-translation-document client library that targets the Document Translation
service version `1.0-preview.1`. This package's documentation and samples demonstrate the new API.

### Cognitive Search 11.2.0b2 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-search-documents_11.2.0b2/sdk/search/azure-search-documents/CHANGELOG.md#1120b2-2021-04-13)
#### New features

- Added support for semantic search    #17638


[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
