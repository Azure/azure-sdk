---
title: "Go Guidelines: API Design"
keywords: guidelines golang
permalink: golang_design.html
folder: golang
sidebar: golang_sidebar
---

{% include draft.html content="The Go Language guidelines are in DRAFT status" %}

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.  

## Package naming

Go groups related types in a package.  In Go, the package should be named `az<service>`, where `<service>` is the service name represented as a single word.

{% include requirement/MUST id="golang-namespace-prefix" %} start the package with `az` to indicate an Azure client library.

{% include requirement/MUST id="golang-namespace-pkgname" %} construct the package name with all lowercase letters (uppercase letters, hyphens and underscores are not allowed). For example, the Azure Key Vault package would be named `azkeyvault` and the Azure Storage Blob package would be named `azblob`.

{% include requirement/MUST id="golang-namespace-registration" %} register the chosen package name with the [Architecture Board]. Open an issue to request the package name. See the [registered namespace list](registered_namespaces.html) for a list of the currently registered namespaces.

## Package path

{% include requirement/MUST id="golang-pkgpath-construction" %} construct a package import path that allows the consumer to tie its packages to the service being used. The package path does **NOT** change when the branding of the product changes. Avoid the use of marketing names that may change.

{% include requirement/MUST id="golang-pkgpath-leaf" %} ensure that the package leaf directory name matches the package name declared in the source code.

{% include requirement/MUST id="golang-pkgpath-mgmt" %} place the management (Azure Resource Manager) API in the `mgmt` group. Use the grouping `./sdk/<group>/mgmt/<service>` for the package path. Since more services require control plane APIs than data plane APIs, other paths may be used explicitly for control plane only. Data plane usage is by exception only. Additional paths that can be used for control plane SDKs include:

{% include tables/mgmt_namespaces.md %}

Many management APIs do not have a data plane because they deal with management of the Azure account. Place the management library in the `mgmt` path. For example, use `sdk/mgmt/costanalysis` instead of `sdk/mgmt/management/costanalysis`.

## Service clients

Your API surface consists of one or more service clients that the consumer instantiates to connect to your service, plus a set of supporting types.

{% include requirement/MUST id="golang-client-naming" %} name service client types with the `Client` suffix.

```go
type WidgetClient struct {
	// ...
}
```

{% include requirement/MUST id="golang-client-constructors" %} provide constructors in the following format that returns a new instance of a service client type.

```go
// NewWidgetClient creates a new instance of WidgetClient with the specified values.  It uses the default pipeline configuration.
func NewWidgetClient(endpoint string, cred azcore.Credential, options WidgetClientOptions) (*WidgetClient, error) {
	// ...
}

// NewWidgetClientWithPipeline creates a new instance of WidgetClient with the specified values and custom pipeline.
func NewWidgetClientWithPipeline(endpoint string, p azcore.Pipeline, options WidgetClientOptions) (*WidgetClient, error) {
	// ...
}
```

{% include requirement/MUST id="golang-api-service-client-immutable" %} ensure that all service client types are immutable upon instantiation.

{% include requirement/MUST id="golang-api-service-client-byref" %} pass all client instances by reference.  All methods on client types will pass their receiver by reference.

{% include requirement/MUSTNOT id="golang-api-service-client-fields" %} export any fields on client types.  This is to support mocking of clients via interface types and strengthens the immutability requirement.

## Service client methods

{% include requirement/MUST id="golang-client-crud-verbs" %} prefer the use of the following terms for CRUD operations:

| Verb           | Parameters | Comments |
| `Set<noun>`    | key,item   | Adds new item or updates existing item. |
| `Add<noun>`    | key,item   | Adds a new item.  Fails if item already exists. |
| `Update<noun>` | key,item   | Updates an existing item.  Fails if item doesn't exist. |
| `Delete<noun>` | key        | Deletes an existing item. |
| `Get<noun>`    | key        | Will retun an error if item doesn't exist. |
| `List<noun>`   |            | Return list of items.  Returns empty list if no items exist. |
| `<noun>Exists` | key        | Return `true` if the item exists. |

{% include requirement/SHOULD id="golang-client-verbs-flexible" %} remain flexible and use names best suited for developer experience. Don’t conflict with terminology used by the service team’s documentation, blogs, and presentations.

{% include requirement/MUST id="golang-feature-support" %} support 100% of the features provided by the Azure service the client library represents. Gaps in functionality cause confusion and frustration among developers.

{% include requirement/MUSTNOT id="golang-noimplleakage" %} allow implementation code (that is, code that doesn’t form part of the public API) to be mistaken as public API. There are two valid arrangements for implementation code:

1.	Implementation types and functions should not be exported and placed within the same package.
2.	Implementation types and functions can be placed in an [internal package](https://docs.google.com/document/d/1e8kOo3r51b2BWtTs_1uADIA5djfXhPT36s6eHVRIvaU/edit).

## Authentication

Azure services use different kinds of authentication schemes to allow clients to access the service. Conceptually, there are two entities responsible in this process: a credential and an authentication policy. Credentials provide confidential authentication data. Authentication policies use the data provided by a credential to authenticate requests to the service.

{% include requirement/MUST id="golang-auth-support" %} support all authentication techniques that the service supports.

{% include requirement/MUST id="golang-auth-use-azidentity" %} use credential and authentication policy implementations from the `azcore` or `azidentity` package where available.

{% include requirement/MUST id="golang-auth-concurrency" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service. If using a service-specific credential type, the implementation must be safe for concurrent use and atomic.

{% include requirement/MUSTNOT id="golang-auth-connection-strings" %} support constructing a service client with a connection string unless such connection string is available within tooling (for copy/paste operations). A connection string is a combination of an endpoint, credential data, and other options used to simplify service client configuration. Client libraries may support a connection string **ONLY IF** the service provides it via the portal or other tooling. Connection strings are easily integrated into an application by copy/paste from the portal. However, credentials within a connection string can’t be rotated within a running process. Their use should be discouraged in production apps.

## Response formats

Requests to the service fall into two basic groups: methods that make a single logical request, and methods that make a deterministic sequence of requests. An example of a _single logical request_ is a request that may be retried inside the operation. An example of a _deterministic sequence of requests_ is a paged operation.

The _logical entity_ is a protocol neutral representation of a response. The logical entity may combine data from headers, body, and the HTTP status. For example, you may expose an `ETag` header as a property on the logical entity. `OperationResponse` is the ‘complete response’. It contains HTTP headers, status code, and the object (a deserialized object created from the response body).

{% include requirement/MUST id="golang-response-logical-entity" %} return the logical entity for the normal form of a service method. The logical entity MUST represent the information needed in the 99%+ case.

```go
type CreateWidgetResponse struct {
	Name string
	Color WidgetColor
}

func (c *WidgetClient) CreateWidget(ctx context.Context, name string, color WidgetColor) (*CreateWidgetResponse, error) {
	// ...
}
```

{% include requirement/MUST id="golang-response-full-response" %} make it possible for a developer to access the complete response, including the HTTP status, headers, and body.

```go
func (r *CreateWidgetResponse) Response() *azcore.Response {
	// ...
}
```

{% include requirement/MUST id="golang-response-examples" %} provide examples on how to access the streamed response for a request, where exposed by the client library. We don’t expect all methods to expose a streamed response.

{% include requirement/MUST id="golang-response-logical-paging" %} provide an idiomatic way to enumerate all logical entities for a paged operation, automatically fetching new pages as needed.  For more information on what to return for List operations, refer to [Pagination](#pagination).

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="golang-response-no-headers" %} return headers and other per-request metadata unless it’s obvious as to which specific HTTP request the method’s return value corresponds to.

{% include requirement/MUST id="golang-response-failure-info" %} provide enough information in failure cases for an application to take appropriate corrective action.

## Pagination

{% include requirement/MUST id="golang-pagination" %} return a value that implements the paged protocol for operations that return collections.  The paged protocol allows consumers to iterate over all items and also provides a method that gives access to individual pages as defined by the service.  Consumers will not directly receive any paging information.

{% include requirement/MUST id="golang-pagination-iterators" %} create iterator types with the name `<Resource>Iterator` that are to be returned from their respective operations.

{% include requirement/MUST id="golang-pagination-methods" %} use the prefix `List` in the method name for methods that return an iterator.  Such methods MUST take a `context.Context` as their first parameter.

{% include requirement/MUSTNOT id="golang-pagination-fields" %} export any fields on iterator types.  This is to support mocking of iterator responses via interface types.

```go
func (c *WidgetClient) ListWidgets(ctx context.Context, options *ListWidgetOptions) *WidgetIterator {
	// ...
}
```

{% include requirement/MUST id="golang-pagination-iterator-interface-page" %} expose methods `NextPage()`, `Page()`, and `Err()` on the `<Resource>Iterator` type.

```go
type WidgetIterator struct {
	// ...
}

// NextPage returns true if the iterator advanced to the next page.
// Returns false if there are no more pages or an error occurred.
func (i *WidgetIterator) NextPage() bool {
	// ...
}

// Page returns the current ListWidgetsPage.
func (i *WidgetIterator) Page() *ListWidgetsPage {
	// ...
}

// Err returns the last error encountered while iterating.
func (i *WidgetIterator) Err() error {
	// ...
}

iter := client.ListWidgets(ctx, options)
for iter.NextPage() { 
	for _, w := range iter.Page().Widgets {
		process(w)
	}
}
if iter.Err() != nil {
	// handle error...
}
```

{% include requirement/MUST id="golang-pagination-iterator-interface-item" %} expose methods `Next()` and `Item()` on the `<Resource>Iterator` type **IFF** the page is a homogenous collection of items.

```go
// Next returns true if the iterator advanced to the next item.
// Returns false if there are no more items or an error occurred.
func (i *WidgetIterator) Next() bool {
	// ...
}

// Item returns the current Widget based on the iterator's index.
func (i *WidgetIterator) Item() *Widget {
	// ...
}

iter := client.ListWidgets(ctx, options)
for iter.Next() {  
	process(iter.Item())
}
if iter.Err() != nil {
	// handle error...
}
```

{% include requirement/MUSTNOT id="golang-pagination-too-many-gets" %} expose an iterator over a collection if retrieving each item requires a corresponding GET request to the service. One GET per item is often too expensive and thus not an action we want to take on behalf of consumers.

{% include requirement/MUST id="golang-pagination-serialization" %} provide means to serialize and deserialize an iterator so that iteration can pause and continue, potentially on another machine.

## Long running operations

{% include requirement/MUST id="golang-lro-encapsulation" %} represent long-running operations with a type that encapsulates the polling and operation status.  The type MUST have the suffix `Operation`.

{% include requirement/MUSTNOT id="golang-lro-fields" %} export any fields on operation types.  This is to support mocking of operation responses via interface types.

```go
type CreateWidgetOperation struct {
	// ...
}
```

{% include requirement/MUST id="golang-lro-operation-type" %} provide the following methods on an `Operation` type: `Done()`, `ID()`, `Response()`, `Poll()`, and `Wait()`.

```go
// Done returns true if the LRO has completed.
func (op *CreateWidgetOperation) Done() bool {
	// ...
}

// ID returns a value representing the operation that can be used to poll for the status
// of the LRO.  IDs are generated by the service and are unique for the operation.
func (op *CreateWidgetOperation) ID() string {
	// ...
}

// Response returns the last response from the service.
func (op *CreateWidgetOperation) Response() *azcore.Response {
	// ...
}

// Poll fetches the latest state of the LRO.
// If Poll fails, the CreateWidgetOperation is unmodified and the error is returned.
// If Poll succeeds and the operation has completed with failure, the CreateWidgetOperation
// is updated and the error is returned.
// If Poll succeeds and the operation has completed successfully, the CreateWidgetOperation
// is updated and the Widget is returned.
// If Poll succeeds and the operation has not completed, the CreateWidgetOperation is
// updated and both return values are nil.
func (op *CreateWidgetOperation) Poll(ctx context.Context) (*Widget, error) {
	// ...
}

// Wait blocks until the LRO is completed, returning the response or any errors encountered.
// The specified polling interval is used if the server does not return a preferred interval.
func (op *CreateWidgetOperation) Wait(ctx context.Context, pollingInterval time.Duration) (*Widget, error) {
	// ...
}
```

{% include requirement/MUST id="golang-lro-wait-method" %} accept a `pollingInterval` argument in the `Wait()` method to be used in the absence of relevant retry-after headers from the service.

{% include requirement/MUST id="golang-lro-method-naming" %} prefix methods which return a `Operation` with `Begin`.

```go
// BeginCreate creates a new widget with the specified name.
func (c *WidgetClient) BeginCreate(ctx context.Context, name string) (*CreateWidgetOperation, error) {
	// ...
}
```

{% include requirement/MUST id="golang-lro-resuming-operations" %} provide a method with the prefix `Resume` to instantiate a `Operation` type with the `ID` from a previous call to `Operation.ID()`.

```go
// ResumeCreateWidgetOperation creates a new CreateWidgetOperation from the specified ID.
// The ID must come from a previous call to CreateWidgetOperation.ID().
func (c *WidgetClient) ResumeCreateWidgetOperation(id string) *CreateWidgetOperation {
	// ...
}
```

{% include requirement/MUSTNOT id="golang-lro-cancel" %} cancel the LRO when cancellation is requested via a context. The context is cancelling the polling operation and should not have any effect on the service.

{% include requirement/MUST id="golang-lro-progress-reporting" %} expose a progress reporting mechanism to the consumer if the service reports progress as part of the polling operation.

```go
// RegisterProgressReporter registers a callback to be invoked with the progress message.
// The message and interval of the callback are determined by the service.
func (op *CreateWidgetOperation) RegisterProgressReporter(reporter func(string)) {
	// ...
}
```

{% include requirement/MUST id="golang-lro-pattern" %} follow the operation pattern for all LROs.

```go
// example #1, blocking call to Wait()
op, err := client.BeginCreateWidget(context.Background(), "blue_widget")
if err != nil {
	// handle error...
}
w, err := op.Wait(context.Background(), 5*time.Second)
if err != nil {
	// handle error...
}
process(w)

// example #2, customized wait loop
op, err := client.BeginCreateWidget(context.Background(), "green_widget")
if err != nil {
	// handle error...
}
for {
	w, err := op.Poll(context.Background())
	if err != nil {
		// handle error...
	}
	if op.Done() {
		process(w)
		break
	}
	// do some other work then sleep...
	time.Sleep(5 * time.Second)
}

// example #3, resuming from a previous operation
op := client.ResumeCreateWidgetOperation("operation ID from external process")
w, err := op.Wait(context.Background(), 2*time.Second)
if err != nil {
	// handle error...
}
process(w)
```

## The Go API

Consumers will use one or more service clients to access Azure services, plus a set of model classes and other supporting types. 

{% include requirement/MUSTNOT id="golang-api-multimethods" %} provide multiple methods for a single REST endpoint.

{% include requirement/MUST id="golang-api-context" %} accept a `context.Context` object as the first parameter to every method that performs 1 (or more) I/O operations.

{% include requirement/MUST id="golang-api-mandatory-params" %} have every I/O method accept all required parameters after the mandatory `context.Context` object.

{% include requirement/MUST id="golang-api-options-struct" %} define a `<MethodNameOptions>` structure for every method with optional parameters.  This structure includes fields for all non-mandatory parameters. The structure can have fields added to it over time to simplify versioning.  To disambiguate names, use the client type name prefix.  E.g. for the BlobClient `List()` method the options type name would be `BlobListOptions`.

{% include requirement/MUST id="golang-api-options-ptr" %} allow the user to pass a pointer to this structure as the last parameter. If the user passes `nil`, then the method should assume appropriate default values for all the structure’s fields.  Note that `nil` and a zero-initialized `<MethodNameOptions>` structure are **NOT** required to be semantically equivalent.

{% include requirement/MUSTNOT id="golang-api-mocked-params" %} define a function or method to accept a client, iterator, or operation type as a parameter as this breaks the consumer's ability to mock the value.  Instead, define an interface containing **only** the methods required by the caller and accept that interface as the parameter.

### Model structures

Model structures are types that consumers use to provide required information into client library methods.  They can also be returned from client methods. These structures typically represent the domain model, or option structures that must be configured before the request can be made.

{% include requirement/MUST id="golang-model-types" %} export all fields on model types to allow for mocking.

{% include requirement/MUST id="golang-model-types-ro" %} document all read-only fields and exclude their values when marshalling the structure to be sent over the wire.

{% include requirement/MUST id="golang-model-types-nil" %} provide a mechanism to distinguish between omitting a value and sending a nil value.

### Enumerated types

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

// WidgetColorValues returns a slice of possible values for WidgetColor.
func WidgetColorValues() []WidgetColor {
	// ...
}
```

### Versioning

Each new package defaults to the latest known service version.

Each package allows the consumer to select a previous service version from a list of enum values provided in that package.

{% include requirement/MUST id="golang-versioning-modules" %} release each package as a [Go module](https://blog.golang.org/using-go-modules).  Legacy dependency management tools such as `dep` and `glide` are not supported.

{% include requirement/MUST id="golang-versioning-semver" %} release versions of modules in accordance with [semver 2.0](https://semver.org/spec/v2.0.0.html).

{% include requirement/MUST id="golang-versioning-breaking-changes" %} release a new major version of a module when breaking changes are introduced in public surface area; this includes new service versions that are NOT backward-compatible.  Use a new major version subdirectory to support [semantic import versioning](https://github.com/golang/go/wiki/Modules#semantic-import-versioning).

{% include requirement/MUST id="golang-versioning-minor-versions" %} release a new minor version of a module when new public surface area is introduced; this includes new service versions that are backward-compatible with the previous versions.

{% include requirement/MUST id="golang-versioning-patch-versions" %} release a new patch version of a module when changes are made that do not affect public surface area.

{% include requirement/MUST id="golang-versioning-preview" %} clearly version prerelease modules.  For new modules, use a v0 major version with no suffix (v0.1.0).  For existing modules, use a `-preview` suffix (v1.1.0-preview, v2.0.0-preview).

{% include refs.md %}
{% include_relative refs.md %}
