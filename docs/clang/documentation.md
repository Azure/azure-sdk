---
title: "C Guidelines: Documentation"
keywords: guidelines clang
permalink: clang_documentation.html
folder: clang
sidebar: clang_sidebar
---

{% include draft.html content="The C Language guidelines are in DRAFT status" %}

There are several documentation deliverables that must be included in or as a companion to your client library. Beyond complete and helpful API documentation within the code itself (docstrings), you need a great README and other supporting documentation.

* `README.md` - Resides in the root of your library's directory within the SDK repository; includes package installation and client library usage information. ([example][README-EXAMPLE])
* `API reference` - Generated from the docstrings in your code; published on docs.microsoft.com. 
* `Code snippets` - Short code examples that demonstrate single (atomic) operations for the champion scenarios you've identified for your library; included in your README, docstrings, and Quickstart. 
* `Quickstart` - Article on docs.microsoft.com that is similar to but expands on the README content; typically written by your service's content developer. 
* `Conceptual` - Long-form documentation like Quickstarts, Tutorials, How-to guides, and other content on docs.microsoft.com; typically written by your service's content developer. 

{% include requirement/MUST id="clang-docs-contentdev" %} include your service's content developer in the Architecture Board review for your library. To find the content developer you should work with, check with your team's Program Manager.

{% include requirement/MUST id="clang-docs-contributors-guide" %} follow the [Azure SDK Contributors Guide]. (MICROSOFT INTERNAL)

{% include requirement/MUST id="clang-docs-style-guide" %} adhere to the specifications set forth in the Microsoft style guides when you write public-facing documentation. This applies to both long-form documentation like a README and the docstrings in your code. (MICROSOFT INTERNAL)

* [Microsoft Writing Style Guide].
* [Microsoft Cloud Style Guide].

{% include requirement/SHOULD id="clang-docs-to-silence" %} attempt to document your library into silence. Preempt developers' usage questions and minimize GitHub issues by clearly explaining your API in the docstrings. Include information on service limits and errors they might hit, and how to avoid and recover from those errors.

As you write your code, *doc it so you never hear about it again.* The less questions you have to answer about your client library, the more time you have to build new features for your service.

### Docstrings

{% include requirement/MUST id="clang-docs-doxygen" %} include docstrings compatible with the [doxygen](http://www.doxygen.nl/index.html) tool for generating reference documentation.

For example, a (very) simple docstring might look like:
{% highlight c %}
/**
 *   @struct az_appconf_client
 *   @brief The az_appconf_client represents the resources required for a connection to
 *          an Azure AppcConfiguration resource.
 */
{% endhighlight %}

{% include requirement/MUST id="clang-docs-doxygen-cmd" %} use doxygen's `@cmd` style docstrings

{% include requirement/MUST id="clang-docs-doxygen-params" %} format parameter documentation like the following:

{% highlight c %}
/* <....documentation....>
* \param[<direction>] <param_name> __<additional_annotations>__ description
* <....documentation....>
*/
{% endhighlight %}

`<additional_annotations>` is a space-separated list of the following annotations:

* `[transfer none|full|container]`
    : indicates who owns a parameter and how that ownership is transferred by a given function
      each ownership transfer mode is defined below. The recipient of a value is the caller for `[callee allocates]` parameters and the callee for `[caller allocates]` parameters
* `[transfer none]`
    : indicates no change in ownership for this parameter. This is sometimes called "borrowing"
* `[transfer full]`
    : indicates complete ownership transfer. After a call to the function the recipient (either the caller or the callee) will be
      responsible for the value. This usually means the recipient will at least need to arrange for any memory referred to by
      the value to be freed.
* `[transfer container]`
    : indicates full ownership transfer for a container value, but not for its contents. For example a char** parameter (that referrers to an array of cstrings)
      would be annotated as `[transfer container]` if the recipient is expected to free the array, but not free each element therein.
* `[nullable]`
    : the parameter may be set to NULL, only valid for pointer parameters/return values. Don't annotate return values or out parameters as `[nullable]`
      if NULL is used to report errors. If a parameter is marked `[nullable]` document what happens when it is null.
* `[not nullable]`
    : The parameter may not be null.
* `[caller allocates]`
    : memory for the value is expected to be allocated by the caller. This is the default for `[in]` parameters, and `[out]/[in,out]` parameters
      that have a single indirection (that is `Foo* p` is `[caller allocates]` but `Foo** p` is not).
* `[callee allocates]`
    : memory for the value will be allocated by the callee. This usually means the caller will need to free said memory when it's no longer needed.

For example:
{% highlight c %}
/**
 * @brief execute a blocking get request
 *	
 * @memberof az_appconf_client
 * 
 * @param[in] client __[transfer none]__
 * @param[in] path_and_query __[transfer none][not nullable]__ 
 * 			  The query to execute relative to the base url of the client
 * @param[out] result __[transfer full][not nullable][callee allocates]__
 * @param[out] result_sz __[not nullable]__ size of the result
 */
az_appconf_err az_appconf_req_get(
    az_appconf_client* client, const char* path_and_query, unsigned char** result, size_t* result_sz);
{% endhighlight %}

Here we see that the first two parameters are input parameters, with no ownership transfer (that is, they are a "borrow"). The `result` output parameter is labeled as `[callee allocates]` because it allocates memory for the output parameter itself. Since `result` is owned by the caller after `az_appconf_req_get` returns it's annotated as `[transfer full]`.

The annotations do not require any special doxygen support and are simply convention. 

{% include requirement/MAY id="clang-docs-doxygen-defaults " %} assume the following default annotations:

* `[not nullable]`
* For `[out]` and `[in,out]` pointer parameters: `[caller allocates][transfer none]`
* For `[out]` and `[in,out]` pointer-to-pointer parameters: `[callee allocates][transfer full]`
* for `[in]` parameters: `[caller allocates]` (Note: `[callee allocates]` doesn't make sense for `[in]` parameters)

{% include requirement/MUST id="clang-docs-doxygen-nullable" %} document what happens to parameters that are set to null.

For example:

{% highlight c %}
/**
 * @brief get properties of a cat (e.g. hair color, weight, floof)
 *
 * @param[in] our_cat __[transfer none]__ the cat to operate on
 * @param[out] props __[nullable][caller-allocates]__ pointer to an array of num_props, or null
 * @param[in,out] num_props __[non nullable][caller-allocates]__ pointer to the number of properties to
 *                                                               retrieve or to a location to store the number of
 *                                                               properties queried as described below
 *
 * If @p props is NULL then return the number of properties available in @p num_props,
 * otherwise return @p num_props into the array at @p props
 */
az_error az_catherding_get_cat_properties(cat* our_cat, cat_properties* props, size_t* num_props);
{% endhighlight %}

This function returns an array using all caller-allocated memory. In order to figure out the size of the array the caller can pass NULL for the array `[out]` parameter. They can then allocate the required memory and call the function again.

{% include requirement/MUST id="clang-docs-doxygen-ptr-dir" %} provide a `<direction>` for all parameters that are pointers or structs/unions containing a pointer.

> **Note**: 
> These annotations are derived from [gobject-introspection-annotations](https://wiki.gnome.org/Projects/GObjectIntrospection/Annotations).  It's not a big deal that we use that form, it's just critical that there is a standard way to indicate ownership of reference parameters

{% include requirement/MUST id="clang-docs-doxygen-failure" %} document how your function can fail. For example, if returning an error code, document when each possible code will be returned.

### Code snippets

{% include requirement/MUST id="clang-docs-include-snippets" %} include example code snippets alongside your library's code within the repository. The snippets should clearly and succinctly demonstrate the operations most developers need to perform with your library. Include snippets for every common operation, and especially for those that are complex or might otherwise be difficult for new users of your library. At a bare minimum, include snippets for the champion scenarios you've identified for the library.

{% include requirement/MUST id="clang-docs-build-snippets" %} build and test your example code snippets using the repository's continuous integration (CI) to ensure they remain functional.

{% include requirement/MUST id="clang-docs-snippets-in-docstrings" %} include the example code snippets in your library's docstrings so they appear in its API reference. If the language and its tools support it, ingest these snippets directly into the API reference from within the docstrings. 

For example, consider a function called `az_do_something_or_other`:
{% highlight c %}
/** 
 * @brief some structure type
 */
typedef struct az_some_struct {
    int member;
} az_some_struct;

/**
 * @brief do something, or maybe do some other thing
 * @memberof az_some_struct
 */
void az_do_something_or_other(az_some_struct* s);
{% endhighlight %}
It can be used as follows:
{% highlight c %}
/**
 * @example example_1.c
 */
int main() {
    az_some_struct a;
    az_do_something_or_other(&a);
    return 1;
}
{% endhighlight %}
When doxygen processes these files, it will see the `@example` command in example_1.c and 
add it to the "examples" section of the documentation, it will also see the usage of
`az_some_struct` in the example and add a link from the documentation of `az_some_struct` to the
documentation (including source code) for `example_1.c`.

Use `@include` or `@snippet` to include examples directly in the documentation for a function or structure. 
For example:

{% highlight c %}
/** 
 * @brief some structure type
 */
typedef struct az_some_struct {
    int member;
} az_some_struct;

/**
 * @brief do something, or maybe do some other thing
 * @memberof az_some_struct
 * see @snippet example_1.c use az_some_struct
 */
void az_do_something_or_other(az_some_struct* s);
{% endhighlight %}
It can be used as follows:
{% highlight c %}
/**
 * @example example_1.c
 */
int main() {
    /** [use az_some_struct] */
    az_some_struct a;
    az_do_something_or_other(&a);
    /** [use az_some_struct] */
    return 1;
}
{% endhighlight %}

Note that automatic links from documentation to examples will only be generated in struct documentation,
not in function documentation. To generate a link from a function's documentation to an example use `@dontinclude`. For example:

{% highlight c %}
/**
 * @brief do something, or maybe do some other thing
 * @memberof az_some_struct
 * @dontinclude example_1.c
 */
void az_do_something_or_other(az_some_struct* s);
{% endhighlight %}

{% include requirement/MUSTNOT id="clang-docs-operation-combinations" %} combine more than one operation in a code snippet unless it's required for demonstrating the type or member, or it's *in addition to* existing snippets that demonstrate atomic operations. For example, a Cosmos DB code snippet should not include both account and container creation operations--create two different snippets, one for account creation, and one for container creation.

Combined operations cause unnecessary friction for a library consumer by requiring knowledge of additional operations which might be outside their current focus. It requires them to first understand the tangential code surrounding the operation they're working on, then carefully extract just the code they need for their task. The developer can no longer simply copy and paste the code snippet into their project.

### Buildsystem integration

{% include requirement/MUST id="clang-docs-buildsystem" %} Provide a buildsystem target called "docs" to build
    the documentation

{% include requirement/MUST id="clang-docs-buildsystem-option" %} Provide an option `BUILD_DOCS` to control
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

    set(DOXYGEN_OPTIMIZE_OUTPUT_FOR_C YES)
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
