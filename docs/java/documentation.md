---
title: "Java Guidelines: Documentation"
keywords: guidelines java
permalink: java_documentation.html
folder: java
sidebar: java_sidebar
---

There are several pieces of documentation that must be included with your client library. Beyond complete and helpful API documentation within the code itself (`JavaDoc`), you need a great README and other supporting documentation.

* `README.md` - Resides in the root of your library's directory within the SDK repository; includes package installation and client library usage information. ([example][README-EXAMPLE])
* `API reference` - Generated from the docstrings in your code; published on docs.microsoft.com. 
* `Code snippets` - Short code examples that demonstrate single (atomic) operations for the champion scenarios you've identified for your library; included in your README, docstrings, and Quickstart. 
* `Quickstart` - Article on docs.microsoft.com that is similar to but expands on the README content; typically written by your service's content developer. 
* `Conceptual` - Long-form documentation like Quickstarts, Tutorials, How-to guides, and other content on docs.microsoft.com; typically written by your service's content developer. 

## General guidelines

{% include requirement/MUST id="java-docs-content-dev" %} include your service's content developer in the architectural review for your library. To find the content developer you should work with, check with your team's Program Manager.

{% include requirement/MUST id="java-docs-contributors-guide" %} follow the [Azure SDK Contributors Guide] (MICROSOFT INTERNAL)

{% include requirement/MUST id="java-docs-style-guide" %} adhere to the Microsoft style guides when you write public-facing documentation. (MICROSOFT INTERNAL)

* [Microsoft Writing Style Guide]
* [Microsoft Cloud Style Guide]

Use the style guides for both long-form documentation like a README and the `docstrings` in your code.

{% include requirement/SHOULD id="java-docs-into-silence" %} attempt to document your library into silence. Preempt developers' usage questions and minimize GitHub issues by clearly explaining your API in the `docstrings`. Include information on service limits and errors they might hit, and how to avoid and recover from those errors.

As you write your code, doc it so you never hear about it again. The fewer questions you have to answer about your client library, the more time you have to build new features for your service.

{% include requirement/MUSTNOT id="java-docs-maven-versions" %} include version details when specifying Maven dependency statements. Always refer the user back to a central document detailing how to use the Azure SDK for Java BOM.

## Code samples

Code samples are small applications that demonstrate a certain feature that is relevant to the client library.  Samples allow developers to quickly understand the full usage requirements of your client library. Code samples shouldn't be any more complex than they needed to demonstrate the feature. Don't write full applications. Samples should have a high signal to noise ratio between useful code and boilerplate code for non-related reasons.

{% include requirement/MUST id="java-samples-include-them" %} include code samples alongside your library's code within the repository. The samples should clearly and succinctly demonstrate the code most developers need to write with your library. Include samples for all common operations.  Pay attention to operations that are complex or might be difficult for new users of your library. Include samples for the champion scenarios you've identified for the library.

{% include requirement/MUST id="java-samples-location" %} place code samples within the `/src/samples/java` directory within the client library root directory. The samples will be compiled, but not packaged into the resulting jar.

{% include requirement/MUST id="java-samples-main" %} ensure that each sample file is executable by including a `public static void main(String[] args)` method.

{% include requirement/MUST id="java-samples-coding-style" %} use the latest coding conventions when creating samples. Make liberal use of modern Java syntax and APIs (for example, diamond operators) as they remove boilerplate from your samples and highlight you library. Don't use any language feature or API of Java the currently supported Java baseline.  The current supported Java version is Java 8.

{% include requirement/MUST id="java-samples-use-latest-library" %} compile sample code using the latest major release of the library. Review sample code for freshness.  At least one commit must be made (to update dependencies) to each sample per semester.

{% include requirement/MUST id="java-samples-grafting" %} ensure that code samples can be easily grafted from the documentation into a users own application.  For example, don't rely on variable declarations in other samples.

{% include requirement/MUST id="java-samples-readability" %} write code samples for ease of reading and comprehension over code compactness and efficiency.

{% include requirement/MUST id="java-samples-platform-support" %} ensure that samples can run in Windows, macOS, and Linux development environments.  Don't use a non-standard developer toolchain.

{% include requirement/MUST id="java-samples-build-code" %} build and test your code samples using the repository's continuous integration (CI) to ensure they remain functional.

{% include requirement/MUSTNOT id="java-snippets-no-combinations" %} combine multiple operations in a code sample unless it's required for demonstrating the type or member. For example, a Cosmos DB code sample doesn't include both account and container creation operations.  Create a sample for account creation, and another sample for container creation.

Combined operations require knowledge of additional operations that might be outside their current focus. The developer must first understand the code surrounding the operation they're working on, and can't copy and paste the code sample into their project.

## JavaDoc

{% include requirement/MUST id="java-javadoc-build" %} ensure that anybody can clone the repo containing the client library and execute `mvn javadoc:javadoc` to generate the full and complete JavaDoc output for the code, without any need for additional processing steps.

{% include requirement/MUST id="java-javadoc-samples" %} include code samples in all class-level JavaDoc, and in relevant method-level JavaDoc.

{% include requirement/MUSTNOT id="java-javadoc-hard-coding" %} hard-code the sample within the JavaDoc (where it may become stale).  Follow the steps below to correctly ingest code samples from Java source files into the generated JavaDoc. 

Let's assume we want to insert code samples into the JavaDoc of a class named `ClientBuilder` in the `com.azure.clientlibrary` package, located within the `src/main/java` directory:

1. If it doesn't exist, create a source directory named `src/samples/java`.
2. Create a Java package with the same name as the package of the source class for which JavaDoc will be generated (for our example, `com.azure.clientlibrary`).
3. Create a class with the name `<SourceClass>JavaDocCodeSamples` (for example, `ClientBuilderJavaDocCodeSamples`)
4. Write code samples to insert into the generated JavaDoc of the source class.
5. Wrap the code samples with `BEGIN` and `END` comments. Don't use punctuation in the sample name.

```java
    // BEGIN: mysampletag1
    … your code sample here …
    // END: mysampletag1
```

6. Open the source class in `src/main/java`.  Edit the JavaDoc section:

```java
    /**
     * {@codesnippet mysampletag1}
     */
```

7. Generate the JavaDoc output with Maven.

```bash
mvn install -DskipTests -Dinclude-non-shipping-modules -Dgpg.skip=true -f pom.client.xml
```

{% include requirement/MUST id="java-javadoc-naming-samples" %} follow the naming convention outlined below for naming samples tags:

 * If a new instance of the class is created through build() method of a builder or through constructor: `<packagename>.<classname>.instantiation`
 * For other methods in the class: `<packagename>.<classname>.<methodName>`
 * For overloaded methods, or methods with arguments: `<packagename>.<classname>.<methodName>#<argType1>-<argType2>`
 * Camel casing for the method name and argument types is valid, but not required.

{% include refs.md %}
{% include_relative refs.md %}


