---
name: Architectural Board Review Request
about: Request that an Azure client library go through an architectural board review
title: 'Board Review: <client library name>'
labels: architecture, board-review
assignees: kyle-patterson
---

Thank you for starting the process for approval of the client library for your Azure service.  Thorough review of your client library ensures that your APIs are consistent with the guidelines and the consumers of your client library have a consistently good experience when using Azure. 

** Before submitting, ensure you adjust the title of the issue appropriately **

To ensure consistency, all Tier-1 languages (C#, TypeScript, Java, Python) will generally be reviewed together.  In expansive libraries, we will pair dynamic languages (Python, TypeScript) together, and strongly typed languages (C#, Java) together in separate meetings.

## The Basics

* Service team responsible for the client library:
* Link to documentation describing the service:
* Contact email (if service team, provide PM and Dev Lead):

## About this client library

* Name of the client library:
* Languages for this review:
* Link to the service REST APIs:

## Artifacts required (per language)

We use an API review tool ([apiview](https://apiview.azurewebsites.net)) to support .NET and Java API reviews.  For Python and TypeScript, use the API extractor tool, then submit the output as a Draft PR to the relevant repository (azure-sdk-for-python or azure-sdk-for-js).

### .NET

* Upload DLL to [apiview](https://apiview.azurewebsites.net).  Link:
* Link to samples for champion scenarios:

### Java

* Upload JAR to [apiview](https://apiview.azurewebsites.net).  Link:
* Link to samples for champion scenarios:

### Python

* Upload the api as a Draft PR.  Link to PR:
* Link to samples for champion scenarios:

### TypeScript

* Upload output of api-extractor as a Draft PR.  Link to PR:
* Link to samples for champion scenarios:

## Champion Scenarios

A champion scenario is a use case that the consumer of the client library is commonly expected to perform.  Champion scenarios are used to ensure the developer experience is exemplary for the common cases.  You need to show the entire code sample (including error handling, as an example) for the champion scenarios.

* Champion Scenario 1:
    * Describe the champion scenario
    * Estimate the percentage of developers using the service who would use the champion scenario
    * Link to the code sample

_ Repeat for each champion scenario _

Examples of good scenarios are technology agnostic (i.e. the customer can do the same thing in multiple ways), and are expected to be used by > 20% of users:

* Upload a file
* Update firmware on the device
* Recognize faces in an uploaded image

Examples of bad scenarios:
* Create a client (it's part of a scenario, and we'll see it often enough in true champion scenarios)
* Send a batch of events (again, part of the scenario)
* Create a page blob (it's not used by enough of the user base)

## Agenda for the review

A board review is generally split into two parts, with additional meetings as required

Part 1 - Introducing the board to the service:
- Review of the service (no more than 10 minutes).
- Review of the champion scenarios.
- Get feedback on the API patterns used in the champion scenarios.

After part 1, you may schedule additional meetings with architects to refine the API and work on implementation.

Part 2 - the "GA" meeting
- Scheduled at least one week after the APIs have been uploaded for review.
- Will go over controversial feedback from the line-by-line API review.
- Exit meeting with concrete changes necessary to meet quality bar.

## Thank you for your submission
    