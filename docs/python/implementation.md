---
title: "Python Guidelines: Implementation"
keywords: guidelines python
permalink: python_implementation.html
folder: python
sidebar: general_sidebar
---

## API implementation

### Service client

#### Http pipeline

Since the client library generally wraps one or more HTTP requests, it's important to support standard network capabilities. Although not widely understood, asynchronous programming techniques are essential in developing resilient web services. Many developers prefer synchronous method calls for their easy semantics when learning how to use a technology. The HTTP pipeline is a component in the `azure-core` library that assists in providing connectivity to HTTP-based Azure services.

{% include requirement/MUST id="python-network-http-pipeline" %} use the [HTTP pipeline] to send requests to service REST endpoints.

{% include requirement/SHOULD id="python-network-use-policies" %} include the following policies in the HTTP pipeline:

- Telemetry (`azure.core.pipeline.policies.UserAgentPolicy`)
- Unique Request ID
- Retry (`azure.core.pipeline.policies.RetryPolicy` and `azure.core.pipeline.policies.AsyncRetryPolicy`)
- Credentials
- Response downloader
- Distributed tracing
- Logging (`azure.core.pipeline.policies.NetworkTraceLoggingPolicy`)

##### Custom policies

#### Parameters

##### Validation


## ---------
## ---------
## ---------

## Configuration

{% include requirement/MUST id="python-envvars-global" %} honor the following environment variables for global configuration settings:

{% include tables/environment_variables.md %}


## Dependencies

{% include requirement/MUST id="python-dependencies-approved-list" %} only pick external dependencies from the following list of well known packages for shared functionality:

{% include_relative approved_dependencies.md %}

{% include requirement/MUSTNOT id="python-dependencies-external" %} use external dependencies outside the list of well known dependencies. To get a new dependency added, contact the [Architecture Board].

{% include requirement/MUSTNOT id="python-dependencies-vendor" %} vendor dependencies unless approved by the [Architecture Board].

When you vendor a dependency in Python, you include the source from another package as if it was part of your package.

{% include requirement/MUSTNOT id="python-dependencies-pin-version" %} pin a specific version of a dependency unless that is the only way to work around a bug in said dependencies versioning scheme.

Applications are expected to pin exact dependencies. Libraries aren't. A library should use a [compatible release](https://www.python.org/dev/peps/pep-0440/#compatible-release) identifier for the dependency.

## Service-specific common library code

There are occasions when common code needs to be shared between several client libraries.  For example, a set of cooperating client libraries may wish to share a set of exceptions or models.

{% include requirement/MUST id="python-commonlib-approval" %} gain [Architecture Board] approval prior to implementing a common library.

{% include requirement/MUST id="python-commonlib-minimize-code" %} minimize the code within a common library.  Code within the common library is available to the consumer of the client library and shared by multiple client libraries within the same namespace.

{% include requirement/MUST id="python-commonlib-namespace" %} store the common library in the same namespace as the associated client libraries.

A common library will only be approved if:

* The consumer of the non-shared library will consume the objects within the common library directly, AND
* The information will be shared between multiple client libraries.

Let's take two examples:

1. Implementing two Cognitive Services client libraries, we find a model is required that is produced by one Cognitive Services client library and consumed by another Coginitive Services client library, or the same model is produced by two client libraries.  The consumer is required to do the passing of the model in their code, or may need to compare the model produced by one client library vs. that produced by another client library.  This is a good candidate for choosing a common library.

2. Two Cognitive Services client libraries throw an `ObjectNotFound` exception to indicate that an object was not detected in an image.  The user might trap the exception, but otherwise will not operate on the exception.  There is no linkage between the `ObjectNotFound` exception in each client library.  This is not a good candidate for creation of a common library (although you may wish to place this exception in a common library if one exists for the namespace already).  Instead, produce two different exceptions - one in each client library.

## Error handling

{% include requirement/MUST id="python-errors-exceptions" %} raise an exception if a method fails to perform its intended functionality. Don't return `None` or a `boolean` to indicate errors.

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

## Logging

{% include requirement/MUST id="python-logging-usage" %} use Pythons standard [logging module](https://docs.python.org/3/library/logging.html).

{% include requirement/MUST id="python-logging-nameed-logger" %} provide a named logger for your library.

The logger for your package **must** use the name of the module. The library may provide additional child loggers. If child loggers are provided, document them.

For example:
- Package name: `azure-someservice`
- Module name: `azure.someservice`
- Logger name: `azure.someservice`
- Child logger: `azure.someservice.achild`

These naming rules allow the consumer to enable logging for all Azure libraries, a specific client library, or a subset of a client library.

{% include requirement/MUST id="python-logging-error" %} use the `ERROR` logging level for failures where it's unlikely the application will recover (for example, out of memory).

{% include requirement/MUST id="python-logging-warn" %} use the `WARNING` logging level when a function fails to perform its intended task. The function should also raise an exception.

Don't include occurrences of self-healing events (for example, when a request will be automatically retried).

{% include requirement/MUST id="python-logging-info" %} use the `INFO` logging level when a function operates normally.

{% include requirement/MUST id="python-logging-debug" %} use the `DEBUG` logging level for detailed trouble shooting scenarios.

The `DEBUG` logging level is intended for developers or system administrators to diagnose specific failures.

{% include requirement/MUSTNOT id="python-logging-sensitive-info" %} send sensitive information in log levels other than `DEBUG`.  For example, redact or remove account keys when logging headers.

{% include requirement/MUST id="python-logging-request" %} log the request line, response line, and headers for an outgoing request as an `INFO` message.

{% include requirement/MUST id="python-logging-cancellation" %} log an `INFO` message, if a service call is canceled.

{% include requirement/MUST id="python-logging-exceptions" %} log exceptions thrown as a `WARNING` level message. If the log level set to `DEBUG`, append stack trace information to the message.

You can determine the logging level for a given logger by calling [`logging.Logger.isEnabledFor`](https://docs.python.org/3/library/logging.html#logging.Logger.isEnabledFor).

## Distributed tracing

> **DRAFT** section

{% include requirement/MUST id="python-tracing-span-per-method" %} create a new trace span for each library method invocation. The easiest way to do so is by adding the distributed tracing decorator from `azure.core.tracing`.

{% include requirement/MUST id="python-tracing-span-name" %} use `<package name>/<method name>` as the name of the span.

{% include requirement/MUST id="python-tracing-span-per-call" %} create a new span for each outgoing network call. If using the HTTP pipeline, the new span is created for you.

{% include requirement/MUST id="python-tracing-propagate" %} propagate tracing context on each outgoing service request.

## Azure Core

The `azure-core` package provides common functionality for client libraries. Documentation and usage examples can be found in the [azure/azure-sdk-for-python] repository.

### HTTP pipeline

The HTTP pipeline is an HTTP transport that is wrapped by multiple policies. Each policy is a control point that can modify either the request or response. A default set of policies is provided to standardize how client libraries interact with Azure services.

For more information on the Python implementation of the pipeline, see the [documentation](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/core/azure-core).

#### Custom Policies

Some services may require custom policies to be implemented. For example, custom policies may implement fall back to secondary endpoints during retry, request signing, or other specialized authentication techniques.

{% include requirement/SHOULD id="python-pipeline-core-policies" %} use the policy implementations in `azure-core` whenever possible.

{% include requirement/MUST id="python-pipeline-document-policies" %} document any custom policies in your package. The documentation should make it clear how a user of your library is supposed to use the policy.

{% include requirement/MUST id="python-pipeline-policy-namespace" %} add the policies to the `azure.<package name>.pipeline.policies` namespace.

### Protocols

#### LROPoller

```python
T = TypeVar("T")
class LROPoller(Protocol):

    def result(self, timeout=None) -> T:
        """ Retrieve the final result of the long running operation.

        :param timeout: How long to wait for operation to complete (in seconds). If not specified, there is no timeout.
        :raises TimeoutException: If the operation has not completed before it timed out.
        """
        ...

    def wait(self, timeout=None) -> None:
        """ Wait for the operation to complete.

        :param timeout: How long to wait for operation to complete (in seconds). If not specified, there is no timeout.
        """

    def done(self) -> boolean:
        """ Check if long running operation has completed.
        """

    def add_done_callback(self, func) -> None:
        """ Register callback to be invoked when operation completes.

        :param func: Callable that will be called with the eventual result ('T') of the operation.
        """
        ...
```

`azure.core.LROPoller` implements the `LROPoller` protocol.

#### Paged

```python
T = TypeVar("T")
class ByPagePaged(Protocol, Iterable[Iterable[T]]):
    continuation_token: "str"

class Paged(Protocol, Iterable[T]):
    continuation_token: "str"

    def by_page(self) -> ByPagePaged[T] ...
```

`azure.core.Paged` implements the `Paged` protocol.

#### DiagnosticsResponseHook

```python
class ResponseHook(Protocol):

    __call__(self, headers, deserialized_response): -> None ...

```


### REST API method versioning

{% include requirement/MUST id="python-versioning-latest-service-api" %} use the latest service protocol version when making requests.

{% include requirement/MUST id="python-versioning-select-service-api" %} allow a client application to specify an earlier version of the service protocol.


## Testing

{% include requirement/MUST id="python-testing-pytest" %} use [pytest](https://docs.pytest.org/en/latest/) as the test framework.

{% include requirement/SHOULD id="python-testing-async" %} use [pytest-asyncio](https://github.com/pytest-dev/pytest-asyncio) for testing of async code.

{% include requirement/MUST id="python-testing-live" %} make your scenario tests runnable against live services. Strongly consider using the [Python Azure-DevTools](https://github.com/Azure/azure-python-devtools) package for scenario tests.

{% include requirement/MUST id="python-testing-record" %} provide recordings to allow running tests offline/without an Azure subscription

{% include requirement/MUST id="python-testing-parallel" %} support simultaneous test runs in the same subscription.

{% include requirement/MUST id="python-testing-independent" %} make each test case independent of other tests.

## Recommended Tools

{% include requirement/MUST id="python-tooling-pylint" %} use [pylint](https://www.pylint.org/) for your code. Use the pylintrc file in the [root of the repository](https://github.com/Azure/azure-sdk-for-python/blob/master/pylintrc).

{% include requirement/MUST id="python-tooling-flake8" %} use [flake8-docstrings](https://gitlab.com/pycqa/flake8-docstrings) to verify doc comments.

{% include requirement/MUST id="python-tooling-black" %} use [Black](https://black.readthedocs.io/en/stable/) for formatting your code.

{% include requirement/SHOULD id="python-tooling-mypy" %} use [MyPy](https://mypy.readthedocs.io/en/latest/) to statically check the public surface area of your library.

You don't need to check non-shipping code such as tests.

## Code style

{% include requirement/MUST id="python-codestyle-pep8" %} follow the general guidelines in [PEP8](https://www.python.org/dev/peps/pep-0008/) unless explicitly overridden in this document.

{% include requirement/MUSTNOT id="python-codestyle-idiomatic" %} "borrow" coding paradigms from other languages.

For example, no matter how common Reactive programming is in the Java community, it's still unfamiliar for most Python developers.

{% include requirement/MUST id="python-codestyle-consistency" %} favor consistency with other Python components over other libraries for the same service.

It's more likely that a developer will use many different libraries using the same language than a developer will use the same service from many different languages.

### Naming conventions

{% include requirement/MUST id="python-codestyle-vars-naming" %} use snake_case for variable, function, and method names:

```python
# Yes:
service_client = ServiceClient()

service_client.list_things()

def do_something():
    ...

# No:
serviceClient = ServiceClient()

service_client.listThings()

def DoSomething():
    ...
```

{% include requirement/MUST id="python-codestyle-type-naming" %} use Pascal case for types:

```python
# Yes:
class ThisIsCorrect(object):
    pass

# No:
class this_is_not_correct(object):
    pass

# No:
class camelCasedTypeName(object):
    pass
```

{% include requirement/MUST id="python-codestyle-const-naming" %} use ALL CAPS for constants:

```python
# Yes:
MAX_SIZE = 4711

# No:
max_size = 4711

# No:
MaxSize = 4711
```

{% include requirement/MUST id="python-codestyle-module-naming" %} use snake_case for module names.

### Method signatures

{% include requirement/MUSTNOT id="python-codestyle-static-methods" %} use static methods ([`staticmethod`](https://docs.python.org/3/library/functions.html#staticmethod)). Prefer module level functions instead. 

Static methods are rare and usually forced by other libraries.

{% include requirement/MUSTNOT id="python-codestyle-properties" %} use simple getter and setter functions. Use properties instead.

```python
# Yes
class GoodThing(object):

    @property
    def something(self):
        """ Example of a good read-only property."""
        return self._something

# No
class BadThing(object):

    def get_something(self):
        """ Example of a bad 'getter' style method."""
        return self._something
```

{% include requirement/SHOULDNOT id="python-codestyle-long-args" %} have methods that require more than five positional parameters. Optional/flag parameters can be accepted using keyword-only arguments, or `**kwargs`.

{% include requirement/MUST id="python-codestyle-optional-args" %} use keyword-only arguments for optional or less-often-used arguments for modules that only need to support Python 3.

```python
# Yes
def foo(a, b, *, c, d=None):
    # Note that I can even have required keyword-only arguments...
    ...
```

{% include requirement/MUST id="python-codestyle-kwargs" %} use keyword-only arguments for arguments that have no obvious ordering.

```python
# Yes - `source` and `dest` have logical order, `recurse` and `overwrite` do not.
def copy(source, dest, *, recurse=False, overwrite=False) ...


# No
def copy(source, dest, recurse=False, overwrite=False) ...
```

{% include requirement/MUST id="python-codestyle-positional-params" %} specify the parameter name when calling methods with more than two required positional parameters.

```python
def foo(a, b, c):
    pass


def bar(d, e):
    pass


# Yes:
foo(a=1, b=2, c=3)
bar(1, 2)
bar(e=3, d=4)

# No:
foo(1, 2, 3)
```

{% include requirement/MUST id="python-codestyle-optional-param-calling" %} specify the parameter name for optional parameters when calling functions.

```python
def foo(a, b=1, c=None):
    pass


# Yes:
foo(1, b=2, c=3)

# No:
foo(1, 2, 3)
```

### Public vs "private"

{% include requirement/MUST id="python-codestyle-private-api" %} use a single leading underscore to indicate that a name isn't part of the public API.  Non-public APIs aren't guaranteed to be stable.

{% include requirement/MUSTNOT id="python-codestyle-double-underscore" %} use leading double underscore prefixed method names unless name clashes in the inheritance hierarchy are likely.  Name clashes are rare.

{% include requirement/MUST id="python-codestyle-public-api" %} add public methods and types to the module's `__all__` attribute.

{% include requirement/MUST id="python-codestyle-interal-module" %} use a leading underscore for internal modules. You **may** omit a leading underscore if the module is a submodule of an internal module.

```python
# Yes:
azure.exampleservice._some_internal_module

# Yes - some_internal_module is still considered internal since it is a submodule of an internal module:
azure.exampleservice._internal.some_internal_module

# No - some_internal_module is considered public:
azure.exampleservice.some_internal_module
```

### Types (or not)

{% include requirement/MUST id="python-codestyle-structural-subtyping" %} prefer structural subtyping and protocols over explicit type checks.

{% include requirement/MUST id="python-codestyle-abstract-collections" %} derive from the abstract collections base classes `collections.abc` (or `collections` for Python 2.7) to provide custom mapping types.

{% include requirement/MUST id="python-codestyle-pep484" %} provide type hints [PEP484](https://www.python.org/dev/peps/pep-0484/) for publicly documented classes and functions.

- See the [suggested syntax for Python 2.7 and 2.7-3.x straddling code](https://www.python.org/dev/peps/pep-0484/#suggested-syntax-for-python-2-7-and-straddling-code) for guidance for Python 2.7 compatible code.

### Threading

{% include requirement/MUST id="python-codestyle-thread-affinity" %} maintain thread affinity for user-provided callbacks unless explicitly documented to not do so.

{% include requirement/MUST id="python-codestyle-document-thread-safety" %} explicitly include the fact that a method (function/class) is thread safe in its documentation.

Examples: [`asyncio.loop.call_soon_threadsafe`](https://docs.python.org/3/library/asyncio-eventloop.html#asyncio.loop.call_soon_threadsafe), [`queue`](https://docs.python.org/3/library/queue.html)

{% include requirement/SHOULD id="python-codestyle-use-executor" %} allow callers to pass in an [`Executor`](https://docs.python.org/3/library/concurrent.futures.html#concurrent.futures.Executor) instance rather than defining your own thread or process management for parallelism.

You may do your own thread management if the thread isn't exposed to the caller in any way. For example, the `LROPoller` implementation uses a background poller thread.

{% include refs.md %}
{% include_relative refs.md %}
