---
name: Architecture Board Review Request - Introductory Session
about: Request for introductory session on an Azure service and client library with the Architecture Board
title: 'Board Review: Introducing <client library name>'
labels: architecture, board-review
assignees: kyle-patterson, ronniegeraghty
---
# Attention
**For internal teams, our process for scheduling review sessions with the Azure SDK Architecture team has changed. The Azure SDK Architecture team has moved to using a [Scheduling Tool](https://aka.ms/azsdk/schedulesdkreview) for the scheduling of both Introduction and SDK Review meetings.**

Thank you for starting the process for approval of the client library for your Azure service.  Thorough review of your client library ensures that your APIs are consistent with the guidelines and the consumers of your client library have a consistently good experience when using Azure. 

**The Architecture Board reviews [Track 2 libraries](https://azure.github.io/azure-sdk/general_introduction.html) only.** If your library does not meet this requirement, please reach out to [Architecture Board](azsdkarch@microsoft.com) before creating the issue.

Please reference our [review process guidelines](https://azure.github.io/azure-sdk/policies_reviewprocess.html) to understand what is being asked for in the issue template.

**Before submitting, ensure you adjust the title of the issue appropriately.**

**Note that the required material must be included before a meeting can be scheduled.** 

## Contacts and Timeline

* Service team responsible for the client library:
* Main contacts:
* Expected stable release date for this library:

## About the Service 

* Link to documentation introducing/describing the service:
* Link to the service REST APIs: 
* Is the goal to release a Public Preview, Private Preview, or GA? 


## About the client library

* Name of client library:
* Link to library reference documentation:
* Is there an existing SDK library? If yes, provide link: 


## Step 1: Champion Scenarios 

Ultimately the library should be easy to use for common scenarios that developers want. Consider the following questions when thinking about champion scenarios:

1. What is the app the developer is building that uses your client library?
2. Who is the end-user of the application (the developer's customer)?
3. What features of the API need to be explained in the sample so that someone could use this API in real app?
4. How does the **authentication** workflow look? 
   
See Champion Scenario section [here](https://azure.github.io/azure-sdk/policies_reviewprocess.html).

Code is appreciated but optional. Pseudocode is fine.  

* Champion scenario 1
    * Link to library’s sample folder: 
* Champion scenario 2
    * Link to library’s sample folder:
* …
* Champion scenario n
    * Link to library’s sample folder:

## Step 2: Quickstart Samples (Optional)
Include samples demonstrating how to consume the client library if available: 

* Create a new resource
* Read the resource
* Modify the resource
* Delete the resource
* Error handling 
* Handling race conditions/concurrency issues




## Thank you for your submission!

