| Name                                                             | Role                | Allowed in public API | Notes |
|------------------------------------------------------------------|-------------------- |:---------------------:|-------|
| [Apache Avro](https://avro.apache.org)                           | Avro parser         | No                    | Used only in azure-core-serializer-avro-apache. |
| [Jackson](https://github.com/FasterXML/jackson)                  | JSON parser         | No                    | Use azure-core `JsonSerializer` abstractions rather than Jackson directly.      |
| [JNA](https://github.com/java-native-access/jna)                 | Native access to OS | No                    | Used only in azure-identity. |
| [Netty](https://netty.io)                                        | HTTP client         | No                    | Used only in azure-core-http-netty.      |
| [OkHttp](https://square.github.io/okhttp/)                       | HTTP client         | No                    | Used only in azure-core-http-okhttp.      |
| [OpenTelemetry](https://opentelemetry.io/)                       | Telemetry library   | No                    | Used only in azure-core-tracing-opentelemetry. |
| [Reactor](https://projectreactor.io)                             | Reactive library    | Yes                   |       |
| [slf4j](https://www.slf4j.org)                                   | Logging framework   | No                    | Use the azure core `ClientLogger` API rather than `slf4j` directly. |
| [Apache Qpid Proton-J](https://github.com/apache/qpid-proton-j)  | AMQP messaging      | No                    | Used only in azure-core-amqp. |
