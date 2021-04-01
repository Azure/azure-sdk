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

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to make available the April 2021 client library release.

#### GA
- Resource Management - Datadog
- Resource Management - NetApp
- Resource Management - Databricks
- Resource Management - Alerts Management
- Resource Management - Data Box
- Resource Management - Support
- Resource Management - Attestation
- Resource Management - Time Series Insights
- Resource Management - Marketplace Ordering
- Resource Management - Content Delivery Network
- Event Grid
- Resource Management - Private DNS
- Resource Management - Communication
- Resource Management - Frontdoor
- Resource Management - Power BI Dedicated

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Common

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Key Vault - Keys
- Key Vault - Keys
- azure-mgmt-deviceupdate
- Resource Management - Automation
- Resource Management - Rdbms
- Key Vault - Keys
- azure-mgmt-extendedlocation
- Resource Management - Rdbms

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
$> pip install azure-keyvault-keys==4.4.0b1
$> pip install azure-keyvault-keys==4.4.0b3
$> pip install azure-mgmt-datadog==1.0.0
$> pip install azure-mgmt-netapp==2.0.0
$> pip install azure-mgmt-databricks==1.0.0
$> pip install azure-mgmt-deviceupdate==1.0.0b2
$> pip install azure-mgmt-alertsmanagement==1.0.0
$> pip install azure-mgmt-automation==1.1.0b1
$> pip install azure-mgmt-rdbms==8.1.0b1
$> pip install azure-mgmt-databox==1.0.0
$> pip install azure-mgmt-support==6.0.0
$> pip install azure-mgmt-attestation==1.0.0
$> pip install azure-mgmt-timeseriesinsights==1.0.0
$> pip install azure-keyvault-keys==4.4.0b2
$> pip install azure-common==1.1.27
$> pip install azure-mgmt-marketplaceordering==1.1.0
$> pip install azure-mgmt-cdn==11.0.0
$> pip install azure-mgmt-extendedlocation==1.0.0b1
$> pip install azure-eventgrid==4.1.0
$> pip install azure-mgmt-privatedns==1.0.0
$> pip install azure-mgmt-communication==1.0.0
$> pip install azure-mgmt-rdbms==8.1.0b2
$> pip install azure-mgmt-frontdoor==1.0.0
$> pip install azure-mgmt-powerbidedicated==1.0.0

```

[pattern]: # ($> pip install ${PackageName}==${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights
### Key Vault - Keys 4.4.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-keyvault-keys_4.4.0b1/sdk/keyvault/azure-keyvault-keys/CHANGELOG.md#440b1-2021-2-10)
#### Changed
- Key Vault API version 7.2-preview is now the default
- Updated msrest requirement to >=0.6.21

#### Added
- Support for Key Vault API version 7.2-preview
([#16566](https://github.com/Azure/azure-sdk-for-python/pull/16566))
  - Added `oct_hsm` to `KeyType`
  - Added 128-, 192-, and 256-bit AES-GCM, AES-CBC, and AES-CBCPAD encryption
    algorithms to `EncryptionAlgorithm`
  - Added 128- and 192-bit AES-KW key wrapping algorithms to `KeyWrapAlgorithm`
  - `CryptographyClient`'s `encrypt` method accepts `iv` and 
    `additional_authenticated_data` keyword arguments
  - `CryptographyClient`'s `decrypt` method accepts `iv`, 
    `additional_authenticated_data`, and `authentication_tag` keyword arguments
  - Added `iv`, `aad`, and `tag` properties to `EncryptResult`
- Added method `parse_key_vault_key_id` that parses out a full ID returned by
Key Vault, so users can easily access the key's `name`, `vault_url`, and `version`.

### Key Vault - Keys 4.4.0b3 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-keyvault-keys_4.4.0b3/sdk/keyvault/azure-keyvault-keys/CHANGELOG.md#440b3-2021-3-11)
#### Added
- `CryptographyClient` will perform all operations locally if initialized with
  the `.from_jwk` factory method
  ([#16565](https://github.com/Azure/azure-sdk-for-python/pull/16565))
- Added requirement for six>=1.12.0

### Resource Management - Datadog 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-datadog_1.0.0/sdk/datadog/azure-mgmt-datadog/CHANGELOG.md#100-2021-03-22)
**Features**

  - Model DatadogAgreementResource has a new parameter system_data
  - Model MonitoringTagRules has a new parameter system_data
  - Model DatadogSingleSignOnResource has a new parameter system_data
  - Model DatadogMonitorResource has a new parameter system_data

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

### Resource Management - Databricks 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-databricks_1.0.0/sdk/databricks/azure-mgmt-databricks/CHANGELOG.md#100-2021-03-19)
- GA release

### azure-mgmt-deviceupdate 1.0.0b2 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-deviceupdate_1.0.0b2/sdk/deviceupdate/azure-mgmt-deviceupdate/CHANGELOG.md#100b2-2021-03-24)
**Breaking changes**

  - Removed operation InstancesOperations.list_by_subscription
  - Model ErrorResponse has a new signature
  - Model ErrorDefinition has a new signature

### Resource Management - Alerts Management 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-alertsmanagement_1.0.0/sdk/alertsmanagement/azure-mgmt-alertsmanagement/CHANGELOG.md#100-2021-03-16)
- GA release

### Resource Management - Automation 1.1.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-automation_1.1.0b1/sdk/automation/azure-mgmt-automation/CHANGELOG.md#110b1-2021-03-16)
**Features**

  - Model SoftwareUpdateConfigurationCollectionItem has a new parameter tasks

### Resource Management - Rdbms 8.1.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-rdbms_8.1.0b1/sdk/rdbms/azure-mgmt-rdbms/CHANGELOG.md#810b1-2021-03-17)
**Features**

  - Added operation ServerSecurityAlertPoliciesOperations.list_by_server

### Resource Management - Data Box 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-databox_1.0.0/sdk/databox/azure-mgmt-databox/CHANGELOG.md#100-2021-03-18)
- GA release

### Resource Management - Support 6.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-support_6.0.0/sdk/support/azure-mgmt-support/CHANGELOG.md#600-2021-03-29)
- GA release

### Resource Management - Attestation 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-attestation_1.0.0/sdk/attestation/azure-mgmt-attestation/CHANGELOG.md#100-2021-03-16)
* GA release

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

### Key Vault - Keys 4.4.0b2 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-keyvault-keys_4.4.0b2/sdk/keyvault/azure-keyvault-keys/CHANGELOG.md#440b2-2021-2-10)
#### Fixed
- API versions older than 7.2-preview no longer raise `ImportError` when
  performing async operations ([#16680](https://github.com/Azure/azure-sdk-for-python/pull/16680))

### Common 1.1.27 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-common_1.1.27/sdk/core/azure-common/CHANGELOG.md#1127-2021-03-23)
- Deprecate JSON and auth file client factory  #15075
- Add 2020-09-01-hybrid profile definition  #14642

### Resource Management - Marketplace Ordering 1.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-marketplaceordering_1.1.0/sdk/marketplaceordering/azure-mgmt-marketplaceordering/CHANGELOG.md#110-2021-03-17)
**Features**

  - Model AgreementTerms has a new parameter system_data
  - Model AgreementTerms has a new parameter marketplace_terms_link

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

### azure-mgmt-extendedlocation 1.0.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-extendedlocation_1.0.0b1/sdk/extendedlocation/azure-mgmt-extendedlocation/CHANGELOG.md#100b1-2021-03-25)
* Initial Release

### Event Grid 4.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-eventgrid_4.1.0/sdk/eventgrid/azure-eventgrid/CHANGELOG.md#410-2021-03-23)
**New Features**
  - Added new SystemEventNames `AcsChatThreadParticipantRemovedEventName`, `AcsChatThreadParticipantAddedEventName` and `AcsRecordingFileStatusUpdatedEventName`.

### Resource Management - Private DNS 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-privatedns_1.0.0/sdk/network/azure-mgmt-privatedns/CHANGELOG.md#100-2021-03-25)
- GA release

### Resource Management - Communication 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-communication_1.0.0/sdk/communication/azure-mgmt-communication/CHANGELOG.md#100-2021-03-29)
**Features**

  - Model CommunicationServiceResource has a new parameter system_data
  - Model Operation has a new parameter action_type
  - Model Operation has a new parameter is_data_action
  - Added operation CommunicationServiceOperations.check_name_availability

**Breaking changes**

  - Model Operation no longer has parameter properties

### Resource Management - Rdbms 8.1.0b2 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-rdbms_8.1.0b2/sdk/rdbms/azure-mgmt-rdbms/CHANGELOG.md#810b2-2021-03-19)
**Features**

  - Model Server has a new parameter source_subscription_id
  - Model Server has a new parameter source_resource_group_name

### Resource Management - Frontdoor 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-frontdoor_1.0.0/sdk/network/azure-mgmt-frontdoor/CHANGELOG.md#100-2021-03-26)
- GA release

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


[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
