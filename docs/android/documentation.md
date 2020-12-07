---
title: "Android Guidelines: Documentation"
keywords: guidelines android
permalink: android_documentation.html
folder: android
sidebar: general_sidebar
---

{% include draft.html content="The Android guidelines are in DRAFT status" %}

There are several pieces of documentation that must be included with your client library. Beyond complete and helpful API documentation within the code itself (`JavaDoc`), you need a great README and other supporting documentation.

* `README.md` - Resides in the root of your library's directory within the SDK repository; includes package installation and client library usage information. ([example][README-EXAMPLE])
* `API reference` - Generated from the docstrings in your code; published on docs.microsoft.com. 
* `Code snippets` - Short code examples that demonstrate single (atomic) operations for the champion scenarios you've identified for your library; included in your README, docstrings, and Quickstart. 
* `Quickstart` - Article on docs.microsoft.com that is similar to but expands on the README content; typically written by your service's content developer. 
* `Conceptual` - Long-form documentation like Quickstarts, Tutorials, How-to guides, and other content on docs.microsoft.com; typically written by your service's content developer. 

## General guidelines

{% include requirement/MUST id="android-docs-content-dev" %} include your service's content developer in the architectural review for your library. To find the content developer you should work with, check with your team's Program Manager.

{% include requirement/MUST id="android-docs-contributors-guide" %} follow the [Azure SDK Contributors Guide] (MICROSOFT INTERNAL)

{% include requirement/MUST id="android-docs-style-guide" %} adhere to the Microsoft style guides when you write public-facing documentation. (MICROSOFT INTERNAL)

* [Microsoft Writing Style Guide]
* [Microsoft Cloud Style Guide]

Use the style guides for both long-form documentation like a README and the `docstrings` in your code.

{% include requirement/SHOULD id="android-docs-to-silence" %} attempt to document your library into silence. Preempt developers' usage questions and minimize GitHub issues by clearly explaining your API in the `docstrings`. Include information on service limits and errors they might hit, and how to avoid and recover from those errors.

As you write your code, doc it so you never hear about it again. The fewer questions you have to answer about your client library, the more time you have to build new features for your service.

{% include requirement/MUST id="android-docs-lang-support" %} document the library with samples and code snippets in both Kotlin and Java.

{% include requirement/MUST id="android-docs-package-managers" %} include both Gradle and Maven samples when specifying how to install the library.

{% include requirement/MUST id="android-docs-version-details" %} specify the latest version of a library when providing examples of Gradle or Maven dependency statements.

## Code samples

Code samples are small applications that demonstrate a certain feature that is relevant to the client library. Samples allow developers to quickly understand the full usage requirements of your client library. Code samples shouldn't be any more complex than they needed to demonstrate the feature. Don't write full applications. Samples should have a high signal to noise ratio between useful code and boilerplate code for non-related reasons.

{% include requirement/MUST id="android-samples-include-them" %} include code samples alongside your library's code within the repository. The samples should clearly and succinctly demonstrate the code most developers need to write with your library. Include samples for all common operations. Pay attention to operations that are complex or might be difficult for new users of your library. Include samples for the champion scenarios you've identified for the library.

{% include requirement/MUST id="android-samples-in-java" %} place Java code samples within the `/src/samples/java` directory within the client library root directory. The samples will be compiled, but not packaged into the resulting jar.

{% include requirement/MUST id="android-samples-in-kotlin" %} place Kotlin code samples within the `/src/samples/kotlin` directory within the client library root directory. 

{% include requirement/MUST id="android-samples-lang-support" %} write both a Java version and a Kotlin version when writing code samples.

{% include requirement/MUST id="android-samples-android-studio" %} ensure that each sample file is wrapped in an Android application that can be loaded and compiled by Android Studio.

{% include requirement/MUST id="android-samples-java-version" %} use the latest coding conventions when creating samples. Make liberal use of modern Java / Kotlin syntax (for example, diamond operators), APIs, and Android OS features, as they remove boilerplate from your samples and highlight your library.

{% include requirement/MUST id="android-samples-latest-major-library-version" %} compile sample code using the latest major release of the library. Review sample code for freshness. At least one commit must be made (to update dependencies) to each sample per semester.

{% include requirement/MUST id="android-samples-grafting" %} ensure that code samples are self-contained and can be easily grafted from the documentation into a user's application. For example, don't rely on variable declarations in other samples.

{% include requirement/MUST id="android-samples-comprehension" %} write code samples for ease of reading and comprehension over code compactness and efficiency.

{% include requirement/MUST id="android-samples-build-code" %} build and test your code samples using the repository's continuous integration (CI) to ensure they remain functional.

{% include requirement/MUSTNOT id="android-samples-no-combinations" %} combine multiple operations in a code snippet unless it's required for demonstrating the type or member. For example, a Cosmos DB code sample doesn't include both account and container creation operations. Create a sample for account creation, and another sample for container creation. You may combine multiple code snippets in the same sample, but ensure you can cut and paste just one operation.

Combined operations require knowledge of additional operations that might be outside their current focus. The developer must first understand the code surrounding the operation they're working on, and can't copy and paste the code sample into their project.

## JavaDoc

{% include requirement/MUST id="android-javadoc-production" %} ensure that anybody can clone the repo containing the client library and execute `./gradlew :dokkaHtmlMultiModule` to generate the full and complete JavaDoc output for the code, without any need for additional processing steps.

{% include requirement/MUST id="android-javadoc-include-samples" %} include code snippets in all class-level JavaDoc, and in relevant method-level JavaDoc.

{% include requirement/MUST id="android-samples-naming" %} follow the naming convention outlined below for naming snippets:

 * If a new instance of the class is created through build() method of a builder or through constructor: `<packagename>.<classname>.instantiation`
 * For other methods in the class: `<packagename>.<classname>.<methodName>`
 * For overloaded methods, or methods with arguments: `<packagename>.<classname>.<methodName>#<argType1>-<argType2>`

{% include refs.md %}
{% include_relative refs.md %}
