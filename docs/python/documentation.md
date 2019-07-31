---
title: "Python Guidelines: Documentation"
keywords: guidelines python
permalink: python_documentation.html
folder: python
sidebar: python_sidebar
---

There are several documentation deliverables that must be included in or as a companion to your 
client library. Beyond complete and helpful API documentation within the code itself (docstrings), you need a great README and other supporting documentation.

* `README.md` - Resides in the root of your library's directory within the SDK repository; includes package installation and client library usage information. ([example](https://github.com/Azure/azure-sdk/blob/master/docs/README-EXAMPLE.md))
* `API reference` - Generated from the docstrings in your code; published on docs.microsoft.com. 
* `Code snippets` - Short code examples that demonstrate single (atomic) operations for the champion scenarios you've identified for your library; included in your README, docstrings, and Quickstart. 
* `Quickstart` - Article on docs.microsoft.com that is similar to but expands on the README content; typically written by your service's content developer. 
* `Conceptual` - Long-form documentation like Quickstarts, Tutorials, How-to guides, and other content on docs.microsoft.com; typically written by your service's content developer. 

{% include requirement/MUST %} include your service's content developer in the adparch review for your 
library. To find the content developer you should work with, check with your team's Program 
Manager.

{% include requirement/MUST %} follow the [Azure SDK Contributors Guide]. (MICROSOFT INTERNAL)

{% include requirement/MUST %} adhere to the specifications set forth in the Microsoft style guides when 
you write public-facing documentation. This applies to both long-form documentation like a README 
and the docstrings in your code. (MICROSOFT INTERNAL)

* [Microsoft Writing Style Guide].
* [Microsoft Cloud Style Guide].

{% include requirement/SHOULD %} attempt to document your library into silence. Preempt developers' usage 
questions and minimize GitHub issues by clearly explaining your API in the docstrings. Include 
information on service limits and errors they might hit, and how to avoid and recover from those 
errors.

As you write your code, *doc it so you never hear about it again.* The less questions you have to 
answer about your client library, the more time you have to build new features for your service.

## Docstrings

{% include requirement/MUST %} follow the [documentation guidelines](http://aka.ms/pydocs) unless explicitly overridden in this document.

{% include requirement/MUST %} provide docstrings for all public modules, types, and methods.

{% include requirement/MUST %} document any `**kwargs` directly consumed by a method. You may refer to the signature of a called method if the `**kwargs` are passed through.

Example:
```python
def request(method, url, headers, **kwargs): ...

def get(*args, **kwargs):
    "Calls `request` with the method "GET" and forwards all other arguments."
    return request("GET", *args, **kwargs)
```

{% include requirement/MUST %} document exceptions that may be raised explicitly in the method and any exceptions raised by the called method.

### Code snippets

{% include requirement/MUST %} include example code snippets alongside your library's code within the repository. The snippets should clearly and succinctly demonstrate the operations most developers need to perform with your library. Include snippets for every common operation, and especially for those that are complex or might otherwise be difficult for new users of your library. At a bare minimum, include snippets for the champion scenarios you've identified for the library.

{% include requirement/MUST %} build and test your example code snippets using the repository's continuous integration (CI) to ensure they remain functional.

{% include requirement/MUST %} include the example code snippets in your library's docstrings so they appear in its API reference. If the language and its tools support it, ingest these snippets directly into the API reference from within the docstrings. Each sample should be a valid `pytest`.

Use the `literalinclude` directive in Python docstrings to instruct Sphinx to [ingest the snippets automatically][1].

{% include requirement/MUSTNOT %} combine more than one operation in a code snippet unless it's required for demonstrating the type or member, or it's *in addition to* existing snippets that demonstrate atomic operations. For example, a Cosmos DB code snippet should not include both account and container creation operations--create two different snippets, one for account creation, and one for container creation.

Combined operations cause unnecessary friction for a library consumer by requiring knowledge of additional operations which might be outside their current focus. It requires them to first understand the tangential code surrounding the operation they're working on, then carefully extract just the code they need for their task. The developer can no longer simply copy and paste the code snippet into their project.

{% include refs.md %}
{% include_relative refs.md %}
[1]: http://www.sphinx-doc.org/en/1.5/markup/code.html#includes
