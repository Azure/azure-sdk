---
title: "Embedded C Guidelines: Implementation"
keywords: guidelines clang
permalink: clang_implementation.html
folder: clang
sidebar: general_sidebar
---

{% include draft.html content="The C Language guidelines are in DRAFT status" %}

## API Implementation

### Service Client

#### Service Methods

C doesn't have object oriented programming built in, but most programs end up implementing some kind of ad-hoc object model. 

Let's consider the object used to represent a widget in the fictional Azure Widgets service. Such a structure could be defined like this:

{% highlight c %}
typedef struct az_widgets_widget {
  uint16_t num_sides;
  az_widget_side* sides;
  bool was_frobnicated;
} az_widgets_widget;
{% endhighlight %}

If you are defining an opaque type then the definition is placed in a `.c` file and the header file contains the following:

{% highlight c %}
typedef struct az_widgets_widget az_widgets_widget;
{% endhighlight %}

If you need to expose the type (for stack allocation), but would like to make it clear that some fields are private and should not be modified, place the type in the header file as follows::

{% highlight c %}
typedef struct az_widgets_widget {
  struct {
    uint16_t num_sides;
    az_widgets_side* sides;
    bool was_frobnicated;
  } _internal;
} az_widgets_widget;
{% endhighlight %}

{% include requirement/MUSTNOT id="clang-objmodel-nohiding" %} hide the members of a struct that supports stack allocation, except in the above way.  This can result in alignment problems and missed optimization opportunities.

##### Initialization and destruction

You must always have an initialization function. This function will take a block of allocated memory of the correct size and alignment and turn it into a valid object instance, setting fields to default values and processing initialization parameters. 

{% include requirement/MUST id="clang-objmodel-init" %} name initialization functions with the form `az_<libname>_init_...`.

{% include requirement/MUST id="clang-objmodel-ready" %} ensure that the object is "ready to use" after a call to the init function for the object.

If there is more than one way to initialize an object, you should define multiple initialization functions with different names. For example:

{% highlight c %}
void az_widgets_client_init(az_widgets_client* client);
void az_kwidgets_client_init_with_sides(az_widgets_client* client, int num_sides, az_widgets_side* sides);
{% endhighlight %}

If initialization could fail (for example, during parameter validation), ensure the init function returns an `az_result` to indicate error conditions.

A possible implementation of these initialization functions would be:

{% highlight c %}
void az_widgets_client_init(az_widgets_client* client) {
  memset(client, 0, sizeof(az_widgets_client));
}


void az_widgets_client_init_with_sides(az_widgets_client* client,
				       int num_sides, az_widgets_side* sides) {
  az_widgets_client_init(herd);
  herd->sides = sides;
  herd->num_sides = num_sides;
}
{% endhighlight %}

Similarly to allocation, a type can have a destruction function. However only types that own a resource (such as memory), or require special cleanup (like securely zeroing their memory) need a destruction function.

{% include requirement/SHOULD id="clang-objmodel-prefer-nonalloc" %} prefer non-allocating types and methods.

##### Allocation and deallocation

Your library should not allocate memory if possible.  It should be possible to use the client library without any allocations, deferring all allocations to the client program.

Allocation should be separated from initialization, unless there's an extremely good reason to tie them together. In general we want to let the user allocate their own memory. You only need an allocation function if you intend to hide the size and alignment of the object from the user.

{% include requirement/MUST id="clang-objmodel-alloc1" %} name the allocation and deallocation functions as `az_<libname>_(de)allocate_<objtype>`.

Note that this is the opposite of the pattern for other methods.  Allocation functions do not operate on a value of `<objtype>`.  Rather they create and destroy such values.

{% include requirement/MUST id="clang-objmodel-alloc2" %} provide an allocation and deallocation function for opaque types.

{% include requirement/SHOULD id="clang-objmodel-alloc3" %} take a set of allocation callbacks as a parameter to the allocation and deallocation functions for an opaque type.  Use the library default allocation functions if the allocation callback parameter is NULL.

{% include requirement/SHOULDNOT id="clang-objmodel-alloc4" %} store a pointer to the allocation callbacks inside the memory returned by the allocation function.  You may store such a pointer for debugging purposes.

The intent is to allow storing a pointer to the allocation callbacks to ensure the same set of callbacks is used for allocation and deallocation.  However, it is not allowed to change the ABI of the returned object to do this.  You need to store the callbacks before or after the pointer returned to the caller.

> TODO: Rationalize this - do we store or not store?

{% include requirement/MUSTNOT id="clang-objmodel-alloc5" %} return any errors from the deallocation function.  It is impossible to write leak-free programs if deallocation and cleanup functions can fail.

For example:

{% highlight c %}
#include <stdint.h>
typedef struct az_widget_client az_widget_client;

az_result az_widgets_allocate_client(az_widgets_client** herd, az_allocation_callbacks* alloc);
void az_widgets_deallocate_client(az_widgets_client* herd, az_allocation_callbacks* alloc);
{% endhighlight %}

{% highlight c %}
#include "herd.h"
typedef struct az_widgets_client {
  uint16_t num_sides;
  az_widgets_side* sides;
  bool was_frobnicated;
} az_widgets_client;


az_result az_widgets_allocate_client(az_widgets_client** client, az_allocation_callbacks* alloc) {
if(!alloc) {
    *client = az_default_alloc(sizeof(az_widgets_client));
} else {
    *client = alloc->allocate(sizeof(az_widgets_herd));
}
if(!*client) {
    return AZ_ERROR_ALLOCATION_ERROR;
}
return AZ_OK;
}

void az_widgets_deallocate_client(az_widgets_client* client, az_allocation_callbacks* alloc) {
if(!alloc) {
    az_default_deallocate(client);
} else {
    alloc->deallocate(client);
}
}
{% endhighlight %}

##### Initialization for objects that allocate

The initialization function should take a set of allocation callbacks and store them inside the object instance.  

{% include requirement/MUST id="clang-objmodel-initalloc1" %} take a set of allocation / deallocation callbacks in the `init` function of objects owning inner pointers.

{% include requirement/SHOULDNOT id="clang-objmodel-initalloc2" %} allocate different inner pointers with different sets of allocation callbacks.  Use a single allocation callback.

##### Destruction for objects that allocate

{% include requirement/MUST id="clang-objmodel-destroyalloc1" %} name destruction functions `az_<libname>_<objtype>_destroy`.

{% include requirement/MUSTNOT id="clang-objmodel-destroyalloc2" %} take allocation callbacks in the destruction function.

The reason one would take an allocation callback parameter in the destruction function is to save space by not storing it in the object instance. The reason we prohibit this is that it means an object that owns a pointer to another object must then take _two_ allocation parameters in its destroy function. 

{% include requirement/MUSTNOT id="clang-objmodel-destroyalloc3" %} return any errors in the destruction function.  It's impossible to write leak-free programs if deallocation / cleanup functions can fail.

The destruction function should follow this pattern:

{% highlight c %}
void az_widgets_client_destroy(az_widgets_client* client);
{% endhighlight %}

The following is a possible implementation of a destruction function for the widgets client object:

{% highlight c %}
void az_widgets_client_destroy(az_widgets_client* client) {
if(client->alloc) {
    client->alloc->deallocate(sides);
}
az_string_destroy(client->str);
client->num_sides = 0;
client->alloc = 0;
}
{% endhighlight %}

##### Methods on objects

To define a method on an object simply define a function taking a pointer to that object as its first parameter. For example:

{% highlight c %}
/**
 * @brief add a side to the widget
 * @memberof az_widgets_client
 *
 * @param[in] herd - the herd
 * @param[in] __[transfer none]__ side - the side to add
 * @return Any errors
 * @retval AZ_OK on success
 * @retval AZ_ERROR_NO_MEMORY if a reallocation of the internal
 *                            array failed
 */
az_result az_widgets_client_add_side(az_widgets_client* client, az_widgets_side* side);
{% endhighlight %}

{% include requirement/MUST id="clang-objmodel-memberof" %} use `@memberof` to indicate a function is associated with a class.

{% include requirement/MUST id="clang-objmodel-firstparam" %} provide the class object as the first parameter to a function associated with the class.

##### Functions with many parameters

Sometimes a function will take a large number of parameters, many of which have sane defaults.  In this case you should pass them via a struct. Default arguments should be represented by "zero". If the function is a method then the first parameter should still be a pointer to the object type the method is associated with.

For example the previous `az_widgets_client_init_with_sides` function could be defined instead as:

{% highlight c %}
typedef struct az_widgets_client_init_with_sides_options {
  int num_sides;
  az_widgets_side* sides;
  bool was_frobnicated;
} az_widgets_client_init_with_sides_options;
void az_widgets_client_init_with_sides(az_widgets_client* client, const az_widgets_client_init_with_sides_options* options);
{% endhighlight %}

and would be called from user code like:

{% highlight c %}
int main() {
  az_widgets_client client = { 0 };
  az_widgets_client_init_with_sides_options options = 
    az_widgets_client_init_with_sides_default_options();
  az_widgets_client_init_with_sides(&client, NULL);
}
{% endhighlight %}

Note that the `num_sides` and `sides` parameters are left as default.

If the `params` parameter is `NULL` then the `az_widgets_client_init_with_sides` function should assume the defaults for all parameters.

If a function takes both optional and non-optional parameters then prefer passing the non-optional ones as parameters and the optional ones by struct.

{% include requirement/MUST id="clang-objmodel-manyparams" %} use a struct to encapsulate parameters if the number of parameters is greater than 5.  

{% include requirement/MUSTNOT id="clang-objmodel-manyparams2" %} include the class object in the encapsulating parameter struct.

##### Methods requiring allocation

If a method could require allocating memory then it should use the most relevant set of allocation callbacks. For example the `az_widgets_client_add_side` method may need to allocate or re-allocate the array of sides.  It should use the `az_widgets_client` allocators.  On the other hand the method:

{% highlight c %}
void az_widgets_client_set_str(az_widgets_client* herd, const char* str);
{% endhighlight %}

would likely use the allocation callbacks inside the `client->str` structure.

> TODO: Rationalize advice here.  Earlier, we said don't include allocators inside the structure.

##### Callbacks

Callback functions should be defined to take a pointer to the "sender" object as the first argument and a void pointer to user data as the last argument. Any additional arguments, if any, should be contextual data needed by the callback. For example say we had an object `az_widgets_client` that could make requests to be handled in a callback and we represent the response as an object `az_response`. We might define the following:

{% highlight c %}
typedef bool (*az_widgets_response_callback)(az_widgets_client* client,
						az_response* resp,
						void* user_data);
void az_widgets_client_set_response_callback(az_widgets_client* client,
						az_widgets_response_callback callback,
						void* user_data);
{% endhighlight %}

Client code would use this in the following manner:

{% highlight c %}
typedef struct user_data {
  int some_int;
} user_data;


bool handle_resp(az_widgets_client* client,
		 az_response* resp,
		 void* user) {
  user_data* data = user;
  /* do things with parameters */
  return true;
}

int main() {
  user_data d = {.some_int = 5};
  az_widgets_client client = { 0 };
  az_widgets_client_init(&client);
  az_widgets_client_set_response_callback(&client, &handle_resp, &d);
  /* do something that triggers the callback */

  /* unset the callback if we don't want to handle it anymore */
  az_widgets_client_set_response_callback(&client, NULL, NULL);
}
{% endhighlight %}

{% include requirement/MUST id="clang-objmodel-callback-userdata" %} include a `user_data` parameter on all callbacks.

{% include requirement/MUSTNOT id="clang-objmodel-callback-deref" %} de-reference the user data pointer from inside the library.

##### Discriminated Unions

Discriminated unions can be useful for grouping information in a struct. However, C does not provide a standard way of defining discriminated unions.  Use the following:

{% highlight c %}
typedef struct discriminated_union {
  enum {
	discriminated_union_tag_int,
	discriminated_union_tag_float,
	discriminated_union_tag_double
  } tag;
  union {
    int the_int;
    float the_float;
    double the_double;
  } value;
} discriminated_union;
{% endhighlight %}

This syntax is supported on all C99 compilers as it adheres to strict C99 syntax. Access the inner member using `union_value.value.the_int` (as an example).

The nested enum and union should never have a `tag name` as this is *always* an extension.  It is a user error to access the union without checking its tag first.

#### Service Method Parameters

##### Parameter Validation

> TODO: This is duplicated from the design.md.

The service client will have several methods that perform requests on the service.  _Service parameters_ are directly passed across the wire to an Azure service.  _Client parameters_ are not passed directly to the service, but used within the client library to fulfill the request.  Examples of client parameters include values that are used to construct a URI, or a file that needs to be uploaded to storage.

{% include requirement/MUST id="clang-params-client-validation" %} validate client parameters.

{% include requirement/MUSTNOT id="clang-params-server-validation" %} validate service parameters.  This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUST id="clang-params-check-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service.  If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

##### Functions with many parameters

Sometimes a function will take a large number of parameters, many of which have sane defaults.  In this case you should pass them via a struct. Default arguments should be represented by "zero". If the function is a method then the first parameter should still be a pointer to the object type the method is associated with.

For example the previous `az_widgets_client_init_with_sides` function could be defined instead as:

{% highlight c %}
typedef struct az_widgets_client_init_with_sides_options {
  int num_sides;
  az_widgets_side* sides;
  bool was_frobnicated;
} az_widgets_client_init_with_sides_options;
void az_widgets_client_init_with_sides(az_widgets_client* client, const az_widgets_client_init_with_sides_options* options);
{% endhighlight %}

and would be called from user code like:

{% highlight c %}
int main() {
  az_widgets_client client = { 0 };
  az_widgets_client_init_with_sides_options options = 
    az_widgets_client_init_with_sides_default_options();
  az_widgets_client_init_with_sides(&client, NULL);
}
{% endhighlight %}

Note that the `num_sides` and `sides` parameters are left as default.

If the `params` parameter is `NULL` then the `az_widgets_client_init_with_sides` function should assume the defaults for all parameters.

If a function takes both optional and non-optional parameters then prefer passing the non-optional ones as parameters and the optional ones by struct.

{% include requirement/MUST id="clang-objmodel-manyparams" %} use a struct to encapsulate parameters if the number of parameters is greater than 5.  

{% include requirement/MUSTNOT id="clang-objmodel-manyparams2" %} include the class object in the encapsulating parameter struct.

### Supporting Types

#### Serialization

Requests to the service fall into two basic groups - methods that make a single logical request, or a deterministic sequence of requests.  An example of a *single logical request* is a request that may be retried inside the operation.  An example of a *deterministic sequence of requests* is a paged operation.

The *logical entity* is a protocol neutral representation of a response. For HTTP, the logical entity may combine data from headers, body and the status line. A common example is exposing an ETag header as a property on the logical entity in addition to any deserialized content from the body.

{% include requirement/MUST id="clang-return-logical-entities" %} optimize for returning the logical entity for a given request. The logical entity MUST represent the information needed in the 99%+ case.

{% include requirement/MUST id="clang-return-expose-raw" %} *make it possible* for a developer to get access to the complete response, including the status line, headers and body. The client library MUST follow the language specific guidance for accomplishing this.

For example, you may choose to do something similar to the following:

{% highlight c %}
typedef struct az_json_short_item {
    // JSON decoded structure.
} az_json_short_item;

typedef struct az_json_short_paged_results {
    uint32 size;
    az_json_short_item *items;
} az_json_short_paged_results;


typedef struct az_json_short_raw_paged_results {
    http_headers *headers;
    uint16 status_code;
    uint8_t *raw_body;
    az_json_short_paged_results* results;
} az_json_short_raw_paged_results;

az_json_short_paged_results* az_json_get_short_list_items(client, /* extra params */);
az_json_short_raw_paged_results* az_json_get_short_list_items_with_response(client, /* extra params */);
{% endhighlight %}

{% include requirement/MUST id="clang-return-document-raw-stream" %} document and provide examples on how to access the raw and streamed response for a given request, where exposed by the client library.  We do not expect all methods to expose a streamed response.

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="clang-return-no-headers-if-confusing" %} return headers and other per-request metadata unless it is obvious as to which specific HTTP request the methods return value corresponds to.

{% include requirement/MUST id="clang-expose-data-for-composite-failures" %} provide enough information in failure cases for an application to take appropriate corrective action.

#### Enumeration-like Structures

> TODO: This section is not applicable for the Embedded C SDK.

## SDK Feature Implementation

### Configuration

> TODO: Add discussion on configuration environment variables to parallel that of other languages

### Logging

Client libraries must support robust logging mechanisms so that the consumer can adequately diagnose issues and quickly determine whether the issue is in the consumer code, client library code, or service.

In general, our advice to consumers of these libraries is to establish logging in their preferred manner at the `WARNING` level or above in production to capture problems with the application, and this level should be enough for customer support situations.  Informational or verbose logging can be enabled on a case-by-case basis to assist with issue resolution.

{% include requirement/MUST id="clang-logging-use-azurecore" %} use the Azure Core library for logging.

> TODO: The Azure Core logging library does not exist yet.

{% include requirement/MUST id="clang-logging-pluggable-logger" %} support pluggable log handlers.

{% include requirement/MUST id="clang-logging-console-logger" %} make it easy for a consumer to enable logging output to the console. The specific steps required to enable logging to the console must be documented. 

{% include requirement/MUST id="clang-logging-levels" %} use one of the following log levels when emitting logs: `Verbose` (details), `Informational` (things happened), `Warning` (might be a problem or not), and `Error`.

{% include requirement/MUST id="clang-logging-failure" %} use the `Error` logging level for failures that the application is unlikely to recover from (out of memory, etc.).

{% include requirement/MUST id="clang-logging-warning" %} use the `Warning` logging level when a function fails to perform its intended task. This generally means that the function will raise an exception.  Do not include occurrences of self-healing events (for example, when a request will be automatically retried).

{% include requirement/MAY id="clang-logging-slowlinks" %} log the request and response (see below) at the `Warning` when a request/response cycle (to the start of the response body) exceeds a service-defined threshold.  The threshold should be chosen to minimize false-positives and identify service issues.

{% include requirement/MUST id="clang-logging-info" %} use the `Informational` logging level when a function operates normally.

{% include requirement/MUST id="clang-logging-verbose" %} use the `Verbose` logging level for detailed troubleshooting scenarios. This is primarily intended for developers or system administrators to diagnose specific failures.

{% include requirement/MUSTNOT id="clang-logging-exclude" %} log payloads or HTTP header/query parameter values that aren't on the service provided allow list.  For header/query parameters not on the allow list use the value `<REDACTED>` in place of the real value.

{% include requirement/MUST id="clang-logging-requests" %} log request line and headers as an `Informational` message. The log should include the following information:

* The HTTP method.
* The URL.
* The query parameters (redacted if not in the allow-list).
* The request headers (redacted if not in the allow-list).
* An SDK provided request ID for correlation purposes.
* The number of times this request has been attempted.

{% include requirement/MUST id="clang-logging-responses" %} log response line and headers as an `Informational` message.  The format of the log should be the following:

* The SDK provided request ID (see above).
* The status code.
* Any message provided with the status code.
* The response headers (redacted if not in the allow-list).
* The time period between the first attempt of the request and the first byte of the body.

{% include requirement/MUST id="clang-logging-cancellations" %} log an `Informational` message if a service call is cancelled.  The log should include:

* The SDK provided request ID (see above).
* The reason for the cancellation (if available).

{% include requirement/MUST id="clang-logging-exceptions" %} log exceptions thrown as a `Warning` level message. If the log level set to `Verbose`, append stack trace information to the message.

### Distributed Tracing

> TODO: Implement the spirit of the general guidelines for distributed tracing.

> TODO: Distributed Tracing is explicitly removed?

### Telemetry

> TODO: Add details about how telemetry is not supported in the Embedded C SDK.

## Testing

We believe testing is a part of the development process, so we expect unit and integration tests to be a part of the source code.  All components must be covered by automated testing, and developers should strive to test corner cases and main flows for every use case.

All code should contain, at least, requirements, unit tests, end-to-end tests, and samples. The requirements description should be placed in the unit test file, on top of the test function that verifies the requirement. The unit test name should be placed in the code as a comment, together with the code that implements that functionality. For example:

_*API source code file:*_
{% highlight c %}
void foo_tcp_manager_destroy(TCP_HANDLE handle)
{
    if(handle == NULL)
    {
        /*[foo_tcp_manager_destroy_does_nothing_on_null_handle]*/
        LogError("handle cannot be NULL");
    }
    else
    {
        TCP_INSTANCE* instance = (TCP_INSTANCE*)handle;

        /*[foo_tcp_manager_destroy_succeed_on_free_all_resources]*/
        netif_remove(&(instance->lpc_netif));
        free(instance);
    }
}
{% endhighlight %}

_*Unit test file:*_
{% highlight c %}
/* If the provided TCP_HANDLE is NULL, the foo_tcp_manager_destroy shall do nothing. */
TEST_FUNCTION(foo_tcp_manager_destroy_does_nothing_on_null_handle)
{
    ///arrange

    ///act
    foo_tcp_manager_destroy(NULL);

    ///assert

    ///cleanup
}

/* The foo_tcp_manager_destroy shall free all resources allocated by the tcpip. */
TEST_FUNCTION(foo_tcp_manager_destroy_succeed_on_free_all_resources)
{
    ///arrange
    TCP_HANDLE handle = foo_tcp_manager_create();
    umock_c_reset_all_calls();
    STRICT_EXPECTED_CALL(netif_remove(IGNORED_PTR_ARG));
    STRICT_EXPECTED_CALL(free(handle));

    ///act
    foo_tcp_manager_destroy(handle);

    ///assert
    ASSERT_ARE_EQUAL(char_ptr, umock_c_get_expected_calls(), umock_c_get_actual_calls());

    ///cleanup
}
{% endhighlight %}

If a single unit test tests more than one requirement, it should be sequentially enumerated in the unit test file, and the same number should be added to the test name in the code comment. For example:

_*API source code file:*_
{% highlight c %}
    /*[foo_tcp_manager_create_createAndReturnInstanceSucceed_1]*/
    TCP_INSTANCE* instance = (TCP_INSTANCE*)malloc(sizeof(TCP_INSTANCE));
{% endhighlight %}

_*Unit test file:*_
{% highlight c %}
/*[1]The foo_tcp_manager_create shall create a new instance of the TCP_INSTANCE 
        and return it as TCP_HANDLE.*/
/*[2]The foo_tcp_manager_create shall initialize the tcpip thread.*/
/*[3]The foo_tcp_manager_create shall initialize the netif with default 
        gateway, ip address, and net mask by calling netif_add.*/
/*[4]The foo_tcp_manager_create shall set the netif defaults by calling 
        netif_set_default and netif_set_up.*/
/*[5]If dhcp is enabled, the foo_tcp_manager_create shall start it by calling dhcp_start.*/
TEST_FUNCTION(foo_tcp_manager_create_createAndReturnInstanceSucceed)
{
    ...
}
{% endhighlight %}

{% include requirement/MUSTNOT id="clang-testing-valgrind" %} have any memory leaks. Run samples and unit tests with [valgrind](https://www.valgrind.org/downloads/current.html). Unit tests and e2e tests are valgrind verified at the gate.

{% include requirement/MUST id="clang-testing-unittests" %} unit test your API with [ccputest](https://cpputest.github.io/), a unit testing and mocking framework for C and C++.

{% include requirement/MUST id="clang-testing-cmake-unit-tests" %} automatically run unit tests when building your client library; i.e. make unit tests part of your continuous integration (CI)

{% include requirement/MUST id="clang-testing-code-coverage" %} maintain a minimum 80% code coverage with unit tests.

## Tooling

We use a common build and test pipeline to provide for automatic distribution of client libraries.  To support this, we need common tooling.

{% include requirement/MUST id="clang-tooling-cmake" %} use [CMake](https://CMake.org/) v3.7 for your project build system. 

Version 3.7 is the minimum version installed on the Azure Pipelines Microsoft hosted agents 
(https://docs.microsoft.com/azure/devops/pipelines/agents/hosted)

{% include requirement/MUST id="clang-tooling-cmake-targets" %} include the following standard targets:

* `build` to build the library
* `test` to run the unit test suite
* `docs` to generate reference documentation
* `all` to run all three targets

Include other targets as they appear useful during the development process.

{% include requirement/SHOULD id="clang-tooling-minimize-variants" %} Minimize build variants.
In particular do not add build options that change the client library ABI or API.


> TODO: Should we advise using valgrind, cppcheck, or other analysis tools (static or dynamic)?

{% include requirement/MUST id="clang-tooling-cmake-settings1" %} use hidden visibility when building dynamic libraries. For CMake:

{% highlight cmake %}
set(CMAKE_C_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)
{% endhighlight %}

This allows you to use an export macro to export symbols. For example:

{% highlight c %}
#ifndef APPCONF_EXPORT_H
#define APPCONF_EXPORT_H

#ifdef APPCONF_STATIC_DEFINE
#  define APPCONF_EXPORT
#  define APPCONF_NO_EXPORT
#else
#  ifndef APPCONF_EXPORT
#    ifdef appconf_EXPORTS
        /* We are building this library */
#      define APPCONF_EXPORT __declspec(dllexport)
#    else
        /* We are using this library */
#      define APPCONF_EXPORT __declspec(dllimport)
#    endif
#  endif

#  ifndef APPCONF_NO_EXPORT
#    define APPCONF_NO_EXPORT 
#  endif
#endif

#ifndef APPCONF_DEPRECATED
#  define APPCONF_DEPRECATED __declspec(deprecated)
#endif

#ifndef APPCONF_DEPRECATED_EXPORT
#  define APPCONF_DEPRECATED_EXPORT APPCONF_EXPORT APPCONF_DEPRECATED
#endif

#ifndef APPCONF_DEPRECATED_NO_EXPORT
#  define APPCONF_DEPRECATED_NO_EXPORT APPCONF_NO_EXPORT APPCONF_DEPRECATED
#endif

#if 0 /* DEFINE_NO_DEPRECATED */
#  ifndef APPCONF_NO_DEPRECATED
#    define APPCONF_NO_DEPRECATED
#  endif
#endif

#endif /* APPCONF_EXPORT_H */
{% endhighlight %}

CMake will automatically generate an appropriate export header:

{% highlight cmake %}
include(GenerateExportHeader)
generate_export_header(appconf
    EXPORT_FILE_NAME az/appconf_export.h)
{% endhighlight %}

{% include requirement/MUST id="clang-tooling-clang-format" %} use [clang-format](https://clang.llvm.org/docs/ClangFormat.html) for formatting, with the following command-line options:

{% highlight bash %}
clang-format -style=file -i <file> ...
{% endhighlight %}

Using `-i` does an in-place edit of the files for style.  There is [a Visual Studio extension](https://marketplace.visualstudio.com/items?itemName=LLVMExtensions.llvm-toolchain) that binds Ctrl-R Ctrl-F to this operation. Visual Studio 2019 includes this functionality by default.

> TODO: Decide on exact formatting standards to use and include here.

{% include requirement/MUST id="clang-tooling-cmake-docs" %} generate API documentation with `doxygen`. 
For example in CMake:

{% highlight cmake %}
find_package(Doxygen REQUIRED doxygen)
set(DOXYGEN_GENERATE_HTML YES)
set(DOXYGEN_GENERATE_XML YES)
set(DOXYGEN_OPTIMIZE_OUTPUT_FOR_C YES)
set(DOXYGEN_EXTRACT_PACKAGE YES)
set(DOXYGEN_SIMPLE_STRUCTS YES)
set(DOXYGEN_TYPEDEF_HIDES_STRUCT NO)

doxygen_add_docs(doxygen
	${PROJECT_SOURCE_DIR}/inc
	${PROJECT_SOURCE_DIR}/src
	${PROJECT_SOURCE_DIR}/doc
	COMMENT "generate docs")
{% endhighlight %}

Notice that:
* We use `find_package()` to find doxygen
* We use the `DOXYGEN_<PREF>` CMake variables instead of writing your own `doxyfile`.
* We set `OPTIMIZE_OUTPUT_FOR_C` in order to get more C appropriate output.
* We use `doxygen_add_docs` to add the target, this will generate a `doxyfile` for you.

{% include requirement/MUST id="clang-tooling-cmake-samples" %} provide a CMake option of the form `<SDK_NAME>_BUILD_SAMPLES` that includes all samples in the build.  For example:

{% highlight cmake %}
if(AZURE_APPCONF_BUILD_SAMPLES)
    add_subdirectory(samples)
endif()
{% endhighlight %}

{% include requirement/MUSTNOT id="clang-tooling-cmake-no-samples-by-default" %} install samples by default.

## Formatting

{% include requirement/MUST id="clang-format-clang" %} use [clang-format](https://clang.llvm.org/docs/ClangFormat.html) for formatting your code. Use the common `clang-format` options from Engineering Systems.

In general, clang-format will format your code correctly and ensure consistency. However, these are few additional  rules to keep in mind.

{% include requirement/MUST id="clang-format-clang-loops" %} place all conditional or loop statements on one line, or add braces to identify the conditional/looping block.

{%highlight c %}
if (meow == 0) purr += 1; // OK
if (meow == 0) {
    purr += 1; // OK
}
if (meow == 0) { purr += 1; } // OK (although will probably be changed by clang-format)
if (meow == 0)
    purr += 1; // NOT OK
{% endhighlight %}

{% include requirement/MUST id="clang-format-clang-closing-braces" %} add comments to closing braces.  Adding a comment to closing braces can help when you are reading code because you don't have to find the begin brace to know what is going on.

{% highlight c %}
while (1) {
    if (valid) {
        ...
    } /* if valid */
    else {

    } /* not valid */
} /* end forever */
{% endhighlight %}

{% include requirement/MUST id="clang-format-clang-closing-endif" %} add comments to closing preprocessor directives to make them easier to understand.  For example:

{% highlight c %}
#if _BEGIN_CODE_

#ifndef _INTERNAL_CODE_

#endif /* _INTERNAL_CODE_ */

#endif /* _BEGIN_CODE_ */
{% endhighlight %}


{% include requirement/SHOULDNOT id="clang-format-clang-space-return" %} use parens in return statements when it isn't necessary.

{% include requirement/MUST id="clang-format-clang-no-yoda" %} place constants on the right of comparisons. For example `if (a == 0)` and not `if (0 == a)`

{% include requirement/MUST id="clang-format-clang-comment-fallthru" %} include a comment for falling through a non-empty `case` statement.  For example:

{% highlight c %}
switch (...) {
    case 1:
        do_something();
        break;
    case 2:
        do_something_else();
        /* fall through */
    case 3: 
        {
            int v;

            do_something_more(v);
        }
        break;
    default:
        log(LOG_DEBUG, "default case reached");
}
{% endhighlight %}

{% include requirement/SHOULDNOT id="clang-format-clang-no-goto" %} use `goto` statements.  The main place where `goto` statements can be usefully employed is to break out of several levels of `switch`, `for`, or `while` nesting, although the need to do such a thing may indicate that the inner constructs should be broken out into a separate function with a success/failure return code.  When a `goto` is necessary, the accompanying label should be alone on a line and to the left of the code that follows.  The `goto` should be commented as to its utility and purpose.

## Complexity Management

{% include requirement/SHOULD id="clang-init-all-vars" %} Initialize all variables. Only leave them
uninitialized if there is a real performance reason to do so. Use static and dynamic analysis tools to
check for uninitialized access. You may leave "result" variables uninitialized so long as they clearly do
not escape from the innermost lexical scope. 

{% include requirement/SHOULD id="clang-function-size" %} limit function bodies to one page of code (40 lines, approximately).

{% include requirement/MUST id="clang-document-null-bodies" %} document null statements.  Always document a null body for a `for` or `while` statement so that it is clear the null body is intentional.

{% include requirement/MUST id="clang-use-explicit-compares" %} use explicit comparisons when testing for failure.  Use `if (FAIL != f())` rather than `if (f())`, even though FAIL may have the value 0 which C considers to be false.  An explicit test will help you out later when somebody decides that a failure return should be -1 instead of 0.  

Explicit comparison should be used even if the comparison value will never change.  e.g. `if (!(bufsize % sizeof(int)))` should be written as `if (0 == (bufsize % sizeof(int))` to reflect the numeric (not boolean) nature of the test.  

A frequent trouble spot is using `strcmp` to test for string equality.  You should **never** use a default action.  The preferred approach is to use an inline function:

{% highlight c %}
inline bool string_equal(char *a, char *b) {
    return (0 == strcmp(a, b));
}
{% endhighlight %}

~ Should
{% include requirement/SHOULDNOT id="clang-embedded-assign" %} use embedded assignments.  There is a time and a place for embedded assignment statements.  In some constructs, there is no better way to accomplish the results without making the code bulkier and less readable.

{% highlight c %}
while (EOF != (c = getchar())) {
    /* process the character */
}
{% endhighlight %}

However, one should consider the tradeoff between increased speed and decreased maintainability that results when embedded assignments are used in artificial places.

## Memory management

{% include requirement/MUST id="clang-design-mm-allocation" %} let the caller allocate memory, then pass a pointer to it to the functions; e.g. `int az_iot_create_client(az_iot_client* client);`. 

The developer could then write code similar to:

{% highlight c %}
az_iot_client client; /* or allocate dynamically with malloc() if needed */

/* init client, if needed */
client.id = 0; 
client.name = NULL;

if (az_iot_create_client(*client) != 0)
{
    /* handle error */
}
{% endhighlight %}

{% include requirement/SHOULD id="clang-design-mm-allocation2" %} If you must allocate memory within the client library,
do so using user-overridable functions.

{% highlight c %}
/**
 * @brief   uLib malloc
 *
 *  Defines the malloc function that the ulib shall use as its own way to dynamically allocate
 *      memory from the HEAP. For simplicity, it can be defined as the malloc(size) from the `stdlib.h`.
 */
#define AZ_IOT_MALLOC(size)    malloc(size)

/**
 * @brief   uLib free
 *
 *  Defines the free function that the ulib shall use as its own way to release memory dynamic 
 *      allocated in the HEAP. For simplicity, it can be defined as the free(ptr) from the `stdlib.h`.
 */
#define AZ_IOT_FREE(ptr)       free(ptr)
{% endhighlight %}

> TODO: Should this be in azure core, or specific to a library?

## Secure functions

{% include requirement/SHOULDNOT id="clang-no-ms-secure-functions" %} use [Microsoft security enhanced versions of CRT functions](https://docs.microsoft.com/cpp/c-runtime-library/security-enhanced-versions-of-crt-functions) to implement APIs that need to be portable across many platforms. Such code is not portable and is not C99 compatible. Adding that code to your API will complicate the implementation with little to no gain from the security side. See [arguments against]( https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1967.htm). 

> TODO: Verify with the security team, and what are the alternatives?

## Miscellaneous

{% include requirement/MUSTNOT id="clang-test-implicit-assign" %} use implicit assignment inside a test.  This is generally an accidental omission of the second `=` of the logical compare. The following is confusing and prone to error.
    
{% highlight c %}
if (a = b) { ... }
{% endhighlight %}

Does the programmer really mean assignment here? Sometimes yes, but usually no. Instead use explicit tests and avoid assignment with an implicit test. The recommended form is to do the assignment before doing the test:

{% highlight c %}
a = b;
if (a) { ... } 
{% endhighlight %}

{% include requirement/MUST id="clang-no-register" %} use the register sparingly to indicate the variables that you think are most critical.  Modern compilers will put variables in registers automatically.  In extreme cases, mark the 2-4 most critical values as `register` and mark the rest as `REGISTER`. The latter can be `#defined` to register on those machines with many registers.

{% include requirement/MUST id="clang-be-const-correct" %} be `const` correct.  C provides the `const` keyword to allow passing as parameters objects that cannot change to indicate when a method doesn't modify its object. Using `const` in all the right places is called "const correctness." 

{% include requirement/MUST id="clang-use-hashif" %} use `#if` instead of `#ifdef`.  For example:

{% highlight c %}
// Bad example
#ifdef DEBUG
    temporary_debugger_break();
#endif
{% endhighlight %}

Someone else might compile the code with turned-of debug info like:

{% highlight c %}
cc -c lurker.cc -DDEBUG=0
{% endhighlight %}

Alway use `#if` if you have to use the preprocessor. This works fine, and does the right thing, even if `DEBUG` is not defined at all (!)

{% highlight c %}
// Good example
#if DEBUG
    temporary_debugger_break();
#endif
{% endhighlight %}

If you really need to test whether a symbol is defined or not, test it with the `defined()` construct, which allows you to add more things later to the conditional without editing text that's already in the program:

{% highlight c %}
#if !defined(USER_NAME)
 #define USER_NAME "john smith"
#endif
{% endhighlight %}

{% include requirement/MUST id="clang-large-comments" %}
Use `#if` to comment out large code blocks.

Sometimes large blocks of code need to be commented out for testing.  The easiest way to do this is with an `#if 0` block:

{% highlight c %}
void example()
{
    great looking code

    #if 0
      many lines  of code
    #endif

    more code
}
{% endhighlight %}

You can't use `/**/` style comments because comments can't contain comments and a large block of your code will probably contain connects.

Do not use `#if 0` directly.  Instead, use descriptive macro names:

{% highlight c %}
#if NOT_YET_IMPLEMENTED  
#if OBSOLETE
#if TEMP_DISABLED
{% endhighlight %}

Always add a short comment explaining why it is commented out.

{% include requirement/MUSTNOT id="clang-" %} put data definitions in header files.  For example, this should be avoided:

{% highlight c %}
/* aheader.h */
int x = 0;
{% endhighlight %}

It's bad magic to have space consuming code silently inserted through the innocent use of header files.  It's not common practice to define variables in the header file, so it will not occur to developers to look for this when there are problems.  Instead, define the variable once in a source file and then use an `extern` statement to reference it in the header file.

{% include requirement/MUSTNOT id="clang-no-magic-numbers" %} use magic numbers. A magic number is a bare naked number used in source code. It's magic because no-one will know what it means after a while.  This significantly reduces maintainability. For example:

{% highlight c %}
// Don't write this.
if      (22 == foo) { start_thermo_nuclear_war(); }
else if (19 == foo) { refund_lots_money(); }
else if (16 == foo) { infinite_loop(); }
else                { cry_cause_im_lost(); }
{% endhighlight %}

Instead of magic numbers, use a real name that means something. You can use `#define`, constants, or enums as names. For example:

{% highlight c %}
// These are good ideas.
#define   PRESIDENT_WENT_CRAZY  (22)
const int WE_GOOFED= 19;
enum  {
   THEY_DIDNT_PAY= 16
};

if      (PRESIDENT_WENT_CRAZY == foo) { start_thermo_nuclear_war(); }
else if (WE_GOOFED            == foo) { refund_lots_money(); }
else if (THEY_DIDNT_PAY       == foo) { infinite_loop(); }
else                                  { happy_days_i_know_why_im_here(); }
{% endhighlight %}

Prefer `enum` values since the debugger can display the label and value and no memory is allocated.  If you use `const`, memory is allocated.  If you use `#define`, the debugger cannot display the label.

{% include requirement/MUST id="clang-check-syscall-errors" %} check every system call for an error return, unless you know you wish to ignore errors. For example, `printf` returns an error code but it is rarely relevant. Cast the return to (void) if you do not care about the error code.

{% highlight c %}
(void)printf("The return type is ignored");
{% endhighlight %}
~

{% include requirement/MUST id="clang-include-errorstr" %} include the system error text when reporting system error messages.

{% include requirement/MUST id="clang-check-malloc" %} check every call to `malloc` or `realloc`. 

We recommend that you use a library-specific wrapper for memory allocation calls that always do the right thing.
