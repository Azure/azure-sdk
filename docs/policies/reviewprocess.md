---
title: "Policies: Review Process"
permalink: policies_reviewprocess.html
folder: policies
sidebar: general_sidebar
---

We expect all Azure client libraries to pass rigorous API reviews similar to those conducted for any other API produced by Microsoft (for example, the .NET APIs).  In addition to detailed reviews of new libraries, **all changes** to an API must be approved by the language architect before release.

## Sequence of events

Depending on the nature and scope of the client library work being done, the sequence of events to follow when engaging with the architecture board will follow one of two paths.  If you are unsure which path applies to the work you are doing, you should consult with a language architect for guidance.

### 1 New libraries, large feature work, and/or pipeline changes

Our common goal is to create a great developer experience on Azure.  New libraries provide an opportunity to dramatically improve that experience by working closely with the architecture board.  Talking about designs in a group results in better APIs, facilitates mutual learning, and helps get everyone on the same page for what we consider a consistent design. The reviews are not a gate, but a fundamental process for designing good APIs.

It's critical that library owners engage with the architecture board early enough to allow time for fixes and (sometimes significant) API redesign based on discussion. New libraries and/or large feature work should be discussed in an architecture board meeting three times:

1. **Informational** - The first is purely informational/educational to enable the board to get up to speed with the library / new features that are coming.  This allows for early feedback and will potentially affect the service design.  High level topics such as API namespaces, function names, and types will be suggested in this first discussion.  See [What to prepare for the initial discussion](#what-to-prepare-for-the-initial-discussion) below.
2. **Review** - The second is to propose and review the overall API shape in the core languages (.NET, Java, Python, and TypeScript) with an eye towards consistency. Occasionally, questions arise in the review for one language that will impact the implementation in other languages as well.  For this reason, it is encouraged that all languages are scheduled for review in the same board meeting or in board meetings within a 7 day period.  Ideally these reviews happen before most of the coding work has been done to implement the APIs.  This review should be done before the first public beta.  See [API Listings](#api-listings) below.
3. **Signoff** - The third is a final API signoff.  All languages must be signed off before any are released as GA.  When there have been limited changes made to the API since the second review, architects may choose to sign off over email without the need for a full meeting.

See [Requesting a meeting with the board](#requesting-a-meeting-with-the-board) below for instructions on how to request one of these three meetings.

### 2 Small, targeted changes and bug fixes

For small or targeted changes and bug fixes which modify APIs, the architect in each language can review and sign off without a combined/central review. We highly recommend doing this review as early as possible. This should be done on GitHub by opening an issue with links to API diffs.  Include all architects as reviewers. In some cases it makes sense for small changes to the API to be batched for efficiency. If a language architect determines there is a need for a deeper discussion, then a meeting with that architect should be scheduled to have that conversation. If it’s a cross language discussion, then a board meeting should be scheduled.

Remember that **all changes** to an API must be approved by the language architect before release.

### Previewing API changes

It is expected that API changes are released in beta for a period of time before they are released as GA. This gives customers time to provide feedback which could result in adjustments to the API before it GAs. API changes that go straight to GA do not benefit from this feedback which can result in them being difficult for customers to use and for us to support. In most circumstances, API changes going through either the full or abbreviated review process should be released as beta before GA.

### Tracking API changes that need to be reviewed

While an API is in beta or after it is in GA, changes to APIs are not always obvious (to the developer or the reviewer) when they're being made so it's important that we identify them and review them to ensure the best SDK library experience for our customers. Long-term we will have tooling in place to detect API additions, changes, and breaks.  Until then, we will use the "APIChange" label on PRs to identify code changes that included a modification to an already released API.  This signals to that a language architect needs to review the change.  Once they've approved the change they would add the "ArchApproved" label.  Before release, a review of all changes merged into the library should be done to ensure that all "APIChange" labels are paired with an "ArchApproved" label.  Here is an [example query](https://github.com/Azure/azure-sdk-for-java/pulls?utf8=%E2%9C%93&q=is%3Apr+label%3AAPIChange+) for the Java libraries.

When the library developers indicate they're ready to release, these should be reviewed by the architect as part of final signoff before GA.  Libraries should not be released as GA (or updated to GA) if there are unresolved "APIChange" labels without a corresponding "ArchApproved" label.  Once final review is requested, all "APIChange" labels will be responded to within 5 working days.

## What to prepare for the initial discussion

For the initial discussion of a new library or large feature work, it is encouraged that the following things be proposed or provided by the owners of the client library:

1. Code samples added to the repo for key scenarios relevant to the target developer.  For introductory discussions, these samples do not need to be 'final' or 'perfect.'  They should be added to the library's sample folder ([example](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/textanalytics/Azure.AI.TextAnalytics/samples)). These must demonstrate the expected use of API functions which target developers would use regularly. ([example](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/textanalytics/Azure.AI.TextAnalytics/samples/Sample1_DetectLanguage.md)). It is expected that these samples are optimized for ensuring that succinct, intuitive, and productive developer experiences are possible for each scenario.
2. Link to the service documentation/specification.
3. Link to the service REST APIs, if applicable/available.

## Requesting a meeting with the board

To request a review:

1. [Submit an issue](https://github.com/Azure/azure-sdk/issues/new/choose) to the [Architecture Board].  If the service is pre-release and not yet publicly disclosed, use the private repository([azure-sdk-pr](https://github.com/Azure/azure-sdk-pr)).  After creating the issue, email the [Architecture Board](mailto:adparch@microsoft.com) to communicate specific requests such as scheduling, invite lists, etc.
    - Ensure you provide all information (or direct links to the information) for ease of review.
    - If this is an API review, ensure that API listings are published for review at least 5 working days before the meeting with the board, allowing time for reviews and comments.
    - If this is an API review, also prepare several code samples for review showing how the client library is meant to be used by customers. An example of a good set of usage samples can be found [here](https://github.com/dotnet/corefx/issues/32588).
2. A review with the entire board will be scheduled.
3. After the review is completed, the architecture board will publish recommendations.

## Approval Meeting Requirements

In order for an API to be approved, the following conditions must be met at the architectural board meeting:

- Representatives from all tier-1 languages, and all languages under consideration must be present at the meeting.
- A minimum of **TWO** architects from different language groups must be present at the meeting.

If a language architect is not present at the meeting, they must review and confirm the outcome of the meeting within 1 business day.  If the language architect is unavailable, the language area engineering lead within the Azure SDK group can approve instead.
The list of language representatives can only be changed by the LT of the Azure SDK group.

## API Listings

During API reviews, we look at API usage samples (as discussed above) and a detailed API listing.  You can see an example of such listing [here](https://github.com/Azure/azure-sdk/blob/master/docs/dotnet/APIListingExample.md).

If you have a prototype of your APIs, depending on the language the APIs are for, you can generate the API listing.

- For .NET, upload a DLL to the [ApiView tool](http://apiview.dev).
- For Java, upload the `*-sources.jar` file to the [ApiView tool](http://apiview.dev) (e.g. `azure-core-1.3.0-beta.1-sources.jar`).
- For TypeScript, use [API-Extractor](https://github.com/Microsoft/web-build-tools/wiki/API-Extractor) to produce a single file with your public API surface.  Submit the output of the API-Extractor as a PR for the [azure-sdk-for-js](http://github.com/azure/azure-sdk-for-js) repository.
- For Python, use [our custom API stub generator](https://github.com/Azure/azure-sdk-tools/tree/master/packages/python-packages/api-stub-generator#generate-stub-file) to produce a single file with your public API surface.  Upload the output of stubgen to the [ApiView tool](http://apiview.dev).

For all other languages, send a request to the [Architecture Board] to discuss the best format on individual basis.

{% include refs.md %}
