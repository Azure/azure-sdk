# Java Best Practices

This document is a supplement to the Java SDK Component guidelines - it covers miscellaneous best practices for developers writing Java API.

A good starting point for all API developers is to refer to the [Java API Design Best Practices website](https://jonathangiles.net/presentations/java-api-design-best-practices/) for a DZone refcard and YouTube videos. Best practices such as immutable classes, using builders as necessary, using `final` appropriately, proper implementation of `hashCode` and `equals` methods, and so on are vital to the quality of an API, and this website has a good of useful guidance.

## IDE Configuration

As it appears most engineers reading this document have standardised on IntelliJ IDEA for their IDE choice, a repository has been made available containing code style and inspection rules. Enabling these configuration settings in IntelliJ IDEA will ensure that all engineers will be generating code that conforms to a shared style standard, with fewer bugs and improved consistency.

Consider installing the addons following the [instructions provided](https://github.com/JonathanGiles/java-code-styles), and ensure that any reported warnings are resolved in your code. If you are not running IntelliJ, use SpotBugs and CheckStyle to perform a similar set of checks.

## Maven Projects

The Azure SDK, and all SDK components, use Maven as the system to handle build and dependency management. By employing a single tool across all SDK components, builds can be related to each other to enable centralized management of build configuration and dependency versioning.

The following is the canonical file structure of a Maven-based project, after it has been initialized:

```
sdk-component
|-- pom.xml
`-- src
    |-- main
    |   `-- java
    |       `-- com
    |           `-- azure
    |               `-- ServiceClient.java
    `-- test
        `-- java
            `-- com
                `-- azure
                    `-- ServiceClientTest.java
```

Projects that decompose into multiple submodules work by effectively introducing an intermediate parent POM that groups together all children modules, but from the root POM there remains only the one POM that it cares about. Choosing to decompose a project into multiple submodules is a decision that an SDK component can make, but it should not be done without a good justification - in most cases a single module is the best approach. If you are interested, you can [read more about multi-module projects](https://books.sonatype.com/mvnex-book/reference/multimodule.html).

### Project Initialization

You **MUST** initialize a brand new Maven project for each SDK component by copying the `template` directory into a new directory, and making the changes outlined in the remainder of this section.

## JavaDoc

JavaDoc ships with a [number of tags](https://docs.oracle.com/javase/8/docs/technotes/tools/windows/javadoc.html#CHDJFCCC) such as `@link`, `@param`, and `@return`, which provide more context to the JavaDoc tooling, and which therefore enables a richer experience when HTML output is generated. It is extremely useful when writing JavaDoc content to keep these in the back of your mind, to ensure that they are all used when relevant. To understand when to use each of these tags, refer to the ['Tag Comments' section](https://docs.oracle.com/javase/8/docs/technotes/tools/windows/javadoc.html#CHDJFCCC) of the Java Platform, Standard Edition Tools Reference documentation.

Do annotate your source code with JavaDoc declarations.

Do use JavaDoc as the specification of the API. Engineers responsible for writing API must consider it part of their job to ensure that a JavaDoc is complete, with class-level and method-level overviews for all public and protected API, specifying the expected inputs, outputs, exceptional circumstances, and any other detail.

Do include code snippets in the JavaDoc content that users can copy/paste into their own software to kick start their own development. These code snippets need not be long screeds of code - it is best if they are constrained to no more than five to ten lines of code. These code snippets can be added to the JavaDoc of the relevant class or method over time, as users start to ask questions on the API.

Do review your JavaDoc to ensure that no implementation details leak out of public API. Developers must ensure that implementation classes are not visible in any public API as method parameters or return types. Similarly, only approved external dependencies should be visible as public API. Finally, JavaDoc must be inspected for completeness and accuracy.

## Deprecation

For a very long time, Java releases applied the appropriate deprecation annotations, but the API lingered through many releases to ensure backwards compatibility. More recently, the final act of following through on deprecation by removing deprecated functionality has become increasingly accepted. The JDK in more recent releases has taken to cleaning out some deprecated functionality, and [improving the `@Deprecated` annotation](https://openjdk.java.net/jeps/277) to enable identification of when an API was deprecated, and if it is planned for removal.

Open source libraries in the Java ecosystem have also been pragmatic about breaking changes, typically following the standard semver approach, along with using the deprecation annotations in Java to inform users how they should change their code, and to ensure their compiler warns them when code they use has become deprecated.

It could be said therefore that deprecation is baked into the Java ethos. We should strive to see deprecation and removal as a last resort, but also as a useful tool in our toolset to ensure that we deliver developers the best developer experience.