---
title: "Python Guidelines: API Design"
keywords: guidelines python
permalink: python_design.html
folder: python
sidebar: general_sidebar
---

## Introduction

### General guidelines

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.

{% include requirement/MUST id="python-feature-support" %} support 100% of the features provided by the Azure service the client library represents. Gaps in functionality cause confusion and frustration among developers.

### Non-HTTP based services

These guidelines were written primarily with a HTTP based request/response in mind, but many general guidelines apply to other types of services as well. This includes, but is not limited to, packaging and naming, tools and project structures.

Please contact @adparch for more guidance on non HTTP/REST based services. TODO JOHAN: update contact information.

## Azure SDK API Design

Your API surface will consist of one or more _service clients_ that the consumer will instantiate to connect to your service, plus a set of supporting types.

### Service client

The service client is the primary entry point for users of the library. A service client exposes one or more methods that allow them to interact with the service.

{% include requirement/MUST id="python-client-namespace" %} expose the service clients the user is more likely to interact with from the root namespace of your package.

{% include requirement/MUST id="python-client-naming" %} name service client types with a **Client** suffix.

{% include requirement/MUST id="python-client-sync-async" %} provide separate sync and async clients. See the <link> TODO: JOHAN - point to the async section for more information.

```python
# Yes
class CosmosClient(object) ... 

# No
class CosmosProxy(object) ... 

# No
class CosmosUrl(object) ... 
```

{% include requirement/MUST id="python-client-immutable" %} make the service client immutable.

#### Constructors and factory methods

Only the minimal information needed to connect and interact with the service should be required in order to construct a client instance. All additional information should be optional and passed in as optional keyword-only arguments.

{% include requirement/MUST id="python-client-constructor-form" %} provide a constructor that takes positional binding parameters (for example, the name of, or a URL pointing to the service instance), a positional `credential` parameter, a `transport` keyword-only parameter, and keyword-only arguments (emulated using `**kwargs` for Python 2.7 support) for passing settings through to individual HTTP pipeline policies.

{% include requirement/MUST id="python-client-constructor-api-version-argument" %} accept an optional `api_version` keyword-only argument of type string. If specified, the provided api version MUST be used when interacting with the service. If the parameter is not provided, the default value MUST be the latest non-preview API version understood by the client library (if there the service has a non-preview version) or the latest preview API version understood by the client library (if the service does not have any non-preview API versions yet). This parameter MUST be available even if there is only one API version understood by the service in order to allow library developers lock down the API version they expect to interact with the service with.

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

{% include requirement/MUST id="python-client-constructor-policy-arguments" %} accept optional default request options as keyword arguments and pass them along to its pipeline policies. See well-known policy arguments for more information. TODO: Johan, link to table...

```python
# Change default number of retries to 18 and overall timeout to 2s.
client = ExampleClient('https://contoso.com/xmpl', 
                       DefaultAzureCredential(), 
                       max_retries=18,
                       timeout=2)
```

{% include requirement/MUST id="python-client-constructor-transport-argument" %} allow users to pass in a `transport` keyword-only argument that allows the caller to specify a specific transport instance. The default value should be the [`RequestsTransport`](https://azuresdkdocs.blob.core.windows.net/$web/python/azure-core/1.1.1/azure.core.pipeline.transport.html?highlight=transport#azure.core.pipeline.transport.RequestsTransport) for synchronous clients and the [`AioHttpTransport`](https://azuresdkdocs.blob.core.windows.net/$web/python/azure-core/1.1.1/azure.core.pipeline.transport.html?highlight=transport#azure.core.pipeline.transport.AioHttpTransport) for async clients. TODO: JOHAN, link to azure core transport and double-check names.


{% include requirement/MUST id="python-client-connection-string" %} use a separate factory class method `from_connection_string` to create a client from a connection string (if the client supports connection strings). The `from_connection_string` factory method should take the same set of arguments (excluding information provided in the connection string) as the constructor. The constructor **must not** take a connection string, even if it means that using the `from_connection_string` is the only supported method to create an instance of the client.

The method **should** parse the connection string and pass the values along with any additional keyword-only arguments except `credential` to the constructor.  Only provide a `from_connection_string` factory method only if the Azure portal exposes a connection string for your service.

```python
class ExampleClientWithConnectionString(object):
    
    @classmethod
    def _parse_connection_string(cls, connection_string): ...

    @classmethod
    def from_connection_string(cls, connection_string, **kwargs):
        endpoint, credential = cls._parse_connection_string(connection_string)
        return cls(endpoint, credential, **kwargs)
```

TODO: JOHAN Fix up the example client... 
```python
{% include_relative _includes/example_client.py %}
```

### Service methods

#### Naming

{% include requirement/SHOULD id="python-client-service-verbs" %} prefer the usage one of the preferred verbs for method names.

|Verb|Parameters|Returns|Comments|
|-|-|-|-|
|`create_\<noun>`|key, item, `[allow_overwrite=True]`|Created item|Create new item. Fails if item already exists.|
|`upsert_\<noun>`|key, item|item|Create new item, or update existing item. Verb is primarily used in database-like services |
|`set_\<noun>`|key, item|item|Create new item, or update existing item. Verb is primarily used for dictionary-like properties of a service |
|`update_\<noun>`|key, partial item|item|Fails if item doesn't exist. |
|`replace_\<noun>`|key, item|item|Completely replaces an existing item. Fails if the item doesn't exist. |
|`append_\<noun>`|item|item|Add item to a collection. Item will be added last. |
|`add_\<noun>`|index, item|item|Add item to a collection. Item will be added at the given index. |
|`get_\<noun>`|key|item|Raises an exception if item doesn't exist |
|`list_\<noun>`||`azure.core.Pageable[Item]`|Return an iterable of `Item`s. Returns an iterable with no items if no items exist (doesn't return `None` or throw)|
|`\<noun>\_exists`|key|`bool`|Return `True` if the item exists. Must raise an exception if the method failed to determine if the item exists (for example, the service returned an HTTP 503 response)|
|`delete_\<noun>`|key|`None`|Delete an existing item. Must succeed even if item didn't exist.|
|`remove_\<noun>`|key|removed item or `None`|Remove a reference to an item from a collection. This method doesn't delete the actual item, only the reference.|

{% include requirement/MUST id="python-client-standardize-verbs" %} standardize verb prefixes outside the list of preferred verbs for a given service across language SDKs. If a verb is called `download` in one language, we should avoid naming it `fetch` in another.

Methods that may take an indeterminate time to complete on the server are referred to as "long running operations". This generally maps back to long running service methods as defined in the Microsoft REST API guidelines TODO: Johan, add link.

{% include requirement/MUST id="python-lro-prefix" %} prefix methods with `begin_` for long running operations. TODO: Johan link to LRO.

{% include requirement/MUST id="python-paged-prefix" %} prefix methods with `list_` for methods that lists instances. Do use a `list_` prefix even if the service API currently do not support server driven paging. This allows server driven paging to be added to the service API without introducing breaking changes in the client library.

#### Parameters

{% include requirement/MUST id="python-client-optional-arguments-keyword-only" %} provide optional operation-specific arguments as keyword only. See TODO: insert link for general guidance on positional vs. optional parameters here.

{% include requirement/MUST id="python-client-service-per-call-args" %} provide keyword-only arguments that override per-request policy options. The name of the parameters MUST mirror the name of the arguments provided in the client constructor or factory methods.

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
def get_thing(name: "str") -> "str":
    url = f'https://<host>/things/{name}'
    return requests.get(url).json()

try:
    thing = get_thing('') # Ooops - we will end up calling '/things/' which usually lists 'things'. We wanted a specific 'thing'.
except ValueError:
    print('We called with some invalid parameters. We should fix that.')

# Yes:
def get_thing(name: "str") -> "str":
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

{% include requirement/MUST id="python-params-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service. Work with the service team if the developer experience is compromised because of service-side error messages.

{% include requirement/MUSTNOT id="python-client-parameter-validation" %} use `isinstance` to validate parameter value types other than for [built-in types](https://docs.python.org/3/library/stdtypes.html) (e.g. `str` etc). For other types, use structural type checks. TODO: JOHAN add reference to python coding guidelines for structural over instance checks.

##### Common service operation parameters

{% include requirement/MUST id="python-client-service-args" %} support the common arguments for service operations:

|Name|Description|Applies to|Notes|
|-|-|-|-|
|`timeout`|Timeout in seconds|All service methods|
|`headers`|Custom headers to include in the service request|All requests|Headers are added to all requests made (directly or indirectly) by the method.|
|`continuation_token`|Opaque token indicating the first page to retrieve. Retrieved from a previous `Paged` return value.|`list` operations.|
|`client_request_id`|Caller specified identification of the request.|Service operations for services that allow the client to send a client-generated correlation ID.|Examples of this include `x-ms-client-request-id` headers.|The client library **must** use this value if provided, or generate a unique value for each request when not specified.|
|`response_hook`|`callable` that is called with (response, headers) for each operation.|All service methods|

{% include requirement/MUST id="python-client-splat-args" %} accept a Mapping (`dict`-like) object in the same shape as a serialized model object for parameters.

```python
# Yes:
class Thing(object):

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
class Thing(object):

    def __init__(self, name, size, description):
        self.name = name
        self.size = size
        self.description = description

class Client(object):

    def update_thing(self, name=None, size=None, thing=None): ...

thing = Thing(name='hello', size=4711, description='This is a description...')

client.update_thing(thing=thing, size=4712) # Will send a request to the service to update the model's size to 4712
thing.description = 'Updated'
thing.size = -1
# Will send a request to the service to update the model's size to 4713 and description to 'Updated'
client.update_thing(name='hello', size=4713, thing=thing)  
```

#### Overloads

TODO: JOHAN Describe if @typing.overloads can be used and if so, when.

#### Return types

Requests to the service fall into two basic groups - methods that make a single logical request, or a deterministic sequence of requests. An example of a single logical request is a request that may be retried inside the operation. An example of a deterministic sequence of requests is a paged operation.

The logical entity is a protocol neutral representation of a response. For HTTP, the logical entity may combine data from headers, body, and the status line. For example, you may wish to expose an `ETag` header as a property on the logical entity.

{% include requirement/MUST id="python-response-logical-entity" %} optimize for returning the logical entity for a given request. The logical entity MUST represent the information needed in the 99%+ case.

{% include requirement/MUST id="python-response-exception-on-failure" %} raise an exception if the method call failed to accomplish the user specified task. This includes both situations where the service actively responded with a failure as well as when no response was received. See <TODO: JOHAN link to exceptions.

TODO: Please include a code sample for return types

#### Methods returning collections (paging)

Services may require multiple requests to retrieve the complete set of items in large collections. This is generally done by the service returning a partial result, and in the response providing a token or link that the client can use to retreive the next batch of responses in addition to the set of items.

{% include requirement/MUST id="python-response-paged-protocol" %} return a value that implements the [Paged protocol](#python-core-protocol-paged) for operations that return collections. The [Paged protocol](#python-core-protocol-paged) allows the user to iterate through all items in a returned collection, and also provides a method that gives access to individual pages.

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

TODO: Johan, show continuation token usage...

#### Methods invoking long running operations

Service operations that take a long time (currently defined in the Microsoft REST API Guidelines as not completing in 0.5s in P99) to complete are modeled by services as long running operations. 

Python client libraries abstracts the long running operation using the long running operation Poller protocol](#python-core-protocol-lro-poller).

{% include requirement/MUST id="python-lro-poller" %} return an object that implements the [Poller protocol](#python-core-protocol-lro-poller) for long running operations.

{% include requirement/MUST id="python-lro-poller" %} use a `begin_` prefix for all long running operations.

TODO: Johan, show continuation token usage...

#### Conditional requests

{% include requirement/MUST id="python-method-conditional-request" %} add a keyword-only `match_condition` parameter for service methods that support conditional requests.

{% include requirement/MUST id="python-method-conditional-request" %} add a keyword-only `etag` parameter for service methods that support conditional requests. For service methods that take a model instance that has an `etag` property, the explicit `etag` value passed in overrides the value in the model instance.

```python
class Thing(object):

    def __init__(self, name, etag):
        self.name = name
        self.etag = etag

thing = client.get_thing('theName')

# Uses the etag from the retrieved thing instance....
client.update_thing(thing, name='updatedName', match_condition=azure.core.MatchConditions.IfNotModified)

# Uses the explicitly provided etag.
client.update_thing(thing, name='updatedName2', match_condition=azure.core.MatchConditions.IfNotModified, etag='"igotthisetagfromsomewhereelse"')
```

#### Module level functions

TODO: Johan Describe when module level functions should be used.

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

Client libraries represent entities transferred to and from Azure services as model types. Certain types are used for round-trips to the service. They can be sent to the service (as an addition or update operation) and retrieved from the service (as a get operation). These should be named according to the type. For example, a `ConfigurationSetting` in App Configuration, or an `Event` on Event Grid.

Data within the model type can generally be split into two parts - data used to support one of the champion scenarios for the service, and less important data. Given a type `Foo`, the less important details can be gathered in a type called `FooDetails` and attached to `Foo` as the `details` attribute.

In order to facilitate round-trip of responses (common in get resource -> conditionally modify resource -> set resource workflows) types should use the input model type (e.g. `ConfigurationSetting`) whenever possible. The `ConfigurationSetting` type should include both server generated (read-only) attributes even though they will be ignored when used as input to the set resource method. 

- `<model>Item` for each item in an enumeration if the enumeration returns a partial schema for the model. For example, GetBlobs() return an enumeration of BlobItem, which contains the blob name and metadata, but not the content of the blob.
- `<operation>Result` for the result of an operation. The `<operation>` is tied to a specific service operation. If the same result can be used for multiple operations, use a suitable noun-verb phrase instead. For example, use `UploadBlobResult` for the result from `UploadBlob`, but `ContainerChangeResult` for results from the various methods that change a blob container. TODO: Johan, when should you just use a `dict`?

The following table enumerates the various models you might create:

|Type|Example|Usage|
|-|-|
|<model>|Secret|The full data for a resource
|<model>Details|SecretDetails|Less important details about a resource. Attached to <model>.details|
|<model>Item|SecretItem|A partial set of data returned for enumeration|
|<operation>Options|AddSecretOptions|Optional parameters to a single operation|
|<operation>Result|AddSecretResult|A partial or different set of data for a single operation|
|<model><verb>Result|SecretChangeResult|A partial or different set of data for multiple operations on a model|

{% include requirement/MUST id="python-models-repr" %} implement `__repr__` for model types. The representation **must** include the type name and any key properties (that is, properties that help identify the model instance).

{% include requirement/MUST id="python-models-repr-length" %} truncate the output of `__repr__` after 1024 characters.

{% include requirement/MUST id="python-models-dict-result" %} use a simple Mapping (e.g. `dict`) rather than creating a `<operation>Result` class if the `<operation>Result` class is not used as an input parameter for other APIs.

TODO: Please include a code sample for model types.

#### Enumerations

{% include requirement/MUST id="python-models-enum-string" %} use extensible enumerations.

```python
class MyEnum(str, Enum):
    One = 'one
    Two = 'two
```

### Exceptions (errors)

{% include requirement/SHOULD id="python-errors-azure-exceptions" %} prefer raising [existing exception types from the `azure-core`](https://azuresdkdocs.blob.core.windows.net/$web/python/azure-core/1.9.0/index.html#azure-core-library-exceptions) package over creating new exception types.

{% include requirement/MUSTNOT id="python-errors-use-standard-exceptions" %} create new exception types when a [built-in exception type](https://docs.python.org/3/library/exceptions.html) will suffice.

{% include requirement/SHOULDNOT id="python-errors-new-exceptions" %} create a new exception type unless the developer can remediate the error by doing something different.  Specialized exception types related to service operation failures should be based on existing exception types from the [`azure-core`](https://azuresdkdocs.blob.core.windows.net/$web/python/azure-core/1.9.0/index.html#azure-core-library-exceptions) package.

For higher-level methods that use multiple HTTP requests, either the last exception or an aggregate exception of all failures should be produced.

{% include requirement/MUST id="python-errors-rich-info" %} include any service-specific error information in the exception.  Service-specific error information must be available in service-specific properties or fields.

{% include requirement/MUST id="python-errors-documentation" %} document the errors that are produced by each method. Don't document commonly thrown errors that wouldn't normally be documented in Python (e.g. `ValueError`, `TypeError`, `RuntimeError` etc.)

{% include requirement/MUST id="python-errors-use-chaining" %} use exception chaining to include the original source of the error when catching and raising new exceptions.

```python
# Yes:
try:
    # do something 
    something()
except:
    # __context__ will be set correctly
    raise MyOwnErrorWithNoContext()

# No:
success = True
try:
    # do something
    something()
except:
    success = False
if not success:
    # __context__ is lost...
    raise MyOwnErrorWithNoContext()
```

### Async support

The `asyncio` library has been available since Python 3.4, and the `async`/`await` keywords were introduced in Python 3.5. Despite such availability, most Python developers aren't familiar with or comfortable using libraries that only provide asynchronous methods.

{% include requirement/MUST id="python-client-sync-async" %} provide both sync and async versions of your APIs

{% include requirement/MUST id="python-client-async-keywords" %} use the `async`/`await` keywords (requires Python 3.5+). Don't use the [yield from coroutine or asyncio.coroutine](https://docs.python.org/3.4/library/asyncio-task.html) syntax.

{% include requirement/MUST id="python-client-separate-sync-async" %} provide two separate client classes for synchronous and asynchronous operations.  Don't combine async and sync operations in the same class.

```python
# Yes
# In module azure.example
class ExampleClient(object):
    def some_service_operation(self, name, size) ...

# In module azure.example.aio
class ExampleClient:
    # Same method name as sync, different client
    async def some_service_operation(self, name, size) ... 

# No
# In module azure.example
class ExampleClient(object):
    def some_service_operation(self, name, size) ...

class AsyncExampleClient: # No async/async pre/postfix.
    async def some_service_operation(self, name, size) ...

# No
# In module azure.example
class ExampleClient(object): # Don't mix'n match with different method names
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

{% include requirement/SHOULD id="python-client-separate-async-pkg" %} ship a separate package for async support if the async version requires additional dependencies.

{% include requirement/MUST id="python-client-same-pkg-name-sync-async" %} use the same name for the asynchronous version of the package as the synchronous version of the package with `-aio` appended.

{% include requirement/MUST id="python-client-async-http-stack" %} use [`aiohttp`](https://aiohttp.readthedocs.io/en/stable/) as the default HTTP stack for async operations. Use `azure.core.pipeline.transport.AioHttpTransport` as the default `transport` type for the async client.

### Authentication

{% include requirement/MUST id="python-auth-credential-azure-core" %} use the credentials classes in `azure-core` whenever possible.

{% include requirement/MAY  id="python-auth-service-credentials" %} add additional credential types if required by the service. Contact @adparch for guidance if you believe you have need to do so.

TODO: update contact information for the architecture board to reflect the new process.

{% include requirement/MUST id="python-auth-service-support" %} support all authentication methods that the service supports.

TODO: please include a code sample for authentication

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

{% include requirement/MUST id="python-namespaces-register" %} register the chosen namespace with the [Architecture Board].  Open an issue to request the namespace.  See [the registered namespace list](registered_namespaces.html) for a list of the currently registered namespaces.

{% include requirement/MUST id="python-namespaces-async" %} use an `.aio` suffix added to the namespace of the sync client for async clients.

Example:

```python
# Yes:
from azure.exampleservice.aio import ExampleServiceClient

# No: Wrong namespace, wrong client name...
from azure.exampleservice import AsyncExampleServiceClient
```

## Azure SDK distribution packages

### Packaging

{% include requirement/MUST id="python-packaging-name" %} name your package after the namespace of your main client class.

{% include requirement/MUST id="python-packaging-name-allowed-chars" %} use all lowercase in your package name with a dash (-) as a separator.

{% include requirement/MUSTNOT id="python-packaging-name-disallowed-chars" %} use underscore (_) or period (.) in your package name. If your namespace includes underscores, replace them with dash (-) in the distribution package name.

{% include requirement/MUST id="python-packaging-follow-repo-rules" %} follow the specific package guidance from the [azure-sdk-packaging wiki](https://github.com/Azure/azure-sdk-for-python/wiki/Azure-packaging)

{% include requirement/MUST id="python-packaging-follow-python-rules" %} follow the [namespace package recommendations for Python 3.x](https://docs.python.org/3/reference/import.html#namespace-packages) for packages that only need to target 3.x.

{% include requirement/MUST id="python-packaging-nspkg" %} depend on `azure-nspkg` for Python 2.x.

{% include requirement/MUST id="python-packaging-group-nspkg" %} depend on `azure-<group>-nspkg` for Python 2.x if you are using namespace grouping.

{% include requirement/MUST id="python-packaging-init" %} include `__init__.py` for the namespace(s) in sdists

### Versioning

{% include requirement/MUST id="python-versioning-semver" %} use [semantic versioning](https://semver.org) for your package.

{% include requirement/MUST id="python-versioning-beta" %} use the `bN` pre-release segment for [beta releases](https://www.python.org/dev/peps/pep-0440/#pre-releases).

Don't use pre-release segments other than the ones defined in [PEP440](https://www.python.org/dev/peps/pep-0440) (`aN`, `bN`, `rcN`). Build tools, publication tools, and index servers may not sort the versions correctly.

{% include requirement/MUST id="python-versioning-changes" %} change the version number if *anything* changes in the library.

{% include requirement/MUST id="python-versioning-patch" %} increment the patch version if only bug fixes are added to the package.

{% include requirement/MUST id="python-verioning-minor" %} increment the minor version if any new functionality is added to the package.

{% include requirement/MUST id="python-versioning-apiversion" %} increment the minor version if the default REST API version is changed, even if there's no public API change to the library.

{% include requirement/MUSTNOT id="python-versioning-api-major" %} increment the major version for a new REST API version unless it requires breaking API changes in the python library itself.

{% include requirement/MUST id="python-versioning-major" %} increment the major version if there are breaking changes in the package. Breaking changes require prior approval from the [Architecture Board].

{% include requirement/MUST id="python-versioning-major" %} select a version number greater than the highest version number of any other released Track 1 package for the service in any other scope or language.

The bar to make a breaking change is extremely high for GA client libraries.  We may create a new package with a different name to avoid diamond dependency issues.

### Binary extensions

{% include requirement/MUST id="python-native-approval" %} be approved by the [Architecture Board].

{% include requirement/MUST id="python-native-plat-support" %} support Windows, Linux (manylinux - see [PEP513](https://www.python.org/dev/peps/pep-0513/), [PEP571](https://www.python.org/dev/peps/pep-0571/)), and MacOS.  Support the earliest possible manylinux to maximize your reach.

{% include requirement/MUST id="python-native-arch-support" %} support both x86 and x64 architectures.

{% include requirement/MUST id="python-native-charset-support" %} support unicode and ASCII versions of CPython 2.7.


## Repository Guidelines

TODO: Please include a section on Python Samples.

{% include refs.md %}
{% include_relative refs.md %}
