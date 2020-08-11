---
title: "Policies: Review Process"
permalink: policies_reviewprocess.html
folder: policies
sidebar: general_sidebar
---

## Introduction
The Azure DevEx Architecture Review Board is a board of language architects specializing in Java, Python, TS/JS, C#, C, and Go in addition to language specific platforms like .Net, Andriod, and IOS. 

**The Architecture Board reviews Track 2 libraries only**. By definition, a Track 2 library is one that follows our [Track 2 library design guidelines and specific language guidelines](https://azure.github.io/azure-sdk/general_introduction.html). This means that libraries produced solely by a code generator do NOT follow these guidelines; engineers MUST build a layer on top of the generated code in order to produce a library that meets the guidelines.  

We expect all Azure client libraries to pass rigorous API reviews similar to those conducted for any other API produced by Microsoft (for example, the .NET APIs). In addition to detailed reviews of new libraries, **all changes** to an API must be approved by an architect of the specific language before release.


## API Review Process Roadmap

Typically, there will be a minimum of three meetings with the Architecture Board: 

1.	Introductory session 
2.	API reviews 
3.	API Sign Off 

Depending on the library surface and other factors, more than one API reviews may be needed.  

After the API is signed off and ready to be released, library owners will need to create an issue using the issue template “Record of Architecture Board Approval for Release.” The release manager will ask for a link to this issue as part of the PLR. 


It’s critical that library owners engage with the architecture board early enough to allow time for fixes and (sometimes significant) API redesign based on discussion. Depending on the nature and scope of the client library work being done, the sequence of events to follow when engaging with the architecture board will follow one of two paths:

1. **New libraries, large feature work, and/or pipeline changes**

    These changes should be discussed in an architecture board meeting at least three times. See “Types of Review Meetings and What to Prepare” section below.

2. **Small, targeted changes and bug fixes**

    See “Getting approval for small, targeted changes and bug fixes” section below.

If you are unsure which path applies to the work you are doing, you should consult with a language architect for guidance.


## Types of Meetings and What to Prepare 

[Submit an issue](https://github.com/Azure/azure-sdk/issues/new/choose) to the Architecture Board to request for a meeting. If the service is pre-release and not yet publicly disclosed, use the private repository ([azure-sdk-pr](https://github.com/Azure/azure-sdk-pr)). After creating the issue, email the Architecture Board to communicate specific requests such as scheduling, invite lists, etc.

Depending on the type of review, use the appropriate template to create the issue. Ensure that you included everything the issue template asks for and in the correct format. 

### 1. Introductory Session 

This purely informational/educational to enable the board to get up to speed with the service and the library/new features that are coming. This allows for early feedback and will potentially affect the service design. High level topics such as API namespaces, function names, and types will be suggested in this first discussion. 

**What to bring (include the following in GitHub issue requesting for review)**: 
* Service introduction material
    * Link to documentation introducing/describing the service
    * Some teams also prepare a PowerPoint introductions 
* Link to the service REST APIs, if applicable/available.
* Champion scenarios samples
    * See “Champion scenarios” section below for definition and examples
    * [Sample example](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/textanalytics/Azure.AI.TextAnalytics/samples/Sample1_DetectLanguage.md)
        * Need not be “final” or “perfect”
        * Should be added to library’s sample folder ([example](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/textanalytics/Azure.AI.TextAnalytics/samples))
* How-To Guide (Option 2)
  * See "How-To Guide" section below

### 2. API Review
During API reviews, we look at API usage samples and a detailed API listing. You can see an example of such listing [here](https://github.com/Azure/azure-sdk/blob/master/docs/dotnet/APIListingExample.md).

If you have a prototype of your APIs, depending on the language the APIs are for, you can generate the API listing.

* For .NET, upload a DLL to the [ApiView](http://apiview.dev/) tool.
* For Java, upload the `*-sources.jar` file to the [ApiView](http://apiview.dev/) tool (e.g. `azure-core-1.3.0-beta.1-sources.jar`).
* For TypeScript, use API-Extractor to produce a single file with your public API surface. Submit the output of the [API-Extractor](https://github.com/Microsoft/web-build-tools/wiki/API-Extractor) as a PR for the [azure-sdk-for-js](http://github.com/azure/azure-sdk-for-js) repository.
* For Python, use our [custom API stub generator](https://github.com/Azure/azure-sdk-tools/tree/master/packages/python-packages/api-stub-generator#generate-stub-file) to produce a single file with your public API surface. Upload the output of stubgen to the [ApiView](http://apiview.dev/) tool.

For all other languages, send a request to the Architecture Board to discuss the best format on individual basis.

Depending on the situation and service, more than one API reviews may be needed (because there are major changes between API versions, for example). If that is the case, file another issue when the team is ready for another review.  

**What to bring (include the following in GitHub issue requesting for review):**
* Links to the API Listings for each language 
  * Be sure to provide these at least **5 business days before** the intended review date so architects have time to review before the meeting
* Code samples for each champion scenario 
* How-To guide (Option 2)

### 3. API Sign Off

The goal of the API sign-off meeting is to resolve any controversial/unsettled questions about the API. These questions can come from language architects or service teams. 

**All languages must be signed off before any are released as GA.** When there have been limited changes made to the API since the second review, *architects may choose to sign off over email* without the need for a full meeting.

**What to bring (include the following in GitHub issue requesting for review):**
* Links to API Listings for each language
* Prepare to talk about unresolved questions about API
  
### Champion Scenarios

A champion scenario is a use case that the consumer of the client library is commonly expected to perform.  Champion scenarios are used to ensure the developer experience is exemplary for the common cases.  You need to show the entire code sample (including error handling, as an example) for the champion scenarios.

Examples of good scenarios are technology agnostic (i.e. the customer can do the same thing in multiple ways), and are expected to be used by > 20% of users:
* Upload a file
* Update firmware on the device
* Recognize faces in an uploaded image

Examples of bad scenarios:
* Create a client (it's part of a scenario, and we'll see it often enough in true champion scenarios)
* Send a batch of events (again, part of the scenario)
* Create a page blob (it's not used by enough of the user base)

### How-To Guides

Samples demonstrating common how-tos: 

* Create a new resource
* Read the resource
* Modify the resource
* Delete the resource
* Authentication
* Error handling 
* Handling race conditions/concurrency issues


Considering the following questions would help guide some the of library design decisions, because ultimately the library should be easy to use for common scenarios that developers want:

1. What is the app the developer is building that uses your client library?
2. Who is the end-user of the application (the developer's customer)
3. What features of the API need to be explained in the sample so that someone could use this API in a real app?



## What Happens During Review

### Who should be present? 

The person/people familiar with the material to be presented, usually the Engineering or PM Lead, should be present in the meeting.

### Introductory sessions
The typical agenda starts with service team presenting the service for about 30 minutes. Then champion scenarios will be presented, each followed by discussions. This will take up majority of the time. If there are Rest APIs available, the Board will discuss them if time allows. And finally, there’ll be a short summary of action items to be done before the next review meeting. 

### API Reviews

Language architects will have reviewed the API Listings provided by the time of the review. They’ll jump right into discussing the API and samples provided. The meeting will end with a short summary of action items to be taken. 

### API Sign Off 

Typically, there’ll be some unsettled/controversial questions on the API either from language architects who reviewed the API or from the presenting team. Since the goal of this review is to approve the API, the Board usually jumps right into discussing these questions. The review will end of a final approval of the API or follow up items to get the API to be approved. 

For an API to be approved, the following conditions must be met at the Architecture Board meeting:

* Representatives from all Tier-1 languages (Java, Python, TS/JS, C#), and all languages under consideration must be present at the meeting.
* A minimum of THREE architects from different language groups must be present at the meeting.
  
If a language architect is *not* present at the meeting, they must review and confirm the outcome of the meeting within 1 business day. If the language architect is unavailable, the language area engineering lead within the Azure SDK group can approve instead. The list of language representatives can only be changed by the LT of the Azure SDK group.


## What Happens After Review

For introductory and API review sessions, there will usually be a list of action items to take before the next meeting. Be sure to follow up on these items. Sometimes, one of these action items could be to schedule for another API review once the architects suggested changes have been made. 

If after an API Sign Off session the Architecture Board approves the release of the API, the SDK Team will add the comment “APPROVED FOR RELEASE” to the issue requesting for the Sign Off review. The service team will need to create an issue using the template “Record of Architecture Board Approval for Release” to indicate that the library has gone through all the required reviews for release. The release manager will ask for a link to this GitHub issue for confirmation. 



## Tracking API Changes That Need to be Reviewed
While an API is in preview or after it is in GA, changes to APIs are not always obvious (to the developer or the reviewer) when they’re being made so it’s important that we identify them and review them to ensure the best SDK library experience for our customers. Long-term we will have tooling in place to detect API additions, changes, and breaks. Until then, we will use the “APIChange” label on PRs to identify code changes that included a modification to an already released API. This signals to that a language architect needs to review the change. Once they’ve approved the change they would add the “ArchApproved” label. Before release, a review of all changes merged into the library should be done to ensure that all “APIChange” labels are paired with an “ArchApproved” label. Here is an [example query](https://github.com/Azure/azure-sdk-for-java/pulls?utf8=%E2%9C%93&q=is%3Apr+label%3AAPIChange+) for the Java libraries.

When the library developers indicate they’re ready to release, these should be reviewed by the architect as part of final signoff before GA. Libraries should not be released as GA (or updated to GA) if there are unresolved “APIChange” labels without a corresponding “ArchApproved” label. Once final review is requested, all “APIChange” labels will be responded to within 5 working days.


{% include refs.md %}
