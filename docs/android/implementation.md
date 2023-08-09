---
title: "Android Guidelines: Implementation"
keywords: guidelines android
permalink: android_implementation.html
folder: android
sidebar: general_sidebar
---

## API Implementation

This section describes guidelines for implementing Azure SDK client libraries. Please note that some of these guidelines are automatically enforced by code generation tools.

{% include requirement/MUSTNOT id="android-implementation" %} allow implementation code (that is, code that doesn't form part of the public API) to be mistaken as public API. There are two valid arrangements for implementation code, which in order of preference are the following:

1. Implementation classes can be made package-private and placed within the same package as the consuming class.
2. Implementation classes can be placed within a subpackage named `implementation`.

CheckStyle checks ensure that classes within an `implementation` package aren’t exposed through public API, but it is better that the API not be public in the first place, so preferring to have package-private is the better approach where practicable.

### Service Client

#### Async Service Client

{% include requirement/MUST id="java-async-blocking" %} include blocking calls inside async client library code.

##### Using the HTTP Pipeline

The Azure SDK team has provided an [Azure Core] library that contains common mechanisms for cross cutting concerns such as configuration and doing HTTP requests.

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

#### Annotations

Include the following annotations on the service client class. For example, this code sample shows a sample class demonstrating the use of these two annotations:

```java
@ServiceClient(builder = ConfigurationAsyncClientBuilder.class, isAsync = true, service = ConfigurationService.class)
public final class ConfigurationAsyncClient {
    @ServiceMethod(returns = ReturnType.COLLECTION)
    public Mono<Response<ConfigurationSetting>> addSetting(String key, String value) {
        ...
    }
}
```

| Annotation | Location | Description |
|:-----------|:---------|:------------|
| `@ServiceClient` | Service Client | Specifies the builder responsible for instantiating the service client, whether the API is asynchronous, and a reference back to the service interface (the interface annotated with `@ServiceInterface`). |
| `@ServiceMethod` | Service Method | Placed on all service client methods that do network operations. |

#### Service Client Builder

##### Annotations

The `@ServiceClientBuilder` annotation should be placed on any class that is responsible for instantiating service clients (that is, instantiating classes annotated with `@ServiceClient`). For example:

```java
@ServiceClientBuilder(serviceClients = {ConfigurationClient.class, ConfigurationAsyncClient.class})
public final class ConfigurationClientBuilder { ... }
```

This builder states that it can build instances of `ConfigurationClient` and `ConfigurationAsyncClient`.

#### Event Handling

##### Event Handlers

{% include requirement/SHOULD id="android-event-handler-collection" %} use Azure Core's `EventHandlerCollection` internally to keep track of registered event handlers and their associations with different event types within a client.

{% include requirement/MUST id="android-event-types" %} declare event types to associate event handlers with as package-private client constants of the type `String`.

```java
public class MessagingClient {
    static final String MESSAGE_SENT = "MessageSent";
    static final String MESSAGE_RECEIVED = "MessageReceived";

    private final String userId;
    private final MessagingClientImpl innerClient;
    private final EventHandlerCollection eventHandlerCollection;

    public MessagingClient(String userId) {
        this.userId = userId;
        this.innerClient = new MessagingClientImpl(userId);
        this.eventHandlerCollection = new EventHandlerCollection();
    }

    public void addOnMessageSentEventHandler(EventHandler<MessageSentEvent> handler) {
        eventHandlerCollection.addEventHandler(MESSAGE_SENT, handler);
    }

    public void addOnMessageReceivedEventHandler(EventHandler<MessageReceivedEvent> handler) {
        eventHandlerCollection.addEventHandler(MESSAGE_RECEIVED, handler);
    }

    public void removeOnMessageSentEventHandler(EventHandler<MessageSentEvent> handler) {
        eventHandlerCollection.removeEventHandler(MESSAGE_SENT, handler);
    }

    public void removeOnMessageReceivedEventHandler(EventHandler<MessageReceivedEvent> handler) {
        eventHandlerCollection.removeEventHandler(MESSAGE_RECEIVED, handler);
    }

    public void sendMessage(Message message) {
        innerClient.sendMessage(message);

        MessageSentEvent messageSentEvent = new MessageSentEvent()
                .setMessageId(UUID.newUUID())
                .setTimestamp(new Date())
                .setUserId(this.userId);

        eventHandlerCollection.fireEvent(MESSAGE_SENT, messageSentEvent);
    }

    public void receiveMessages() {
        for (Message message : innerClient.receiveMessages()) {
            MessageReceivedEvent messageReceivedEvent = new MessageReceivedEvent()
                    .setMessageId(message.getMessageId())
                    .setTimestamp(message.getTimestamp())
                    .setUserId(message.getUserId())
                    .setContents(message.getContents());

            eventHandlerCollection.fireEvent(MESSAGE_RECEIVED, messageReceivedEvent);
        }
    }
}
```

### Supporting Types

#### Model Types

##### Annotations

There are two annotations of note that should be applied on model classes, when applicable:

* The `@Fluent` annotation is applied to all model classes that are expected to provide a fluent API to end users.
* The `@Immutable` annotation is applied to all immutable classes.

> TODO: Include the @HeaderCollection annotation.

## SDK Feature Implementation

### Configuration

When configuring your client library, particular care must be taken to ensure that the consumer of your client library can properly configure the connectivity to your Azure service both globally (along with other client libraries the consumer is using) and specifically with your client library. For Android applications, configuration can be applied in a variety of ways, such as through application preferences or using a `.properties` file, to name a few.

> TODO: Determine a recommended way to pass configuration parameters to Android libraries

### Logging

Client libraries must make use of the robust logging mechanisms in Azure Core, so that the consumers can adequately diagnose issues with method calls and quickly determine whether the issue is in the consumer code, client library code, or service.

Request logging will be done automatically by the `HttpPipeline`. If a client library needs to add custom logging, follow the same guidelines and mechanisms as the pipeline logging mechanism. If a client library wants to do custom logging, the designer of the library must ensure that the logging mechanism is pluggable in the same way as the `HttpPipeline` logging policy.

{% include requirement/MUST id="android-logging-directly" %} follow [the logging section of the Azure SDK General Guidelines][logging-general-guidelines] and [the following guidelines](#using-the-clientlogger-interface) if logging directly (as opposed to through the `HttpPipeline`).

#### Using the ClientLogger interface

{% include requirement/MUST id="android-logging-clientlogger" %} use the `ClientLogger` API provided within Azure Core as the sole logging API throughout all client libraries. Internally, `ClientLogger` logs to the Android Logcat buffer.

> TODO: Determine if we want ClientLogger to wrap SLF4J like it's Java counterpart.

{% include requirement/MUST id="android-logging-create-new" %} create a new instance of a `ClientLogger` per instance of all relevant classes. For example, the code below will create a `ClientLogger` instance for the `ConfigurationAsyncClient`:

```java
public final class ConfigurationAsyncClient {
    private final ClientLogger logger = new ClientLogger(ConfigurationAsyncClient.class);

    // Example call to a service.
    public Response<String> setSetting(ConfigurationSetting setting) {
        Response<String> response = service.setKey(serviceEndpoint, setting.key(), setting.label(), setting, getETagValue(setting.etag()), null);
        
        logger.info("Set ConfigurationSetting - {}", response.value());
        
        return response;
    }
}
```

Don't create static logger instances. Static logger instances are long-lived and the memory allocated to them is not released until the application is terminated.

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

### Distributed tracing

Distributed tracing is uncommon in a mobile context. If you feel like you need to support distributed tracing, contact the [Azure SDK mobile team](mailto:azuresdkmobileteam@microsoft.com) for advice.

### Testing

One of the key things we want to support is to allow consumers of the library to easily write repeatable unit-tests for their applications without activating a service. This allows them to reliably and quickly test their code without worrying about the vagaries of the underlying service implementation (including, for example, network conditions or service outages). Mocking is also helpful to simulate failures, edge cases, and hard to reproduce situations (for example: does code work on February 29th).

{% include requirement/MUST id="android-testing-patterns" %} parameterize all applicable unit tests to make use of all available HTTP clients and service versions. Parameterized runs of all tests must occur as part of live tests. Shorter runs, consisting of just Netty and the latest service version, can be run whenever PR validation occurs.

> TODO: Document how to write good tests using JUnit on Android.

### Other Android-related considerations

> TODO: Revisit min API level chosen.

Android developers need to concern themselves with the runtime environment they are running in. The Android ecosystem is fragmented, with a wide variety of runtimes deployed.

{% include requirement/MUST id="android-library-sync-support" %} support at least Android API level 15 and later (Ice Cream Sandwich). This value can be found in your project's top level `build.gradle` file as `minSdkVersion`.

There are two things that are of concern when discussing the minimum API level to choose:

1. The minimum API level that Google supports.
2. The reach of selecting a particular API level.

We require the minimum API level that Google supports that reaches the most Android devices while still allowing for the use of widely adopted tools by the developer community, such as popular HTTP clients or serialization libraries. We have currently landed on API level 15, which covers more than 99.8% of all Android devices (as of May 2021). The reach of a particular API level can be found when clicking "Help me choose" in Android Studio's "Create New Project" screen, after selecting the type of project to create.

{% include requirement/MUST id="android-library-target-sdk-version" %} set the `targetSdkVersion` to be API level 26 or higher in your project's top level `build.gradle` file.

As of November 2018, all existing Android apps are required to target API level 26 or higher. For more information, see [Improving app security and performance on Google Play for years to come](https://android-developers.googleblog.com/2017/12/improving-app-security-and-performance.html).

{% include requirement/MUST id="android-library-max-sdk-version" %} set the `maxSdkVersion` to be the latest API level that you have run tests on in your project's top level `build.gradle` file. This should be the latest API level that is supported by Google at the point at which the SDK is released.

{% include requirement/MUST id="android-library-source-compat" %} set your Gradle project's source and target compatibility level to `1.8`.

{% include requirement/MUST id="android-library-aar" %} release the library as an Android AAR.

{% include requirement/MUST id="android-library-resource-prefix" %} define a `resourcePrefix` of `azure_<service>` in the `build.gradle` android section if using resources.

{% include requirement/SHOULD id="android-library-shrink-code" %} include a Proguard configuration in the AAR to assist developers in correctly minifying their applications when using the library.

{% include requirement/MUST id="android-library-proguard" %} use `consumerProguardFiles` if you include a Proguard configuration in the library.

{% include refs.md %}
{% include_relative refs.md %}
