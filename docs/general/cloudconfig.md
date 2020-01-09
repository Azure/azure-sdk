## SDK Support for sovereign clouds and Azure Stack

The fact that there are multiple instances of Azure clouds introduces a distinct set of challenges for developers.

### Endpoint configuration
Different cloud instances have different endpoint addresses. This includes both endpoints for services (e.g. the default storage endpoint suffix for the Azure China Cloud is core.chinacloudapi.cn whereas the default storage endpoint suffix for the Azure US Government cloud is core.usgovcloudapi.net)

- A client library **MUST** expose a mechanism to specify the friendly name of the cloud instance that they are targeting when creating a client. See below for list of friendly names.
- A client library **MUST** expose a mechanism that allows a developer to explicitly specify all endpoint information when targeting a specific cloud instance. This includes the active directory endpoint to use.
- A client library **MUST** expose a mechanism that allows a developer to globally specify the default profile to use in their application.
- A client library **SHOULD** expose a mechanism that allows a developer to globally specify the cloud instance that they intend to target using the friendly name.

|Friendly name|Notes|
|-|-|
|AzureCloud|Default cloud instance. Used unless overridden by application.
|AzureChinaCloud|https://azure.microsoft.com/en-us/global-infrastructure/china/|
|AzureUSGovernment|https://azure.microsoft.com/en-us/global-infrastructure/government/|
|AzureGermanCloud|https://azure.microsoft.com/en-us/global-infrastructure/germany/|

### Versioning

As new versions of Azure Services are deployed over time, not all cloud instances will be updated at the same time. This is especially true for instances that Microsoft does not directly control (e.g. Azure Stack, containerized service instances etc.)
In practical terms, this means that, at the point of release, the default API version for the latest client library for an Azure service may not be supported in a given cloud instance.

In order to avoid having to know the api version for each service, Azure [publishes API profiles](https://docs.microsoft.com/en-us/azure-stack/user/azure-stack-profiles-azure-resource-manager-versions?view=azs-1910), which maps service APIs to supported API versions. In addition, a developer can query a given cloud instance to determine which profiles it supports.

- A client library **MUST** expose a mechanism to specify the api profile name to use when creating a client instance. The client library **MUST** report an error if the user explicitly provides a profile name that the client doesn't recognize.
- A client library **MUST** expose a mechanism to specify the specific api version to use when creating a client instance.
- A client library **MAY** allow a caller to specify the api profile name or api version on a per-invocation basis.