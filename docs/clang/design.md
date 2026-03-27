---
title: "Embedded C Azure SDK Design Guidelines"
keywords: guidelines clang
permalink: clang_design.html
folder: clang
sidebar: general_sidebar
---

{% include draft.html content="The C Language guidelines are in DRAFT status" %}

## Introduction

The C guidelines are for the benefit of client library designers targeting service applications written in C, primarily IoT devices.  You do not have to write a client library for C if your service is not normally accessed from IoT devices.

### Design principles

The Azure SDK should be designed to enhance the productivity of developers connecting to Azure services. Other qualities (such as completeness, extensibility, and performance) are important but secondary. Productivity is achieved by adhering to the principles described below:

#### Idiomatic

* The SDK should follow the general design guidelines and conventions for the target language. It should feel natural to a developer in the target language.
* We embrace the ecosystem with its strengths and its flaws.
* We work with the ecosystem to improve it for all developers.

#### Consistent

* Client libraries should be consistent within the language, consistent with the service and consistent between all target languages. In cases of conflict, consistency within the language is the highest priority and consistency between all target languages is the lowest priority.
* Service-agnostic concepts such as logging, HTTP communication, and error handling should be consistent. The developer should not have to relearn service-agnostic concepts as they move between client libraries.
* Consistency of terminology between the client library and the service is a good thing that aids in diagnosability.
* All differences between the service and client library must have a good (articulated) reason for existing, rooted in idiomatic usage rather than whim.
* The Azure SDK for each target language feels like a single product developed by a single team.
* There should be feature parity across target languages. This is more important than feature parity with the service.

#### Approachable

* We are experts in the supported technologies so our customers, the developers, don't have to be.
* Developers should find great documentation (hero tutorial, how to articles, samples, and API documentation) that makes it easy to be successful with the Azure service.
* Getting off the ground should be easy through the use of predictable defaults that implement best practices. Think about progressive concept disclosure.
* The SDK should be easily acquired through the most normal mechanisms in the target language and ecosystem.
* Developers can be overwhelmed when learning new service concepts. The core use cases should be discoverable.

#### Diagnosable

* The developer should be able to understand what is going on.
* It should be discoverable when and under what circumstances a network call is made.
* Defaults are discoverable and their intent is clear.
* Logging, tracing, and exception handling are fundamental and should be thoughtful.
* Error messages should be concise, correlated with the service, actionable, and human readable. Ideally, the error message should lead the consumer to a useful action that they can take.
* Integrating with the preferred debugger for the target language should be easy.

#### Dependable

* Breaking changes are more harmful to a user's experience than most new features and improvements are beneficial.
* Incompatibilities should never be introduced deliberately without thorough review and very strong justification.
* Do not rely on dependencies that can force our hand on compatibility.

### General Guidelines

{% include requirement/MUST id="clang-general-follow-general-guidelines" %} follow the [General Azure SDK Guidelines].

{% include requirement/MUST id="clang-general-repository" %} locate all source code in the [azure/azure-sdk-for-c] GitHub repository.

{% include requirement/MUST id="clang-general-engsys" %} follow Azure SDK engineering systems guidelines for working in the [azure/azure-sdk-for-c] GitHub repository.

### Support for non-HTTP Protocols

This document contains guidelines developed primarily for typical Azure REST services, i.e. stateless services with request-response based interaction model. Many of the guidelines in this document are more broadly applicable, but some might be specific to such REST services.

> TODO: Implement general guidelines for non-HTTP protocols and discuss MQTT.

## Azure SDK API Design

Azure services will be exposed to Embedded C developers as one or more _service client_ types and a set of _supporting types_. The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.

### Supported platforms

{% include requirement/MUST id="clang-c99" %} implement the client library in [C99](https://en.wikipedia.org/wiki/C99) to ensure maximum portability of your code. While MSVC supports most C99 features, it is not fully compatible with C99 yet.  If using MSVC (or if Windows is required), ensure you avoid non-supported C99 features in MSVC.

> TODO: Provide a link to non-supported C99 features in MSVC

{% include requirement/SHOULD id="clang-platform" %} support the following platforms and associated compilers when implementing your client library.

| Operating System    | Architecture | Compiler Version                        |
|---------------------|:------------:|:----------------------------------------|
| Ubuntu 16.04 (LTS)  | x64          | gcc-5.4.0                               |
| Ubuntu 18.04 (LTS)  | x86          | gcc-7.3                                 |
| Ubuntu 18.04 (LTS)  | x64          | Clang 6.0.x                             |
| OSX 10.13.4         | x64          | XCode 9.4.1                             |
| Windows Server 2016 | x86          | MSVC 14.16.x                            |
| Windows Server 2016 | x64          | MSVC 14.16.x                            |
| Windows Server 2016 | x64          | MSVC 14.23.x                            |
| Windows Server 2016 | x86,x64      | MSVC 14.23.x                            |
| Debian 9 Stretch    | x64          | gcc-7.x                                 |

> TODO: This is based on versions supported by the Azure IoT SDK for C.  Additional investigation is needed to ensure it is up to date.  We need to make sure the version supported is the latest long term servicing with wide adoption available for each platform.  Suggested additions: RHEL 8 (gcc 8.2.1) and Fedora (30 with gcc 9.1.1) + Alpine.  Windows Server 2016 includes Windows 8 - should we switch?

> TODO: provide any common flags to be used with each compiler.

{% include requirement/SHOULDNOT id="clang-cpp-extensions" %} use compiler extensions.  Examples of extensions to avoid include:

* [MSVC compiler extensions](https://docs.microsoft.com/cpp/build/reference/microsoft-extensions-to-c-and-cpp)
* [Clang language extensions](https://clang.llvm.org/docs/LanguageExtensions.html)
* [GNU C compiler extensions](https://gcc.gnu.org/extensions.html)

Use the appropriate options for each compiler to prevent the use of such extensions.

{% include requirement/MUST id="clang-cpp-options" %} use compiler flags to identify warnings:

| Compiler                 | Compiler Flags   |
|:-------------------------|------------------|
| gcc                      | `-Wall -Wextra`  |
| Clang and XCode          | `-Wall -Wextra`   |
| MSVC                     | `/W4`            |

hen configuring your client library, particular care must be taken to ensure that the consumer of your client library can properly configure the connectivity to your Azure service both globally (along with other client libraries the consumer is using) and specifically with your client library.

### The Service Client

In C, your API surface will consist of one or more _service client initializers_ that the consumer will call to define a connection to your service, plus a set of supporting functions that perform network requests.

{% include requirement/MUST id="clang-apisurface-serviceclientnaming" %} the signature of the
 service client initializer should be 
 `AZ_NODISCARD az_result az_shortname_client_init(az_shortname_client*, <args>)`.
 The function may assume that storage has been allocated, and the first parameter points to
 allocated (but not nessassarly initialized) storage.

{% include requirement/MUST id="clang-apisurface-serviceclientclosing" %} allow the consumer to release resources by calling `void az_shortname_client_destroy(az_shortname_client*)`.  This allows the library to manage memory on behalf of the user for the purposes of the client as well.

{% include requirement/MUST id="clang-apisurface-serviceclient-types" %} define a type `az_shortname_client` that represents the response from the service client initializer.

A typical definition might look like:

Header file:

{% highlight c %}
#ifndef KEYVAULT_CLIENT_H
#define KEYVAULT_CLIENT_H

typedef struct az_keyvault_client az_keyvault_client;
typedef struct az_keyvault_client_credentials az_keyvault_client_credentials;
typedef struct az_keyvault_http_handler_pipeline az_keyvault_http_handler_pipeline;

AZ_NODISCARD az_result az_keyvault_client_init(az_keyvault_client* self);
void az_keyvault_client_destroy(az_keyvault_client *client);


/* C does not support overloading function names, so we use a different name */
AZ_NODISCARD az_result *az_keyvault_client_init_with_credentials(az_keyvault_client* self, 
  az_keyvault_client_credentials *credentials);

/* Other functions related to kevault client */
AZ_NODISCARD az_result az_keyvault_client_backup_certificate_with_http_messages(az_keyvault_client* self, 
  char *vault_base_url, char *certificate_name, char **custom_headers, int headers_count);

/* client used to create other types */
AZ_NODISCARD az_result az_keyvault_client_init_http_handler_pipeline(az_keyvault_client* self, 
  az_http_client_handler *handler, az_keyvault_http_handler_pipeline* pipeline);
void az_keyvault_client_destroy_http_handler_pipeline(az_keyvault_client* self, 
  az_keyvault_http_handler_pipeline *handler_pipeline);

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

void az_keyvault_client_destroy(az_keyvault_client *client)
{
	/* implementation */
}

az_result az_keyvault_create_client_with_credentials(az_keyvault_client* client, 
  az_keyvault_client_credentials *credentials) {
  *client = {0};
	/* implementation */
	return AZ_OK;
}

az_result az_keyvault_client_backup_certificate_with_http_messages(az_keyvault_client* client, 
  char *vault_base_url, char *certificate_name, char **custom_headers, int headers_count)
{
	/* implementation */
	return AZ_OK;
}

az_result az_keyvault_client_init_http_handler_pipeline(az_keyvault_client* self, 
  az_http_client_handler *handler, az_keyvault_http_handler_pipeline* pipeline);
{
	/* implementation */
	return AZ_OK;
}

void az_keyvault_client_destroy_http_handler_pipeline(az_keyvault_client* self, 
  az_keyvault_http_handler_pipeline *handler_pipeline);
{
	/* implementation */
}
{% endhighlight %}

{% include requirement/MUST id="clang-apisurface-serviceclientconstructor" %} allow the consumer to construct a service client with the minimal information needed to connect and authenticate to the service.

{% include requirement/MUST id="clang-apisurface-standardized-verbs" %} standardize verb prefixes within a set of client libraries for a service.  The service must be able to speak about a specific operation in a cross-language manner within outbound materials (such as documentation, blogs, and public speaking). They cannot do this if the same operation is referred to by different verbs in different languages.  The following verbs are preferred for CRUD operations:

> __Note__: The `prefix` in below table is `az_<shortname>_<objname>`

<!-- The table data is in yaml format on _data/tables/clang_standard_verbs -->
{% assign data = site.data.tables.clang_standard_verbs.entries %}
{% include tables/standard_verbs_template.html %}

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

#### Service Client Constructors

##### Client Configuration

{% include requirement/MUST id="clang-config-global-config" %} use relevant global configuration settings either by default or when explicitly requested to by the user.

{% include requirement/SHOULD id="clang-config-global-config-howto" %} Use an "options" structure
to allow user specified configuration, in particular when there are many configuration options
for one client constructor.

For example,

```c
typedef struct az_widgets_client_options {
    uint32_t num_sides;
    bool was_frobnicated;
} az_widgets_client_options;

AZ_NODISCARD az_widgets_client_options az_widgets_client_default_options(void);

AZ_NODISCARD az_result az_widgets_client_init(az_widgets_client* self, const az_widgets_default_client_options* options);
```

The user can request the default with:

```c
az_widgets_client client = {0};
az_result res = az_widgets_client_init(&client, NULL);
```
or specify their own options with:
```c
az_widgets_client client = {0};
az_widgets_client_options options = az_widgets_client_default_options();
options.num_sides = 4;
az_result res = az_widgets_client_init(&client, &options);
```

{% include requirement/MUST id="clang-config-for-different-clients" %} allow different clients of the same type to use different configurations.

{% include requirement/MUST id="clang-config-optout" %} allow consumers of your service clients to opt out of all global configuration settings at once.

{% include requirement/MUST id="clang-config-global-overrides" %} allow all global configuration settings to be overridden by client-provided options. The names of these options should align with any user-facing global configuration keys.

{% include requirement/MUST id="clang-config-defaults-consistent" %} Have consistent defaults across
all supported systems and build configurations. This means changing settings such as
default buffer sizes based on the target platform or build settings is prohibited.

For example, consider the structure:
```c
typedef struct az_widgets_widget {
    int num_sides;
    uint8_t side_buffer[AZ_WIDGETS_SIDE_BUFFER_SIZE];
} az_widgets_widget;
```

This is OK:

```cmake
...
set(AZ_WIDGETS_SIDE_BUFFER_SIZE 1024 CACHE STRING "default size of side buffer")
target_compile_definitions(az_widgets PUBLIC AZ_WIDGETS_SIDE_BUFFER_SIZE=${AZ_WIDGETS_SIDE_BUFFER_SIZE})
```

This is not OK:

```cmake
if(TARGETING_DESKTOP)
    set(AZ_WIDGETS_SIDE_BUFFER_SIZE 4096 CACHE STRING "default size of side buffer")
else()
    set(AZ_WIDGETS_SIDE_BUFFER_SIZE 1024 CACHE STRING "default size of side buffer")
endif()
target_compile_definitions(az_widgets PUBLIC CAT_BUFFER_SIZE=${AZ_WIDGETS_SIDE_BUFFER_SIZE})
```

{% include requirement/MUSTNOT id="clang-config-defaults-nochange" %} Change the default values of client configuration options based on runtime system or client state.

{% include requirement/MUSTNOT id="clang-config-defaults-nobuildchange" %} Change default values of
client configuration options based on how the client library was built.

{% include requirement/MUSTNOT id="clang-config-noruntime" %} use client library specific runtime 
configuration such as environment variables or a config file. Keep in mind that many IoT devices
won't have a filesystem or an "environment block" to read from.

##### Setting the Service Version

> TODO: The Embedded C library does not allow configuring the service version.

##### Sync and Async

> TODO: The Embedded C library only provides synchronous APIs.

##### Client Immutability

> TODO: Add a note about this.

#### Service Methods

##### Naming

{% include requirement/MUST id="clang-design-naming-concise" %} use clear and concise names.

{% include requirement/SHOULDNOT id="clang-design-naming-abbrev" %} use abbreviations unless necessary or when they are commonly used and understood.  For example, `az` is allowed since it is commonly used to mean `Azure`, and `iot` is used since it is a commonly understood industry term.  However, using `kv` for Key Vault would not be allowed since `kv` is not commonly used to refer to Key Vault.

{% include requirement/MUST id="clang-design-naming-lowercase" %} use lower-case for all variable, function, and struct names.

{% include requirement/MUST id="clang-design-naming-underbar" %} use underscores (`_`) to separate name components (commonly refered to as snake-casing).

{% include requirement/MUST id="clang-design-naming-internal" %} use a single leading underscore to indicate that a name is not part of the public API and is not guaranteed to be stable.

###### Variables

{% include requirement/MUST id="clang-design-naming-units" %} include units in names.  If a variable represents time, weight, or some other unit, then include the unit in the name so developers can more easily spot problems.  For example:

{% highlight c %}
// Bad
uint32 timeout;
uint32 my_weight;

// Goog
uint32 timeout_msecs;
uint32 my_weight_kg;
{% endhighlight %}

{% include requirement/MUST id="clang-design-naming-optimize-position" %} declare variables in structures organized by use in a manner that minimizes memory wastage because of compiler alignment issues and size.  All things being equal, use alphabetical ordering.

{% highlight c %}
// Bad
struct foo {
    int a;
    char *b;
    int c;
    char *d;
};

// Good
struct foo {
    int a;
    int c;
    char *b;
    char *d;
};
{% endhighlight %}

Each variable is normally defined with its own type and line.  An exception can be made when declaring bitfields (to clarify that the variable is a part of one bitfield).  The use of bitfields in general is discouraged.

{% include requirement/MUST id="clang-design-naming-staticvars" %} declare all variables that are only used within the same source file as `static`.  Static variables may contain only the variable name (no prefixes).  For example:

{% highlight c %}
static uint32_t byte_counter = 0;
{% endhighlight %}

###### Globals

{% include requirement/SHOULDNOT id="clang-design-naming-no-globals" %} use global variables.  If a global variable is absolutely necessary:

* Declare the global at the top of your file.
* Name the global `g_az_<svcname>_<globalname>`.

{% include requirement/MUST id="clang-design-naming-global-const" %} name public global constants using all upper-case, with the `AZ_` prefix, and with snake-casing.  For example:

{% highlight c %}
// Bad
const int Global_Foo = 5;

// Good
const int AZ_WIDGETS_TIMEOUT_MSEC = 5;
{% endhighlight %}

{% include requirement/MUST id="clang-design-naming-global-private-const" %} name private/internal global constants in all uppercase with the prefix `_az`. For example:

```c
// bad
const int _AZ_PRIVATE_CONSTANT = 5;

// bad
const int az_PRIVATE_CONSTANT = 5;

// good
const int _az_PRIVATE_CONSTANT = 5;
```

Note that this differs slightly from the guidance on internal function naming below. This is because `_AZ_PRIVATE_MEOW` is a reserved name.

###### Structs

{% include requirement/MUST id="clang-design-naming-declare-structs" %} declare major structures at the top of the file in which they are used, or in separate header files if they are used in multiple source files.  

{% include requirement/MUST id="clang-design-naming-struct-definition" %} declare structs using typedef.  Name the struct and typedef according to the normal naming for types.  For example:

{% highlight c %}
typedef struct az_iot_client {
    char *api_version;
    az_iot_client_credentials *credentials;
    int retry_timeout;
} az_iot_client;
{% endhighlight %}

{% include requirement/MUSTNOT id="clang-design-naming-struct-no-const" %} declare const fields within structs. Pointers to const are fine, however. For example:
```c
// bad
typedef struct az_iot_client {
    const int retry_timeout;
    char* const api_version;
} az_iot_client;

// good
typedef struct az_iot_client {
    int retry_timeout;
    char const * api_version;
} az_iot_client;
```

The reason to avoid such members is that it makes it impossible to ever _reassign_ a variable of the struct type. For example:

```c
typedef struct az_iot_client {
    int retry_timeout;
    char const* const api_version;
};

az_iot_client az_iot_create_client() {
    az_iot_client result = {4, "some version"};
    return result;
}

void az_iot_client_do_operation(az_iot_client const * client);

int main(void) {
    az_iot_client client = az_iot_create_client();
    az_iot_client_do_operation(&client);
    // done, need to connect to some other service endpoint
    client = az_iot_create_client(); // <--- does not compile
    // do things with the other client
}

```

###### Enums

{% include requirement/MUST id="clang-design-naming-enum" %} use snake-casing to name enum types, and include the az_<svcname>_<shortenumname> prefix.

{% include requirement/MUST id="clang-design-naming-enumerators" %}
Name enumerators (the "members" of an enum) with ALL_CAPS and with
the AZ_<svcname>_<shortenumname> prefix. For example:

{% highlight c %}
typedef enum az_pin_state {
    AZ_PIN_STATE_OFF,
    AZ_PIN_STATE_ON
} az_pin_state;
{% endhighlight %}

Enums do not have a guaranteed size.  If you have a type that can take a known range of values and it is transported in a message, you cannot use an enum as the type.

{% include requirement/MUST id="clang-design-modelasstring" %} Use strings, not enums
  as the datatype for service data with the "ModelAsString" swagger attribute.

{% include requirement/MUSTNOT id="clang-design-enumsareinternal" %} use C enums to model any data sent to the service. Use C enums only for types completely internal to the client library.

{% include requirement/SHOULD id="clang-design-naming-enum-errors" %} use the first label within an enum for an error state, if it exists.  

{% highlight c %}
typedef enum az_iot_service_state {
    AZ_IOT_SERVICE_STATE_ERR,
    AZ_IOT_SERVICE_STATE_OPEN,
    AZ_IOT_SERVICE_STATE_RUNNING,
    AZ_IOT_SERVICE_STATE_DYING
} az_iot_service_state;
{% endhighlight %}

###### Functions

{% include requirement/MUST id="clang-design-naming-funcname" %} name functions with all-lowercase.  If part of the public API, start with `az_<svcname>_[<objname>_]`.  If not, start with `_`. For example:

{% highlight c %}
// Part of the private API
int64_t _az_compute_hash(int32_t a, int32_t b);

// Part of the public API
AZ_NODISCARD az_result az_widgets_client_init(az_widgets_client* self);

// Bad - no leading underscore
int64_t compute_hash(int32_t a, int32_t b);
{% endhighlight %}

{% include requirement/MUST id="clang-design-naming-funcstatic-initializers" %} declare all functions that initialize structures with `..._<objname>_init`.  These functions can fail and must return an az_result.

{% highlight c %}

// Initialize the object
AZ_NODISCARD az_result az_widgets_client_init(az_widgets_client* self);

{% endhighlight %}

{% include requirement/MUST id="clang-design-naming-funcstatic-options" %} declare all functions that return an initialized options structure (which can be examined/modified) with `..._<objname>_options_default`.  These functions must always succeed.

{% highlight c %}

// Default initialized options object
AZ_NODISCARD az_widgets_options az_widgets_options_default();

{% endhighlight %}

{% include requirement/SHOULD id="clang-design-naming-funcstatic-same-source" %} declare all functions that are only used within the same source file as `static`.  Static functions may contain only the function name (no prefixes).  For example:

{% highlight c %}
static int64_t compute_hash(int32_t a, int32_t b) {
    // ...
}
{% endhighlight %}

{% include requirement/SHOULD id="clang-design-naming-paramnames" %} use a meaningful name for parameters and local variable names.  Parameters and local variable names should be named as all lower-case words, separated by underscores (snake-casing).

{% include requirement/MUSTNOT id="clang-design-const-parameters" %} use first level const for parameters or return types for function signatures. 
Pointers to const are fine. First level const on function parameters do not provide any additional guarantees to the caller, and can be confusing. For example:

This is not OK:
```c
const int az_iot_client_set_widget_id(az_iot_client *client, const int id);
```

Instead write:
```c
int az_iot_client_set_widget_id(az_iot_client *client, int id);
```

This is also not OK
```c
const int az_iot_client_get_widget_id(az_iot_client const *const client, int *const id);
```

Instead write:
```c
int az_iot_client_get(az_iot_client const *client, int *id);
```

Note: You may use first level const when _defining_ a function, if you want to ensure you don't modify the value. Similarly you may use first level const on
definitions of inline functions (which are in headers).

###### Callbacks

Functions that request a callback with a context should order the callback first and then the context.  For example:

{% highlight c %}
az_iot_client az_iot_client_send_async(az_iot_client *client, 
        az_iot_message *message, az_iot_release_callback release_message, 
        az_iot_client_result_callback callback, az_iot_client_result_context context)
{% endhighlight %}

Callbacks that receive the context should do so as the first argument:

{% highlight c %}
static void on_client_result(az_iot_client_result_context context, 
        az_iot_result result, az_iot_message_received message)
{% endhighlight %}

###### Macros

{% include requirement/MUST id="clang-design-naming-macros1" %} name macros with upper-case snake-casing. 

{% include requirement/MUST id="clang-design-naming-macro-params" %} wrap the macro expression in parentheses.  This avoids potential communitive operation ambiguity.

{% include requirement/MUST id="clang-design-naming-macros-form" %} prepend macro names with `AZ_<SVCNAME>` to make macros unique.

{% include requirement/MUST id="clang-design-naming-macros2" %} avoid side-effects when implementing macros.

If the macro is an inline expansion of a function, the function is defined in lowercase and the macro must have the same name in uppercase.  If the macro is an expression, wrap the expression in parenthesis.

For example:

{% highlight c %}
#define MAX(a,b) ((a > b) ? a : b)
#define IS_ERR(err) (err < 0)
{% endhighlight %}

{% include requirement/SHOULD id="clang-design-naming-macros3" %} wrap the macro in `do { ... } while(0)` if the macro is more than a single statement, so that a trailing semicolon works.  Right-justify backslashes to ensure the macro is easy to read.  For example:

{% highlight c %}
#define MACRO(v, w, x, y)           \
do {                                \
    v = (x) + (y);                  \
    w = (y) + 2;                    \
} while (0)
{% endhighlight %}

{% include requirement/MUSTNOT id="clang-design-naming-macros-donoevil" %} change syntax via macro substitution.  It [makes the program unintelligible](https://gist.github.com/aras-p/6224951) to all but the perpetrator.

{% include requirement/SHOULD id="clang-design-naming-macros-inlinefunc" %} replace macros with inline functions where possible.  Macros are not required for code efficiency.

{% highlight c %}
// Bad
#define MAX(a,b) ((a > b) ? a : b)

// Good
inline int max(int x, int y) {
    return (x > y ? x : y);
}
{% endhighlight %}

##### Return Types

> TODO: Implement the spirit of the general guidelines for network requests - explicitly, how to use Azure Core for making network requests

##### Cancellation

> TODO: Add a discussion about context.

#### Service Method Parameters

##### Options Parameters

> TODO: Add a discussion about options parameter in Embedded C.

##### Parameter Validation

The service client will have several methods that perform requests on the service.  _Service parameters_ are directly passed across the wire to an Azure service.  _Client parameters_ are not passed directly to the service, but used within the client library to fulfill the request.  Examples of client parameters include values that are used to construct a URI, or a file that needs to be uploaded to storage.

{% include requirement/MUST id="clang-params-client-validation" %} validate client parameters.

{% include requirement/MUSTNOT id="clang-params-server-validation" %} validate service parameters.  This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUST id="clang-params-check-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service.  If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

#### Methods Returning Collections (Paging)

Although object-orientated languages can eschew low-level pagination APIs in favor of high-level abstractions, C acts as a lower level language and thus embraces pagination APIs provided by the service.  You should work within the confines of the paging system provided by the service.

{% include requirement/MUST id="clang-pagination-use-paging" %} export the same paging API as the service provides.

{% include requirement/MUST id="clang-last-page" %} indicate in the return type if the consumer has reached the end of the result set.

{% include requirement/MUST id="clang-size-of-page" %} indicate how many items were returned by the service, and have a list of those items for the consumer to iterate over.

#### Methods Invoking Long Running Operations

> TODO: The Embedded C library does not support long-running operations.
> TODO: Implement general guidelines for LRO

#### Conditional Request Methods

> TODO: The Embedded C library does not support conditional request methods.

#### Hierarchical Clients

> TODO: The Embedded C library does not support hierarchical clients.

### Supporting Types

#### Model Types

> TODO: Add a discussion about model types in Embedded C.

#### Enumerations

{% include requirement/MUST id="clang-design-naming-enum" %} use snake-casing to name enum types, and include the az_<svcname>_<shortenumname> prefix.

{% include requirement/MUST id="clang-design-naming-enumerators" %}
Name enumerators (the "members" of an enum) with ALL_CAPS and with
the AZ_<svcname>_<shortenumname> prefix. For example:

{% highlight c %}
typedef enum az_pin_state {
    AZ_PIN_STATE_OFF,
    AZ_PIN_STATE_ON
} az_pin_state;
{% endhighlight %}

Enums do not have a guaranteed size.  If you have a type that can take a known range of values and it is transported in a message, you cannot use an enum as the type.

{% include requirement/MUST id="clang-design-modelasstring" %} Use strings, not enums
  as the datatype for service data with the "ModelAsString" swagger attribute.

{% include requirement/MUSTNOT id="clang-design-enumsareinternal" %} use C enums to model any data sent to the service. Use C enums only for types completely internal to the client library.

{% include requirement/SHOULD id="clang-design-naming-enum-errors" %} use the first label within an enum for an error state, if it exists.  

{% highlight c %}
typedef enum az_iot_service_state {
    AZ_IOT_SERVICE_STATE_ERR,
    AZ_IOT_SERVICE_STATE_OPEN,
    AZ_IOT_SERVICE_STATE_RUNNING,
    AZ_IOT_SERVICE_STATE_DYING
} az_iot_service_state;
{% endhighlight %}

#### Using Azure Core Types

> TODO: Add details on how to use azure core types.

#### Using Primitive Types

> TODO: Add details on how to use Embedded C primitive types.

### Exceptions (Errors)

Error handling is an important aspect of implementing a client library. It is the primary method by which problems are communicated to the consumer. Because we intend for the C client libraries to be used on a wide range of devices with a wide range of reliability requirements, it's important to provide robust error handling.

We distinguish between several different types of errors:

* Pre-Conditions
    : Pre-Condition errors occur when a caller violates the expectations of a function, for example by passing an out-of-range value or a null pointer. These are always avoidable by the direct caller, and will always require a source code change (by the caller) to fix.
* Post-Conditions
    : Post-Condition violations happen when some function didn't do the correct thing, these are _always_ bugs in the function itself, and users shouldn't be expected to handle them.
* Exhaustion / Act of God
    : errors like running out of stack space, or dealing with power failure that, in general, can not be anticipated and after which it may be hard to execute any more code, let alone recover. Code handling these errors needs to be written to *very* specific requirements, for example not doing any allocations and never growing the stack.
* Recoverable Error
    : Things like trying to open a file that doesn't exist, or trying to write to a full disk. These kinds of errors can usually be handled by a function's caller directly, and need to be considered by callers that want to be robust.

#### Pre-conditions

{% include requirement/SHOULD id="clang-error-prec-contract" %} check preconditions with a contract macro. For example:

{% highlight c %}
#ifdef INCLUDE_CONTRACTS
#  define CONTRACT_CHECK(x)                 \
    do {                                    \
      if(!(x)) return az_panic_function();	\
    } while(0);
#else
#  define CONTRACT_CHECK(x)
#endif
  az_result some_unction(int some_arg) {
    CONTRACT_CHECK(some_arg > 0);
  }

{% endhighlight %}

{% include requirement/MUST id="clang-error-prec-panic" %} call a "panic function" on a (checked) precondition failure. This function should be either provided by the user, or marked as a "weak symbol" if supported by the compiler.

For example

{% highlight c %}
az_result az_panic() {
  return AZ_ERROR_INVALID_ARGUMENT;
}
{% endhighlight %}

{% include requirement/MAY id="clang-error-prec-disablecheck" %} provide an option to disable any checks, and omit checking code from built binaries.

{% include requirement/MUST id="clang-error-prec-document" %} document all function preconditions. For conditions like "not null", a `[not nullable]` annotation is satisfactory.

#### Post Conditions

{% include requirement/SHOULDNOT id="clang-error-postc-check" %} check post-conditions in a way that changes the computational complexity of the function.

{% include requirement/MUST id="clang-error-postc-disablecheck" %} provide a way to disable postcondition checks, and omit checking code from built binaries.

#### Exhaustion / Act of God

{% include requirement/MUSTNOT id="clang-error-exh-return error" %} return an error to the caller.

{% include requirement/MAY id="clang-error-exh-crash" %} crash, if possible.

Note: if your client library needs to be resilient to these kinds of errors you must either provide a fallback system, or construct your code in a way to facilitate proving that such errors can not occur.

#### Recoverable errors

{% include requirement/MUST id="clang-error-recov-reporting" %} report errors via an error code enum. The core library defines such an enum called `az_result`.

For example:

{% highlight c %}
AZ_NODISCARD az_result az_widgets_count_widgets(az_widgets_client* client, int* widgets) {
  if(client->no_widget_storage) {
    return AZ_RESULT_WIDGETS_NO_STORAGE;
  }
  *widgets = clinet->num_widgets;
  return AZ_OK;
}
{% endhighlight %}

{% include requirement/MUST id="clang-error-recov-nodiscard" %} mark all functions returning errors as `AZ_NODISCARD`. This will cause supported compilers to emit a warning if the caller ignores the error code.

{% include requirement/MUST id="clang-error-recov-success" %} return `AZ_OK` or `AZ_RESULT_MEOW` from successful functions, unless the function has no error conditions.

{% include requirement/MUST id="clang-error-recov-error" %} produce a recoverable error when any HTTP request fails with an HTTP status code that is not defined by the service/Swagger as a successful status code.

{% include requirement/MUST id="clang-error-recov-document" %} document all recoverable errors each function generates.

#### A Note on Out Of Memory

We all want to be able to handle low memory situations gracefully and effectively, and C is "helpful" in that most memory allocation functions return an error or null pointer if they fail, including in the case of "out of memory". If you need to allocate memory of a dynamic (user specified) size, or of an extremely large size, then failures of that allocation should always be treated as a recoverable error. However, for small, compile-time constant sized allocations the decision of weather to treat a failure as an "Act of God" or a "Recoverable error" is more subtle and should be decided when you start a new library (with Architectural Review Board consultation).

On some platforms, mainly those that overcommit, it's extremely hard to handle OOM gracefully. Additionally, if you are "almost" out of memory and attempt to grow the stack - by calling functions, for example - then the system _MIGHT NOT TELL YOU_ and your program's state will be corrupted. To recover from out of memory errors the program must have bounded stack size and must set the stack size to that bound at the start of the program. Additionally, the library must not allocate on the OOM error handling path. 

### Authentication

Azure services use a variety of different authentication schemes to allow clients to access the service. Conceptually, there are two entities responsible in this process: a credential and an authentication policy.  Credentials provide confidential authentication data.  Authentication policies use the data provided by a credential to authenticate requests to the service.  

{% include requirement/MUST id="clang-apisurface-support-all-auth-techniques" %} support all authentication techniques that the service supports and are available to a client application (as opposed to service side).  C is used only for client applications when talking to Azure, so some authentication techniques may not be valid.

{% include requirement/MUST id="clang-apisurface-use-azure-core" %} use credential and authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="clang-apisurface-prefer-token-auth" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service in a non-blocking atomic manner for each authentication scheme that does not have an implementation in Azure Core.

{% include requirement/MUST id="clang-apisurface-auth-in-constructors" %} provide service client constructors or factories that accept any supported authentication credentials.

Client libraries may support providing credential data via a connection string __ONLY IF__ the service provides a connection string to users via the portal or other tooling. 

{% include requirement/MUSTNOT id="clang-apisurface-no-connection-strings" %} support constructing a service client with a connection string unless such connection string is available within tooling (for copy/paste operations).

### Namespaces

The C programming language does not have the concept of a namespace.  Instead, a common prefix is used for all structs, variables, and functions within the library.  This allows the developer to easily distinguish between specific libraries.  For example:

{% highlight c %}
az_keyvault_key *az_keyvault_keyclient_create_key(char *info);
az_eventhub_eph_process_partition(az_eventhub_partition_info *partition_info);
void az_iot_credential_init(az_iot_credential *credential);
void az_iot_credential_deinit(az_iot_credential *credential);
{% endhighlight %}

{% include requirement/MUST id="general-namespaces-shortened-name" %} pick a shortened service name that allows the consumer to tie the package to the service being used.  As a default, use the compressed service name (that is, the service name with all spaces removed and lower-cased).  The namespace does **NOT** change when the branding of the product changes, so avoid the use of marketing names that may change.

{% include requirement/MUST id="clang-namespaces-prefix" %} prefix all exposed functions with `az_` and the short name of the service; i.e. `az_<svcname>_`.  When using objects (see the Object model later on), add the object name to the list (i.e. `az_<svcname>_<objname>_`).

{% include requirement/MUST id="clang-namespaces-register" %} register the short name of the client library with the [Architecture Board].

### Support for Mocking

{% include requirement/MUST id="clang-tooling-test-tools" %} use the following tools for testing:

* Azure C Test for unit test running: [https://github.com/Azure/azure-ctest](https://github.com/Azure/azure-ctest)

* Azure micro mock C [umock-c](https://github.com/Azure/umock-c): [https://github.com/Azure/umock-c](https://github.com/Azure/umock-c)

* Use TestRunnerSwitcher, which is a simple library to switch test runners between [azure-ctest](https://github.com/Azure/azure-ctest.git) and CppUnitTest: [https://github.com/Azure/azure-c-testrunnerswitcher](https://github.com/Azure/azure-c-testrunnerswitcher)

## Azure SDK Library Design

### Packaging

{% include requirement/SHOULD id="clang-package-dynamic" %} provide both dynamic and static linking options for your library.  Each has its own merits and use cases.

{% include requirement/MUST id="clang-package-source" %} publish your package in source code format.  Due to differences in platforms, this is the most common publishing mechanism for C libraries.

{% include requirement/MUST id="clang-package-vcpkg" %} publish your package to [vcpkg](https://github.com/Microsoft/vcpkg), a C++ library manager supporting Windows, Linux, and MacOS.

{% include requirement/SHOULD id="clang-package-linux" %} publish libraries targeted to Linux to standard Linux package managers.

> TODO: decide which Linux package managers to support plus which repositories we bless.

> TODO:  Decide if we need to publish to GitHub Package Registry.  If we do, then we likely want to do it across all languages.ß

#### Service-Specific Common Libraries

> TODO: Add details about how code is shared.

### Versioning

Unlike other languages, client libraries written for the C ecosystem are tied to a single API version within the service.  Different client library versions may target different service API versions.

{% include requirement/MUST id="clang-version-library-api" %} include a `SHORTNAME_VERSIONINFO` definition in the main header file that defines the current version of the library.

{% include requirement/MUST id="clang-version-service-api" %} include a `SHORTNAME_SERVICEVERSION` definition in the main header file that defines the API version of the service that is targetted by the library if the service supports different concurrent versions on the REST API.

Example:

{% highlight c %}
#ifndef azure_devicetwin_h
#define azure_devicetwin_h

#define DEVICETWIN_VERSIONINFO "1.0.0"
#define DEVICETWIN_SERVICEVERSION "2018-11-28"

#endif /* azure_devicetwin_h */
{% endhighlight %}

### Dependencies

Dependencies bring in many considerations that are often easily avoided by avoiding the 
dependency. 

- **Versioning** - Many programming languages do not allow a consumer to load multiple versions of the same package. So, if we have an client library that requires v3 of package Foo and the consumer wants to use v5 of package Foo, then the consumer cannot build their application. This means that client libraries should not have dependencies by default. 
- **Size** - Consumer applications must be able to deploy as fast as possible into the cloud and move in various ways across networks. Removing additional code (like dependencies) improves deployment performance.
- **Licensing** - You must be conscious of the licensing restrictions of a dependency and often provide proper attribution and notices when using them.
- **Compatibility** - Often times you do not control a dependency and it may choose to evolve in a direction that is incompatible with your original use.
- **Security** - If a security vulnerability is discovered in a dependency, it may be difficult ortime consuming to get the vulnerability corrected if Microsoft does not control the dependencys code base.

{% include requirement/MUST id="clang-dependencies-stdlibc" %} use the [C standard library](https://en.wikipedia.org/wiki/C_standard_library).  The C standard library is sometimes referred to as `libc`, the C-Runtime, CRT, or (for Windows) Universal CRT.

{% include requirement/MUST id="clang-dependencies-azure-core" %} depend on the Azure Core library for functionality that is common across all client libraries.  This library includes APIs for HTTP connectivity, global configuration, and credential handling.

> TODO: Move the azure/azure-c-shared-utility into azure-core as a prerequisite for release of the guidelines.

{% include requirement/MUSTNOT id="clang-dependencies-approved-only" %} be dependent on any other packages within the client library distribution package. Dependencies are by-exception and need a thorough vetting through architecture review.  This does not apply to build dependencies, which are acceptable and commonly used.

{% include requirement/SHOULD id="clang-dependencies-vendoring" %} consider copying or linking required code into the client library in order to avoid taking a dependency on another package that could conflict with the ecosystem. Make sure that you are not violating any licensing agreements and consider the maintenance that will be required of the duplicated code. ["A little copying is better than a little dependency"][1] (YouTube).

{% include requirement/MUSTNOT id="clang-dependencies-concrete" %} depend on concrete logging, dependency injection, or configuration technologies (except as implemented in the Azure Core library).  The client library will be used in applications that might be using the logging, DI, and configuration technologies of their choice.

#### C language specifics

Unlike many other programming languages, which have large runtimes, the C standard runtime is limited in functionality and scope. The standard library covers areas such as memory and string manipulation, sandard input/output, floating point and others. However, many of the features required for modern applications and services; e.g. those required for synchronization, networking and advanced memory management and threading are not part of the standard library. Instead, many of those features are included in open source C libraries that are also cross-platform with good support for Windows, OSX and most Linux platforms. Because of that support and because Azure SDK implementations will need such functionality, it is expected that client libraries will take dependencies on these libraries.  Ensure the version matches to allow for compatibility when an application integrates multiple client libraries.

{% include requirement/MUST id="clang-approved-dependencies" %} utilize the following libraries as needed for commonly required operations:

{% include_relative approved_dependencies.md %}

{% include requirement/MUST id="clang-dependencies-adparch" %} consult the [Architecture Board] if you wish to use a dependency that is not on the list of approved dependencies.

### Native Code

> TODO: This section is not applicable for the Embedded C SDK.

### Documentation Comments

> TODO: Add link to the Documentation Style section below or restructure it.

## Repository Guidelines

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

### Files

{% include requirement/MUST id="clang-style-filenaming" %} name all files as lowercase, prefixed by the service short name; separate words with underscores, and end with the appropriate extension (`.c` or `.h`).  For example, `iot_credential.c` is valid, while `IoTCredential.cl` is not.

{% include requirement/MUST id="clang-style-publicapi-hdr" %} identify the file containing the public API with `<svcname>_<objname>.h`.  For example, `iot_credential.h`.

{% include requirement/MUST id="clang-style-privateapi-hdr" %} place include files that are not part of the public API in the `src` directory.

{% include requirement/MUST id="clang-style-internalapi-hdr" %} place include files that are exposed to other sdk components but not part of the public api in
the `internal` directory (a sibling of `src` and `inc`).

{% include requirement/MUSTNOT id="clang-style-publicapi-hdr-includes" %} include internal or private headers in public headers.

{% include requirement/MUSTNOT id="clang-style-publicapi-hdr-expose" %} expose internal implementation details (fields, types, or methods) within the public surface area and header files. The following **note** issues one exception to this guidance.

> **Note**: It is allowed for a public header to declare internal structures to be used **only** within another internal structure or API. See example below.

For example, the following **can** be part of a public header.
{% highlight c %}
// internal structure only used by another _internal field
typedef struct {
      int x;
} _az_internal_structure;

// Public structure with a nested `_internal` structure
typedef struct {
      int y; // Public field in a public struct.
      struct {
            _az_internal_structure nested; // This is OK.
      } _internal;
} az_public_struct;
{% endhighlight %}

On the contrary, the following **cannot** be part of a public header.
{% highlight c %}
// Public structure with an internal struct exposed as a public field rather than within a nested `_internal` struct.
typedef struct {
      int y; // Public field in a public struct.
      _az_internal_structure nested; // This is not OK. Exposing internal field as public.
} az_public_struct;
{% endhighlight %}

{% include requirement/MUSTNOT id="clang-style-install-internal-private-headers" %} install internal or private headers with `make install` or equivalent.

{% include requirement/MUST id="clang-style-filenames" %} use characters in the range `[a-z0-9_]` for the name portion (before the file extension).  No other characters are permitted.

Filenames should be concise, but convey what role the file plays within the library.

{% include requirement/MUST id="clang-style-headerguards" %} use header file guards:

{% highlight c %}
#ifndef IOT_CLIENT_H
#define IOT_CLIENT_H

/* Contents of iot_client.h */

#endif /* IOT_CLIENT_H */
{% endhighlight %}

### Documentation Style

{% include requirement/MUST id="clang-docs-doxygen" %} include docstrings compatible with the [doxygen](https://www.doxygen.nl/index.html) tool for generating reference documentation.

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
 * @brief get properties of a widget (e.g. place of manufacture, number of sides, material)
 *
 * @param[in] self __[transfer none]__ the widget to operate on
 * @param[out] props __[nullable][caller-allocates]__ pointer to an array of num_props, or null
 * @param[in,out] num_props __[non nullable][caller-allocates]__ pointer to the number of properties to
 *                                                               retrieve or to a location to store the number of
 *                                                               properties queried as described below
 *
 * If @p props is NULL then return the number of properties available in @p num_props,
 * otherwise return @p num_props into the array at @p props
 */
az_error az_widgets_get_widget_properties(az_widgets_widget* self, az_widgets_widget_properties* props, size_t* num_props);
{% endhighlight %}

This function returns an array using all caller-allocated memory. In order to figure out the size of the array the caller can pass NULL for the array `[out]` parameter. They can then allocate the required memory and call the function again.

{% include requirement/MUST id="clang-docs-doxygen-ptr-dir" %} provide a `<direction>` for all parameters that are pointers or structs/unions containing a pointer.

> **Note**: 
> These annotations are derived from [gobject-introspection-annotations](https://wiki.gnome.org/Projects/GObjectIntrospection/Annotations).  It's not a big deal that we use that form, it's just critical that there is a standard way to indicate ownership of reference parameters

{% include requirement/MUST id="clang-docs-doxygen-failure" %} document how your function can fail. For example, if returning an error code, document when each possible code will be returned.

#### Buildsystem integration

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

### README

> TODO: Fill out this section.

### Samples

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

{% include refs.md %}
{% include_relative refs.md %}