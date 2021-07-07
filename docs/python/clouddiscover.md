# Cloud configuration and discovery

There are multiple Azure Cloud instances. This includes well-known cloud instances such as Public Azure, Azure China Cloud, Azure Government Cloud etc. It also includes private cloud instances that are managed by our customers. An example of this is Azure Stack.

The clouds differ in which endpoints to use when connecting to it. Finding exactly which endpoints to use is challenging for users. This applies both for public clouds and private instances. For private cloud instances, Microsoft does not know the specific endpoints used by the cloud instance. Additionally cloud instances may or may not be reachable from public internet.

To discover which endpoints (DNS names and suffixes) are to be used when connecting to a specific cloud, a discovery endpoint will be introduced. This reduces the amount of information a developer needs to connect to a given cloud to knowing a single endpoint.

## Goals

* Simplify configuring for a client connecting to clouds other than Public Azure.
* Allow use of configuration data retrieved from cloud configuration discovery endpoint for private cloud instances.

## Non-goals

* Automatically discover which cloud an application runs in and set that as a default for libraries to use.
* Change in requirements for client libraries to always accept a simple name (e.g. storage account name) in addition to full endpoint information when constructing clients.

## Core capabilities

* Well-known (public) cloud configurations MUST be built-in to the client libraries for each language. Each well-known cloud configuration has a "simple name" in addition to a set of key/value pairs representing endpoints and suffixes for known services.

> The built-in cloud configurations MUST be defined in azure core.

> The simple cloud name MAY be a string or an enum value.

> The cloud configuration instance MAY be represented by a custom type in strongly typed languages.

* In addition to the well-known cloud configurations, it MUST be possible to construct a custom cloud configuration for a specific cloud instance (e.g. Azure Stack).

* The core library MUST provide a mechanism to list well-known cloud instance names.

```python
for known_cloud in azure.core.clouds.well_known:
  print(known_cloud)
```

* It MUST be possible (and documented how) to load a configuration from the returned information in ARM's discovery endpoint. Unknown configuration data retrieved from the ARM discovery endpoint (e.g. configuration data associated with new services) MUST be ignored.

> A canonical use-case for this is to, given the metadata configuration endpoint for a given cloud, download the configuration data to a local file.

### Cloud configuration properties

A cloud configuration object consists of a common `authentication` sections plus a map of service-name to service-specific-configuration-entry as per below:

```jsonc
{
  "authentication": {
    "loginEndpoint": "<url>"
  },
  "services": {
    "<service entry1>": {
      "endpoint": "<url>",
      "suffix": "<suffix>",
      "authentication": {
        "audiences": [
          "<optional audiences>"
        ]
      }
    },
    "<service entry2>": {
      "endpoint": "<url>",
      "suffix": "<suffix>",
      "authentication": {
        "audiences": [
            "<optional audiences>"
        ]
      }
    }
  }
}
```

|Property|Description|Example|
|-|-|-|
|endpoint|Absolute URL (including domain name) for the service. Used by multitenant services.|`https://management.microsoftazure.de`
|suffix|Clouds specific domain suffix for the service. Used for single tenant services with unique hostname per instance/account.|`.vault.microsoftazure.de`
|audiences|List of audiences for the given service|
|tenant|Tenant used to authenticate the given service|

where `<service entry>` is (currently) one of the following values:

|Name|Notes|
|-|-|
|`batch`|Batch service endpoint|
|`containerRegistry`|Azure Container Registry|
|`dataLakeAnalyticsCatalogAndJob`||
|`dataLakeStorageFileSystem`||
|`gallery`||
|`graph`||
|`keyvault`||
|`media`|Media services service endpoint|
|`portal`|Portal address|
|`resourceManager`||
|`sql`||
|`sqlManagement`||
|`storage`||

None of the individual properties in a service configuration entry are required as they differ between different services (e.g. a service can have a well-known endpoint or a suffix, but it never has both)

> Note that this format differs from the raw json exposed by the discovery endpoint. The endpoint discovery response is not structured on a per-service basis, which makes it harder to evolve the set of metadata in the response.

> A given language can choose to expose the configuration as a dictionary or as a strongly typed class.

* It MUST be possible to persist and load configuration objects.

## Service specific client library guidance

* Service specific client libraries that have baked-in cloud-specific defaults MUST accept a cloud configuration instance in the constructor (or equivalent) for the service client instance. Client libraries MAY also accept a simple cloud name.

> Examples of cloud specific defaults include hostnames (for services sharing a common DNS name, such as ARM) and host name suffixes (for client libraries that concatenate a "simple" service name with a suffix to build the full DNS name to connect to).

### Ambient default configuration

* A language MAY provide the capability to set the default cloud to use. 
* If supported, client libraries MUST copy the applicable configuration settings when creating the client (or other configuration-aware) object. If the default configuration is changed after the object has been created, the change MUST NOT be observed by the already created object.

> In most cases, the ambient default configuration will be set during application start-up, much like other process wide configuration data is initialized (e.g. log levels etc.)

### Interaction with other configuration settings

The order of precedence is (in order of decreasing specificity):

* Explicitly provided configuration value from cloud_configuration parameter provided when creating the client.
* Ambient default cloud (if supported) explicitly set by the application.
* Endpoint specific environment variables (i.e. `AZURE_AUTHORITY_HOST`)
* Cloud specified in the `AZURE_CLOUD` environment variable.
* Final fallback, corresponding Public Azure's settings (built in to the client library)

### Missing configuration properties

Given that more configuration settings can be added over time, you may run into a situation where not all configuration settings that a client library needs are populated in a provided cloud configuration entry. If a cloud configuration is provided, but a client library cannot find the configuration setting it expects, the method MUST fail.

> In most languages, the failure is exposed as an exception.

* Methods that accept a configuration object that is missing one or more configuration settings that it expects MUST raise an error. The error message MUST be clear enough for the developer to understand what data is missing and how to supply it.

* Adding a new required configuration property for a given method/API is a breaking change. 

## Example usage

### Python

```python
from azure.core.clouds import CloudConfiguration

# In order to default to switch all default values to match the expected configuration for
# the Azure China Cloud.
azure.core.settings.cloud_configuration = 'AzureChinaCloud'

creds = azure.identity.DefaultAzureCredential() # We will use the Azure China Cloud's authority (https://login.chinacloudapi.cn) since that is what is configured as the default cloud.

# The default management endpoint from AzureChinaCloud is used
# (picked up from the resourceManager service entry in of the AzureChinaCloud built-in cloud configuration)
client = azure.mgmt.compute.ComputeManagementClient(subscriptionId, creds)

# I can still specify the default authority host to override the default settings...
public_azure_creds = azure.identity.DefaultAzureCredential(authority='https://login.windows.net')

# I can also specify a full cloud configuration object:
# In order to default to switch all default values to match the expected configuration for
# the Azure China Cloud.
azure.core.settings.cloud_configuration = azure.core.clouds.well_known['AzureChinaCloud']

# ...or pass in a custom cloud configuration instance into a method
config: typing.Mapping[str, CloudConfiguration] = {
  data['name']: CloudConfiguration.from_metadata_dict(data)
  for data in requests.get('https://some.cloud.instance/metadata/endpoints?api-version=2019-05-01 '.json()
}
creds = azure.identity.DefaultAzureCredential(cloud_configuration=config['AzureStackInstance1'])

# ...or by name
creds = azure.identity.DefaultAzureCredential(cloud_configuration='PublicAzure')
```

## Future evolution/addition of per-service endpoint configuration

* Over time metadata can be added for a given service/new services may be added. Client libraries that depend on the new metadata can set the minimum version of the azure core dependency to ensure that the new metadata is available for well-known clouds.

* New service entries are added to azure-core on demand (i.e. when a client library needs new configuration values)

## Issues

* Only updated client libraries will pick up the ambient default settings. This problem will fade over time as new client library versions are made aware of ambient settings.

## Appendix

### Cloud configuration schema

```json-schema
{   
    "$schema": "http://json-schema.org/draft-04/schema#",
    "$id": "https://example.com/cloudconfig.schema.json",
    "title": "Azure Cloud Configuration",
    "description": "Endpoint and authentication information for azure cloud instances",
    "type": "object",
    "required": [
        "authentication",
        "services"
    ],
    "properties": {
        "authentication": {
            "$ref": "#/$defs/Authentication"
        },
        "services": {
          "additionalProperties": {
              "$ref": "#/$defs/CloudConfiguration"
          }
        }
    },
    "$defs": {
        "Authentication": {
            "type": "object",
            "required": [ "loginEndpoint", "audiences", "tenant" ],
            "properties": {
                "loginEndpoint: {
                    "type": "string"
                },
                "audiences": {
                    "type": "array",
                    "items": {
                        "type": "string"
                    }
                },
                "tenant: {
                    "type": "string"
                },
                "identityProvider: {
                    "default": "AAD",
                    "type": "string"
                }
            }
        },
        "CloudConfiguration": {
            "type": "object",
            "properties": {
                "endpoint": {
                    "type": "string"
                },
                "suffix": {
                    "type": "string"
                },
                "audiences" : {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                }
            }
        }
    }
}
```
