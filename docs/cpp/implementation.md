---
title: "C++ Guidelines: Implementation"
keywords: guidelines cpp
permalink: cpp_implementation.html
folder: cpp
sidebar: cpp_sidebar
---

{% include draft.html content="The C++ Language guidelines are in DRAFT status" %}

## Supported platforms

{% include requirement/MUST id="cpp-platform-min" %} support the following platforms and associated compilers when implementing your client library.

### Windows

| Operating System     | Version       | Architectures | Compiler Version                        | Notes
|----------------------|---------------|---------------|-----------------------------------------|------
| Windows Client       | 7 SP1+, 8.1   | x64, x86      | MSVC 14.16.x, MSVC 14.20x               |
| Windows 10 Client    | Version 1607+ | x64, x86, ARM | MSVC 14.16.x, MSVC 14.20x               |
| Windows 10 Client    | Version 1909+ | ARM64         | MSVC 14.20x                             |
| Nano Server          | Version 1803+ | x64, ARM32    | MSVC 14.16.x, MSVC 14.20x               |
| Windows Server       | 2012 R2+      | x64, x86      | MSVC 14.16.x, MSVC 14.20x               |

### Mac

| Operating System                | Version       | Architectures | Compiler Version                        | Notes
|---------------------------------|---------------|---------------|-----------------------------------------|------
| macOS                           | 10.13+        | x64           | XCode 9.4.1                             |

### Linux

| Operating System                | Version       | Architectures | Compiler Version                        | Notes
|---------------------------------|---------------|---------------|-----------------------------------------|------
| Red Hat Enterprise Linux <br> CentOS <br> Oracle Linux        | 7+            | x64           | gcc-4.8                                 | [Red Hat lifecycle](https://access.redhat.com/support/policy/updates/errata/) <br> [CentOS lifecycle](https://wiki.centos.org/FAQ/General#head-fe8a0be91ee3e7dea812e8694491e1dde5b75e6d) <br> [Oracle Linux lifecycle](http://www.oracle.com/us/support/library/elsp-lifetime-069338.pdf)
| Debian                          | 9+            | x64           | gcc-6.3                                 | [Debian lifecycle](https://wiki.debian.org/DebianReleases)
| Ubuntu                          | 18.04, 16.04  | x64           | gcc-7.3                                 | [Ubuntu lifecycle](https://wiki.ubuntu.com/Releases)
| Linux Mint                      | 18+           | x64           | gcc-7.3                                 | [Linux Mint lifecycle](https://www.linuxmint.com/download_all.php)
| openSUSE                        | 15+           | x64           | gcc-7.5                                 | [OpenSUSE lifecycle](https://en.opensuse.org/Lifetime)
| SUSE Enterprise Linux (SLES)    | 12 SP2+       | x64           | gcc-4.8                                 | [SUSE lifecycle](https://www.suse.com/lifecycle/)

{% include requirement/SHOULD id="cpp-platform" %} support the following additional platforms and associated compilers when implementing your client library.


{% include requirement/SHOULDNOT id="cpp-cpp-extensions" %} use compiler extensions.  Examples of extensions to avoid include:

* [MSVC compiler extensions](https://docs.microsoft.com/cpp/build/reference/microsoft-extensions-to-c-and-cpp)
* [clang language extensions](https://clang.llvm.org/docs/LanguageExtensions.html)
* [GNU C compiler extensions](https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html)

Use the appropriate options for each compiler to prevent the use of such extensions.

{% include requirement/MUST id="cpp-cpp-options" %} use compiler flags to identify warnings:

| Compiler                 | Compiler Flags   |
|:-------------------------|------------------|
| gcc                      | `-Wall -Wextra`  |
| cpp and XCode            | `-Wall -Wextra`  |
| MSVC                     | `/W4`            |

When configuring your client library, particular care must be taken to ensure that the consumer of your client library can properly configure the connectivity to your Azure service both globally (along with other client libraries the consumer is using) and specifically with your client library.

### Client configuration

{% include requirement/MUST id="cpp-config-global-config" %} use relevant global configuration settings either by default or when explicitly requested to by the user, for example by passing in a configuration object to a client constructor.

{% include requirement/MUST id="cpp-config-for-different-clients" %} allow different clients of the same type to use different configurations.

{% include requirement/MUST id="cpp-config-optout" %} allow consumers of your service clients to opt out of all global configuration settings at once.

{% include requirement/MUST id="cpp-config-global-overrides" %} allow all global configuration settings to be overridden by client-provided options. The names of these options should align with any user-facing global configuration keys.

{% include requirement/MUSTNOT id="cpp-config-defaults-nochange" %} Change the default values of client
configuration options based on system or program state.

{% include requirement/MUSTNOT id="cpp-config-defaults-nobuildchange" %} Change default values of
client configuration options based on how the client library was built.

{% include requirement/MUSTNOT id="cpp-config-behaviour-changes" %} change behavior based on configuration changes that occur after the client is constructed. Hierarchies of clients inherit parent client configuration unless explicitly changed or overridden. Exceptions to this requirement are as follows:

1. Log level, which must take effect immediately across the Azure SDK.
2. Tracing on/off, which must take effect immediately across the Azure SDK.

{% include requirement/MUSTNOT id="cpp-config-noruntime" %} use client library specific runtime
configuration such as environment variables or a config file. Keep in mind that many IOT devices
won't have a filesystem or an "environment block" to read from.

## Parameter validation

The service client will have several methods that perform requests on the service.  _Service parameters_ are directly passed across the wire to an Azure service.  _Client parameters_ are not passed directly to the service, but used within the client library to fulfill the request.  Examples of client parameters include values that are used to construct a URI, or a file that needs to be uploaded to storage.

{% include requirement/MUST id="cpp-params-client-validation" %} validate client parameters.

{% include requirement/MUSTNOT id="cpp-params-server-validation" %} validate service parameters.  This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUST id="cpp-params-check-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service.  If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

## Network requests

> TODO: Implement the spirit of the general guidelines for network requests - explicitly, how to use Azure Core for making network requests

## Authentication

When implementing authentication, don't open up the consumer to security holes like PII (personally identifiable information) leakage or credential leakage.  Credentials are generally issued with a time limit, and must be refreshed periodically to ensure that the service connection continues to function as expected.  Ensure your client library follows all current security recommendations and consider an independent security review of the client library to ensure you're not introducing potential security problems for the consumer.

{% include requirement/MUSTNOT id="cpp-implementing-no-persistence-auth" %}
persist, cache, or reuse security credentials.  Security credentials should be considered short lived to cover both security concerns and credential refresh situations.

If your service implements a non-standard credential system (one that is not supported by Azure Core), then you need to produce an authentication policy for the HTTP pipeline that can authenticate requests given the alternative credential types provided by the client library.

{% include requirement/MUST id="cpp-implementing-secure-auth-erase" %} Use a "secure" function to zero authentication or authorization credentials as soon as possible once they are no longer needed. Examples of such functions
include: `SecureZeroMemory`, `memset_s`, and `explicit_bzero`. Examples of insecure functions include `memset`. An optimizer may notice that the credentials are
never accessed again, and optimize away the call to `memset`, resulting in the credentials remaining in memory.

{% include requirement/MUST id="cpp-implementing-auth-policy" %}
provide a suitable authentication policy that authenticates the HTTP request in the HTTP pipeline when using non-standard credentials.  This includes custom connection strings, if supported.

## Logging

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

## Dependencies

Dependencies bring in many considerations that are often easily avoided by avoiding the
dependency.

- **Versioning** - Many programming languages do not allow a consumer to load multiple versions of the same package. So, if we have an client library that requires v3 of package Foo and the consumer wants to use v5 of package Foo, then the consumer cannot build their application. This means that client libraries should not have dependencies by default.
- **Size** - Consumer applications must be able to deploy as fast as possible into the cloud and move in various ways across networks. Removing additional code (like dependencies) improves deployment performance.
- **Licensing** - You must be conscious of the licensing restrictions of a dependency and often provide proper attribution and notices when using them.
- **Compatibility** - Often times you do not control a dependency and it may choose to evolve in a direction that is incompatible with your original use.
- **Security** - If a security vulnerability is discovered in a dependency, it may be difficult or time consuming to get the vulnerability corrected if Microsoft does not control the dependencies code base.

{% include requirement/MUST id="cpp-dependencies-stdlibcpp" %} use the [C++ standard library](https://en.cppreference.com/w/).

{% include requirement/MUST id="cpp-dependencies-azure-core" %} depend on the Azure Core library for functionality that is common across all client libraries.  This library includes APIs for HTTP connectivity, global configuration, and credential handling.

{% include requirement/MUSTNOT id="cpp-dependencies-approved-only" %} be dependent on any other packages within the client library distribution package. Dependencies are by-exception and need a thorough vetting through architecture review.  This does not apply to build dependencies, which are acceptable and commonly used.

{% include requirement/SHOULD id="cpp-dependencies-vendoring" %} consider copying or linking required code into the client library in order to avoid taking a dependency on another package that could conflict with the ecosystem. Make sure that you are not violating any licensing agreements and consider the maintenance that will be required of the duplicated code. ["A little copying is better than a little dependency"][1] (YouTube).

{% include requirement/MUSTNOT id="cpp-dependencies-concrete" %} depend on concrete logging, dependency injection, or configuration technologies (except as implemented in the Azure Core library).  The client library will be used in applications that might be using the logging, DI, and configuration technologies of their choice.

### C and C++ language specifics

Unlike many other programming languages, which have large runtimes, the C++ standard runtime is limited in functionality and scope. The standard library covers areas such as memory and string manipulation, standard input/output, floating point and others. However, many of the features required for modern applications and services; e.g. those required for networking and advanced memory management are not part of the standard library. Instead, many of those features are included in open source C++ libraries that are also cross-platform with good support for Windows, OSX and most Linux platforms. Because of that support and because Azure SDK implementations will need such functionality, it is expected that client libraries will take dependencies on these libraries.  Ensure the version matches to allow for compatibility when an application integrates multiple client libraries.

{% include requirement/MUST id="cpp-approved-dependencies" %} utilize the following libraries as needed for commonly required operations:

{% include_relative approved_dependencies.md %}

{% include requirement/MUST id="cpp-dependencies-adparch" %} consult the [Architecture Board] if you wish to use a dependency that is not on the list of approved dependencies.

## Testing

We believe testing is a part of the development process, so we expect unit and integration tests to be a part of the source code.  All components must be covered by automated testing, and developers should strive to test corner cases and main flows for every use case.

All code should contain, at least, requirements, unit tests, end-to-end tests, and samples.

Tests should be written using the [Google Test][] library.

## Coding style

{% include requirement/MUST id="cpp-style-clang-format" %} format your source code with `clang-format`, using the configuration file located in [the azure-sdk-for-cpp repo](https://github.com/Azure/azure-sdk-for-cpp/blob/master/.clang-format).

### Files

{% include requirement/MUST id="cpp-style-filenaming" %} name all files as lowercase, in a directory of the service short name. Separate words with underscores, and end with the appropriate extension (`.cpp` or `.hpp`). For example, `iot_credential.cpp` is valid, while `IoTCredential.cl` is not.

{% include requirement/MUST id="cpp-style-privateapi-hdr" %} place an include file that is not part of the public API in an `internal` directory.  Do not include the service short name.  For example, `<azure/internal/credential.hpp>`.

{% include requirement/MUST id="cpp-style-filenames" %} use characters in the range `[a-z0-9_]` for the name portion (before the file extension).  No other characters are permitted.

Filenames should be concise, but convey what role the file plays within the library.

{% include requirement/MUST id="cpp-style-headerguards" %} use `#pragma once`

{% highlight cpp %}
#pragma once

// Contents of a given header
{% endhighlight %}

{% include requirement/MAY id="cpp-style-whole-sdk-header" %} have a header file that includes an entire client library. For example, `<azure/speech.hpp>`.

{% include requirement/SHOULD id="cpp-style-sub-sdk-header" %} have headers for smaller components that make sense to be used together. For example, `<azure/speech/translation.hpp>`.

{% include requirement/MUSTNOT id="cpp-style-change-headers" %} substantially change the names exposed by the header in response to macros or other controls. For example, `NOMINMAX` or `WIN32_LEAN_AND_MEAN` from `<Windows.h>`.

## Tooling

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

## Packaging

{% include requirement/SHOULD id="cpp-package-dynamic" %} provide both dynamic and static linking options for your library.  Each has its own merits and use cases.

{% include requirement/MUST id="cpp-package-source" %} publish your package in source code format.  Due to differences in platforms, this is the most common publishing mechanism for C libraries.

{% include requirement/MUST id="cpp-package-vcpkg" %} publish your package to [vcpkg](https://github.com/Microsoft/vcpkg), a C++ library manager supporting Windows, Linux, and MacOS.

## Formatting

{% include requirement/MUST id="cpp-format-cpp" %} use [cpp-format](https://clang.llvm.org/docs/ClangFormat.html) for formatting your code. Use the [.clang-format](https://github.com/Azure/azure-sdk-for-cpp/blob/master/.clang-format) options.

In general, cpp-format will format your code correctly and ensure consistency. However, these are few additional  rules to keep in mind.

{% include requirement/MUST id="cpp-format-cpp-loops" %} place all conditional or loop statements on one line, or add braces to identify the conditional/looping block.

{%highlight c %}
if (meow == 0) purr += 1; // OK
if (meow == 0) {
    purr += 1; // OK
}
if (meow == 0) { purr += 1; } // OK (although will probably be changed by cpp-format)
if (meow == 0)
    purr += 1; // NOT OK
{% endhighlight %}

{% include requirement/MUST id="cpp-format-cpp-closing-braces" %} add comments to closing braces.  Adding a comment to closing braces can help when you are reading code because you don't have to find the begin brace to know what is going on.

{% highlight cpp %}
while (1) {
    if (valid) {
        ...
    } /* if valid */
    else {

    } /* not valid */
} /* end forever */
{% endhighlight %}

{% include requirement/MUST id="cpp-format-cpp-closing-endif" %} add comments to closing preprocessor directives to make them easier to understand.  For example:

{% highlight cpp %}
#if _BEGIN_CODE_

#ifndef _INTERNAL_CODE_

#endif /* _INTERNAL_CODE_ */

#endif /* _BEGIN_CODE_ */
{% endhighlight %}


{% include requirement/SHOULDNOT id="cpp-format-cpp-space-return" %} use parens in return statements when it isn't necessary.

{% include requirement/MUST id="cpp-format-cpp-no-yoda" %} place constants on the right of comparisons. For example `if (a == 0)` and not `if (0 == a)`

{% include requirement/MUST id="cpp-format-cpp-comment-fallthru" %} include a comment for falling through a non-empty `case` statement.  For example:

{% highlight cpp %}
switch (...) {
    case 1:
        DoSomething();
        break;
    case 2:
        DoSomethingElse();
        /* fall through */
    case 3:
        {
            int v;

            DoSomethingMore(v);
        }
        break;
    default:
        Log(LOG_DEBUG, "default case reached");
}
{% endhighlight %}

{% include requirement/SHOULDNOT id="cpp-format-cpp-no-goto" %} use `goto` statements.  The main place where `goto` statements can be usefully employed is to break out of several levels of `switch`, `for`, or `while` nesting, although the need to do such a thing may indicate that the inner constructs should be broken out into a separate function with a success/failure return code.  When a `goto` is necessary, the accompanying label should be alone on a line and to the left of the code that follows.  The `goto` should be commented as to its utility and purpose.

## Complexity Management

{% include requirement/SHOULD id="cpp-init-all-vars" %} Initialize all variables. Only leave them
uninitialized if there is a real performance reason to do so. Use static and dynamic analysis tools to
check for uninitialized access. You may leave "result" variables uninitialized so long as they clearly do
not escape from the innermost lexical scope.

{% include requirement/SHOULD id="cpp-function-size" %} limit function bodies to one page of code (40 lines, approximately).

{% include requirement/MUST id="cpp-document-null-bodies" %} document null statements.  Always document a null body for a `for` or `while` statement so that it is clear the null body is intentional.

{% include requirement/MUST id="cpp-use-explicit-compares" %} use explicit comparisons when testing for failure.  Use `if (FAIL != f())` rather than `if (f())`, even though FAIL may have the value 0 which C considers to be false.  An explicit test will help you out later when somebody decides that a failure return should be -1 instead of 0.

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

## Miscellaneous

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
