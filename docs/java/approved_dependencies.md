| Name                                              | Role                | Allowed in public API | Notes |
|---------------------------------------------------|-------------------- |:---------------------:|-------|
| [`Reactor`](http://projectreactor.io)             | Reactive library    | Yes                   |       |
| [`Netty`](http://netty.io)                        | HTTP client         | No                    |       |
| [`slf4j`](http://slf4j.org)                       | Logging framework   | No                    | Use the azure core `ClientLogger` API rather than `slf4j` directly. |
| [`Jackson`](https://github.com/FasterXML/jackson) | JSON parser         | No                    |       |
| [`OpenTelemetry`](https://opentelemetry.io/)      | Telemetry library   | No                    | Enabled through the [tracing plugin](https://github.com/Azure/azure-sdk-for-java/tree/master/sdk/core/azure-core-tracing-opentelemetry) |
