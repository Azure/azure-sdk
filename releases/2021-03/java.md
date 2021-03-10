---
title: Azure SDK for Java (March 2021)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

<!--
azure-resourcemanager-eventgrid:1.0.0-beta.2
azure-resourcemanager-resources:2.2.0
azure-resourcemanager-eventhubs:2.2.0
azure-resourcemanager-redis:2.2.0
azure-mixedreality-remoterendering:1.0.0-beta.1
azure-resourcemanager-iothub:1.0.0-beta.1
azure-resourcemanager-containerservice:2.2.0
azure-resourcemanager-storagecache:1.0.0-beta.1
azure-resourcemanager-network:2.2.0
azure-digitaltwins-core:1.0.3
azure-resourcemanager-dns:2.2.0
azure-resourcemanager-compute:2.2.0
azure-resourcemanager-search:2.2.0
azure-resourcemanager-cosmos:2.2.0
azure-resourcemanager-mediaservices:1.0.0-beta.2
azure-resourcemanager:2.2.0
azure-resourcemanager-storage:2.2.0
azure-resourcemanager-hybridkubernetes:1.0.0-beta.1
azure-resourcemanager-msi:2.2.0
azure-sdk-bom:1.0.2
azure-mixedreality-authentication:1.0.0-beta.1
azure-resourcemanager-containerinstance:2.2.0
azure-resourcemanager-appplatform:2.2.0
azure-resourcemanager-authorization:2.2.0
azure-resourcemanager-keyvault:2.2.0
azure-resourcemanager-appservice:2.2.0
azure-resourcemanager-cdn:2.2.0
azure-resourcemanager-privatedns:2.2.0
azure-resourcemanager-containerregistry:2.2.0
azure-resourcemanager-digitaltwins:1.0.0-beta.1
azure-resourcemanager-monitor:2.2.0
azure-mixedreality-authentication:1.0.0
azure-resourcemanager-trafficmanager:2.2.0
azure-resourcemanager-servicebus:2.2.0
azure-resourcemanager-netapp:1.0.0-beta.1
azure-resourcemanager-redisenterprise:1.0.0-beta.2
azure-resourcemanager-redisenterprise:1.0.0-beta.1
azure-resourcemanager-sql:2.2.0
azure-resourcemanager-datadog:1.0.0-beta.1
azure-resourcemanager-storagecache:1.0.0-beta.2
azure-ai-textanalytics:5.0.4
azure-analytics-synapse-artifacts:1.0.0-beta.3

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to announce our March 2021 client library releases.

#### GA
- Resource Management - Resources
- Resource Management - Event Hubs
- Resource Management - Redis
- Resource Management - Container Service
- Resource Management - Network
- Resource Management - DNS
- Resource Management - Virtual Machines
- Resource Management - Cognitive Search
- Resource Management - Cosmos DB
- Resource Management
- Resource Management - Storage
- Resource Management - Managed Service Identity
- Resource Management - Container Instances
- Resource Management - Spring Cloud
- Resource Management - Authorization
- Resource Management - Key Vault
- Resource Management - App Service
- Resource Management - Content Delivery Network
- Resource Management - Private DNS
- Resource Management - Container Registry
- Resource Management - Monitor
- Azure Mixed Reality Authentication
- Resource Management - Traffic Manager
- Resource Management - Service Bus
- Resource Management - SQL

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Digital Twins - Core
- SDK - Bill of Materials
- Text Analytics

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Resource Management - Event Grid
- Azure Remote Rendering
- azure-resourcemanager-iothub
- Resource Management - Storage Cache
- Resource Management - Media Services
- azure-resourcemanager-hybridkubernetes
- Azure Mixed Reality Authentication
- azure-resourcemanager-digitaltwins
- Resource Management - NetApp Files
- Resource Management - Redis Enterprise
- Resource Management - Redis Enterprise
- azure-resourcemanager-datadog
- Resource Management - Storage Cache
- Synapse - Artifacts
- Azure Communication Common
- Azure Communication Identity
- Azure Communication Chat
- Azure Communication Phone Numbers
- Azure Communication SMS

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-eventgrid</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-resources</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-eventhubs</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-redis</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-mixedreality-remoterendering</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-iothub</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-containerservice</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-storagecache</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-network</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-digitaltwins-core</artifactId>
  <version>1.0.3</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-dns</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-compute</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-search</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-cosmos</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-mediaservices</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-storage</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-hybridkubernetes</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-msi</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-sdk-bom</artifactId>
  <version>1.0.2</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-mixedreality-authentication</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-containerinstance</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-appplatform</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-authorization</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-keyvault</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-appservice</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-cdn</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-privatedns</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-containerregistry</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-digitaltwins</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-monitor</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-mixedreality-authentication</artifactId>
  <version>1.0.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-trafficmanager</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-servicebus</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-netapp</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-redisenterprise</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-redisenterprise</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-sql</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-datadog</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-storagecache</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>5.0.4</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-analytics-synapse-artifacts</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

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
### Resource Management - Event Grid 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-eventgrid_1.0.0-beta.2/sdk/eventgrid/azure-resourcemanager-eventgrid/CHANGELOG.md#100-beta2-2021-02-22)
- Azure Resource Manager EventGrid client library for Java. This package contains Microsoft Azure SDK for EventGrid Management SDK. Azure EventGrid Management Client. Package tag package-2020-10-preview. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### Breaking Change

##### `models.Topics` was modified

* `regenerateKeyWithResponse(java.lang.String,java.lang.String,models.TopicRegenerateKeyRequest,com.azure.core.util.Context)` was removed

#### New Feature

* `models.ExtensionTopic` was added

* `models.CreatedByType` was added

* `models.PartnerNamespaces` was added

* `models.SystemTopic` was added

* `models.StringNotBeginsWithAdvancedFilter` was added

* `models.EventSubscriptionIdentity` was added

* `models.PartnerNamespaceSharedAccessKeys` was added

* `models.PartnerTopicTypeAuthorizationState` was added

* `models.EventChannel` was added

* `models.Sku` was added

* `models.PartnerNamespace` was added

* `models.NumberInRangeAdvancedFilter` was added

* `models.DeadLetterWithResourceIdentity` was added

* `models.IsNotNullAdvancedFilter` was added

* `models.PartnerRegistration$UpdateStages` was added

* `models.PartnerRegistration$Update` was added

* `models.EventChannel$Definition` was added

* `models.UserIdentityProperties` was added

* `models.SystemTopic$Definition` was added

* `models.EventChannels` was added

* `models.EventChannelDestination` was added

* `models.IsNullOrUndefinedAdvancedFilter` was added

* `models.PartnerTopicUpdateParameters` was added

* `models.ResourceSku` was added

* `models.ResourceKind` was added

* `models.PartnerRegistration$DefinitionStages` was added

* `models.EventChannelProvisioningState` was added

* `models.NumberNotInRangeAdvancedFilter` was added

* `models.PartnerTopicEventSubscriptions` was added

* `models.SystemData` was added

* `models.PartnerNamespace$Update` was added

* `models.EventChannel$DefinitionStages` was added

* `models.IdentityInfo` was added

* `models.EventChannelSource` was added

* `models.PartnerTopicReadinessState` was added

* `models.PartnerNamespacesListResult` was added

* `models.SystemTopic$UpdateStages` was added

* `models.DeliveryAttributeListResult` was added

* `models.DeliveryAttributeMapping` was added

* `models.PartnerRegistration$Definition` was added

* `models.StringNotEndsWithAdvancedFilter` was added

* `models.EventChannel$Update` was added

* `models.PartnerTopicActivationState` was added

* `models.SystemTopicUpdateParameters` was added

* `models.PartnerRegistrationProvisioningState` was added

* `models.DeliveryAttributeMappingType` was added

* `models.PartnerTopicType` was added

* `models.PartnerNamespaceUpdateParameters` was added

* `models.IdentityType` was added

* `models.StaticDeliveryAttributeMapping` was added

* `models.PartnerTopics` was added

* `models.DeliveryWithResourceIdentity` was added

* `models.TopicTypePropertiesSupportedScopesForSourceItem` was added

* `models.PartnerRegistrationsListResult` was added

* `models.PartnerRegistrationUpdateParameters` was added

* `models.DynamicDeliveryAttributeMapping` was added

* `models.ExtensionTopics` was added

* `models.EventChannelsListResult` was added

* `models.PartnerRegistration` was added

* `models.SystemTopicsListResult` was added

* `models.PartnerRegistrationVisibilityState` was added

* `models.EventSubscriptionIdentityType` was added

* `models.PartnerNamespace$DefinitionStages` was added

* `models.StringNotContainsAdvancedFilter` was added

* `models.SystemTopic$Update` was added

* `models.EventChannelFilter` was added

* `models.SystemTopic$DefinitionStages` was added

* `models.PartnerNamespaceProvisioningState` was added

* `models.PartnerTopicProvisioningState` was added

* `models.PartnerTopicsListResult` was added

* `models.EventChannel$UpdateStages` was added

* `models.PartnerTopic` was added

* `models.SystemTopics` was added

* `models.ExtendedLocation` was added

* `models.PartnerNamespace$Definition` was added

* `models.PartnerRegistrations` was added

* `models.PartnerNamespaceRegenerateKeyRequest` was added

* `models.PartnerNamespace$UpdateStages` was added

* `models.SystemTopicEventSubscriptions` was added

##### `models.Topics` was modified

* `regenerateKey(java.lang.String,java.lang.String,models.TopicRegenerateKeyRequest,com.azure.core.util.Context)` was added

##### `models.Topic` was modified

* `regenerateKey(models.TopicRegenerateKeyRequest,com.azure.core.util.Context)` was added
* `listSharedAccessKeys()` was added
* `sku()` was added
* `listSharedAccessKeysWithResponse(com.azure.core.util.Context)` was added
* `regenerateKey(models.TopicRegenerateKeyRequest)` was added
* `identity()` was added
* `extendedLocation()` was added
* `kind()` was added

##### `models.EventSubscriptionFilter` was modified

* `enableAdvancedFilteringOnArrays()` was added
* `withEnableAdvancedFilteringOnArrays(java.lang.Boolean)` was added

##### `models.WebhookEventSubscriptionDestination` was modified

* `withDeliveryAttributeMappings(java.util.List)` was added
* `deliveryAttributeMappings()` was added

##### `models.StorageQueueEventSubscriptionDestination` was modified

* `queueMessageTimeToLiveInSeconds()` was added
* `withQueueMessageTimeToLiveInSeconds(java.lang.Long)` was added

##### `models.EventSubscription$Definition` was modified

* `withDeliveryWithResourceIdentity(models.DeliveryWithResourceIdentity)` was added
* `withDeadLetterWithResourceIdentity(models.DeadLetterWithResourceIdentity)` was added

##### `models.ServiceBusQueueEventSubscriptionDestination` was modified

* `withDeliveryAttributeMappings(java.util.List)` was added
* `deliveryAttributeMappings()` was added

##### `models.TopicUpdateParameters` was modified

* `identity()` was added
* `withSku(models.ResourceSku)` was added
* `sku()` was added
* `withIdentity(models.IdentityInfo)` was added

##### `models.Domain$Update` was modified

* `withIdentity(models.IdentityInfo)` was added
* `withSku(models.ResourceSku)` was added

##### `models.Topic$Definition` was modified

* `withSku(models.ResourceSku)` was added
* `withKind(models.ResourceKind)` was added
* `withExtendedLocation(models.ExtendedLocation)` was added
* `withIdentity(models.IdentityInfo)` was added

##### `models.ServiceBusTopicEventSubscriptionDestination` was modified

* `withDeliveryAttributeMappings(java.util.List)` was added
* `deliveryAttributeMappings()` was added

##### `models.DomainUpdateParameters` was modified

* `sku()` was added
* `withIdentity(models.IdentityInfo)` was added
* `withSku(models.ResourceSku)` was added
* `identity()` was added

##### `models.Topic$Update` was modified

* `withSku(models.ResourceSku)` was added
* `withIdentity(models.IdentityInfo)` was added

##### `models.EventSubscription` was modified

* `deadLetterWithResourceIdentity()` was added
* `getDeliveryAttributes()` was added
* `getFullUrl()` was added
* `getDeliveryAttributesWithResponse(com.azure.core.util.Context)` was added
* `deliveryWithResourceIdentity()` was added
* `getFullUrlWithResponse(com.azure.core.util.Context)` was added
* `systemData()` was added

##### `models.Domain` was modified

* `listSharedAccessKeysWithResponse(com.azure.core.util.Context)` was added
* `identity()` was added
* `regenerateKey(models.DomainRegenerateKeyRequest)` was added
* `listSharedAccessKeys()` was added
* `regenerateKeyWithResponse(models.DomainRegenerateKeyRequest,com.azure.core.util.Context)` was added
* `sku()` was added

##### `models.AzureFunctionEventSubscriptionDestination` was modified

* `deliveryAttributeMappings()` was added
* `withDeliveryAttributeMappings(java.util.List)` was added

##### `models.EventSubscription$Update` was modified

* `withDeadLetterWithResourceIdentity(models.DeadLetterWithResourceIdentity)` was added
* `withDeliveryWithResourceIdentity(models.DeliveryWithResourceIdentity)` was added

##### `models.HybridConnectionEventSubscriptionDestination` was modified

* `withDeliveryAttributeMappings(java.util.List)` was added
* `deliveryAttributeMappings()` was added

##### `models.TopicTypeInfo` was modified

* `supportedScopesForSource()` was added

##### `models.EventHubEventSubscriptionDestination` was modified

* `deliveryAttributeMappings()` was added
* `withDeliveryAttributeMappings(java.util.List)` was added

##### `models.EventSubscriptions` was modified

* `getDeliveryAttributes(java.lang.String,java.lang.String)` was added
* `getDeliveryAttributesWithResponse(java.lang.String,java.lang.String,com.azure.core.util.Context)` was added

##### `EventGridManager` was modified

* `partnerTopics()` was added
* `eventChannels()` was added
* `partnerRegistrations()` was added
* `partnerTopicEventSubscriptions()` was added
* `extensionTopics()` was added
* `systemTopics()` was added
* `systemTopicEventSubscriptions()` was added
* `partnerNamespaces()` was added

##### `models.Domain$Definition` was modified

* `withIdentity(models.IdentityInfo)` was added
* `withSku(models.ResourceSku)` was added

##### `models.EventSubscriptionUpdateParameters` was modified

* `withDeliveryWithResourceIdentity(models.DeliveryWithResourceIdentity)` was added
* `deadLetterWithResourceIdentity()` was added
* `withDeadLetterWithResourceIdentity(models.DeadLetterWithResourceIdentity)` was added
* `deliveryWithResourceIdentity()` was added

### Resource Management - Resources 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-resources_2.2.0/sdk/resourcemanager/azure-resourcemanager-resources/CHANGELOG.md#220-2021-02-24)
- Supported locks with API version `2016-09-01`. Added `ManagementLock` and related classes.

### Resource Management - Event Hubs 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-eventhubs_2.2.0/sdk/resourcemanager/azure-resourcemanager-eventhubs/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Resource Management - Redis 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-redis_2.2.0/sdk/resourcemanager/azure-resourcemanager-redis/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-06-01`

### Azure Remote Rendering 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-mixedreality-remoterendering_1.0.0-beta.1/sdk/remoterendering/azure-mixedreality-remoterendering/CHANGELOG.md#100-beta1-2021-02-23)
This is the initial release of Azure Mixed Reality RemoteRendering library. For more information, please see the [README][read_me] and [samples][samples].

This is a Public Preview version, so breaking changes are possible in subsequent releases as we improve the product. To provide feedback, please submit an issue in our [Azure SDK for Java GitHub repo](https://github.com/Azure/azure-sdk-for-java/issues).

<!-- LINKS -->
[read_me]: https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/remoterendering/azure-mixedreality-remoterendering/README.md
[samples]: https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/remoterendering/azure-mixedreality-remoterendering/src/samples/java/com/azure/mixedreality/remoterendering

### azure-resourcemanager-iothub 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-iothub_1.0.0-beta.1/sdk/iothub/azure-resourcemanager-iothub/CHANGELOG.md#100-beta1-2021-03-02)
- Azure Resource Manager IotHub client library for Java. This package contains Microsoft Azure SDK for IotHub Management SDK. Use this API to manage the IoT hubs in your Azure subscription. Package tag package-2020-03. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Container Service 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-containerservice_2.2.0/sdk/resourcemanager/azure-resourcemanager-containerservice/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-11-01`
- Removed `withNodeImageVersion` method in `ManagedClusterAgentPoolProfileProperties`
- Removed unused class `Components1Q1Og48SchemasManagedclusterAllof1`
- Removed unused class `ComponentsQit0EtSchemasManagedclusterpropertiesPropertiesIdentityprofileAdditionalproperties`, it is same as its superclass `UserAssignedIdentity`

### Resource Management - Storage Cache 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-storagecache_1.0.0-beta.1/sdk/storagecache/azure-resourcemanager-storagecache/CHANGELOG.md#100-beta1-2021-02-22)
- Azure Resource Manager StorageCache client library for Java. This package contains Microsoft Azure SDK for StorageCache Management SDK. A Storage Cache provides scalable caching service for NAS clients, serving data from either NFSv3 or Blob at-rest storage (referred to as "Storage Targets"). These operations allow you to manage Caches. Package tag package-2020-10-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Network 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-network_2.2.0/sdk/resourcemanager/azure-resourcemanager-network/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-08-01`
- Removed field `GCM_AES_128` and `GCM_AES_256` from class `ExpressRouteLinkMacSecCipher`
- Changed return type from `Integer` to `Long` for `ConnectionStateSnapshot::avgLatencyInMs()`, `ConnectionStateSnapshot::maxLatencyInMs()`, `ConnectionStateSnapshot::minLatencyInMs()`, `ConnectionStateSnapshot::probesFailed()`, `ConnectionStateSnapshot::probesSent()`
- Changed return type from `Integer` to `Long` for `HopLink::roundTripTimeAvg()`, `HopLink::roundTripTimeMax()`, `HopLink::roundTripTimeMin()`
- Changed return type from `Integer` to `Long` for `PacketCaptureParameters::bytesToCapturePerPacket()`, `PacketCaptureParameters::totalBytesPerSession()`
- Changed return type from `int` to `long` for `PacketCapture::bytesToCapturePerPacket()`, `PacketCapture::totalBytesPerSession()`
- Changed return type from `Resource` to `String` for `EffectiveRoutesParameters::resourceId()`

### Digital Twins - Core 1.0.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-digitaltwins-core_1.0.3/sdk/digitaltwins/azure-digitaltwins-core/CHANGELOG.md#103-2021-02-24)
#### Dependency Updates

- Upgraded `jackson-annotations` dependency from `2.11.3` to `2.12.1` 
- Upgraded `azure-identity` dependency from `1.2.2` to `1.2.3` 
  - [azure-identity changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/identity/azure-identity/CHANGELOG.md#123-2021-02-09)
- Upgraded `azure-core` dependency from `1.12.0` to `1.13.0` 
  - [azure-core changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core/CHANGELOG.md#1130-2021-02-05)
- Upgraded `azure-core-http-netty` dependency from `1.7.1` to `1.8.0` 
  - [azure-core-http-netty changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-http-netty/CHANGELOG.md#180-2021-02-05)
- Upgraded `azure-core-serializer-json-jackson` dependency from `1.1.1` to `1.1.2` 
  - [azure-core-serializer-json-jackson changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-serializer-json-jackson/CHANGELOG.md#112-2021-02-05)

### Resource Management - DNS 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-dns_2.2.0/sdk/resourcemanager/azure-resourcemanager-dns/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Resource Management - Virtual Machines 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-compute_2.2.0/sdk/resourcemanager/azure-resourcemanager-compute/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-12-01`
- Supported force deletion on virtual machines and virtual machine scale sets
- Removed container service as it is deprecated in compute, please use `KubernetesCluster` from `azure-resourcemanager-containerservice`

### Resource Management - Cognitive Search 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-search_2.2.0/sdk/resourcemanager/azure-resourcemanager-search/CHANGELOG.md#220-2021-02-24)
- Migrated from previous sdk and updated `api-version` to `2020-08-01`.

### Resource Management - Cosmos DB 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-cosmos_2.2.0/sdk/resourcemanager/azure-resourcemanager-cosmos/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-09-01`
- Deprecated `ipRangeFilter` and `withIpRangeFilter`, replaced by `ipRules` and `withIpRules`

### Resource Management - Media Services 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-mediaservices_1.0.0-beta.2/sdk/mediaservices/azure-resourcemanager-mediaservices/CHANGELOG.md#100-beta2-2021-02-22)
- Azure Resource Manager Mediaservices client library for Java. This package contains Microsoft Azure SDK for Mediaservices Management SDK. This Swagger was generated by the API Framework. Package tag package-2020-05. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### New Feature

* `models.InputFile` was added

* `models.FaceRedactorMode` was added

* `models.FromEachInputFile` was added

* `models.TrackDescriptor` was added

* `models.H265Video` was added

* `models.SelectVideoTrackById` was added

* `models.H265Complexity` was added

* `models.JobInputSequence` was added

* `models.SelectAudioTrackById` was added

* `models.AttributeFilter` was added

* `models.FromAllInputFile` was added

* `models.TrackAttribute` was added

* `models.VideoTrackDescriptor` was added

* `models.CreatedByType` was added

* `models.H265Layer` was added

* `models.InputDefinition` was added

* `models.BlurType` was added

* `models.H265VideoLayer` was added

* `models.SystemData` was added

* `models.SelectVideoTrackByAttribute` was added

* `models.ChannelMapping` was added

* `models.SelectAudioTrackByAttribute` was added

* `models.AudioTrackDescriptor` was added

* `models.H265VideoProfile` was added

##### `models.FaceDetectorPreset` was modified

* `withMode(models.FaceRedactorMode)` was added
* `blurType()` was added
* `mode()` was added
* `withBlurType(models.BlurType)` was added

##### `models.MediaService` was modified

* `syncStorageKeysWithResponse(models.SyncStorageKeysInput,com.azure.core.util.Context)` was added
* `listEdgePolicies(models.ListEdgePoliciesInput)` was added
* `syncStorageKeys(models.SyncStorageKeysInput)` was added
* `systemData()` was added
* `listEdgePoliciesWithResponse(models.ListEdgePoliciesInput,com.azure.core.util.Context)` was added

##### `models.AssetFilter` was modified

* `systemData()` was added

##### `models.LiveEvent` was modified

* `allocate()` was added
* `start()` was added
* `stop(models.LiveEventActionInput)` was added
* `reset()` was added
* `allocate(com.azure.core.util.Context)` was added
* `reset(com.azure.core.util.Context)` was added
* `systemData()` was added
* `start(com.azure.core.util.Context)` was added
* `stop(models.LiveEventActionInput,com.azure.core.util.Context)` was added

##### `models.AccountFilter` was modified

* `systemData()` was added

##### `models.Asset` was modified

* `getEncryptionKey()` was added
* `listContainerSas(models.ListContainerSasInput)` was added
* `systemData()` was added
* `listStreamingLocators()` was added
* `listStreamingLocatorsWithResponse(com.azure.core.util.Context)` was added
* `listContainerSasWithResponse(models.ListContainerSasInput,com.azure.core.util.Context)` was added
* `getEncryptionKeyWithResponse(com.azure.core.util.Context)` was added

##### `models.StreamingLocator` was modified

* `listContentKeysWithResponse(com.azure.core.util.Context)` was added
* `systemData()` was added
* `listPaths()` was added
* `listPathsWithResponse(com.azure.core.util.Context)` was added
* `listContentKeys()` was added

##### `models.MetricSpecification` was modified

* `lockAggregationType()` was added

##### `models.StreamingPolicy` was modified

* `systemData()` was added

##### `models.StreamingEndpoint` was modified

* `start()` was added
* `systemData()` was added
* `stop(com.azure.core.util.Context)` was added
* `scale(models.StreamingEntityScaleUnit,com.azure.core.util.Context)` was added
* `scale(models.StreamingEntityScaleUnit)` was added
* `stop()` was added
* `start(com.azure.core.util.Context)` was added

##### `models.ContentKeyPolicy` was modified

* `getPolicyPropertiesWithSecretsWithResponse(com.azure.core.util.Context)` was added
* `systemData()` was added
* `getPolicyPropertiesWithSecrets()` was added

##### `models.JobInputClip` was modified

* `withInputDefinitions(java.util.List)` was added
* `inputDefinitions()` was added

##### `models.JobInputAsset` was modified

* `withInputDefinitions(java.util.List)` was added
* `withInputDefinitions(java.util.List)` was added

##### `models.JobInputHttp` was modified

* `withInputDefinitions(java.util.List)` was added
* `withInputDefinitions(java.util.List)` was added

##### `models.Job` was modified

* `cancelJobWithResponse(com.azure.core.util.Context)` was added
* `cancelJob()` was added
* `systemData()` was added

##### `models.Transform` was modified

* `systemData()` was added

### Resource Management 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager_2.2.0/sdk/resourcemanager/azure-resourcemanager/CHANGELOG.md#220-2021-02-24)
- Improved performance of `PagedIterable`

### Resource Management - Storage 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-storage_2.2.0/sdk/resourcemanager/azure-resourcemanager-storage/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2021-01-01`
- Return type of `Identity.type()` changed from `String` to `IdentityType`

### azure-resourcemanager-hybridkubernetes 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-hybridkubernetes_1.0.0-beta.1/sdk/hybridkubernetes/azure-resourcemanager-hybridkubernetes/CHANGELOG.md#100-beta1-2021-03-01)
- Azure Resource Manager HybridKubernetes client library for Java. This package contains Microsoft Azure SDK for HybridKubernetes Management SDK. Hybrid Kubernetes Client. Package tag package-2021-03-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Managed Service Identity 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-msi_2.2.0/sdk/resourcemanager/azure-resourcemanager-msi/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### SDK - Bill of Materials 1.0.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-sdk-bom_1.0.2/sdk/boms/azure-sdk-bom/CHANGELOG.md#102-2021-02-25)
#### Dependency Updates

- Updated Azure SDK dependency versions to more recent releases.
- Transitioned loose dependencies of Jackson, Netty, and Reactor to using their BOMs.

### Azure Mixed Reality Authentication 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-mixedreality-authentication_1.0.0-beta.1/sdk/mixedreality/azure-mixedreality-authentication/CHANGELOG.md#100-beta1-2021-02-23)
This is the initial release of Azure Mixed Reality Authentication library. For more information, please see the [README][read_me] and [samples][samples].

This is a Public Preview version, so breaking changes are possible in subsequent releases as we improve the product. To provide feedback, please submit an issue in our [Azure SDK for Java GitHub repo](https://github.com/Azure/azure-sdk-for-java/issues).

<!-- LINKS -->
[read_me]: https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/mixedreality/azure-mixedreality-authentication/README.md
[samples]: https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/mixedreality/azure-mixedreality-authentication/src/samples/java/com/azure/mixedreality/authentication

### Resource Management - Container Instances 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-containerinstance_2.2.0/sdk/resourcemanager/azure-resourcemanager-containerinstance/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Resource Management - Spring Cloud 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-appplatform_2.2.0/sdk/resourcemanager/azure-resourcemanager-appplatform/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-11-01-preview`

### Resource Management - Authorization 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-authorization_2.2.0/sdk/resourcemanager/azure-resourcemanager-authorization/CHANGELOG.md#220-2021-02-24)
- Supported `listByServicePrincipal` in `RoleAssignments`
- Updated API from `AAD Graph` to `Microsoft Graph`. New permission needs to be granted before calling the API, [Reference](https://docs.microsoft.com/graph/permissions-reference)
- Removed `applicationPermissions` in `ActiveDirectoryApplication`
- Removed `signInName` in `ActiveDirectoryUser`
- Removed `withPasswordValue` in `PasswordCredential.Definition`
- Supported `withPasswordConsumer` in `PasswordCredential.Definition` to consume the password value.

### Resource Management - Key Vault 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-keyvault_2.2.0/sdk/resourcemanager/azure-resourcemanager-keyvault/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Resource Management - App Service 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-appservice_2.2.0/sdk/resourcemanager/azure-resourcemanager-appservice/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Resource Management - Content Delivery Network 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-cdn_2.2.0/sdk/resourcemanager/azure-resourcemanager-cdn/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-09-01`
- Removed `UrlSigningActionParametersOdataType`
- Type of property `odataType` in `UrlSigningActionParameters` changed from `UrlSigningActionParametersOdataType` to `String`
- Type of property `keyId` in `UrlSigningActionParameters` removed

### Resource Management - Private DNS 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-privatedns_2.2.0/sdk/resourcemanager/azure-resourcemanager-privatedns/CHANGELOG.md#220-2021-02-24)
- Improved performance on `PrivateDnsZone` update

### Resource Management - Container Registry 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-containerregistry_2.2.0/sdk/resourcemanager/azure-resourcemanager-containerregistry/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### azure-resourcemanager-digitaltwins 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-digitaltwins_1.0.0-beta.1/sdk/digitaltwins/azure-resourcemanager-digitaltwins/CHANGELOG.md#100-beta1-2021-03-02)
- Azure Resource Manager AzureDigitalTwins client library for Java. This package contains Microsoft Azure SDK for AzureDigitalTwins Management SDK. Azure Digital Twins Client for managing DigitalTwinsInstance. Package tag package-2020-12. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Monitor 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-monitor_2.2.0/sdk/resourcemanager/azure-resourcemanager-monitor/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Azure Mixed Reality Authentication 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-mixedreality-authentication_1.0.0/sdk/mixedreality/azure-mixedreality-authentication/CHANGELOG.md#100-2021-02-26)
This is the initial stable release of Azure Mixed Reality Authentication library. For more information, please see the [README][read_me] and [samples][samples].

### Resource Management - Traffic Manager 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-trafficmanager_2.2.0/sdk/resourcemanager/azure-resourcemanager-trafficmanager/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Resource Management - Service Bus 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-servicebus_2.2.0/sdk/resourcemanager/azure-resourcemanager-servicebus/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Resource Management - NetApp Files 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-netapp_1.0.0-beta.1/sdk/netapp/azure-resourcemanager-netapp/CHANGELOG.md#100-beta1-2021-02-22)
- Azure Resource Manager NetAppFiles client library for Java. This package contains Microsoft Azure SDK for NetAppFiles Management SDK. Microsoft NetApp Files Azure Resource Provider specification. Package tag package-netapp-2020-11-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Redis Enterprise 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-redisenterprise_1.0.0-beta.2/sdk/redisenterprise/azure-resourcemanager-redisenterprise/CHANGELOG.md#100-beta2-2021-03-02)
- Azure Resource Manager RedisEnterprise client library for Java. This package contains Microsoft Azure SDK for RedisEnterprise Management SDK. REST API for managing Redis Enterprise resources in Azure. Package tag package-2021-03. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Redis Enterprise 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-redisenterprise_1.0.0-beta.1/sdk/redisenterprise/azure-resourcemanager-redisenterprise/CHANGELOG.md#100-beta1-2021-02-23)
- Azure Resource Manager RedisEnterprise client library for Java. This package contains Microsoft Azure SDK for RedisEnterprise Management SDK. REST API for managing Redis Enterprise resources in Azure. Package tag package-preview-2021-02. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - SQL 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-sql_2.2.0/sdk/resourcemanager/azure-resourcemanager-sql/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources
### azure-resourcemanager-datadog 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-datadog_1.0.0-beta.1/sdk/datadog/azure-resourcemanager-datadog/CHANGELOG.md#100-beta1-2021-03-08)
- Azure Resource Manager MicrosoftDatadog client library for Java. This package contains Microsoft Azure SDK for MicrosoftDatadog Management SDK.  Package tag package-2020-02-preview. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Storage Cache 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-storagecache_1.0.0-beta.2/sdk/storagecache/azure-resourcemanager-storagecache/CHANGELOG.md#100-beta2-2021-03-08)
- Azure Resource Manager StorageCache client library for Java. This package contains Microsoft Azure SDK for StorageCache Management SDK. A Storage Cache provides scalable caching service for NAS clients, serving data from either NFSv3 or Blob at-rest storage (referred to as "Storage Targets"). These operations allow you to manage Caches. Package tag package-2021-03. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### Breaking Change

* `models.ClfsTargetProperties` was removed

* `models.Nfs3TargetProperties` was removed

* `models.StorageTargetProperties` was removed

* `models.UnknownTargetProperties` was removed

##### `models.UnknownTarget` was modified

* `withUnknownMap(java.util.Map)` was removed
* `unknownMap()` was removed

#### New Feature

* `models.Condition` was added

* `models.BlobNfsTarget` was added

##### `models.StorageTarget` was modified

* `blobNfs()` was added
* `targetType()` was added
* `dnsRefresh(com.azure.core.util.Context)` was added
* `dnsRefresh()` was added

##### `models.CacheHealth` was modified

* `conditions()` was added

##### `models.StorageTarget$Update` was modified

* `withTargetType(models.StorageTargetType)` was added
* `withBlobNfs(models.BlobNfsTarget)` was added

##### `models.CacheNetworkSettings` was modified

* `dnsSearchDomain()` was added
* `withDnsSearchDomain(java.lang.String)` was added
* `dnsServers()` was added
* `ntpServer()` was added
* `withDnsServers(java.util.List)` was added
* `withNtpServer(java.lang.String)` was added

##### `models.UnknownTarget` was modified

* `withAttributes(java.util.Map)` was added
* `attributes()` was added

##### `models.StorageTargets` was modified

* `dnsRefresh(java.lang.String,java.lang.String,java.lang.String)` was added
* `dnsRefresh(java.lang.String,java.lang.String,java.lang.String,com.azure.core.util.Context)` was added

##### `models.StorageTarget$Definition` was modified

* `withTargetType(models.StorageTargetType)` was added
* `withBlobNfs(models.BlobNfsTarget)` was added
### Text Analytics 5.0.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-textanalytics_5.0.4/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#504-2021-03-09)
#### Dependency updates
- Update dependency version, `azure-core` to 1.14.0 and `azure-core-http-netty` to 1.9.0.

### Synapse - Artifacts 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-analytics-synapse-artifacts_1.0.0-beta.3/sdk/synapse/azure-analytics-synapse-artifacts/CHANGELOG.md#100-beta3-2021-03-09)
- Add new APIs in `LibraryClient` and `LibraryAsyncClient`

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

[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
