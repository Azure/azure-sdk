---
title: "Go Azure SDK Design Guidelines"
keywords: guidelines golang
permalink: golang_introduction.html
folder: golang
sidebar: general_sidebar
---

## Introduction

The Go guidelines are for the benefit of client library designers targeting service applications written in [Go](https://golang.org/).

### Design principles {#golang-principles}

The Azure SDK should be designed to enhance the productivity of developers connecting to Azure services. Other qualities (such as completeness, extensibility, and performance) are important but secondary. Productivity is achieved by adhering to the principles described below:

**Idiomatic**

* The SDK should follow the general design guidelines and conventions for the target language. It should feel natural to a developer in the target language.
* We embrace the ecosystem with its strengths and its flaws.
* We work with the ecosystem to improve it for all developers.

**Consistent**

* Client libraries should be consistent within the language, consistent with the service and consistent between all target languages. In cases of conflict, consistency within the language is the highest priority and consistency between all target languages is the lowest priority.
* Service-agnostic concepts such as logging, HTTP communication, and error handling should be consistent. The developer should not have to relearn service-agnostic concepts as they move between client libraries.
* Consistency of terminology between the client library and the service is a good thing that aids in diagnosability.
* All differences between the service and client library must have a good (articulated) reason for existing, rooted in idiomatic usage rather than whim.
* The Azure SDK for each target language feels like a single product developed by a single team.
* There should be feature parity across target languages. This is more important than feature parity with the service.

**Approachable**

* We are experts in the supported technologies so our customers, the developers, don't have to be.
* Developers should find great documentation (hero tutorial, how to articles, samples, and API documentation) that makes it easy to be successful with the Azure service.
* Getting off the ground should be easy through the use of predictable defaults that implement best practices. Think about progressive concept disclosure.
* The SDK should be easily acquired through the most normal mechanisms in the target language and ecosystem.
* Developers can be overwhelmed when learning new service concepts. The core use cases should be discoverable.

**Diagnosable**

* The developer should be able to understand what is going on.
* It should be discoverable when and under what circumstances a network call is made.
* Defaults are discoverable and their intent is clear.
* Logging, tracing, and error handling are fundamental and should be thoughtful.
* Error messages should be concise, correlated with the service, actionable, and human readable. Ideally, the error message should lead the consumer to a useful action that they can take.
* Integrating with the preferred debugger for the target language should be easy.

**Dependable**

* Breaking changes are more harmful to a user's experience than most new features and improvements are beneficial.
* Incompatibilities should never be introduced deliberately without thorough review and very strong justification.
* Do not rely on dependencies that can force our hand on compatibility.

### General Guidelines {#golang-general}

{% include requirement/MUST id="golang-general-follow-general-guidelines" %} follow the [General Azure SDK Guidelines].

{% include requirement/MUST id="golang-general-use-azcore-pipeline" %} use `azcore.Pipeline` to implement all methods that call Azure REST services.

{% include requirement/MUST id="golang-general-idiomatic-code" %} write idiomatic Go code.  If you're not familiar with the language, a great place to start is <https://golang.org/doc/effective_go>.  Do **NOT** simply attempt to translate your language of choice into Go.

### Support for non-HTTP Protocols

This document contains guidelines developed primarily for typical Azure REST services, i.e. stateless services with request-response based interaction model. Many of the guidelines in this document are more broadly applicable, but some might be specific to such REST services.

## Azure SDK API Design {#golang-api}

Azure services will be exposed to Go developers as one or more _service client_ types and a set of _supporting types_.

### Service Clients {#golang-client}

Your API surface consists of one or more service clients that the consumer instantiates to connect to your service, plus a set of supporting types.

{% include requirement/MUST id="golang-client-naming" %} name service client types with the `Client` suffix.

```go
type WidgetClient struct {
	// all fields MUST NOT be exported
}
```

#### Service Client Constructors

{% include requirement/MUST id="golang-client-constructors" %} provide one or more constructors in the following format that return a new instance of a service client type.  The "simple named" constructor MUST use an `azcore.TokenCredential`, assuming the service supports AAD authentication.  If not, then the preferred credential type is used instead.  Constructors MUST return the client instance by reference.

```go
// NewWidgetClient creates a new instance of WidgetClient with the specified values.
// endpoint - The URI of the Widget.
// cred - The AAD token credential used to authenticate with the Widget service.
// options - Optional WidgetClient values.  Pass nil to accept default values.
func NewWidgetClient(endpoint string, cred azcore.TokenCredential, options *WidgetClientOptions) (*WidgetClient, error) {
	// ...
}

// NewWidgetClientWithNoCredential creates a new instance of WidgetClient with the specified values.
// endpoint - The URI of the Widget that supports anonymous/SAS authentication
// options - Optional WidgetClient values.  Pass nil to accept default values.
func NewWidgetClientWithNoCredential(endpoint string, options *WidgetClientOptions) (*WidgetClient, error) {
	// ...
}

// NewWidgetClientFromConnectionString creates a new instance of WidgetClient from the specified connection string.
// options - Optional WidgetClient values.  Pass nil to accept default values.
func NewWidgetClientFromConnectionString(connectionString string, options *WidgetClientOptions) (*WidgetClient, error) {
	// ...
}
```

{% include requirement/MUST id="golang-client-constructors-params" %} document all constructor parameters as part of the method block comment.

##### Service Client Configuration

##### Setting the Service Version

{% include requirement/MUST id="golang-api-service-client-versioning-highest-api" %} call the highest supported service API version by default.

{% include requirement/MUST id="golang-api-service-client-versioning-select-api-version" %} allow the consumer to explicitly select a supported service API version when instantiating the service client.

##### Client Immutability

{% include requirement/MUST id="golang-api-service-client-immutable" %} ensure that all service client types are safe for concurrent use by multiple goroutines.  Ideally, all client state is immutable which will satisfy this guideline.

{% include requirement/MUSTNOT id="golang-api-service-client-fields" %} export any fields on client types.  This is to support mocking of clients via interface types.

#### Service Methods

_Service methods_ are the methods on the client that invoke operations on the service.

##### Sync and Async

The Go idiom is to expose only synchronous methods.  This allows callers to implement asynchronous calls as appropriate for their use-case.

{% include requirement/MUSTNOT id="golang-api-sync-only" %} create any goroutines inside an API call or return any channels which implies concurrent behavior.  This allows the consumer to control the concurrent implementation in a way that works best with their application.


{% include requirement/SHOULD id="golang-api-async-helper" %} create higher-level abstractions that work asynchronously where appropriate, allowing consumers the ability to opt-in to the async behavior.

##### Naming

{% include requirement/MUST id="golang-client-crud-verbs" %} prefer the use of the following terms for CRUD operations:

| Verb           | Parameters | Comments |
| `Set<noun>`    | key,item   | Adds new item or updates existing item. |
| `Add<noun>`    | key,item   | Adds a new item.  Fails if item already exists. |
| `Update<noun>` | key,item   | Updates an existing item.  Fails if item doesn't exist. |
| `Delete<noun>` | key        | Deletes an existing item. Doesn't fail if item doesn't exist. |
| `Get<noun>`    | key        | Will retun an error if item doesn't exist. |
| `List<noun>`   |            | Returns list of items.  Returns empty list if no items exist. |
| `<noun>Exists` | key        | Returns `true` if the item exists. |

{% include requirement/SHOULD id="golang-client-verbs-flexible" %} remain flexible and use names best suited for developer experience. Don’t conflict with terminology used by the service team’s documentation, blogs, and presentations.

{% include requirement/MUSTNOT id="golang-api-multimethods" %} provide multiple methods for a single REST endpoint.

##### Return Types

Requests to the service fall into two basic groups: methods that make a single logical request, and methods that make a deterministic sequence of requests. An example of a _single logical request_ is a request that may be retried inside the operation. An example of a _deterministic sequence of requests_ is a paged operation.

The _response envelope_ is a protocol neutral representation of a response. The response envelope may combine data from headers and response body. For example, you may expose an `ETag` header as a property on the response envelope. `<Client><Method>Response` is the ‘response envelope’. It contains HTTP headers and the object (a deserialized object created from the response body).  Response envelopes MUST be returned by value.

{% include requirement/MUST id="golang-response-logical-entity" %} return the response envelope for the normal form of a service method. The response envelope MUST represent the information needed in the 99%+ case.

```go
// WidgetClientGetResponse contains the response from method WidgetClient.Get.
type WidgetClientGetResponse struct {
	// ETag contains the value from the ETag header.
	ETag *azcore.ETag

	// LastModified contains the value from the last-modified header.
	LastModified *time.Time

	// Widget contains the unmarshalled response body in Widget format.
	Widget
}

type Widget struct {
	Name string
	Color WidgetColor
}

func (c *WidgetClient) Get(ctx context.Context, name string, options *WidgetClientGetOptions) (WidgetClientGetResponse, error) {
	// ...
}
```

{% include requirement/MUST id="golang-response-examples" %} provide examples on how to access the streamed response for a request, where exposed by the client library. We don’t expect all methods to expose a streamed response.

```go
// WidgetClientGetBinaryResponse contains the response from method WidgetClient.GetBinaryResponse.
type WidgetClientGetBinaryResponse struct {
	// Body contains the streaming response.
	Body io.ReadCloser
}

func (c *WidgetClient) GetBinaryResponse(ctx context.Context, name string, options *WidgetClientGetBinaryResponseOptions) (WidgetClientGetBinaryResponse, error) {
	// ...
}
```

{% include requirement/MUST id="golang-response-logical-paging" %} provide an idiomatic way to enumerate all logical entities for a paged operation, automatically fetching new pages as needed.  For more information on what to return for List operations, refer to [Pagination](#pagination).

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="golang-response-no-headers" %} return headers and other per-request metadata unless it’s obvious as to which specific HTTP request the method’s return value corresponds to.

{% include requirement/MUST id="golang-response-failure-info" %} provide enough information in failure cases for an application to take appropriate corrective action.

Model structures are types that consumers use to provide required information into client library methods.  They can also be returned from client methods. These structures typically represent the domain model, or option structures that must be configured before the request can be made.

{% include requirement/MUST id="golang-model-types" %} export all fields on model types to allow for mocking.

{% include requirement/MUST id="golang-model-types-ro" %} document all read-only fields and exclude their values when marshalling the structure to be sent over the wire.

##### Cancellation

Cancellation is handled via the `context.Context` paramater, which is _always_ the first method parameter.  All APIs that perform I/O of any kind, sleep, or perform a significant amount of CPU-bound work _must_ take a `context.Context` as its first parameter.  Please see the documentation for [context](https://pkg.go.dev/context) for more information, including examples.

##### Thread Safety

{% include requirement/MUST id="golang-methods-thread-safety" %} be safe for concurrent use across multiple goroutines.

#### Service Method Parameters

{% include requirement/MUST id="golang-api-service-client-byref" %} ensure that all methods on client types pass their receiver by reference.

{% include requirement/MUST id="golang-api-context" %} accept a `context.Context` object as the first parameter to every method that performs any I/O operations.

{% include requirement/MUST id="golang-api-mandatory-params" %} have every I/O method accept all required parameters after the mandatory `context.Context` object.

##### Optional Parameters

{% include requirement/MUST id="golang-api-options-struct" %} define a `<Client><Method>Options` structure for every method.  This structure includes fields for all non-mandatory parameters. The structure can have fields added to it over time to simplify versioning.  To disambiguate names, use the client type name for a prefix.  If the method contains no optional parameters, the `options` struct should have a comment indicating it's a placeholder for future optional parameters.

```go
// WidgetClientGetOptions contains the optional parameters for the WidgetClient.Get method.
type WidgetClientGetOptions struct {
	Tag *string
	Length *int
}

// WidgetClientSetOptions contains the optional parameters for the WidgetClient.Set method.
type WidgetClientSetOptions struct {
	// placeholder for future optional parameters
}
```

{% include requirement/MUST id="golang-api-options-ptr" %} allow the user to pass a pointer to the structure as the last parameter. If the user passes `nil`, then the method should assume appropriate default values for all the structure’s fields.  Note that `nil` and a zero-initialized `<Client><Method>Options` structure **are required** to be semantically equivalent.

{% include requirement/MUST id="golang-api-params" %} document all parameters as part of the method block comment.

```go
// Get retrieves the specified Widget.
// ctx - The context used to control the lifetime of the request.
// name - The name of the Widget to retrieve.
// options - Any optional parameters.
func (c *WidgetClient) Get(ctx context.Context, name string, options *WidgetClientGetOptions) (WidgetClientGetResponse, error) {
	// ...
}
```

##### Parameter Validation

The service client will have several methods that perform requests on the service. _Service parameters_ are directly passed across the wire to an Azure service. _Client parameters_ are not passed directly to the service, but used within the client library to fulfill the request.  Examples of client parameters include values that are used to construct a URI, or a file that needs to be uploaded to storage.

{% include requirement/MUST id="golang-params-client-validation" %} validate client parameters.

{% include requirement/MUSTNOT id="golang-params-service-validation" %} validate service parameters. This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUST id="golang-params-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service. If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

#### Methods Returning Collections (Paging)

{% include requirement/MUST id="golang-pagination" %} return an instance of `*runtime.Pager[T]` for operations that return pages.  `runtime.Pager[T]` allows consumers to iterate over all pages as defined by the service.

{% include requirement/MUST id="golang-paged-method-naming" %} name methods that return a `*runtime.Pager[T]` with pattern `New<Operation>Pager`.

{% include requirement/MUSTNOT id="golang-paging-io" %} perform any IO when creating the `runtime.Pager[T]`.  This implies that the method does NOT take a context and does NOT return an error.

```go
func (c *WidgetClient) NewListPager(options *WidgetClientListOptions) *runtime.Pager[WidgetClientListResponse] {
	// ...
}

type WidgetClientListResponse struct {
	WidgetsListResult
}

type WidgetsListResult struct {
	Values []*Widget

	NextLink *string
}

pager := client.NewListPager(nil)
for pager.More() {
	page, err := pager.NextPage(context.Background())
	if err != nil {
		// handle error...
	}
	for _, w := range page.Value {
		process(w)
	}
}
```

{% include requirement/MUST id="golang-pagination-serialization" %} provide means to serialize and deserialize a `runtime.Pager[T]` so that paging can pause and continue, potentially on another machine.

#### Methods Invoking Long Running Operations

{% include requirement/MUST id="golang-lro-poller" %} return an instance of `*runtime.Poller[T]` for long-running operation methods.  `runtime.Poller[T]` encapsulates the polling and status of the long-running operation.

{% include requirement/MUST id="golang-lro-method-naming" %} prefix methods which return a `*runtime.Poller[T]` with `Begin`.

```go
// BeginCreate creates a new widget with the specified name.
func (c *WidgetClient) BeginCreate(ctx context.Context, name string, options *WidgetClientBeginCreateOptions) (*runtime.Poller[WidgetClientCreateResponse], error) {
	// ...
}

// WidgetClientCreateResponse contains the response from method WidgetClient.BeginCreate.
type WidgetClientCreateResponse struct {
	Widget
}
```

{% include requirement/MUST id="golang-lro-resuming-operations" %} provide a field named `ResumeToken` in the `<Client><Method>Options` type used to instantiate a `*runtime.Poller[T]` type with the `ResumeToken` from a previous call to `Poller[T].ResumeToken()`.

```go
// WidgetClientBeginCreateOptions contains the optional parameters for the WidgetClient.BeginCreate method.
type WidgetClientBeginCreateOptions struct {
	// Resumes the LRO from the provided token.
	ResumeToken string
}
```

{% include requirement/MUSTNOT id="golang-lro-cancel" %} cancel the LRO when cancellation is requested via a context. The context is cancelling the polling operation and should not have any effect on the service.

{% include requirement/MUST id="golang-lro-pattern" %} follow the operation pattern for all LROs.

```go
// example #1, blocking call to PollUntilDone()
poller, err := client.BeginCreate(context.Background(), "blue_widget", nil)
if err != nil {
	// handle error...
}

w, err = poller.PollUntilDone(context.Background(), &runtime.PollUntilDoneOptions{Frequency: 5*time.Second})
if err != nil {
	// handle error...
}

process(w)

// example #2, customized poll loop
poller, err := client.BeginCreate(context.Background(), "green_widget")
if err != nil {
	// handle error...
}

for {
	resp, err := poller.Poll(context.Background())
	if err != nil {
		// handle error ...
	}
	if poller.Done() {
		break
	}
	if delay := runtime.RetryAfter(resp); delay > 0 {
		time.Sleep(delay)
	} else {
		time.Sleep(frequency)
	}
}
w, err := poller.Result(context.Background())
if err != nil {
	// handle error ...
}
process(w)

// example #3, resuming from a previous operation
// getting the resume token from a previous poller instance
poller, err := client.BeginCreate(context.Background(), "blue_widget", nil)
if err != nil {
	// handle error...
}

tk, err := poller.ResumeToken()
if err != nil {
	// handle error ...
}

// resuming from the resume token that was previously saved
poller, err = client.BeginCreate(context.Background(), "", &WidgetClientBeginCreateOptions{
	ResumeToken: tk,
})
if err != nil {
	// handle error ...
}

w, err = poller.PollUntilDone(context.Background(), nil)
if err != nil {
	// handle error...
}
process(w)
```

##### Conditional Request Methods

##### Hierarchical Clients

### Supporting Types

In addition to service client types, Azure SDK APIs provide and use other supporting types as well.

#### Model Types

##### Model Type Naming

#### Constants as Enumerations

{% include requirement/MUST id="golang-const" %} use a `const` for parameters, fields, and return types when values are known.

#### Azure Core Types

#### Primitive Types

### Error Handling

{% include requirement/MUST id="golang-errors" %} return an error if a method fails to perform its intended functionality.  For methods that return multiple items, the error object is always the last item in the return signature.

{% include requirement/SHOULD id="golang-errors-wrapping" %} wrap an error with another error if it would help in the diagnosis of the underlying failure.  Expect consumers to use [error helper functions](https://blog.golang.org/go1.13-errors) like `errors.As()` and `errors.Is()`.

```go
err := xml.Unmarshal(resp.Payload, v)
if err != nil {
	return fmt.Errorf("unmarshalling type %s: %w", reflect.TypeOf(v).Elem().Name(), err)
}
```

{% include requirement/MUST id="golang-errors-on-request-failed" %} return the service/operation specific error type when an HTTP request fails with an unsuccessful HTTP status code as defined by the service.  For operations that do not define an error type, return the HTTP response body in string format if available, else return the `Status` string on the HTTP response.

{% include requirement/MUST id="golang-errors-include-response" %} include the HTTP response and originating request in the returned error.  Use `runtime.NewResponseError()` from the `sdk/internal` module to provide this information.

In the case of a method that makes multiple HTTP requests, the first error encountered should stop the remainder of the operation and this error (or another error wrapping it) should be returned.

{% include requirement/MUST id="golang-errors-distinct-types" %} return distinct error types so that consumers can distinguish between a client error (incomplete/incorrect API parameter values) and other SDK failures (failure to send the request, marshalling/unmarshalling, parsing errors).

{% include requirement/MUST id="golang-errors-documentation" %} document the error types that are returned by each method.  Don't document commonly returned error types, for example `context.DeadlineExceeded` when an HTTP request times out.

{% include requirement/MUSTNOT id="golang-errors-other-types" %} create arbitrary error types.  Use error types provided by the service, standard library, or `azcore`.

### Authentication

Azure services use different kinds of authentication schemes to allow clients to access the service. Conceptually, there are two entities responsible in this process: a credential and an authentication policy. Credentials provide confidential authentication data. Authentication policies use the data provided by a credential to modify an HTTP request before it is sent to the service.

{% include requirement/MUST id="golang-auth-support" %} support all authentication techniques that the service supports.

{% include requirement/MUST id="golang-auth-use-azidentity" %} use credential and authentication policy implementations from the `azcore` or `azidentity` package where available.

{% include requirement/MUST id="golang-auth-concurrency" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service. If using a service-specific credential type, the implementation must be safe for concurrent use by multiple goroutines.

{% include requirement/MUSTNOT id="golang-auth-connection-strings" %} support constructing a service client with a connection string unless such connection string is available within tooling (e.g. Azure portal, for copy/paste operations). A connection string is a combination of an endpoint, credential data, and other options used to simplify service client configuration. Connection strings are easily integrated into an application by copy/paste from the portal. However, credentials within a connection string can’t be rotated within a running process. Their use should be discouraged in production apps.  If the client library supports connection strings, the constructor should look like this:

```go
// NewWidgetClientFromConnectionString creates a new instance of WidgetClient with the specified values.  It uses the default pipeline configuration.
func NewWidgetClientFromConnectionString(con string, options *WidgetClientOptions) (*WidgetClient, error) {
	// ...
}
```

When implementing authentication, don't open up the consumer to security holes like PII (personally identifiable information) leakage or credential leakage. Credentials are generally issued with a time limit, and must be refreshed periodically to ensure that the service connection continues to function as expected. Ensure your client library follows all current security recommendations and consider an independent security review of the client library to ensure you're not introducing potential security problems for the consumer.

{% include requirement/MUSTNOT id="golang-auth-persistence" %} persist, cache, or reuse security credentials. Security credentials should be considered short lived to cover both security concerns and credential refresh situations.

{% include requirement/MUST id="golang-auth-policy-impl" %} provide a suitable authentication policy if your service implements a non-standard authentication system (that is, an authentication system that is not supported by Azure Core).  You also need to produce an authentication policy for the HTTP pipeline that can add credentials to requests given the alternative authentication mechanism provided by the service.  Custom credentials will need to implement the `azcore.Credentials` interface.

### Package Naming

### Support for Mocking

One of the key things we want to support is to allow consumers of the package to easily write repeatable unit-tests for their applications without activating a service. This allows them to reliably and quickly test their code without worrying about the vagaries of the underlying service implementation (including, for example, network conditions or service outages). Mocking is also helpful to simulate failures, edge cases, and hard to reproduce situations (for example: does code work on February 29th).

{% include requirement/MUST id="golang-mock-friendly" %} generate types and methods that can be mocked to simulate a response from an Azure endpoint.

{% include requirement/MUST id="golang-mock-procedure" %} document the tools and procedures recommended to generate client interfaces for mocking.

{% include requirement/MUST id="golang-mock-lro-pages" %} generate interface types for LRO and pageable response types that contain all of the methods for their respective types.  The interface type name will be the same as the LRO/pageable response type name.

{% include requirement/MUST id="golang-test-recordings" %} support HTTP request and response recording/playback via the pipeline.

## Azure SDK Module Design

### Packages {#golang-packages}

Go groups related types in a package.  In Go, the package should be named `<prefix><service>`, where `<prefix>` is either `arm` or `az`, and where `<service>` is the service name represented as a single word.

{% include requirement/MUST id="golang-package-prefix" %} start the package with `arm` or `az` to indicate an Azure client package.  Use `arm` for management-plane packages, and `az` for all other packages.

{% include requirement/MUST id="golang-package-name" %} construct the package name with all lowercase letters (uppercase letters, hyphens and underscores are not allowed). For example, the Azure compute management package would be named `armcompute` and the Azure blob storage package would be named `azblob`.

{% include requirement/MUST id="golang-package-registration" %} register the chosen package name with the [Architecture Board]. Open an issue to request the package name. See the [registered package list] for a list of the currently registered packages.

#### Directory Structure

{% include requirement/MUST id="golang-pkgpath-construction" %} construct a package import path that allows the consumer to tie its packages to the service being used. The package path does **NOT** change when the branding of the product changes. Avoid the use of marketing names that may change.

{% include requirement/MUST id="golang-pkgpath-leaf" %} ensure that the package leaf directory name matches the package name declared in the source code.

{% include requirement/MUST id="golang-pkgpath-apiver" %} ensure that each service API version is in its own directory, IFF that service supports multiple API versions.

{% include requirement/MUST id="golang-pkgpath-mgmt" %} place the management (Azure Resource Manager) API in the `arm` path. Use the grouping `./sdk/arm/<group>/<api-version>/arm<service>` for the package path. Since more services require management APIs than data plane APIs, other paths may be used explicitly for management only. Data plane usage is by exception only. Additional paths that can be used for control plane SDKs include:

{% include tables/mgmt_namespaces.md %}

Many management APIs do not have a data plane because they deal with management of the Azure account. Place the management package in the `arm` path. For example, use `sdk/arm/costanalysis/...` instead of `sdk/arm/management/costanalysis`.

Here is a complete example.

Data-plane packages:

- github.com/Azure/azure-sdk-for-go/sdk/keyvault/7.0/azkeyvault
- github.com/Azure/azure-sdk-for-go/sdk/storage/blob/2019-12-19/azblob
- github.com/Azure/azure-sdk-for-go/sdk/storage/queue/2019-12-19/azqueue
- github.com/Azure/azure-sdk-for-go/sdk/storage/table/2019-12-19/aztable

Management-plane packages:

- github.com/Azure/azure-sdk-for-go/sdk/arm/keyvault/2019-09-01/armkeyvault
- github.com/Azure/azure-sdk-for-go/sdk/arm/storage/2019-01-01/armstorage
- github.com/Azure/azure-sdk-for-go/sdk/arm/storage/2019-02-01/armstorage

#### Common Packages

There are occasions when common code needs to be shared between several client packages. For example, a set of cooperating client packages may wish to share a set of errors or models.

{% include requirement/MUST id="golang-commonlib-approval" %} gain [Architecture Board] approval prior to implementing a common package.

{% include requirement/MUST id="golang-commonlib-minimize-code" %} minimize the code within a common package. Code within the common package is treated the same as any other client package.

{% include requirement/MUST id="golang-commonlib-namespace" %} store the common package in the same directory as the associated client packages.

A common package will only be approved if:

* The consumer of the non-shared package will consume the objects within the common package directly, AND
* The information will be shared between multiple client package.

Let's take two examples:

1. Implementing two Cognitive Services client packages, we find a model is required that is produced by one Cognitive Services client package and consumed by another Coginitive Services client package, or the same model is produced by two client packages. The consumer is required to do the passing of the model in their code, or may need to compare the model produced by one client package vs. that produced by another client package. This is a good candidate for choosing a common package.

2. Two Cognitive Services client packages return a `BoundingBox` model to indicate where an object was detected in an image. There is no linkage between the `BoundingBox` model in each client package, and it is not passed into another client package. This is not a good candidate for creation of a common package (although you may wish to place this model in a common package if one exists for the namespace already). Instead, produce two different models - one in each client package.

### Package Versioning

{% include requirement/MUST id="golang-versioning-modules" %} release each package as a [Go module](https://blog.golang.org/using-go-modules).  Legacy dependency management tools such as `dep` and `glide` are not supported.

{% include requirement/MUST id="golang-versioning-semver" %} release versions of modules in accordance with [semver 2.0](https://semver.org/spec/v2.0.0.html).

{% include requirement/MUST id="golang-versioning-beta" %} clearly version prerelease modules.  For new modules, use a v0 major version with no suffix (v0.1.0).  For existing modules, use a `-beta` suffix (v1.1.0-beta, v2.0.0-beta).

### Dependencies

Packages should strive to avoid taking dependencies on packages outside of the standard library for the following reasons:

- **Versioning** - Exposing types defined outside the standard library (i.e. `exchange types`) can indroduce versioning complexity.  If we have an client package that exposes types from a v3 of package Foo and the consumer wants to use v5 of package Foo, then the consumer cannot use the v5 types to satisfy the v3 requirement.
- **Size** - Consumer applications must be able to deploy as fast as possible into the cloud and move in various ways across networks. Removing additional code (like dependencies) improves deployment performance.
- **Licensing** - You must be conscious of the licensing restrictions of a dependency and often provide proper attribution and notices when using them.
- **Compatibility** - Often times you do not control a dependency and it may choose to evolve in a direction that is incompatible with your original use.
- **Security** - If a security vulnerability is discovered in a dependency, it may be difficult or time consuming to get the vulnerability corrected if Microsoft does not control the dependency's code base.

{% include requirement/MUST id="golang-dependencies-exch-types" %} limit exchange types to those provided by the standard library (**NO EXCEPTIONS**).

{% include requirement/MUST id="golang-dependencies-azure-core" %} depend on the `azcore` package for functionality that is common across all client packages.  This package includes APIs for HTTP connectivity, global configuration, logging, credential handling, and more.

{% include requirement/MUST id="golang-dependencies-sdk-internal" %} depend on the `sdk/internal` package for functionality that is common across all client packages that should not be publicly exported.  This package includes helpers for creating errors with stack frame information, and more.

{% include requirement/MUSTNOT id="golang-dependencies-approved-list" %} be dependent on any other packages within the client package distribution package, with the exception of the following:

{% include_relative approved_dependencies.md %}

### Native Code

Native dependencies introduce lots of complexities and should be avoided.

{% include requirement/SHOULDNOT id="golang-problems-native-dependencies" %} use native dependencies.

### Doc Comments

{% include requirement/MUST id="golang-document-everything" %} document every exported constant, function, and type within a package.

## Repository Guidelines

{% include requirement/MUST id="golang-general-repository" %} locate all source code in the [azure/azure-sdk-for-go] GitHub repository.

{% include requirement/MUST id="golang-general-engsys" %} follow Azure SDK engineering systems guidelines for working in the [azure/azure-sdk-for-go] GitHub repository.

### Documentation Style

{% include requirement/SHOULD id="golang-docs-to-silence" %} attempt to document your library into silence. Preempt developers' usage questions and minimize GitHub issues by clearly explaining your API in the [GoDoc]. Include information on service limits and errors they might hit, and how to avoid and recover from those errors.

As you write your code, *doc it so you never hear about it again.* The less questions you have to answer about your client library, the more time you have to build new features for your service.

### README

{% include requirement/MUST id="golang-docs-readme" %} have a README.md file in the package root folder.

An example of a good `README.md` file can be found [here](https://github.com/Azure/azure-sdk-for-go/blob/main/sdk/security/keyvault/azkeys/README.md).

{% include requirement/MUST id="golang-docs-readme-consumer" %} optimize the `README.md` for the consumer of the client library.

The contributor guide (`CONTRIBUTING.md`) should be a separate file linked to from the main component `README.md`.

### Samples

Code examples are small functions that demonstrate a certain feature that is relevant to the client library.  Examples allow developers to quickly understand the full usage requirements of your client library.  Code examples shouldn't be any more complex than needed to demonstrate the feature.  Don't write full applications.  Examples should have a high signal to noise ratio between useful code and boilerplate code for non-related reasons.

{% include requirement/MUST id="golang-include-code-examples" %} include code examples within your package’s code. The examples should clearly and succinctly demonstrate the code most developers need to write with your library. Include examples for all common operations. Pay attention to operations that are complex or might be difficult for new users of your library. Include examples for the champion scenarios you’ve identified for the library.

{% include requirement/MUST id="golang-code-example-location" %} place code examples within the package directory, for example in an `examples_test.go` file.

{% include requirement/MUST id="golang-code-example-comments" %} add an `Output:` or `Unordered output:` [comment](https://golang.org/pkg/testing/#hdr-Examples) at the end of the example if the output is deterministic and suitable for running as a unit test.

{% include requirement/MUST id="golang-code-example-graft" %} ensure that code examples can be easily grafted from the documentation into a user’s own application.

{% include requirement/MUST id="golang-code-example-readability" %} write code examples for ease of reading and comprehension over code compactness and efficiency.

{% include requirement/MUST id="golang-code-example-platforms" %} ensure that examples can run in Windows, macOS, and Linux development environments.

{% include requirement/MUST id="golang-code-example-builds" %} build and test your code examples using the repository’s continuous integration (CI) to ensure they remain functional.

{% include requirement/MUST id="golang-code-example-exports" %} ensure that all exported types, members, functions, and methods are documented. 

{% include requirement/MUSTNOT id="golang-code-example-combination" %} combine multiple operations in a code example unless it’s required for demonstrating the type or member. For example, a Cosmos DB code example doesn’t include both account and container creation operations. Create an example for account creation, and another example for container creation.

Combined operations require knowledge of additional operations that might be outside the user’s current focus. The developer must first understand the code surrounding the operation they’re working on and can’t copy and paste the code example into their project.

{% include refs.md %}
{% include_relative refs.md %}
