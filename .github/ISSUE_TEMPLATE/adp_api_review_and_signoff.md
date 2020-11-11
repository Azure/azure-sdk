---
name: Architecture Board Review Request - API Review/API Sign Off
about: Request for API review or API sign off for an Azure client library 
title: 'Board Review: <client library name>'
labels: architecture, board-review
assignees: lilyjma
---

Thank you for submitting this review request. Thorough review of your client library ensures that your APIs are consistent with the guidelines and the consumers of your client library have a consistently good experience when using Azure. 

**The Architecture Board reviews [Track 2 libraries](https://azure.github.io/azure-sdk/general_introduction.html) only.** If your library does not meet this requirement, please reach out to [Architecture Board](adparch@microsoft.com) before creating the issue. 

Please reference our [review process guidelines](https://azure.github.io/azure-sdk/policies_reviewprocess.html) to understand what is being asked for in the issue template.

To ensure consistency, all Tier-1 languages (C#, TypeScript, Java, Python) will generally be reviewed together.  In expansive libraries, we will pair dynamic languages (Python, TypeScript) together, and strongly typed languages (C#, Java) together in separate meetings.

For Tier-2 languages (C, C++, Go, Android, iOS), the review will be on an as-needed basis.

**Before submitting, ensure you adjust the title of the issue appropriately.**

**Note that the required material must be included before a meeting can be scheduled.** 



## Contacts and Timeline

* Responsible service team:
* Main contacts:
* Expected code complete date:
* Expected release date:

## About the Service 

* Link to documentation introducing/describing the service:
* Link to the service REST APIs: 
* Link to GitHub issue for previous review sessions, if applicable:  


## About the client library

* Name of the client library:
* Languages for this review:

## Artifacts required (per language)

Please read through “API Review” section [here](https://azure.github.io/azure-sdk/policies_reviewprocess.html) to understand how these artifacts are generated. **It is critical that these artifacts are present and are in the right format. If not, the language architects cannot review them with the SDK Team’s API review tool.**

### .NET

* Upload a DLL to the [ApiView](http://apiview.dev/) tool. Link:
* Link to Champion Scenarios/Quickstart samples:

### Java

* Upload the `*-sources.jar` file to the [ApiView](http://apiview.dev/) tool (e.g. `azure-core-1.3.0-beta.1-sources.jar`).Link:
* Link to Champion Scenarios/Quickstart samples:

### Python

* Upload output of our [custom API stub generator](https://github.com/Azure/azure-sdk-tools/tree/master/packages/python-packages/api-stub-generator#generate-stub-file) to the [ApiView](http://apiview.dev/) tool. Link:
* Link to Champion Scenarios/Quickstart samples:
  
### TypeScript

* Upload output of the [API-Extractor](https://github.com/Microsoft/web-build-tools/wiki/API-Extractor) as a PR for the [azure-sdk-for-js](http://github.com/azure/azure-sdk-for-js) repository. Link to PR:
* Link to Champion Scenarios/Quickstart samples:


For all other languages, send a request to the Architecture Board to discuss the best format on individual basis.


## Thank you!
    
