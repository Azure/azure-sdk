---
title: "Policies: Review Process"
permalink: policies_reviewprocess.html
folder: policies
sidebar: general_sidebar
---

## Introduction

The Azure SDK Architecture Board is a board of language architects specializing in Java, Python, TS/JS, C#, C, C++, Go, Rust, Android, and iOS.

We expect all Azure client libraries to pass rigorous SDK API reviews similar to those conducted for any other API produced by Microsoft (for example, the .NET APIs). In addition to detailed reviews of new libraries, **all changes** to an SDK API must be approved by an architect of the specific language before release.

Note that the library review process described here is currently an **internal** one. This document is intended to clarify the process for Azure service teams looking to have their libraries reviewed.

## SDK API review process roadmap

Typically, there will be a minimum of three meetings with the Architecture Board:

1.	Introductory session
2.	SDK API reviews
3.	SDK API approval


Depending on the library surface and other factors, more than one SDK API reviews may be needed.

It’s critical that library owners engage with the architecture board early enough to allow time for fixes and (sometimes significant) API redesign based on discussion. Depending on the nature and scope of the client library work being done, the sequence of events to follow when engaging with the architecture board will follow one of two paths:

1. **New libraries, large feature work, and/or pipeline changes**

    These changes should be discussed in an architecture board meeting at least three times. See “Types of review meetings and what to prepare” section below.


2. **Small, targeted changes and bug fixes**

    See “Getting approval for small, targeted changes and bug fixes” section below.

## Types of review meetings and what to prepare

There are two types of meetings that may be scheduled: Introduction and Follow-Up. 
For internal teams, use the [Scheduling Tool](https://aka.ms/azsdk/schedulesdkreview) to schedule review sessions. Select whether you are introducing a new service to the review board ("Introduction") or following up on a previous introduction, need an SDK API review or an SDK API approval ("Follow-Up"). Requirements for each type of meeting are detailed below.

### 1. Introductory Session

This purely informational/educational session is to let the Azure SDK Architecture board get up to speed with the service and the library/new features that are coming. This allows for early feedback and will potentially affect the service design. High level topics such as API namespaces, function names, and types will be suggested in this first discussion.

#### Prerequisites

| Title | Importance | Brief Description | Example and Support Documentation |
| --- | --- | --- | --- |
| Hero Scenarios | Must Have | Top scenarios on how service is consumed. | Guidelines on how to identify hero scenarios - [link](https://github.com/Azure/azure-sdk-pr/blob/24384df0202021ab86ee37fcb14e9554182cd014/training/azure-sdk-apis/principles/approachable/README.md#hero-scenarios)<br><br> [Examples](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/textanalytics/Azure.AI.TextAnalytics/samples/Sample1_DetectLanguage.md) |
| Core Concepts | Good to have | A glossary of nouns & verbs | [Example](https://github.com/Azure/azure-sdk-pr/blob/main/onboarding/Core_Concepts.pdf) |
| APIView | Good to have | APIView for the generated SDK | [Example](https://apiview.dev/Assemblies/Review/8b7f5312697a458ab9e65c2fd9cdc2dd)  |
| REST API Spec | Good to have | Link to the reviewed REST API Spec definition in [azure/azure-rest-api-specs-pr](https://github.com/azure/azure-rest-api-specs-pr) or [azure/azure-rest-api-specs](https://github.com/azure/azure-rest-api-specs) repo. | [Example](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/attestation/data-plane/Attestation/stable/2020-10-01/attestation.json) |

### 2. SDK API Review
During SDK API reviews, we look at sample code and detailed SDK API listings. You can see an example of such listing [here](https://github.com/Azure/azure-sdk/blob/main/docs/dotnet/APIListingExample.md).

Depending on the situation and service, more than one SDK API review may be needed (because there are major changes between API versions, for example). If that is the case, scheduler another meeting when the team is ready for another review.

**All SDK API languages must be approved before any stable release.** When there have been limited changes made to the SDK API since the previous review, *architects may choose to approve over email* without the need for a full meeting.

#### Prerequisites

| Title | Importance |Brief Description | Example and Support Documentation |
| --- | --- | --- | --- |
| APIView | Must Have | APIView for each SDK. Be sure to provide these at least **5 business days before** the review date.| [Example](https://apiview.dev/Assemblies/Review/8b7f5312697a458ab9e65c2fd9cdc2dd)  |
| Hero Scenarios | Good to have| Top scenarios on how service is consumed. Each scenario with the equivalent code sample. Note that samples can be added in APIView. | Guidelines on how to identify hero scenarios - [link](https://github.com/Azure/azure-sdk-pr/blob/24384df0202021ab86ee37fcb14e9554182cd014/training/azure-sdk-apis/principles/approachable/README.md#hero-scenarios)<br><br> [Examples](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/appconfiguration/Azure.Data.AppConfiguration#examples) |
| REST API Spec | Good to have | Link to the reviewed REST API spec definition in [azure/azure-rest-api-specs-pr](https://github.com/azure/azure-rest-api-specs-pr) or [azure/azure-rest-api-specs](https://github.com/azure/azure-rest-api-specs) repo. | [Example](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/attestation/data-plane/Attestation/stable/2020-10-01/attestation.json) |
| Core Concepts | Good to have | A glossary of nouns & verbs | [Example](https://github.com/Azure/azure-sdk-pr/blob/main/onboarding/Core_Concepts.pdf) |


**APIView Note**: If you have a pull request for your changes, then you can use the automatically generated [APIView](https://apiview.dev/) reviews from the pull request to discuss the APIs with the Architecture Board. If you do not have a pull request and have a prototype of your APIs, you can generate the API listing in the [APIView](https://apiview.dev/) tool as mentioned [here](https://github.com/Azure/azure-sdk-tools/blob/main/src/dotnet/APIView/APIViewWeb/README.md#how-to-create-an-api-review-manually). 

## What happens during review

### Who should be present?

The people familiar with the SDK APIs and service (usually the Engineering and/or PM Lead) should be present.

### Introductory sessions
The typical agenda starts with service team presenting the service for about 30 minutes. Then hero scenarios will be presented, each followed by discussions. This will take up majority of the time. If there are REST API Specs available, the Board will discuss them if time allows. And finally, there’ll be a short summary of action items to be done before the next review meeting.

### SDK API reviews

Language architects will have reviewed the SDK API Listings provided by the time of review. They’ll jump right into discussing the SDK API and samples provided. The meeting will end with a short summary of action items to be taken.

### SDK API approval

Typically, there’ll be some unsettled/controversial questions on the SDK API either from language architects who reviewed the SDK API or from the presenting team. Since the goal of this review is to approve the SDK API, the Board usually jumps right into discussing these questions. The review will end with a final approval of the SDK API or follow up items to get the SDK API to be approved.

### Required quorum

For an SDK API to be approved, the following conditions must be met at the Architecture Board meeting:

* Representatives from all Tier-1 languages (Java, Python, TS/JS, C#), and all languages under consideration must be present.
* A minimum of THREE architects from different language groups must be present.

If a language architect is *not* present at the meeting, a deputy architect can be the representative of that specific language instead. The list of language representatives can only be changed by the LT of the Azure SDK group.

## What happens after review

For introductory and SDK API review sessions, there will usually be a list of action items to take before the next meeting. Be sure to follow up on these items. Sometimes, one of these action items could be to schedule for another SDK API review once the architects' suggested changes have been made.

## Previewing SDK API changes

It is expected that SDK API changes are released in beta for a period of time before they are released as stable. This gives customers time to provide feedback which could result in adjustments to the SDK API before it moves to stable. SDK API changes that go straight to stable do not benefit from this feedback which can result in them being difficult for customers to use and for us to support. In most circumstances, SDK API changes going through either the full or abbreviated review process should be released as beta before a stable release.

## Getting approval for small, targeted changes and bug fixes

For small or targeted changes and bug fixes which modify SDK APIs, the architect in each language can review and approve without a combined/central review. We highly recommend doing this review as early as possible. This should be done on GitHub by opening an issue with links to [APIView](https://apiview.dev/) diffs. Include all architects as reviewers. In some cases it makes sense for small changes to the SDK API to be batched for efficiency. If a language architect determines there is a need for a deeper discussion, then a meeting with that architect should be scheduled. If it’s a cross-language discussion, then a board meeting should be scheduled.

Remember that **all** changes to an SDK API must be approved by the language architect before a stable release.

### Hero Scenarios

A hero scenario is a use case that the consumer of the client library is commonly expected to perform.  Hero scenarios are used to ensure the developer experience is exemplary for the common cases. You need to show the entire code sample (including error handling, as an example) for the hero scenarios. Please also show how the **authentication workflow** would look like for your library.

Good scenarios are technology agnostic (i.e. the customer can do the same thing in multiple ways), and are expected to be used by > 20% of users.

Examples of bad scenarios:
* Create a client (it's part of a scenario, and we'll see it often enough in true hero scenarios)
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

{% include refs.md %}
