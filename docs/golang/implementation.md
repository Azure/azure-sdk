---
title: "Go Azure SDK Design Guidelines: Implementation"
keywords: guidelines golang
permalink: golang_implementation.html
folder: golang
sidebar: general_sidebar
---

## API Implementation

TODO

### The Service Client

TODO

#### Service Methods

TODO

##### Using azcore.Pipeline

Each supported language has an Azure Core library that contains common mechanisms for cross cutting concerns such as configuration and doing HTTP requests.

{% include requirement/MUST id="golang-network-use-http-pipeline" %} use the HTTP pipeline component within `azcore` library for communicating to service REST endpoints.

The HTTP pipeline consists of a HTTP transport that is wrapped by multiple policies. Each policy is a control point during which the pipeline can modify either the request and/or response. We prescribe a default set of policies to standardize how client libraries interact with Azure services. The order in the list is the most sensible order for implementation.

{% include requirement/MUST id="golang-network-policies" %} implement the following policies in the HTTP pipeline:

- Telemetry
- Retry
- Authentication
- Response downloader
- Distributed tracing
- Logging
- The HTTP transport itself

{% include requirement/SHOULD id="golang-network-azure-core-policies" %} use the policy implementations in Azure Core whenever possible. Do not try to "write your own" policy unless it is doing something unique to your service. If you need another option to an existing policy, engage with the [Architecture Board] to add the option.

##### Using azcore.Policy

TODO

#### Service Method Parameters

TODO

##### Parameter validation

TODO

### Supporting Types

TODO

#### Model Types

TODO

##### Serialization

TODO

#### Constants as Enumerations

{% include requirement/MUST id="golang-enum-type" %} define the enumeration's type to match the type sent/received over-the-wire (string is the most common example).

{% include requirement/MUST id="golang-enum-value-naming" %} name all values with a prefix of the type's name.

{% include requirement/MUST id="golang-enum-value-grouping" %} place all values for an enumerated type within their own `const` block, which is to immediately follow the type's declaration.

{% include requirement/MUST id="golang-enum-type-values" %} define a function named `<EnumTypeName>Values()` that returns a slice containing all possible values for the enumeration.

```go
// WidgetColor specifies a Widget's color from the list of possible values.
type WidgetColor string

const (
	WidgetColorBlue  WidgetColor = "blue"
	WidgetColorGreen WidgetColor = "green"
	WidgetColorRed   WidgetColor = "red"
)

// PossibleWidgetColorValues returns a slice of possible values for WidgetColor.
func PossibleWidgetColorValues() []WidgetColor {
	// ...
}

```

## SDK Feature Implementation

TODO

### Configuration

{% include requirement/MUST id="golang-config-global" %} use relevant global configuration settings either by default or when explicitly requested to by the user, for example by passing in a configuration object to a client constructor.

{% include requirement/MUST id="golang-config-client" %} allow different clients of the same type to use different configurations.

{% include requirement/MUST id="golang-config-optout" %} allow consumers of your service clients to opt out of all global configuration settings at once.

{% include requirement/MUST id="golang-config-global-override" %} allow all global configuration settings to be overridden by client-provided options. The names of these options should align with any user-facing global configuration keys.

{% include requirement/MUSTNOT id="golang-config-behavior-changes" %} change behavior based on configuration changes that occur after the client is constructed. Hierarchies of clients inherit parent client configuration unless explicitly changed or overridden. Exceptions to this requirement are as follows:

1. Log level, which must take effect immediately across the Azure SDK.
2. Tracing on/off, which must take effect immediately across the Azure SDK.

#### Configuration via Environment Variables

{% include requirement/MUST id="golang-envvars-prefix" %} prefix Azure-specific environment variables with `AZURE_`.

{% include requirement/MAY id="golang-envvars-client-prefix" %} use client library-specific environment variables for portal-configured settings which are provided as parameters to your client library. This generally includes credentials and connection details. For example, Service Bus could support the following environment variables:

* `AZURE_SERVICEBUS_CONNECTION_STRING`
* `AZURE_SERVICEBUS_NAMESPACE`
* `AZURE_SERVICEBUS_ISSUER`
* `AZURE_SERVICEBUS_ACCESS_KEY`

Storage could support:

* `AZURE_STORAGE_ACCOUNT`
* `AZURE_STORAGE_ACCESS_KEY`
* `AZURE_STORAGE_DNS_SUFFIX`
* `AZURE_STORAGE_CONNECTION_STRING`

{% include requirement/MUST id="golang-envvars-approval" %} get approval from the [Architecture Board] for every new environment variable.

{% include requirement/MUST id="golang-envvars-syntax" %} use this syntax for environment variables specific to a particular Azure service:

* `AZURE_<ServiceName>_<ConfigurationKey>`

Where _ServiceName_ is the canonical shortname without spaces, and _ConfigurationKey_ refers to an unnested configuration key for that client library.

{% include requirement/MUSTNOT id="golang-envvars-posix-compliance" %} use non-alpha-numeric characters in your environment variable names with the exception of underscore. This ensures broad interoperability.

### Logging

Client libraries must support robust logging mechanisms so that the consumer can adequately diagnose issues with the method calls and quickly determine whether the issue is in the consumer code, client library code, or service.

{% include requirement/MUST id="golang-log-api" %} use the Logger API provided within `azcore` as the sole logging API throughout all client libraries.

{% include requirement/MUST id="golang-log-classification" %} define constant classification strings using the `azcore.LogClassification` type, then log using these values.

{% include requirement/MUST id="golang-log-inclue" %} log HTTP request line, response line, and all header/query parameter names.

{% include requirement/MUSTNOT id="golang-log-exclude" %} log payloads or HTTP header/query parameter values that aren't on the allow list.  For header/query parameters not on the allow list use the value `<REDACTED>` in place of the real value.

### Distributed Tracing

{% include requirement/MUST id="golang-tracing-abstraction" %} abstract the underlying tracing facility, allowing consumers to use the tracing implementation of their choice.

{% include requirement/MUST id="golang-tracing-span-per-call" %} create a new trace span for each API call.  New spans must be children of the context that was passed in.

{% include requirement/MUST id="golang-tracing-span-name" %} use `<package name>.<type name>.<method name>` as the name of the span.

{% include requirement/MUST id="golang-tracing-propagate" %} propagate tracing context on each outgoing service request through the appropriate headers to support a tracing service like [Azure Monitor](https://azure.microsoft.com/services/monitor/) or [ZipKin](https://zipkin.io/).  This is generally done with the HTTP pipeline.

### Telemetry

TODO

### Testing

TODO
