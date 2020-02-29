---
title: "Policies: Review Process"
permalink: policies_reviewprocess.html
folder: policies
sidebar: general_sidebar
---

We expect all Azure client libraries to pass rigorous API reviews similar to those conducted for any other API produced by Microsoft (for example, the .NET APIs).  In addition to detailed reviews of new libraries, **all changes** to an API must be approved by the language architect before release.

## Sequence of events
Depending on the nature and scope of the client library work being done, the sequence of events to follow when engaging with the architecture board will follow one of two paths.  If you are unsure which path applies to the work you are doing, you should consult with a langauge architect for guidance.

### 1 New libraries, large feature work, and/or core pipeline changes

Our common goal is to create a great developer experience on Azure.  New libraries provide an opportunty to dramatically improve that experience by working closely with the architecture board.  Talking about designs in a group results in better APIs, facilitates mutual learning, and helps get everyone on the same page for what we consider a consistent design. The reviews are not a gate, but a fundamental process for designing good APIs.

It's critical that library owners engage with the architecture board early enough to allow time for fixes and, sometimes significant API redesign based on discussion. New libraries and/or large feature work should be discussed in an architecture board meeting three times:

1. The first is purely informational/educational getting the board up to speed with the features that are coming.  This allows for early feedback and will potentially affect the service design.
2. The second is to propose and review the overall API shape in the core languages (.NET, Java, Python, and TypeScript) with an eye towards consistency and to work through any details that arose as part of implementation. Occasionally, questions arise in the review for one langauge that will impact the implementation in other languages as well.  For this reason, it is encouraged that all langauges are scheduled for review in the same board meeting or in back-to-back board meetings.  Ideally these reviews happen before most of the coding work has been done to implement the APIs.  This should be done before the first public preview.
3. The third is a final signoff.  All languages must be signed off before any are released as GA.  When there has been limited change to the API since the second review, architects may choose to sign off over email rather than requiring a full arch board meeting.

See [Requesting an API review with the board](#requesting-an-api-review-with-the-board) below for instructions on how to request one of these three reviews.

### 2 Small, targeted changes and bug fixes

For small or targeted changes and bug fixes which modify APIs, the architect in each language can review and sign off without a combined/central review. We highly recommend doing this review as early as possible. This should be done over email where possible with links to API diffs. In some cases it makes sense for small changes to the API to be batched for efficiency. If the language architect determines there is a need for a deeper discussion, then a meeting with that architect should be scheduled to have that conversation. If it’s a cross language discussion, then the entire board should be scheduled. 

Remember that **all changes** to an API must be approved by the language architect before release.

### Tracking API changes that need to be reviewed

Between releases, changes to APIs are not always obvious (to the developer or the reviewer) when they're being made so it's important that we identify them clearly and review them to ensure the best SDK library experience for our customers. Long-term we will have tooling in place to detect API additions, changes, and breaks.  Until then, we will use the "APIChange" label on PRs to identify code changes that included a modification to an already released API.  This signals to that a langauge architect needs to review the change.  Once they've approved the change they would add the "ArchApproved" label.  Before release, a review of all changes merged into the library should be done to ensure that all "APIChange" labels are pared with an "ArchApproved" label.  Here is an [example query](https://github.com/Azure/azure-sdk-for-java/pulls?utf8=%E2%9C%93&q=is%3Apr+label%3AAPIChange+) for the Java libraries.

### Previewing API changes

Because we are committed to never breaking APIs, it is expected that API changes are released in preview or RC (release candidate) for a period of time before they are released as GA.  This gives customers time to provide feedback which could result in adjustments to the API before it GAs.  In most circumstances, API changes going through either the full or abreviated review process should be previewed (or RC) before GA.

## How to Design Great Azure APIs

Make sure your client libraries follow [Azure SDK Design Guidelines][general-guidelines].  You can find language-specific guidance for [.NET][dotnet-guidelines], [Java][java-guidelines], [Python][python-guidelines], [TypeScript][typescript-guidelines], [Android][android-guidelines], [C][clang-guidelines], [C++][cpp-guidelines], [Go][golang-guidelines], and [iOS][ios-guidelines].

## What to Prepare for a Review

To conduct a review of a new library or large feature work, we need the following things from the owners of the client library:

1. Several code samples showing how the client library is meant to be used by customers. An example of a good set of usage samples can be found [here](https://github.com/dotnet/corefx/issues/32588).
2. A listing of 3-5 champion scenarios relevant to the developer. These must identify the critical scenarios that the majority of developers will experience. For each champion scenario, a link to a code sample in the repo must be provided. It is expected that these champion scenarios are optimized for, ensuring succinct, intuitive, and productive developer experiences are possible for each.
3. Listings of the APIs in each language. See below for example and tools to generate those.
4. Link to the service documentation/specification.
5. Link to the service REST APIs, if applicable/available.
6. If the client library is already prototyped, the proposed distribution (for example, DLL files for .NET, or JAR files for Java)
7. If the client library already GAed in the past, and this review is for additional APIs, the diff between the old API and new API.

## API Listings

During API reviews, we look at API usage samples (as discussed above) and a detailed API listing.  You can see an example of such listing [here](https://github.com/Azure/azure-sdk/blob/master/docs/dotnet/APIListingExample.md).

If you have a prototype of your APIs, depending on the language the APIs are for, you can possibly generate the API listing.

- For .NET, upload a DLL to the [ApiView tool](http://apiview.dev).
- For Java, upload a JAR to the [ApiView tool](http://apiview.dev).
- For TypeScript, use [API-Extractor](https://github.com/Microsoft/web-build-tools/wiki/API-Extractor) to produce a single file with your public API surface.  Submit the output of the API-Extractor as a PR for the [azure-sdk-for-js](http://github.com/azure/azure-sdk-for-js) repository.
- For Python, use [stubgen from mypy](https://github.com/python/mypy/blob/master/docs/source/stubgen.rst) to produce a single file with your public API surface.  Submit the output of stubgen as a PR for the [azure-sdk-for-python](http://github.com/azure/azure-sdk-for-python) repository.

For all other languages, send a request to the [Architecture Board] to discuss the best format on individual basis.

## Requesting an API review with the board

To request a review:

1. [Submit an issue](https://github.com/Azure/azure-sdk/issues/new/choose) to the [Architecture Board].  If the service is pre-release and not yet publicly disclosed, use the private repository([azure-sdk-pr](https://github.com/Azure/azure-sdk-pr)).  After creating the issue, email the [Architecture Board](mailto:adparch@microsoft.com) to communicate specific requests such as scheduling, invite lists, etc.
    - Ensure you provide all information (or direct links to the information) for ease of review.
2. A review with the entire review board will be scheduled.
3. After the review is completed, the architecture board will publish recommendations.

{% include refs.md %}
