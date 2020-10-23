---
title: "C++ Guidelines: API Design"
keywords: guidelines cpp
permalink: cpp_design.html
folder: cpp
sidebar: cpp_sidebar
---

{% include draft.html content="The C++ Language guidelines are in DRAFT status" %}

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.

## Naming and Declarations

{% include requirement/MUST id="cpp-design-naming-concise" %} use clear, concise, and meaningful names.

{% include requirement/SHOULDNOT id="cpp-design-naming-abbrev" %} use abbreviations unless necessary or when they are commonly used and understood.  For example, `az` is allowed since it is commonly used to mean `Azure`, and `iot` is used since it is a commonly understood industry term.  However, using `kv` for Key Vault would not be allowed since `kv` is not commonly used to refer to Key Vault.

### Definitions

- **PascalCase** identifiers start with an uppercase letter and then use additional capital letters to divide words. Acronyms and initialisms are capitalized if they are 2 letters or shorter; otherwise only the first letter is capitalized. For example, `PascalCase`, `HttpRequest`, `JsonParser`, or `IOContext`.

- **camelCase** identifiers start with a lowercase letter and then use additional capital letters to divide words. Acronyms and initialisms that start an identifier are all lowercase if they begin an identifier, otherwise they follow the same 2 letters rule as PascalCase. For example, `camelCase`, `httpRequest`, `processHttp`, `ioContext`, `startIO`.

- **ALL_CAPITAL_SNAKE_CASE** identifiers are composed of entirely capital letters and divide words with underscores.

### Namespaces

Grouping services within a cloud infrastructure is common since it aids discoverability and provides structure to the reference documentation.

{% include requirement/MUST id="cpp-design-naming-namespaces" %} name namespaces using **PascalCase**.

{% include requirement/MUST id="cpp-design-naming-namespaces-hierarchy" %} use a root namespace of the form `Azure::<Group>::<Service>`.  All consumer-facing APIs that are commonly used should exist within this namespace.  The namespace is comprised of three parts:

- `Azure` indicates a common prefix for all Azure services.
- `<Group>` is the group for the service.  See the list below.
- `<Service>` is the shortened service name.

{% include requirement/MUST id="general-namespaces-shortened-name" %} pick a shortened service name that allows the consumer to tie the package to the service being used.  As a default, use the compressed service name.  The namespace does **NOT** change when the branding of the product changes, so avoid the use of marketing names that may change.

A compressed service name is the service name without spaces.  It may further be shortened if the shortened version is well known in the community.  For example, "Azure Media Analytics" would have a compressed service name of `MediaAnalytics`, whereas "Azure Service Bus" would become `ServiceBus`.

{% include requirement/MUST id="general-namespaces-approved-list" %} use the following list as the group of services:

{% include tables/data_namespaces_pascal_case.md %}

If the client library does not seem to fit into the group list, contact the [Architecture Board] to discuss the namespace requirements.

{% include requirement/MUST id="general-namespaces-mgmt" %} place the management (Azure Resource Manager) API in the `Management` group.  Use the grouping `Azure::Management::<Group>::<Service>` for the namespace. Since more services require control plane APIs than data plane APIs, other namespaces may be used explicitly for control plane only.  Data plane usage is by exception only.  Additional namespaces that can be used for control plane SDKs include:

{% include tables/mgmt_namespaces_pascal_case.md %}

Many `management` APIs do not have a data plane because they deal with management of the Azure account. Place the management library in the `Azure::Management` namespace.  For example, use `Azure::Management::CostAnalysis` instead of `Azure::Management::Management::CostAnalysis`.

{% include requirement/MUSTNOT id="general-namespaces-similar-names" %} choose similar names for clients that do different things.

{% include requirement/MUST id="general-namespaces-registration" %} register the chosen namespace with the [Architecture Board].  Open an issue to request the namespace.  See [the registered namespace list](registered_namespaces.html) for a list of the currently registered namespaces.

{% include requirement/MUST id="cpp-design-naming-namespaces-details" %} place private implementation details in a `Details` namespace.

{% highlight cpp %}
namespace Azure { namespace Group { namespace Service {
namespace Details {
// Part of the private API
struct HashComputation {
    int InternalBookkeeping;
};

const int g_privateConstant = 1729;
} // namespace Details

// Part of the public API
struct UploadBlobRequest {
    unsigned char* Data;
    size_t DataLength;
};

// Bad - private API in public namespace.
struct HashComputation {
    int InternalBookkeeping;
};
const int g_privateConstant = 1729;
}}} // namespace Azure::Group::Service
{% endhighlight %}

#### Example Namespaces

Here are some examples of namespaces that meet these guidelines:

- `Azure::Data::Cosmos`
- `Azure::Identity::ActiveDirectory`
- `Azure::Iot::DeviceProvisioning`
- `Azure::Storage::Blobs`
- `Azure::Messaging::NotificationHubs` (the client library for Notification Hubs)
- `Azure::Management::Messaging::NotificationHubs` (the management library for Notification Hubs)

Here are some namespaces that do not meet the guidelines:

- `microsoft::azure::CosmosDB` (not in the `Azure` namespace and does not use grouping, uses lowercase letters)
- `azure::mixed_reality::kinect` (the grouping is not in the approved list and uses snake_case)
- `Azure::Iot::IotHub::DeviceProvisioning` (too many levels in the group)

### Class Types (including `union`s and `struct`s)

Throughout this section, *class types* includes types with *class-key* `struct` or *class-key* `union`, consistent with the [C++ Standard](http://eel.is/c++draft/class#pre-4).

{% include requirement/MUST id="cpp-design-naming-classes" %} name class types with **PascalCase**.

{% include requirement/MUST id="cpp-design-naming-classes-public-protected-variables" %} name `public` and `protected` member variables with **PascalCase**.

{% include requirement/MUST id="cpp-design-naming-classes-public-variables" %} name `private` member variables with an `m_` prefix, followed by a **camelCase** name. For example, `m_timeoutMs`.

{% include requirement/MUST id="cpp-design-naming-classes-functions" %} name member functions with **PascalCase**, except where the C++ Standard forbids this. For example, `UploadBlob`, or `operator[]`.

{% include requirement/SHOULD id="cpp-design-naming-classes-no-struct-keyword" %} declare classes with only public members using *class-key* `struct`.
{% highlight cpp %}
// Good
struct OnlyPublicMembers {
    int Member;
};

// Bad
class OnlyPublicMembers {
public:
    int Member;
};
{% endhighlight %}

{% include requirement/SHOULD id="cpp-design-naming-classes-typedefs" %} define class types without using `typedef`s. For example:

{% highlight cpp %}
// Good: Uses C++ style class declaration:
struct IotClient {
    char* ApiVersion;
    IotClientCredentials* Credentials;
    int RetryTimeout;
};

// Bad: Uses C-style typedef:
typedef struct IotClient {
    char* ApiVersion;
    IotClientCredentials* Credentials;
    int RetryTimeout;
} AzIotClient;
{% endhighlight %}

### Variables

{% include requirement/MUST id="cpp-design-naming-variables-public-global" %} name namespace scope variables intended for user consumption with **PascalCase**.

{% include requirement/MUST id="cpp-design-naming-variables-constants" %} name namespace scope `const` or `constexpr` variables intended for user consumption with **PascalCase** and a `c_` prefix.

{% include requirement/MUST id="cpp-design-naming-variables-public-global" %} name namespace scope non-constant variables intended only for internal consumption with a `g_` prefix followed by **camelCase**. For example, `g_applicationContext`. Note that all such cases will be in a `Details` namespace or an unnamed namespace.

{% include requirement/MUST id="cpp-design-naming-variables-local" %} name local variables and parameters with **camelCase**.

{% highlight cpp %}
// Examples of the above naming rules:

namespace Azure { namespace Group { namespace Service {
int PublicNamespaceScopeVariable; // these should be used sparingly
const int c_PublicNamespaceScopeConstant = 42;
constexpr int c_OtherPublicNamespaceScopeConstant = 42;
constexpr char * c_PublicNamespaceScopeConstantPointer = nullptr; // const pointer to modifiable

void Function(int parameterName) {
    int localName;
}

namespace Details {
    extern int g_internalUseGlobal;
} // namespace Details

}}} // namespace Azure::Group::Service
{% endhighlight %}

{% include requirement/MUST id="cpp-design-naming-variables-typing-units" %} use types to enforce units where possible. For example, the C++ standard library provides `std::chrono` which makes time conversions automatic.
{% highlight cpp %}
// Bad
uint32 Timeout;

// Good
std::chrono::milliseconds Timeout;
{% endhighlight %}

{% include requirement/MUST id="cpp-design-naming-naming-units" %} include units in names when a type based solution to enforce units is not present.  If a variable represents weight, or some other unit, then include the unit in the name so developers can more easily spot problems.  For example:

{% highlight cpp %}
// Bad
uint32 Timeout;
uint32 MyWeight;

// Good
std::chrono::milliseconds Timeout;
uint32 MyWeightKg;
{% endhighlight %}

{% include requirement/MUST id="cpp-design-naming-variables-one-per-line" %} Declare or define each variable on its own line, except when declaring bitfields. An exception can be made when declaring bitfields (to clarify that the variable is a part of one bitfield). The use of bitfields in general is discouraged.

### Enums and Enumerators

{% include requirement/MUST id="cpp-design-naming-enum" %} name `enum class`es and enumerators using **PascalCase**.

{% include requirement/MUST id="cpp-design-naming-enum-class" %} use `enum class` for enumerations. For example:

{% highlight cpp %}
enum class PinState {
    Off,
    On
};
{% endhighlight %}

### Functions

{% include requirement/MUST id="cpp-design-naming-functions" %} name functions with **PascalCase**. For example:

{% highlight cpp %}
namespace Azure { namespace Group { namespace Service {
namespace Details {
// Part of the private API
[[nodiscard]] int64_t ComputeHash(int32_t a, int32_t b) noexcept;
} // namespace Details

// Part of the public API
[[nodiscard]] CatHerdClient CatHerdCreateClient(char* herdName);

// Bad - private API in public namespace.
[[nodiscard]] int64_t ComputeHash(int32_t a, int32_t b) noexcept;
}}} // namespace Azure::Group::Service
{% endhighlight %}

{% include requirement/SHOULD id="cpp-design-naming-functions-noexcept" %} declare all functions that can never throw exceptions `noexcept`.

### Templates

{% include requirement/MUST id="cpp-design-naming-templates" %} name function templates and class templates the same as one would name non-templates.

{% include requirement/MUST id="cpp-design-naming-templates-parameters" %} name template arguments with **PascalCase**.

### Macros

{% include requirement/SHOULD id="cpp-design-naming-macros-avoid" %} avoid use of macros. It is acceptable to use macros in the following situations. Use outside of these situations should contact the Azure Review Board.

* Platform, compiler, or other environment detection (for example, `_WIN32` or `_MSC_VER`).
* Emission or suppression of diagnostics.
* Emission or supression of debugging asserts.
* Import declarations. (`__declspec(dllimport)`, `__declspec(dllexport)`)

> TODO: Need to involve Charlie in how we want to talk about import declarations

{% include requirement/MUST id="cpp-design-naming-macros-caps" %} name macros with **ALL_CAPITAL_SNAKE_CASE**.

{% include requirement/MUST id="cpp-design-naming-macros-form" %} prepend macro names with `AZ_<SERVICENAME>` to make macros unique.

{% include requirement/MUSTNOT id="cpp-design-naming-macros-functions" %} use macros where an inline function or function template would achieve the same effect. Macros are not required for code efficiency.

{% highlight cpp %}
// Bad
##define MAX(a,b) ((a > b) ? a : b)

// Good
template<class T>
[[nodiscard]] inline T Max(T x, T y) {
    return x > y ? x : y;
}
{% endhighlight %}

{% include requirement/MUSTNOT id="cpp-design-naming-macros-donoevil" %} change syntax via macro substitution.  It [makes the program unintelligible](https://gist.github.com/aras-p/6224951) to all but the perpetrator.

## Physical Design

> TODO: Move this to implementation or move the headers discussion from implementation here

{% include requirement/SHOULD id="cpp-design-physical-include-quotes" %} include files using quotes (") for files within the same git repository, and angle brackets (<>) for external dependencies.

{% include requirement/SHOULD id="cpp-design-physical-unnamed-namespace" %} declare all types that are only used within the same `.cpp` file in an unnamed namespace. For example:

{% highlight cpp %}
namespace {
struct HashComputation {
    int InternalBookkeeping;
};
} // unnamed namespace
{% endhighlight %}

## Logical Design

### Type Safety Recommendations

{% include requirement/MUST id="cpp-design-logical-rule-of-zero" %} In class types, implement the "rule of zero", the "rule of 3", or the "rule of 5". That is, of the special member functions, a type should implement exactly one of the following:

* No copy constructor, no copy assignment operator, no move constructor, no move assignment operator, or destructor.
* A copy constructor, a copy assignment operator, no move constructor, no move assignment operator, and a destructor.
* A copy constructor, a copy assignment operator, a move constructor, a move assignment operator, and a destructor.

This encourages use of resource managing types like std::unique_ptr (which implements the rule of 5) as a compositional tool in more complex data models that implement the rule of zero.

{% include requirement/MUST id="cpp-design-logical-initialize-all-data" %} provide types which are usable when default-initialized. (That is, every constructor must initialize all type invariants, not assume members have default values of 0 or similar.)

{% highlight cpp %}
class TypeWithInvariants {
    int m_member;
public:
    TypeWithInvariants() noexcept : member(0) {} // Good: initializes all parts of the object
    [[nodiscard]] int Next() noexcept  {
        return m_member++;
    }
};

class BadTypeWithInvariants {
    int m_member;
public:
    BadTypeWithInvariants() {} // Bad: Does not initialize all parts of the object
    int Next() {
        return m_member++;
    }
};

void TheCustomerCode() {
    TypeWithInvariants a{}; // value-initializes a TypeWithInvariants, OK
    TypeWithInvariants b; // default-initializes a TypeWithInvariants, we want this to be OK
    BadTypeWithInvariants c{}; // value-initializes a BadTypeWithInvariants, OK
    BadTypeWithInvariants d; // default-initializes a BadTypeWithInvariants, this will trigger
                             // undefined behavior if anyone calls d.Next()
}
{% endhighlight %}


{% include requirement/MUST id="cpp-design-logical-no-getters-or-setters" %} define getters and setters for data transfer objects.  Expose the members directly to users unless you need to enforce some constraints on the data.  For example:
{% highlight cpp %}
// Good - no restrictions on values
struct ExampleRequest {
    int RetryTimeoutMs;
    const char* Text;
};

// Bad - no restrictions on parameters and access is not idiomatic
class ExampleRequest {
    int m_retryTimeoutMs;
    const char* m_text;
public:
    [[nodiscard]] int GetRetryTimeoutMs() const noexcept {
        return m_retryTimeoutMs;
    }
    void SetRetryTimeoutMs(int i) noexcept {
        m_retryTimeoutMs = i;
    }
    [[nodiscard]] const char* GetText() const noexcept {
        return m_text;
    }
    void SetText(const char* i) noexcept {
        m_text = i;
    }
};

// Good - type maintains invariants
class TypeWhichEnforcesDataRequirements {
    size_t m_size;
    int* m_data;
public:
    [[nodiscard]] size_t GetSize() const noexcept {
        return m_size;
    }
    void AddData(int i) noexcept {
        m_data\[m_size++\] = i;
    }
};

// Also Good
class TypeWhichClamps {
    int m_retryTimeout;
public:
    [[nodiscard]] int GetRetryTimeout() const noexcept {
        return m_retryTimeout;
    }
    void SetRetryTimeout(int i) noexcept {
        if (i < 0) i = 0; // clamp i to the range [0, 1000]
        if (i > 1000) i = 1000;
        m_retryTimeout = i;
    }
};

{% endhighlight %}

{% include requirement/MUST id="cpp-design-logical-optimize-position" %} declare variables in structures organized by use in a manner that minimizes memory wastage because of compiler alignment issues and size.  All things being equal, use alphabetical ordering.

{% highlight cpp %}
// Bad
struct Foo {
    int A; // the compiler will insert 4 bytes of padding after A to align B
    char *B;
    int C;
    char *D;
};

// Good
struct Foo {
    int A; // C is now stored in that padding
    int C;
    char *B;
    char *D;
};
{% endhighlight %}

{% include requirement/MUSTNOT id="cpp-design-logical-enumsareinternal" %} use enums to model any data sent to the service. Use enums only for types completely internal to the client library. For example, an enum to disable Nagle's algorithm would be OK, but an enum to ask the service to create a particular entity kind is not.

### Const and Reference members

{% include requirement/MUSTNOT id="cpp-design-logical-no-const-or-reference-members" %} declare types with const or reference members. Const and reference members artificially make your types non-Regular as they aren't assignable, and have surprising interactions with C++ Core language rules. For example, many accesses to const or reference members would need to involve use of `std::launder` to avoid undefined behavior, but `std::launder` was added in C++17, a later version than the SDKs currently target. See C++ Core Working Group [CWG1116 "Aliasing of union members"](http://www.open-std.org/jtc1/sc22/wg21/docs/cwg_defects.html#1116), [CWG1776 "Replacement of class objects containing reference members"](http://www.open-std.org/jtc1/sc22/wg21/docs/cwg_defects.html#1776), and [P0137R1 "Replacement of class objects containing reference members"](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2016/p0137r1.html) for additional details.

If you want a type to provide effectively const data except assignment, declare all your member functions const. Const member functions only get a const view of the class' data.

{% highlight cpp %}
// Bad
class RetrySettings {
    const int m_maxRetryCount;
public:
    int GetMaxRetryCount() {
        // intent: disallow m_maxRetryCount = aDifferentValue;
        return m_maxRetryCount;
    }
};

// Good
class RetrySettings {
    int m_maxRetryCount;
public:
    int GetMaxRetryCount() const {
        // still prohibits m_maxRetryCount = aDifferentValue; without making RetrySettings un-assignable
        return m_maxRetryCount;
    }
};
{% endhighlight %}

### Integer sizes

The following integer rules are listed in rough priority order. Integer size selections are primarily driven by service future compatibility. For example, just because today a service might have a 2 GiB file size limit does not mean that it will have such a limit forever. We believe 64 bit length limits will be sufficient for sizes an individual program works with for the foreseeable future.

{% include requirement/MUST id="cpp-design-logical-integer-files" %} Represent file sizes with `int64_t`, even on 32 bit platforms.

{% include requirement/MUST id="cpp-design-logical-integer-memory-buffers" %} Represent memory buffer sizes with `size_t` or `ptrdiff_t` as appropriate for the environment. Between the two, choose the type likely to need the fewest conversions in application. For example, we would prefer signed `ptrdiff_t` in most cases because signed integers behave like programmers expect more consistently, but the SDK will need to transact with `malloc`, `std::vector`, and/or `std::string` which all speak unsigned `size_t`.

{% include requirement/MUST id="cpp-design-logical-integer-service-values" %} Represent any other integral quantity passed over the wire to a service using `int64_t`, even if the service uses a 32 bit constant internally today.

{% include requirement/MUSTNOT id="cpp-design-logical-integer-not-int" %} Use `int` under any circumstances, including `for` loop indexes. Those should usually use `ptrdiff_t` or `size_t` under the buffer size rule above.

{% include requirement/MAY id="cpp-design-logical-integer-otherwise" %} Use any integer type in the `intN_t` or `uintN_t` family as appropriate for quantities not enumerated above, such as calculated values internal to the SDK such as retry counts.

### Secure functions

{% include requirement/SHOULDNOT id="cpp-design-logical-no-ms-secure-functions" %} use [Microsoft security enhanced versions of CRT functions](https://docs.microsoft.com/cpp/c-runtime-library/security-enhanced-versions-of-crt-functions) to implement APIs that need to be portable across many platforms. Such code is not portable and is not compatible with either the C or C++ Standards. See [arguments against]( http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1967.htm).

> TODO: Verify with the security team, and what are the alternatives?

### Client interface

> TODO: This section needs to be driven by code in the Core library.

#### Network requests

> TODO: This section needs to be driven by code in the Core library.

#### Authentication

Azure services use a variety of different authentication schemes to allow clients to access the service. Conceptually, there are two entities responsible in this process: a credential and an authentication policy.  Credentials provide confidential authentication data.  Authentication policies use the data provided by a credential to authenticate requests to the service.

{% include requirement/MUST id="cpp-design-logical-client-support-all-auth-techniques" %} support all authentication techniques that the service supports and are available to a client application (as opposed to service side).  C is used only for client applications when talking to Azure, so some authentication techniques may not be valid.

{% include requirement/MUST id="cpp-design-logical-client-use-azure-core" %} use credential and authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="cpp-design-logical-client-prefer-token-auth" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service in a non-blocking atomic manner for each authentication scheme that does not have an implementation in Azure Core.

{% include requirement/MUST id="cpp-apisurface-auth-in-constructors" %} provide service client constructors or factories that accept any supported authentication credentials.

{% include requirement/SHOULDNOT id="cpp-design-logical-client-surface-no-connection-strings" %} support providing credential data via a connection string. Connection string interfaces should be provided __ONLY IF__ the service provides a connection string to users via the portal or other tooling.

{% include requirement/MUSTNOT id="cpp-design-logical-client-surface-no-connection-string-ctors" %} support constructing a service client with a connection string unless such connection string. Provide a `CreateFromConnectionString` static member function which returns a client instead to encourage customers to choose non-connection-string-based authentication.

#### Response formats

Requests to the service fall into two basic groups - methods that make a single logical request, or a deterministic sequence of requests.  An example of a *single logical request* is a request that may be retried inside the operation.  An example of a *deterministic sequence of requests* is a paged operation.

The *logical entity* is a protocol neutral representation of a response. For HTTP, the logical entity may combine data from headers, body and the status line. A common example is exposing an ETag header as a property on the logical entity in addition to any deserialized content from the body.

{% include requirement/MUST id="cpp-design-logical-client-return-logical-entities" %} optimize for returning the logical entity for a given request. The logical entity MUST represent the information needed in the 99%+ case.

{% include requirement/MUST id="cpp-design-logical-client-expose-raw" %} *make it possible* for a developer to get access to the complete response, including the status line, headers and body. The client library MUST follow the language specific guidance for accomplishing this.

For example, you may choose to do something similar to the following:

{% highlight cpp %}
namespace Azure { namespace Group { namespace Service {
struct JsonShortItem {
    // JSON decoded structure.
};

struct JsonShortPagedResults {
    uint32 Size;
    JsonShortItem* Items;
};

struct JsonShortRawPagedResults {
    HTTP_HEADERS* Headers;
    uint16 StatusCode;
    byte* RawBody;
    JsonShortPagedResults* Results;
};

class ShortItemsClient {
    JsonShortPagedResults* JsonGetShortListItems() const;
    JsonShortRawPagedResults* JsonGetShortListItemsWithResponse(client, /* extra params */);
};
}}} // namespace Azure::Group::Service
{% endhighlight %}

{% include requirement/MUST id="cpp-design-logical-client-document-raw-stream" %} document and provide examples on how to access the raw and streamed response for a given request, where exposed by the client library.  We do not expect all methods to expose a streamed response.

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="cpp-design-logical-client-no-headers-if-confusing" %} return headers and other per-request metadata unless it is obvious as to which specific HTTP request the methods return value corresponds to.

{% include requirement/MUST id="cpp-design-logical-client-expose-data-for-composite-failures" %} provide enough information in failure cases for an application to take appropriate corrective action.

#### Pagination

Although object-orientated languages can eschew low-level pagination APIs in favor of high-level abstractions, C acts as a lower level language and thus embraces pagination APIs provided by the service.  You should work within the confines of the paging system provided by the service.

{% include requirement/MUST id="cpp-design-logical-client-pagination-use-paging" %} export the same paging API as the service provides.

{% include requirement/MUST id="cpp-design-logical-client-pagination-cpp-last-page" %} indicate in the return type if the consumer has reached the end of the result set.

{% include requirement/MUST id="cpp-design-logical-client-pagination-size-of-page" %} indicate in the return type how many items were returned by the service, and have a list of those items for the consumer to iterate over.

#### Enumerations

{% include requirement/MUST id="cpp-design-logical-client-enumerations-no-enums" %} use `enum` or `enum class` for values shared "over the wire" with a service, to support future compatibility with the service where additional values are added. Such values should be persisted as strings in client data structures instead.

{% include requirement/MAY id="cpp-design-logical-client-enumerations-enumish-pattern" %} provide an 'extensible enum' pattern for storing service enumerations which provides reasonable constant values. This pattern stores the value as a string but provides public static member fields with the individual values for customer consumption. For example:

{% highlight cpp %}
#include <azure.hpp> // for Azure::Core::Details::LocaleInvariantCaseInsensitiveEqual
#include <utility> // for std::move
namespace Azure { namespace Group { namespace Service {

// an "Extensible Enum" type
class KeyType {
    std::string m_Value;
public:
    // Provide `explicit` conversion from string or types convertible to string:
    explicit KeyType(const std::string& value) : m_Value(value) { }
    explicit KeyType(std::string&& value) : m_Value(std::move(value)) { }
    explicit KeyType(const char* value) : m_Value(value) { }

    // Provide an equality comparison. If the service treats the enumeration case insensitively,
    // use LocaleInvariantCaseInsensitiveEqual to prevent differing locale settings from affecting
    // the SDK's behavior:
    bool operator==(const KeyType& other) const noexcept {
        return Azure::Core::Details::LocaleInvariantCaseInsensitiveEqual(m_Value, other.m_Value);
    }

    bool operator!=(const KeyType& other) const noexcept { return !(*this == other); }

    // Provide a "Get" accessor
    const std::string& Get() const noexcept { return mValue; }

    // Provide your example values as static const members
    const static KeyType Ec;
    const static KeyType EcHsm;
    const static KeyType Rsa;
    const static KeyType RsaHsm;
    const static KeyType Oct;
};
}}} // namespace Azure::Group::Service


// in a .cpp file:
namespace Azure { namespace Group { namespace Service {
const KeyType KeyType::Ec = "EC";
const KeyType KeyType::EcHsm = "EC-HSM";
const KeyType KeyType::Rsa = "RSA";
const KeyType KeyType::RsaHsm = "RSA-HSM";
const KeyType KeyType::Oct = "oct";
}}} // namespace Azure::Group::Service
{% endhighlight %}

### Error handling

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

{% include requirement/MUSTNOT id="cpp-design-logical-errorhandling-actofgod-no-return" %} return an error to the caller.

{% include requirement/MUST id="cpp-design-logical-errorhandling-actofgod-crash" %} crash, if possible. This means calling some form of fast failing function, like `abort`.

Note: if your client library needs to be resilient to these kinds of errors you must either provide a fallback system, or construct your code in a way to facilitate proving that such errors can not occur.

#### Pre-conditions
{% include requirement/MAY id="cpp-design-logical-errorhandling-prec-check" %} check preconditions on function entry.

{% include requirement/MAY id="cpp-design-logical-errorhandling-prec-disablecheck" %} privide a means to disable precondition checks in release / optimized builds.

{% include requirement/MUST id="cpp-design-logical-errorhandling-prec-crash" %} crash, if possible. This means calling some form of fast failing function, like `abort`.

{% include requirement/MUSTNOT id="cpp-design-logical-errorhandling-prec-exceptions" %} throw a C++ exception.

#### Post Conditions

{% include requirement/SHOULDNOT id="cpp-design-logical-errorhandling-postc-check" %} check post-conditions in a way that changes the computational complexity of the function.

{% include requirement/MUST id="cpp-design-logical-errorhandling-postc-disablecheck" %} provide a way to disable postcondition checks, and omit checking code from built binaries.

{% include requirement/MUST id="cpp-design-logical-errorhandling-postc-crash" %} crash, if possible. This means calling some form of fast failing function, like `abort`.

{% include requirement/MUSTNOT id="cpp-design-logical-errorhandling-postc-exceptions" %} throw a C++ exception.

#### Heap Exhaustion (Out of Memory)

{% include requirement/MAY id="cpp-design-logical-errorhandling-oom-crash" %} crash. For example, this may mean dereferencing a nullptr returned by malloc, or explicitly checking and calling abort.

Note that on some comonly deployed platforms like Linux, handling heap exhaustion from user mode is not possible in a default configuration.

{% include requirement/MAY id="cpp-design-logical-errorhandling-oom-bad-alloc" %} propagate a C++ exception of type `std::bad_alloc` when encountering an out of memory condition. We do not expect the program to continue in a recoverable state after this occurs. Note that most standard library facilities and the built in `operator new` do this automatically, and we want to allow use of other facilities that may throw here.

{% include requirement/MUSTNOT id="cpp-design-logical-errorhandling-oom-throw" %} throw bad_alloc from the SDK code itself.

#### Recoverable errors

{% include requirement/MUST id="cpp-design-logical-errorhandling-recov-reporting" %} report errors by throwing C++ exceptions defined in the Azure C++ Core Library.

> TODO: The Core library needs to provide exceptions for the common failure modes, e.g. the same values as `az_result` in the C SDK.

For example:

{% highlight cpp %}
class Herd {
  bool m_hasShyCats;
  int m_numCats;
public:
  void CountCats(int* cats) {
    if(m_hasShyCats) {
      throw std::runtime_error("shy cats are not allowed");
    }
    *cats = m_numCats;
  }
};
{% endhighlight %}

{% include requirement/MUST id="cpp-design-logical-errorhandling-recov-error" %} produce a recoverable error when any HTTP request fails with an HTTP status code that is not defined by the service/Swagger as a successful status code.

{% include requirement/MUST id="cpp-design-logical-errorhandling-recov-document" %} document all exceptions each function and its transitive dependencies may throw, except for `std::bad_alloc`.

#### C++ Exceptions

{% include requirement/MUSTNOT id="cpp-design-logical-errorhandling-exceptions-other" %} `throw` exceptions, except those from the Azure C++ Core library as described in the error handling section.

{% include requirement/MUST id="cpp-design-logical-errorhandling-exceptions" %} propagate exceptions thrown by user code, callbacks, or dependencies. Assume any user-provided callback will propagate C++ exceptions unless the SDK documents that the callback must be completely non-throwing.

{% highlight cpp %}
template<class Callback>
void ApiFunc(const Callback& c) {
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
