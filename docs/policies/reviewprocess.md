---
title: "Policies: Review Process"
permalink: policies_reviewprocess.html
folder: policies
sidebar: general_sidebar
---

## Overview

The Azure SDK Architecture Board reviews Azure data plane (client plane) SDKs to ensure they are developer-friendly, consistent across all supported languages, and follow Azure SDK design guidelines. The goal is to provide a world-class developer experience for all Azure services.

> **Note:** Management Plane (ARM) libraries do NOT require an Architecture Board review.

All Azure data plane SDKs must be reviewed by the Architecture Board prior to release. The review process is normally conducted asynchronously via email and APIView comments. Synchronous meetings are only scheduled when async review is insufficient for complex cross-language issues.

Note that the library review process described here is currently an **internal** one. This document is intended to clarify the process for Azure service teams looking to have their libraries reviewed.

## Find your scenario

Depending on where you are in your SDK development journey, you'll need to engage with the Architecture Board in different ways:

🆕 **New to the Architecture Board?** → **Service Introduction Meeting**  
If your team has never had an SDK Architecture Review before, you must start here. This one-time meeting introduces your service to the Architecture Board and establishes the foundation for all future SDK reviews. *When to schedule: Before you request your first Beta SDK Review.*

📦 **Ready to release your first Beta (Preview) SDK?** → **Beta (Preview) Review**  
Request a Beta review when you're preparing to release the first preview version of your SDK for one or more languages. *Important: You only need to request a Beta review for your first beta release. Subsequent beta releases do not require an Architecture Board review.*

🚀 **Ready to release a Stable (GA) SDK?** → **Stable (GA) Review**  
Request a Stable review when you're preparing to release a GA version of your SDK across all Tier 1 languages.

## Service Introduction meeting

**Purpose:** Introduce service, establish relationships, agree on library names, identify design challenges early  
**What to prepare:**
- Service overview and target scenarios
- Proposed library names
- API approach (link to TypeSpec project)
- Timeline and questions

**How to schedule:** Email azsdkarch-help@microsoft.com with subject "[Service Name] Service Introduction Meeting Request"

**What to expect:** 30-60 minute meeting to discuss prepared materials, align on library names, and receive guidance on next steps.

## Beta (Preview) Review

This is required for your first Beta SDK release. You do not need Architecture Board review for subsequent beta versions.

**Requirements:**
- Completed your Service Introduction meeting
- API specifications are finalized
- At least one SDK language is ready for review
- CI quality gates are passing for all libraries in the review

**What's reviewed:** Library API design and code samples demonstrating hero scenarios

**Required materials:**
- APIView links with code samples attached
- Pull Request links
- API spec directory (with client.tsp)
- Changelog/known gaps
- README links
- Language coverage note (optional)

**How to request:** Email azsdkarch-help@microsoft.com with subject "[Service Name] [Beta Preview] Azure SDK Review" — include all materials listed above.

**What to expect:**
1. **Material verification** (1-2 business days) — Operations/PM reviews materials, verifies CI, flags elevation needs
2. **Async architect review** (1 week for initial feedback) — Language architects review and comment in [APIView](https://apiview.org)
3. **Iteration** — Service team responds to feedback in APIView threads
4. **Approval** — When all conversations are closed and APIViews approved

First feedback typically within 1 week; completion within 2-3 weeks.

**Reviews may be elevated to sync meetings for:** cross-language issues, major structural/breaking changes, strategic services, or large volume of changes.

## Stable (GA) Review

This is required before releasing any SDK to GA.

**Requirements:**
- Completed and received approval from your Beta SDK Review
- All feedback from beta review has been addressed
- All Tier 1 languages (.NET, Java, JavaScript/TypeScript, Python) are ready
- CI quality gates are passing for all languages

**What's reviewed:** The API Views for all libraries, cross-language consistency, samples, documentation, and parity across all Tier 1 languages

**Required materials:**
- APIView links for all Tier 1 languages
- Code samples
- API spec directory
- Originating PRs
- README links

**How to request:** Email azsdkarch-help@microsoft.com with subject "[Service Name] [Stable/GA] Azure SDK Review"

**What to expect:** Same async flow as Beta review. Reviews may be elevated for unresolved beta feedback, cross-language issues, or strategic/complex libraries.

## Async review workflow

1. **Service team submits review request** — Email with required materials
2. **Material verification** — ArchBoard Operations/PM reviews, verifies CI, flags elevation needs
3. **Async architect review** — APIView comments for language-specific feedback, email for cross-language issues
4. **Elevation if needed** — 1-hour meeting if required, with decisions recorded in async thread
5. **Closure** — Feedback addressed, review closed, confirmation to proceed

## Previewing SDK API changes

It is expected that SDK API changes are released in beta for a period of time before they are released as stable. This gives customers time to provide feedback which could result in adjustments to the SDK API before it moves to stable. SDK API changes that go straight to stable do not benefit from this feedback which can result in them being difficult for customers to use and for us to support. In most circumstances, SDK API changes going through either the full or abbreviated review process should be released as beta before a stable release.

## Getting approval for small, targeted changes and bug fixes

For small or targeted changes and bug fixes which modify SDK APIs, the architect in each language can review and approve without a combined/central review. We highly recommend doing this review as early as possible. This should be done on GitHub by opening an issue with links to [APIView](https://apiview.org) diffs. Include all architects as reviewers. In some cases it makes sense for small changes to the SDK API to be batched for efficiency. If a language architect determines there is a need for a deeper discussion, then a meeting with that architect should be scheduled. If it's a cross-language discussion, then a board meeting should be scheduled.

Remember that **all** changes to an SDK API must be approved by the language architect before a stable release.

## Additional resources

- Azure SDK Guidelines: https://azure.github.io/azure-sdk/
- APIView: https://apiview.org

### Contact

Email: azsdkarch-help@microsoft.com

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
