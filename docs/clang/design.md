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
az_keyvault_key *az_keyvault_keyclient_create_key(char *info)
{

}
```

```c
az_eventhub_eph_process_partition(az_eventhub_partition_info *partition_info)
{

}

void az_iot_credential_init(az_iot_credential *credential)
{
    
}

void az_iot_credential_deinit(az_iot_credential *credential)
{

}
{% endhighlight %}

{% include requirement/MUST id="general-namespaces-shortened-name" %} pick a shortened service name that allows the consumer to tie the package to the service being used.  As a default, use the compressed service name (that is, the service name with all spaces removed and lower-cased).  The namespace does **NOT** change when the branding of the product changes, so avoid the use of marketing names that may change.

{% include requirement/MUST id="clang-namespaces-prefix" %} prefix all exposed functions with `az_` and the short name of the service; i.e. `az_<svcname>_`.  When using objects (see the Object model later on), add the object name to the list (i.e. `az_<svcname>_<objname>_`).

{% include requirements/MUST id="clang-namespaces-register" %} register the short name of the client library with the [Architecture Board].

## Client interface

## Network requests

## Authentication

## Response formats

## Pagination

## Long running operations

## Support for non-HTTP protocols

## Memory management

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
