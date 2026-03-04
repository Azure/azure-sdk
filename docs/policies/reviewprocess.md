---
title: "Policies: Review Process"
permalink: policies_reviewprocess.html
folder: policies
sidebar: general_sidebar
---

## Overview

The Azure SDK Architecture Board reviews Azure **data plane** (client) SDKs to ensure they are developer-friendly, consistent across languages, and follow the [Azure SDK design guidelines](https://azure.github.io/azure-sdk/).

> **Note:** Management Plane (ARM) libraries do **not** require an Architecture Board review.

## When do you need a review?

There are three types of Architecture Board engagements:

1. **Service Introduction Meeting** — A one-time meeting for teams that have never had an Architecture Board review. This must happen before your first Beta review.
2. **Beta (Preview) Review** — Required before releasing your **first** beta SDK. Subsequent beta releases do not require a review.
3. **Stable (GA) Review** — Required before releasing a GA SDK across all Tier 1 languages (.NET, Java, JavaScript/TypeScript, Python).

## How to request a review

For the complete review process, including how to request a review, required materials, and what to expect, see the [Azure SDK Architecture Board Review Process](https://aka.ms/azsdk/review-process).

## Previewing SDK API changes

It is expected that SDK API changes are released in beta for a period of time before they are released as stable. This gives customers time to provide feedback which could result in adjustments to the SDK API before it moves to stable. SDK API changes that go straight to stable do not benefit from this feedback which can result in them being difficult for customers to use and for us to support. In most circumstances, SDK API changes going through either the full or abbreviated review process should be released as beta before a stable release.

## Getting approval for small, targeted changes and bug fixes

For small or targeted changes and bug fixes which modify SDK APIs, the architect in each language can review and approve without a combined/central review. We highly recommend doing this review as early as possible. This should be done on GitHub by opening an issue with links to [APIView](https://apiview.org) diffs. Include all architects as reviewers. In some cases it makes sense for small changes to the SDK API to be batched for efficiency. If a language architect determines there is a need for a deeper discussion, then a meeting with that architect should be scheduled. If it's a cross-language discussion, then a board meeting should be scheduled.

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
