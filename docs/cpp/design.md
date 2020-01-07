---
title: "C++ Guidelines: API Design"
keywords: guidelines cpp
permalink: cpp_design.html
folder: cpp
sidebar: cpp_sidebar
---

{% include draft.html content="The C++ Language guidelines are in DRAFT status" %}

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.

## Namespaces

Grouping services within a cloud infrastructure is common since it aids discoverability and provides structure to the reference documentation.

{% include requirement/SHOULD id="general-namespaces-support" %} support namespaces if namespace usage is common within the language ecosystem.

{% include requirement/MUST id="general-namespaces-naming" %} use a root namespace of the form `azure::<group>::<service>`.  All consumer-facing APIs that are commonly used should exist within this namespace.  The namespace is comprised of three parts:

- `azure` indicates a common prefix for all Azure services.
- `<group>` is the group for the service.  See the list below.
- `<service>` is the shortened service name.

{% include requirement/MUST id="general-namespaces-shortened-name" %} pick a shortened service name that allows the consumer to tie the package to the service being used.  As a default, use the compressed service name.  The namespace does **NOT** change when the branding of the product changes, so avoid the use of marketing names that may change.

A compressed service name is the service name without spaces.  It may further be shortened if the shortened version is well known in the community.  For example, "Azure Media Analytics" would have a compressed service name of `media_analytics`, whereas "Azure Service Bus" would become `service_bus`.

{% include requirement/MUST id="general-namespaces-approved-list" %} use the following list as the group of services (if the target language supports namespaces):

{% include tables/data_namespaces.md %}

If the client library does not seem to fit into the group list, contact the [Architecture Board] to discuss the namespace requirements.

{% include requirement/MUST id="general-namespaces-mgmt" %} place the management (Azure Resource Manager) API in the `management` group.  Use the grouping `<AZURE>::management::<group>::<service>` for the namespace. Since more services require control plane APIs than data plane APIs, other namespaces may be used explicitly for control plane only.  Data plane usage is by exception only.  Additional namespaces that can be used for control plane SDKs include:

{% include tables/mgmt_namespaces.md %}

Many `management` APIs do not have a data plane because they deal with management of the Azure account. Place the management library in the `<AZURE>.management` namespace.  For example, use `azure::management::costanalysis` instead of `azure::management::management::costanalysis`.

{% include requirement/MUSTNOT id="general-namespaces-similar-names" %} choose similar names for clients that do different things.

{% include requirement/MUST id="general-namespaces-registration" %} register the chosen namespace with the [Architecture Board].  Open an issue to request the namespace.  See [the registered namespace list](registered_namespaces.html) for a list of the currently registered namespaces.

### Example Namespaces

Here are some examples of namespaces that meet these guidelines:

- `azure::data::cosmos`
- `azure::identity::active_directory`
- `azure::iot::device_provisioning`
- `azure::storage::blobs`
- `azure::messaging::notification_hubs` (the client library for Notification Hubs)
- `azure::management::messaging::notification_hubs` (the management library for Notification Hubs)

Here are some namespaces that do not meet the guidelines:

- `microsoft::azure::CosmosDB` (not in the `Azure` namespace and does not use grouping, uses capital letters)
- `azure::mixed_reality::kinect` (the grouping is not in the approved list)
- `azure::iot::iot_hub::device_provisioning` (too many levels in the group)

## Naming conventions

{% include requirement/MUST id="cpp-design-naming-concise" %} use clear and concise names.

{% include requirement/SHOULDNOT id="cpp-design-naming-abbrev" %} use abbreviations unless necessary or when they are commonly used and understood.  For example, `az` is allowed since it is commonly used to mean `Azure`, and `iot` is used since it is a commonly understood industry term.  However, using `kv` for Key Vault would not be allowed since `kv` is not commonly used to refer to Key Vault.

{% include requirement/MUST id="cpp-design-naming-lowercase" %} use lower-case for all variable, function, and struct names.

{% include requirement/MUST id="cpp-design-naming-underbar" %} use underscores (`_`) to separate name components (commonly refered to as snake-casing).

{% include requirement/MUST id="cpp-design-naming-internal" %} use a single leading underscore to indicate that a name is not part of the public API and is not guaranteed to be stable.

### Variables

{% include requirement/MUST id="cpp-design-typing-units" %} use types to enforce units where possible. For example, the C++ standard library provides `std::chrono` which makes time conversions automatic.
{% highlight cpp %}
// Bad
uint32 timeout;

// Good
std::chrono::milliseconds timeout;
{% endhighlight %}

{% include requirement/MUST id="cpp-design-naming-units" %} include units in names when a type based solution to enforce units is not present.  If a variable represents weight, or some other unit, then include the unit in the name so developers can more easily spot problems.  For example:

{% highlight cpp %}
// Bad
uint32 timeout;
uint32 my_weight;

// Good
std::chrono::milliseconds timeout;
uint32 my_weight_kg;
{% endhighlight %}

{% include requirement/MUST id="cpp-design-naming-optimize-position" %} declare variables in structures organized by use in a manner that minimizes memory wastage because of compiler alignment issues and size.  All things being equal, use alphabetical ordering.

{% highlight cpp %}
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

{% include requirement/MUST id="cpp-design-naming-staticvars" %} declare all entities that are only used within the same source file in an unnamed namespace.  Such entities may contain only the variable name (no prefixes).  For example:

{% highlight cpp %}
namespace {
    uint32_t byte_counter = 0;
    struct a_class_not_exposed {};
    class a_different_class_not_exposed {};
} // unnamed namespace
{% endhighlight %}

### Globals

{% include requirement/SHOULDNOT id="cpp-design-naming-no-globals" %} use global non-constant variables.

### Structs and Classes

{% include requirement/MUST id="cpp-design-naming-classname" %} name class types with all-lowercase.  If part of the public API, place them in your SDK's namespace.  If not, place the API in a "_details" namespace. For example:

{% highlight cpp %}
namespace azure::group::api {
namespace _details {
// Part of the private API
struct hash_computation_private_details {
    int internal_bookkeeping;
};
} // namespace _details

// Part of the public API
struct upload_blob_request {
    unsigned char* data;
    size_t data_length;
};

// Bad - private API in public namespace.
struct hash_computation_private_details {
    int internal_bookkeeping;
};
} // namespace azure::group::api
{% endhighlight %}

The definition of types must be placed in the `*_api.h` file for the module.

{% include requirement/SHOULD id="cpp-design-naming-classstatic" %} declare all types that are only used within the same source file in an unnamed namespace.  Such types may contain only the function name (no prefixes).  For example:

{% highlight cpp %}
namespace {
struct hash_computation_private_details {
    int internal_bookkeeping;
};
} // unnamed namespace
{% endhighlight %}

{% include requirement/SHOULD id="cpp-design-naming-members" %} use a meaningful name for class members.  Members should be named as all lower-case words, separated by underscores (snake-casing).

{% include requirement/MUST id="cpp-design-naming-declare-structs" %} declare major structures at the top of the file in which they are used, or in separate header files if they are used in multiple source files.

{% include requirement/MUST id="cpp-design-rule-of-zero" %} Implement the "rule of zero", the "rule of 3", or the "rule of 5". That is, of the special member functions, a type should implement exactly one of the following:

* No copy constructor, no copy assignment operator, no move constructor, no move assignment operator, or destructor.
* A copy constructor, a copy assignment operator, no move constructor, no move assignment operator, and a destructor.
* A copy constructor, a copy assignment operator, a move constructor, a move assignment operator, and a destructor.

This encourages use of resource managing types like std::unique_ptr (which implements the rule of 5) as a compositional tool in more complex data models that implement the rule of zero.

{% include requirement/MUST id="cpp-design-initialize-all-data" %} provide types which are usable when default-initialized. (That is, every constructor must initialize all type invariants, not assume members have default values of 0 or similar.)

{% highlight cpp %}
class type_with_invariants {
    int member;
public:
    type_with_invariants() noexcept : member(0) {} // Good: initializes all parts of the object
    [[nodiscard]] int next() noexcept  {
        return member++;
    }
};

class bad_type_with_invariants {
    int member;
public:
    type_with_invariants() {} // Bad: Does not initialize all parts of the object
    int next() {
        return member++;
    }
};

void the_customer_code() {
    type_with_invariants a{}; // value-initializes a type_with_invariants, OK
    type_with_invariants b; // default-initializes a type_with_invariants, we want this to be OK
    bad_type_with_invariants c{}; // value-initializes a bad_type_with_invariants, OK
    bad_type_with_invariants d; // default-initializes a bad_type_with_invariants, this will trigger
                                // undefined behavior if anyone calls d.next()
}
{% endhighlight %}

{% include requirement/SHOULD id="cpp-design-naming-struct-definition" %} define structs and classes without using typedefs.  Name the struct and typedef according to the normal naming for types.  For example:

{% highlight cpp %}
// Good: Uses C++ style class declaration:
struct iot_client {
    char* api_version;
    iot_client_credentials* credentials;
    int retry_timeout;
};

// Bad: Uses C-style typedef:
typedef struct iot_client {
    char* api_version;
    iot_client_credentials* credentials;
    int retry_timeout;
} az_iot_client;
{% endhighlight %}

{% include requirement/MUST id="cpp-design-no-getters-or-setters" %} define getters and setters for data transfer objects.  Expose the members directly to users unless you need to enforce some constraints on the data.  For example:
{% highlight cpp %}
// Good - no restrictions on values
struct example_request {
    int retry_timeout;
    const char* text;
};

// Bad - no restrictions on parameters and access is not idiomatic
class example_request {
    int retry_timeout;
    const char* text;
public:
    [[nodiscard]] int get_retry_timeout() const noexcept {
        return retry_timeout;
    }
    void set_retry_timeout(int i) noexcept {
        retry_timeout = i;
    }
    [[nodiscard]] const char* get_text() const noexcept {
        return text;
    }
    void set_text(const char* i) noexcept {
        text = i;
    }
};

// Good - type maintains invariants
class type_which_enforces_data_requirements {
    size_t size_;
    int* data_;
public:
    [[nodiscard]] size_t get_size() const noexcept {
        return size_;
    }
    void add_data(int i) noexcept {
        data_\[size_++\] = i;
    }
};

// Also Good
class type_which_clamps {
    int retry_timeout;
public:
    [[nodiscard]] int get_retry_timeout() const noexcept {
        return retry_timeout;
    }
    void set_retry_timeout(int i) noexcept {
        if (i < 0) i = 0; // clamp i to the range [0, 1000]
        if (i > 1000) i = 1000;
        retry_timeout = i;
    }
};

{% endhighlight %}

{% include requirement/SHOULD id="cpp-design-no-use-struct-keyword" %} declare classes with only public members using the `struct` keyword.
{% highlight cpp %}
// Good
struct only_pubic_members {
    int member;
};

// Bad
class only_public_members {
public:
    int member;
};
{% endhighlight %}

{% include requirement/MUSTNOT id="cpp-design-no-public-prefixes" %} declare public class members with prefixes or suffixes.

{% highlight cpp %}
struct example {
    int a; // OK
    int m_a; // prohibited
    int _a; // prohibited
    int a_; // prohibited
};
{% endhighlight &}

### Enums

{% include requirement/MUSTNOT id="clang-design-enumsareinternal" %} use enums to model any data sent to the service. Use enums only for types completely internal to the client library. For example, an enum to disable Nagle's algorithm would be OK, but an enum to ask the service to create a particular entity kind is not.

{% include requirement/MUST id="cpp-design-use-enum-class" %} use `enum class` for enumerations. For example:

{% highlight cpp %}
enum class pin_state {
    off,
    on
};
{% endhighlight %}

### Functions

{% include requirement/MUST id="cpp-design-naming-funcname" %} name functions with all-lowercase.  If part of the public API, place them in your SDK's namespace.  If not, place the API in a "_details" namespace. For example:

{% highlight cpp %}
namespace azure::group::api {
namespace _details {
// Part of the private API
[[nodiscard]] int64_t compute_hash(int32_t a, int32_t b) noexcept;
} // namespace _details

// Part of the public API
[[nodiscard]] catherd_client catherd_create_client(char *herd_name);

// Bad - private API in public namespace.
[[nodiscard]] int64_t compute_hash(int32_t a, int32_t b) noexcept;
} // namespace azure::group::api
{% endhighlight %}

The definition of the function must be placed in the `*_api.h` file for the module.

{% include requirement/SHOULD id="cpp-design-naming-funcstatic" %} declare all functions that are only used within the same source file in an unnamed namespace.  Static functions may contain only the function name (no prefixes).  For example:

{% highlight cpp %}
namespace {
[[nodiscard]] int64_t compute_hash(int32_t a, int32_t b) noexcept {
    // ...
}
} // unnamed namespace
{% endhighlight %}

{% include requirement/SHOULD id="cpp-design-naming-paramnames" %} use a meaningful name for parameters and local variable names.  Parameters and local variable names should be named as all lower-case words, separated by underscores (snake-casing).

{% include requirement/SHOULD id="cpp-design-noexcept" %} declare all functions that can never throw exceptions `noexcept`. If your SDK never uses exceptions, all non-`extern "C"` functions should be marked `noexcept`.

### Macros

{% include requirement/MUST id="cpp-design-naming-macros1" %} name macros with upper-case snake-casing.

{% include requirement/MUST id="cpp-design-naming-macro-params" %} wrap the macro expression in parentheses.  This avoids potential communitive operation ambiguity.

{% include requirement/MUST id="cpp-design-naming-macros-form" %} prepend macro names with `AZ_<SVCNAME>` to make macros unique.

{% include requirement/MUST id="cpp-design-naming-macros2" %} avoid side-effects when implementing macros.

If the macro is an inline expansion of a function, the function is defined in lowercase and the macro must have the same name in uppercase.  If the macro is an expression, wrap the expression in parenthesis.

For example:

{% highlight cpp %}
#define MAX(a,b) ((a > b) ? a : b)
#define IS_ERR(err) (err < 0)
{% endhighlight %}

{% include requirement/SHOULD id="cpp-design-naming-macros3" %} wrap the macro in `do { ... } while(0)` if the macro is more than a single statement, so that a trailing semicolon works.  Right-justify backslashes to ensure the macro is easy to read.  For example:

{% highlight cpp %}
#define MACRO(v, w, x, y)           \
do {                                \
    v = (x) + (y);                  \
    w = (y) + 2;                    \
} while (0)
{% endhighlight %}

{% include requirement/MUSTNOT id="cpp-design-naming-macros-donoevil" %} change syntax via macro substitution.  It [makes the program unintelligible](https://gist.github.com/aras-p/6224951) to all but the perpetrator.

{% include requirement/SHOULD id="cpp-design-naming-macros-inlinefunc" %} replace macros with inline functions where possible.  Macros are not required for code efficiency.

{% highlight cpp %}
// Bad
#define MAX(a,b) ((a > b) ? a : b)

// Good
[[nodiscard]] inline int max(int x, int y) noexcept {
    return (x > y ? x : y);
}
{% endhighlight %}

## Client interface

> TODO: This section needs to be driven by code in the Core library.

### Network requests

> TODO: This section needs to be driven by code in the Core library.

### Authentication

Azure services use a variety of different authentication schemes to allow clients to access the service. Conceptually, there are two entities responsible in this process: a credential and an authentication policy.  Credentials provide confidential authentication data.  Authentication policies use the data provided by a credential to authenticate requests to the service.

{% include requirement/MUST id="cpp-apisurface-support-all-auth-techniques" %} support all authentication techniques that the service supports and are available to a client application (as opposed to service side).  C is used only for client applications when talking to Azure, so some authentication techniques may not be valid.

{% include requirement/MUST id="cpp-apisurface-use-azure-core" %} use credential and authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="cpp-apisurface-prefer-token-auth" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service in a non-blocking atomic manner for each authentication scheme that does not have an implementation in Azure Core.

{% include requirement/MUST id="cpp-apisurface-auth-in-constructors" %} provide service client constructors or factories that accept any supported authentication credentials.

Client libraries may support providing credential data via a connection string __ONLY IF__ the service provides a connection string to users via the portal or other tooling.

{% include requirement/MUSTNOT id="cpp-apisurface-no-connection-strings" %} support constructing a service client with a connection string unless such connection string is available within tooling (for copy/paste operations).

## Response formats

Requests to the service fall into two basic groups - methods that make a single logical request, or a deterministic sequence of requests.  An example of a *single logical request* is a request that may be retried inside the operation.  An example of a *deterministic sequence of requests* is a paged operation.

The *logical entity* is a protocol neutral representation of a response. For HTTP, the logical entity may combine data from headers, body and the status line. A common example is exposing an ETag header as a property on the logical entity in addition to any deserialized content from the body.

{% include requirement/MUST id="cpp-return-logical-entities" %} optimize for returning the logical entity for a given request. The logical entity MUST represent the information needed in the 99%+ case.

{% include requirement/MUST id="cpp-return-expose-raw" %} *make it possible* for a developer to get access to the complete response, including the status line, headers and body. The client library MUST follow the language specific guidance for accomplishing this.

For example, you may choose to do something similar to the following:

{% highlight cpp %}
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

{% include requirement/MUST id="cpp-return-document-raw-stream" %} document and provide examples on how to access the raw and streamed response for a given request, where exposed by the client library.  We do not expect all methods to expose a streamed response.

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="cpp-return-no-headers-if-confusing" %} return headers and other per-request metadata unless it is obvious as to which specific HTTP request the methods return value corresponds to.

{% include requirement/MUST id="cpp-expose-data-for-composite-failures" %} provide enough information in failure cases for an application to take appropriate corrective action.

## Pagination

Although object-orientated languages can eschew low-level pagination APIs in favor of high-level abstractions, C acts as a lower level language and thus embraces pagination APIs provided by the service.  You should work within the confines of the paging system provided by the service.

{% include requirement/MUST id="cpp-pagination-use-paging" %} export the same paging API as the service provides.

{% include requirement/MUST id="cpp-last-page" %} indicate in the return type if the consumer has reached the end of the result set.

{% include requirement/MUST id="cpp-size-of-page" %} indicate in the return type how many items were returned by the service, and have a list of those items for the consumer to iterate over.

## Error handling

Error handling is an important aspect of implementing a client library. It is the primary method by which problems are communicated to the consumer. Because we intend for the C client libraries to be used on a wide range of devices with a wide range of reliability requirements, it's important to provide robust error handling.

We distinguish between several different types of errors:

* Exhaustion / Act of God
    : errors like running out of stack space, or dealing with power failure that, in general, can not be anticipated and after which it may be hard to execute any more code, let alone recover. Code handling these errors needs to be written to *very* specific requirements, for example not doing any allocations and never growing the stack.
* Pre-Conditions
    : Pre-Condition errors occur when a caller violates the expectations of a function, for example by passing an out-of-range value or a null pointer. These are always avoidable by the direct caller, and will always require a source code change (by the caller) to fix.
* Post-Conditions
    : Post-Condition violations happen when some function didn't do the correct thing, these are _always_ bugs in the function itself, and users shouldn't be expected to handle them.
* Heap Exhaustion (Out of Memory)
    : Running out of memory.
* Recoverable Error
    : Things like trying to open a file that doesn't exist, or trying to write to a full disk. These kinds of errors can usually be handled by a function's caller directly, and need to be considered by callers that want to be robust.

#### Exhaustion / Act of God

{% include requirement/MUSTNOT id="cpp-error-exh-return error" %} return an error to the caller.

{% include requirement/MUST id="cpp-error-exh-crash" %} crash, if possible. This means calling some form of fast failing function, like `abort`.

Note: if your client library needs to be resilient to these kinds of errors you must either provide a fallback system, or construct your code in a way to facilitate proving that such errors can not occur.

#### Pre-conditions
{% include requirement/MAY id="cpp-error-prec-check" %} check preconditions on function entry.

{% include requirement/MAY id="cpp-error-prec-disablecheck" %} privide a means to disable precondition checks in release / optimized builds.

{% include requirement/MUST id="cpp-error-exh-crash" %} crash, if possible. This means calling some form of fast failing function, like `abort`.

{% include requirement/MUSTNOT id="cpp-error-prec-exceptions" %} throw a C++ exception.

#### Post Conditions

{% include requirement/SHOULDNOT id="cpp-error-postc-check" %} check post-conditions in a way that changes the computational complexity of the function.

{% include requirement/MUST id="cpp-error-postc-disablecheck" %} provide a way to disable postcondition checks, and omit checking code from built binaries.

{% include requirement/MUST id="cpp-error-exh-crash" %} crash, if possible. This means calling some form of fast failing function, like `abort`.

{% include requirement/MUSTNOT id="cpp-error-postc-exceptions" %} throw a C++ exception.

#### Heap Exhaustion (Out of Memory)

{% include requirement/MAY id="cpp-error-oom-crash" %} crash. For example, this may mean dereferencing a nullptr returned by malloc, or explicitly checking and calling abort.

Note that on some comonly deployed platforms like Linux, handling heap exhaustion from user mode is not possible in a default configuration.

{% include requirement/MAY id="cpp-error-oom-bad-alloc" %} propagate a C++ exception of type `std::bad_alloc` when encountering an out of memory condition. We do not expect the program to continue in a recoverable state after this occurs. Note that most standard library facilities and the built in `operator new` do this automatically, and we want to allow use of other facilities that may throw here.

{% include requirement/MUSTNOT id="cpp-error-oom-throw" %} throw bad_alloc from the SDK code itself.

#### Recoverable errors

{% include requirement/MUST id="cpp-error-recov-reporting" %} report errors by throwing C++ exceptions defined in the Azure C++ Core Library.

> TODO: The Core library needs to provide exceptions for the common failure modes, e.g. the same values as `az_result` in the C SDK.

For example:

{% highlight cpp %}
class herd {
  bool has_shy_cats;
public:
  void count_cats(int* cats) {
    if(this->has_shy_cats) {
      throw std::runtime_error("shy cats are not allowed");
    }
    *cats = this->num_cats;
  }
};
{% endhighlight %}

{% include requirement/MUST id="cpp-error-recov-error" %} produce a recoverable error when any HTTP request fails with an HTTP status code that is not defined by the service/Swagger as a successful status code.

{% include requirement/MUST id="cpp-error-recov-document" %} document all exceptions each function and its transitive dependencies may throw, except for `std::bad_alloc`.

## Secure functions

{% include requirement/SHOULDNOT id="cpp-no-ms-secure-functions" %} use [Microsoft security enhanced versions of CRT functions](https://docs.microsoft.com/en-us/cpp/c-runtime-library/security-enhanced-versions-of-crt-functions?view=vs-2019) to implement APIs that need to be portable across many platforms. Such code is not portable and is not C99 compatible. Adding that code to your API will complicate the implementation with little to no gain from the security side. See [arguments against]( http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1967.htm).

> TODO: Verify with the security team, and what are the alternatives?

## C++ Exceptions

{% include requirement/MUSTNOT id="cpp-exceptions" %} `throw` exceptions, except those from the Azure C++ Core library as described in the error handling section.

{% include requirement/MUST id="cpp-exceptions" %} propagate exceptions thrown by user code, callbacks, or dependencies. Assume any user-provided callback will propagate C++ exceptions unless the SDK documents that the callback must be completely non-throwing.

{% highlight cpp %}
template<class Callback>
void api_func(const Callback& c) {
    // best
    c();

    // allowed, but results in a less pretty debugging experience for customers
    try {
        c();
    } catch (...) {
        // clean up
        throw; // throw; rethrows the original exception object
    }

    // prohibited
    try {
        c();
    } catch (...) {
        // missing throw;
    }
}
{% endhighlight %}


## Async

> TODO: Async needs to be funded.
