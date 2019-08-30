---
title: "TypeScript Guidelines: API Design"
keywords: guidelines typescript
permalink: typescript_design.html
folder: typescript
sidebar: js_sidebar
---

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.

## Platform Support {#ts-platform-support}

{% include requirement/MUST id="ts-node-support" %} support [all LTS versions of Node](https://github.com/nodejs/Release#release-schedule) and newer versions up to and including the latest release. At time of writing, this means Node 8.x through Node 12.x.

{% include requirement/MUST id="ts-browser-support" %} support the following browsers and versions:

* Apple Safari: latest two versions
* Google Chrome: latest two versions
* Microsoft Edge: all supported versions
* Mozilla FireFox: latest two versions

Use [caniuse.com](https://caniuse.com) to determine whether you can use a given platform feature in the runtime versions you support. Syntax support is provided by TypeScript.

{% include requirement/SHOULDNOT id="ts-no-ie11-support" %} support IE11. If you have a business justification for IE11 support, contact the [Architecture Board].

{% include requirement/MUST id="ts-support-ts" %} compile without errors on all versions of TypeScript greater than 3.1.

While consumers are fast at adopting new versions of TypeScript, version 3.1 is used by Angular 7, which is still commonly used.  Supporting older versions of TypeScript can be a challenge. There are two general approaches:

1. Don't use new features.
2. Use [`typesVersions`](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-3-1.html#version-selection-with-typesversions), which might require manual effort to produce typings compatible with older versions based on the new typings.

{% include requirement/MUST id="ts-register-dropped-platforms" %} get approval from the [Architecture Board] to drop support for any platform (except IE11 and Node 6) even if support isn't required.

## Namespaces and NPM scopes {#ts-namespace}

{% include requirement/MUST id="ts-azure-scope" %} publish your library to the `@azure` npm scope.

{% include requirement/MUST id="ts-namespace-serviceclient" %} pick a package name that allows the consumer to tie the namespace to the service being used.  As a default, use the compressed service name at the end of the namespace.  The namespace does **NOT** change when the branding of the product changes. Avoid the use of marketing names that may change.

{% include requirement/MUST id="ts-namespace-in-browsers" %} use one of the appropriate namespaces (see below) for browser globals when producing UMD builds.

In cases where namespaces are supported, the namespace should be named `Azure.<group>.<service>`. All consumer-facing APIs that are commonly used should exist within this namespace.  Here:

- `<group>` is the group for the service (see the list above)
- `<service>` is the service name represented as a single word

{% include requirement/MUST id="ts-namespace-startswith" %} start the namespace with `Azure`.

{% include requirement/MUST id="ts-namespace-camelcase" %} use camel-casing for elements of the namespace.

A compressed service name is the service name without spaces.  It may further be shortened if the shortened version is well known in the community.  For example, "Azure Media Analytics" would have a compressed service name of "MediaAnalytics", and "Azure Service Bus" would become "ServiceBus".

{% include requirement/MUST id="ts-namespace-names" %} use the following list as the group of services (if the target language supports namespaces):

{% include tables/data_namespaces.md %}

{% include requirement/MUST id="ts-namespace-split-management-api" %} place the management (Azure Resource Manager) API in the "management" group.  Use the grouping `Azure.Management.<group>.<servicename>` for the namespace.  Since more services require control plane APIs than data plane APIs, other namespaces may be used explicitly for control plane only.  Data plane usage is by exception only.  Additional namespaces that can be used for control plane libraries include:

{% include tables/mgmt_namespaces.md %}

Many `management` APIs don't have a data plane.  It's reasonable to place the management library in the `Azure.Management` namespace.  For example, use `Azure.Management.CostAnalysis`, not `Azure.Management.Management.CostAnalysis`.

{% include requirement/MUSTNOT id="ts-namespace-avoid-ambiguity" %} choose similar names for clients that do different things.

{% include requirement/MUST id="ts-namespace-register" %} register the chosen namespace with the [Architecture Board].  Open an issue to request the namespace.  See [the registered namespace list](registered_namespaces.html) for a list of the currently registered namespaces.

These namespace examples meet the guidelines:

- `Azure.Data.Cosmos`
- `Azure.Identity.ActiveDirectory`
- `Azure.IoT.DeviceProvisioning`
- `Azure.Storage.Blob`
- `Azure.Messaging.NotificationHubs` (the client library for Notification Hubs)
- `Azure.Management.Messaging.NotificationHubs` (the management client for Notification Hubs)

These examples that don't meet the guidelines:

- `Microsoft.Azure.CosmosDB` (not in the Azure namespace, no grouping)
- `Azure.MixedReality.Kinect` (invalid group)
- `Azure.IoT.IoTHub.DeviceProvisioning` (too many levels)

Contact the [Architecture Board] for advice if the appropriate group isn't obvious.  If you feel your service requires a new group, open a "Design Guidelines Change" request.

## The Client API {#ts-apisurface-serviceclient}

Your API surface will consist of one or more _service clients_ that the consumer will instantiate to connect to your service, plus a set of supporting types. The basic shape of JavaScript service clients is shown in the following example:

```javascript
export class ServiceClient {
  // client constructors have overloads for handling different
  // authentication schemes.
  constructor(connectionString: string, options?: ServiceClientOptions);
  constructor(host: string, credential: TokenCredential, options?: ServiceClientOptions);
  constructor(...) { }

  // Service methods. Options take at least an abortSignal.
  async createItem(options?: CreateItemOptions): CreateItemResponse;
  async deleteItem(options?: DeleteItemOptions): DeleteItemResponse; 

  // Simple paginated API
  listItems(): PagedAsyncIterableIterator<Item, ItemPage> { }

  // Clients for sub-resources
  getItemClient(itemName: string) { }
}
```

### Client constructors and factories

{% include requirement/MUST id="ts-apisurface-serviceclientnamespace" %} place service client types that the consumer is most likely to interact as a top-level export from your library.  That is, the service client type should be something that can be imported directly by the consumer.

{% include requirement/MUST id="ts-apisurface-serviceclientconstructor" %} allow the consumer to construct a service client with the minimal information needed to connect and authenticate to the service.

{% include requirement/MUST id="ts-apisurface-standardized-verbs" %} standardize verb prefixes within a set of client libraries for a service (see [approved verbs](#ts-approved-verbs)).

The service speaks about specific operations in a cross-language manner within outbound materials (such as documentation, blogs, and public speaking).  The service can't be consistent across languages if the same operation is referred to by different verbs in different languages.

{% include requirement/MUST id="ts-apisurface-supportallfeatures" %} support 100% of the features provided by the Azure service the client library represents.

Gaps in functionality cause confusion and frustration among developers. A feature may be omitted if there isn't support on the platform. For example, a library that depends on local file system access may not work in a browser.

{% include requirement/SHOULD id="ts-use-constructor-overloads" %} provide overloaded constructors for all client construction scenarios.

Don't use static methods to construct a client unless an overload would be ambiguous.  Prefix the static method with `from` if you require a static constructor.

{% include requirement/SHOULD id="ts-use-overloads-over-unions" %} prefer overloads over unions when either:

1. Users want to see documentation (for example, signature help) tailored specifically to the parameters they're passing in, or
2. Multiple parameters are correlated.

Unions may be used if neither of these conditions are met. Let's say we have an API that takes either two numbers or two strings but not both. In this case, the parameters are correlated. If we implemented the types using unions like the following code:

```javascript
function foo(a: string | number, b: string | number): void {}
```

We have mistakenly allowed invalid arguments; that is `foo(number, string)` and `foo(string, number)`. Overloads naturally express this correlation:

```javascript
function foo(a: string, b: string): void;
function foo(a: number, b: number): void;
function foo(a: string | number, b: string | number): void {}
```

The overload approach also lets us attach documentation to each overload individually.

```javascript
// bad example
class ExampleClient {
  constructor (connectionString: string, options: ExampleClientOptions);
  constructor (url: string, options: ExampleClientOptions);
  constructor (urlOrCS: string, options: ExampleClientOptions) {
    // have to dig into the first parameter to see whether its
    // a url or a connection string. Not ideal.
  }
}

// better example
class ExampleClient {
  constructor (url: string, options: ExampleClientOptions) {

  }

  static fromConnectionString(connectionString: string, options: ExampleClientOptions) {

  }
}
```

### Options {#ts-options}

The guidelines in this section apply to options passed in options bags to clients, whether methods or constructors. When referring to option names, this means the key of the object users must use to specify that option when passing it into a method or constructor.

{% include requirement/MUST id="ts-options-abortSignal" %} name abort signal options `abortSignal`

{% include requirement/MUST id="ts-options-suffix-durations" %} suffix durations with `In<Unit>`. Unit should be `ms` for milliseconds, and otherwise the name of the unit. Examples include `timeoutInMs` and `delayInSeconds`.

### Response formats {#ts-responses}

Requests to the service fall into two basic groups - methods that make a single logical request, or a deterministic sequence of requests.  An example of a *single logical request* is a request that may be retried inside the operation.  An example of a *deterministic sequence of requests* is a paged operation. The *logical entity* is a protocol neutral representation of a response. For HTTP, the logical entity may combine data from headers, the body, and the status line.  For example, you may add the `ETag` header as a property on the logical entity to the deserialized content from the body of the response.

{% include requirement/MUST id="ts-return-logical-entities" %} optimize for returning the logical entity for a given request. The logical entity MUST represent the information needed in the 99%+ case.

{% include requirement/MUST id="ts-return-expose-raw" %} *make it possible* for a developer to get access to the complete response, including the status line, headers, and body.

{% include requirement/MUST id="ts-return-document-raw-stream" %} document how to access the raw and streamed response for a request (if exposed by the client library).  Include comprehensive samples.  We don't expect all methods to expose a streamed response.

For methods that combine multiple requests into a single call:

{% include requirement/MUSTNOT id="general-return-no-headers-if-confusing" %} return headers and other per-request metadata unless it's obvious as to which specific HTTP request the methods return value corresponds to.

{% include requirement/MUST id="general-expose-data-for-composite-failures" %} provide enough information in failure cases for an application to take appropriate corrective action.

{% include requirement/SHOULDNOT id="general-dont-use-value" %} use the following property names within a logical entity:

- `object`
- `value`

Using names that are commonly used as reserved words can cause confusion and will cause consistency issues between languages.

<a name="ts-example-return-types"></a>
An example:

```javascript
// Service operation method on a service client
  public async getProperties(
    options: ContainerGetPropertiesOptions = {}
  ): Promise<Models.ContainerGetPropertiesResponse> {
    // ...
  }

// Response type, in this case for a service which returns the
// relevant info in headers. Note how the headers are represented
// in first-class properties with intellisense etc.
export type ContainerGetPropertiesResponse = ContainerGetPropertiesHeaders & {
  /**
   * The underlying HTTP response.
   */
  _response: msRest.HttpResponse & {
      /**
       * The parsed HTTP response headers.
       */
      parsedHeaders: ContainerGetPropertiesHeaders;
    };
};

export interface ContainerGetPropertiesHeaders {
  // ...
  /**
   * @member {PublicAccessType} [blobPublicAccess] Indicated whether data in
   * the container may be accessed publicly and the level of access. Possible
   * values include: 'container', 'blob'
   */
  blobPublicAccess?: PublicAccessType;
  /**
   * @member {boolean} [hasImmutabilityPolicy] Indicates whether the container
   * has an immutability policy set on it.
   */
  hasImmutabilityPolicy?: boolean;
}
```

### Client naming conventions {#ts-client-naming-conventions}

{% include requirement/MUST id="ts-apisurface-serviceclientnaming" %} name service client types with the _Client_ suffix.

{% include requirement/SHOULD id="ts-approved-verbs" %} use one of the approved verbs in the below table when referring to service operations.

|Verb|Parameters|Returns|Comments|
|-|-|-|-|
|`create\<Noun>`|key, item|Created item|Create new item. Fails if item already exists.|
|`upsert\<Noun>`|key, item|Updated or created item|Create new item, or update existing item. Verb is primarily used in database-like services |
|`set\<Noun>`|key, item|Updated or created item|Create new item, or update existing item. Verb is primarily used for dictionary-like properties of a service |
|`update\<Noun>`|key, partial item|Updated item|Fails if item doesn't exist. |
|`replace\<Noun>`|key, item|Replace existing item|Completely replaces an existing item. Fails if the item doesn't exist. |
|`append\<Noun>`|item|Appended item|Add item to a collection. Item will be added last. |
|`add\<Noun>`|index, item|Added item|Add item to a collection. Item will be added at the given index. |
|`get\<Noun>`|key|Item|Will return null if item doesn't exist |
|`list\<Noun>s`||`PagedAsyncIterableIterator<TItem, TPage>`|Return list of items. Returns empty list if no items exist |
|`\<noun>Exists`|key|`bool`|Return true if the item exists. |
|`delete\<Noun>`|key|None|Delete an existing item. Will succeed even if item didn't exist.|
|`remove\<Noun>`|key|None or removed item|Remove item from a collection.|

{% include requirement/MUSTNOT id="ts-naming-drop-noun" %} include the `Noun` when the operation is operating on the resource itself,  For example, if you have an `ItemClient` with a delete method, it should be called `delete` rather than `deleteItem`. The noun is implicitly `this`.

{% include requirement/MUST id="ts-naming-subclients" %} prefix methods that create or vend subclients with `get` and suffix with `client`.  For example, `container.getBlobClient()`.

{% include requirement/MUST id="ts-naming-options" %} suffix options bag parameters names with `Options`, and prefix with the name of the operation. For example, if an operation is called createItem, its options type must be called `CreateItemOptions`.

<a name="ts-example-naming"></a>
The following are good examples of names for operations in a TypeScript client library:

```javascript
containerClient.listBlobs();
containerClient.delete();
```

The following are bad examples:

```javascript
containerClient.deleteContainer(); // don't include noun for direct manipulation
containerClient.newBlob(); // use create instead of new
containerClient.createOrUpdate(); // use upsert
containerClient.createBlobClient(); // should be `getBlobClient`.
```

### Network requests {#ts-network-requests}

When an application makes a network request, the network infrastructure (like routers) and the called service may take a long time to respond. In fact, the network infrastructure may never respond. A well-written application should **NEVER** give up its control to the network infrastructure or service.

Consider the following examples. An orchestrator needs to stop a service because of a scaling operation, reconfiguration, or upgrading to a new version). The orchestrator typically notifies a running service instance by sending an interrupt signal. The service should stop as quickly as possible when it receives this signal. Similarly, when a web server receives a request, it may set a time limit indicating how much time it's allowing before giving a response to the user. A UI application may offer the user a cancel button when making a network request.

The best way for consumers to work with cancellation is to think of cancellation objects as forming a tree. For example:

- Cancelling a parent automatically cancels its children.
- Children can time out sooner than their parent but can't extend the total time.
- Cancellation can happen because of a timeout or an explicit request.

{% include requirement/MUST %} accept an `AbortSignalLike` parameter on all asynchronous calls. This type is provided by `@azure/abort-controller`.

{% include requirement/SHOULD %} only check cancellation tokens on I/O calls (such as network requests and file loads).  Don't check the cancellation token between I/O calls within the client library (for example, when processing data between I/O calls).

{% include requirement/MUSTNOT %} leak the underlying protocol transport implementation details to the consumer.  All types from the protocol transport implementation must be appropriately abstracted.

### Authentication

Azure services use different kinds of authentication schemes to allow clients to access the service.  Conceptually, there are two entities responsible in this process: a credential and an authentication policy.  Credentials provide confidential authentication data.  Authentication policies use the data provided by a credential to authenticate requests to the service.  

{% include requirement/MUST id="ts-apisurface-supportcancellation" %} support all authentication techniques that the service supports.

{% include requirement/MUST id="ts-apisurface-check-cancel-on-io-calls" %} use credential and authentication policy implementations from the Azure Core library where available.

{% include requirement/MUST id="general-apisurface-no-leaking-implementation" %} provide credential types that can be used to fetch all data needed to authenticate a request to the service. Credential types should be non-blocking and atomic.  Use credential types from the `@azure/core-auth` library where possible.

{% include requirement/MUST id="general-apisurface-auth-in-constructors" %} provide service client constructors or factories that accept any supported authentication credentials.

Client libraries may support connection strings __ONLY IF__ the service provides a connection string to users via the portal or other tooling. Connection strings are easily integrated into an application by copy/paste from the portal.  However, connection strings don't allow the credentials to be rotated within a running process.

{% include requirement/MUSTNOT id="general-apisurface-no-connection-strings" %} support constructing a service client with a connection string unless such connection string is available within tooling (for copy/paste operations).

### Modern & Idiomatic JavaScript {#ts-modern-javascript}

{% include requirement/MUST id="ts-use-promises" %} use built-in promises for asynchronous operations. You may provide overloads that take a callback. Don't import a polyfill or library to implement promises.

Promises were added to JavaScript ES2015. ES2016 and later added `async` functions to make working with promises easier. Promises are broadly supported in JavaScript runtimes, including all currently supported versions of Node.

{% include requirement/SHOULD id="ts-use-async-functions" %} use `async` functions for implementing asynchronous library APIs.

If you need to support ES5 and are concerned with library size, use `async` when combining asynchronous code with control flow constructs.  Use promises for simpler code flows.  `async` adds code bloat (especially when targeting ES5) when transpiled. 

{% include requirement/MUST id="ts-use-iterators" %} use [Iterators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Iterators_and_Generators) and [Async Iterators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for-await...of) for sequences and streams of all sorts.

Both iterators and async iterators are built into JavaScript and easy to consume. Other streaming interfaces (such as node streams) may be used where appropriate as long as they're idiomatic.

{% include requirement/SHOULD id="ts-use-interface-parameters" %} prefer interface types to class types. JavaScript is fundamentally a duck-typed language, and so alternative classes that implement the same interface should be allowed. Declare parameters as interface types over class types whenever possible. Overloads with specific class types are fine but there should be an overload present with the generic interface.

<a name="ts-example-iterators"></a>

```javascript
// bad synchronous example
function listItems() {
  return {
    nextItem() { /*...*/ }
  }
}

// better synchronous example
function* listItems() {
  /* ... */
}

// bad asynchronous examples
function listItems() {
  return Rx.Observable.of(/* ... */)
}

function listItems(callback) {
  // fetch items
  for (const item of items) {
    callback (item)
    }
}

// better asynchronous example
async function* listItems() {
  for (const item of items) {
    yield item;
  }
}
```
~

### Modern & Idiomatic TypeScript {#ts-modern-typescript}

{% include requirement/MUST id="ts-use-typescript" %} implement your library in TypeScript.

{% include requirement/MUST id="ts-ship-type-declarations" %} include type declarations for your library.

TypeScript static types provide significant benefit for both the library authors and consumers. TypeScript also compiles modern JavaScript language features for use with older runtimes.

#### tsconfig.json {#ts-tsconfig.json}

Your `tsconfig.json` should look similar to the following example:
<a name="ts-figure-tsconfig-json"></a>

```javascript
{
  "compilerOptions": {
    "declaration": true,
    "module": "es6",
    "moduleResolution": "node",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "outDir": "./dist-esm",
    "target": "es6",
    "sourceMap": true,
    "declarationMap": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "forceConsistentCasingInFileNames": true,
    "importHelpers": true
  },
  "include": ["./src/**/*"],
  "exclude": ["node_modules"]
}
```

{% include requirement/MUST id="ts-config-exclude" %} have at least "node_modules" in the `exclude` array. TypeScript shouldn't needlessly type check your dependencies.

{% include requirement/MUSTNOT id="ts-config-lib" %} use the `compilerOptions.lib` field. Built in typescript libraries (for example, `esnext.asynciterable`) should be included via reference directives. See also [Microsoft/TypeScript#27416](https://github.com/Microsoft/TypeScript/issues/27416).

{% include requirement/MUST id="ts-config-strict" %} set `compilerOptions.strict` to true. The `strict` flag is a best practice for developers as it provides the best TypeScript experience. The `strict` flag also ensures that your type definitions are maximally pedantic.

{% include requirement/MUST id="ts-config-esModuleInterop" %} set `compilerOptions.esModuleInterop` to true.

{% include requirement/MUST id="ts-config-allowSyntheticDefaultImports" %} set `compilerOptions.allowSyntheticDefaultImports` to true.

{% include requirement/MUST id="ts-config-target" %} set `compilerOptions.target`, but it can be any valid value so long as the final source distributions are compatible with the runtimes your library targets. See also [#ts-source-distros].

{% include requirement/MUST id="ts-config-forceConsistentCasingInFileNames" %} set `compilerOptions.forceConsistentCasingInFileNames` to true. `forceConsistentCasingInFileNames` forces TypeScript to treat files as case sensitive, and ensures you don't get surprised by build failures when moving between platforms.


{% include requirement/MUST id="ts-config-module" %} set `compilerOptions.module` to `es6`. Use a bundler such as [Rollup](https://rollupjs.org/guide/en/) or [Webpack](https://webpack.js.org/) to produce the CommonJS and UMD builds.

{% include requirement/MUST id="ts-config-moduleResolution" %} set `compilerOptions.moduleResolution` to "node" if your library targets Node. Otherwise, it should be absent.

{% include requirement/MUST id="ts-config-declaration" %} set `compilerOptions.declaration` to true. The `--declaration` option tells TypeScript to emit a `d.ts` file that contains the public surface area of your library. TypeScript and editors use this file to provide intellisense and type checking capabilities. Ensure you reference this type declaration file from the `types` field of your package.json.

{% include requirement/MUSTNOT id="ts-config-no-experimentalDecorators" %} set `compilerOptions.experimentalDecorators` to `true`. The experimentalDecorators flag adds support for "v1 decorators" to TypeScript. Unfortunately the standards process has moved on to an incompatible second version that is not yet implemented by TypeScript. Taking a dependency on decorators now means signing up your users for breaking changes later. 

{% include requirement/MUST id="ts-config-sourceMap" %} set `compilerOptions.sourceMap` and `compilerOptions.declarationMap` to true. Shipping source maps in your package ensures clients can easily debug into your library code. `sourceMap` maps your emitted JS source to the declaration file and `declarationMap` maps the declaration file back to the TypeScript source that generated it. Be sure to include your original TypeScript sources in the package.

{% include requirement/MUST id="ts-config-importHelpers" %} set `compilerOptions.importHelpers` to true. Using external helpers keeps your package size down. Without this flag, TypeScript will add a helper block to each file that needs it. The file size savings using this option can be huge when using `async` functions (as an example) in a number of different files.

#### TypeScript Coding Guidelines {#ts-coding-guidelines}

{% include requirement/SHOULDNOT id="ts-no-namespaces" %} use TypeScript namespaces. Namespaces either use the `namespace` keyword explicitly, or the `module` keyword with a module name (for example, `module Microsoft.ApplicationInsights { ... }`). Use top-level imports/exports with ECMAScript modules instead. Namespaces make your code less compatible with standard ECMAScript and create significant friction with the TypeScript community.

{% include requirement/SHOULDNOT id="ts-no-const-enums" %} use `const enum`. `Const enum` requires global understanding of your program to compile properly. As a result, `const enum` can't be used with Babel 7, which otherwise supports TypeScript. Avoiding `const enum` will make sure your code can be compiled by any tool. Use regular enums instead.

## Pagination {#ts-pagination}

Most developers will want to process a list one item at a time. Higher-level APIs (for example, async iterators) are preferred in the majority of use cases.  Finer-grained control over handling paginated result sets is sometimes required (for example, to handle over-quota or throttling).  

{% include requirement/MUST id="ts-pagination-provide-list" %} provide a `list` method that returns a `PagedAsyncIterableIterator` from the module `@azure/core-paging`.

{% include requirement/MUST id="ts-pagination-provide-bypage-settings" %} provide page-related settings to the `byPage()` iterator and not the per-item iterator.

{% include requirement/MUST id="ts-pagination-take-continuationToken" %} take a `continuationToken` option in the `byPage()` method. You must rename other parameters that perform a similar function (for example, `nextMarker`).  If your page type has a continuation token, it must be named `continuationToken`.

{% include requirement/MUST id="ts-pagination-take-maxpagesize" %} take a `maxPageSize` option in the `byPage()` method.  

An example of a paginating client:
<a name="ts-example-pagination"></a>

```javascript
// usage
const client = new ServiceClient()
for await (const item of client.listItems()) {
    console.log(item);
}

for await (const page of client.listItems().byPage({ maxPageSize: 50 })) {
    console.log(page);
}

// implementation
interface Item {
    name: string;
}

interface Page {
    continuationToken: string;
    items: Item[];
}

class ServiceClient {
    /* ... */
    listItems(): PagedAsyncIterableIterator<Item, Page> {
        async function* pages () { /* ... */ }
        async function* items () {
            for (const page of pages()) {
                for (const item of page.items) {
                    yield item;
                }
            }
        }

        const itemIter = items();
        
        return {
            next() {
                return itemIter.next();
                /* ... */
            },
            byPage() {
                return pages();
            },
            [Symbol.asyncIterator]() { return this }
        }
    }
}
```

{% include requirement/MUST id="general-pagination-paginate-lists" %} expose non-paginated list endpoints identically to paginated list endpoints. Users shouldn't need to appreciate the difference.

{% include requirement/MUST id="general-pagination-distinct-types" %} use different types for entities returned from a `list` endpoint and a `get` endpoint if the returned entities have a different shape.  If both entities are the same form, use the same type.

{% include note.html content="Services should return the same shape for entities from a <code>list</code> endpoint vs. a <code>get</code> endpoint unless there's a good reason for the difference.  Using the same type for both operations will make the API surface in the client library simpler." %}

{% include requirement/MUSTNOT id="general-pagination-no-item-iterators" %} expose an iterator over individual items if it causes additional service requests.  Some services charge on a per-request basis. One `GET` per item is often too expensive when the data isn't used.

{% include requirement/MUSTNOT id="general-pagination-support-toArray" %} expose an API to get a paginated collection into an array. Services may return many pages, which can lead to memory exhaustion in the application.

## Long Running Operations {#ts-lro}

Long-running operations are operations which consist of an initial request to start the operation followed by polling to determine when the operation has completed or failed. Long-running 
operations in Azure tend to follow the [REST API guidelines for Long-running Operations][rest-lro], but there are exceptions.

{% include requirement/MUST %} represent long-running operations with some object that encapsulates the polling and the operation status. This object, called a *poller*, must provide APIs for:

1. querying the current operation state (either asynchronously, which may consult the service, or synchronously which must not)
2. requesting an asynchronous notification when the operation has completed
3. cancelling the operation if cancellation is supported by the service
4. registering disinterest in the operation so polling stops
5. triggering a poll operation manually (automatic polling must be disabled)
6. progress reporting (if supported by the service)

{% include requirement/MUST id="ts-lro-support-options" %} support the following polling configuration options:

* `pollInterval`
  
Polling configuration may be used only in the absence of relevant retry-after headers from service, and otherwise should be ignored.

{% include requirement/MUST id="ts-lro-prefix-methods" %} prefix method names which return a poller with either `begin` or `start`. Language-specific guidelines will dictate which verb to use.

{% include requirement/MUST id="ts-lro-continuation" %} provide a way to instantiate a poller with the serialized state of another poller to begin where it left off, for example by passing the state as a parameter to the same method which started the operation, or by directly instantiating a poller with that state.

{% include requirement/MUSTNOT id="ts-lro-cancellation" %} cancel the long-running operation when cancellation is requested via a cancellation token. The cancellation token is cancelling the polling operation and should not have any effect on the service.

{% include requirement/MUST id="ts-lro-logging" %} log polling status at the `Info` level (including time to next retry)

{% include requirement/MUST id="ts-lro-progress-reporting" %} expose a progress reporting mechanism to the consumer if the service reports progress as part of the polling operation.  Language-dependent guidelines will present additional guidance on how to expose progress reporting in this case.

{% include draft.html content="Long-running operations will use the <code>@azure/core-lro</code> package, which is an abstration that provides the above requirements" %}

## Support for non-HTTP protocols {#general-other-protocols}

Most Azure services expose a RESTful API over HTTPS.  However, a few services use other protocols, such as [AMQP](https://www.amqp.org/), [MQTT](http://mqtt.org/), or [WebRTC](https://webrtc.org/). In these cases, the operation of the protocol can be split into two phases:

* Per-connection (surrounding when the connection is initiated and terminated)
* Per-operation (surrounding when an operation is sent through the open connection)

The policies that are added to a HTTP request/response (authentication, unique request ID, telemetry, distributed tracing, and logging) are still valid on both a per-connection and per-operation basis.  However, the methods by which these policies are implemented are protocol dependent.

{% include requirement/MUST id="general-other-protocols-pipeline-policies" %} implement as many of the policies as possible on a per-connection and per-operation basis.

For example, MQTT over WebSockets provides the ability to add headers during the initiation of the WebSockets connection, so this is a good place to add authentication, telemetry, and distributed tracing policies.  However, MQTT has no metadata (the equivalent of HTTP headers), so per-operation policies are not possible.  AMQP, by contract, does have per-operation metadata.  Unique request ID, and distributed tracing headers can be provided on a per-operation basis with AMQP.

{% include requirement/MUST id="general-other-protocols-consult-on-policies" %} consult the [Architecture Board] on policy decisions for non-HTTP protocols.  Implementation of all policies is expected.  If the protocol cannot support a policy, obtain an exception from the [Architecture Board].

{% include requirement/MUST id="general-other-protocols-use-global-config" %} use the global configuration established in the Azure Core library to configure policies for non-HTTP protocols.  Consumers don't necessarily know what protocol is used by the client library.  They will expect the client library to honor global configuration that they have established for the entire Azure SDK.  

{% include refs.md %}
{% include_relative refs.md %}
