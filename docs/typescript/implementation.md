---
title: "TypeScript Guidelines: Implementation"
keywords: guidelines typescript
permalink: typescript_implementation.html
folder: typescript
sidebar: general_sidebar
---

Once you've worked through an acceptable API design, you can start implementing the service clients.

{% include requirement/SHOULD id="ts-should-use-template" %} use the [TypeScript client library template].

TODO: Please add a discussion of how to use the Http Pipeline to implement a service method, if relevant, and on creating and adding custom policies to the pipeline.

## Configuration {#ts-configuration}

When configuring your client library, particular care must be taken to ensure that the consumer of your client library can properly configure the connectivity to your Azure service both globally (along with other client libraries the consumer is using) and specifically with your client library.

{% include requirement/MUST id="ts-configuration-use-core-lib" %} use the `@azure/core-configuration` package.  The `@azure/core-configuration` package implements the general guidelines for configuration; specifically:

* Retrieve any relevant settings from the environment.
* Retrieve any relevant global settings from the consumers code.

### Client configuration

{% include requirement/MUST id="ts-configuration-use-global-config" %} use relevant global configuration settings either by default or when explicitly requested to by the user, for example by passing in a configuration object to a client constructor.

{% include requirement/MUST id="ts-configuration-allow-different-configs" %} allow different clients of the same type to use different configurations.

{% include requirement/MUST id="ts-configuration-allow-optout" %} allow consumers of your service clients to opt out of all global configuration settings at once.

{% include requirement/MUST id="ts-configuration-allow-overrides" %} allow all global configuration settings to be overridden by client-provided options. The names of these options should align with any user-facing global configuration keys.

{% include requirement/MUSTNOT id="ts-configuration-no-config-changes-after-construction" %} change behavior based on configuration changes that occur after the client is constructed. Hierarchies of clients inherit parent client configuration unless explicitly changed or overridden. Exceptions to this requirement are as follows:

1. Log level, which must take effect immediately across the Azure SDK.
2. Tracing on/off, which must take effect immediately across the Azure SDK.

### Service-specific environment variables

{% include requirement/MUST id="ts-configuration-env-prefix" %} prefix Azure-specific environment variables with `AZURE_`.

{% include requirement/MAY id="ts-configuration-service-envs" %} use client library-specific environment variables for portal-configured settings which are provided as parameters to your client library. This generally includes credentials and connection details. For example, Service Bus could support the following environment variables:

* `AZURE_SERVICEBUS_CONNECTION_STRING`
* `AZURE_SERVICEBUS_NAMESPACE`
* `AZURE_SERVICEBUS_ISSUER`
* `AZURE_SERVICEBUS_ACCESS_KEY`

Storage could support:

* `AZURE_STORAGE_ACCOUNT`
* `AZURE_STORAGE_ACCESS_KEY`
* `AZURE_STORAGE_DNS_SUFFIX`
* `AZURE_STORAGE_CONNECTION_STRING`

{% include requirement/MUST id="ts-configuration-approval-for-envs" %} get approval from the [Architecture Board] for every new environment variable.

{% include requirement/MUST id="ts-configuration-env-syntax" %} use this syntax for environment variables specific to a particular Azure service:

* `AZURE_<ServiceName>_<ConfigurationKey>`

where _ServiceName_ is the canonical shortname without spaces, and _ConfigurationKey_ refers to an unnested configuration key for that client library.

{% include requirement/MUSTNOT id="ts-configuration-posix-envs" %} use non-alpha-numeric characters in your environment variable names with the exception of underscore. This ensures broad interoperability.

## Parameter validation {#general-parameter-validation}

The service client will have several methods that perform requests on the service.  _Service parameters_ are directly passed across the wire to an Azure service.  _Client parameters_ are not passed directly to the service, but used within the client library to fulfill the request.  Examples of client parameters include values that are used to construct a URI, or a file that needs to be uploaded to storage.

{% include requirement/MUST id="general-parameter-validation-client" %} validate client parameters.

{% include requirement/MUSTNOT id="general-parameter-validation-service" %} validate service parameters.  This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUST id="general-parameter-validation-errors" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service.  If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

## Network requests {#general-network-requests}

Each supported language has an Azure Core library that contains common mechanisms for cross cutting concerns such as configuration and doing HTTP requests.

{% include requirement/MUST id="general-implementing-httppipeline" %} use the HTTP pipeline component within `@azure/core-rest-pipeline` package for communicating to service REST endpoints.

The HTTP pipeline consists of a HTTP transport that is wrapped by multiple policies. Each policy is a control point during which the pipeline can modify either the request and/or response. We prescribe a default set of policies to standardize how client libraries interact with Azure services.  The order in the list is the most sensible order for implementation.

{% include requirement/MUST id="general-implementing-policies" %} include the following policies in the HTTP pipeline or your client SDK library:

- Telemetry
- Unique Request ID
- Retry
- Authentication
- Response downloader
- Distributed tracing
- Logging
-

{% include requirement/SHOULD id="general-implementing-use-core-policies" %} use the policy implementations in Azure Core whenever possible.  Do not try to "write your own" policy unless it is doing something unique to your service.  If you need another option to an existing policy, engage with the [Architecture Board] to add the option.

## Authentication {#general-implementing-auth}

When implementing authentication, don't open up the consumer to security holes like PII (personally identifiable information) leakage or credential leakage.  Credentials are generally issued with a time limit, and must be refreshed periodically to ensure that the service connection continues to function as expected.  Ensure your client library follows all current security recommendations and consider an independent security review of the client library to ensure you're not introducing potential security problems for the consumer.

{% include requirement/MUSTNOT id="general-implementing-no-persistence-auth" %} persist, cache, or reuse security credentials.  Security credentials should be considered short lived to cover both security concerns and credential refresh situations.

If your service implements a non-standard credential system (that is, a credential system that is not supported by Azure Core), then you need to produce an authentication policy for the HTTP pipeline that can authenticate requests given the alternative credential types provided by the client library.

{% include requirement/MUST id="general-implementing-auth-policy" %} provide a suitable authentication policy that authenticates the HTTP request in the HTTP pipeline when using non-standard credentials.  This includes custom connection strings, if supported.

TODO: Would a code sample be helpful here?

## Native code {#general-native-code}

Some languages support the development of platform-specific native code plugins.  These cause compatibility issues and require additional scrutiny.  Certain languages compile to a machine-native format (for example, C or C++), whereas most modern languages opt to compile to an intermediary format to aid in cross-platform support.

{% include requirement/SHOULD id="general-implementing-nonativecode" %} write platform-specific / native code unless the language compiles to a machine-native format.

## Error handling {#general-error-handling}

Error handling is an important aspect of implementing a client library.  It is the primary method by which problems are communicated to the consumer.  There are two methods by which errors are reported to the consumer.  Either the method throws an exception, or the method returns an error code (or value) as its return value, which the consumer must then check.  In this section we refer to "producing an error" to mean returning an error value or throwing an exception, and "an error" to be the error value or exception object.

{% include requirement/SHOULD id="general-errors-prefer-exceptions" %} prefer the use of exceptions over returning an error value when producing an error.

{% include requirement/MUST id="general-errors-when-http-fails" %} produce an error when any HTTP request fails with an HTTP status code that is not defined by the service/Swagger as a successful status code. These errors should also be logged as errors.

{% include requirement/MUST id="general-errors-include-response" %} ensure that the error produced contains the HTTP response (including status code and headers) and originating request (including URL, query parameters, and headers).

In the case of a higher-level method that produces multiple HTTP requests, either the last exception or an aggregate exception of all failures should be produced.

{% include requirement/MUST id="general-errors-rich-information" %} ensure that if the service returns rich error information (via the response headers or body), the rich information must be available via the error produced in service-specific properties/fields.

{% include requirement/SHOULDNOT id="general-errors-no-new-errors" %} create a new error type unless the developer can perform an alternate action to remediate the error.  Specialized error types should be based on existing error types present in the Azure Core package.

{% include requirement/MUSTNOT id="general-errors-use-system-errors" %} create a new error type when a language-specific error type will suffice.  Use system-provided error types for validation.

{% include requirement/MUST id="ts-error-handling" %} use ECMAScript built-in error types for validation failures when appropriate. Specifically,

* Use `TypeError` for errors relating to passing in an incorrect type, such as an Object when a string is expected.
* Use `RangeError` for errors relating to values that are outside an allowable range, such as passing 0 for a number that must be greater than 0.
* Use `Error` for all other validation failures.

{% include requirement/SHOULD id="ts-error-handling-coercion" %} coerce incorrect types into an appropriate type, if possible. JavaScript users expect some amount of fuzziness with parameters as the standard library will coerce types if possible. TypeScript users should get pedantic types as they've opted in to types and expect errors.

{% include requirement/MUST id="ts-errors-documentation" %} document the errors that are produced by each method (with the exception of commonly thrown errors that are generally not documented in the target language).

{% include requirement/SHOULD id="ts-error-use-name" %} check the name property inside catch clauses rather than using `instanceof`.

## Logging {#general-logging}

Client libraries must support robust logging mechanisms so that the consumer can adequately diagnose issues with the method calls and quickly determine whether the issue is in the consumer code, client library code, or service.

{% include requirement/MUST id="ts-logging-use-debug-module" %} use the `debug` module to log to stderr or the browser console.

{% include requirement/MUST id="general-logging-console" %} make it easy for a consumer to enable logging output to the console. The specific steps required to enable logging to the console must be documented.

{% include requirement/MUST id="ts-logging-prefix-channel-names" %} prefix channel names with `azure:<service-name>`.

{% include requirement/MUST id="ts-logging-channels" %} create log channels for the following log levels with the following channel name suffixes:

* Error: `:error`
* Warning: `:warning`
* Info: `:info`
* Verbose: `:verbose`

{% include requirement/MAY id="ts-logging-additional-channels" %} have additional log channels, for example, to log from separate components. However, these channels MUST still provide the three log levels from above for each subchannel.

{% include requirement/MUST id="ts-logging-top-level-exports" %} expose all log channels as top-level exports of your package, allowing the consumer to configure how the logging happens and integrate with 3rd-party loggers.

{% include requirement/MUST id="general-logging-levels-error" %} use the Error channel for failures that the application is unlikely to recover from (out of memory, etc.).

{% include requirement/MUST id="general-logging-levels-warning" %} use the Warning channel when a function fails to perform its intended task. This generally means that the function will raise an exception.  Do not include occurrences of self-healing events (for example, when a request will be automatically retried).

{% include requirement/MUST id="general-logging-levels-informational" %} use the Info channel when a function operates normally.

{% include requirement/MUST id="general-logging-levels-verbose" %} use the Verbose channel for detailed troubleshooting scenarios. This is primarily intended for developers or system administrators to diagnose specific failures.

{% include requirement/MUSTNOT id="general-logging-no-sensitive-info" %} send sensitive information in channels other than Verbose. For example, remove account keys when logging headers.

{% include requirement/MUST id="general-logging-requests-in-info" %} log request line, response line, and headers on the Info channel.

{% include requirement/MUST id="general-logging-info-if-cancelled" %} log to the Info channel if a service call is cancelled.

{% include requirement/MUST id="general-logging-error-if-exceptions" %} log exceptions thrown to the Warning channel. Additionally, send stack trace information to the Verbose channel.

## Distributed tracing {#general-distributed-tracing}

Distributed tracing mechanisms allow the consumer to trace their code from frontend to backend. The distributed tracing library creates spans - units of unique work.  Each span is in a parent-child relationship.  As you go deeper into the hierarchy of code, you create more spans.  These spans can then be exported to a suitable receiver as needed.  To keep track of the spans, a _distributed tracing context_ (called a context in the remainder of this section) is passed into each successive layer.  For more information on this topic, visit the [OpenTelemetry] topic on tracing.

{% include draft.html content="DRAFT GUIDELINES" %}

{% include requirement/MUST id="general-tracing-support-opentelemetry" %} support [OpenTelemetry] for distributed tracing.

{% include requirement/MUST id="general-tracing-use-core-tracing" %} Use helpers from `core-tracing` to support  distributed tracing.

{% include requirement/MUST id="general-tracing-pass-context" %} pass the context to the backend service through the appropriate headers (`traceparent`, `tracestate`, etc.) to support [Azure Monitor].  This is generally done with the HTTP pipeline.

{% include requirement/MUST id="general-tracing-create-span-on-entry" %} create a new span for each method that user code calls.  New spans must be children of the context that was passed in.  If no context was passed in, a new root span must be created.

{% include requirement/MUST id="general-tracing-create-span-on-rest" %} create a new span (which must be a child of the per-method span) for each REST call that the client library makes.  This is generally done with the HTTP pipeline.

Some of these requirements will be handled by the HTTP pipeline.  However, as a client library writer, you must handle the incoming context appropriately.  JavaScript doesn't have primitives similar to a local context.  As such, we must manually plumb parent span IDs into the library.

TODO: Please add a discussion of how to set the user-agent string for implementation of the SDK Telemetry feature.

## Dependencies {#ts-dependencies}

Dependencies bring in many considerations that are often easily avoided by avoiding the dependency:

**Versioning**: Many programming languages don't allow a consumer to load multiple versions of the same package. For example, if we have a client library that requires v3 of package `Foo` and the consumer wants to use v5 of package `Foo`, then the consumer can't build their application. Client libraries shouldn't have dependencies by default.

**Size**: Consumer applications need to deploy as fast as possible into the cloud. Remove additional code (like dependencies) to improve deployment performance.

**Licensing**: You must be conscious of the licensing restrictions of a dependency and often provide proper attribution and notices when using them.

**Compatibility**: You don't control the dependency. It may choose to evolve in a direction that is incompatible with your original use.

**Security**: If a vulnerability is discovered in a dependency, it may be difficult or time consuming to get the vulnerability corrected.

{% include requirement/MUST id="ts-dependencies-azure-core" %} depend on the Azure Core library for functionality that is common across all client libraries.  This library includes APIs for HTTP connectivity, global configuration, and credential handling.

{% include requirement/MUSTNOT id="ts-dependencies-no-other-packages" %} depend any other packages within the client library distribution package. Dependencies are thoroughly vetted through architecture review.  Build dependencies, by contrast, are acceptable and commonly used.

{% include requirement/SHOULD id="ts-dependencies-consider-vendoring" %} consider copying or linking required code into the client library to avoid taking a dependency on another package. Don't violate the license agreements. Consider the maintenance that will be required when duplicating code. ["A little copying is better than a little dependency"](https://www.youtube.com/watch?v=PAAkCSZUG1c&t=9m28s) (YouTube).

{% include requirement/MUSTNOT id="general-no-concrete-logging" %} depend on concrete logging, dependency injection, or configuration technologies (except as implemented in the Azure Core library).

{% include requirement/SHOULDNOT id="ts-dependencies-no-tiny-libraries" %} take dependencies on tiny libraries as the cost of many small libraries adds up over time. Larger dependencies are subject to approval.

{% include requirement/SHOULDNOT id="ts-dependencies-no-polyfills" %} depend directly on polyfills or other libraries that modify global scope. If developers using older runtimes need to polyfill some capability, the package install and usage instructions (in the `README`) should indicate this dependency.

The following table lists the well-known and already-blessed dependencies outside of Azure Core that may be used in production (non-test) code.
<a name="ts-known-deps"></a>

{% include_relative approved_dependencies.md %}

## Service-specific common library code

There are occasions when common code needs to be shared between several client libraries.  For example, a set of cooperating client libraries may wish to share a set of exceptions or models.

{% include requirement/MUST id="general-implementing-common-library-usage" %} gain [Architecture Board] approval prior to implementing a common library.

{% include requirement/MUST id="general-implementing-minimal-common-content" %} minimize the code within a common library.  Code within the common library is available to the consumer of the client library and shared by multiple client libraries within the same namespace.

{% include requirement/MUST id="general-implementing-common-namespace" %} store the common library in the same namespace as the associated client libraries.

A common library will only be approved if:

* The consumer of the non-shared library will consume the objects within the common library directly, AND
* The information will be shared between multiple client libraries.

Let's take two examples:

1. Implementing two Cognitive Services client libraries, we find a model is required that is produced by one Cognitive Services client library and consumed by another Coginitive Services client library, or the same model is produced by two client libraries.  The consumer is required to do the passing of the model in their code, or may need to compare the model produced by one client library vs. that produced by another client library.  This is a good candidate for choosing a common library.

2. Two Cognitive Services client libraries throw an `ObjectNotFound` exception to indicate that an object was not detected in an image.  The user might trap the exception, but otherwise will not operate on the exception.  There is no linkage between the `ObjectNotFound` exception in each client library.  This is not a good candidate for creation of a common library (although you may wish to place this exception in a common library if one exists for the namespace already).  Instead, produce two different exceptions - one in each client library.

## Testing TypeScript libraries

{% include requirement/SHOULD id="ts-use-vitest" %} use [vitest](https://vitest.dev/) as it supports build pipelines and works in browsers and node.

## Versioning {#ts-versioning}

Consistent versioning allows consumers to determine what to expect from a new version of the library.  However, versioning rules tend to be very idiomatic to the language.  The engineering system release guidelines require the use of _MAJOR_._MINOR_._PATCH_ format for the version.

{% include requirement/MUST id="general-versioning-bump" %} change the version number of the client library when **ANYTHING** changes in the client library.

{% include requirement/MUST id="general-versioning-patch" %} increment the patch version when fixing a bug.

{% include requirement/MUSTNOT id="general-versioning-no-features-in-patch" %} include new features in a patch release.

{% include requirement/MUST id="general-versioning-adding-features" %} increment the major or minor version when adding support for a service API version, or add a backwards-compatible feature.

{% include requirement/MUSTNOT id="general-versioning-no-breaking-changes" %} make breaking changes.  If a breaking change is absolutely required, then you **MUST** engage with the [Architecture Board] prior to making the change.  If a breaking change is approved, increment the major version.

{% include requirement/SHOULD id="general-versioning-major-bump" %} increment the major version when making large feature changes.

{% include requirement/MUST id="general-versioning-serviceapi-support" %} provide the ability to call a specific supported version of the service API.

A particular (major.minor) version of a library can choose what service APIs it supports.  We recommend the support window be no less than two service versions (if available) and no less than what is specified in the [Fixed Lifecycle Policy for Microsoft business, developer, and desktop systems](https://support.microsoft.com/help/14085).

{% include requirement/MUST id="ts-versioning-semver" %} version with [semver](https://semver.org/). Deprecated features and flags must offer an alternate stable or beta path for developers.

{% include requirement/MUSTNOT id="ts-versioning-no-ga-prerelease" %} have a pre-release version or any additional build metadata for stable packages.

{% include requirement/MUST id="ts-versioning-beta" %} give beta packages a pre-release version of the format `1.0.0-beta.X` where X is an integer. Pre-release package versions shouldn't have additional build metadata.

{% include requirement/MUSTNOT id="ts-versioning-no-version-0" %} use a major version of 0, even for beta packages.

{% include requirement/MUST id="versioning-bump-from-track-1" %} select a version number greater than the highest version number of any other released Track 1 package for the service in any other npm scope or language.

Semantic versioning is more of a lofty ideal than a practical specification for some libraries. Also, [one person's bug might be another person's key feature](https://xkcd.com/1172/). Package authors are required to follow semver in a way that is useful for their consumers.

For more details, review the [Releases policy]({{ site.baseurl }}/policies_releases.html).

## Packaging {#ts-npm-package}

{% include requirement/MUST id="ts-npm-package-ownership" %} have npm package ownership set to either the Azure or Microsoft organizations.

### Package Layout {#ts-package-file-layout}

Use the `"tshy"` section in your package.json to configure your npm package.

```
  "tshy": {
    "project": "./tsconfig.src.json",
    "exports": {
      "./package.json": "./package.json",
      ".": "./src/index.ts",
      "./experimental": "./src/experimental/index.ts"
    },
    "dialects": [
      "esm",
      "commonjs"
    ],
    "esmDialects": [
      "browser",
      "react-native"
    ],
    "selfLink": false
  },
```

The layout of packaged library should look similar to this:

<a name="ts-figure-package-layout"></a>

```
azure-library
├─ README.md
├─ LICENSE
├─ dist
│   ├── browser
│   │   ├── index.d.ts
│   │   ├── index.js
│   │   ├── index.js.map
│   │   ├── ...*.js
│   │   └── ...*.js.map
│   ├── commonjs
│   │   ├── index.d.ts
│   │   ├── index.js
│   │   ├── index.js.map
│   │   ├── ...*.js
│   │   └── ...*.js.map
│   ├── esm
│   │   ├── index.d.ts
│   │   ├── index.js
│   │   ├── index.js.map
│   │   ├── ...*.js
│   │   └── ...*.js.map
│   ├── react-native
│       ├── index.d.ts
│       ├── index.js
│       ├── index.js.map
│       ├── ...*.js
│       └── ...*.js.map
└─ package.json
```

{% include requirement/MUST id="ts-file-layout-conventions" %} follow these conventions where applicable.

{% include requirement/MUSTNOT id="ts-no-tsconfig" %} include a `tsconfig.json` file in your package. While generally useful to include, our `tsconfig.json` files are heavily tied to our monorepo structure and so won't work properly when read from inside an individual package.

{% include requirement/MAY id="ts-can-have-other-files" %} include other files.

{% include requirement/MUSTNOT id="ts-no-npmignore" %} use `.npmignore` files to control which files are included in the package. All files must be added to the package explicitly using the `package.json` files key.

### The `package.json` file {#ts-package-json}

The following sections describe the package.json file that must be included with every npm package. A compliant `package.json` file looks like the following:
<a name="ts-figure-package-json"></a>

```javascript
{
  "name": "@azure/package",
  "description": "A pithy but accurate description",
  "keywords": [
    "azure",
    "cloud",
    "..."
  ],
  "version": "1.0.0",
  "author": "Microsoft Corporation",
  "main": "./dist/commonjs/index.js",
  "module": "./dist/esm/index.js",
  "browser": "./dist/browser/index.js",
  "types": "./dist/commonjs/index.d.ts",
  "engine": {
    "node": ">=20.0.0"
  },
  "scripts": {
    "build": "...",
    "test": "...",
  },
  "files": [
    "dist/",
    "README.md",
    "LICENSE"
  ],
  "devDependencies": { /* ... */ },,
  "dependencies": { /* ... */ },
  "repository": "github:Azure/azure-sdk-for-js",
  "homepage": "https://github.com/Azure/azure-sdk-for-js/tree/main/sdk/servicebus/service-bus",
  "bugs": {
    "url": "https://github.com/Azure/azure-sdk-for-js/issues"
  },
  "license": "MIT",
  "sideEffects": false
}
```

{% include requirement/MUST id="ts-package-json-name" %} set `name` to `@azure/<name>`, where `<name>` is the name of the service. Package names are kebab-case: all lowercase with words joined by dashes.

{% include requirement/MUST id="ts-package-json-homepage" %} set `homepage` to a URL pointing to your library's readme inside the git repo. Since the repository link goes to the monorepo, this link exists to serve as an easier way to reach the actual package's source.

{% include requirement/MUST id="ts-package-json-bugs" %} set `bugs` to an object with a `url` key pointing to your library's issue tracker: https://github.com/Azure/azure-sdk-for-js/issues.

{% include requirement/MUST id="ts-package-json-repo" %} set `repository` to the JS SDK monorepo - `github:Azure/azure-sdk-for-js`. Use of the `github:user/repo` short-hand is recommended.

{% include requirement/MUST id="ts-package-json-description" %} set `description` to a useful but terse description of your library. The description is used and shown when searching for packages on [npmjs.org](https://npmjs.org).

{% include requirement/MUST id="ts-package-json-keywords" %} set `keywords` to an array that includes at least the entries "Azure" and "cloud". It must also contain at least the name of your service. It should contain other entries relevant to your SDK.

{% include requirement/MUST id="ts-package-json-author" %} set `author` to `"Microsoft Corporation"`.

{% include requirement/MUST id="ts-package-json-sideeffects" %} set `sideEffects` to `false`. Side effecting libraries must be explicitly approved during design review. The `sideEffects` field is used by [Webpack](https://webpack.js.org) and potentially other tools as an indicator of how aggressively the package can be optimized.

Side effects are modifications to the runtime environment of the program. For example, including a polyfill library is a `sideEffect`. It mutates the global environment. Side effects make it harder for tools to optimize your build and should be avoided.

{% include requirement/MUST id="ts-package-json-main-is-cjs" %} set `main` to point to either a CommonJS or a UMD module. Main is the entry point of your application for Node users.

{% include requirement/MUSTNOT id="ts-package-json-main-is-not-es6" %} set `main` to include any ESM syntax.

{% include requirement/MUST id="ts-package-json-module" %} set `module` to the ESM entrypoint of your application.

Tools such as [Webpack](https://webpack.js.org) use this key to discover the static module graph of your application for optimization purposes.

{% include requirement/MUST id="ts-package-json-browser" %} include a file map in the `browser` object if your library supports the browser and needs browser-specific module substitutions.

For example, the following JSON snippet demonstrates the minimum requirements, assuming you have a separate entrypoint for browsers.

```json
{
    "main": "./dist/index.js",
    "browser": {
        "./dist/index.js": "./dist/index.browser.js"
    }
}
```

{% include requirement/MUST id="ts-package-json-engine-is-present" %} set `engine` to the versions of Node your library supports. See [#ts-supported-node-versions] for Node support requirements.

{% include requirement/MUST id="ts-package-json-required-scripts" %} set `scripts` to an object with the following scripts:

- `"build"`: generates the main export of the application.
- `"test"`: runs your package's functional test suite for inner-loop development. Additional test tasks (for example, continuous integration tests) are allowed but `test` must be how developers test your package during development.

{% include requirement/MUSTNOT id="ts-package-json-required-scripts-for-development" %} depend on shell scripts to build or test the package.  Shell scripts need to be platform-specific.  Include a `script` for any task required during development of your package.

{% include requirement/MUST id="ts-package-json-files-required" %} set `files` to an array containing paths of your package contents. Setting this field prevents extraneous files from ending up in your package by being explicit about which files you ship to npm.

{% include requirement/MUST id="ts-package-json-types" %} set `types` to point to the TypeScript type declarations for your library's public surface area, usually `"./types/index.d.ts"`.

{% include requirement/MUST id="ts-package-json-license" %} set `license` to "MIT".

### Distributions {#ts-source-distros}

Modern npm packages often ship multiple source distributions targeting different usage scenarios. Packages must include a CJS or UMD build, an ESM build, and original soure files. Packages may include other source distributions as necessary for their particular usage scenarios. The main downside of including additional source distributions is the increased package size (larger packages mean CIs take longer). However, performance, compatibility, and developer experience goals are often more important.

{% include requirement/MUST id="ts-include-original-source" %} include the source code in your source map files' `sourcesContent` by using the TypeScript compiler option `inlineSources`.

The source code in your package helps developers debug your package. _Go-to-definition_ is a quick way to confirm how to use a function. Seeing useful names and readable source code in call stacks helps with debugging. We can aggressively optimize the build artifacts since users won't need to puzzle through the mangled code.

{% include requirement/MUST id="ts-include-cjs" %} include a CommonJS (CJS) or UMD build in your package if you intend to support Node.

{% include requirement/MUST id="ts-flatten-umd" %} flatten the CommonJS or UMD module.  [Rollup](https://rollupjs.org) is recommended for producing a flattened module.

The process of packing multiple modules into a single file is known as _flattening_. It's used to significantly reduce the load time for the library.  Flattening can make a measurable impact on cold start times for services such as Azure Functions. While performance-sensitive developers will likely package their applications themselves, faster start-up is still important especially during development.

{% include requirement/MUST id="ts-include-esm" %} include an ECMAScript Module (ESM) build in your package.

{% include requirement/MUSTNOT id="ts-include-esm-not-flattened" %} flatten the ESM build.

An ESM distribution is consumed by tools such as [Webpack](https://webpack.js.org) that optimize the module graph. It should be "transpiled" to support the runtime versions you're targeting. Versions of Webpack before Webpack 4.0 produce better optimized bundles if the ESM build is flattened. However, flattening doesn't play so well with tree-shaking. The latest versions of Webpack do a better job when using an unflattened ESM build.


<a name="ts-browser-umd"></a>
<a name="ts-browser-umd-global-naming"></a>
<a name="ts-browser-minify-umd"></a>
<a name="ts-browser-location"></a>
{% include requirement/MUSTNOT id="ts-no-browser-bundle" %} include a browser bundle in your package. Shipping browser bundles is convenient for users but comes with some significant downsides too. For example, browser bundles must flatten the entire dependency tree and re-distribute all open source components it depends on. This requires ThirdPartyNotices.txt to be accurate which is a complex and error-prone. Security vulnerabilities in any dependency requires servicing the browser bundle as well.

In practice, users working on production applications will likely be using a bundler. Moreover, modern bundlers are much easier to use relative to earlier incarnation. Azure client libraries should work with most popular bundlers.

### Modules {#ts-modules}

{% include requirement/MUST id="ts-modules-only-named" %} have named exports at the top level

{% include requirement/MUSTNOT id="ts-modules-no-default" %} have a default export at the top level

Azure packages authored using TypeScript export standard ES6 modules. As Node doesn't support ES6 modules natively, authoring ES6 modules for consumption in Node has a bit of friction. Most notably, a commonJS package can only import a single value.

{% include refs.md %}
{% include_relative refs.md %}
