# Cloud configuration and discovery

There are multiple Azure Cloud instances. This includes well-known cloud instances such as Public Azure, Azure China Cloud, Azure Government Cloud etc. It also includes private cloud instances that are managed by our customers. An example of this is Azure Stack.

The clouds differ in which endpoints to use when connecting to it. Finding exactly which endpoints to use is challenging for users. This applies both for public clouds and private instances. For private cloud instances, Microsoft does not know the specific endpoints used by the cloud instance. Additionally cloud instances may or may not be reachable from public internet. 

In order to discover which endpoints (DNS names and suffixes) are to be used when connecting to a specific cloud, a disovery endpoint has been introduced. This reduces the amount of information a developer needs in order to connect to a given cloud to knowing a single endpoint.

## Goals

* Simplify configuring for a client connecting to public clouds other than Public Azure.
* Allow use of configuration data retreived from cloud configuration discovery endpoint for private cloud instances.

## Non-goals

* Automatically discover which cloud an application runs in.
* Change in requirements for client libraries to always accept a simple name (e.g. storage account name) in addition to full endpoint information when constructing clients.

## Core capabilities

* Well-known (public) cloud configurations MUST be built-in to the client libraries for each language. Each well-known cloud configuration has a "simple name" in addition to a set of key/value pairs representing endpoints and suffixes for known services.

> The built-in cloud configurations SHOULD be defined in azure core.

> The simple cloud name MAY be a string or an enum value.

> The cloud configuration instance MAY be represented by a custom type in strongly typed lanugages.

* In addition to the well-known cloud configurations, it MUST be possible to construct a custom cloud configuration instance for a specific cloud (e.g. Azure Stack).

* It MUST be possible (and documented how) to load a configuration from the returned information in ARM's discovery endpoint.

> A canonical use-case for this is to, given the metadata configuration endpoint for a given cloud, download the configuration data to a local file.

### Cloud configuration properties

A cloud configuration object consists of a map of service-name to service-specific-configuration-entry as per below:

```json
{
   "<service entry1>": {
       "endpoint": "<url>",
       "suffix": "<suffix>",
       "audiences": [
           "<optional audiences>"
       ],
       "tenant": "<optional tenant>",
       "identityProvider": "<optional identity provider>"
    },
    "<service entry2>": {
       "endpoint": "<url>",
       "suffix": "<suffix>",
       "audiences": [
           "<optional audiences>"
       ],
       "tenant": "<optional tenant>",
       "identityProvider": "<optional identity provider>"
   }
}
```

where `<service entry>` is (currently) one of the following values:

|Name|Notes|
|-|-|
|`acr`|Azure Container Registry|
|`authentication`||
|`batch`|Batch service endpoint|
|`dataLakeCatalogAndJob`||
|`dataLakeFileSystem`||
|`microsoftGraph`||
|`keyvault`||
|`media`|Media services service endpoint|
|`portal`|Portal address|
|`resourceManager`||
|`sqlServer`||
|`storage`||

None of the properties in a service configuration entry are required as they differ between different services. 

> Note that this format differs from the raw json exposed by the discovery endpoint. The endpoint discovery response is not structured on a per-service basis, which makes it harder to evolve the set of metadata in the response.

> A given language can choose to expose the configuration as a dictionary or as a strongly typed class.

## Service specific client library guidance

* Service specific client libraries that have baked-in cloud-specific defaults MUST accept a cloud configuration instance in the constructor (or equivalent) for the service client instance. Client libraries MAY also accept a a simple cloud name.

### Ambient default configuration

* A language MAY provide the capability to set the default cloud to use. 
* If supported, client libraries MUST copy the applicable configuration settings when creating the client (or other configuration-aware) object. If the default configuration is changed after the object has been created, the change MUST NOT be observed by the already created object.

> In most cases, the ambient default configuration will be set during application start-up, much like other process wide configuration data is initialized (e.g. log levels etc.)

### Interaction with other configuration settings

The order of precedence is (in order of decreasing specificity):

* Explicitly provided endpoint parameter passed in value in the method call
* Explicitly provided configuration value from cloud_configuration parameter passed in the method call
* Ambient default cloud (if supported)
* Endpoint specific environment variables (e.g. `AZURE_AUTHORITY_HOST`)
* Final fallback, corresponding Public Azure's settings (built in to the client library)

### Missing configuration properties

Given that more configuration settings can be added over time, you may run into a situation where not all configuration settings that a client library needs are populated in a provided cloud configuration entry. If a cloud configuration is provided, but a client library cannot find the configuration setting it expects, the method MUST fail.

> In most languages, the failure is exposed as an exception.

* Methods that accept a configuration object that is missing one or more configuration settings that it expects MUST raise an error.

## Example usage 

### Python
```python
# In order to default to switch all default values to match the expected configuration for
# the Azure China Cloud.
azure.core.settings.set_default_cloud('AzureChinaCloud')

creds = azure.identity.DefaultAzureCredential() # We will use the Azure China Cloud's authority (https://login.chinacloudapi.cn) since that is what is configured as the default cloud.

# I can still specify the default authority host to override the default settings...
public_azure_creds = azure.identity.DefaultAzureCredential(authority='https://login.windows.net')

# I can also specify a full cloud configuration object:
# In order to default to switch all default values to match the expected configuration for
# the Azure China Cloud.
config = CloudConfiguration.from_json(requests.get('https://azurestackinstance1.contoso.com/discover'.json()))
azure.core.settings.set_default_cloud(config['AzureStack'])

# ...or pass in a custom cloud configuration into a method
creds = azure.identity.DefaultAzureCredential(cloud_configuration=config['PublicAzure'])
```

### C#

```C#
// In order to default to switch all default values to match the expected configuration for
// the Azure China Cloud.
creds = Azure.Core.Identity.DefaultAzureCredentials(
    Azure.Core.Identity.DefaultAzureCredentialOptions() {
        CloudConfiguration = Azure.Core.CloudConfigurations.AzureChinaCloud
    }
);
```

## Future evolution/addition of per-service endpoint configuration

* Over time metadata can be added for a given service/new services may be added. Client libraries that depend on the new metadata can set the minimum version of the azure core dependency to ensure that the new metadata is available for well-known clouds.

## Issues

* Only updated client libraries will pick up the ambient default settings. This problem will fade over time as new client library versions are made aware of ambient settings.

