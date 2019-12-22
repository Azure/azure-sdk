# Testing

Software testing provides developers a safety net. Investing in tests upfront saves time overall due to increased certainty over the development process that changes are not resulting in divergence from stated requirements and specifications. The intention of these guidelines is to enable open source development of our client libraries, with certainty that regardless of the developer making code changes there always remains conformance to the initial design goals of the code. Additionally, our goal is to ensure that developers building atop the Azure client libraries can meaningfully test their own code, without incurring additional complexity or expense through unnecessary interactions with a live Azure service.

## Existing guidelines

* General: https://azure.github.io/azure-sdk/general_implementation.html
* C#: https://azure.github.io/azure-sdk/dotnet_introduction.html#dotnet-mocking
* Java: https://azure.github.io/azure-sdk/java_implementation.html
* Python: https://azure.github.io/azure-sdk/python_implementation.html#testing
* TypeScript: https://azure.github.io/azure-sdk/typescript_implementation.html#testing-typescript-libraries

## Internal testing (by the ADP team)

**DO** ensure that client libraries have appropriate unit test coverage. [Focus on quality, rather than attaining a specific target](https://martinfowler.com/bliki/TestCoverage.html) in unit test coverage. In other words, use the code coverage reporting tools to identify areas where more tests would be beneficial, rather than using these tools simply to attain a target coverage value.

**DO** write tests that ensure APIs fulfil their contract and algorithms work as specified. These tests must work without the need for any network connectivity or access to Azure services.

**DO** write tests that use a mock service implementation. This ensures that the service client continues to properly consume service responses as APIs and implementations evolve.

**DO** enable all network-mocked services to also connect to live Azure service. The test assertions should remain unchanged regardless of whether the service call is mocked or not.

## External testing (by users of our client libraries)

**DO** ensure that users can write higher-level unit tests for their applications and libraries that make use of the Azure client libraries.

**DO** support the ability for users to override service client methods such that functionality may be overridden through mocking frameworks or other means.

**DO** support the ability to instantiate and set all properties on model objects, such that users may return these from their code.

**DO** support user tests to operate in a network-mocked manner, without the need for any network access.

**DO** provide clear documentation on how users are to instantiate the client library such that it may operate in these modes.

## Java-specific guidance

All client libraries must support mocking.

**DO** use [Mockito](https://site.mockito.org/) for creating mock objects for testing. Refer to the [DZone reference card](https://dzone.com/refcardz/mockito?chapter=1) for more details on how to use Mockito.

**DO** ensure that all service client classes can be mocked using Mockito. This places restrictions on static APIs and final classes.
