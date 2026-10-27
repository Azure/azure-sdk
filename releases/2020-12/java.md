---
title: Azure SDK for Java (December 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our December 2020 client library releases.

#### GA

- Management Library - CDN
- Management Library - Container Instance
- Management Library - Container Registry
- Management Library - Event Hubs
- Management Library - Private DNS
- Management Library - Redis
- Management Library - Service Bus
- Management Library - Spring Cloud
- Management Library - SQL
- Management Library - Traffic Manager
- Spring Library - Spring Boot
- Spring Library - Spring Cloud

#### Updates

- Azure Cosmos
- Azure Identity
- Azure Spring Data Cosmos
- Management Library - App Services
- Management Library - Resources

#### Beta

- Storage Library - Blobs
- Storage Library - Blob Batch
- Storage Library - Blob Cryptography
- Storage Library - File Datalake
- Storage Library - File Share
- Storage Library - Queue
- Synapse Library - Spark
- Synapse Library - Access Control
- Synapse Library - Artifacts
- Synapse Library - Managed Private Endpoints
- Synapse Library - Monitoring

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-cdn</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerinstance</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerregistry</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-eventhubs</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-privatedns</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-redis</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-servicebus</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-appplatform</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-sql</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-trafficmanager</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-appservice</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-resources</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.10.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-batch</artifactId>
  <version>12.8.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-cryptography</artifactId>
  <version>12..10.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-common</artifactId>
  <version>12.10.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.4.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-share</artifactId>
  <version>12.8.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.8.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-internal-avro</artifactId>
  <version>12.0.2-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.10.0</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.9.0</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-spring-data-cosmos</artifactId>
  <version>3.2.0</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.2.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-synapse-spark</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-synapse-accesscontrol</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-synapse-artifacts</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-synapse-managedprivateendpoints</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-synapse-monitoring</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>
```

For resource management libraries, we also provide a wrapper package that contains all available services
```xml
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager</artifactId>
  <version>2.1.0</version>
</dependency>
```
To use Azure Spring Cloud starters and binders, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate.

```xml
 <dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-queue</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-topic</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-cache</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-eventhubs-kafka</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-eventhubs</artifactId>
  <version>2.0.0</version>
</dependency>
```

To use Azure Spring Boot starters, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate.
```xml
<dependencyManagement>
    <dependencies>
      <dependency>
        <groupId>com.azure.spring</groupId>
        <artifactId>azure-spring-boot-bom</artifactId>
        <version>3.0.0</version>
        <type>pom</type>
        <scope>import</scope>
      </dependency>
    </dependencies>
</dependencyManagement>

<dependencies>
    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot</artifactId>
    </dependency>

    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot-starter</artifactId>
    </dependency>

    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot-starter-active-directory</artifactId>
    </dependency>

    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot-starter-active-directory-b2c</artifactId>
    </dependency>

    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot-starter-cosmos</artifactId>
    </dependency>

    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot-starter-keyvault-secrets</artifactId>
    </dependency>

    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot-starter-servicebus-jms</artifactId>
    </dependency>

    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot-starter-storage</artifactId>
    </dependency>
</dependencies>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights

### Management Libraries

We are excited to announce the GA releases of management libraries that follow the [Azure SDK Design Guidelines for Java](https://azure.github.io/azure-sdk/java/guidelines/). In addition, more management libraries are now in Public Preview to provide better Azure service coverage. These new libraries provide a higher-level, object-oriented API for managing Azure resources, that is optimized for ease of use, succinctness and consistency. You can find the list of new packages [on this page](https://azure.github.io/azure-sdk/releases/latest/java.html). Detailed documentation and code samples for these new libraries can be [found here](https://aka.ms/azsdk/java/mgmt)

These new packages share the same groupId ``com.azures.resourcemanager`` and artifactId share the same prefix of ``azure-resourcemanager``

### Azure Storage Blob 12.10.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob/CHANGELOG.md#12100-beta1-2020-12-07)
#### New Features
- Exposed ClientOptions on all client builders, allowing users to set a custom application id and custom headers.
- Added ability to get container client from blob clients and service client from container clients
- Added a MetadataValidationPolicy to check for leading and trailing whitespace in metadata that would cause Auth failures.
- Added support for the 2020-04-08 service version.
- Added support to upload block blob from URL.
- Added lease ID parameter to Get and Set Blob Tags.
- Added blob tags to BlobServiceClient.findBlobsByTags() result.

#### Bug Fixes
- Fixed a bug where the error message would not be displayed the exception message of a HEAD request.

### Azure Storage File Datalake 12.4.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-datalake/CHANGELOG.md#1240-beta1-2020-12-07)
#### New Features
- Added support to list paths on a directory.
- Exposed ClientOptions on all client builders, allowing users to set a custom application id and custom headers.
- Added a MetadataValidationPolicy to check for leading and trailing whitespace in metadata that would cause Auth failures.

#### Bug Fixes
- Fixed a bug where the error message would not be displayed the exception message of a HEAD request.

### Azure Storage File Share 12.8.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-share/CHANGELOG.md#1280-beta1-2020-12-07)
#### New Features
- Exposed ClientOptions on all client builders, allowing users to set a custom application id and custom headers.
- Added a MetadataValidationPolicy to check for leading and trailing whitespace in metadata that would cause Auth failures.
- Added support for the 2020-04-08 service version.
- Added support for specifying enabled protocols on share creation
- Added support for setting root squash on share creation and through set properties.

#### Bug Fixes
- Fixed a bug where snapshot would be appended to a share snapshot instead of sharesnapshot.
- Fixed a bug where the sharesnapshot query parameter would be ignored in share and share file client builders.
- Fixed a bug where the error message would not be displayed the exception message of a HEAD request.

### Azure Spring Data Cosmos 3.2.0
#### New Features
- Updated Spring Data Commons version to 2.3.5.RELEASE.
- Updated Spring Core version to 5.2.10.RELEASE.

#### Key Bug Fixes
- Fixed publishing of `spring.factories` file with released jar.
- Fixed repository query with repeated parameters.

### Azure Cosmos 4.10.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/cosmos/azure-cosmos/CHANGELOG.md#4100-2020-12-14)
#### New Features
- Added Conflict API support.

### Azure Cosmos 4.9.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/cosmos/azure-cosmos/CHANGELOG.md#490-2020-12-11)
#### New Features
- Added Beta API for Bulk Operations.
- Added `getRegionsContacted` API in `CosmosDiagnostics`.
- Added Diagnostics for `CosmosStoredProcedureResponse`.
- Added trouble shooting guide links to `CosmosException`.

#### Key Bug Fixes
- Adding automatic retries on client-side transient failures on writes while possible with still being idempotent.
- Fixed NPE on `getDiagnostics` for `CosmosStoredProcedureResponse`.
- Fixed empty `resourceAddress` in `CosmosException`.

### Azure Identity 1.2.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/identity/azure-identity/CHANGELOG.md#121-2020-12-08)
#### Dependency Updates
- Upgraded `azure-core` dependency to 1.11.0

#### Synapse Spark [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/synapse/azure-analytics-synapse-spark/CHANGELOG.md#100-beta1-2020-12-08)

- Initial Release.

#### Synapse Access Control [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/synapse/azure-analytics-synapse-accesscontrol/CHANGELOG.md#100-beta1-2020-12-08)

- Initial Release.

#### Synapse Artifacts [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/synapse/azure-analytics-synapse-artifacts/CHANGELOG.md#100-beta1-2020-12-08)

- Initial release.

#### Synapse Managed Private Endpoints [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/synapse/azure-analytics-synapse-managedprivateendpoints/CHANGELOG.md#100-beta1-2020-12-15)

- Initial release.

#### Synapse Monitoring [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/synapse/azure-analytics-synapse-monitoring/CHANGELOG.md#100-beta1-2020-12-15)

- Initial release.

### Azure Spring Cloud
#### Breaking Changes
- Deprecated the `spring.cloud.azure.managed-identity.client-id` property,
  use `spring.cloud.azure.client-id` to set the managed identity id when using Managed Identity.

### Azure Spring Boot
#### Breaking Changes
- Deprecated `AADAppRoleStatelessAuthenticationFilter` and `AADAuthenticationFilter`.
- Changed artifact id from `azure-active-directory-spring-boot-starter` to `azure-spring-boot-starter-active-directory`.
- Changed group id of `azure-spring-boot-starter-active-directory` from `com.microsoft.azure` to `com.azure.spring`.
- Deprecated `azure-spring-boot-starter-active-directory` configuration properties:
    ```
    spring.security.oauth2.client.provider.azure.*
    spring.security.oauth2.client.registration.azure.*
    azure.activedirectory.environment
    azure.activedirectory.user-group.key
    azure.activedirectory.user-group.value
    azure.activedirectory.user-group.object-id-key
    ```
- Stop support of Azure Active Directory Endpoints.

#### New Features
- Support consent of multiple client registrations during user login.
- Support on-demand client registrations.
- Support the use of `@RegisteredOAuth2AuthorizedClient` annotation to get `OAuth2AuthorizedClient`.
- Support access control through users' membership information.
- Support on-behalf-of flow in the resource server.
- Provide AAD specific token validation methods of audience validation and issuer validation.
- Expose a flag `isPersonalAccount` in `AADOAuth2AuthenticatedPrincipal` to specify the account type in use: work account or personal account.
- Enable loading transitive membership information from Microsoft Graph API.
- Enable following `azure-spring-boot-starter-active-directory` configuration properties:
    ```yaml
    # Redirect URI of authorization server
    azure.activedirectory.redirect-uri-template
    # Refresh time of the cached JWK set before it expires, default value is 5 minutes.
    azure.activedirectory.jwk-set-cache-refresh-time
    # Logout redirect URI
    azure.activedirectory.post-logout-redirect-uri
    # base URI for authorization server, default value is "https://login.microsoftonline.com/"
    azure.activedirectory.base-uri
    # Membership URI of Microsoft Graph API to get users' group information, default value is "https://graph.microsoft.com/v1.0/me/memberOf"
    azure.activedirectory.graph-membership-uri
    ```

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
