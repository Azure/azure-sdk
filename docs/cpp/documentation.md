---
title: "C++ Guidelines: Documentation"
keywords: guidelines cpp
permalink: cpp_documentation.html
folder: cpp
sidebar: cpp_sidebar
---

{% include draft.html content="The C++ Language guidelines are in DRAFT status" %}

There are several documentation deliverables that must be included in or as a companion to your client library. Beyond complete and helpful API documentation within the code itself (docstrings), you need a great README and other supporting documentation.

* `README.md` - Resides in the root of your library's directory within the SDK repository; includes package installation and client library usage information. ([example][README-EXAMPLE])
* `API reference` - Generated from the docstrings in your code; published on docs.microsoft.com.
* `Code snippets` - Short code examples that demonstrate single (atomic) operations for the champion scenarios you've identified for your library; included in your README, docstrings, and Quickstart.
* `Quickstart` - Article on docs.microsoft.com that is similar to but expands on the README content; typically written by your service's content developer.
* `Conceptual` - Long-form documentation like Quickstarts, Tutorials, How-to guides, and other content on docs.microsoft.com; typically written by your service's content developer.

{% include requirement/MUST id="cpp-docs-contentdev" %} include your service's content developer in the Architecture Board review for your library. To find the content developer you should work with, check with your team's Program Manager.

{% include requirement/MUST id="cpp-docs-contributors-guide" %} follow the [Azure SDK Contributors Guide]. (MICROSOFT INTERNAL)

{% include requirement/MUST id="cpp-docs-style-guide" %} adhere to the specifications set forth in the Microsoft style guides when you write public-facing documentation. This applies to both long-form documentation like a README and the docstrings in your code. (MICROSOFT INTERNAL)

* [Microsoft Writing Style Guide].
* [Microsoft Cloud Style Guide].

{% include requirement/SHOULD id="cpp-docs-to-silence" %} attempt to document your library into silence. Preempt developers' usage questions and minimize GitHub issues by clearly explaining your API in the docstrings. Include information on service limits and errors they might hit, and how to avoid and recover from those errors.

As you write your code, *doc it so you never hear about it again.* The less questions you have to answer about your client library, the more time you have to build new features for your service.

### Docstrings

{% include requirement/MUST id="cpp-docs-doxygen" %} include docstrings compatible with the [doxygen](http://www.doxygen.nl/index.html) tool for generating reference documentation.

For example, a (very) simple docstring might look like:
{% highlight cpp %}
/**
 *   @class client
 *   @brief The client represents the resources required for a connection to an Azure AppcConfiguration resource.
 */
{% endhighlight %}

{% include requirement/MUST id="cpp-docs-doxygen-cmd" %} use doxygen's `@cmd` style docstrings

{% include requirement/MUST id="cpp-docs-doxygen-params" %} format parameter documentation like the following:

{% highlight cpp %}
/* <....documentation....>
* @param[<direction>] <param_name> description
* <....documentation....>
*/
{% endhighlight %}

For example:
{% highlight cpp %}
namespace azure::storage::blob {
/**
 * @brief execute a blocking get request
 *
 * @param[in] client
 * @param[in] path_and_query The query to execute relative to the base url of the client
 * @param[out] result
 * @param[out] result_sz size of the result
 */
void req_get(client* client, const char* path_and_query, unsigned char** result, size_t* result_sz);
} // namespace azure::storage::blob
{% endhighlight %}

{% include requirement/MUST id="cpp-docs-doxygen-nullable" %} document what happens to parameters that are set to null.

For example:

{% highlight cpp %}
namespace azure::animals::cats {
/**
 * @brief get properties of a cat (e.g. hair color, weight, floof)
 *
 * @param[in] our_cat the cat to operate on
 * @param[out] props pointer to an array of num_props, or null
 * @param[in,out] num_props pointer to the number of properties to retrieve or to a location to store the number of
 *                          properties queried as described below
 *
 * If @p props is NULL then return the number of properties available in @p num_props,
 * otherwise return @p num_props into the array at @p props
 */
void get_cat_properties(cat* our_cat, cat_properties* props, size_t* num_props);
} // namespace azure::animals::cats
{% endhighlight %}

{% include requirement/MUST id="cpp-docs-doxygen-failure" %} document which exceptions your function can propagate.

### Code snippets

{% include requirement/MUST id="cpp-docs-include-snippets" %} include example code snippets alongside your library's code within the repository. The snippets should clearly and succinctly demonstrate the operations most developers need to perform with your library. Include snippets for every common operation, and especially for those that are complex or might otherwise be difficult for new users of your library. At a bare minimum, include snippets for the champion scenarios you've identified for the library.

{% include requirement/MUST id="cpp-docs-build-snippets" %} build and test your example code snippets using the repository's continuous integration (CI) to ensure they remain functional.

{% include requirement/MUST id="cpp-docs-snippets-in-docstrings" %} include the example code snippets in your library's docstrings so they appear in its API reference. If the language and its tools support it, ingest these snippets directly into the API reference from within the docstrings.

For example, consider a function called `do_something_or_other`:
{% highlight cpp %}
namespace azure::sdks::example {
/**
 * @brief some class type
 */
struct some_class {
    int member;

    /**
    * @brief do something, or maybe do some other thing
    */
    void do_something_or_other();
};
} // azure::sdks::example
{% endhighlight %}
It can be used as follows:
{% highlight cpp %}
/**
 * @example example_1.cpp
 */
int main() {
    using azure::sdks::example::some_class;
    some_class a;
    a.do_something_or_other();
    return 1;
}
{% endhighlight %}
When doxygen processes these files, it will see the `@example` command in example_1.cpp and
add it to the "examples" section of the documentation, it will also see the usage of
`some_struct` in the example and add a link from the documentation of `some_struct` to the
documentation (including source code) for `example_1.cpp`.

Use `@include` or `@snippet` to include examples directly in the documentation for a function or structure.
For example:

{% highlight cpp %}
//
// @brief some structure type
//
struct some_struct {
    int member;
};

//
// @brief do something, or maybe do some other thing
// see @snippet example_1.cpp use some_struct
//
void do_something_or_other(some_struct* s);
{% endhighlight %}
It can be used as follows:
{% highlight cpp %}
/**
 * @example example_1.cpp
 */
int main() {
    /** [use some_struct] */
    some_struct a;
    do_something_or_other(&a);
    /** [use some_struct] */
    return 1;
}
{% endhighlight %}

Note that automatic links from documentation to examples will only be generated in struct documentation,
not in function documentation. To generate a link from a function's documentation to an example use `@dontinclude`. For example:

{% highlight cpp %}
/**
 * @brief do something, or maybe do some other thing
 * @dontinclude example_1.cpp
 */
void do_something_or_other(const some_struct& s);
{% endhighlight %}

{% include requirement/MUSTNOT id="cpp-docs-operation-combinations" %} combine more than one operation in a code snippet unless it's required for demonstrating the type or member, or it's *in addition to* existing snippets that demonstrate atomic operations. For example, a Cosmos DB code snippet should not include both account and container creation operations--create two different snippets, one for account creation, and one for container creation.

Combined operations cause unnecessary friction for a library consumer by requiring knowledge of additional operations which might be outside their current focus. It requires them to first understand the tangential code surrounding the operation they're working on, then carefully extract just the code they need for their task. The developer can no longer simply copy and paste the code snippet into their project.

### Buildsystem integration

{% include requirement/MUST id="cpp-docs-buildsystem" %} Provide a buildsystem target called "docs" to build
    the documentation

{% include requirement/MUST id="cpp-docs-buildsystem-option" %} Provide an option `BUILD_DOCS` to control
    building of the docs, this should default to `OFF`

To provide this you can use the CMake `FindDoxygen` module as follows:

{% highlight cmake %}
option(BUILD_DOCS "Build documentation" OFF)
if(BUILD_DOCS)
    find_package(Doxygen REQUIRED doxygen)

    # note: DOXYGEN_ options are strings to cmake, not
    # booleans, thus use only YES and NO
    set(DOXYGEN_GENERATE_XML YES)
    set(DOXYGEN_GENERATE_HTML YES)

    set(DOXYGEN_EXTRACT_PACKAGE YES)
    set(DOXYGEN_INLINE_SIMPLE_STRUCTS YES)
    set(DOXYGEN_TYPEDEF_HIDES_STRUCT YES)
    doxygen_add_docs(docs
        ${PROJECT_SOURCE_DIR}/inc
        ${PROJECT_SOURCE_DIR}/doc
        ${PROJECT_SOURCE_DIR}/src
        COMMENT "Generate Documentation")
endif()
{% endhighlight %}


{% include refs.md %}
