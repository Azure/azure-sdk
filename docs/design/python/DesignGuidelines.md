# Design guidelines for Azure python libraries

### Revision history

|Version|Date|Comments|
|-|-|-|
0.0.1|2019-01-17|Initial draft.

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

* DO follow the general guidelines in [PEP8](https://www.python.org/dev/peps/pep-0008/t) unless explicitly overridden in this document.

* DON'T "borrow" coding paradigms from other languages.
  
  *For example, regardless of how common Reactive programming is in the Java community, it is still unfamiliar for most Python devalepers.*

* DO favor consistency with other Python components over other libraries for the same service

  *It is significantly more likely that a developer will use many different libraries using the same languages than that a developer will use the same service from many different languages*
  
* DO use a single underscore to indicate that a name is not part of the public API and is not guaranteed stable.

* DON'T use leading double underscore prefixed method names unless name clashes in inheritence hierarchy are likely. This is rare. 

* DO prefer structural subtyping and protocols over explicit type checks

  *It is [Easier to ask for forgiveness than permission](https://docs.python.org/3/glossary.html#term-eafp)*

* DO derive from the abstract collections base classes `collections.abc` (or `collections` for Python 2.7) when appropriate.

* DO provide type hints [PEP484](https://www.python.org/dev/peps/pep-0484/) wherever you are providing class or function documentation.

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

* DO use keyword-only arguments for modules that only need to support Python 3.

  ```python
  # Yes
  def foo(a, *, b=1, c=None):
      ...
  ```
  
* DO specify the parameter name for optional parameters when calling functions

  ```python
  def foo(a, b=1, c=None):
      pass


  # Yes:
  foo(1, b=2, c=3)

  # No:
  foo(1, 2, 3)
  ```
## Coding - shared functionality

* DO use the suffix "Client" for types accessing the service (Ex. CosmosClient)

* DO use the base classes in [msrest](https://github.com/azure/msrest-for-python) whenever possible:

  |Type|Usage|
  |-|-|
  |`msrest.SDKClient`|Service specific client.|
  |`msrest.configuration.Configuration`|Pass configuration information to `msres.SDKClient` derived classes.
  |`msrest.authentication.Authentication`|Make use an existing class of or derive from in order to provide support for additional authentication schemes.|
  |`msrest.serialization.Model`|Base class for models returned by service methods.
  |`msrest.paging.Paged`|Base class for return values for service methods that return lists of object. Also supports server driven paging|
  |`msrest.polling.PollingMethod`|Base class for return values for service methods that are long running.|
  
* DO provide pipeline policies for shared behavior

  > TODO: Provide common policies

## Coding - common service patterns

* DO provide a way to automatically poll on long running operations

* DO provide a way to manually poll on long running operations by returning an operations object

  *A pattern of starting operation in process 1, handing off the info needed to poll to process 2 is a relatively common pattern in distributed computing.*

* DO make sure that operations objects can be [pickled](https://docs.python.org/3.7/library/pickle.html). 

* DO prefer the use of the following terms for CRUD operations:

  |Verb|Parameters|Returns|Comments|
  |-|-|-|-|
  upsert_\<noun>|key, item|Updated or created item|Create new item or update existing item.
  create_\<noun>|key, item|Created item|Create new item. Fails if item already exists.
  update_\<noun>|key, partial item|Updated item|Fails if item does not exist.
  replace_\<noun>|key, item|Replace existing item|Completely replaces an existing item. Fails if the item does not exist.
  delete_\<noun>|key|None|Delete an existing item. Will succeed even if item did not exist.
  append_\<noun>|item|Appended item|Add item to a collection. Item will be added last.
  add_\<noun>|index, item|Added item|Add item to a collection. Item will be added last.
  remove_\<noun>|key|None or removed item|Remove item from a collection.
  get_\<noun>|key|Item|Will return None if item does not exist
  list_\<noun>||`msrest.Pageable[Item]`|Return list of items. Returns empty list if no items exist
  \<noun>\_exists|key|`bool`|Return True if the item exists.

* DO prefer the use of the following terms for long running operations:
  - begin_\<verb>_\<noun> for methods returning an operation object

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

* DO maintain thread affinity for user-provided code unless explicitly documented to not do so.

  > TODO - We need to provide more specific guidance for the use of threads in SDKs. This includes scenarios with native callback libraries as well as parallell workloads.

## Dependencies

* DO consider using the following packages for shared functionality:

  - msrest
  - requests (synchronous HTTP)
  - aiohttp (asynchronous HTTP)
  > ToDo : fill in more

* DON'T use external dependencies outside the list of "well known dependencies". To get a new dependency added, contact @adparch. ToDo : how to specify. 

* DON'T vendor dependencies unless approved by @adparch

  *Vendoring dependencies in Python means including the source from another package as if it was part of your package*

## Packaging

* DO provide wheels for all supported Python versions and architectures

* DO publish your packages to PyPI

* DO name your package after the namespace of your main client class

* DO use all lowercase in your package name with a dash (-) as a separator.

* DON'T use underscore (_) or period (.) in your package name. 

* DO use semantic versioning for your package

* DO follow the specific package guidance from packaging.md]

  > TODO: Consolidate packaging wiki, python notes and this document

  * DO use pkgutil style namespace packages

  * DO depend on azure-nspkg for Python 2.x

  * DO follow PEP420 for Python 3.0

  * DO include __init__.py for the namespace(s) in sdists

## Packaging - Binary extensions

* DO support Windows, Linux (manylinux - see PEP513), macOS

* DO support x86, x64 and ARM

* DO support unicode and ascii versions of CPython

## Async support

* DO require  Python 3.5.3 for async support.

* DO use the async/await keywords.

* DON'T use the [yield from coroutine/@asyncio.coroutine](https://docs.python.org/3.4/library/asyncio-task.html) syntax in order to support Python 3.4.

* DON'T prevent async frameworks other than asyncio (i.e. Trio) to be used

* DO provide a separate package for async support

* DO use the name azure-aio-\<service name> for the async version of the package

* DO use the namespace azure.aio.\<service_name> for your asynchronous package

[More detailed instructions can be found in async_design_guidelines.md]

## Testing

* DO use pytest as the test framework

* DO consider using pytest-asyncio for testing of async code. 

* DO make your scenario tests runnable against live services

* DO provide recordings to allow running tests offline/without an Azure subscription

* DO support multiple simultanous test runs in the same subscription

* DO make each test case independent of other tests

## Tooling

* DO use pylint for your code.

  - > TODO: Shared .pylintrc? Probably one per version of Python that is to be supported (e.g. unnescessary `object` inheritence should be avoided for Python3-only code, but is required for code straddling 2.7 and 3.x)

* DO use [flake8-docstrings](https://gitlab.com/pycqa/flake8-docstrings) to verify doccomments. 

* DO use Black for formatting your code.

* DO consider using MyPy to statically check your code

## Documenting your code

* DO follow the guidelines in https://aka.ms/pydocs unless explicitly overridden in this document.

* DO use the Azure docstring guidelines to document your code

* DO provide code snippets for each non-trivial method

* DO document exceptions that may be raised

## Samples

* DO provide samples showing real-world usage of the package
  - Error handling
