---
title: "iOS Guidelines: Documentation"
keywords: guidelines ios
permalink: ios_documentation.html
folder: ios
sidebar: ios_sidebar
---

{% include draft.html content="The iOS guidelines are in DRAFT status" %}

There are several pieces of documentation that must be included with your client library. Beyond complete and helpful API documentation within the code itself, you need a great README and other supporting documentation.

* `README.md` - Resides in the root of your library's directory within the SDK repository; includes package installation and client library usage information. ([example][README-EXAMPLE])
* `API reference` - Generated from the docstrings in your code; published on docs.microsoft.com. 
* `Code snippets` - Short code examples that demonstrate single (atomic) operations for the champion scenarios you've identified for your library; included in your README, docstrings, and Quickstart. 
* `Quickstart` - Article on docs.microsoft.com that is similar to but expands on the README content; typically written by your service's content developer. 
* `Conceptual` - Long-form documentation like Quickstarts, Tutorials, How-to guides, and other content on docs.microsoft.com; typically written by your service's content developer. 

## General guidelines

{% include requirement/MUST id="ios-docs-content-dev" %} include your service's content developer in the architectural review for your library. To find the content developer you should work with, check with your team's Program Manager.

{% include requirement/MUST id="ios-docs-contributors-guide" %} follow the [Azure SDK Contributors Guide] (MICROSOFT INTERNAL)

{% include requirement/MUST id="ios-docs-style-guide" %} adhere to the Microsoft style guides when you write public-facing documentation. (MICROSOFT INTERNAL)

* [Microsoft Writing Style Guide]
* [Microsoft Cloud Style Guide]

Use the style guides for both long-form documentation like a README and the `docstrings` in your code.

{% include requirement/SHOULD id="ios-docs-to-silence" %} attempt to document your library into silence. Preempt developers' usage questions and minimize GitHub issues by clearly explaining your API in the `docstrings`. Include information on service limits and errors they might hit, and how to avoid and recover from those errors.

As you write your code, doc it so you never hear about it again. The fewer questions you have to answer about your client library, the more time you have to build new features for your service.

{% include requirement/MUST id="ios-docs-lang-support" %} document the library with samples and code snippets in Swift.

{% include requirement/SHOULD id="ios-docs-lang-objc-support" %} document the library with samples and code snippets in Objective-C.

## Code samples

Code samples are small applications that demonstrate a certain feature that is relevant to the client library.  Samples allow developers to quickly understand the full usage requirements of your client library. Code samples shouldn't be any more complex than they needed to demonstrate the feature. Don't write full applications. Samples should have a high signal to noise ratio between useful code and boilerplate code for non-related reasons.

{% include requirement/MUST id="ios-samples-include-them" %} include code samples alongside your library's code within the repository. The samples should clearly and succinctly demonstrate the code most developers need to write with your library. Include samples for all common operations.  Pay attention to operations that are complex or might be difficult for new users of your library. Include samples for the champion scenarios you've identified for the library.

{% include requirement/MUST id="ios-samples-in-swift" %} place Swift code samples within the `/src/samples/swift` directory within the client library root directory.

{% include requirement/MUST id="ios-samples-in-objc" %} place Objective-C code samples within the `/src/samples/objc` directory within the client library root directory.

{% include requirement/MUST id="ios-samples-lang-support" %} write a Swift version when writing code samples.  

{% include requirement/SHOULD id="ios-samples-objc-support" %} write an Objective-C version when writing code samples.  

If you write Objective-C samples, ensure **ALL** samples are duplicated in both Objective-C and Swift. 

{% include requirement/MUST id="ios-samples-xcode" %} ensure that each sample file is wrapped in an iOS application that can be loaded and compiled by XCode.

{% include requirement/MUST id="ios-samples-swift-version" %} use the latest coding conventions when creating samples. Make liberal use of modern Swift syntax and APIs as they remove boilerplate from your samples and highlight your library.

{% include requirement/MUST id="ios-samples-api-version" %} ensure that samples can be run on the latest iOS devices and the latest iOS simulators. 

{% include requirement/MUST id="ios-samples-latest-major-library-version" %} compile sample code using the latest major release of the library. Review sample code for freshness.  At least one commit must be made (to update dependencies) to each sample per semester.

{% include requirement/MUST id="ios-samples-grafting" %} ensure that code samples can be easily grafted from the documentation into a users own application.  For example, don't rely on variable declarations in other samples.

{% include requirement/MUST id="ios-samples-comprehension" %} write code samples for ease of reading and comprehension over code compactness and efficiency.

{% include requirement/MUST id="ios-samples-build" %} build and test your code samples using the repository's continuous integration (CI) to ensure they remain functional.

{% include requirement/MUSTNOT id="ios-samples-no-combinations" %} combine multiple operations in a code snippet unless it's required for demonstrating the type or member. For example, a Cosmos DB code sample doesn't include both database and container creation operations.  Create a sample for database creation, and another sample for container creation.  You may combine multiple code snippets in the same sample, but ensure you can cut and paste just one operation.

Combined operations require knowledge of additional operations that might be outside their current focus. The developer must first understand the code surrounding the operation they're working on, and can't copy and paste the code sample into their project.

## Swift docstrings

{% include requirement/MUST id="ios-swift-docstrings" %} write docstrings in [XCode Markup](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_markup_formatting_ref/).  The code can then be post-processed to extract the docstrings for generating API reference documentation.

{% include requirement/MUST id="ios-swift-build-apiref" %} ensure that anybody can clone the repo containing the client library and execute `jazzy` to generate the full and complete API reference output for the code, without any need for additional processing steps.

Add the following `.jazzy.yaml` file to the project:

```
output: docs
clean: true
xcodebuild_argument:
- -workspace
- YourWorkspaceName.xcworkspace
- -scheme
- YourSchemeName
- CODE_SIGNING_ALLOWED = NO
author: Microsoft, Inc.
module: Folder_Name_where_all_code_resides
module_version: 1.0
copyright: Copyright (C) 2019 Microsoft, Inc.
min_acl: internal
theme: apple
```

Replace the `YourWorkspaceName`, `YourSchemeName`, and `Folder_Name_where_all_code_resides` appropriately for the project.

{% include refs.md %}
{% include_relative refs.md %}

