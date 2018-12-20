# Cloud Native Azure SDK Features

## All Cloud Native SDKs should support these features:
- Customization of the HTTP stack (allowing proxies, changing concurrent connections, keep-alives, TLS, expect continue, etc.)
  
- Logging  (with levels [debug, info, warning, error] and possible too-much-time threshold)
- Retries (With exponential/fixed policy, max # of retries, per-try timeout, retry delay, max retry delay). Also, deserialization of service payloads should be retryable should connection fail while downloading. Some services may support additional retry features such as retrying an operation from an alternate datacenter. Also note that the service and/or client may need to do some additonal work to guarantee idempotency.
- Telemetry
- Credentials (Anonymous, OAuth, and possibly custom [like shared key for Azure Storage])
- Unique request ID generation (possibly overwritten by customer)
- Progress reporting when transferring large amounts of data
- Manual & timed cancellation (ideally, a single cancellation object could be usable across multiple SDKs; for example, imagine a single 5-second cancellation object that can be passed to keyvault, CosmosDB, and Azure Storage APIs ensuring that all operations complete within 5 seconds)
 

## Some other potential features are:
- Circuit breakers  
- Client-side caching
- Pacing of requests
- Fault injection
- Bandwidth monitoring
- Mocking/testing support (recordings)

## Here are some other SDK thoughts:
- SDK design should be centered around leading customer into "pit of success". For example, customers should be able to diagnose problems themselves and fix them without having to get any kind of support. This, by necessaity, requires NOT abstracting network calls and communcation endpoints so that when communication fails, the customer can determine what was trying to be communcatted with in an effort to diagnose the failure. 

- SDKs should be pay for play. That is, customers should only have to take what they need.

- Each SDK major version is tied to a specific service version. Minor version updates are for compatible bug fixes/perf improvements/non-breaking features. We're allowed to make breaking changes between major versions. However, breaks should NOT be gratuitous; they should be a very good reason for breaking customer code.

- If possible (usually depending on the programming language), customers should be able to load multiple versions of the SDK in their application; old code can run against the old version and new code can run against the new version. There MUST be a way for customer code to interop between the versions. For example, the customer can grab a URL from an old library object and construct a new library object using the same URL - this allows the user to use both old & new libraries at will within their application to leverage new feratures while not forcing them to upgrade old code to a new library version.

- SDKs should ideally depend on the language's core platform only and NOT depend on any other packages. Depending on other packages prevents customers from using other SDKs that depend on different versions of those same packages. This could even prevent multiple Azure SDKs from being used within a single app if the SDKs depend on different versions of the same package. To solve this, it is best for each SDK to not depend on any other packages.

- SDKs should stick with simple data types (strings, numbers, booleans, and simple structures consisting of these data types) as these are available in all languages allowing for greater consistency across languages which simplifies user's learning curve.

- Of course, the SDK should be up-to-date with the idioms used by the SDK's programming language. Here are some examples:
    - .NET I/O APIs should all be of the XxxAsync form; synchronous and BeginXxx/EndXxx APIs should not be exposed. 
    - Go I/O APIs should all take a context.Context object as their first parameter.
    - Java I/O APIs should use RxJava and not expose synchronous APIs.
    - Node I/O APIs should return promises.

- All APIs must be threadsafe. Ideally, all data structures returned from a service call are immutable.

- SDKs should avoid allocating memory/buffers as much as possible. Customers should own their own memory consumption including buffer sizes, number of buffers, and their lifetime.