---
title: "Python Guidelines: API Design"
keywords: guidelines python
permalink: python_design.html
folder: python
sidebar: general_sidebar
---

## Introduction

### Design principles

The Azure SDK should be designed to enhance the productivity of developers connecting to Azure services. Other qualities (such as completeness, extensibility, and performance) are important but secondary. Productivity is achieved by adhering to the principles described below:azu

#### Idiomatic

* The SDK should follow the design guidelines and conventions for the target language. It should feel natural to a developer in the target language.
* We embrace the ecosystem with its strengths and its flaws.
* We work with the ecosystem to improve it for all developers.

#### Consistent

* Client libraries should be consistent within the language, consistent with the service and consistent between all target languages. In cases of conflict, consistency within the language is the highest priority and consistency between all target languages is the lowest priority.
* Service-agnostic concepts such as logging, HTTP communication, and error handling should be consistent. The developer should not have to relearn service-agnostic concepts as they move between client libraries.
* Consistency of terminology between the client library and the service is a good thing that aids in diagnosability.
* All differences between the service and client library must have a good (articulated) reason for existing, rooted in idiomatic usage rather than whim.
* The Azure SDK for each target language feels like a single product developed by a single team.
* There should be feature parity across target languages. This is more important than feature parity with the service.

#### Approachable

* We are experts in the supported technologies so our customers, the developers, don't have to be.
* Developers should find great documentation (hero tutorial, how to articles, samples, and API documentation) that makes it easy to be successful with the Azure service.
* Getting off the ground should be easy through the use of predictable defaults that implement best practices. Think about progressive concept disclosure.
* The SDK should be easily acquired through the most normal mechanisms in the target language and ecosystem.
* Developers can be overwhelmed when learning new service concepts. The core use cases should be discoverable.

#### Diagnosable

* The developer should be able to understand what is going on.
* It should be discoverable when and under what circumstances a network call is made.
* Defaults are discoverable and their intent is clear.
* Logging, tracing, and exception handling are fundamental and should be thoughtful.
* Error messages should be concise, correlated with the service, actionable, and human readable. Ideally, the error message should lead the consumer to a useful action that they can take.
* Integrating with the preferred debugger for the target language should be easy.

#### Dependable

* Breaking changes are more harmful to a user's experience than most new features and improvements are beneficial.
* Incompatibilities should never be introduced deliberately without thorough review and very strong justification.
* Do not rely on dependencies that can force our hand on compatibility.

### General guidelines

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.

{% include requirement/MUST id="python-feature-support" %} support 100% of the features provided by the Azure service the client library represents. Gaps in functionality cause confusion and frustration among developers.

### Non-HTTP based services

These guidelines were written primarily with a HTTP based request/response in mind, but many general guidelines apply to other types of services as well. This includes, but is not limited to, packaging and naming, tools and project structures.

Please contact the [Architecture board] for more guidance on non HTTP/REST based services.

### Supported python versions

{% include requirement/MUST id="python-general-version-support" %} support Python 3.9+.

## Azure SDK API Design

Your API surface will consist of one or more _service clients_ that the consumer will instantiate to connect to your service, plus a set of supporting types.

### Service client

The service client is the primary entry point for users of the library. A service client exposes one or more methods that allow them to interact with the service.

{% include requirement/MUST id="python-client-namespace" %} expose the service clients the user is more likely to interact with from the root namespace of your package. Specialized service clients may be placed in sub-namespaces.

{% include requirement/MUST id="python-client-naming" %} name service client types with a **Client** suffix.

{% include requirement/MUST id="python-client-sync-async-separate-clients" %} provide separate sync and async clients. See the [Async Support](#async-support) section for more information.

```python
# Yes
class CosmosClient: ...

# No
class CosmosProxy: ...

# No
class CosmosUrl: ...
```

{% include requirement/MUST id="python-client-immutable" %} make the service client immutable. See the [Client Immutability](#client-immutability) section for more information.

#### Constructors and factory methods

Only the minimal information needed to connect and interact with the service should be required in order to construct a client instance. All additional information should be optional and passed in as optional keyword-only arguments.

##### Client configuration

{% include requirement/MUST id="python-client-constructor-form" %} provide a constructor that takes positional binding parameters (for example, the name of, or a URL pointing to the service instance), a positional `credential` parameter, a `transport` keyword-only parameter, and keyword-only arguments for passing settings through to individual HTTP pipeline policies. See the [Authentication](#authentication) section for more information on the `credential` parameter.

{% include requirement/MUSTNOT id="python-client-options-naming" %} use an "options bag" object to group optional parameters. Instead, pass as individual keyword-only arguments.

{% include requirement/MUST id="python-client-constructor-policy-arguments" %} accept optional default request options as keyword arguments and pass them along to its pipeline policies. See [Common service operation parameters](#common-service-operation-parameters) for more information.

```python
# Change default number of retries to 18 and overall timeout to 2s.
client = ExampleClient('https://contoso.com/xmpl',
                       DefaultAzureCredential(),
                       max_retries=18,
                       timeout=2)
```

{% include requirement/MUST id="python-client-constructor-transport-argument" %} allow users to pass in a `transport` keyword-only argument that allows the caller to specify a specific transport instance. The default value should be the [`RequestsTransport`](https://azuresdkdocs.z19.web.core.windows.net/python/azure-core/latest/azure.core.pipeline.transport.html?highlight=transport#azure.core.pipeline.transport.RequestsTransport) for synchronous clients and the [`AioHttpTransport`](https://azuresdkdocs.z19.web.core.windows.net/python/azure-core/latest/azure.core.pipeline.transport.html?highlight=transport#azure.core.pipeline.transport.AioHttpTransport) for async clients.

{% include requirement/MUST id="python-client-connection-string" %} use a separate factory classmethod `from_connection_string` to create a client from a connection string (if the client supports connection strings). The `from_connection_string` factory method should take the same set of arguments (excluding information provided in the connection string) as the constructor. The constructor (`__init__` method) **must not** take a connection string, even if it means that using the `from_connection_string` is the only supported method to create an instance of the client.

The method **should** parse the connection string and pass the values along with any additional keyword-only arguments except `credential` to the constructor.  Only provide a `from_connection_string` factory method if the Azure portal exposes a connection string for your service.

```python
class ExampleClientWithConnectionString:

    @classmethod
    def _parse_connection_string(cls, connection_string): ...

    @classmethod
    def from_connection_string(cls, connection_string, **kwargs):
        endpoint, credential = cls._parse_connection_string(connection_string)
        return cls(endpoint, credential, **kwargs)
```

```python
{% include_relative _includes/example_client.py %}
```

{% include requirement/MAY id="python-client-constructor-from-url" %} use a separate factory classmethod `from_<resource type>_url` (e.g. `from_blob_url`) to create a client from a URL (if the service relies on passing URLs to resources around - e.g. Azure Blob Storage). The `from_url` factory method should take the same set of optional keyword arguments as the constructor.

##### Specifying the Service Version

{% include requirement/MUST id="python-client-constructor-api-version-argument-1" %} accept an optional `api_version` keyword-only argument of type string. If specified, the provided api version MUST be used when interacting with the service. If the parameter is not provided, the default value MUST be the latest non-preview API version understood by the client library (if there the service has a non-preview version) or the latest preview API version understood by the client library (if the service does not have any non-preview API versions yet). This parameter MUST be available even if there is only one API version understood by the service in order to allow library developers to lock down the API version they expect to interact with the service with.

```python
from azure.identity import DefaultAzureCredential

# By default, use the latest supported API version
latest_known_version_client = ExampleClient('https://contoso.com/xmpl',
                                            DefaultAzureCredential())

# ...but allow the caller to specify a specific API version as welll
specific_api_version_client = ExampleClient('https://contoso.com/xmpl',
                                            DefaultAzureCredential(),
                                            api_version='1971-11-01')
```

{% include requirement/MUST id="python-client-constructor-api-version-argument-2" %} document the service API version that is used by default.

{% include requirement/MUST id="python-client-constructor-api-version-argument-3" %} document in which API version a feature (function or parameter) was introduced in if not all service API versions support it.

{% include requirement/MAY id="python-client-constructor-api-version-argument-4" %} validate the input `api_version` value against a list of supported API versions.

{% include requirement/MAY id="python-client-constructor-api-version-argument-5" %} include all service API versions that are supported by the client library in a `ServiceVersion` enumerated value.

##### Additional constructor parameters

|Name|Description|
|-|-|
|`credential`|Credentials to use when making service requests (See [Authentication](#authentication))|
|`application_id`|Name of the client application making the request. Used for telemetry|
|`api_version`|API version to use when making service requests (See [Service Version](#specifying-the-service-version)) |
|`transport`|Override the default HTTP transport (See [Client Configuration](#client-configuration))|

##### Client immutability

{% include requirement/MUST id="python-client-immutable-design" %} design the client to be immutable. This does not mean that you need to use read-only properties (attributes are still acceptable), but rather that the there should not be any scenarios that require callers to change properties/attributes of the client.

#### Service methods

##### Naming

{% include requirement/SHOULD id="python-client-service-verbs" %} prefer the usage one of the preferred verbs for method names. You should have a good (articulated) reason to have an alternate verb for one of these operations.

|Verb|Parameters|Returns|Comments|
|-|-|-|-|
|`create_\<noun>`|key, item, `[allow_overwrite=False]`|Created item|Create new item. Fails if item already exists.|
|`upsert_\<noun>`|key, item|item|Create new item, or update existing item. Verb is primarily used in database-like services |
|`set_\<noun>`|key, item|item|Create new item, or update existing item. Verb is primarily used for dictionary-like properties of a service |
|`update_\<noun>`|key, partial item|item|Fails if item doesn't exist. |
|`replace_\<noun>`|key, item|item|Completely replaces an existing item. Fails if the item doesn't exist. |
|`append_\<noun>`|item|item|Add item to a collection. Item will be added last. |
|`add_\<noun>`|index, item|item|Add item to a collection. Item will be added at the given index. |
|`get_\<noun>`|key|item|Raises an exception if item doesn't exist |
|`list_\<noun>`||`azure.core.ItemPaged[Item]`|Return an iterable of `Item`s. Returns an iterable with no items if no items exist (doesn't return `None` or throw)|
|`\<noun>\_exists`|key|`bool`|Return `True` if the item exists. Must raise an exception if the method failed to determine if the item exists (for example, the service returned an HTTP 503 response)|
|`delete_\<noun>`|key|`None`|Delete an existing item. Must succeed even if item didn't exist.|
|`remove_\<noun>`|key|removed item or `None`|Remove a reference to an item from a collection. This method doesn't delete the actual item, only the reference.|

{% include requirement/MUST id="python-client-standardize-verbs" %} standardize verb prefixes outside the list of preferred verbs for a given service across language SDKs. If a verb is called `download` in one language, we should avoid naming it `fetch` in another.

{% include requirement/MUST id="python-lro-prefix" %} prefix methods with `begin_` for [long running operations](#methods-invoking-long-running-operations).

{% include requirement/MUST id="python-paged-prefix" %} prefix methods with `list_` for methods that enumerate (lists) resources

##### Return types

Requests to the service fall into two basic groups - methods that make a single logical request, or a deterministic sequence of requests. An example of a single logical request is a request that may be retried inside the operation. An example of a deterministic sequence of requests is a paged operation.

The logical entity is a protocol neutral representation of a response. For HTTP, the logical entity may combine data from headers, body, and the status line. For example, you may wish to expose an `ETag` header as an `etag` attribute on the logical entity. For more information see [Model Types](#model-types).

{% include requirement/MUST id="python-response-logical-entity" %} optimize for returning the logical entity for a given request. The logical entity MUST represent the information needed in the 99%+ case.

{% include requirement/MUST id="python-response-exception-on-failure" %} raise an exception if the method call failed to accomplish the user specified task. This includes both situations where the service actively responded with a failure as well as when no response was received. See [Exceptions](#exceptions) for more information.

```python
client = ComputeClient(...)

try:
    # Please note that there is no status code etc. as part of the response.
    # If the call fails, you will get an exception that will include the status code
    # (if the request was made)
    virtual_machine  = client.get_virtual_machine('example')
    print(f'Virtual machine instance looks like this: {virtual_machine}')
except azure.core.exceptions.ServiceRequestError as e:
    print(f'Failed to make the request - feel free to retry. But the specifics are here: {e}')
except azure.core.exceptions.ServiceResponseError as e:
    print(f'The request was made, but the service responded with an error. Status code: {e.status_code}')
```

Do not return `None` or a `boolean` to indicate errors:

```python
# Yes
try:
    resource = client.create_resource(name)
except azure.core.errors.ResourceExistsException:
    print('Failed - we need to fix this!')

# No
resource = client.create_resource(name):
if not resource:
    print('Failed - we need to fix this!')
```

{% include requirement/MUSTNOT id="python-errors-normal-responses" %} throw an exception for "normal responses".

Consider an `exists` method. The method **must** distinguish between the service returned a client error 404/NotFound and a failure to even make a request:

```python
# Yes
try:
    exists = client.resource_exists(name):
    if not exists:
        print("The resource doesn't exist...")
except azure.core.errors.ServiceRequestError:
    print("We don't know if the resource exists - so it was appropriate to throw an exception!")

# No
try:
    client.resource_exists(name)
except azure.core.errors.ResourceNotFoundException:
    print("The resource doesn't exist... but that shouldn't be an exceptional case for an 'exists' method")
```

##### Cancellation

{% include requirement/MUST id="python-client-cancellation-sync-methods" %} provide an optional keyword argument `timeout` to allow callers to specify how long they are willing to wait for the method to complete. The `timeout` is in seconds, and should be honored to the best extent possible.

 {% include requirement/MUST id="python-client-cancellation-async-methods" %} use the standard [asyncio.Task.cancel](https://docs.python.org/3/library/asyncio-task.html#asyncio.Task.cancel) method to cancel async methods.

#### Service Method Parameters

{% include requirement/MUST id="python-client-optional-arguments-keyword-only" %} provide optional operation-specific arguments as keyword only. See [positional and keyword-only arguments] for more information.

{% include requirement/MUST id="python-client-service-per-call-args" %} provide keyword-only arguments that override per-request policy options. The name of the parameters MUST mirror the name of the arguments provided in the client constructor or factory methods.
For a full list of supported optional arguments used for pipeline policy and transport configuration (both at the client constructor and per service operation), see the [Azure Core developer documentation](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/core/azure-core/CLIENT_LIBRARY_DEVELOPER.md).

{% include requirement/MUST id="python-client-service-args-conflict" %} qualify a service parameter name if it conflicts with any of the documented pipeline policy or transport configuration options used with all service operations and client constructors.

```python
# Set the default number of retries to 18 and timeout to 2s for this client instance.
client = ExampleClient('https://contoso.com/xmpl', DefaultAzureCredential(), max_retries=18, timeout=2)

# Override the client default timeout for this specific call to 32s (but max_retries is kept to 18)
client.do_stuff(timeout=32)
```

##### Parameter validation

The service client will have several methods that send requests to the service. **Service parameters** are directly passed across the wire to an Azure service. **Client parameters** aren't passed directly to the service, but used within the client library to fulfill the request. Parameters that are used to construct a URI, or a file to be uploaded are examples of client parameters.

{% include requirement/MUST id="python-params-client-validation" %} validate client parameters. Validation is especially important for parameters used to build up the URL since a malformed URL means that the client library will end up calling an incorrect endpoint.

```python
# No:
def get_thing(name: str) -> str:
    url = f'https://<host>/things/{name}'
    return requests.get(url).json()

try:
    thing = get_thing('') # Ooops - we will end up calling '/things/' which usually lists 'things'. We wanted a specific 'thing'.
except ValueError:
    print('We called with some invalid parameters. We should fix that.')

# Yes:
def get_thing(name: str) -> str:
    if not name:
        raise ValueError('name must be a non-empty string')
    url = f'https://<host>/things/{name}'
    return requests.get(url).json()

try:
    thing = get_thing('')
except ValueError:
    print('We called with some invalid parameters. We should fix that.')
```

{% include requirement/MUSTNOT id="python-params-service-validation" %} validate service parameters. Don't do null checks, empty string checks, or other common validating conditions on service parameters. Let the service validate all request parameters.

{% include requirement/MUST id="python-params-devex" %} verify that the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service. Work with the service team if the developer experience is compromised because of service-side error messages.

##### Common service operation parameters

{% include requirement/MUST id="python-client-service-args" %} support the common arguments for service operations:

|Name|Description|Applies to|Notes|
|-|-|-|-|
|`timeout`|Timeout in seconds|All service methods|
|`headers`|Custom headers to include in the service request|All requests|Headers are added to all requests made (directly or indirectly) by the method.|
|`client_request_id`|Caller specified identification of the request.|Service operations for services that allow the client to send a client-generated correlation ID.|Examples of this include `x-ms-client-request-id` headers.|The client library **must** use this value if provided, or generate a unique value for each request when not specified.|
|`response_hook`|`callable` that is called with (response, headers) for each operation.|All service methods|

{% include requirement/MUST id="python-client-splat-args" %} accept a Mapping (`dict`-like) object in the same shape as a serialized model object for parameters.

```python
# Yes:
class Thing:

    def __init__(self, name, size):
        self.name = name
        self.size = size

def do_something(thing: "Thing"):
    ...

do_something(Thing(name='a', size=17)) # Works
do_something({'name': 'a', 'size', '17'}) # Does the same thing...
```

{% include requirement/MUST id="python-client-flatten-args" %} use "flattened" named arguments for `update_` methods. **May** additionally take the whole model instance as a named parameter. If the caller passes both a model instance and individual key=value parameters, the explicit key=value parameters override whatever was specified in the model instance.

```python
class Thing:

    def __init__(self, name, size, description):
        self.name = name
        self.size = size
        self.description = description

    def __repr__(self):
        return json.dumps({
            "name": self.name, "size": self.size, "description": self.description
        })[:1024]

class Client:

    def update_thing(self, name=None, size=None, thing=None): ...

thing = Thing(name='hello', size=4711, description='This is a description...')

client.update_thing(thing=thing, size=4712) # Will send a request to the service to update the model's size to 4712
thing.description = 'Updated'
thing.size = -1
# Will send a request to the service to update the model's size to 4713 and description to 'Updated'
client.update_thing(name='hello', size=4713, thing=thing)
```

#### Methods returning collections (paging)

Services may require multiple requests to retrieve the complete set of items in large collections. This is generally done by the service returning a partial result, and in the response providing a token or link that the client can use to retrieve the next batch of responses in addition to the set of items.

In Azure SDK for Python cilent libraries, this is exposed to users through the [ItemPaged protocol](#python-core-protocol-paged). The `ItemPaged` protocol optimizes for retrieving the full set of items rather than forcing users to deal with the underlying paging.

{% include requirement/MUST id="python-response-paged-protocol" %} return a value that implements the [ItemPaged protocol](#python-core-protocol-paged) for operations that return collections. The [ItemPaged protocol](#python-core-protocol-paged) allows the user to iterate through all items in a returned collection, and also provides a method that gives access to individual pages.

```python
client = ExampleClient(...)

# List all things - paging happens transparently in the
# background.
for thing in client.list_things():
    print(thing)

# The protocol also allows you to list things by page...
for page_no, page in enumerate(client.list_things().by_page()):
    print(page_no, page)
```

{% include requirement/MAY id="python-response-paged-results" %} expose a `results_per_page` keyword-only parameter where supported by the service (e.g. an OData `$top` query parameter).

{% include requirement/SHOULDNOT id="python-response-paged-continuation" %} expose a continuation parameter in the `list_` client method - this is supported in the `by_page()` function.

```python
client = ExampleClient(...)

# No - don't pass in the continuation token directly to the method...
for thing in client.list_things(continuation_token='...'):
    print(thing)

# Yes - provide a continuation_token to in the `by_page` method...
for page in client.list_things().by_page(continuation_token='...'):
    print(page)
```

{% include requirement/MUST id="python-paged-non-server-paged-list" %} return a value that implements the [ItemPaged protocol](#python-core-protocol-paged) even if the service API currently do not support server driven paging. This allows server driven paging to be added to the service API without introducing breaking changes in the client library.

#### Methods invoking long running operations

Service operations that take a long time (currently defined in the [Microsoft REST API Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/Guidelines.md#141-principles) as not completing in 0.5s in P99) to complete are modeled by services as long running operations.

Python client libraries abstracts the long running operation using the [Long running operation Poller protocol](#python-core-protocol-lro-poller).
In cases where a service API is not explicitly implemented as a long-running operation, but the common usage pattern requires a customer to sleep or poll a status - it's likely that these API's should still be represented in the SDK using the Poller protocol.

{% include requirement/MUST id="python-lro-poller" %} return an object that implements the [Poller protocol](#python-core-protocol-lro-poller) for long running operations.

{% include requirement/MUST id="python-lro-poller-begin-naming" %} use a `begin_` prefix for all long running operations.

#### Conditional request methods

{% include requirement/MUST id="python-method-conditional-request" %} add a keyword-only `match_condition` parameter for service methods that support conditional requests. The parameter should support the `azure.core.MatchConditions` type defined in `azure-core` as input.

{% include requirement/MUST id="python-method-conditional-request-etag" %} add a keyword-only `etag` parameter for service methods that support conditional requests. For service methods that take a model instance that has an `etag` property, the explicit `etag` value passed in overrides the value in the model instance.

```python
class Thing:

    def __init__(self, name, etag):
        self.name = name
        self.etag = etag

thing = client.get_thing('theName')

# Uses the etag from the retrieved thing instance....
client.update_thing(thing, name='updatedName', match_condition=azure.core.MatchConditions.IfNotModified)

# Uses the explicitly provided etag.
client.update_thing(thing, name='updatedName2', match_condition=azure.core.MatchConditions.IfNotModified, etag='"igotthisetagfromsomewhereelse"')
```

#### Hierarchical clients

Many services have resources with nested child (or sub) resources. For example, Azure Storage provides an account that contains zero or more containers, which in turn contains zero or more blobs.

{% include requirement/MUST id="python-client-hierarchy" %} create a client type corresponding to each level in the hierarchy except for leaf resource types. You **may** omit creating a client type for leaf node resources.

{% include requirement/MUST id="python-client-hier-creation" %} make it possible to directly create clients for each level in the hierarchy.  The constructor can be called directly or via the parent.

```python
class ChildClient:
    # Yes:
    __init__(self, parent, name, credentials, **kwargs) ...

class ChildClient:
    # Yes:
    __init__(self, url, credentials, **kwargs) ...
```

{% include requirement/MUST id="python-client-hier-vend" %} provide a `get_<child>_client(self, name, **kwargs)` method to retrieve a client for the named child. The method must not make a network call to verify the existence of the child.

{% include requirement/MUST id="python-client-hier-create" %} provide method `create_<child>(...)` that creates a child resource. The method **should** return a client for the newly created child resource.

{% include requirement/SHOULD id="python-client-hier-delete" %} provide method `delete_<child>(...)` that deletes a child resource.

### Supporting types

#### Model types

Client libraries represent entities transferred to and from Azure services as model types. Certain types are used for round-trips to the service. They can be sent to the service (as an addition or update operation) and retrieved from the service (as a get operation). These should be named according to the type. For example, a `ConfigurationSetting` in App Configuration, or a `VirtualMachine` on for Azure Resource Manager.

Data within the model type can generally be split into two parts - data used to support one of the champion scenarios for the service, and less important data. Given a type `Foo`, the less important details can be gathered in a type called `FooDetails` and attached to `Foo` as the `details` attribute.

{% include requirement/MUST id="python-models-input-dict" %} support dicts as alternative inputs to model types.

{% include requirement/MUST id="python-models-input-constructor" %} craft a constructor for models that are intended to be instantiated by a user (i.e. non-result types) with minimal required information and optional information as keyword-only arguments.

{% include requirement/MAY id="python-models-generated" %} expose models from the generated layer by adding to the root `__init__.py` (and `__all__`) if they otherwise meet the guidelines.

{% include requirement/MUSTNOT id="python-models-async" %} duplicate models between the root and `aio` namespace.

In order to facilitate round-trip of responses (common in get resource -> conditionally modify resource -> set resource workflows), output model types should use the input model type (e.g. `ConfigurationSetting`) whenever possible. The `ConfigurationSetting` type should include both server generated (read-only) attributes even though they will be ignored when used as input to the set resource method.

- `<model>Item` for each item in an enumeration if the enumeration returns a partial schema for the model. For example, GetBlobs() return an enumeration of BlobItem, which contains the blob name and metadata, but not the content of the blob.
- `<operation>Result` for the result of an operation. The `<operation>` is tied to a specific service operation. If the same result can be used for multiple operations, use a suitable noun-verb phrase instead. For example, use `UploadBlobResult` for the result from `UploadBlob`, but `ContainerChangeResult` for results from the various methods that change a blob container.

{% include requirement/MUST id="python-models-dict-result" %} use a simple Mapping (e.g. `dict`) rather than creating a `<operation>Result` class if the `<operation>Result` class is not used as an input parameter for other APIs.

The following table enumerates the various models you might create:

|Type|Example|Usage|
|-|-|
|<model>|Secret|The full data for a resource|
|<model>Details|SecretDetails|Less important details about a resource. Attached to <model>.details|
|<model>Item|SecretItem|A partial set of data returned for enumeration|
|<operation>Result|AddSecretResult|A partial or different set of data for a single operation|
|<model><verb>Result|SecretChangeResult|A partial or different set of data for multiple operations on a model|

```python
# An example of a model type.
class ConfigurationSetting:
    """Model type representing a configuration setting

    :ivar name: The name of the setting
    :vartype name: str
    :ivar value: The value of the setting
    :vartype value: object
    """

    def __init__(self, name: str, value: object):
        self.name = name
        self.value = value

    def __repr__(self) -> str:
        return json.dumps(self.__dict__)[:1024]
```

#### Enumerations

{% include requirement/MUST id="python-models-enum-string" %} use extensible enumerations.

{% include requirement/MUST id="python-models-enum-name-uppercase" %} use UPPERCASE names for enum names.

```python

# Yes
class MyGoodEnum(str, Enum):
    ONE = 'one'
    TWO = 'two'

# No
class MyBadEnum(str, Enum):
    One = 'one' # No - using PascalCased name.
    two = 'two' # No - using all lower case name.
```

### Exceptions

{% include requirement/SHOULD id="python-errors-azure-exceptions" %} prefer raising [existing exception types from the `azure-core`](https://azuresdkdocs.z19.web.core.windows.net/python/azure-core/latest/index.html#azure-core-library-exceptions) package over creating new exception types.

{% include requirement/MUSTNOT id="python-errors-use-standard-exceptions" %} create new exception types when a [built-in exception type](https://docs.python.org/3/library/exceptions.html) will suffice.

{% include requirement/SHOULDNOT id="python-errors-new-exceptions" %} create a new exception type unless the developer can handle the error programmatically.  Specialized exception types related to service operation failures should be based on existing exception types from the [`azure-core`](https://azuresdkdocs.z19.web.core.windows.net/python/azure-core/latest/index.html#azure-core-library-exceptions) package.

For higher-level methods that use multiple HTTP requests, either the last exception or an aggregate exception of all failures should be produced.

{% include requirement/MUST id="python-errors-rich-info" %} include any service-specific error information in the exception.  Service-specific error information must be available in service-specific properties or fields.

{% include requirement/MUST id="python-errors-documentation" %} document the errors that are produced by each method. Don't document commonly thrown errors that wouldn't normally be documented in Python (e.g. `ValueError`, `TypeError`, `RuntimeError` etc.)

### Authentication

{% include requirement/MUST id="python-auth-credential-azure-core" %} use the credentials classes in `azure-core` whenever possible.

{% include requirement/MUST id="python-auth-policy-azure-core" %} use authentication policy implementations in `azure-core` whenever possible.

{% include requirement/MAY  id="python-auth-service-credentials" %} add additional credential types if required by the service. Contact the [Architecture board] for guidance if you believe you have need to do so.

{% include requirement/MUST id="python-auth-service-support" %} support all authentication methods that the service supports.

### Namespaces

In the guidelines below, the term "namespace" is used to denote a python package or module (i.e. something that you would `import` in your code). The term "distribution package" is used to describe the artifact you publish to and install from your package manager (i.e. something that you would `pip install`).

{% include requirement/MUST id="python-namespaces-prefix" %} implement your library as a sub-package of the `azure` root namespace.

> Note: You MUST NOT use `microsoft` as your root namespace. If you need to include `microsoft` in the namespace (e.g. because of policy requirements for extensions to other projects such as `opentelemetry`), you should concatenate it with the package specific namespace with an underscore (e.g. `microsoft_myservice`). You may still use `microsoft-myservice` as the distribution package name in this scenario.

{% include requirement/MUST id="python-namespaces-naming" %} pick a package name that allows the consumer to tie the namespace to the service being used. As a default, use the compressed service name at the end of the namespace. The namespace does NOT change when the branding of the product changes. Avoid the use of marketing names that may change.

A compressed service name is the service name without spaces. It may further be shortened if the shortened version is well known in the community. For example, “Azure Media Analytics” would have a compressed service name of `mediaanalytics`, and “Azure Service Bus” would become `servicebus`.  Separate words using an underscore if necessary. For example, `mediaanalytics` could be separated into `media_analytics`

{% include requirement/MAY id="python-namespaces-grouping" %} include a group name segment in your namespace (for example, `azure.<group>.<servicename>`) if your service or family of services have common behavior (for example, shared authentication types).

{% include requirement/MUST id="python-namespaces-grouping-dont-introduce-new-packages" %} avoid introducing new distribution packages that only differ in name. For existing packages, this means that you should not change the name of the package just to introduce a group name.

If you want to use a group name segment, use one of the following groups:

{% include tables/data_namespaces.md %}

{% include requirement/MUST id="python-namespaces-mgmt" %} place management (Azure Resource Manager) APIs in the `mgmt` group. Use the grouping `azure.mgmt.<servicename>` for the namespace. Since more services require control plane APIs than data plane APIs, other namespaces may be used explicitly for control plane only.

{% include requirement/MUST id="python-namespaces-register" %} register the chosen namespace with the [Architecture Board].  Open an [issue] to request the namespace.  See [the registered namespace list](registered_namespaces.html) for a list of the currently registered namespaces.

{% include requirement/MUST id="python-namespaces-async" %} use an `.aio` suffix added to the namespace of the sync client for async clients.

Example:

```python
# Yes:
from azure.exampleservice.aio import ExampleServiceClient

# No: Wrong namespace, wrong client name...
from azure.exampleservice import AsyncExampleServiceClient
```

#### Example Namespaces

Here are some examples of namespaces that meet these guidelines:

- `azure.storage.blob`
- `azure.keyvault.certificates`
- `azure.ai.textanalytics`
- `azure.mgmt.servicebus`

### Async support

Despite the availability of the `asyncio` library and the `async`/`await` keywords, most Python developers aren't familiar with or comfortable using libraries that only provide asynchronous methods.

{% include requirement/MUST id="python-client-sync-async" %} provide both sync and async versions of your APIs

{% include requirement/MUST id="python-client-async-keywords" %} use the `async`/`await` keywords. Do not use the [yield from coroutine or asyncio.coroutine](https://docs.python.org/3.4/library/asyncio-task.html) syntax.

{% include requirement/MUST id="python-client-separate-sync-async" %} provide two separate client classes for synchronous and asynchronous operations.  Do not combine async and sync operations in the same class.

```python
# Yes
# In module azure.example
class ExampleClient:
    def some_service_operation(self, name, size) ...

# In module azure.example.aio
class ExampleClient:
    # Same method name as sync, different client
    async def some_service_operation(self, name, size) ...

# No
# In module azure.example
class ExampleClient:
    def some_service_operation(self, name, size) ...

class AsyncExampleClient: # No async/async pre/postfix.
    async def some_service_operation(self, name, size) ...

# No
# In module azure.example
class ExampleClient: # Don't mix'n match with different method names
    def some_service_operation(self, name, size) ...
    async def some_service_operation_async(self, name, size) ...

```

{% include requirement/MUST id="python-client-same-name-sync-async" %} use the same client name for sync and async packages

Example:

|Sync/async|Namespace|Distribution package name|Client name|
|-|-|-|-|
|Sync|`azure.sampleservice`|`azure-sampleservice`|`azure.sampleservice.SampleServiceClient`|
|Async|`azure.sampleservice.aio`|`azure-sampleservice-aio`|`azure.sampleservice.aio.SampleServiceClient`|

{% include requirement/MUST id="python-client-namespace-sync" %} use the same namespace for the synchronous client as the synchronous version of the package with `.aio` appended.

Example:

```python
from azure.storage.blob import BlobServiceClient # Sync client

from azure.storage.blob.aio import BlobServiceClient # Async client
```

{% include requirement/SHOULD id="python-client-separate-async-pkg" %} ship a separate package for async support if the async version requires additional dependencies.

{% include requirement/MUST id="python-client-same-pkg-name-sync-async" %} use the same name for the asynchronous version of the package as the synchronous version of the package with `-aio` appended.

{% include requirement/MUST id="python-client-async-http-stack" %} use [`aiohttp`](https://aiohttp.readthedocs.io/en/stable/) as the default HTTP stack for async operations. Use `azure.core.pipeline.transport.AioHttpTransport` as the default `transport` type for the async client.

## Azure SDK distribution packages

### Packaging

{% include requirement/MUST id="python-packaging-name" %} name your package after the namespace of your main client class. For example, if your main client class is in the `azure.data.tables` namespace, your package name should be azure-data-tables.

{% include requirement/MUST id="python-packaging-name-allowed-chars" %} use all lowercase in your package name with a dash (-) as a separator.

{% include requirement/MUSTNOT id="python-packaging-name-disallowed-chars" %} use underscore (_) or period (.) in your package name. If your namespace includes underscores, replace them with dash (-) in the distribution package name.

{% include requirement/MUST id="python-packaging-follow-repo-rules" %} follow the specific package guidance from the [azure-sdk-packaging wiki](https://github.com/Azure/azure-sdk-for-python/wiki/Azure-packaging)

{% include requirement/MUST id="python-packaging-follow-python-rules" %} follow the [namespace package recommendations for Python 3.x](https://docs.python.org/3/reference/import.html#namespace-packages).

{% include requirement/MUST id="python-general-supply-sdist" %} provide both source distributions (`sdist`) and wheels.

{% include requirement/MUST id="python-general-pypi" %} publish both source distributions (`sdist`) and wheels to PyPI.

{% include requirement/MUST id="python-general-wheel-behavior" %} test correct behavior for both CPython and PyPy for [pure](https://packaging.python.org/guides/distributing-packages-using-setuptools/#id75) and [universal](https://packaging.python.org/guides/distributing-packages-using-setuptools/#universal-wheels) Python wheels.

{% include requirement/MUST id="python-packaging-init" %} include `__init__.py` for the namespace(s) in sdists

#### Service-specific common library code

There are occasions when common code needs to be shared between several client libraries.  For example, a set of cooperating client libraries may wish to share a set of exceptions or models.

{% include requirement/MUST id="python-commonlib-approval" %} gain [Architecture Board] approval prior to implementing a common library.

{% include requirement/MUST id="python-commonlib-minimize-code" %} minimize the code within a common library.  Code within the common library is available to the consumer of the client library and shared by multiple client libraries within the same namespace.

A common library will only be approved if:

* The consumer of the non-shared library will consume the objects within the common library directly, AND
* The information will be shared between multiple client libraries

Let's take two examples:

1. Implementing two Cognitive Services client libraries, we find that they both rely on the same business logic. This is a candidate for choosing a common library.

2. Two Cognitive Services client libraries have models (data classes) that are the same in shape, but has no or minimal logic associated with them. This is not a good candidate for a shared library. Instead, implement two separate classes.

### Package Versioning

{% include requirement/MUST id="python-versioning-semver" %} use [semantic versioning](https://semver.org) for your package.

{% include requirement/MUST id="python-versioning-beta" %} use the `bN` pre-release segment for [beta releases](https://www.python.org/dev/peps/pep-0440/#pre-releases).

Don't use pre-release segments other than the ones defined in [PEP440](https://www.python.org/dev/peps/pep-0440) (`aN`, `bN`, `rcN`). Build tools, publication tools, and index servers may not sort the versions correctly.

{% include requirement/MUST id="python-versioning-changes" %} change the version number if *anything* changes in the library.

{% include requirement/MUST id="python-versioning-patch" %} increment the patch version if only bug fixes are added to the package.

{% include requirement/MUST id="python-verioning-minor" %} increment the minor version if any new functionality is added to the package.

{% include requirement/MUST id="python-versioning-apiversion" %} increment (at least) the minor version if the default REST API version is changed, even if there's no public API change to the library.

{% include requirement/MUSTNOT id="python-versioning-api-major" %} increment the major version for a new REST API version unless it requires breaking API changes in the python library itself.

{% include requirement/MUST id="python-versioning-major" %} increment the major version if there are breaking changes in the package. Breaking changes require prior approval from the [Architecture Board].

{% include requirement/MUST id="python-versioning-major-cross-languages" %} select a version number greater than the highest version number of any other released Track 1 package for the service in any other scope or language.

The bar to make a breaking change is extremely high for stable client libraries.  We may create a new package with a different name to avoid diamond dependency issues.

### Dependencies

{% include requirement/MUST id="python-dependencies-approved-list" %} only pick external dependencies from the following list of well known packages for shared functionality:

{% include_relative approved_dependencies.md %}

{% include requirement/MUSTNOT id="python-dependencies-external" %} use external dependencies outside the list of well known dependencies. To get a new dependency added, contact the [Architecture Board].

{% include requirement/MUSTNOT id="python-dependencies-vendor" %} vendor dependencies unless approved by the [Architecture Board].

When you vendor a dependency in Python, you include the source from another package as if it was part of your package.

{% include requirement/MUSTNOT id="python-dependencies-pin-version" %} pin a specific version of a dependency unless that is the only way to work around a bug in said dependencies versioning scheme.

Only applications are expected to pin exact dependencies. Libraries are not. A library should use a [compatible release](https://www.python.org/dev/peps/pep-0440/#compatible-release) identifier for the dependency.

### Binary extensions (native code)

{% include requirement/MUST id="python-native-approval" %} seek approval by the [Architecture Board] before implementing a binary extension.

{% include requirement/MUST id="python-native-plat-support" %} support Windows, Linux (manylinux - see [PEP513](https://www.python.org/dev/peps/pep-0513/), [PEP571](https://www.python.org/dev/peps/pep-0571/)), and MacOS.  Support the earliest possible manylinux to maximize your reach.

{% include requirement/MUST id="python-native-arch-support" %} support both x86 and x64 architectures.

### Docstrings

{% include requirement/MUST id="python-docstrings-pydocs" %} follow the [documentation guidelines](https://aka.ms/pydocs) unless explicitly overridden in this document.

{% include requirement/MUST id="python-docstrings-all" %} provide docstrings for all public modules, types, constants and functions.

{% include requirement/MUST id="python-docstrings-kwargs" %} document any `**kwargs` directly consumed by a method. If `**kwargs` are passed through to another API, you **must** document which API(s) will be called with the forwarded `**kwargs`.

Example:
```python
def request(method, url, headers, **kwargs): ...

def get(*args, **kwargs):
    """Calls `request` with the method "GET" and forwards all other arguments.

    Keyword arguments are passed to :func:`request`.
    """
    return request("GET", *args, **kwargs)
```

{% include requirement/MUST id="python-docstrings-exceptions" %} document exceptions that may be raised explicitly in the method and any exceptions raised by the called method.

#### Code snippets

{% include requirement/MUST id="python-snippets-include" %} include example code snippets alongside your library's code within the repository. The snippets should clearly and succinctly demonstrate the operations most developers need to perform with your library. Include snippets for every common operation, and especially for those that are complex or might otherwise be difficult for new users of your library. At a bare minimum, include snippets for the champion scenarios you've identified for the library.

{% include requirement/MUST id="python-snippets-build" %} build and test your example code snippets using the repository's continuous integration (CI) to ensure they remain functional.

{% include requirement/MUST id="python-snippets-docstrings" %} include the example code snippets in your library's docstrings so they appear in its API reference. If the language and its tools support it, ingest these snippets directly into the API reference from within the docstrings. Each sample should be a valid `pytest`.

Use the `literalinclude` directive in Python docstrings to instruct Sphinx to [ingest the snippets automatically][1].

{% include requirement/MUSTNOT id="python-snippets-combinations" %} combine more than one operation in a code snippet unless it's required for demonstrating the type or member, or it's *in addition to* existing snippets that demonstrate atomic operations. For example, a Cosmos DB code snippet should not include both account and container creation operations--create two different snippets, one for account creation, and one for container creation.

## Repository Guidelines

### Documentation style

There are several documentation deliverables that must be included in or as a companion to your client library. Beyond complete and helpful API documentation within the code itself (docstrings), you need a great README and other supporting documentation.

* `README.md` - Resides in the root of your library's directory within the SDK repository; includes package installation and client library usage information. ([example][https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/appconfiguration/azure-appconfiguration/README.md])
* `API reference` - Generated from the docstrings in your code; published on docs.microsoft.com.
* `Code snippets` - Short code examples that demonstrate single (atomic) operations for the champion scenarios you've identified for your library; included in your README, docstrings, and Quickstart.
* `Quickstart` - Article on docs.microsoft.com that is similar to but expands on the README content; typically written by your service's content developer.
* `Conceptual` - Long-form documentation like Quickstarts, Tutorials, How-to guides, and other content on docs.microsoft.com; typically written by your service's content developer.

{% include requirement/MUST id="python-docs-content-dev" %} include your service's content developer in the adparch review for your library. To find the content developer you should work with, check with your team's Program Manager.

{% include requirement/MUST id="python-docs-contributor-guide" %} follow the [Azure SDK Contributors Guide]. (MICROSOFT INTERNAL)

{% include requirement/MUST id="python-docs-style-guide" %} adhere to the specifications set forth in the Microsoft style guides when you write public-facing documentation. This applies to both long-form documentation like a README and the docstrings in your code. (MICROSOFT INTERNAL)

* [Microsoft Writing Style Guide].
* [Microsoft Cloud Style Guide].

{% include requirement/SHOULD id="python-docs-into-silence" %} attempt to document your library into silence. Preempt developers' usage questions and minimize GitHub issues by clearly explaining your API in the docstrings. Include information on service limits and errors they might hit, and how to avoid and recover from those errors.

As you write your code, *doc it so you never hear about it again.* The less questions you have to answer about your client library, the more time you have to build new features for your service.

### Samples

Code samples are small applications that demonstrate a certain feature that is relevant to the client library. Samples allow developers to quickly understand the full usage requirements of your client library. Code samples shouldn't be any more complex than they needed to demonstrate the feature. Don't write full applications. Samples should have a high signal to noise ratio between useful code and boilerplate code for non-related reasons.

{% include requirement/MUST id="python-samples-include-them" %} include code samples alongside your library's code within the repository. The samples should clearly and succinctly demonstrate the code most developers need to write with your library. Include samples for all common operations. Pay attention to operations that are complex or might be difficult for new users of your library. Include samples for the champion scenarios you've identified for the library.

{% include requirement/MUST id="python-samples-location" %} place code samples within the /samples directory within the client library root directory. The samples will be packaged into the resulting distribution package.

{% include requirement/MUST id="python-samples-runnable" %} ensure that each sample file is runnable.

{% include requirement/MUST id="python-samples-coding-style" %} avoid using features newer than the Python 3 baseline support. The current minimum supported Python version is 3.9.

{% include requirement/MUST id="python-samples-grafting" %} ensure that code samples can be easily grafted from the documentation into a users own application. For example, don't rely on variable declarations in other samples.

{% include requirement/MUST id="python-samples-readability" %} write code samples for ease of reading and comprehension over code compactness and efficiency.

{% include requirement/MUST id="python-samples-platform-support" %} ensure that samples can run in Windows, macOS, and Linux development environments.

{% include requirement/MUSTNOT id="python-snippets-no-combinations" %} combine multiple scenarios in a code sample unless it's required for demonstrating the type or member. For example, a Cosmos DB code sample doesn't include both account and container creation operations. Create a sample for account creation, and another sample for container creation.

Combined scenarios require knowledge of additional operations that might be outside their current focus. The developer must first understand the code surrounding the scenario they're working on, and can't copy and paste the code sample into their project.

{% include refs.md %}
{% include_relative refs.md %}
