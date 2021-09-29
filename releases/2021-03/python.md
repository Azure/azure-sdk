---
title: Azure SDK for Python (March 2021)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

<!--
azure-ai-textanalytics:5.1.0b6
azure-core:1.12.0
azure-eventgrid:4.0.0
azure-eventhub:5.3.1
azure-eventhub:5.4.0b1
azure-eventhub-checkpointstoreblob-aio:1.1.3
azure-eventhub-checkpointstoreblob:1.1.3
azure-identity:1.6.0b2
azure-iot-deviceupdate:1.0.0b1
azure-keyvault-keys:4.4.0b3
azure-mgmt-cosmosdb:6.1.0
azure-mgmt-containerservice:15.0.0
azure-mgmt-datadog:1.0.0b3
azure-mgmt-deviceupdate:1.0.0b1
azure-mgmt-resource:16.0.0
azure-mgmt-resourcemover:1.1.0b1
azure-mgmt-servicefabricmanagedclusters:1.0.0b1
azure-mgmt-web:2.0.0
azure-servicebus:7.1.0
azure-storage-blob:12.8.0
azure-storage-file-datalake:12.3.0
azure-synapse-accesscontrol:0.6.0
azure-synapse-artifacts:0.5.0
azure-synapse-managedprivateendpoints:0.3.0
azure-synapse-monitoring:0.2.0
azure-synapse-spark:0.5.0
azure-data-tables:12.0.0b5
azure-keyvault-keys:4.4.0b1
azure-keyvault-keys:4.4.0b2

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to make available the March 2021 client library release.

#### GA
- Event Grid
- Resource Management - Container Service
- Resource Management - Resources
- Resource Management - Web

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Core
- Event Hubs
- Event Hubs - Azure Blob Storage Checkpoint Store
- Event Hubs - Azure Blob Storage Checkpoint Store AIO
- Resource Management - Cosmos DB
- Service Bus
- Storage - Blobs
- Storage - Files Data Lake

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Azure Communication Identity
- Azure Communication Chat
- Azure Communication Phone Numbers
- Azure Communication SMS
- azure-mgmt-deviceupdate
- azure-mgmt-servicefabricmanagedclusters
- azure-iot-deviceupdate
- Event Hubs
- Identity
- Key Vault - Keys
- Resource Management - Datadog
- Resource Management - Resource Mover
- Synapse - AccessControl
- Synapse - Artifacts
- Synapse - Managed Private Endpoints
- Synapse - Monitoring
- Synapse - Spark
- Tables
- Text Analytics

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
$> pip install azure-ai-textanalytics==5.1.0b6
$> pip install azure-communication-identity
$> pip install azure-communication-chat
$> pip install azure-communication-sms
$> pip install azure-communication-phonenumbers
$> pip install azure-core==1.12.0
$> pip install azure-data-tables==12.0.0b5
$> pip install azure-eventgrid==4.0.0
$> pip install azure-eventhub==5.3.1
$> pip install azure-eventhub==5.4.0b1
$> pip install azure-eventhub-checkpointstoreblob==1.1.3
$> pip install azure-eventhub-checkpointstoreblob-aio==1.1.3
$> pip install azure-identity==1.6.0b2
$> pip install azure-iot-deviceupdate==1.0.0b1
$> pip install azure-keyvault-keys==4.4.0b3
$> pip install azure-mgmt-containerservice==15.0.0
$> pip install azure-mgmt-cosmosdb==6.1.0
$> pip install azure-mgmt-datadog==1.0.0b3
$> pip install azure-mgmt-deviceupdate==1.0.0b1
$> pip install azure-mgmt-resource==16.0.0
$> pip install azure-mgmt-resourcemover==1.1.0b1
$> pip install azure-mgmt-servicefabricmanagedclusters==1.0.0b1
$> pip install azure-mgmt-web==2.0.0
$> pip install azure-servicebus==7.1.0
$> pip install azure-storage-blob==12.8.0
$> pip install azure-storage-file-datalake==12.3.0
$> pip install azure-synapse-accesscontrol==0.6.0
$> pip install azure-synapse-artifacts==0.5.0
$> pip install azure-synapse-managedprivateendpoints==0.3.0
$> pip install azure-synapse-monitoring==0.2.0
$> pip install azure-synapse-spark==0.5.0
```

[pattern]: # ($> pip install ${PackageName}==${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights
### Text Analytics 5.1.0b6 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-ai-textanalytics_5.1.0b6/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#510b6-2021-03-09)
**New Features**
- Added `RecognizeLinkedEntitiesAction` as a supported action type for `begin_analyze_batch_actions`.
- Added parameter `categories_filter` to the `recognize_pii_entities` client method.
- Added enum `PiiEntityCategoryType`.
- Add property `normalized_text` to `HealthcareEntity`. This property is a normalized version of the `text` property that already
exists on the `HealthcareEntity`
- Add property `assertion` onto `HealthcareEntity`. This contains assertions about the entity itself, i.e. if the entity represents a diagnosis,
is this diagnosis conditional on a symptom?

**Breaking Changes**
- By default, we now target the service's `v3.1-preview.4` endpoint through enum value `TextAnalyticsApiVersion.V3_1_PREVIEW`
- Removed property `related_entities` on `HealthcareEntity` and added `entity_relations` onto the document response level for healthcare
- Renamed properties `aspect` and `opinions` to `target` and `assessments` respectively in class `MinedOpinion`.
- Renamed classes `AspectSentiment` and `OpinionSentiment` to `TargetSentiment` and `AssessmentSentiment` respectively.

**Known Issues**

- `begin_analyze_healthcare_entities` is currently in gated preview and can not be used with AAD credentials. For more information, see [the Text Analytics for Health documentation](https://docs.microsoft.com/azure/cognitive-services/text-analytics/how-tos/text-analytics-for-health?tabs=ner#request-access-to-the-public-preview).
- At time of this SDK release, the service is not respecting the value passed through `model_version` to `begin_analyze_healthcare_entities`, it only uses the latest model.

### Azure Communication Administration is deprecated
- Phone number administration is moved into the new package `azure-communication-phonenumbers`.

### Azure Communication Phone Numbers 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/communication/azure-communication-phonenumbers/CHANGELOG.md#100b4-2021-03-09)

##### New Features

- Added `PhoneNumbersClient` (originally was part of the `azure.communication.administration` package).

### Azure Communication Chat 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/communication/azure-communication-chat/CHANGELOG.md#100b5-2021-03-09)

##### New Features

- Removed nullable references from method signatures.

#### Breaking Changes

- Added support for communication identifiers instead of raw strings.
- Changed return type of `create_chat_thread`: `ChatThreadClient -> CreateChatThreadResult`
- Changed return types `add_participants`: `None -> list[(ChatThreadParticipant, CommunicationError)]`
- Added check for failure in `add_participant`

### Azure Communication Identity 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/communication/azure-communication-identity/CHANGELOG.md#100b5-2021-03-09)

#### Breaking Changes

- CommunicationIdentityClient's (synchronous and asynchronous) `issue_token` function is now renamed to `get_token`.
- The CommunicationIdentityClient constructor uses type `TokenCredential` and `AsyncTokenCredential` for the credential parameter.

### Azure Communication SMS 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/communication/azure-communication-sms/CHANGELOG.md#100b5-2021-03-09)

#### New Features

- Added support for Azure Active Directory authentication.
- Added support for 1:N SMS messaging.
- Added support for SMS idempotency.
- Send method series in SmsClient are idempotent under retry policy.
- Added support for tagging SMS messages.
- The SmsClient constructor uses type `TokenCredential` and `AsyncTokenCredential` for the credential parameter.

#### Breaking Changes

- Send method takes in strings for phone numbers instead of `PhoneNumberIdentifier`.
- Send method returns a list of `SmsSendResult`s instead of a `SendSmsResponse`.

### Core 1.12.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-core_1.12.0/sdk/core/azure-core/CHANGELOG.md#1120-2021-03-08)
This version will be the last version to officially support Python 3.5, future versions will require Python 2.7 or Python 3.6+.

#### New Features

- Added `azure.core.messaging.CloudEvent` model that follows the cloud event spec.
- Added `azure.core.serialization.NULL` sentinel value
- Improve `repr`s for `HttpRequest` and `HttpResponse`s  #16972

#### Bug Fixes

- Disable retry in stream downloading. (thanks to @jochen-ott-by @hoffmann for the contribution)  #16723

### Device Update 1.0.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/deviceupdate/azure-iot-deviceupdate/CHANGELOG.md#100b1-2021-03-03)

* Initial Release

### Event Grid 4.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-eventgrid_4.0.0/sdk/eventgrid/azure-eventgrid/CHANGELOG.md#400-2021-03-09)
**Notes**
This is the first stable release of our efforts to create a user-friendly and Python client library for Azure EventGrid. Users migrating from `v1.x` are advised to view the [migration guide](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/eventgrid/azure-eventgrid/migration_guide.md)

**New Features**
- `azure-eventgrid` package now supports `azure.core.messaging.CloudEvent` which honors the CNCF CloudEvent spec.
- `azure.eventgrid.SystemEventNames` can be used to get the event model type mapping for system events.
- Implements the `EventGridPublisherClient` for the publish flow for EventGrid Events, CloudEvents and Custom schema events.

**Breaking Changes**
- `azure.eventgrid.models` namespace along with all the models in it are now removed:
  - JSON documentation on the events is available here: https://docs.microsoft.com/azure/event-grid/system-topics
  - `azure.eventgrid.SystemEventNames` provides the list of available events name for easy switching.
- `azure.eventgrid.event_grid_client.EventGridClient` is now removed in favor of `azure.eventgrid.EventGridPublisherClient`.
- `azure.eventgrid.event_grid_client.EventGridClientConfiguration` is now removed.

### Event Hubs 5.3.1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-eventhub_5.3.1/sdk/eventhub/azure-eventhub/CHANGELOG.md#531-2021-03-09)
This version will be the last version to officially support Python 3.5, future versions will require Python 2.7 or Python 3.6+.

**Bug fixes**

- Sending empty `event_data_batch` will be a no-op now instead of raising error.

### Event Hubs 5.4.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/feature/eventhub%2Fidempotent-producer/sdk/eventhub/azure-eventhub/CHANGELOG.md#540b1-2021-03-09)

This version and all future versions will require Python 2.7 or Python 3.6+, Python 3.5 is no longer supported.

#### New Features

- Added support for idempotent publishing which is supported by the service to endeavor to reduce the number of duplicate
  events that are published.
  - `EventHubProducerClient` constructor accepts two new parameters for idempotent publishing:
    - `enable_idempotent_partitions`: A boolean value to tell the `EventHubProducerClient` whether to enable idempotency.
    - `partition_config`: The set of configurations that can be specified to influence publishing behavior
     specific to the configured Event Hub partition.
  - Introduced a new method `get_partition_publishing_properties` on `EventHubProducerClient` to inspect the information
    about the state of publishing for a partition.
  - Introduced a new property `published_sequence_number` on `EventData` to get the publishing sequence number assigned
    to the event at the time it was successfully published.
  - Introduced a new property `starting_published_sequence_number` on `EventDataBatch` to get the publishing sequence
    number assigned to the first event in the batch at the time the batch was successfully published.
  - Introduced a new class `azure.eventhub.PartitionPublishingConfiguration` which is a set of configurations that can be
    specified to influence the behavior when publishing directly to an Event Hub partition.

#### Notes

- Updated uAMQP dependency to 1.2.15.

### Event Hubs - Azure Blob Storage Checkpoint Store AIO 1.1.3 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-eventhub-checkpointstoreblob-aio_1.1.3/sdk/eventhub/azure-eventhub-checkpointstoreblob-aio/CHANGELOG.md#113-2021-03-09)
This version will be the last version to officially support Python 3.5, future versions will require Python 2.7 or Python 3.6+.

**Bug fixes**
- Updated vendor azure-storage-blob dependency to v12.7.1.
  - Fixed storage blob authentication failure due to request date header too old (#16192).

### Event Hubs - Azure Blob Storage Checkpoint Store 1.1.3 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-eventhub-checkpointstoreblob_1.1.3/sdk/eventhub/azure-eventhub-checkpointstoreblob/CHANGELOG.md#113-2021-03-09)
This version will be the last version to officially support Python 3.5, future versions will require Python 2.7 or Python 3.6+.

**Bug fixes**
- Updated vendor azure-storage-blob dependency to v12.7.1.
  - Fixed storage blob authentication failure due to request date header too old (#16192).

### Identity 1.6.0b2 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-identity_1.6.0b2/sdk/identity/azure-identity/CHANGELOG.md#160b2-2021-03-09)
#### Breaking Changes
> These changes do not impact the API of stable versions such as 1.5.0.
> Only code written against a beta version such as 1.6.0b1 may be affected.
- Renamed `CertificateCredential` keyword argument `certificate_bytes` to
  `certificate_data`
- Credentials accepting keyword arguments `allow_unencrypted_cache` and
  `enable_persistent_cache` to configure persistent caching accept a
  `cache_persistence_options` argument instead whose value should be an
  instance of `TokenCachePersistenceOptions`. For example:
  ```
  # before (e.g. in 1.6.0b1):
  DeviceCodeCredential(enable_persistent_cache=True, allow_unencrypted_cache=True)

  # after:
  cache_options = TokenCachePersistenceOptions(allow_unencrypted_storage=True)
  DeviceCodeCredential(cache_persistence_options=cache_options)
  ```

  See the documentation and samples for more details.

#### New Features
- New class `TokenCachePersistenceOptions` configures persistent caching
- The `AuthenticationRequiredError.claims` property provides any additional
  claims required by a user credential's `authenticate()` method

### Key Vault - Keys 4.4.0b3 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-keyvault-keys_4.4.0b3/sdk/keyvault/azure-keyvault-keys/CHANGELOG.md#440b3-2021-3-11)
#### New Features
- `CryptographyClient` will perform all operations locally if initialized with
  the `.from_jwk` factory method
  ([#16565](https://github.com/Azure/azure-sdk-for-python/pull/16565))
- Added requirement for six>=1.12.0

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

### Resource Management - Cosmos DB 6.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-cosmosdb_6.1.0/sdk/cosmos/azure-mgmt-cosmosdb/CHANGELOG.md#610-2021-03-02)
**New Features**

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

### Resource Management - Datadog 1.0.0b3 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-datadog_1.0.0b3/sdk/datadog/azure-mgmt-datadog/CHANGELOG.md#100b3-2021-03-02)
**New Features**

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

### Resource Manaement -Device Update 1.0.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-deviceupdate_1.0.0b1/sdk/deviceupdate/azure-mgmt-deviceupdate/CHANGELOG.md#100b1-2021-03-02)
* Initial Release

### Resource Management - Resources 16.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-resource_16.0.0/sdk/resources/azure-mgmt-resource/CHANGELOG.md#1600-2021-02-26)
**New Features**

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

### azure-mgmt-servicefabricmanagedclusters 1.0.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-servicefabricmanagedclusters_1.0.0b1/sdk/servicefabricmanagedclusters/azure-mgmt-servicefabricmanagedclusters/CHANGELOG.md#100b1-2021-02-26)
* Initial Release

### Resource Management - Web 2.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-mgmt-web_2.0.0/sdk/appservice/azure-mgmt-web/CHANGELOG.md#200-2021-02-25)
**New Features**

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

**Bug Fixes**
- Fixed `delete_blob()` method signature (#15891)
- Fixed Content-MD5 throwing when passed (#15919)

### Storage - Files Data Lake 12.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-storage-file-datalake_12.3.0/sdk/storage/azure-storage-file-datalake/CHANGELOG.md#1230-2021-03-01)
**Stable release of preview features**
- Added support for `DatalakeServiceClient.undelete_filesystem()`
- Added support for `DirectoryClient.exists()`, `FileClient.exists()` and `FileSystemClient.exists()`

**Bug Fixes**
- Fixed `DatalakeServiceClient` context manager/session closure issue (#15358)
- `PurePosixPath` is now handled correctly if passed as a path (#16159)

### Service Bus 7.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-servicebus_7.1.0/sdk/servicebus/azure-servicebus/CHANGELOG.md#710-2021-03-09)
This version will be the last version to officially support Python 3.5, future versions will require Python 2.7 or Python 3.6+.

**New Features**

* Updated the following methods so that lists and single instances of Mapping representations are accepted for corresponding strongly-typed object arguments (PR #14807, thanks @bradleydamato):
  - `update_queue`, `update_topic`, `update_subscription`, and `update_rule` on `ServiceBusAdministrationClient` accept Mapping representations of `QueueProperties`, `TopicProperties`, `SubscriptionProperties`, and `RuleProperties`, respectively.
  - `send_messages` and `schedule_messages` on both sync and async versions of `ServiceBusSender` accept a list of or single instance of Mapping representations of `ServiceBusMessage`.
  - `add_message` on `ServiceBusMessageBatch` now accepts a Mapping representation of `ServiceBusMessage`.

**Bug Fixes**

* Operations failing due to `uamqp.errors.LinkForceDetach` caused by no activity on the connection for 10 minutes will now be retried internally except for the session receiver case.
* `uamqp.errors.AMQPConnectionError` errors with condition code `amqp:unknown-error` are now categorized into `ServiceBusConnectionError` instead of the general `ServiceBusError`.
* The `update_*` methods on `ServiceBusManagementClient` will now raise a `TypeError` rather than an `AttributeError` in the case of unsupported input type.

### Synapse - Artifacts 0.5.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-synapse-artifacts_0.5.0/sdk/synapse/azure-synapse-artifacts/CHANGELOG.md#050-2021-03-09)
**New Features **

- Add library operations
- Change create_or_update_sql_script, delete_sql_script, rename_sql_script to long running operations

** Breaking changes **

- Stop Python 3.5 support

### Tables 12.0.0b5 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-data-tables_12.0.0b5/sdk/tables/azure-data-tables/CHANGELOG.md#12.0.0b5-2020-03-09)
**New Features **

- Add library operations
- Change create_or_update_sql_script, delete_sql_script, rename_sql_script to long running operations

** Breaking changes **

- Stop Python 3.5 support

[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
