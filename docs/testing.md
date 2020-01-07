# Testing

Software testing provides developers a safety net. Investing in tests upfront saves time overall due to increased certainty over the development process that changes are not resulting in divergence from stated requirements and specifications. The intention of these testing guidelines is to focus on the complexities around testing APIs that are backed by live services when in their normal operating mode. We want to enable open source development of our client libraries, with certainty that regardless of the developer making code changes there always remains conformance to the initial design goals of the code. Additionally, our goal is to ensure that developers building atop the Azure client libraries can meaningfully test their own code, without incurring additional complexity or expense through unnecessary interactions with a live Azure service.

**DO** write tests that ensure all APIs fulfil their contract and algorithms work as specified. Focus particular attention on client functionality, and places where payloads are serialized and deserialized.

**DO** ensure that client libraries have appropriate unit test coverage, [focusing on quality tests](https://martinfowler.com/bliki/TestCoverage.html), using code coverage reporting tools to identify areas where more tests would be beneficial. Each client library should define its minimum level of code coverage, and ensure that this is maintained as the code base evolves.

**DO** use unique, descriptive test case names so test failures in CI (especially external PRs) are readily understandable.

**DO** ensure that users can run all tests without needing access to Microsoft-internal resources. If internal-only tests are necessary, these should be a separate test suite triggered via a separate command, so that they are not executed by users who will then encounter test failures that they cannot resolve.

**DO NOT** rely on pre-existing test resources or infrastructure and **DO NOT** leave test resources around after tests have completed. Anything needed for a test should be initialized and cleaned up as part of the test execution (whether by running an ARM template prior to starting tests, or by setting up and tearing down resources in the tests themselves).

## Recorded Tests

**DO** ensure that all tests work without the need for any network connectivity or access to Azure services.

**DO** write tests that use a mock service implementation, with a set of recorded tests per service version supported by the client library. This ensures that the service client continues to properly consume service responses as APIs and implementations evolve. Recorded tests must be run using the language-appropriate trigger to enable the specific service version support in the client library.

**DO** recreate recorded tests for a specific service version when notified by the service team of any changes to the endpoint APIs for that service version. In the absence of this notification, recordings should not be updated needlessly. When the service team requires recorded tests to be recreated, or when a recorded test begins to fail unexpectedly, notify the [architecture board](mailto:adparch@microsoft.com) before recreating the tests.

**DO** enable all network-mocked tests to also connect to live Azure service. The test assertions should remain unchanged regardless of whether the service call is mocked or not.

**DO** ensure that all recorded tests do not contain sensitive information.

## Testability

As outlined above, writing tests that we can run constantly is critical for confidence in our client library offering, but equally critical is enabling users of the Azure client libraries to write tests for their applications and libraries. End users want to be certain that their code is performing appropriately, and in cases where this code interacts with the Azure client libraries, end users do not want complex or costly Azure interactions to prevent their ability to test their software.

**DO** support the ability for users to override service client methods such that functionality may be overridden through mocking frameworks or other means.

**DO** support the ability to instantiate and set all properties on model objects, such that users may return these from their code.

**DO** support user tests to operate in a network-mocked manner, without the need for any network access.

**DO** provide clear documentation on how users are to instantiate the client library such that it may operate in these modes.
