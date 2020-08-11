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

**Before submitting, ensure you adjust the title of the issue appropriately.**

**Note that the right material must be included before a meeting can be scheduled.** 



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

Please read through “API Listing” section [here](https://azure.github.io/azure-sdk/policies_reviewprocess.html#api-listings) to understand how these artifacts are generated. **It is critical that these artifacts are present and are in the right format. If not, the language architects cannot review them with the SDK Team’s API review tool.**

### .NET

* Upload DLL to [apiview](https://apiview.azurewebsites.net).  Link:
* Link to samples for champion scenarios:

### Java

* Upload JAR to [apiview](https://apiview.azurewebsites.net).  Link:
* Link to samples for champion scenarios:

### Python

* Upload output of stubgen to [apiview](https://apiview.azurewebsites.net):
* Link to samples for champion scenarios:

### TypeScript

* Upload output of api-extractor as a Draft PR.  Link to PR:
* Link to samples for champion scenarios:


## Thank you!
    