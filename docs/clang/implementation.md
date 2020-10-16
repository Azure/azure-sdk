---
title: "C Guidelines: Implementation"
keywords: guidelines clang
permalink: clang_implementation.html
folder: clang
sidebar: clang_sidebar
---

{% include draft.html content="The C Language guidelines are in DRAFT status" %}

## Supported platforms

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
* [GNU C compiler extensions](https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html)

Use the appropriate options for each compiler to prevent the use of such extensions.

{% include requirement/MUST id="clang-cpp-options" %} use compiler flags to identify warnings:

| Compiler                 | Compiler Flags   |
|:-------------------------|------------------|
| gcc                      | `-Wall -Wextra`  |
| Clang and XCode          | `-Wall -Wextra`   |
| MSVC                     | `/W4`            |

hen configuring your client library, particular care must be taken to ensure that the consumer of your client library can properly configure the connectivity to your Azure service both globally (along with other client libraries the consumer is using) and specifically with your client library.

### Client configuration

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
configuration such as environment variables or a config file. Keep in mind that many IOT devices
won't have a filesystem or an "environment block" to read from.

## Parameter validation

The service client will have several methods that perform requests on the service.  _Service parameters_ are directly passed across the wire to an Azure service.  _Client parameters_ are not passed directly to the service, but used within the client library to fulfill the request.  Examples of client parameters include values that are used to construct a URI, or a file that needs to be uploaded to storage.

{% include requirement/MUST id="clang-params-client-validation" %} validate client parameters.

{% include requirement/MUSTNOT id="clang-params-server-validation" %} validate service parameters.  This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUST id="clang-params-check-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service.  If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

## Network requests

> TODO: Implement the spirit of the general guidelines for network requests - explicitly, how to use Azure Core for making network requests

## Authentication

When implementing authentication, don't open up the consumer to security holes like PII (personally identifiable information) leakage or credential leakage.  Credentials are generally issued with a time limit, and must be refreshed periodically to ensure that the service connection continues to function as expected.  Ensure your client library follows all current security recommendations and consider an independent security review of the client library to ensure you're not introducing potential security problems for the consumer.

{% include requirement/MUSTNOT id="clang-implementing-no-persistence-auth" %}
persist, cache, or reuse security credentials.  Security credentials should be considered short lived to cover both security concerns and credential refresh situations.  

If your service implements a non-standard credential system (one that is not supported by Azure Core), then you need to produce an authentication policy for the HTTP pipeline that can authenticate requests given the alternative credential types provided by the client library.

{% include requirement/MUST id="clang-implementing-secure-auth-erase" %} Use a "secure" function to zero authentication or authorization credentials as soon as possible once they are no longer needed. Examples of such functions
include: `SecureZeroMemory`, `memset_s`, and `explicit_bzero`. Examples of insecure functions include `memset`. An optimizer may notice that the credentials are
never accessed again, and optimize away the call to `memset`, resulting in the credentials remaining in memory.

{% include requirement/MUST id="clang-implementing-auth-policy" %}
provide a suitable authentication policy that authenticates the HTTP request in the HTTP pipeline when using non-standard credentials.  This includes custom connection strings, if supported.

> TODO: The authentication policies are generally within the Azure Core / Identity library - that does not exist yet.

## Logging

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

## Distributed tracing

> TODO: Implement the spirit of the general guidelines for distributed tracing.

> TODO: Distributed Tracing is explicitly removed?

## Dependencies

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

### C language specifics

Unlike many other programming languages, which have large runtimes, the C standard runtime is limited in functionality and scope. The standard library covers areas such as memory and string manipulation, sandard input/output, floating point and others. However, many of the features required for modern applications and services; e.g. those required for synchronization, networking and advanced memory management and threading are not part of the standard library. Instead, many of those features are included in open source C libraries that are also cross-platform with good support for Windows, OSX and most Linux platforms. Because of that support and because Azure SDK implementations will need such functionality, it is expected that client libraries will take dependencies on these libraries.  Ensure the version matches to allow for compatibility when an application integrates multiple client libraries.

{% include requirement/MUST id="clang-approved-dependencies" %} utilize the following libraries as needed for commonly required operations:

{% include_relative approved_dependencies.md %}

{% include requirement/MUST id="clang-dependencies-adparch" %} consult the [Architecture Board] if you wish to use a dependency that is not on the list of approved dependencies.

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

{% include requirement/MUSTNOT id="clang-testing-valgrind" %} have any memory leaks. Run samples and unit tests with [valgrind](http://www.valgrind.org/downloads/current.html). Unit tests and e2e tests are valgrind verified at the gate.

{% include requirement/MUST id="clang-testing-unittests" %} unit test your API with [ccputest](https://cpputest.github.io/), a unit testing and mocking framework for C and C++.

{% include requirement/MUST id="clang-testing-cmake-unit-tests" %} automatically run unit tests when building your client library; i.e. make unit tests part of your continuous integration (CI)

{% include requirement/MUST id="clang-testing-code-coverage" %} maintain a minimum 80% code coverage with unit tests.

## Coding style

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

{% include requirement/MUST id="clang-tooling-clang-format" %} use [clang-format](http://clang.llvm.org/docs/ClangFormat.html) for formatting, with the following command-line options:

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

### Testing and Mocking {clang-testing}

{% include requirement/MUST id="clang-tooling-test-tools" %} use the following tools for testing:

* Azure C Test for unit test running: [https://github.com/Azure/azure-ctest](https://github.com/Azure/azure-ctest)

* Azure micro mock C [umock-c](https://github.com/Azure/umock-c): [https://github.com/Azure/umock-c](https://github.com/Azure/umock-c)

* Use TestRunnerSwitcher, which is a simple library to switch test runners between [azure-ctest](https://github.com/Azure/azure-ctest.git) and CppUnitTest: [https://github.com/Azure/azure-c-testrunnerswitcher](https://github.com/Azure/azure-c-testrunnerswitcher)

## Packaging

{% include requirement/SHOULD id="clang-package-dynamic" %} provide both dynamic and static linking options for your library.  Each has its own merits and use cases.

{% include requirement/MUST id="clang-package-source" %} publish your package in source code format.  Due to differences in platforms, this is the most common publishing mechanism for C libraries.

{% include requirement/MUST id="clang-package-vcpkg" %} publish your package to [vcpkg](https://github.com/Microsoft/vcpkg), a C++ library manager supporting Windows, Linux, and MacOS.

{% include requirement/SHOULD id="clang-package-linux" %} publish libraries targeted to Linux to standard Linux package managers.

> TODO: decide which Linux package managers to support plus which repositories we bless.

> TODO:  Decide if we need to publish to GitHub Package Registry.  If we do, then we likely want to do it across all languages.ß

## Formatting

{% include requirement/MUST id="clang-format-clang" %} use [clang-format](http://clang.llvm.org/docs/ClangFormat.html) for formatting your code. Use the common `clang-format` options from Engineering Systems.

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
