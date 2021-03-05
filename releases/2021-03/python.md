---
title: Azure SDK for Python (March 2021)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

<!--
azure-storage-file-datalake:12.3.0
azure-mgmt-servicefabricmanagedclusters:1.0.0b1
azure-mgmt-web:2.0.0
azure-storage-blob:12.8.0
azure-mgmt-resource:16.0.0
azure-mgmt-cosmosdb:6.1.0
azure-mgmt-deviceupdate:1.0.0b1
azure-mgmt-datadog:1.0.0b3
azure-keyvault-keys:4.4.0b1
azure-keyvault-keys:4.4.0b2
azure-mgmt-containerservice:15.0.0

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to make available the March 2021 client library release.

#### GA
- Storage - Files Data Lake
- Resource Management - Web
- Storage - Blobs
- Resource Management - Resources
- Resource Management - Cosmos DB
- Resource Management - Container Service

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- azure-mgmt-servicefabricmanagedclusters
- azure-mgmt-deviceupdate
- Resource Management - Datadog
- Key Vault - Keys
- Key Vault - Keys

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
$> pip install azure-storage-file-datalake==12.3.0
$> pip install azure-mgmt-servicefabricmanagedclusters==1.0.0b1
$> pip install azure-mgmt-web==2.0.0
$> pip install azure-storage-blob==12.8.0
$> pip install azure-mgmt-resource==16.0.0
$> pip install azure-mgmt-cosmosdb==6.1.0
$> pip install azure-mgmt-deviceupdate==1.0.0b1
$> pip install azure-mgmt-datadog==1.0.0b3
$> pip install azure-keyvault-keys==4.4.0b1
$> pip install azure-keyvault-keys==4.4.0b2
$> pip install azure-mgmt-containerservice==15.0.0

```

[pattern]: # ($> pip install ${PackageName}==${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights
### Storage - Files Data Lake 12.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-storage-file-datalake_12.3.0/sdk/storage/azure-storage-file-datalake/CHANGELOG.md#1230-2021-03-01)
**Stable release of preview features**
- Added support for `DatalakeServiceClient.undelete_filesystem()`
- Added support for `DirectoryClient.exists()`, `FileClient.exists()` and `FileSystemClient.exists()`

**Fixes**
- Fixed `DatalakeServiceClient` context manager/session closure issue (#15358)
- `PurePosixPath` is now handled correctly if passed as a path (#16159)

### azure-mgmt-servicefabricmanagedclusters 1.0.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-servicefabricmanagedclusters_1.0.0b1/sdk/servicefabricmanagedclusters/azure-mgmt-servicefabricmanagedclusters/CHANGELOG.md#100b1-2021-02-26)
* Initial Release

### Resource Management - Web 2.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-web_2.0.0/sdk/appservice/azure-mgmt-web/CHANGELOG.md#200-2021-02-25)
**Features**

  - Model Usage has a new parameter system_data
  - Model StaticSiteFunctionOverviewARMResource has a new parameter system_data
  - Model HybridConnection has a new parameter system_data
  - Model GeoRegion has a new parameter system_data
  - Model IpSecurityRestriction has a new parameter headers
  - Model StaticSiteBuildARMResource has a new parameter system_data
  - Model PushSettings has a new parameter system_data
  - Model SlotDifference has a new parameter system_data
  - Model AppServiceCertificatePatchResource has a new parameter system_data
  - Model DiagnosticDetectorResponse has a new parameter system_data
  - Model MetricSpecification has a new parameter supported_aggregation_types
  - Model PremierAddOnPatchResource has a new parameter system_data
  - Model SitePatchResource has a new parameter custom_domain_verification_id
  - Model SitePatchResource has a new parameter system_data
  - Model SitePatchResource has a new parameter client_cert_mode
  - Model HostNameBinding has a new parameter system_data
  - Model CustomHostnameAnalysisResult has a new parameter system_data
  - Model VnetGateway has a new parameter system_data
  - Model MSDeployLog has a new parameter system_data
  - Model Site has a new parameter custom_domain_verification_id
  - Model Site has a new parameter system_data
  - Model Site has a new parameter client_cert_mode
  - Model PrivateEndpointConnectionResource has a new parameter system_data
  - Model ResourceHealthMetadata has a new parameter system_data
  - Model CertificatePatchResource has a new parameter system_data
  - Model WorkerPoolResource has a new parameter system_data
  - Model AppServiceEnvironmentResource has a new parameter system_data
  - Model DetectorResponse has a new parameter system_data
  - Model TriggeredWebJob has a new parameter system_data
  - Model SiteSourceControl has a new parameter is_git_hub_action
  - Model SiteSourceControl has a new parameter system_data
  - Model MSDeploy has a new parameter system_data
  - Model TriggeredJobHistory has a new parameter system_data
  - Model SiteConfigResource has a new parameter vnet_route_all_enabled
  - Model SiteConfigResource has a new parameter system_data
  - Model SiteConfigResource has a new parameter scm_min_tls_version
  - Model SiteConfigResource has a new parameter vnet_private_ports_count
  - Model BackupRequest has a new parameter system_data
  - Model DeletedSite has a new parameter system_data
  - Model RenewCertificateOrderRequest has a new parameter system_data
  - Model StorageMigrationResponse has a new parameter system_data
  - Model CsmPublishingCredentialsPoliciesCollection has a new parameter system_data
  - Model AddressResponse has a new parameter system_data
  - Model BillingMeter has a new parameter system_data
  - Model Deployment has a new parameter system_data
  - Model ProcessModuleInfo has a new parameter system_data
  - Model CertificateEmail has a new parameter system_data
  - Model Certificate has a new parameter system_data
  - Model StaticSitePatchResource has a new parameter system_data
  - Model SitePhpErrorLogFlag has a new parameter system_data
  - Model CsmPublishingCredentialsPoliciesEntity has a new parameter system_data
  - Model SwiftVirtualNetwork has a new parameter system_data
  - Model VnetRoute has a new parameter system_data
  - Model ConnectionStringDictionary has a new parameter system_data
  - Model WebSiteInstanceStatus has a new parameter system_data
  - Model WebSiteInstanceStatus has a new parameter health_check_url
  - Model HybridConnectionKey has a new parameter system_data
  - Model PremierAddOnOffer has a new parameter system_data
  - Model ContinuousWebJob has a new parameter system_data
  - Model SnapshotRestoreRequest has a new parameter system_data
  - Model SiteAuthSettings has a new parameter git_hub_client_id
  - Model SiteAuthSettings has a new parameter microsoft_account_client_secret_setting_name
  - Model SiteAuthSettings has a new parameter git_hub_client_secret
  - Model SiteAuthSettings has a new parameter is_auth_from_file
  - Model SiteAuthSettings has a new parameter auth_file_path
  - Model SiteAuthSettings has a new parameter google_client_secret_setting_name
  - Model SiteAuthSettings has a new parameter git_hub_client_secret_setting_name
  - Model SiteAuthSettings has a new parameter aad_claims_authorization
  - Model SiteAuthSettings has a new parameter system_data
  - Model SiteAuthSettings has a new parameter git_hub_o_auth_scopes
  - Model SiteAuthSettings has a new parameter client_secret_setting_name
  - Model SiteAuthSettings has a new parameter twitter_consumer_secret_setting_name
  - Model SiteAuthSettings has a new parameter facebook_app_secret_setting_name
  - Model DetectorDefinition has a new parameter system_data
  - Model SiteConfigurationSnapshotInfo has a new parameter system_data
  - Model PublicCertificate has a new parameter system_data
  - Model DomainOwnershipIdentifier has a new parameter system_data
  - Model StringDictionary has a new parameter system_data
  - Model PrivateLinkConnectionApprovalRequestResource has a new parameter system_data
  - Model SlotConfigNamesResource has a new parameter system_data
  - Model WebJob has a new parameter system_data
  - Model ApplicationStackResource has a new parameter system_data
  - Model ReissueCertificateOrderRequest has a new parameter system_data
  - Model User has a new parameter system_data
  - Model RestoreRequest has a new parameter system_data
  - Model StaticSiteUserInvitationRequestResource has a new parameter system_data
  - Model StorageMigrationOptions has a new parameter system_data
  - Model HybridConnectionLimits has a new parameter system_data
  - Model StaticSiteUserARMResource has a new parameter system_data
  - Model AppServiceCertificateResource has a new parameter system_data
  - Model AnalysisDefinition has a new parameter system_data
  - Model VnetInfo has a new parameter system_data
  - Model DomainPatchResource has a new parameter system_data
  - Model MSDeployStatus has a new parameter system_data
  - Model MigrateMySqlRequest has a new parameter system_data
  - Model Identifier has a new parameter system_data
  - Model SiteLogsConfig has a new parameter system_data
  - Model AppServiceCertificateOrder has a new parameter system_data
  - Model BackupItem has a new parameter system_data
  - Model ProcessInfo has a new parameter system_data
  - Model MigrateMySqlStatus has a new parameter system_data
  - Model StaticSiteResetPropertiesARMResource has a new parameter system_data
  - Model NetworkFeatures has a new parameter system_data
  - Model Recommendation has a new parameter system_data
  - Model ProcessThreadInfo has a new parameter system_data
  - Model AzureStoragePropertyDictionaryResource has a new parameter system_data
  - Model Domain has a new parameter system_data
  - Model StaticSiteARMResource has a new parameter system_data
  - Model ResourceMetricDefinition has a new parameter system_data
  - Model VnetValidationTestFailure has a new parameter system_data
  - Model StaticSiteUserInvitationResponseResource has a new parameter system_data
  - Model PrivateAccess has a new parameter system_data
  - Model SiteConfig has a new parameter vnet_route_all_enabled
  - Model SiteConfig has a new parameter vnet_private_ports_count
  - Model SiteConfig has a new parameter scm_min_tls_version
  - Model FunctionEnvelope has a new parameter system_data
  - Model TopLevelDomain has a new parameter system_data
  - Model RecommendationRule has a new parameter system_data
  - Model RelayServiceConnectionEntity has a new parameter system_data
  - Model ProxyOnlyResource has a new parameter system_data
  - Model Snapshot has a new parameter system_data
  - Model VnetParameters has a new parameter system_data
  - Model DiagnosticAnalysis has a new parameter system_data
  - Model CertificateOrderAction has a new parameter system_data
  - Model DeletedAppRestoreRequest has a new parameter system_data
  - Model AppServicePlan has a new parameter system_data
  - Model Resource has a new parameter system_data
  - Model StaticSiteCustomDomainOverviewARMResource has a new parameter system_data
  - Model PremierAddOn has a new parameter system_data
  - Model TriggeredJobRun has a new parameter system_data
  - Model LogSpecification has a new parameter log_filter_pattern
  - Model DiagnosticCategory has a new parameter system_data
  - Model SourceControl has a new parameter system_data
  - Model VnetValidationFailureDetails has a new parameter system_data
  - Model AppServiceEnvironmentPatchResource has a new parameter system_data
  - Model AppServiceCertificateOrderPatchResource has a new parameter system_data
  - Model SiteExtensionInfo has a new parameter system_data
  - Model AppServicePlanPatchResource has a new parameter system_data
  - Added operation WebAppsOperations.update_auth_settings_v2
  - Added operation WebAppsOperations.update_auth_settings_v2_slot
  - Added operation WebAppsOperations.get_auth_settings_v2
  - Added operation WebAppsOperations.get_auth_settings_v2_slot
  - Added operation StaticSitesOperations.preview_workflow
  - Added operation WebSiteManagementClientOperationsMixin.generate_github_access_token_for_appservice_cli_async

**Breaking changes**

  - Model SiteConfigResource no longer has parameter acr_use_managed_identity_creds
  - Model SiteConfigResource no longer has parameter acr_user_managed_identity_id
  - Model SiteConfig no longer has parameter acr_use_managed_identity_creds
  - Model SiteConfig no longer has parameter acr_user_managed_identity_id
  - Model FunctionSecrets has a new signature
  - Removed operation WebAppsOperations.get_app_settings_key_vault_references
  - Removed operation WebAppsOperations.get_app_setting_key_vault_reference

### Storage - Blobs 12.8.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-storage-blob_12.8.0/sdk/storage/azure-storage-blob/CHANGELOG.md#1280-2021-03-01)
**Stable release of preview features**
- Added `ContainerClient.exists()` method
- Added container SAS support for blob batch operations

**Fixes**
- Fixed `delete_blob()` method signature (#15891)
- Fixed Content-MD5 throwing when passed (#15919)

### Resource Management - Resources 16.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-resource_16.0.0/sdk/resources/azure-mgmt-resource/CHANGELOG.md#1600-2021-02-26)
**Features**

  - Model ParameterDefinitionsValueMetadata has a new parameter strong_type
  - Model ParameterDefinitionsValueMetadata has a new parameter assign_permissions
  - Model ProviderResourceType has a new parameter location_mappings
  - Model DeploymentProperties has a new parameter expression_evaluation_options
  - Model PolicyAssignment has a new parameter non_compliance_messages
  - Model TemplateLink has a new parameter query_string
  - Model TemplateSpec has a new parameter versions
  - Model DeploymentWhatIfProperties has a new parameter expression_evaluation_options
  - Added operation ApplicationDefinitionsOperations.get_by_id
  - Added operation ApplicationDefinitionsOperations.begin_create_or_update_by_id
  - Added operation ApplicationDefinitionsOperations.begin_delete_by_id
  - Added operation ProvidersOperations.register_at_management_group_scope
  - Added operation PolicySetDefinitionsOperations.list_by_management_group
  - Added operation PolicyDefinitionsOperations.list_by_management_group
  - Added operation group ProviderResourceTypesOperations
  - Added operation group DataPolicyManifestsOperations
  - Added operation group ApplicationClientOperationsMixin
  - Added operation group PolicyExemptionsOperations

**Breaking changes**

  - Operation PolicyAssignmentsOperations.list has a new signature
  - Operation PolicyAssignmentsOperations.list_for_management_group has a new signature
  - Operation PolicyAssignmentsOperations.list_for_resource has a new signature
  - Operation PolicyAssignmentsOperations.list_for_resource_group has a new signature
  - Operation TemplateSpecsOperations.get has a new signature
  - Operation TemplateSpecsOperations.list_by_resource_group has a new signature
  - Operation TemplateSpecsOperations.list_by_subscription has a new signature
  - Model PolicyAssignment no longer has parameter sku
  - Operation PolicySetDefinitionsOperations.list_built_in has a new signature
  - Operation PolicySetDefinitionsOperations.list has a new signature
  - Operation PolicyDefinitionsOperations.list_built_in has a new signature
  - Operation PolicyDefinitionsOperations.list has a new signature

### Resource Management - Cosmos DB 6.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-cosmosdb_6.1.0/sdk/cosmos/azure-mgmt-cosmosdb/CHANGELOG.md#610-2021-03-02)
**Features**

  - Model DatabaseAccountGetResults has a new parameter network_acl_bypass
  - Model DatabaseAccountGetResults has a new parameter backup_policy
  - Model DatabaseAccountGetResults has a new parameter identity
  - Model DatabaseAccountGetResults has a new parameter network_acl_bypass_resource_ids
  - Model PrivateEndpointConnection has a new parameter group_id
  - Model PrivateEndpointConnection has a new parameter provisioning_state
  - Model ContainerPartitionKey has a new parameter system_key
  - Model DatabaseAccountUpdateParameters has a new parameter network_acl_bypass
  - Model DatabaseAccountUpdateParameters has a new parameter backup_policy
  - Model DatabaseAccountUpdateParameters has a new parameter identity
  - Model DatabaseAccountUpdateParameters has a new parameter network_acl_bypass_resource_ids
  - Model PrivateLinkServiceConnectionStateProperty has a new parameter description
  - Model DatabaseAccountCreateUpdateParameters has a new parameter network_acl_bypass
  - Model DatabaseAccountCreateUpdateParameters has a new parameter backup_policy
  - Model DatabaseAccountCreateUpdateParameters has a new parameter identity
  - Model DatabaseAccountCreateUpdateParameters has a new parameter network_acl_bypass_resource_ids

### azure-mgmt-deviceupdate 1.0.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-deviceupdate_1.0.0b1/sdk/deviceupdate/azure-mgmt-deviceupdate/CHANGELOG.md#100b1-2021-03-02)
* Initial Release

### Resource Management - Datadog 1.0.0b3 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-datadog_1.0.0b3/sdk/datadog/azure-mgmt-datadog/CHANGELOG.md#100b3-2021-03-02)
**Features**

  - Model DatadogOrganizationProperties has a new parameter application_key
  - Model DatadogOrganizationProperties has a new parameter redirect_uri
  - Model DatadogOrganizationProperties has a new parameter api_key
  - Model MonitoringTagRulesProperties has a new parameter provisioning_state
  - Model DatadogSingleSignOnProperties has a new parameter provisioning_state
  - Added operation MarketplaceAgreementsOperations.create_or_update
  - Added operation MonitorsOperations.list_monitored_resources
  - Added operation MonitorsOperations.refresh_set_password_link
  - Added operation MonitorsOperations.get_default_key
  - Added operation MonitorsOperations.set_default_key
  - Added operation MonitorsOperations.list_api_keys
  - Added operation MonitorsOperations.list_hosts
  - Added operation MonitorsOperations.list_linked_resources

**Breaking changes**

  - Removed operation MarketplaceAgreementsOperations.create
  - Removed operation group RefreshSetPasswordOperations
  - Removed operation group HostsOperations
  - Removed operation group ApiKeysOperations
  - Removed operation group MonitoredResourcesOperations
  - Removed operation group LinkedResourcesOperations

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

### Key Vault - Keys 4.4.0b2 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-keyvault-keys_4.4.0b2/sdk/keyvault/azure-keyvault-keys/CHANGELOG.md#440b2-2021-2-10)
#### Fixed
- API versions older than 7.2-preview no longer raise `ImportError` when
  performing async operations ([#16680](https://github.com/Azure/azure-sdk-for-python/pull/16680))

### Resource Management - Container Service 15.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-containerservice_15.0.0/sdk/containerservice/azure-mgmt-containerservice/CHANGELOG.md#1500-2021-03-03)
**Features**

  - Model ManagedClusterPropertiesAutoScalerProfile has a new parameter max_node_provision_time
  - Model ManagedClusterPodIdentityProfile has a new parameter allow_network_plugin_kubenet
  - Model KubeletConfig has a new parameter container_log_max_size_mb
  - Model KubeletConfig has a new parameter pod_max_pids
  - Model KubeletConfig has a new parameter container_log_max_files
  - Model SysctlConfig has a new parameter net_core_rmem_default
  - Model SysctlConfig has a new parameter net_core_wmem_default
  - Model Components1Q1Og48SchemasManagedclusterAllof1 has a new parameter azure_portal_fqdn
  - Model Components1Q1Og48SchemasManagedclusterAllof1 has a new parameter fqdn_subdomain
  - Model ManagedCluster has a new parameter azure_portal_fqdn
  - Model ManagedCluster has a new parameter fqdn_subdomain
  - Model ManagedClusterAgentPoolProfile has a new parameter kubelet_disk_type
  - Model ManagedClusterAgentPoolProfile has a new parameter enable_encryption_at_host
  - Model ManagedClusterAgentPoolProfile has a new parameter node_public_ip_prefix_id
  - Model ManagedClusterAgentPoolProfileProperties has a new parameter kubelet_disk_type
  - Model ManagedClusterAgentPoolProfileProperties has a new parameter enable_encryption_at_host
  - Model ManagedClusterAgentPoolProfileProperties has a new parameter node_public_ip_prefix_id
  - Model AgentPool has a new parameter kubelet_disk_type
  - Model AgentPool has a new parameter enable_encryption_at_host
  - Model AgentPool has a new parameter node_public_ip_prefix_id
  - Added operation group MaintenanceConfigurationsOperations

**Breaking changes**

  - Model SysctlConfig no longer has parameter net_ipv4_tcp_rmem
  - Model SysctlConfig no longer has parameter net_ipv4_tcp_wmem

[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
