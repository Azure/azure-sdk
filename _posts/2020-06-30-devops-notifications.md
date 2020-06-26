---
title: Routing Failure Notifications in DevOps
layout: post
date: 2020-06-30
sidebar: releases_sidebar
author_github: danieljurek
repository: azure/azure-sdk
---

The Azure SDK Engineering System runs roughly 480 Azure DevOps pipelines to validate GitHub Pull Requests, run live test automation, and ensure that the libraries are ready to be released. If a build or test fails, our alerting system immediately notifies our SDK engineering teams and partner Azure service teams. In this post, we'll learn how The Azure SDK Engineering Systems team scaled Azure DevOps notifications to alert the right people at the right time when our automation discovers an issue.

## That’s a lot of pipelines

We generally create one pipeline per service/language combination to build and test code relating to that pipeline. This keeps our DevOps agent machine time focused more narrowly and enables engineers to iterate more quickly on changes. For example, there’s no need to build packages and run tests for Storage when you’re making changes to Key Vault.

Keeping this many pipelines organized requires a standard approach to how we create, configure, name, and trigger pipelines. When you can apply standards you can automate work, so we built automation that uses the [Azure DevOps API](https://docs.microsoft.com/rest/api/azure/devops/?view=azure-devops-rest-5.1). A small team of engineers can scale our Engineering Systems to meet the needs of an ever growing matrix of services and languages.

## Alert System Architecture

The Engineering Systems team looks for existing tools to handle problems and we discovered that the Azure DevOps alerting system does most of the work for us. Rather than build our own alerting system we automate configuring Azure DevOps notification groups.

Our alerting system makes use of GitHub’s CODEOWNERS file that teams are already using to add reviewers to pull requests. These same owners are responsible for fixing code in their service’s SDK when a build or test fails. In order to route failure notifications we need to do a few things:

1. Get a list of pipelines with schedule triggers
1. Create notification groups for each pipeline and subscribe those groups to receive failure notifications
1. Synchronize appropriate code owners into the group

### Get a list of pipelines with schedule triggers

This is a straightforward process of filtering pipelines in the Azure DevOps build definition API.

### Create notification groups

We query groups in DevOps and use YAML in the group description to understand each group’s purpose. This keeps us from having to store data in another database. The syntax is simple:

```yaml
pipelineId: 123
purpose: ParentNotificationTeam
```

The `pipelineId` field gives the Azure DevOps pipeline ID and the `purpose` can either be `ParentNotificationTeam` or `SynchronizedNotificationTeam`.

We use two teams because some interested parties (like project leads or Engineering Systems administrators) may want to know when pipeline executions fail. The Parent Notification Team allows us to manually add these parties. The Synchronized Notification team gets the code owners.

```text
----------------------------------------
| Parent Notification Team             |
|  * Person 1                          |
|  * Person 2                          |
|                                      |
|   ---------------------------------- |
|   | Synchronized Notification Team | |
|   |  * Person A                    | |
|   |  * Person B                    | |
|   |                                | |
|   ---------------------------------- |
----------------------------------------
```

### Synchronize CODEOWNERS

Here is a subset of the [CODEOWNERS file](https://github.com/Azure/azure-sdk-for-net/blob/master/.github/CODEOWNERS) in the Azure SDK for .NET repo.

```text
# Catch all
/sdk/        @AlexGhiondea

# Core
/sdk/core/        @pakrym @KrzysztofCwalina
…
# Service teams
/sdk/appconfiguration/    @annelo-msft @AlexanderSher
```

In this example we see a couple of services under the `sdk/` folder (Core and App Configuration) and a catch-all contact who can be alerted when a specific entry doesn’t exist for a service. For example, if we added a service called Foo but did not have an entry in the CODEOWNERS file, `@AlexGhiondea` would still receive notifications for Foo pipeline failures.

Our pipeline definition yml files exist at the level of the service (e.g. [/sdk/appconfiguration/ci.yml](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/appconfiguration/ci.yml)) and matches the path leading up to the .yml file (e.g. `/sdk/appconfiguration/`) against the service team folder for each pipeline definition.

We translate the GitHub aliases using a Microsoft database of employees who contribute on behalf of the company and synchronize those contacts into the Synchronized Notification Team.

## Use our tools

The notification creation tool is open source so you can use it to build your own notification strategy. It is designed to work with repositories that follow our repo layout and pipeline structure but can be modified and extended to work with other environments. You can find the code at:

[https://github.com/Azure/azure-sdk-tools/tree/master/tools/notification-configuration](https://github.com/Azure/azure-sdk-tools/tree/master/tools/notification-configuration)

If you are working outside of Microsoft you will need to adapt the [GitHubNameResolver](https://github.com/Azure/azure-sdk-tools/blob/master/tools/notification-configuration/github-codeowner-subscriber/GitHubNameResolver.cs) class to work with your own contact resolving strategy. The process may be as simple as getting the user's email address from the [GitHub User API](https://developer.github.com/v3/users/#get-a-user).

## Other things to try

Some ideas we had when designing this project but have not implemented yet:

**Microsoft Teams** – The Azure SDK team makes considerable use of Microsoft Teams and putting these alerts in a Teams channel could work better than email for the ways in which some teams work.

**Making better use of error logs** – Azure DevOps has a Logging Commands feature where a specifically formatted message sent to stdout will generate an alert in Azure DevOps. These alerts are the only detail a developer will see in an email and a little more effort here can help a product engineer quickly make sense of the failure and save time on investigations:
