# Azure SDK Design Guidelines

This document will describe architectural and API design guidelines for Azure SDKs. 

Currently, the document id mainly as a list of topics that we want to cover in more detail, i.e. there is not much useful inforamtion in it yet.

## 1.0 Language Independent Guidelines

### 1.0.0 General Guidelines

1.0.1 :warning: **NOTE** language-specific gudelines (sections 2.0 - 6.0) overrule language independent guidelines  

1.0.2 :white_check_mark: **DO** provide SDKs for the following languages: C#, Java, Python, JavaScript

1.0.3 :ballot_box_with_check: **CONSIDER** providing SDKs for the following languages:  Go, C++

<font size="2" color="gray">TODO: This will result in partial coverage for optional languages. Is that OK?</font>

1.0.4 :white_check_mark: **DO** support cancellations.

1.0.5 :white_check_mark: **DO** support retries

1.0.6 :no_entry: **DO NOT** depend on concrete logging, dependency injection, or configuration technologies. 

The SDKs will be used in applications that might be using ther logging, DI, and configuration technologies of their choice. 

## 1.1.0 Telemetry
Telemetry is used by service teams (not customers) to monitor what SDK a client is using to call into their service. Specifically, the service team can detect client OS, language, language version, and service SDK version. Some clients can prepend additional information indicating the name and version of the client application.

1.1.1 :white_check_mark: **DO** send telemetry information in the User-Agent header, with the header value in the the following format: 

[<application_id>/<SPACE\>]<sdk_name>/<sdk_version>/<SPACE\><platform_information>

* <application_id> ::= optional application-specific string. The string is supplied by the user of the SDK, e.g. "AzCopy/10.0.4-Preview"
* <sdk_name> ::= name of the SDK, e.g. "Azure-Storage-Blob"
* <sdk_version> ::= the version of the SDK. Note: this is not the version of the service
* <platform_information> ::= information about the currently-executing OS and runtime, e.g. "(NODE-VERSION v4.5.0; Windows_NT 10.0.14393)"

For example, the following two are fully formatter User-Agent header values:

* "Azure-Storage/1.4.0 (NODE-VERSION v4.5.0; Windows_NT 10.0.14393)"
* "AzCopy/10.0.4-Preview Azure-Storage/1.4.0 (NODE-VERSION v4.5.0; Windows_NT 10.0.14393)"

For details on the User-Agent header, see https://tools.ietf.org/html/rfc7231#section-5.5.3

NOTE: today, the <sdk_name> for all storage SDKs/packages (Blob, File, etc.) is simply "Azure-Storage". The guideline above proposes that we standardize on full SDK names, e.g. "Azure-Storage-Blob". 

TODO: provide the full list of SDK names.

TODO: provide language-specific guidelines (and possibly shared library) for generating <platform_information> 

TODO: provide shared library API for injecting telemetry information
## 1.2.0 Logging

1.2.1 :white_check_mark: **DO** support pluggable loggers.

1.2.2 :white_check_mark: **DO** emit the following log levels: Verbose (i.e. details), Informational (things happened), Warning (might be a problem or not), and Error. 

1.2.3 :no_entry: **DO NOT** send sensitive information to the logs, e.g. remove account keys when logging headers.

1.2.4 :white_check_mark: **DO** log a Warning message, if a request takes longer than some specified threshold. The default threshold is 3 seconds.

1.2.5 :white_check_mark: **DO** log request line, response line, and headers, as Informational message.

1.2.6 :white_check_mark: **DO** log an Error message, if a response comes back with a status codes between 400-599. 

Some services use status codes in this range in normal course of operation, e.g. implement an "exists" check by returning 404 (not found). In such situations, the particular service might opt out from logging such status code as error. 

1.2.7 :white_check_mark: **DO** log a Warning message, if a service call needs to be retried.

1.2.7 :white_check_mark: **DO** log an Informational message, if a service call is cancelled.

1.2.7 :white_check_mark: **DO** log exceptions thrown as an Error message. If the log level set to Verbose, append stack trace information to the message.

1.2.7 :white_check_mark: **DO** DO log failures (exceptions and error status codes), regardless logging level, to the event log on Windows and the syslog on Linux, i.e. this cannot be turned off by the SDK user unless they replace the pipeline.

TODO: describe format/syntax of the log messages.
TODO: provide and describe pipeline APIs for logging.

## 1.3.0 Retry

There are many reasons why failure can occur when a client application attempts to send a network request to a service. Some examples are timeout, network infrastructure failures, service rejecting the request due to throttle/busy, service instance terminating due to service scale down, service instance going down to be replaced with another version, service crashing due to an unhandled exception, etc. By offering a built-in retry mechanism (with a default configuration overridable by the customer), our SDKs and the customer’s application become resilient to these kinds of failures. Note that some services charge real money for each try and so customers should be able to disable retries entirely if they prefer to save money over resiliency.

1.3.1 :white_check_mark: **DO** offer the following configuration settings: 
- Retry policy (exponential or fixed)
- Maximum number of tries (32-bit integer; 0=default, 1=1 try & no retries, 2=1 try & 1 retry, etc.)
- Per-try timeout (timespan/duration; default=worst anticipated bandwidth times largest single request and response payloads)
- Retry delay (timespan/duration; this is the delay for fixed policy, the delay is increased exponentially by this amount for the exponential policy)
- Max retry delay (timespan/duration; the delay will never go over this amount)

1.3.2 :white_check_mark: **DO** offer additional retry mechanism if supported by the service
- For example, the Azure Storage Blob service supports retrying read operations against a secondary datacenter

1.3.3 :white_check_mark: **DO** reset (or seek back to position 0) any request data stream before retrying a request

1.3.4 :white_check_mark: **DO** honor any cancellation mechanism passed-in be the caller which can terminate the request before retried have been attempted.

1.3.5 :white_check_mark: **DO** update any query parameter or request header that gets sent to the service telling it how much time the service has to process the individual request attempt.

1.3.6 :white_check_mark: **DO** retry in the case of a hardware network failure as it may self-correct

1.3.7 :white_check_mark: **DO** retry in the case of a service not found error as the service may be coming back online or a load balancer may be reconfiguring itself.

1.3.8 :white_check_mark: **DO** retry in the case of a per-try timeout

1.3.9 :white_check_mark: **DO** retry if the service successfully responds indicating that it is throttle requests.

1.3.2 :no_entry: **DO NOT** retry if the service successfully responds indicating that the requested operation failed.

## 1.4.0 Cancellation & Timeouts
When an application makes a network request, the network infrastrucutre(like routers) and the called service may take a long time to respond and, in fact, may never respond. A well-written application SHOULD NEVER give up its control to the network infrasture or service. To ensure that users of our SDKs can keep control of their application, SDK methods that perform I/O operations MUST accept some kind of cancellation & timeout mechanism specific to the programming language.

 Here are some examples as to why this is so important:
 - When an orchestrator needs to terminate a service (due to scale in, reconfiguration, or upgrading to a new version), the orchestrator typically notifies a running service stance by simulating a Ctrl+C or SIGINT. When the service recieves this, it should terminate as quickly & gracefully as possible by setting a cancelation mechanism which should be honored by ALL functions that are currently in-flight. 
 - When a customer's webserver receives a request, it may set a time-limit indicating how much time it is allowing before it must give a response to the customer. 
 - When a customer's GUI appication makes a request to an Azure service via our SDK, the GUI might offer a cancel button so that the end-user can indicate that they are no longer in waiting for an operation or operations to complete.

The best way for customers to work with cancellation is to think of cancellation objects as forming a tree. For example:
- Cancelling a parent automatically cancels it’s children. 
- Children can timeout sooner than their parent but cannot extend the time. 
- Cancellation can happen due to timeout or due to a manual/explicit cancel. 
  
Here is an example of how an application would use the tree of cancellations:
- When an application starts, it should create a cancellation object that represents the entire application; this object is explicitly terminated in response to the application receiving a Ctrl+C or SIGINT notification.
- When a webserver receives an incoming request, it would create a new cancellation node that is a child of the application node. The new node would specify a maximum time that the webserver is allowing beforeto operate on the incoming request.
- As part of operating on the incoming request, the webserver might need to make multiple requests to other services (like a database). If these requests can be made serially or in parallel, then they might share the previously-created cancellation node's timeout. However, if the webserver wants to limit the time spent on 1 or more the requests, it can create a new cancellation node (with the desired timeout value) and make this node a child of the incoming request's node; this way, the individual request timesout either when the overall request timesout or when the max time for this operation timeout - whichever happens first.
- Note that if multiple request are made in parallel, it is common for the customer to want to cancel all of them if any one of them fails. This should be a supported scenario.

## 1.5.0 Dependencies
Many programming languages do not allow a customer to load multiple versions of the same package. So, if we have an SDK that requires v3 of package Foo and the customer wants to use v5 of package Foo, then the customer cannot build their application. This means that our SDKs should not dependend on any additional packages. In addition, customer applications must be able to deploy as fast as possible onto datacetner virtual machines. Removing additional code (like dependencies) improves deployment performance.

1.5.1 :no_entry: **DO NOT** be dependent on any other packages

1.5.2 :white_check_mark: **DO** copy & paste other required code into the SDK package in order to avoid taking a dependency on another package. Make sure that you are not violating any licensing agreements.

1.5.3 :warning: **NOTE** For some languages (most notably Java) you will have no choice but to take dependency on other packages. You must only do this if you truely have no other way to avoid taking the dependency.

## 1.6.0 Configuration 

1.6.1 :white_check_mark: **DO** allow any customer configuration or customization via SDK functions or properties as this allos the cusomter code to determine how to configure SDK options and also how to expose those SDK options to the customer's users. 

1.6.2 :no_entry: **DO NOT** allow any customer configuration or customization via a shared resource like a file or environment variable as this prevents different configurations to exist at the same time.

## Other topics to be covered
-   Tracing
-   Versioning
-	Authorization (credentials)
-	Error/Exception handling
-	Packaging (Brian)
-	Namespaces (Krzysztof)
-	High level structure of APIs (Krzysztof)
-	Docs (reference, Samples, Quick Starts) (Jonathan Giles)
-	UX Study

-   Engineering TOC:
    -	Linter
    - Packaging
    - Signing
    - Project Structure
    - Repos
    - License
    - Testing (unit & E2E)
    - Supported versions
    - Platform Support
    - Stress
    - Performance


## 2.0 C# Specific Guidelines

2.0.1 :white_check_mark: **DO** follow the official [Framework Design Guidelines](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/)

2.0.2 :warning: **NOTE** additional gudelines in this section overrule the Framework Design Guidelines  

<font size="2" color="gray">TODO: describe guidance for logging, configuration, and dependency injection</font>

## 3.0 Java Specific Guidelines

## 4.0 Python Specific Guidelines

## 5.0 JavaScript Specific Guidelines

## 6.0 Go Specific Guidelines
