---
title: "Policies: Review Process"
permalink: policies_reviewprocess.html
folder: policies
sidebar: general_sidebar
---

## Introduction

The Azure Developer Platform (ADP) Architecture Review Board is a board of language architects specializing in Java, Python, TS/JS, C#, C, C++, Go, Android, and iOS.

**The Architecture Board reviews Track 2 libraries only**. By definition, a Track 2 library is one that follows our [Track 2 library design guidelines and specific language guidelines](https://azure.github.io/azure-sdk/general_introduction.html). This means that libraries produced solely by a code generator do NOT follow these guidelines; engineers MUST build a layer on top of the generated code in order to produce a library that meets the guidelines. We have developed the SDK Development Training program to help you be successful in building these libraries - find out more [here!](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/346/Azure-SDK-Development-Training)

We expect all Azure client libraries to pass rigorous API reviews similar to those conducted for any other API produced by Microsoft (for example, the .NET APIs). In addition to detailed reviews of new libraries, **all changes** to an API must be approved by an architect of the specific language before release.

Note that the library review process described here is currently an **internal** one. This document is intended to clarify the process for Azure service teams looking to have their libraries reviewed.

## API Review Process Roadmap

Typically, there will be a minimum of three meetings with the Architecture Board:

1.	Introductory session
2.	API reviews
3.	API Sign Off


Depending on the library surface and other factors, more than one API reviews may be needed.

Create an epic using the “Record of Architecture Board Approval for Release” issue template to track reviews and approvals. The release manager will ask for a link to this issue as part of the PLR.

It’s critical that library owners engage with the architecture board early enough to allow time for fixes and (sometimes significant) API redesign based on discussion. Depending on the nature and scope of the client library work being done, the sequence of events to follow when engaging with the architecture board will follow one of two paths:

1. **New libraries, large feature work, and/or pipeline changes**

    These changes should be discussed in an architecture board meeting at least three times. See “Types of Review Meetings and What to Prepare” section below.


2. **Small, targeted changes and bug fixes**

    See “Getting approval for small, targeted changes and bug fixes” section below.

If you are unsure which path applies to the work you are doing, you should consult with a language architect for guidance.


## Types of Review Meetings and What to Prepare

[Submit an issue](https://github.com/Azure/azure-sdk/issues/new/choose) to the Architecture Board to request for a meeting. If the service is pre-release and not yet publicly disclosed, use the private repository ([azure-sdk-pr](https://github.com/Azure/azure-sdk-pr)). After creating the issue, email the [Architecture Board](mailto:adparch@microsoft.com) to communicate specific requests such as scheduling, invite lists, etc.

Depending on the type of review, use the appropriate template to create the issue. Ensure that you included everything the issue template asks for and in the correct format.

### 1. Introductory Session

This purely informational/educational to let the board get up to speed with the service and the library/new features that are coming. This allows for early feedback and will potentially affect the service design. High level topics such as API namespaces, function names, and types will be suggested in this first discussion.

**What to bring (include the following in GitHub issue requesting for review)**:
* Service introduction material
    * Link to documentation introducing/describing the service
    * Some teams also prepare a PowerPoint introductions
* Link to the service REST APIs, if applicable/available.
* Champion scenario samples
    * Code is appreciated but optional. Pseudocode is fine.
    * See “Champion scenarios” section below for definition
    * [Sample example](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/textanalytics/Azure.AI.TextAnalytics/samples/Sample1_DetectLanguage.md)
        * Should be added to library’s sample folder ([example](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/textanalytics/Azure.AI.TextAnalytics/samples))
* Quickstart samples
  * Optional for introductory meeting
  * See "Quickstart Samples" section below

### 2. API Review
During API reviews, we look at sample code and detailed API listings. You can see an example of such listing [here](https://github.com/Azure/azure-sdk/blob/main/docs/dotnet/APIListingExample.md).

If you have a prototype of your APIs, you can generate the API listing:

* For .NET, upload a DLL to the [ApiView](http://apiview.dev/) tool.
* For Java, upload the `*-sources.jar` file to the [ApiView](http://apiview.dev/) tool (e.g. `azure-core-1.3.0-beta.1-sources.jar`).
* For Python, use our [custom API stub generator](https://github.com/Azure/azure-sdk-tools/tree/main/packages/python-packages/api-stub-generator#generate-stub-file) to produce a single file with your public API surface. Upload the output of stubgen to the [ApiView](http://apiview.dev/) tool.
* For TypeScript, use [api-extractor](https://api-extractor.com/pages/setup/generating_docs/) to generate your `api.json/docModel` file and then upload to [APIView](https://apiview.dev/).

For all other languages, send a request to the Architecture Board to discuss the best format on individual basis.

- For .NET, upload a DLL to the [ApiView tool](http://apiview.dev).
- For Java, upload the `*-sources.jar` file to the [ApiView tool](http://apiview.dev) (e.g. `azure-core-1.3.0-beta.1-sources.jar`).
- For TypeScript, use [API-Extractor](https://github.com/Microsoft/web-build-tools/wiki/API-Extractor) to generate a docModel file. Upload generated api.json file to the [ApiView tool](http://apiview.dev).
- For Python, upload a wheel to the [ApiView tool](http://apiview.dev) ( e.g. azure_core-1.8.0-py2.py3-none-any.whl). Python wheel can be generated by executing following command at package root directory.
  `python setup.py bdist_wheel -d <dest_folder>'
Depending on the situation and service, more than one API review may be needed (because there are major changes between API versions, for example). If that is the case, file another issue when the team is ready for another review.

**What to bring (include the following in GitHub issue requesting for review):**
* Links to the API Listings for each language reviewed
  * Be sure to provide these at least **5 business days before** the intended review date so architects have time to review before the meeting
* Code samples for each champion scenario
* Quickstart samples

### 3. API Sign Off

The goal of the API sign-off meeting is to resolve any controversial/unsettled questions about the API. These questions can come from language architects or service teams.

**All languages must be signed off before any are released as GA.** When there have been limited changes made to the API since the second review, *architects may choose to sign off over email* without the need for a full meeting.

**What to bring (include the following in GitHub issue requesting for review):**
* Links to API Listings for each language
* Prepare to talk about unresolved questions about API

### Champion Scenarios

A champion scenario is a use case that the consumer of the client library is commonly expected to perform.  Champion scenarios are used to ensure the developer experience is exemplary for the common cases. You need to show the entire code sample (including error handling, as an example) for the champion scenarios. Please also show how the **authentication workflow** would look like for your library.

Good scenarios are technology agnostic (i.e. the customer can do the same thing in multiple ways), and are expected to be used by > 20% of users.

Examples of bad scenarios:
* Create a client (it's part of a scenario, and we'll see it often enough in true champion scenarios)
* Send a batch of events (again, part of the scenario)
* Create a page blob (it's not used by enough of the user base)

### Quickstart Samples

Samples demonstrating common how-tos:

* Create a new resource
* Read the resource
* Modify the resource
* Delete the resource
* Error handling
* Handling race conditions/concurrency issues

## What Happens During Review

### Who should be present?

The people familiar with the APIs and service (usually the Engineering and/or PM Lead) should be present.

### Introductory sessions
The typical agenda starts with service team presenting the service for about 30 minutes. Then champion scenarios will be presented, each followed by discussions. This will take up majority of the time. If there are Rest APIs available, the Board will discuss them if time allows. And finally, there’ll be a short summary of action items to be done before the next review meeting.

### API Reviews

Language architects will have reviewed the API Listings provided by the time of review. They’ll jump right into discussing the API and samples provided. The meeting will end with a short summary of action items to be taken.

### API Sign Off

Typically, there’ll be some unsettled/controversial questions on the API either from language architects who reviewed the API or from the presenting team. Since the goal of this review is to approve the API, the Board usually jumps right into discussing these questions. The review will end with a final approval of the API or follow up items to get the API to be approved.

### Required Quorum

For an API to be approved, the following conditions must be met at the Architecture Board meeting:

* Representatives from all Tier-1 languages (Java, Python, TS/JS, C#), and all languages under consideration must be present.
* A minimum of THREE architects from different language groups must be present.

If a language architect is *not* present at the meeting, a deputy architect can be the representative of that specific language instead. The list of language representatives can only be changed by the LT of the Azure SDK group.


## What Happens After Review

For introductory and API review sessions, there will usually be a list of action items to take before the next meeting. Be sure to follow up on these items. Sometimes, one of these action items could be to schedule for another API review once the architects' suggested changes have been made.

Remember to create an epic using the issue template “Record of Architecture Board Approval for Release” to keep track of API reviews and approvals.

If after an API Sign Off session the Architecture Board approves the release, the SDK Team will add the comment “APPROVED FOR RELEASE” to the issue requesting for the Sign Off review. Remember to add the issue's link to the record of approval epic!

## Previewing API Changes

It is expected that API changes are released in beta for a period of time before they are released as GA. This gives customers time to provide feedback which could result in adjustments to the API before it GAs. API changes that go straight to GA do not benefit from this feedback which can result in them being difficult for customers to use and for us to support. In most circumstances, API changes going through either the full or abbreviated review process should be released as beta before GA.

## Getting Approval for Small, Targeted Changes and Bug Fixes

For small or targeted changes and bug fixes which modify APIs, the architect in each language can review and sign off without a combined/central review. We highly recommend doing this review as early as possible. This should be done on GitHub by opening an issue with links to API diffs. Include all architects as reviewers. In some cases it makes sense for small changes to the API to be batched for efficiency. If a language architect determines there is a need for a deeper discussion, then a meeting with that architect should be scheduled. If it’s a cross-language discussion, then a board meeting should be scheduled.

Remember that **all** changes to an API must be approved by the language architect before release.

## Tracking API Changes That Need to be Reviewed
While an API is in preview or after it is in GA, changes to APIs are not always obvious (to the developer or the reviewer) when they’re being made so it’s important that we identify them and review them to ensure the best SDK library experience for our customers. Long-term we will have tooling in place to detect API additions, changes, and breaks. Until then, we will use the “APIChange” label on PRs to identify code changes that included a modification to an already released API. This signals to that a language architect needs to review the change. Once they’ve approved the change they would add the “ArchApproved” label. Before release, a review of all changes merged into the library should be done to ensure that all “APIChange” labels are paired with an “ArchApproved” label. Here is an [example query](https://github.com/Azure/azure-sdk-for-java/pulls?utf8=%E2%9C%93&q=is%3Apr+label%3AAPIChange+) for the Java libraries.

When the library developers indicate they’re ready to release, these should be reviewed by the architect as part of final signoff before GA. Libraries should not be released as GA (or updated to GA) if there are unresolved “APIChange” labels without a corresponding “ArchApproved” label. Once final review is requested, all “APIChange” labels will be responded to within 5 working days.

{% include refs.md %}
