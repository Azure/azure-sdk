---
name: Architectural Board Review Request
about: Request that an Azure client library go through an architectural board review
title: 'Board Review: <client library name>'
labels: architecture, board-review
assignees: adrianhall
---

Thank you for starting the process for approval of the client library for your Azure service.  Thorough review of your client library ensures that your APIs are consistent with the guidelines and the consumers of your client library have a consistently good experience when using Azure. 

** Before submitting, ensure you adjust the title of the issue appropriately **

## The Basics

* Service team responsible for the client library:
* Link to documentation describing the service:
* Contact email (if service team, provide PM and Dev Lead):

## About this client library

* Name of the client library:
* Languages for this review:
* Link to the service REST APIs:
* Link to the reference documentation:
* Link to several samples:

To ensure consistency, all Tier-1 languages (C#, TypeScript, Java, Python) will be reviewed together.  Other languages may be included as required.

## Champion Scenarios

A champion scenario is a use case that the consumer of the client library is commonly expected to perform.  Examples might be "Update Firmware", "Download a file", "Recognize faces in a list of pictures".  Champion scenarios are used to ensure the developer experience is exemplary for the common cases.  You need to show the entire code sample (including error handling, as an example) for the champion scenarios.

* Champion Scenario 1:
    * Describe the champion scenario
    * Link to the code sample

_ Repeat for each champion scenario _

## Agenda for the review

The following agenda will normally be followed:

1. Introduction to the service (10 minutes max)
2. Class Heirarchy (general) and public API surface
    * To ensure consistency, discuss any language then indicate how the other languages are constructed
3. Per-language exceptions and examples
4. Implementation of champion scenarios (top 3-4 only) with code in preferred language
    * Include samples as attachments for other languages - all languages under consideration must be provided

## Thank you for your submission
    