---
title: "C Guidelines: API Design"
keywords: guidelines clang
permalink: clang_design.html
folder: clang
sidebar: clang_sidebar
---

{% include draft.html content="The C Language guidelines are in DRAFT status" %}

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.  

## Namespaces

The C programming language does not have the concept of a namespace.  Instead, a common prefix is used for all structs, variables, and functions within the library.  This allows the developer to easily distinguish between specific libraries.  For example:

{% highlight c %}
az_keyvault_key *az_keyvault_keyclient_create_key(char *info);
az_eventhub_eph_process_partition(az_eventhub_partition_info *partition_info);
void az_iot_credential_init(az_iot_credential *credential);
void az_iot_credential_deinit(az_iot_credential *credential);
{% endhighlight %}

{% include requirement/MUST id="general-namespaces-shortened-name" %} pick a shortened service name that allows the consumer to tie the package to the service being used.  As a default, use the compressed service name (that is, the service name with all spaces removed and lower-cased).  The namespace does **NOT** change when the branding of the product changes, so avoid the use of marketing names that may change.

{% include requirement/MUST id="clang-namespaces-prefix" %} prefix all exposed functions with `az_` and the short name of the service; i.e. `az_<svcname>_`.  When using objects (see the Object model later on), add the object name to the list (i.e. `az_<svcname>_<objname>_`).

{% include requirements/MUST id="clang-namespaces-register" %} register the short name of the client library with the [Architecture Board].

## Client interface

In C, your API surface will consist of one or more _service client initializers_ that the consumer will call to define a connection to your service, plus a set of supporting functions that perform network requests.

{% include requirement/MUST id="clang-apisurface-serviceclientnaming" %} name the service client initializer `az_shortname_create_client()`.  It should return a type (generally a struct or struct pointer, but it could also be an integer orhandle that you deal with internally) or `NULL` on error.

{% include requirement/MUST id="clang-apisurface-serviceclientclosing" %} allow the consumer to release resources by calling `az_shortname_close_client()`.  This allows the library to manage memory on behalf of the user for the purposes of the client as well.

{% include requirement/MUST id="clang-apisurface-serviceclient-types" %} define a type `az_shortname_client` that represents the response from the service client initializer.

A typical definition might look like:

Header file:

{% highlight c %}
#ifndef KEYVAULT_CLIENT_H
#define KEYVAULT_CLIENT_H

typedef struct az_keyvault_client az_keyvault_client;
typedef struct az_keyvault_client_credentials az_keyvault_client_credentials;
typedef struct az_keyvault_http_handler_pipeline az_keyvault_http_handler_pipeline;

az_keyvault_client *az_keyvault_create_client();
void az_keyvault_close_client(az_keyvault_client *client);


/* C does not support overloading function names, so we use a different name */
az_keyvault_client *az_keyvault_create_client_with_credentials(az_keyvault_client_credentials *credentials);

/* Other functions related to kevault client */
int az_keyvault_client_backup_certificate_With_http_messages(char *vault_base_url, char *certificate_name, char **custom_headers, int headers_count);

/* client used to create other types */
az_keyvault_http_handler_pipeline *az_keyvault_client_create_http_handler_pipeline(az_http_client_handler *handler);
void az_keyvault_client_close_http_handler_pipeline(az_keyvault_http_handler_pipeline *handler_pipeline);

#endif /* IOT_CLIENT_API_H */
{% endhighlight %}

Source file:

{% highlight c %}
#include <stdbool.h> 
#include <stddef.h>
/* for az_http_client_handler*/
#include "http_client.h"
#include "keyvault_client.h"

typedef struct az_keyvault_client {
	char *accept_language;
	char *api_version;
	az_keyvault_client_credentials *credentials;
	bool generate_clientrequest_id;
	int long_running_operation_retry_timeout;
	char *vault_without_scheme;
} az_keyvault_client;

typedef struct az_keyvault_client_credentials {
	char *version;
	/* remaining struct members here */
} az_keyvault_client_credentials;

typedef struct az_keyvault_http_handler_pipeline {
	char *version;
	/* remaining struct members here */
} az_keyvault_http_handler_pipeline;

az_keyvault_client *az_keyvault_create_client() {
	/* implementation */
	return NULL;
}

void az_keyvault_close_client(az_keyvault_client *client)
{
	/* implementation */
}

az_keyvault_client *az_keyvault_create_client_with_credentials(az_keyvault_client_credentials *credentials) {
	/* implementation */
	return NULL;
}

int az_keyvault_client_backup_certificate_With_http_messages(char *vault_base_url, char *certificate_name, char **custom_headers, int headers_count)
{
	/* implementation */
	return 0;
}

az_keyvault_http_handler_pipeline* az_keyvault_client_create_http_handler_pipeline(az_http_client_handler *handler)
{
	/* implementation */
	return NULL;
}

void az_keyvault_client_close_http_handler_pipeline(az_keyvault_http_handler_pipeline *handler_pipeline)
{
	/* implementation */
}
{% endhighlight %}

> TODO:  Please note that in the previous examples, the memory model used is to have it allocated by the callee, rather than the caller. There are different options and this will be discussed further in a separate memory management section.

{% include requirement/MUST id="clang-apisurface-serviceclientconstructor" %} allow the consumer to construct a service client with the minimal information needed to connect and authenticate to the service.

{% include requirement/MUST id="clang-apisurface-standardized-verbs" %} standardize verb prefixes within a set of client libraries for a service.  The service must be able to speak about a specific operation in a cross-language manner within outbound materials (such as documentation, blogs, and public speaking). They cannot do this if the same operation is referred to by different verbs in different languages.  The following verbs are preferred for CRUD operations:

|Verb|Parameters|Returns|Comments|
|-|-|-|-|
| az\_\<shortname>\_\<objname>\__insert_\_\<noun>|key, item|Updated or created item|Create new item or update existing item. Verb is primarily used in database-like services |
| az\_\<shortname>\_\<objname>\__set_\_\<noun>|key, item|Updated or created item|Create new item or update existing item. Verb is primarily used for dictionary-like properties of a service |
| az\_\<shortname>\_\<objname>\__create_\_\<noun>|key, item|Created item|Create new item. Fails if item already exists. |
| az\_\<shortname>\_\<objname>\__update_\_\<noun>|key, partial item|Updated item|Fails if item does not exist. |
| az\_\<shortname>\_\<objname>\__replace_\_\<noun>|key, item|Replace existing item|Completely replaces an existing item. Fails if the item does not exist. |
| az\_\<shortname>\_\<objname>\__delete_\_\<noun>|key|None|Delete an existing item. Will succeed even if item did not exist. |
| az\_\<shortname>\_\<objname>\__append_\_\<noun>|item|Appended item|Add item to a collection. Item will be added last. |
| az\_\<shortname>\_\<objname>\__add_\_\<noun>|index, item|Added item|Add item to a collection. Item will be added on the given position. |
| az\_\<shortname>\_\<objname>\__remove_\_\<noun>|key|None or removed item|Remove item from a collection. |
| az\_\<shortname>\_\<objname>\__get_\_\<noun>|key|Item|Will return None if item does not exist |
| az\_\<shortname>\_\<objname>\__list_\_\<noun>||array of items|Return list of items. Returns empty list if no items exist |
| az\_\<shortname>\_\<objname>\__exists_\_\<noun>|key|boolean|Return True if the item exists. |

Some examples:

{% highlight c %}
void az_keyvault_client_delete_key(az_keyvault_client *client, char *vault_base_url, char *key_name);
void az_keyvault_client_delete_key_async(az_keyvault_client *client, char *vault_base_url, char *key_name, az_keyvault_callback *callback, void *callback_context);

az_keyvault_certificate_bundle *az_keyvault_client_get_certificate(az_keyvault_client *client, char *certtificate_id);
void az_keyvault_client_get_certificate_async(az_keyvault_client *client, char *certtificate_id, az_keyvault_callback *callback, void *callback_context);

bool az_keyvault_client_exists_key(az_keyvault_client *client, char *key_name);
{% endhighlight %}

{% include requirement/MUST id="clang-apisurface-lro-initiation" %} use `az_<shortname>_<objname>_begin_<verb>_<noun>` for methods that initiate a long running operation.  For example: `az_storage_blob_begin_copy_from_url()`.

{% include requirement/MUST id="clang-apisurface-supportallfeatures" %} support as close as possible to 100% of the commonly used features provided by the Azure service the client library represents.  Unlike more general purpose object-orientated languages, the scenarios that need to be supported in C are more limited.

### Network requests

Since the client library clangly wraps one or more HTTP requests, it is important to support standard network capabilities.  Asynchronous programming techniques are not widely understood and the low level nature of C provides an indication that consumers may want to manage threads themselves.  Many developers prefer synchronous method calls for their easy semantics when learning how to use a technology.  

{% include requirement/MUST id="clang-apisurface-be-thread-safe" %} be thread-safe.  Individual requests to the service must be able to be placed on separate threads without unintentional problems.

{% include requirement/MUST id="clang-apisurface-syncandasync" %} support both synchronous and asynchronous functions, utilizing `libuv` for async support.  

{% include requirement/MUST id="clang-apisurface-identifyasync" %} ensure that the consumer can easily identify which functions are async and which are synchronous.

When an application makes a network request, the network infrastructure (like routers) and the called service may take a long time to respond and, in fact, may never respond. A well-written application SHOULD NEVER give up its control to the network infrastucture or service. 

{% include requirement/MUST id="clang-apisurface-supportcancellation" %} accept a timeout in milliseconds for each network request.  

{% include requirement/MUSTNOT id="clang-apisurface-no-leaking-implementation" %} leak the underlying protocol transport implementation details to the consumer.  All types from the protocol transport implementation must be appropriately abstracted.

### Authentication

Azure services use a variety of different authentication schemes to allow clients to access the service. Conceptually, there are two entities responsible in this process: a credential and an authentication policy.  Credentials provide confidential authentication data.  Authentication policies use the data provided by a credential to authenticate requests to the service.  

{% include requirement/MUST id="clang-apisurface-support-all-auth-techniques" %} support all authentication techniques that the service supports and are available to a client application (as opposed to service side).  C is used only for client applications when talking to Azure, so some authentication techniques may not be valid.

{% include requirement/MUST id="clang-apisurface-use-azure-core" %} use credential and authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="clang-apisurface-prefer-token-auth" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service in a non-blocking atomic manner for each authentication scheme that does not have an implementation in Azure Core.

{% include requirement/MUST id="clang-apisurface-auth-in-constructors" %} provide service client constructors or factories that accept any supported authentication credentials.

Client libraries may support providing credential data via a connection string __ONLY IF__ the service provides a connection string to users via the portal or other tooling. 

{% include requirement/MUSTNOT id="clang-apisurface-no-connection-strings" %} support constructing a service client with a connection string unless such connection string is available within tooling (for copy/paste operations).

## Response formats

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
    HTTP_HEADERS *headers;
    uint16 status_code;
    byte *raw_body;
    az_json_short_paged_results* results;
} az_json_short_raw_paged_results;

az_json_short_paged_results* az_json_get_short_list_items(client, /* extra params */);
az_json_short_raw_paged_results* az_json_get_short_list_items_with_response(client, /* extra params */);
{% endhighlight %}

{% include requirement/MUST id="clang-return-document-raw-stream" %} document and provide examples on how to access the raw and streamed response for a given request, where exposed by the client library.  We do not expect all methods to expose a streamed response.

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="clang-return-no-headers-if-confusing" %} return headers and other per-request metadata unless it is obvious as to which specific HTTP request the methods return value corresponds to.

{% include requirement/MUST id="clang-expose-data-for-composite-failures" %} provide enough information in failure cases for an application to take appropriate corrective action.

## Pagination

Although object-orientated languages can eschew low-level pagination APIs in favor of high-level abstractions, C acts as a lower level language and thus embraces pagination APIs provided by the service.  You should work within the confines of the paging system provided by the service.

{% include requirement/MUST id="clang-pagination-use-paging" %} export the same paging API as the service provides.

{% include requirement/MUST id="clang-last-page" %} indicate in the return type if the consumer has reached the end of the result set.

{% include requirement/MUST id="clang-size-of-page" %} indicate in the return type how many items were returned by the service, and have a list of those items for the consumer to iterate over.

## Long running operations

> TODO: Implement general guidelines for LRO

## Support for non-HTTP protocols

> TODO: Implement gneral guidelines for non-HTTP protocols

## Memory management

> TODO: Discuss memory management from an API design perspective.  This may be covered in the object model below somewhat, but I think an expansive discussion of how we think about memory management is in order.

## Object model

C doesn't have object oriented programming built in, but most programs end up implementing some kind of ad-hoc object model. 

Let's consider the object used to represent a herd of cats in the fictional Azure Catherding client library. Such a structure could be defined like this:

{% highlight c %}
typedef struct az_catherding_herd {
  uint16_t num_cats;
  az_catherding_cat* cats;
  bool is_indoor;
} az_catherding_herd;
{% endhighlight %}

If you are defining an opaque type then the definition is placed in a `.c` file and the header file contains the following:

{% highlight c %}
typedef struct az_catherding_herd az_catherding_herd;
{% endhighlight %}

If you need to expose the type (for stack allocation), but would like to make it clear that some fields are private and should not be modified, place the type in the header file as follows::

{% highlight c %}
typedef struct az_catherding_herd {
  struct {
    uint16_t num_cats;
    az_catherding_cat* cats;
    bool is_indoor;
  } internal;
} az_catherding_herd;
{% endhighlight %}

{% include requirement/MUSTNOT id="clang-objmodel-nohiding" %} hide the members of a struct that supports stack allocation.  This can result in alignment problems and missed optimization opportunities.

### Initialization and destruction

You must always have an initialization function. This function will take a block of allocated memory of the correct size and alignment and turn it into a valid object instance, setting fields to default values and processing initialization parameters. 

{% include requirement/MUST id="clang-objmodel-init" %} name initialization functions with the form `az_<libname>_init_...`.

{% include requirement/MUST id="clang-objmodel-ready" %} ensure that the object is "ready to use" after a call to the init function for the object.

If there is more than one way to initialize an object, you should define multiple initialization functions with different names. For example:

{% highlight c %}
void az_catherding_herd_init(az_catherding_herd* herd);
void az_catherding_herd_init_with_cats(az_catherding_herd* herd, int num_cats, az_catherding_cats* cats);
{% endhighlight %}

If initialization could fail (for example, during parameter validation), ensure the init function returns an `az_error` to indicate error conditions.

A possible implementation of these initialization functions would be:

{% highlight c %}
void az_catherding_herd_init(az_catherding_herd* herd) {
  memset(herd, 0, sizeof(az_catherding_herd));
}


void az_catherding_herd_init_with_cats(az_catherding_herd* herd,
				       int num_cats, az_catherding_cats* cats) {
  az_catherding_herd_init(herd);
  herd->cats = cats;
  herd->num_cats = num_cats;
}
{% endhighlight %}

Similarly to allocation, a type can have a destruction function. However only types that own a resource (such as memory), or require special cleanup (like securely zeroing their memory) need a destruction function.

{% include requirement/SHOULD id="clang-objmodel-prefer-nonalloc" %} prefer non-allocating types and methods.

### Allocation and deallocation

Your library should not allocate memory if possible.  It should be possible to use the client library without any allocations, deferring all allocations to the client program.

Allocation should be separated from initialization, unless there's an extremely good reason to tie them together. In general we want to let the user allocate their own memory. You only need an allocation function if you intend to hide the size and alignment of the object from the user.

{% include requirement/MUST id="clang-objmodel-alloc1" %} name the allocation and deallocation functions as `az_<libname>_(de)allocate_<objtype>`.

Note that this is the opposite of the pattern for other methods.  Allocation functions do not operate on a value of `<objtype>`.  Rather they create and destroy such values.

{% include requirement/MUST id="clang-objmodel-alloc2" %} provide an allocation and deallocation function for opaque types.

{% include requirement/SHOULD id="clang-objmodel-alloc3" %} take a set of allocation callbacks as a parameter to the allocation and deallocation functions for an opaque type.  Use the library default allocation functions if the allocation callback parameter is NULL.

{% include requirement/SHOULDNOT id="clang-objmodel-alloc4" %} store a pointer to the allocation callbacks inside the memory returned by the allocation function.  You may store such a pointer for debugging purposes.

The intent is to allow storing a pointed tot he allocation callbacks to ensure the same set of callbacks is used for allocation and deallocation.  However, it is not allowed to change the ABI of the returned object to do this.  You need to store the callbacks before or after the pointer returned to the called.

> TODO: Rationalize this - do we store or not store?

{% include requirement/MUSTNOT id="clang-objmodel-alloc5 %} return any errors from the deallocation function.  It is impossible to write leak-free programs if deallocation and cleanup functions can fail.

For example:

{% highlight c %}
#include <stdint.h>
typedef struct az_catherding_herd az_catherding_herd;

az_error az_catherding_allocate_herd(az_catherding_herd** herd, az_allocation_callbacks* alloc);
void az_catherding_deallocate_herd(az_catherding_herd* herd, az_allocation_callbacks* alloc);
{% endhighlight %}

{% highlight c %}
#include "herd.h"
typedef struct az_catherding_herd {
  uint16_t num_cats;
  az_catherding_cat* cats;
  bool is_indoor;
} az_catherding_herd;


az_error az_catherding_allocate_herd(az_catherding_herd** herd, az_allocation_callbacks* alloc) {
if(!alloc) {
    *herd = az_default_alloc(sizeof(az_catherding_herd));
} else {
    *herd = alloc->allocate(sizeof(az_catherding_herd));
}
if(!*herd) {
    return AZ_ERROR_ALLOCATION_ERROR;
}
return AZ_SUCCESS;
}

void az_catherding_deallocate_herd(az_catherding_herd* herd, az_allocation_callbacks* alloc) {
if(!alloc) {
    az_default_deallocate(herd);
} else {
    alloc->deallocate(herd);
}
}
{% endhighlight %}

### Initialization for objects that allocate

The initialization function should take a set of allocation callbacks and store them inside the object instance.  

{% include requirement/MUST id="clang-objmodel-initalloc1" %} take a set of allocation / deallocation callbacks in the `init` function of objects owning inner pointers.

{% include requirement/SHOULDNOT id="clang-objmodel-initalloc2" %} allocate different inner pointers with different sets of allocation callbacks.  Use a single allocation callback.

### Destruction for objects that allocate

{% include requirement/MUST id="clang-objmodel-destroyalloc1" %} name destruction functions `az_<libname>_<objtype>_destroy`.

{% include reuqirement/MUSTNOT id="clang-objmodel-destroyalloc2" %} take allocation callbacks in the destruction function.

The reason one would take an allocation callback parameter in the destruction function is to save space by not storing it in the object instance. The reason we prohibit this is that it means an object that owns a pointer to another object must then take _two_ allocation parameters in its destroy function. 

{% include requirement/MUSTNOT id="clang-objmodel-destroyalloc3" %} return any errors in the destruction function.  It's impossible to write leak-free programs if deallocation / cleanup functions can fail.

The destruction function should follow this pattern:

{% highlight c %}
void az_catherding_herd_destroy(az_catherding_herd* herd);
{% endhighlight %}

The following is a possible implementation of a destruction function for the cat herding object:

{% highlight c %}
void az_catherding_herd_destroy(az_catherding_herd* herd) {
if(herd->alloc) {
    herd->alloc->deallocate(cats);
}
az_string_destroy(herd->str);
herd->num_cats = 0;
herd->alloc = 0;
}
{% endhighlight %}

### Methods on objects

To define a method on an object simply define a function taking a pointer to that object as its first parameter. For example:

{% highlight c %}
/**
 * @brief add a cat to the herd
 * @memberof az_catherding_herd
 *
 * @param[in] herd - the herd
 * @param[in] __[transfer none]__ cat - the cat to add
 * @return Any errors
 * @retval AZ_SUCCESS on success
 * @retval AZ_ERROR_NO_MEMORY if a reallocation of the internal
 *                            array failed
 */
az_error az_catherding_herd_add_cat(az_catherding_herd* herd, cat* cat);
{% endhighlight %}

{% include requirement/MUST id="clang-objmodel-memberof" %} use `@memberof` to indicate a function is associated with a class.

{% include requirement/MUST id="clang-objmodel-firstparam" %} provide the class object as the first parameter to a function associated with the class.

### Functions with many parameters

Sometimes a function will take a large number of parameters, many of which have sane defaults.  In this case you should pass them via a struct. Default arguments should be represented by "zero". If the function is a method then the first parameter should still be a pointer to the object type the method is associated with.

For example the previous `az_catherding_herd_init_with_cats` function could be better defined instead as:

{% highlight c %}
typedef struct az_catherding_herd_init_with_cats_params {
  int num_cats;
  az_catherding_cats* cats;
  bool is_indoor;
} az_catherding_herd_init_with_cats_params;
void az_catherding_herd_init_with_params(az_catherding_herd* herd, const az_catherding_herd_init_with_cats_params* params);
{% endhighlight %}

and would be called from user code like:

{% highlight c %}
int main() {
  az_catherding_herd herd;
  az_catherding_herd_init_with_params(&herd, &(az_catherding_herd_init_with_cats_params){
    .is_indoor = true
  });
}
{% endhighlight %}

Note that the `num_cats` and `cats` parameters are left as default.

If the `params` parameter is `NULL` then the `az_catherding_init_with_params` function should assume the defaults for all parameters.

If a function takes both optional and non-optional parameters then prefer passing the non-optional ones as parameters and the optional ones by struct.

{% include requirement/MUST id="clang-objmodel-manyparams" %} use a struct to encapsulate parameters if the number of parameters is greater than 5.  

{% include reuqirement/MUSTNOT id="clang-objmodel-manyparams2" %} include the class object in the encapsulating paramter struct.

### Methods requiring allocation

If a method could require allocating memory then it should use the most relevant set of allocation callbacks. For example the `az_catherding_herd_add_cat` method may need to allocate or re-allocate the array of cats.  It should use the `az_catherding_herd` allocators.  On the other hand the method:

{% highlight c %}
void az_catherding_herd_set_str(az_catherding_herd* herd, const char* str);
{% endhighlight %}

would likely use the allocation callbacks inside the `herd->str` structure.

> TODO: Rationalize advice here.  Earlier, we said don't include allocators inside the structure.

### Callbacks

Callback functions should be defined to take a pointer to the "sender" object as the first argument and a void pointer to user data as the last argument. Any additional arguments, if any, should be contextual data needed by the callback. For example say we had an object `az_catherding_client` that could make requests to be handled in a callback and we represent the response as an object `az_response`. We might define the following:

{% highlight c %}
typedef bool (*az_catherding_response_callback)(az_catherding_client* client,
						az_response* resp,
						void* user_data);
void az_catherding_client_set_response_callback(az_catherding_client* client,
						az_catherding_response_callback callback,
						void* user_data);
{% endhighlight %}

Client code would use this in the following manner:

{% highlight c %}
typedef struct user_data {
  int some_int;
} user_data;


bool handle_resp(az_catherding_client* client,
		 az_response* resp,
		 void* user) {
  user_data* data = user;
  /* do things with parameters */
  return true;
}

int main() {
  user_data d = {.some_int = 5};
  az_catherding_client client;
  az_catherding_client_init(&client);
  az_catherding_client_set_response_callback(&client, &handle_resp, &d);
  /* do something that triggers the callback */

  /* unset the callback if we don't want to handle it anymore */
  az_catherding_client_set_response_callback(&client, NULL, NULL);
}
{% endhighlight %}

{% include requirement/MUST id="clang-objmodel-callback-userdata" %} include a `user_data` parameter on all callbacks.

{% include requirement/MUSTNOT id="clang-objmodel-callback-deref" %} de-reference the user data pointer from inside the library.

### Discriminated Unions

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

## Versioning
