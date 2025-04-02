---
title: "C++ Guidelines: Implementation"
keywords: guidelines cpp
permalink: cpp_implementation.html
folder: cpp
sidebar: general_sidebar
---

## API Implementation

This section describes guidelines for implementing Azure SDK client libraries. Please note that some of these guidelines are automatically enforced by code generation tools.

### Service Client

Service clients are the main starting points for developers calling Azure services with the Azure SDK. Each client library should have at least one client, so it’s easy to discover. The guidelines in this section describe patterns for the design of a service client.

When configuring your client library, particular care must be taken to ensure that the consumer of your client library can properly configure the connectivity to your Azure service both globally (along with other client libraries the consumer is using) and specifically with your client library.

#### Service Methods

Each supported language has an Azure Core library that contains common mechanisms for cross cutting concerns such as configuration and doing HTTP requests.

{% include requirement/MUST id="cpp-api-service-http-pipeline" %} use the HTTP pipeline component within `Azure::Core` namespace for communicating to service REST endpoints.

##### HttpPipeline

The following example shows a typical way of using `HttpPipeline` to implement a service call method. The `HttpPipeline` will handle common HTTP requirements such as the user agent, logging, distributed tracing, retries, and proxy configuration.

##### HttpPipelinePolicy/Custom Policies

The HTTP pipeline includes a number of policies that all requests pass through.  Examples of policies include setting required headers, authentication, generating a request ID, and implementing proxy authentication.  `HttpPipelinePolicy` is the base type of all policies (plugins) of the `HttpPipeline`. This section describes guidelines for designing custom policies.

Some services may require custom policies to be implemented. For example, custom policies may implement fall back to secondary endpoints during retry, request signing, or other specialized authentication techniques.

{% include requirement/MUST id="cpp-pipeline-core-policies" %} use the policy implementations in `Azure::Core` whenever possible.

{% include requirement/MUST id="cpp-custom-policy-review" %} review the proposed policy with the Azure SDK [Architecture Board]. There may already be an existing policy that can be modified/parameterized to satisfy your need.

{% include requirement/MUST id="cpp-custom-policy-thread-safe" %} ensure thread-safety for custom policies. A practical consequence of this is that you should keep any per-request or connection bookkeeping data in the context rather than in the policy instance itself.

{% include requirement/MUST id="cpp-pipeline-document-policies" %} document any custom policies in your package. The documentation should make it clear how a user of your library is supposed to use the policy.

#### Service Method Parameters

##### Parameter Validation

See [general parameter validation guidelines](introduction.md#cpp-parameters).

{% include requirement/MUSTNOT id="general-parameter-validation-service" %} validate service parameters.  This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

### Supporting Types

#### Serialization {#cpp-usage-json}

##### JSON Serialization

#### Enumeration-like Structs

As described in [general enumeration guidelines](introduction.md#cpp-enums), you should use `enum` types whenever passing or deserializing a fixed well-known set of values to or from the service.
There may be times, however, where a `struct` is necessary to capture an extensible value from the service even if well-known values are defined,
or to pass back to the service those same or other user-supplied values:

- The value is retrieved and deserialized from service, and may contain a value not supported by the client library.
- The value is roundtripped: the value is retrieved and deserialized from the service, and may later be serialized and sent back to the server.

{% include requirement/MUST id="cpp-design-naming-enum" %} name `enum class`es and enumerators using **PascalCase**.

{% include requirement/MUST id="cpp-design-naming-enum-class" %} use `enum class` for enumerations. For example:

{% highlight cpp %}
enum class PinState {
    Off,
    On
};
{% endhighlight %}

Note that modifying the enumerators in an enumeration is considered a breaking change, if the enumerators in an enumeration may change over time, use an Extendable Enumeration instead.

##### Extendable Enumerations

When the set of values in an enumeration is *not* fixed, the `Azure::Core::_internal::ExtendableEnumeration` template should be used.

{% highlight cpp %}
class MyEnumeration final : public ExtendableEnumeration<MyEnumeration> {
public:
  explicit MyEnumeration(std::string value) :
     ExtendableEnumeration(std::move(value)) {}
   MyEnumeration() = default;
   static const MyEnumeration Enumerator1;
   static const MyEnumeration Enumerator2;
   static const MyEnumeration Enumerator3;
};

{% endhighlight %}

The ExtendableEnumeration type contains the methods for comparison, copying, and conversion to and from string values.

#### Using Azure Core Types

##### Implementing Subtypes of Operation\<T\> {#cpp-implement-operation}

Subtypes of `Operation<T>` are returned from service client methods invoking long running operations.

{% include requirement/MUST id="cpp-lro-return" %} check the value of `IsDone` in subclass implementations of `PollInternal` and `PollUntilDoneInternal` and immediately return the result of `GetRawResponse` if it is true.

{% include requirement/MUST id="cpp-lro-exceptions" %} throw from methods on `Operation<T>` subclasses in the following scenarios.

- If an underlying service operation call from `Poll` or `PollUntilDone` throws, re-throw `RequestFailedException` or its subtype.
- If the operation completes with a non-success result, throw `RequestFailedException` or its subtype from `Poll` or `PollUntilDone`.

  - Include any relevant error state information in the exception message.

- If the ```Value``` property is evaluated after the operation failed (```HasValue``` is false and ```IsDone``` is true) throw the same exception as the one thrown when the operation failed.

- If the ```Value``` property is evaluated before the operation is complete (```IsDone``` is false) throw ```TODO: What to throw```.
  - The exception message should be: "The operation has not yet completed."

##### Azure::Core::Context

{% include requirement/MUST id="cpp-always-pass-context-by-reference" %} always pass `Azure::Core::Context` types by reference, preferably by `const` reference.
{% include requirement/MUSTNOT id="cpp-must-not-cancel-input" %} cancel the input Context parameter.

The cancellation requirement stems from the nature of an `Azure::Core::Context` object - there may be multiple `Azure::Core::Context` objects which share the same cancellation context - cancelling one cancels all of the shared contexts. To avoid this, a service client should instead create a new `Azure::Core::Context` from the original context using either `Context::WithValue`, `Context::WithDeadline` and cancel that new context.

### SDK Feature Implementation

#### Configuration

{% include requirement/MUST id="cpp-config-global" %} use relevant global configuration settings either by default or when explicitly requested to by the user, for example by passing in a configuration object to a client constructor.

{% include requirement/MUST id="cpp-config-client" %} allow different clients of the same type to use different configurations.

{% include requirement/MUST id="cpp-config-optout" %} allow consumers of your service clients to opt out of all global configuration settings at once.

{% include requirement/MUST id="cpp-config-global-override" %} allow all global configuration settings to be overridden by client-provided options. The names of these options should align with any user-facing global configuration keys.

{% include requirement/MUSTNOT id="cpp-config-behavior-changes" %} change behavior based on configuration changes that occur after the client is constructed. Hierarchies of clients inherit parent client configuration unless explicitly changed or overridden. Exceptions to this requirement are as follows:

1. Log level, which must take effect immediately across the Azure SDK.
2. Tracing on/off, which must take effect immediately across the Azure SDK.

#### Configuration via Environment Variables

{% include requirement/MUST id="cpp-envvars-prefix" %} prefix Azure-specific environment variables with `AZURE_`.

{% include requirement/MAY id="cpp-envvars-client-prefix" %} use client library-specific environment variables for portal-configured settings which are provided as parameters to your client library. This generally includes credentials and connection details. For example, Service Bus could support the following environment variables:

* `AZURE_SERVICEBUS_CONNECTION_STRING`
* `AZURE_SERVICEBUS_NAMESPACE`
* `AZURE_SERVICEBUS_ISSUER`
* `AZURE_SERVICEBUS_ACCESS_KEY`

Storage could support:

* `AZURE_STORAGE_ACCOUNT`
* `AZURE_STORAGE_ACCESS_KEY`
* `AZURE_STORAGE_DNS_SUFFIX`
* `AZURE_STORAGE_CONNECTION_STRING`

{% include requirement/MUST id="cpp-envvars-approval" %} get approval from the [Architecture Board] for every new environment variable.

{% include requirement/MUST id="cpp-envvars-syntax" %} use this syntax for environment variables specific to a particular Azure service:

* `AZURE_<ServiceName>_<ConfigurationKey>`

Where _ServiceName_ is the canonical shortname without spaces, and _ConfigurationKey_ refers to an unnested configuration key for that client library.

{% include requirement/MUSTNOT id="cpp-envvars-posix-compliance" %} use non-alpha-numeric characters in your environment variable names with the exception of underscore. This ensures broad interoperability.

#### Logging

Request logging will be done automatically by the `HttpPipeline`.  If a client library needs to add custom logging, follow the [same guidelines](implementation.md#general-logging) and mechanisms as the pipeline logging mechanism.  If a client library wants to do custom logging, the designer of the library must ensure that the logging mechanism is pluggable in the same way as the `HttpPipeline` logging policy.

{% include requirement/MUST id="dotnet-logging-follow-guidelines" %} follow [the logging section of the Azure SDK General Guidelines](implementation.md#general-logging) if logging directly (as opposed to through the `HttpPipeline`).

##### C++ Logging specific details

Client libraries must support robust logging mechanisms so that the consumer can adequately diagnose issues with the method calls and quickly determine whether the issue is in the consumer code, client library code, or service.

In general, our advice to consumers of these libraries is to establish logging in their preferred manner at the `WARNING` level or above in production to capture problems with the application, and this level should be enough for customer support situations.  Informational or verbose logging can be enabled on a case-by-case basis to assist with issue resolution.

{% include requirement/MUST id="cpp-logging-use-azurecore" %} use the Azure Core library for logging.

{% include requirement/MUST id="cpp-logging-pluggable-logger" %} support pluggable log handlers.

{% include requirement/MUST id="cpp-logging-console-logger" %} make it easy for a consumer to enable logging output to the console. The specific steps required to enable logging to the console must be documented.

{% include requirement/MUST id="cpp-logging-levels" %} use one of the following log levels when emitting logs: `Verbose` (details), `Informational` (things happened), `Warning` (might be a problem or not), and `Error`.

{% include requirement/MUST id="cpp-logging-failure" %} use the `Error` logging level for failures that the application is unlikely to recover from (out of memory, etc.).

{% include requirement/MUST id="cpp-logging-warning" %} use the `Warning` logging level when a function fails to perform its intended task. This generally means that the function will raise an exception.  Do not include occurrences of self-healing events (for example, when a request will be automatically retried).

{% include requirement/MAY id="cpp-logging-slowlinks" %} log the request and response (see below) at the `Warning` when a request/response cycle (to the start of the response body) exceeds a service-defined threshold.  The threshold should be chosen to minimize false-positives and identify service issues.

{% include requirement/MUST id="cpp-logging-info" %} use the `Informational` logging level when a function operates normally.

{% include requirement/MUST id="cpp-logging-verbose" %} use the `Verbose` logging level for detailed troubleshooting scenarios. This is primarily intended for developers or system administrators to diagnose specific failures.

{% include requirement/MUST id="cpp-logging-no-sensitive-info" %} only log headers and query parameters that are in a service-provided "allow-list" of approved headers and query parameters.  All other headers and query parameters must have their values redacted.

{% include requirement/MUST id="cpp-logging-requests" %} log request line and headers as an `Informational` message. The log should include the following information:

* The HTTP method.
* The URL.
* The query parameters (redacted if not in the allow-list).
* The request headers (redacted if not in the allow-list).
* An SDK provided request ID for correlation purposes.
* The number of times this request has been attempted.

{% include requirement/MUST id="cpp-logging-responses" %} log response line and headers as an `Informational` message.  The format of the log should be the following:

* The SDK provided request ID (see above).
* The status code.
* Any message provided with the status code.
* The response headers (redacted if not in the allow-list).
* The time period between the first attempt of the request and the first byte of the body.

{% include requirement/MUST id="cpp-logging-cancellations" %} log an `Informational` message if a service call is cancelled.  The log should include:

* The SDK provided request ID (see above).
* The reason for the cancellation (if available).

{% include requirement/MUST id="cpp-logging-exceptions" %} log exceptions thrown as a `Warning` level message. If the log level set to `Verbose`, append stack trace information to the message.

#### Distributed Tracing {#cpp-distributedtracing}

{% include requirement/MUST id="cpp-tracing-abstraction" %} abstract the underlying tracing facility, allowing consumers to use the tracing implementation of their choice.

{% include requirement/MUST id="cpp-tracing-span-per-call" %} create a new trace span for each API call.  New spans must be children of the span that was passed in.

#### Telemetry

Client library usage telemetry is used by service teams (not consumers) to monitor what SDK language, client library version, and language/platform info a client is using to call into their service. Clients can prepend additional information indicating the name and version of the client application.

{% include requirement/MUST id="cpp-http-telemetry-useragent" %} send telemetry information in the [User-Agent header] using the following format:

```
[<application_id> ]azsdk-cpp-<package_name>/<package_version> <platform_info>
```

- `<application_id>`: optional application-specific string. May contain a slash, but must not contain a space. The string is supplied by the user of the client library, e.g. "XCopy/10.0.4-Preview"
- `<package_name>`: client library (distribution) package name as it appears to the developer, replacing slashes with dashes and removing the Azure and cpp indicator.  For example, "azure-security-keyvault-secrets-cpp" would specify "azsdk-cpp-security-keyvault-secrets".
- `<package_version>`: the version of the package. Note: this is not the version of the service
- `<platform_info>`: information about the currently executing language runtime and OS, e.g. "MSVC/14.10.0(Windows-10-10.0.19041-SP0)"

{% include requirement/SHOULD id="cpp-http-telemetry-dynamic" %} send additional (dynamic) telemetry information as a semi-colon separated set of key-value types in the `X-MS-AZSDK-Telemetry` header.  For example:

```http
X-MS-AZSDK-Telemetry: class=BlobClient;method=DownloadFile;blobType=Block
```

The content of the header is a semi-colon key=value list.  The following keys have specific meaning:

* `class` is the name of the type within the client library that the consumer called to trigger the network operation.
* `method` is the name of the method within the client library type that the consumer called to trigger the network operation.

Any other keys that are used should be common across all client libraries for a specific service.  **DO NOT** include personally identifiable information (even encoded) in this header.  Services need to configure log gathering to capture the `X-MS-SDK-Telemetry` header in such a way that it can be queried through normal analytics systems.

### Testing

We believe testing is a part of the development process, so we expect unit and integration tests to be a part of the source code.  All components must be covered by automated testing, and developers should strive to test corner cases and main flows for every use case.

All code should contain, at least, requirements, unit tests, end-to-end tests, and samples.

Tests should be written using the [Google Test][https://google.github.io/googletest/] library.

### Language-specific other

Unlike many other programming languages, which have large runtimes, the C++ standard runtime is limited in functionality and scope. The standard library covers areas such as memory and string manipulation, standard input/output, floating point and others. However, many of the features required for modern applications and services; e.g. those required for networking and advanced memory management are not part of the standard library. Instead, many of those features are included in open source C++ libraries that are also cross-platform with good support for Windows, OSX and most Linux platforms. Because of that support and because Azure SDK implementations will need such functionality, it is expected that client libraries will take dependencies on these libraries.  Ensure the version matches to allow for compatibility when an application integrates multiple client libraries.

{% include requirement/MUST id="cpp-approved-dependencies" %} utilize the following libraries as needed for commonly required operations:

{% include_relative approved_dependencies.md %}

{% include requirement/MUSTNOT id="cpp-test-implicit-assign" %} use implicit assignment inside a test.  This is generally an accidental omission of the second `=` of the logical compare. The following is confusing and prone to error.

{% highlight cpp %}
if (a = b) { ... }
{% endhighlight %}

Does the programmer really mean assignment here? Sometimes yes, but usually no. Instead use explicit tests and avoid assignment with an implicit test. The recommended form is to do the assignment before doing the test:

{% highlight cpp %}
a = b;
if (a) { ... }
{% endhighlight %}

{% include requirement/MUSTNOT id="cpp-no-register" %} use the register keyword.  Modern compilers will put variables in registers automatically.

{% include requirement/MUST id="cpp-be-const-correct" %} be `const` correct.  C++ provides the `const` keyword to allow passing as parameters objects that cannot change to indicate when a method doesn't modify its object. Using `const` in all the right places is called "const correctness."

{% include requirement/MUST id="cpp-use-hashif" %} use `#if` instead of `#ifdef`.  For example:

{% highlight cpp %}
// Bad example
#ifdef DEBUG
    TemporaryDebuggerBreak();
#endif
{% endhighlight %}

Someone else might compile the code with turned-of debug info like:

{% highlight cpp %}
cc -c lurker.cc -DDEBUG=0
{% endhighlight %}

Alway use `#if` if you have to use the preprocessor. This works fine, and does the right thing, even if `DEBUG` is not defined at all (!)

{% highlight cpp %}
// Good example
#if DEBUG
    TemporaryDebuggerBreak();
#endif
{% endhighlight %}

If you really need to test whether a symbol is defined or not, test it with the `defined()` construct, which allows you to add more things later to the conditional without editing text that's already in the program:

{% highlight cpp %}
#if !defined(USER_NAME)
 #define USER_NAME "john smith"
#endif
{% endhighlight %}

{% include requirement/MUST id="cpp-large-comments" %}
Use `#if` to comment out large code blocks.

Sometimes large blocks of code need to be commented out for testing.  The easiest way to do this is with an `#if 0` block:

{% highlight cpp %}
void Example()
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

{% highlight cpp %}
#if NOT_YET_IMPLEMENTED
#if OBSOLETE
#if TEMP_DISABLED
{% endhighlight %}

Always add a short comment explaining why it is commented out.

{% include requirement/MUSTNOT id="cpp-" %} put data definitions in header files.  For example, this should be avoided:

{% highlight cpp %}
/* aheader.hpp */
int x = 0;
{% endhighlight %}

It's bad magic to have space consuming code silently inserted through the innocent use of header files.  It's not common practice to define variables in the header file, so it will not occur to developers to look for this when there are problems.  Instead, define the variable once in a source file and then use an `extern` statement to reference it in the header file.

{% include requirement/MUSTNOT id="cpp-no-magic-numbers" %} use magic numbers. A magic number is a bare naked number used in source code. It's magic because no-one will know what it means after a while.  This significantly reduces maintainability. For example:

{% highlight cpp %}
// Don't write this.
if (19 == foo) { RefundLotsMoney(); }}
else           { HappyDaysIKnowWhyIAmHere(); }
{% endhighlight %}

Instead of magic numbers, use a real name that means something. You can use `constexpr` for names. For example:

{% highlight cpp %}
constexpr int WE_GOOFED = 19;

if (WE_GOOFED == foo) { RefundLotsMoney(); }
else                  { HappyDaysIKnowWhyIAmHere(); }
{% endhighlight %}

{% include requirement/MUST id="cpp-check-syscall-errors" %} check every system call for an error return, unless you know you wish to ignore errors. For example, `printf` returns an error code but it is rarely relevant. Cast the return to (void) if you do not care about the error code.

{% highlight cpp %}
(void)printf("The return value is ignored");
{% endhighlight %}

{% include requirement/MUST id="cpp-include-errorstr" %} include the system error text when reporting system error messages.

{% include requirement/SHOULD id="cpp-use-cpp-core-guidelines" %} follow the [CPP Core Guidelines](https://github.com/isocpp/CppCoreGuidelines/blob/master/CppCoreGuidelines.md) whenever possible, with the following exceptions:

- List TBD.

#### Complexity Management

{% include requirement/SHOULD id="cpp-init-all-vars" %} Initialize all variables. Only leave them
uninitialized if there is a real performance reason to do so. Use static and dynamic analysis tools to
check for uninitialized access. You may leave "result" variables uninitialized so long as they clearly do
not escape from the innermost lexical scope.

{% include requirement/SHOULD id="cpp-function-size" %} limit function bodies to one page of code (40 lines, approximately).

{% include requirement/MUST id="cpp-document-null-bodies" %} document null statements.  Always document a null body for a `for` or `while` statement so that it is clear the null body is intentional.

{% include requirement/MUST id="cpp-use-explicit-compares" %} use explicit comparisons when testing for failure.  Use `if (FAIL != f())` rather than `if (f())`, even though FAIL may have the value 0 which C considers to be false.  An explicit test will help you out later when somebody decides that a failure return should be -1 instead of 0.

{% include requirement/MUSTNOT id="cpp-do-not-compare-booleans-against-true" %} compare boolean values with explicit comparisons. Rather than writing `if (f() == true)`, write `if (f())` - the result is clearer and more succinct. The same applies to objects that implement `operator bool()`

Explicit comparison should be used even if the comparison value will never change.  e.g. `if (!(bufsize % sizeof(int)))` should be written as `if (0 == (bufsize % sizeof(int))` to reflect the numeric (not boolean) nature of the test.

A frequent trouble spot is using `strcmp` to test for string equality.  You should **never** use a default action.  The preferred approach is to use an inline function:

{% highlight cpp %}
inline bool StringEqual(char *a, char *b) {
    return (0 == strcmp(a, b));
}
{% endhighlight %}

~ Should

{% include requirement/SHOULDNOT id="cpp-embedded-assign" %} use embedded assignments.  There is a time and a place for embedded assignment statements.  In some constructs, there is no better way to accomplish the results without making the code bulkier and less readable.

{% highlight cpp %}
while (EOF != (c = getchar())) {
    /* process the character */
}
{% endhighlight %}

However, one should consider the tradeoff between increased speed and decreased maintainability that results when embedded assignments are used in artificial places.

#### Templates

{% include requirement/MUST id="cpp-design-naming-templates" %} name function templates and class templates the same as one would name non-templates.

{% include requirement/MUST id="cpp-design-naming-templates-parameters" %} name template arguments with **PascalCase**.

#### Macros

{% include requirement/SHOULD id="cpp-design-naming-macros-avoid" %} avoid use of macros. It is acceptable to use macros in the following situations. Use outside of these situations should contact the Azure Review Board.

* Platform, compiler, or other environment detection (for example, `_WIN32` or `_MSC_VER`).
* Emission or suppression of diagnostics.
* Emission or supression of debugging asserts.
* Import declarations. (`__declspec(dllimport)`, `__declspec(dllexport)`)

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

#### Type Safety Recommendations

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
        m_data[m_size++] = i;
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
    int A; // the compiler will insert up to 4 bytes of padding after A to align B
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

#### Const and Reference members

{% include requirement/MUSTNOT id="cpp-design-logical-no-const-or-reference-members" %} declare types with const or reference members. Const and reference members artificially make your types non-Regular as they aren't assignable, and have surprising interactions with C++ Core language rules. For example, many accesses to const or reference members would need to involve use of `std::launder` to avoid undefined behavior, but `std::launder` was added in C++17, a later version than the SDKs currently target. See C++ Core Working Group [CWG1116 "Aliasing of union members"](https://www.open-std.org/jtc1/sc22/wg21/docs/cwg_defects.html#1116), [CWG1776 "Replacement of class objects containing reference members"](https://www.open-std.org/jtc1/sc22/wg21/docs/cwg_defects.html#1776), and [P0137R1 "Replacement of class objects containing reference members"](https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2016/p0137r1.html) for additional details.

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

#### Parameter passing rules

In general, all method parameters that are not POD should be passed by `const reference`.

#### Integer sizes

The following integer rules are listed in rough priority order. Integer size selections are primarily driven by service future compatibility. For example, just because today a service might have a 2 GiB file size limit does not mean that it will have such a limit forever. We believe 64 bit length limits will be sufficient for sizes an individual program works with for the foreseeable future.

{% include requirement/MUST id="cpp-design-logical-integer-files" %} Represent file sizes with `std::int64_t`, even on 32 bit platforms.

{% include requirement/MUST id="cpp-design-logical-integer-memory-buffers" %} Represent memory buffer sizes with `std::size_t` or `std::ptrdiff_t` as appropriate for the environment. Between the two, choose the type likely to need the fewest conversions in application. For example, we would prefer signed `std::ptrdiff_t` in most cases because signed integers behave like programmers expect more consistently, but the SDK will need to transact with `malloc`, `std::vector`, and/or `std::string` which all speak unsigned `std::size_t`.

{% include requirement/MUST id="cpp-design-logical-integer-service-values" %} Represent any other integral quantity passed over the wire to a service using `std::int64_t`, even if the service uses a 32 bit constant internally today.

{% include requirement/MUSTNOT id="cpp-design-logical-integer-not-int" %} Use `int` under any circumstances, including `for` loop indexes. Those should usually use `ptrdiff_t` or `size_t` under the buffer size rule above.

{% include requirement/MAY id="cpp-design-logical-integer-otherwise" %} Use any integer type in the `intN_t` or `uintN_t` family as appropriate for quantities not enumerated above, such as calculated values internal to the SDK such as retry counts.

#### Secure functions

{% include requirement/SHOULDNOT id="cpp-design-logical-no-ms-secure-functions" %} use [Microsoft security enhanced versions of CRT functions](https://docs.microsoft.com/cpp/c-runtime-library/security-enhanced-versions-of-crt-functions) to implement APIs that need to be portable across many platforms. Such code is not portable and is not compatible with either the C or C++ Standards. See [arguments against](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1967.htm).

#### Enumerations

{% include requirement/MUST id="cpp-design-logical-client-enumerations-no-enums" %} use `enum` or `enum class` for values shared "over the wire" with a service, to support future compatibility with the service where additional values are added. Such values should be persisted as strings in client data structures instead.

{% include requirement/MAY id="cpp-design-logical-client-enumerations-enumish-pattern" %} provide an 'extensible enum' pattern for storing service enumerations which provides reasonable constant values. This pattern stores the value as a string but provides public static member fields with the individual values for customer consumption. For example:

{% highlight cpp %}
#include <azure/core/strings.hpp> // for Azure::Core::Strings::LocaleInvariantCaseInsensitiveEqual
#include <utility> // for std::move
namespace Azure { namespace Group { namespace Service {

// an "Extensible Enum" type
class KeyType {
    std::string m_value;
public:
    // Provide `explicit` conversion from string or types convertible to string:
    explicit KeyType(const std::string& value) : m_value(value) { }
    explicit KeyType(std::string&& value) : m_value(std::move(value)) { }
    explicit KeyType(const char* value) : m_value(value) { }

    // Provide an equality comparison. If the service treats the enumeration case insensitively,
    // use LocaleInvariantCaseInsensitiveEqual to prevent differing locale settings from affecting
    // the SDK's behavior:
    bool operator==(const KeyType& other) const noexcept {
        return Azure::Core::Strings::LocaleInvariantCaseInsensitiveEqual(m_value, other.m_value);
    }

    bool operator!=(const KeyType& other) const noexcept { return !(*this == other); }

    // Provide a "Get" accessor
    const std::string& Get() const noexcept { return m_value; }

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
    const KeyType KeyType::Ec{"EC"};
    const KeyType KeyType::EcHsm{"EC-HSM"};
    const KeyType KeyType::Rsa{"RSA"};
    const KeyType KeyType::RsaHsm{"RSA-HSM"};
    const KeyType KeyType::Oct{"OCT"};
}}} // namespace Azure::Group::Service
{% endhighlight %}

#### Physical Design

{% include requirement/SHOULD id="cpp-design-physical-include-quotes" %} include files using quotes (") for files within the same git repository, and angle brackets (<>) for external dependencies.

{% include requirement/SHOULD id="cpp-design-physical-unnamed-namespace" %} declare all types that are only used within the same `.cpp` file in an unnamed namespace. For example:

{% highlight cpp %}
namespace {
struct HashComputation {
    int InternalBookkeeping;
};
} // unnamed namespace
{% endhighlight %}

#### Class Types (including `union`s and `struct`s)

Throughout this section, *class types* includes types with *class-key* `struct` or *class-key* `union`, consistent with the [C++ Standard](https://eel.is/c++draft/class#pre-4).

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

By convention, C++ Structs {% include requirement/SHOULDNOT id="cpp-structs-no-methods" %} define any methods. If a C++ object needs methods, it should be declared as a `class`.

#### Tooling

We use a common build and test pipeline to provide for automatic distribution of client libraries.  To support this, we need common tooling.

{% include requirement/MUST id="cpp-tooling-cmake" %} use [CMake](https://CMake.org/) v3.7 for your project build system.

Version 3.7 is the minimum version installed on the Azure Pipelines Microsoft hosted agents
(https://docs.microsoft.com/azure/devops/pipelines/agents/hosted)

{% include requirement/MUST id="cpp-tooling-cmake-targets" %} include the following standard targets:

* `build` to build the library
* `test` to run the unit test suite
* `docs` to generate reference documentation
* `all` to run all three targets

Include other targets as they appear useful during the development process.

{% include requirement/MUST id="cpp-tooling-cmake-settings1" %} use hidden visibility when building dynamic libraries. For CMake:

{% highlight cmake %}
set(CMAKE_C_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)
{% endhighlight %}

This allows you to use an export macro to export symbols. For example:

{% highlight cpp %}
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
generate_export_header(speech
    EXPORT_FILE_NAME azure/speech_export.hpp)
{% endhighlight %}

{% include requirement/MUST id="cpp-tooling-cpp-format" %} use [clang-format](https://clang.llvm.org/docs/ClangFormat.html) for formatting, with the following command-line options:

{% highlight bash %}
cpp-format -style=file -i <file> ...
{% endhighlight %}

Using `-i` does an in-place edit of the files for style.  There is [a Visual Studio extension](https://marketplace.visualstudio.com/items?itemName=LLVMExtensions.llvm-toolchain) that binds Ctrl-R Ctrl-F to this operation. Visual Studio 2019 includes this functionality by default.

{% include requirement/MUST id="cpp-tooling-cmake-docs" %} generate API documentation with `doxygen`.
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

{% include requirement/MUST id="cpp-tooling-cmake-samples" %} provide a CMake option of the form `<SDK_NAME>_BUILD_SAMPLES` that includes all samples in the build.  For example:

{% highlight cmake %}
if(AZURE_APPCONF_BUILD_SAMPLES)
    add_subdirectory(samples)
endif()
{% endhighlight %}

{% include requirement/MUSTNOT id="cpp-tooling-cmake-no-samples-by-default" %} install samples by default.

## Supported platforms

{% include requirement/MUST id="cpp-platform-min" %} support at least the following platforms and associated compilers when implementing your client library:

- Windows
- Unix-like operating systems (Linux, Unix, etc)
- OSX/iOS

As of 10/2024, the Azure SDK for C++ is currently tested against the following platforms:

| Operating System | Versions   | Architectures| Compiler | Compiler Version | Notes |
|------------------|------------|--------------|----------|-------------------|-------|
| Windows          | 2019, 2022 | x32, x64     | MSVC     | MSVC 16, MSVC 17  |       |
| OSX              | 14         | x64          | XCODE    | 15.4              |       |
| Linux - Ubuntu   | 2020.04, 2022.04 | x64    | GCC      | 8, 9              |       | 
| Linux - Ubuntu   | 2020.04, 2022.04 | x64    | clang    | 11, 13, 15        |       |

For a current list of supported platforms, see the [platform matrix](https://github.com/Azure/azure-sdk-for-cpp/blob/main/eng/pipelines/templates/stages/platform-matrix.json).


{% include requirement/SHOULD id="cpp-platform" %} support the following additional platforms and associated compilers when implementing your client library.

{% include requirement/SHOULDNOT id="cpp-cpp-extensions" %} use compiler extensions. Examples of extensions to avoid include:

* [MSVC compiler extensions](https://docs.microsoft.com/cpp/build/reference/microsoft-extensions-to-c-and-cpp)
* [clang language extensions](https://clang.llvm.org/docs/LanguageExtensions.html)
* [GNU C compiler extensions](https://gcc.gnu.org/extensions.html)

Use the appropriate options for each compiler to prevent the use of such extensions.

{% include requirement/MUST id="cpp-cpp-options" %} use compiler flags to identify warnings:

| Compiler      | Compiler Flags  |
| :------------ | --------------- |
| gcc           | `-Wall -Wextra` |
| cpp and XCode | `-Wall -Wextra` |
| MSVC          | `/W4`           |
