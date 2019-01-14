## Supported Python versions

* DO provide packages supporting Python 2.7 and Python 3.4+

## Supported Python interpreters

* DO consider supporting PyPy, Jython

## Supported Operating systems

> ToDo : fill in

## Coding - general

* DO adhere to the [Zen of Python](https://www.python.org/dev/peps/pep-0020/)

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

* DO follow the general guidelines in PEP8 unless explicitly overridden in this document.

* DON'T "borrow" coding paradigms from other languages.
  
  *For example, regardless of how common Reactive programming is in the Java community, it is still unfamiliar for most Python devalepers.*

* DO favor consistence with other Python components over other libraries for the same service

  *It is significantly more likely that a developer will use many different libraries using the same languages than that a developer will use the same service from many different languages*
  
* DO use a single underscore to indicate that a class/module/function/attribute is internal/not intended to be used outside the package.

* DON'T use leading double underscore prefixed method names unless name clashes are likely.

* DO prefer structural subtyping and protocols over explicit type checks

* DO provide type hints [PEP484](https://www.python.org/dev/peps/pep-0484/)
  - See the [suggested syntax for Python2.7 and straddling code](https://www.python.org/dev/peps/pep-0484/#suggested-syntax-for-python-2-7-and-straddling-code) for guidance for Python 2.7 compatible code. 


## Coding - naming

* DO use snake_case for variables and method names
  ```python
  # Yes:
  service_client = ServiceClient()

  # No:
  serviceClient = ServiceClient()
  ```

* DO use Pascal case for Types

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

* DO specify the parameter name when calling methods with more than two required positional parameters

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

* DO specify the parameter name for optional parameters 

  ```python
  def foo(a, b=1, c=None):
    pass

  # Yes:
  foo(1, b=2, c=3)

  # No:
  foo(1, 2, 3)
  ```
## Coding - shared functionality

* DO use the base classes in [msrest](https://github.com/azure/msrest-for-python) whenever possible:

  - `msrest.SDKClient`
  - `msrest.authentication.Authentication` (and subclasses)
  - `msrest.configuration.Configuration`
  - `msrest.paging.Paged`
  - `msrest.serialization.Model`
  
* DO use the suffix "Client" for types accessing the service (Ex. CosmosClient)

* DO provide pipeline policies for shared behavior

  > TODO: Provide common policies

## Coding - common service patterns

* DO provide a way to automatically poll on long running operations

* DO provide a way to manually poll on long running operations by returning an operations object

* DO provide a way to serialize the operations objects

* DO prefer the use of the following terms for CRUD operations:
  - upsert_\<noun>
  - create_\<noun>
  - update_\<noun>
  - replace_\<noun>
  - delete_\<noun>
  - add_\<noun>
  - remove_\<noun>

* DO prefer the use of the following terms for long running operations:
  - start_\<verb>_\<noun> for methods returning an operation object

* DO provide iterators over paged results which handle subsequent calls transparently. 

  *`msrest.paging.Paged` is the preferred base class to provide this functionality.*

## Coding - namespaces

* DO add your code to the 'azure' namespace

* DO add async code to the 'azure.aio' namespace

[See packaging guidelines and async programming guidelnies for more related guidance]

## Coding - exceptions

* DO provide a common exception base class deriving from:
  > ToDo : common exception types

* DO prefer different derived exception types over only differentiating between types of errors using an exception code

## Coding - threads

* DO require explicit opt-in for any scenario where user-provided code will run in a different thread.

## Dependencies

* DO consider using the following packages for shared functionality:

  - msrest
  - requests (synchronous HTTP)
  - aiohttp (asynchronous HTTP)
  - certifi
  - ToDo : fill in more

* DON'T use external dependencies outside the list of "well known dependencis". To get a new dependency added, contact @adparch. ToDo : how to specify. 

* DON'T vendor dependencies unless approved by @adparch

## Packaging

* DO provide wheels for all supported Python versions and architectures

* DO publish your packages to PyPi

* DO name your package after the namespace of your main client class

* DO use all lowercase in your package name

* DO use semantic versioning for your package

* DO use pkgutil style namespace packages

* DO depend on azure-nspkg for Python 2.x

* DO follow PEP420 for Python 3.0

* DO include __init__.py in sdists

[More detailed instructions can be found in packaging.md]

## Packaging - Binary extensions

* DO support Windows, Linux (manylinux - see PEP513), macOS

* DO support x86, x64 and ARM

* DO support unicode and ascii versions of CPython

## Async support

* DO use the async/await keywords when targeting Python 3.5.3+

* DON'T prevent async frameworks other than asyncio (i.e. Trio) to be used

* DO provide a separate package for async support

* DO use the name azure-aio-\<service name> for the async version of the package

* DO use the namespace azure.aio.\<service_name> for your asynchronous package

[More detailed instructions can be found in async_design_guidelines.md]

## Testing

* DO use pytest as the test framework

* DO make your scenario tests runnable against live services

* DO provide recordings to allow running tests offline/without an Azure subscription

* DO support multiple simultanous test runs in the same subscription

* DO make each test case independent of other tests

## Tooling

* DO use pylint for your code

* DO use Black for formatting your code

* DO consider using MyPy to statically check your code

## Documenting your code

* DO use the Azure DO cstring guidelines to document your code

* DO provide code snippets for each non-trivial method

* DO DO cument exceptions that may be raised

[More detailed instructions can be found in docstrings.md]

## Samples

* DO provide samples showing real-world usage of the package
  - Error handling
