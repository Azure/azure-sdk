---
title: "Policies: Guideline Adoption"
permalink: policies_adoption.html
folder: policies
sidebar: general_sidebar
---

The design guidelines are meant to be much like the US constitution - a document that everyone can abide by and follow, but not one that is easy to adjust.  As a result, the following policy affects how we can change the design guidelines.

## Changing the general design guidelines

Any change to the general design guidelines (which includes everything under the `/docs/general` folder within the `azure/azure-sdk` repository) should be "a big deal" since such changes affect every single client library that we produce.  The following requirements must be met before a general design guideline is adopted:

* The design guideline is discussed within an Architectural Board meeting with a quorum of 3 voting members of the architecture board.  Each voting member may vote as follows:
    * Approve - the architect believes this is a good guideline.
    * Abstain - the architect feels the guideline has flaws, but not enough to stop the proposal.
    * Reject - the architect feels the guideline is flawed enough it must not be added to the guidelines.
* Two thirds of voting members must vote "Approve".
* There must be no "Reject" votes.
* The proposed language for the design guideline is submitted via PR.
    * Review by any appropriate groups (as determined by the board chair) - examples: Security, CSS.
    * Review by at least two affected service teams in different groups.
    * Approval (through the PR process) by 3 voting members of the board.

## Changing the language specific guidelines

Language specific guidelines (which includes everything under the language-specific folder of `/docs` in the `azure/azure-sdk` repository) are generally driven by the general guidelines, but also idiomatic and generally accepted design and implementation principals in the language of choice.  Design guidelines must meet the spirit of the general design guidelines.  Implementation guidelines are governed by the language team, with the language architect having responsibility for ensuring the implementation guidelines meet the best practices for the language concerned.

Guidelines can be proposed by anyone via PR, but the following must be met to be merged:

* PR is approved (through the PR process) by the assigned language architect.  If the updated guidelines affect the design principles or the API design sections, then a second member of the architecture board must also approve the PR.
* PR is reviewed with relevant stake holders (such as service teams, security, and CSS).
* PR is approved by the language dev lead.

## Engineering systems policy changes

The engineering systems policies (which includes everything under the `/docs/policies` folder within the `azure/azure-sdk` repository) are also proposed via PR and subject to review:

* PR is reviewed with relevant stake holders, as determined by the engineering systems dev lead (such as service teams, security, and CSS).
* PR is approved by the engineering systems dev lead or designate.
* If the proposal affects client libraries in a specific language, then the proposal must also be approved by the language dev lead.

## For new language guidelines

Language specific guidelines are first published in DRAFT.  This means that they are in flux and may be adjusted as the first libraries are created.  During the draft phase, there are no requirements on merging pull requests.  To move from DRAFT to general availability, the following conditions must be met:

* The guidelines are published in draft mode for at least 1 month to allow public comments.
* The engineering systems are configured for producing client libraries in the language.
* The Azure Core and Azure Identity libraries are published in beta to appropriate distribution points.
* At least 2 Azure client libraries are published in beta to the appropriate distribution points.
* At least 1 user study has been conducted that studies the Azure Core and Azure Identity library usage (generally as part of a client library user study).
* The guidelines have been reviewed by the architectural board and (if there is one) the language team in DevDiv.

## Changing this policy

Changes to this policy can only be made by the [SDK architectural board](mailto:adparch@microsoft.com).

