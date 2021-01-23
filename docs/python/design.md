---
title: "Python Guidelines: API Design"
keywords: guidelines python
permalink: python_design.html
folder: python
sidebar: general_sidebar
---

## Introduction

### Support for non-HTTP protocols

TODO: In Introduction section, call out that API designers for non-HTTP based services to reach out to the arch board for guidance.

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.

{% include requirement/MUST id="python-feature-support" %} support 100% of the features provided by the Azure service the client library represents. Gaps in functionality cause confusion and frustration among developers.

## Namespaces

{% include requirement/MUST id="python-namespaces-prefix" %} implement your library as a subpackage in the `azure` namespace.

{% include requirement/MUST id="python-namespaces-naming" %} pick a package name that allows the consumer to tie the namespace to the service being used. As a default, use the compressed service name at the end of the namespace. The namespace does NOT change when the branding of the product changes. Avoid the use of marketing names that may change.

A compressed service name is the service name without spaces. It may further be shortened if the shortened version is well known in the community. For example, “Azure Media Analytics” would have a compressed service name of `mediaanalytics`, and “Azure Service Bus” would become `servicebus`.  Separate words using an underscore if necessary. If used, `mediaanalytics` would become `media_analytics`

{% include requirement/MAY id="python-namespaces-grouping" %} include a group name segment in your namespace (for example, `azure.<group>.<servicename>`) if your service or family of services have common behavior (for example, shared authentication types). 

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

## Clients

TODO: Add an example of the basic API shape similar to what's shown in the code sample <!--[here](https://azure.github.io/azure-sdk/java_design.html#java-sync-client-shape)--> but with the equivalent in Python.  Please include code illustrations of the following areas:

- Service Client
- Client Construction
- Service Methods
- Model Types
- Common Namespace
- Common Auth

See Azure SDK Core Shape slides shown at **github.com/Azure/azure-sdk-pr/issues/440** for details.


Your API surface will consist of one or more _service clients_ that the consumer will instantiate to connect to your service, plus a set of supporting types.

{% include requirement/MUST id="python-client-naming" %} name service client types with a **Client** suffix.

```python
# Yes
class CosmosClient(object) ... 

# No
class CosmosProxy(object) ... 

# No
class CosmosUrl(object) ... 

```

{% include requirement/MUST id="python-client-namespace" %} expose the service clients the user is more likely to interact with from the root namespace of your package.

### Constructors and factory methods

{% include requirement/MUST id="python-client-constructor-form" %} provide a constructor that takes binding parameters (for example, the name of, or a URL pointing to the service instance), a `credentials` parameter, a `transport` parameter, and `**kwargs` for passing settings through to individual HTTP pipeline policies.

Only the minimal information needed to connect and interact with the service should be required. All additional information should be optional.

The constructor **must not** take a connection string. 

{% include requirement/MUST id="python-client-connection-string" %} use a separate factory method `ExampleServiceClient.from_connection_string` to create a client from a connection string (if the client supports connection strings).

The method **should** parse the connection string and pass the values to the constructor.  Provide a `from_connection_string` factory method only if the Azure portal exposes a connection string for your service.

TODO: Please include a code sample here.

TODO: Please include a code sample for setting the service version.


TODO: If client configuration options are relevant to Python (e.g. does an API designer need to do something special to enable configuration of retries?  Or other client-specific options like we designed for Text Analytics?), please add a subsection on designing these here.

TODO: Are clients immutable in Python as they are in other languages?  If so, please call that out in this or above Service Client section.

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

|Sync/async|Namespace|Package name|Client name|
|-|-|-|-|
|Sync|`azure.sampleservice`|`azure-sampleservice`|`azure.sampleservice.SampleServiceClient`|
|Async|`azure.sampleservice.aio`|`azure-sampleservice-aio`|`azure.sampleservice.aio.SampleServiceClient`|

{% include requirement/MUST id="python-client-namespace-sync" %} use the same namespace for the synchronous client as the synchronous version of the package with `.aio` appended.

{% include requirement/SHOULD id="python-client-separate-async-pkg" %} ship a separate package for async support if the async version requires additional dependencies.

{% include requirement/MUST id="python-client-same-pkg-name-sync-async" %} use the same name for the asynchronous version of the package as the synchronous version of the package with `-aio` appended.

{% include requirement/MUST id="python-client-async-http-stack" %} use [`aiohttp`](https://aiohttp.readthedocs.io/en/stable/) as the default HTTP stack for async operations. Use `azure.core.pipeline.transport.AioHttpTransport` as the default `transport` type for the async client.

### Hierarchical services

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

### Service operations

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
|`list_\<noun>`||`azure.core.Pageable[Item]`|Return an iterable of items. Returns iterable with no items if no items exist (doesn't return `None` or throw)|
|`\<noun>\_exists`|key|`bool`|Return `True` if the item exists. Must raise an exception if the method failed to determine if the item exists (for example, the service returned an HTTP 503 response)|
|`delete_\<noun>`|key|`None`|Delete an existing item. Must succeed even if item didn't exist.|
|`remove_\<noun>`|key|removed item or `None`|Remove a reference to an item from a collection. This method doesn't delete the actual item, only the reference.|

{% include requirement/MUST id="python-client-standardize-verbs" %} standardize verb prefixes outside the list of preferred verbs for a given service across language SDKs. If a verb is called `download` in one language, we should avoid naming it `fetch` in another.

{% include requirement/MUST id="python-lro-prefix" %} prefix methods with `begin_` for long running operations. Long running operations *must* return a [Poller](#python-core-protocol-lro-poller) object. 

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
class Model(object):

    def __init__(self, name, size):
        self.name = name
        self.size = size

def do_something(model: "Model"):
    ...

do_something(Model(name='a', size=17)) # Works
do_something({'name': 'a', 'size', '17'}) # Does the same thing...
```

{% include requirement/MUST id="python-client-flatten-args" %} use "flattened" named arguments for `update_` methods. **May** additionally take the whole model instance as a named parameter. If the caller passes both a model instance and individual key=value parameters, the explicit key=value parameters override whatever was specified in the model instance.

```python
class Model(object):

    def __init__(self, name, size, description):
        self.name = name
        self.size = size
        self.description = description

class Client(object):

    def update_model(self, name=None, size=None, model=None): ...

model = Model(name='hello', size=4711, description='This is a description...')

client.update_model(model=model, size=4712) # Will send a request to the service to update the model's size to 4712
model.description = 'Updated'
model.size = -1
# Will send a request to the service to update the model's size to 4713 and description to 'Updated'
client.update_model(name='hello', size=4713, model=model)  
```

TODO: If there are design considerations to call out that parallel the xxOptions parameters, please add those here.  e.g. per the Python API Design Training Article Anna put together at **github.com/Azure/azure-sdk-pr/blob/master/training/azure-sdk-apis/getting-started/design-the-api/design-the-api-python.md#the-get-request**, what should be positional parameters vs. kwargs?

#### Response formats

Requests to the service fall into two basic groups - methods that make a single logical request, or a deterministic sequence of requests. An example of a single logical request is a request that may be retried inside the operation. An example of a deterministic sequence of requests is a paged operation.

The logical entity is a protocol neutral representation of a response. For HTTP, the logical entity may combine data from headers, body, and the status line. For example, you may wish to expose an `ETag` header as a property on the logical entity.

{% include requirement/MUST id="python-response-logical-entity" %} optimize for returning the logical entity for a given request. The logical entity MUST represent the information needed in the 99%+ case.

{% include requirement/MUST id="python-response-paged-protocol" %} return a value that implements the [Paged protocol](#python-core-protocol-paged) for operations that return collections. The [Paged protocol](#python-core-protocol-paged) allows the user to iterate through all items in a returned collection, and also provides a method that gives access to individual pages.

{% include requirement/MUST id="python-lro-poller" %} return a value that implements the [Poller protocol](#python-core-protocol-lro-poller) for long running operations.

TODO: Please include a code sample for return types

TODO: Please add a section on Conditional Requests - much of this is documented [here](https://azure.github.io/azure-sdk/general_design.html#conditional-requests), but could be made Python-specific as needed.

## Models

{% include requirement/MUST id="python-models-repr" %} implement `__repr__` for model types. The representation **must** include the type name and any key properties (that is, properties that help identify the model instance).

{% include requirement/MUST id="python-models-repr-length" %} truncate the output of `__repr__` after 1024 characters.

TODO: Please add discussion similar to the [Model Type discussion from the General Guidelines](https://azure.github.io/azure-sdk/general_design.html#model-types), including the naming table if relevant to Python, or an alternate one specific to Python.  Per the Python API Design Training Article linked above, when should a model type be replaced with a dictionary in the Azure SDK?

TODO: Please include a code sample for model types.

TODO: If you do anything specific to model extensible enums in Python that an API designer should know, please call this out.

## Authentication

{% include requirement/MUST id="python-auth-credential-azure-core" %} use the credentials classes in `azure-core` whenever possible.

{% include requirement/MAY  id="python-auth-service-credentials" %} add additional credential types if required by the service. Contact @adparch for guidance if you believe you have need to do so.

TODO: update contact information for the architecture board to reflect the new process.

{% include requirement/MUST id="python-auth-service-support" %} support all authentication methods that the service supports.

TODO: please include a code sample for authentication

## Repository Guidelines

TODO: Please include a section on Python Samples.

{% include refs.md %}
{% include_relative refs.md %}
