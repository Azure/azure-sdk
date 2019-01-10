# Azure Python SDK Specification

**Version:** 1.0.0-preview-1

**Editors:**

- Johan Stenberg - johan.stenberg@microsoft.com

The Azure Python SDK Specification (APSS) contains guidelines for writing high-quality Python SDKs for accessing and consuming Azure services in an idiomatic, consistent, and high-quality fashion.

## Contents

> TODO: Fill in TOC. I'm still moving things around too much to be bothered with keeping it up to date. 

## 1 Scope

Any Azure SDK component published to [PyPi](https://pypi.org) under the azure namespace. For other sdk components, including Azure internal SDKs, these guidelines are merely recommended.

## 2 Terminology

- **TODO**: TODO

## 3 Pre-requisites

TODO

## 4 Platform Support

### 4.0 Operating Systems

Unless otherwise stated, all Linux, Windows and OSX versions still under support that are capable of running a supported version of Python should be supported.

### 4.1 Supported Python Versions

While Python 2.7 is quickly approaching its end of life, it is still not dead. Providing Python 2.7 compatible components are still required - however, providing additional/enhanced functionality (e.g. asynchronous support) beyond basic functionality by providing supplementary packages is expected. 

See [10.1 - async](#101-Async) below for more information on recommended ways to provide async support.

> TODO: add list of supported Python interpreters - CPython, PyPy, MicroPython etc. 


#### 4.2 Minimum required `pip` and `setuptools` versions

* Setuptools >= 17.1
* pip >= 6.0

## 5 Versioning

Packages must be versioned with [semver](https://semver.org/).

SDK components may use a major version of 0 for the first set of preview releases (e.g. for a new service). For subsequent preview releases, a -preview suffix is to be used.

TODO: Should we include API version bump => minor version bump in the official documentation?

### 5.1 Deprecation of methods or classes

Any method that is scheduled to be deprecated should add a [`warnings.warn`](https://docs.python.org/2/library/warnings.html#warnings.showwarning) using the `DeprecationWarning` category. 

## 6 Package and namespace names

All officially supported Azure packages are expected to be under the azure namespace. Package names should be the same as the namespace name with dots (.) replaced by dashes. 

Eg: 
```
Package name: azure-storage-blobs 
Namespace   : azure.storage.blobs
```

### 6.0 Determing package name

Package names should conform to azure-\<group name>-\<service name> pattern. They may include additional differentiating subpackages (e.g. azure-storage-tables)

For asynchronous alternate packages, the package name should be azure-aio-\<group name>-\<service name>

### 6.1 Namespaces and namespace syntax

The module names must be all lowercase (no camel case is allowed), and without spaces or hyphens. For example, Azure Key Vault would be in the `azure.secrets.keyvault` module - note that the two words 'Key' and 'Vault' are brought together to `keyvault`, instead of `keyVault`, `key_vault`, or `key-vault`.

Detailed information about namespaces and packaging can be found in the [Azure SDK For Python packaging wiki](https://github.com/Azure/azure-sdk-for-python/wiki/Azure-packaging)

Notable details:

* wheels MUST NOT include an azure/__init__.py file. 
* wheels should install azure-nspkg ONLY when installed on Python2
* sdists MUST contain an azure/__init__.py file that declares `azure` as a namespace package using `pkgutil` syntax.

### 6.1 Private vs. public module

Private module names should be prefixed with an underscore. 

### 7.0 Project structure

> TODO cookicutter for project creation?

The following is the canonical file structure of your python project:

```
setup.py
setup.config
MANIFEST.in
README.md
azure
  |-- some_service
  |   `-- __init__.py
tests
  `-- ...
doc
  `-- ...
```

> TODO detail multi-module projects

#### 7.1.0 Setup.py

> TODO: Reference wiki or move wiki to this document

## 8 GitHub Requirements

### 8.0 README.md

Your GitHub repo must include a README.md file that has the sections shown below. Rather than produce this from scratch, refer to the template readme.md file and take that as a starting point.

> Todo linke to template version when it exists

- One paragraph introduction of the service
- Documentation
  - Link to SDK source code 
  - Link to SDK reference documentation
- Prerequisites
  - Steps to prepare environment/resources using the Azure CLI etc.
- Installation steps (pip install service)
- How to authenticate
- Examples
  - Links to example snippets (not whole samples) describing common use cases
- Troubleshooting
- Next steps
  - Links to samples


### 8.1 LICENSE<span></span>.md

This file must be present and must contain your license text. See section 6.1 for more details.

## 9 Dependencies

#### 9.1 Adding a new dependency to a package

Dependencies on external packages must be approved by adparch@microsoft.com. 

> TODO: Where/how to keep the list of "approved" packages and versions. pyproject.toml?

## 10 Coding Conventions

### 10.0 Modern & Idiomatic Python

All SDK components should follow [the Zen of Python](https://www.python.org/dev/peps/pep-0020/):
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

### 10.1 Async

The async/await keywords were not introduced into Python until version 3.5. In addition, there is still a lot of movement both with regards to the asyncio standard library as well as in the ecosystem. This makes it less clear what the righ path forward is for python packages.

- *DO* create a separate package for asynchronous functionality
- *DO* support Python 3.5.3 (aligns with minimum version of `aiohttp`)
- *DO* add an `-aio` suffix in the package name to distinguish between the sync and async package
- *DO* add the code into the azure.aio namespace

Ex. 

`azure-storage-blob` exposes the blob storage service using synchronous IO (using requests) and supports Python 2.7+
`azure-storage-blob-aio` exposes the blob storage service using asynchronous IO (using aiohttp) and supports Python 3.5.3+

#### 10.1.1 Event loops - Asyncio vs. Trio vs. something else

While asyncio is part of the standard library, there are competing alternatives (most specifically [Trio](https://trio.readthedocs.io/en/latest/)) for asynchronous event loops in Python. Our SDK components should allow an application to choose which framework to use. 

* *DO* prefer async/await over callbacks or asyncio specific constructs (e.g. callbacks) whenever possible. 
* *DO* make it possible to use both Trio and aiohttp with your library. 

### 11.2 Client configuration

> TODO: List common configuration options. This is related to the pipeline. 

* Authentication
* Proxy configuration
* Disable certificate verification
* Enable debug logging
* Retry policy
* Tracing

### 11.3 Telemetry

> TODO: Refer back to general guidelines doc.

### 11.4 Logging

Azure components should use Python's standard logging module.

* *DO* document the available loggers. 

> TODO: Reference common guidelines on *what* should be logged. 

### 11.5 Tracing

> TODO: Need to provide guidance on how to hook up OpenCensus and OpenTrace

### 11.6 Tooling

#### 11.6.0 pylint

Pylint helps enforce coding standards, does error detection and has good editor integration. Yes, there is support for `emacs`. 

> TODO: Provide common pylint configuration?

#### 11.6.1 Black

[Black](https://black.readthedocs.io/en/stable/) is the preferred code formatter. 

#### 11.6.2 MyPy

Usage of [mypy](http://mypy-lang.org/) is encouraged but not required.

### 11.7 Testing

Azure components should use [pytest](https://docs.pytest.org/en/latest/) test framework. 

#### 11.7.1 Recordings vs. running tests against live services

## 12 Documentation

### 12.0 General Advice

Litmus test: A developer should be able to make their first successful call to the service within 5 minutes based on the information in the README.md file in the project root. This includes installation of relevant packages and creation of required resources. 

### 12.1 Quickstarts & Tutorials

> TODO: Do we require quick starts for all packages? Ideally, the example snippets in the README.md file is enough to get started. 

### 12.2 Code Samples

> TODO determine where samples should live. Options include: the Azure Samples Gallery, a single repo per language for all samples, within the azure-sdk-for-<language> repo (in a single 'samples' directory or under each specific data plane SDK).

### 12.3 API Reference Documentation

Each module, class and method should be documented according to [PEP257](https://www.python.org/dev/peps/pep-0257/). In addition, the following `sphinx` directives should be used:

Example:
```python
"""The example_documentation module shows how a module in an Azure SDK component should look.
"""

class ClassWithExample(object):
  """ A collection of mathematical functions

  The methods of this class are only for show. They don't acutally have a method body. But they
  do have beautiful and relevant documentation. 
  
  :ivar last_factorial: The result of the last factorial computed
  """

  def __init__(self, seed:"int"=7):
    self.last_factorial = -1


  def calculate_factorial(self, value: "int", fail_if_bigger_than: "int"=None) -> "int":
    """ Calculate the factorial of `value`
    :param value: The value for which the factorial is to compted.
    :param fail_if_bigger_than: Raise a `ValueError` if the value is greater than the provided value.
    :raise ValueError: If result is greater than fail_if_bigger_than.

    .. literalinclude:: ../../examples/class_with_example.py
    :start-after: [START calculate_factorial]
    :end-before: [END calculate_factorial]
    :language: python
    :dedent: 0
    :caption: Calculate the factorial of 4711:
    :name: calculate_factorial
    """
    pass
```

#### 12.3.1 Inline code snippets

The `".. literalinclude"` directive lets you include sections of an external file. By having an external file that you selectively include sections from, you can keep your code examples executable (by including any code needed to setup/clean up the environment/variables referenced in the code snippet) without having to include this in the code snippet. 

> TODO: Link to example

#### 12.3.2 Supported `Sphinx` directives

|Directive|Description|Example|
|-|-|-|
|:param:| Parameter documentation
|:ivar:| Class member
|:returns:|
|:raises:|
|:literalinclude:|

> TODO: Find the supposedly just agreed-upon format to use for MS SDKs. 

#### 12.3.2 Generating documentation locally

> TODO: 