---
title: Routing Failure Notifications in DevOps
layout: post
date: 2020-06-30
sidebar: releases_sidebar
author_github: danieljurek
repository: azure/azure-sdk
---

The Azure SDK Engineering System runs roughly 480 Azure DevOps pipelines to validate GitHub Pull Requests, run live test automation, and ensure that the libraries are ready to be released. If a build or test fails, our alerting system immediately notifies our SDK engineering teams and partner Azure service teams. In this post, we'll learn how the Azure SDK Engineering Systems team scaled Azure DevOps notifications to alert the right people at the right time when our automation discovers an issue.

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

We use the [.NET client libraries for Azure DevOps and TFS](https://docs.microsoft.com/en-us/azure/devops/integrate/concepts/dotnet-client-libraries?view=azure-devops) in our tools because the client libraries simplify working with the Azure DevOps API.

The client libraries do not provide the ability to directly filter by definition types so we use LINQ to filter the query results.

This example shows how to filter pipeline definitions based on the trigger type.

```csharp
using Microsoft.TeamFoundation.Build.WebApi;
using Microsoft.VisualStudio.Services.Common;
using Microsoft.VisualStudio.Services.WebApi;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace DemoFilteringScheduledPipelines
{
    class Program
    {
         static async Task Main(string[] args)
        {
            const string devOpsToken = "<devops_pat>";
            const string organization = "<your_organization_name>";
            const string projectName = "<your_project_name>";

            // Create credentials using the PAT
            var devOpsCreds = new VssBasicCredential("nobody", devOpsToken);
            var devOpsConnection = new VssConnection(new Uri($"https://dev.azure.com/{organization}/"), devOpsCreds);

            // Create client and fetch a list of definitions for the
            // specified project. The .NET client library does not directly
            // support querying for build definitions based on trigger types
            var buildDefinitionClient = await devOpsConnection.GetClientAsync<BuildHttpClient>();
            var definitions = await buildDefinitionClient.GetFullDefinitionsAsync2(project: projectName);

            // Use LINQ to filter definitions to those definitions that have schedules
            var targetDefinitions = definitions.Where(def =>
                def.Triggers.Any(trigger => trigger.TriggerType == DefinitionTriggerType.Schedule));


            foreach (var definition in targetDefinitions)
            {
                Console.WriteLine($"{definition.Name} ({definition.Id}) has a schedule");
            }
        }
    }
}
```

### Create notification groups

For each of the filtered pipelines we create two groups or "Teams" in Azure DevOps. The Parent Notification Team serves as the central point of contact and the Synchronized Notification Team contains the contacts from the CODEOWNERS file.

The Parent Notification Team is subscribed to alerts for its pipeline and it has as its member the Synchronized Notification Team. We can add add arbitrary members to the parent team, like project or Engineering System administrators, who want to know when a pipeline fails but don't want to be a code owner on GitHub.

The Synchronized Notification Team belongs to the Parent Notification team. When a GitHub alias is added or removed from the CODEOWNERS file for a given pipeline the corresponding contact is added or removed from the Synchronized Notification Team.

![The synchronized notification team is a member of the parent notification team](https://devblogs.microsoft.com/azure-sdk/wp-content/uploads/sites/58/2020/06/nested-notification-groups.png)

We keep track of groups using YAML in the `Description` field of the pipeline. This keeps us from having to store data in another database. For example:

```yaml
pipelineId: 123
purpose: ParentNotificationTeam
```

The `pipelineId` field gives the Azure DevOps pipeline numerical ID and the `purpose` can either be `ParentNotificationTeam` or `SynchronizedNotificationTeam`.

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

![An example of error message logs in an Azure DevOps failure email](https://devblogs.microsoft.com/azure-sdk/wp-content/uploads/sites/58/2020/06/devops-email-error-messages.png)

## Conclusion

Using and enforcing consistent pipeline and repo layouts means that our Engineering System will scale smoothly to meet the needs of our product engineers.  Small tools like this one can tune your system in ways that help your product teams stay focused on their goals.

## Working with us and giving feedback

So far, the community has filed hundreds of issues against these new SDKs with feedback ranging from documentation issues to API surface area change requests to pointing out failure cases. Please keep that coming. We work in the open on GitHub and you can submit issues here:

* [API design guidelines](https://github.com/Azure/azure-sdk/)
* [.NET](https://github.com/Azure/azure-sdk-for-net)
* [Java](https://github.com/Azure/azure-sdk-for-java)
* [JavaScript / TypeScript](https://github.com/Azure/azure-sdk-for-js)
* [Python](https://github.com/Azure/azure-sdk-for-python)

Finally, please keep up to date with all the news about the Azure developer experience programs and let us know how we are doing by following [@AzureSDK](https://twitter.com/AzureSDK) on Twitter.
