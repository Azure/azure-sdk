---
title: "Python Guidelines: Introduction"
keywords: guidelines python
permalink: python_introduction.html
folder: python
sidebar: general_sidebar
---

## Design principles

The Azure SDK should be designed to enhance the productivity of developers connecting to Azure services. Other qualities (such as completeness, extensibility, and performance) are important but secondary. Productivity is achieved by adhering to the principles described below:

### Idiomatic

* The SDK should follow the general design guidelines and conventions for the target language. It should feel natural to a developer in the target language.
* We embrace the ecosystem with its strengths and its flaws.
* We work with the ecosystem to improve it for all developers.

### Consistent

* Client libraries should be consistent within the language, consistent with the service and consistent between all target languages. In cases of conflict, consistency within the language is the highest priority and consistency between all target languages is the lowest priority.
* Service-agnostic concepts such as logging, HTTP communication, and error handling should be consistent. The developer should not have to relearn service-agnostic concepts as they move between client libraries.
* Consistency of terminology between the client library and the service is a good thing that aids in diagnosability.
* All differences between the service and client library must have a good (articulated) reason for existing, rooted in idiomatic usage rather than whim.
* The Azure SDK for each target language feels like a single product developed by a single team.
* There should be feature parity across target languages. This is more important than feature parity with the service.

### Approachable

* We are experts in the supported technologies so our customers, the developers, don't have to be.
* Developers should find great documentation (hero tutorial, how to articles, samples, and API documentation) that makes it easy to be successful with the Azure service.
* Getting off the ground should be easy through the use of predictable defaults that implement best practices. Think about progressive concept disclosure.
* The SDK should be easily acquired through the most normal mechanisms in the target language and ecosystem.
* Developers can be overwhelmed when learning new service concepts. The core use cases should be discoverable.

### Diagnosable

* The developer should be able to understand what is going on.
* It should be discoverable when and under what circumstances a network call is made.
* Defaults are discoverable and their intent is clear.
* Logging, tracing, and exception handling are fundamental and should be thoughtful.
* Error messages should be concise, correlated with the service, actionable, and human readable. Ideally, the error message should lead the consumer to a useful action that they can take.
* Integrating with the preferred debugger for the target language should be easy.

### Dependable

* Breaking changes are more harmful to a user's experience than most new features and improvements are beneficial.
* Incompatibilities should never be introduced deliberately without thorough review and very strong justification.
* Do not rely on dependencies that can force our hand on compatibility.

## Python Design Principles

Use the guiding principles in the Zen of Python [Zen of Python] when making design trade-offs:

```
  Beautiful is better than ugly.
  Explicit is better than implicit.
  Simple is better than complex.
  Complex is better than complicated.
  Flat is better than nested.
  Sparse is better than dense.
  Readability counts.
  Special cases aren't special enough to break the rules.
  Although practicality beats purity.
  Errors should never pass silently.
  Unless explicitly silenced.
  In the face of ambiguity, refuse the temptation to guess.
  There should be one-- and preferably only one --obvious way to do it.
  Although that way may not be obvious at first unless you're Dutch.
  Now is better than never.
  Although never is often better than *right* now.
  If the implementation is hard to explain, it's a bad idea.
  If the implementation is easy to explain, it may be a good idea.
  Namespaces are one honking great idea -- let's do more of those!
```

## General Guidelines

{% include requirement/MUST id="python-general-follow-general-guidelines" %} follow the [General Azure SDK Guidelines].

{% include requirement/MUST id="python-general-monorepo" %} locate all source code in the [azure/azure-sdk-for-python] GitHub repository.

{% include requirement/MUST id="python-general-engsys" %} follow Azure SDK engineering systems guidelines for working in the [azure/azure-sdk-for-python] GitHub repository.

## Supported python versions

{% include requirement/MUST id="python-general-version-support" %} support Python 2.7 and 3.6+.

{% include requirement/SHOULD id="python-general-universal-pkg" %} provide a [universal package] that works on all supported versions of Python, unless there's a compelling reason to have separate Python2 and Python3 packages.  

For example, if you depend on different external packages for Python2 and Python3, and neither external dependency is available for both Python versions.

{% include requirement/MUST id="python-general-supply-sdist" %} provide both source distributions (`sdist`) and wheels.

{% include requirement/MUST id="python-general-pypi" %} publish both source distributions (`sdist`) and wheels to PyPI.

{% include requirement/MUST id="python-general-wheel-behavior" %} test correct behavior for both CPython and PyPy for [pure](https://packaging.python.org/guides/distributing-packages-using-setuptools/#id75) and [universal](https://packaging.python.org/guides/distributing-packages-using-setuptools/#universal-wheels) Python wheels. 

For more information on packaging naming, see the [Packaging] section.

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
