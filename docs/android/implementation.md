---
title: "Android Guidelines: Implementation"
keywords: guidelines android
permalink: android_implementation.html
folder: android
sidebar: general_sidebar
---

## API Implementation

This section describes guidelines for implementing Azure SDK client libraries. Please note that some of these guidelines are automatically enforced by code generation tools.

{% include requirement/MUSTNOT id="android-implementation" %} allow implementation code (that is, code that doesn't form part of the public API) to be mistaken as public API. Implementation code can be made internal or file-private and placed within the same source file as the consuming code.

### Service Client

> TODO: Add introductory sentence.

#### Service Methods

> TODO: Add introductory sentence.

##### Using the HTTP Pipeline

The Azure SDK team has provided an Azure Core library that contains common mechanisms for cross cutting concerns such as configuration and doing HTTP requests.

{% include requirement/MUST id="android-requests-use-pipeline" %} use the HTTP pipeline component within Azure Core for communicating to service REST endpoints.

The HTTP pipeline consists of a HTTP transport that is wrapped by multiple policies. Each policy is a control point during which the pipeline can modify either the request and/or response. We prescribe a default set of policies to standardize how client libraries interact with Azure services. The order in the list is the most sensible order for implementation.

{% include requirement/MUST id="android-requests-implement-policies" %} include the following policies provided by Azure Core when constructing the HTTP pipeline:

- Telemetry
- Unique Request ID
- Retry
- Authentication
- Response downloader
- Logging

{% include requirement/SHOULD id="ios-requests-use-azure-core-impl" %} use the policy implementations in Azure Core whenever possible.  Do not try to "write your own" policy unless it is doing something unique to your service. If you need another option to an existing policy, engage with the [Architecture Board] to add the option.

### Supporting Types

> TODO: Add introductory sentence.

#### Model Types

> TODO

## SDK Feature Implementation

> TODO: Add introductory sentence.

### Configuration

When configuring your client library, particular care must be taken to ensure that the consumer of your client library can properly configure the connectivity to your Azure service both globally (along with other client libraries the consumer is using) and specifically with your client library.

#### Client configuration

{% include requirement/MUST id="android-config-global-config" %} use relevant global configuration settings either by default or when explicitly requested to by the user, for example by passing in a configuration object to a client builder.

{% include requirement/MUST id="android-config-for-different-clients" %} allow different clients of the same type to use different configurations.

{% include requirement/MUST id="android-config-opt-out" %} allow consumers of your service clients to opt out of all global configuration settings at once.

{% include requirement/MUST id="android-config-global-overrides" %} allow all global configuration settings to be overridden by client-provided options. The names of these options should align with any user-facing global configuration keys.

{% include requirement/MUSTNOT id="general-config-behaviour-changes" %} change behavior based on configuration changes that occur after the client is constructed. Hierarchies of clients inherit parent client configuration unless explicitly changed or overridden. Exceptions to this requirement are as follows:

1. Log level, which must take effect immediately across the Azure SDK.
2. Telemetry on/off, which must take effect immediately across the Azure SDK.

> TODO: Update these guidelines to specify exactly how to do these things for Android

#### Service-specific configuration

For Android applications, configuration can be applied in a variety of ways, such as through application preferences or using a `.properties` file, to name a few.

> TODO: Determine a recommended way to pass configuration parameters to Android libraries

### Logging

Client libraries must support robust logging mechanisms so that the consumer can adequately diagnose issues with the method calls and quickly determine whether the issue is in the consumer code, client library code, or service.

{% include requirement/MUST id="android-logging-clientlogger" %} use the `ClientLogger` API provided within Azure Core as the sole logging API throughout all client libraries. Internally, `ClientLogger` logs to the Android Logcat buffer.

{% include requirement/MUST id="android-logging-create-new" %} create a new instance of a `ClientLogger` per instance of all relevant classes. For example, the code below will create a `ClientLogger` instance for the `ConfigurationAsyncClient`:

```java
public final class ConfigurationAsyncClient {
    private final ClientLogger logger = new ClientLogger(ConfigurationAsyncClient.class);

    // example call to a service
    public void setSetting(ConfigurationSetting setting) {
        return service.setKey(serviceEndpoint, setting.key(), setting.label(), setting, getETagValue(setting.etag()), null, new CallbackWithHeader<ConfigurationSetting>() {
            @Override
            public void onSuccess(Response<ConfigurationSetting> response) {
                logger.info("Set ConfigurationSetting - {}", response.value());
            }

            @Override
            public void onError(Response<ConfigurationSetting> errorResponse) {
                logger.warning("Failed to set ConfigurationSetting - {}", setting, errorResponse.getMessage());
            }
        });
    }
}
```

Don't create static logger instances. Static logger instances are long-lived and the memory allocated to them is not released until the application is terminated.

{% include requirement/MUST id="android-logging-levels" %} use one of the following log levels when emitting logs: `Logger.debug` (details), `Logger.info` (things happened), `Logger.warning` (might be a problem or not), and `Logger.error`.

{% include requirement/MUST id="android-logging-errors" %} use the `Logger.error` logging level for failures that the application is unlikely to recover from (out of memory, etc.).

{% include requirement/MUST id="android-logging-warn" %} use the `Logger.warning` logging level when a function fails to perform its intended task. This generally means that the function will raise an exception. Do not include occurrences of self-healing events (for example, when a request will be automatically retried).

{% include requirement/MUST id="android-logging-info" %} use the `Logger.info` logging level when a function operates normally.

{% include requirement/MUST id="android-logging-debug" %} use the `Logger.debug` logging level for detailed troubleshooting scenarios. This is primarily intended for developers or system administrators to diagnose specific failures.

{% include requirement/MUSTNOT id="android-logging-sensitive-info" %} send sensitive information in log levels other than `Logger.debug`. For example, remove account keys when logging headers. Headers and query parameters must be redacted using the `allowedHeaderNames` set and `allowedQueryParameterNames` set specified within the log options.

{% include requirement/MUST id="android-logging-default-allowedlist" %} set reasonable defaults for the `allowedHeaderNames` and `allowedQueryParameterNames` properties in the log options.

{% include requirement/MUST id="android-logging-no-sensitive-info" %} only log headers and query parameters that are in a service-provided "allow-list" of approved headers and query parameters.  All other headers and query parameters must have their values redacted.

{% include requirement/MUST id="android-logging-requests" %} log request line and headers as a `Logger.info` message. The log should include the following information:

* The HTTP method.
* The URL.
* The query parameters (redacted if not in the allow-list).
* The request headers (redacted if not in the allow-list).
* An SDK provided request ID for correlation purposes.

This happens within Azure Core by default, but users can configure this through the builder `httpLogOptions` configuration setting.

{% include requirement/MUST id="android-logging-responses" %} log response line and headers as a `Logger.info` message. The format of the log should be the following:

* The SDK provided request ID (see above).
* The status code.
* Any message provided with the status code.
* The response headers (redacted if not in the allow-list).
* The time period between the first attempt of the request and the first byte of the body.

{% include requirement/MUST id="android-logging-cancellations" %} log a message at the `Logger.info` level if a service call is cancelled.  The log should include:

* The SDK provided request ID (see above).
* The reason for the cancellation (if available).

{% include requirement/MUST id="android-logging-exceptions" %} log thrown exceptions at the `Logger.warning` level. If the log level is set to `debug`, append stack trace information to the message.

{% include requirement/MUST id="android-logging-log-and-throw" %} throw all exceptions created within the client library code through one of the logger APIs - `ClientLogger.logThrowableAsError()`, `ClientLogger.logThrowableAsWarning()`, `ClientLogger.logExceptionAsError()` or `ClientLogger.logExceptionAsWarning()`.

For example:

```java
// NO!!!!
if (priority != null && priority < 0) {
    throw new IllegalArgumentException("'priority' cannot be a negative value. Please specify a zero or positive long value.");
}

// Good

// Log any Throwable as error and throw the exception
if (!file.exists()) {
    throw logger.logThrowableAsError(new IOException("File does not exist " + file.getName()));
}

// Log any Throwable as warning and throw the exception
if (!file.exists()) {
    throw logger.logThrowableAsWarning(new IOException("File does not exist " + file.getName()));
}

// Log a RuntimeException as error and throw the exception
if (priority != null && priority < 0) {
    throw logger.logExceptionAsError(new IllegalArgumentException("'priority' cannot be a negative value. Please specify a zero or positive long value."));
}

// Log a RuntimeException as warning and throw the exception
if (numberOfAttempts < retryPolicy.getMaxRetryCount()) {
    throw logger.logExceptionAsWarning(new RetryableException("A transient error occurred. Another attempt will be made after " + retryPolicy.getDelay()));
}
```

> TBD:
> * Hook in to HockeyApp

### Distributed tracing

Distributed tracing is uncommon in a mobile context. If you feel like you need to support distributed tracing, contact the [Azure SDK mobile team](mailto:azuresdkmobileteam@microsoft.com) for advice.

### Testing

One of the key things we want to support is to allow consumers of the library to easily write repeatable unit-tests for their applications without activating a service. This allows them to reliably and quickly test their code without worrying about the vagaries of the underlying service implementation (including, for example, network conditions or service outages). Mocking is also helpful to simulate failures, edge cases, and hard to reproduce situations (for example: does code work on February 29th).

{% include requirement/MUST id="android-testing-stub-os" %} encapsulate access to Android OS APIs by way of an intermediate interface. This allows the runtime implementation to be swapped out for a test implementation in unit tests.

{% include requirement/MUST id="android-testing-mocking" %} support mocking of network operations.

> TODO: Document how to write good tests using JUnit.
> TODO: Say something about mocking of the requests and how to design for it.

### Other Android-related considerations

> TODO: Revisit min API level

Android developers need to concern themselves with the runtime environment they are running in. The Android ecosystem is fragmented, with a wide variety of runtimes deployed.

{% include requirement/MUST id="android-library-sync-support" %} support Android API level 16 and later (Jelly Bean).

There are two settings that are of concern when discussing the minimum API level to choose:

1. The minimum API level that Google supports.
2. The reach of selecting a particular API level.

We require the minimum API level that Google supports that reaches the most Android devices while still allowing for the use of widely adopted tools by the developer community, such as popular HTTP clients or serialization libraries. We We have currently landed on API level 16, which covers about 99.8% of all Android devices (as of January of 2021).

{% include requirement/MUST id="android-library-target-sdk-version" %} set the `targetSdkVersion` to be API level 26 or higher.

As of November 2018, all existing apps are required to target API level 26 or higher. For more information, see [Improving app security and performance on Google Play for years to come](https://android-developers.googleblog.com/2017/12/improving-app-security-and-performance.html).

{% include requirement/MUST id="android-library-max-sdk-version" %} set the `maxSdkVersion` to be the latest API level that you have run tests on. This should be the latest API level that is supported by Google at the point at which the SDK is released.

{% include requirement/MUST id="android-library-java-lang" %} write client libraries in Java. This avoids forcing customers to depend on the Kotlin runtime in their applications.

{% include requirement/MUST id="android-library-java-version" %} write client libraries using Java 8 syntax. Java 8 syntax constructs will be down-leveled using [Java 8 language feature desugaring](https://developer.android.com/studio/write/java8-support#supported_features) provided by Android Gradle Plugin 3.0.0+. This includes use of the following Java 8 language features:

* Lambda expressions
* Method references
* Type annotations (except `TYPE_USE` and `TYPE_PARAMETER`)
* Default and static interface methods
* Repeating annotations

{% include requirement/MUST id="android-library-source-compat" %} set your Gradle project's source and target compatibility level to 1.8.

{% include requirement/MUSTNOT id="android-library-java-api" %} use Java 8+ APIs. Some such APIs are able to be down-leveled using [Java 8+ API desugaring](https://developer.android.com/studio/write/java8-support#library-desugaring) provided by Android Gradle Plugin 4.0.0+. However many developers may not be using a sufficiently updated version of the plugin, and library desugaring injects additional code into the customer's application, potentially increasing the APK size or method count. This includes use of the following Java 8+ APIs:

* Sequential streams (`java.util.stream`)
* `java.time`
* `java.util.function`
* Java 8+ additions to `java.util.{Map,Collection,Comparator}`
* Optionals (`java.util.Optional`, `java.util.OptionalInt` and `java.util.OptionalDouble`)
* Java 8+ additions to `java.util.concurrent.atomic` (new methods on `AtomicInteger`, `AtomicLong` and `AtomicReference`)
* `ConcurrentHashMap`

{% include requirement/MUST id="android-library-aar" %} release the library as an Android AAR.

{% include requirement/MUST id="android-library-resource-prefix" %} define a `resourcePrefix` of `azure_<service>` in the `build.gradle` android section if using resources.

{% include requirement/SHOULD id="android-library-shrink-code" %} include a Proguard configuration in the AAR to assist developers in correctly minifying their applications when using the library.

{% include requirement/MUST id="android-library-proguard" %} use `consumerProguardFiles` if you include a Proguard configuration in the library.

{% include refs.md %}
{% include_relative refs.md %}
