---
title: "Go Guidelines: API Design"
keywords: guidelines golang
permalink: golang_design.html
folder: golang
sidebar: general_sidebar
---

{% include draft.html content="The Go Language guidelines are in DRAFT status" %}

## Azure SDK API Design

Azure services will be exposed to Go developers as one or more _service client_ types and a set of _supporting types_.

### Service Clients

Your API surface consists of one or more service clients that the consumer instantiates to connect to your service, plus a set of supporting types.

{% include requirement/MUST id="golang-client-naming" %} name service client types with the `Client` suffix.

```go
type WidgetClient struct {
	// all fields MUST NOT be exported
}
```

#### Service Client Constructors

{% include requirement/MUST id="golang-client-constructors" %} provide two constructors in the following format that return a new instance of a service client type.  Constructors MUST return the client instance by reference.

```go
// NewWidgetClient creates a new instance of WidgetClient with the specified values.  It uses the default pipeline configuration.
// endpoint - The URI of the Widget.
// cred - The credential used to authenticate with the Widget service.
// options - Optional WidgetClient values.  Pass nil to accept default values.
func NewWidgetClient(endpoint string, cred azcore.Credential, options *WidgetClientOptions) (*WidgetClient, error) {
	// ...
}

// NewWidgetClientWithPipeline creates a new instance of WidgetClient with the specified values and custom pipeline.
// endpoint - The URI of the Widget.
// p - The pipeline used to process HTTP requests and responses for this WidgetClient.
func NewWidgetClientWithPipeline(endpoint string, p azcore.Pipeline) (*WidgetClient, error) {
	// ...
}
```

{% include requirement/MUST id="golang-client-constructors" %} provide a default constructor in the following format for services with a default endpoint (management plane is the most common example).

```go
// NewDefaultClient creates a new instance of WidgetClient with the specified values.  It uses the default endpoint and pipeline configuration.
// cred - The credential used to authenticate with the Widget service.
// options - Optional Client values.  Pass nil to accept default values.
func NewDefaultClient(cred azcore.Credential, options *ClientOptions) (*WidgetClient, error) {

}
```

{% include requirement/MUST id="golang-client-constructors-params" %} document all constructor parameters as part of the method block comment.

##### Service Client Configuration

TODO

##### Setting the Service Version

TODO

##### Client Immutability

{% include requirement/MUST id="golang-api-service-client-immutable" %} ensure that all service client types are safe for concurrent use by multiple goroutines.  Ideally, all client state is immutable which will satisfy this guideline.

{% include requirement/MUSTNOT id="golang-api-service-client-fields" %} export any fields on client types.  This is to support mocking of clients via interface types.

#### Service Methods

_Service methods_ are the methods on the client that invoke operations on the service.

##### Sync and Async

The Go idiom is to expose only synchronous methods.  This allows callers to implement asynchronous calls as appropriate for their use-case.

{% include requirement/MUSTNOT id="golang-api-sync-async" %} create any goroutines inside an API call or return any channels which implies concurrent behavior.

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

The _response envelope_ is a protocol neutral representation of a response. The response envelope may combine data from headers, body, and the HTTP response. For example, you may expose an `ETag` header as a property on the response envelope. `<Resource>Response` is the ‘response envelope’. It contains HTTP headers, the object (a deserialized object created from the response body), and the raw HTTP response.  Response envelopes MUST be returned by value.

{% include requirement/MUST id="golang-response-logical-entity" %} return the response envelope for the normal form of a service method. The response envelope MUST represent the information needed in the 99%+ case.

```go
// WidgetResponse is the response envelope for operations that return a Widget type.
type WidgetResponse struct {
	// ETag contains the value from the ETag header.
	ETag *string

	// LastModified contains the value from the last-modified header.
	LastModified *time.Time

	// Widget contains the unmarshalled response body in Widget format.
	Widget *Widget

	// RawResponse contains the underlying HTTP response.
	RawResponse *http.Response
}

type Widget struct {
	Name string
	Color WidgetColor
}

func (c *WidgetClient) GetWidget(ctx context.Context, name string, options *GetWidgetOptions) (WidgetResponse, error) {
	// ...
}
```

{% include requirement/MUST id="golang-response-examples" %} provide examples on how to access the streamed response for a request, where exposed by the client library. We don’t expect all methods to expose a streamed response.

```go
func (c *WidgetClient) GetBinaryResponse(ctx context.Context, name string, options *GetBinaryResponseOptions) (*http.Response, error) {
	// ...
}

// callers read from the io.ReadCloser Body field on the HTTP response.
```

{% include requirement/MUST id="golang-response-logical-paging" %} provide an idiomatic way to enumerate all logical entities for a paged operation, automatically fetching new pages as needed.  For more information on what to return for List operations, refer to [Pagination](#pagination).

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="golang-response-no-headers" %} return headers and other per-request metadata unless it’s obvious as to which specific HTTP request the method’s return value corresponds to.

{% include requirement/MUST id="golang-response-failure-info" %} provide enough information in failure cases for an application to take appropriate corrective action.

Model structures are types that consumers use to provide required information into client library methods.  They can also be returned from client methods. These structures typically represent the domain model, or option structures that must be configured before the request can be made.

{% include requirement/MUST id="golang-model-types" %} export all fields on model types to allow for mocking.

{% include requirement/MUST id="golang-model-types-ro" %} document all read-only fields and exclude their values when marshalling the structure to be sent over the wire.

##### Cancellation

Cancellation is handled via the `context.Context` paramater, which is _always_ the first method parameter.  All APIs that perform I/O of any kind, sleep, or perform a significant amount of CPU-bound work _must_ take a `context.Context` as its first parameter.  The following are some examples of how to wait on a context.

```go
// delay sleeps for the specified duration or until the context is cancelled
func delay(ctx context.Context, delay time.Duration) error {
	select {
	case <-time.After(delay):
		// delay interval has elapsed
		return nil
	case <-ctx.Done():
		// the context was cancelled
		return ctx.Err()
	}
}

// expensiveComputation performs some CPU-intensive work until finished or the context is cancelled
func expensiveComputation(ctx context.Context) error {
	for {
		select {
		case <-ctx.Done():
			// the context was cancelled
			return ctx.Err()
		default:
			// perform iteration of expensive computation
			if done {
				return nil
			}
		}
	}
}
```

##### Thread Safety

{% include requirement/MUST id="golang-methods-thread-safety" %} be safe for concurrent use across multiple goroutines.

#### Service Method Parameters

{% include requirement/MUST id="golang-api-service-client-byref" %} ensure that all methods on client types pass their receiver by reference.

{% include requirement/MUST id="golang-api-context" %} accept a `context.Context` object as the first parameter to every method that performs any I/O operations.

{% include requirement/MUST id="golang-api-mandatory-params" %} have every I/O method accept all required parameters after the mandatory `context.Context` object.

##### Optional Parameters

{% include requirement/MUST id="golang-api-options-struct" %} define a `<MethodNameOptions>` structure for every method.  This structure includes fields for all non-mandatory parameters. The structure can have fields added to it over time to simplify versioning.  To disambiguate names, use the client type name for a prefix.  If the method contains no optional parameters, the `options` struct should have a comment indicating it's a placeholder for future optional parameters.

```go
// GetWidgetOptions contains the optional parameters for the Widget.Get method.
type GetWidgetOptions struct {
	Tag *string
	Length *int
}

// SetWidgetOptions contains the optional parameters for the Widget.Set method.
type SetWidgetOptions struct {
	// placeholder for future optional parameters
}
```

{% include requirement/MUST id="golang-api-options-ptr" %} allow the user to pass a pointer to the structure as the last parameter. If the user passes `nil`, then the method should assume appropriate default values for all the structure’s fields.  Note that `nil` and a zero-initialized `<MethodNameOptions>` structure are **NOT** required to be semantically equivalent.

{% include requirement/MUST id="golang-api-params" %} document all parameters as part of the method block comment.

```go
// GetWidget retrieves the specified Widget.
// ctx - The context used to control the lifetime of the request.
// name - The name of the Widget to retrieve.
// options - Any optional parameters.
func (c *WidgetClient) GetWidget(ctx context.Context, name string, options *GetWidgetOptions) (WidgetResponse, error) {
	// ...
}
```

##### Parameter Validation

The service client will have several methods that perform requests on the service. _Service parameters_ are directly passed across the wire to an Azure service. _Client parameters_ are not passed directly to the service, but used within the client library to fulfill the request.  Examples of client parameters include values that are used to construct a URI, or a file that needs to be uploaded to storage.

{% include requirement/MUST id="golang-params-client-validation" %} validate client parameters.

{% include requirement/MUSTNOT id="golang-params-service-validation" %} validate service parameters. This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUST id="golang-params-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service. If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

#### Methods Returning Collections (Paging)

{% include requirement/MUST id="golang-pagination" %} return a value that implements the Pager interface for operations that return pages.  The Pager interface allows consumers to iterate over all pages as defined by the service.

{% include requirement/MUST id="golang-pagination-pagers" %} create Pager interface types with the name `<Resource>Pager` that are to be returned from their respective operations.

{% include requirement/MUST id="golang-pagination-pagers-interface-page" %} expose methods `NextPage()`, `PageResponse()`, and `Err()` on the `<Resource>Pager` type.

```go
// WidgetPager provides iteration over ListWidgets pages.
type WidgetPager interface {
	// NextPage returns true if the pager advanced to the next page.
	// Returns false if there are no more pages or an error occurred.
	NextPage(context.Context) bool

	// PageResponse returns the current WidgetsPage.
	PageResponse() ListWidgetsResponse

	// Err returns the last error encountered while paging.
	Err() error
}

type ListWidgetsResponse struct {
	RawResponse *http.Response
	Widgets *[]Widget
}
```

{% include requirement/MUST id="golang-pagination-methods" %} use the prefix `List` in the method name for methods that return a Pager.  The `List` method creates the Pager but does NOT perform an IO operation.

```go
func (c *WidgetClient) ListWidgets(options *ListWidgetOptions) WidgetPager {
	// ...
}

pager := client.ListWidgets(options)
for pager.NextPage(ctx) {
	for _, w := range pager.PageResponse().Widgets {
		process(w)
	}
}
if pager.Err() != nil {
	// handle error...
}
```

{% include requirement/MUST id="golang-pagination-serialization" %} provide means to serialize and deserialize a Pager so that paging can pause and continue, potentially on another machine.

#### Methods Invoking Long Running Operations

{% include requirement/MUST id="golang-lro-poller" %} return a value that implements the Poller interface for long-running operation methods.  The Poller interface encapsulates the polling and status of the long-running operation.

{% include requirement/MUST id="golang-lro-poller-name" %} create Poller interface types with the name `<Resource>Poller` that are to be returned from their respective operations.

{% include requirement/MUST id="golang-lro-poller-def" %} provide the following methods on a `<Resource>Poller` type: `Done()`, `ResumeToken()`, `Poll()`, and `FinalResponse()`.

```go
// Poller provides operations for checking the state of a long-running operation.
// An LRO can be in either a non-terminal or terminal state.  A non-terminal state
// indicates the LRO is still in progress.  A terminal state indicates the LRO has
// completed successfully, failed, or was cancelled.
type WidgetPoller interface {
	// Done returns true if the LRO has reached a terminal state.
	Done() bool

	// ResumeToken returns a value representing the poller that can be used to resume
	// the LRO at a later time. ResumeTokens are unique per service operation.
	ResumeToken() string

	// Poll fetches the latest state of the LRO.  It returns an HTTP response or error.
	// If the LRO has completed successfully, the poller's state is update and the HTTP
	// response is returned.
	// If the LRO has completed with failure or was cancelled, the poller's state is
	// updated and the error is returned.
	// If the LRO has not reached a terminal state, the poller's state is updated and
	// the latest HTTP response is returned.
	// If Poll fails, the poller's state is unmodified and the error is returned.
	// Calling Poll on an LRO that has reached a terminal state will return the final
	// HTTP response or error.
	Poll(context.Context) (*http.Response, error)

	// FinalResponse performs a final GET to the service and returns the final response
	// for the polling operation. If there is an error performing the final GET then an error is returned.
	// If the final GET succeeded then the final WidgetResponse will be returned.
	FinalResponse(context.Context) (WidgetResponse, error)
}
```

{% include requirement/MUST id="golang-lro-wait-method" %} accept a `pollingInterval` argument in the `PollUntilDone()` method to be used in the absence of relevant retry-after headers from the service.

{% include requirement/MUST id="golang-lro-method-naming" %} prefix methods which return a `<Resource>Poller` with `Begin`.

```go
// WidgetPollerResponse is the response envelope for operations that asynchronously return a Widget type.
type WidgetPollerResponse struct {
	// PollUntilDone will poll the service endpoint until a terminal state is reached or an error is received.
	PollUntilDone func(context.Context, time.Duration) (WidgetResponse, error)

	// Poller contains an initialized WidgetPoller.
	Poller WidgetPoller

	// RawResponse contains the underlying HTTP response.
	RawResponse *http.Response
}

// BeginCreate creates a new widget with the specified name.
func (c *WidgetClient) BeginCreate(ctx context.Context, name string, options *BeginCreateOptions) (WidgetPollerResponse, error) {
	// ...
}
```

{% include requirement/MUST id="golang-lro-resuming-operations" %} provide a method with the prefix `Resume` to instantiate a `<Resource>Poller` type with the `ResumeToken` from a previous call to `Poller.ResumeToken()`.

```go
// ResumeWidgetPoller creates a new WidgetPoller from the specified ResumtToken.
// resumeToken - The value must come from a previous call to WidgetPoller.ResumeToken().
func (c WidgetClient) ResumeWidgetPoller(resumeToken string) WidgetPoller {
	// ...
}
```

{% include requirement/MUSTNOT id="golang-lro-cancel" %} cancel the LRO when cancellation is requested via a context. The context is cancelling the polling operation and should not have any effect on the service.

{% include requirement/MUST id="golang-lro-pattern" %} follow the operation pattern for all LROs.

```go
// example #1, blocking call to PollUntilDone()
resp, err := client.BeginCreate(context.Background(), "blue_widget", nil)
if err != nil {
	// handle error...
}
w, err = resp.PollUntilDone(context.Background(), 5*time.Second)
if err != nil {
	// handle error...
}
process(w)

// example #2, customized poll loop
resp, err := client.BeginCreate(context.Background(), "green_widget")
if err != nil {
	// handle error...
}
poller := resp.Poller
for {
	resp, err := poller.Poll(context.Background())
	if err != nil {
		// handle error ...
	}
	if poller.Done() {
		break
	}
	if delay := azcore.RetryAfter(resp); delay > 0 {
		time.Sleep(delay)
	} else {
		time.Sleep(frequency)
	}
}
w, err := poller.FinalResponse(ctx)
if err != nil {
	// handle error ...
}
process(w)

// example #3, resuming from a previous operation
// getting the resume token from a previous poller instance
poller := resp.Poller
tk, err := poller.ResumeToken()
if err != nil {
	// handle error ...
}
// resuming from the resume token that was previously saved
poller, err := client.ResumeWidgetPoller(tk)
if err != nil {
	// handle error ...
}
for {
	resp, err := poller.Poll(context.Background())
	if err != nil {
		// handle error ...
	}
	if poller.Done() {
		break
	}
	if delay := azcore.RetryAfter(resp); delay > 0 {
		time.Sleep(delay)
	} else {
		time.Sleep(frequency)
	}
}
w, err := poller.FinalResponse(ctx)
if err != nil {
	// handle error ...
}
process(w)
```

##### Conditional Request Methods

TODO

### Supporting Types

In addition to service client types, Azure SDK APIs provide and use other supporting types as well.

#### Model Types

TODO

##### Model Type Naming

TODO

#### Azure Core Types

TODO

#### Primitive Types

TODO

#### Constants as Enumerations

{% include requirement/MUST id="golang-enum-type" %} define the enumeration's type to match the type sent/received over-the-wire (string is the most common example).

{% include requirement/MUST id="golang-enum-value-naming" %} name all values with a prefix of the type's name.

{% include requirement/MUST id="golang-enum-value-grouping" %} place all values for an enumerated type within their own `const` block, which is to immediately follow the type's declaration.

{% include requirement/MUST id="golang-enum-type-values" %} define a function named `<EnumTypeName>Values()` that returns a slice containing all possible values for the enumeration.

{% include requirement/MUST id="golang-enum-type-values" %} define a method named `ToPtr()` on the enumerated type that returns a pointer to the enum value.

```go
// WidgetColor specifies a Widget's color from the list of possible values.
type WidgetColor string

const (
	WidgetColorBlue  WidgetColor = "blue"
	WidgetColorGreen WidgetColor = "green"
	WidgetColorRed   WidgetColor = "red"
)

// WidgetColorValues returns a slice of possible values for WidgetColor.
func WidgetColorValues() []WidgetColor {
	// ...
}

func (c WidgetColor) ToPtr() *WidgetColor {
	return &c
}

```

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

### Package Naming

TODO (namespaces in other languages)

### Support for Mocking

One of the key things we want to support is to allow consumers of the package to easily write repeatable unit-tests for their applications without activating a service. This allows them to reliably and quickly test their code without worrying about the vagaries of the underlying service implementation (including, for example, network conditions or service outages). Mocking is also helpful to simulate failures, edge cases, and hard to reproduce situations (for example: does code work on February 29th).

{% include requirement/MUST id="golang-mock-friendly" %} generate types and methods that can be mocked to simulate a response from an Azure endpoint.

{% include requirement/MUST id="golang-mock-procedure" %} document the tools and procedures recommended to generate client interfaces for mocking.

{% include requirement/MUST id="golang-mock-lro-pages" %} generate interface types for LRO and pageable response types that contain all of the methods for their respective types.  The interface type name will be the same as the LRO/pageable response type name.

{% include requirement/MUST id="golang-test-recordings" %} support HTTP request and response recording/playback via the pipeline.

### Hierarchical Clients

TODO

{% include refs.md %}
{% include_relative refs.md %}
