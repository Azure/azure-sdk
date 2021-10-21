## Overview
The document is intended to show you what process the Azure SDK team has implemented to ensure that your issue is reviewed promptly and by the right team. The hope is that by gaining some insight into this process, you'll have a better experience interacting with us on GitHub and a smoother issue resolving process.

The process as described here currently applies to the following repositories:

- [Azure/azure-sdk-for-net](https://github.com/Azure/azure-sdk-for-net)
- [Azure/azure-sdk-for-java](https://github.com/Azure/azure-sdk-for-java)
- [Azure/azure-sdk-for-python](https://github.com/Azure/azure-sdk-for-python)
- [Azure/azure-sdk-for-js](https://github.com/Azure/azure-sdk-for-js)
- [Azure/azure-sdk-for-ruby](https://github.com/Azure/azure-sdk-for-ruby)
- [Azure/azure-sdk-for-go](https://github.com/Azure/azure-sdk-for-go)
- [Azure/azure-powershell](https://github.com/Azure/azure-powershell)
- [Azure/azure-cli](https://github.com/Azure/azure-cli)
- [Azure/azure-cli-extensions](https://github.com/Azure/azure-cli-extensions)
- [Azure/azure-rest-api-specs](https://github.com/Azure/azure-rest-api-specs)

We also have plans to add the process to these repositories: 

- [Azure/azure-sdk-for-c](https://github.com/Azure/azure-sdk-for-c)
- [Azure/azure-sdk-for-cpp](https://github.com/Azure/azure-sdk-for-cpp)
- [Azure/azure-sdk-for-android](https://github.com/Azure/azure-sdk-for-android)
- [Azure/azure-sdk-for-ios](https://github.com/Azure/azure-sdk-for-ios)

## A label-driven process 

### 1. Triage and routing 

New issues are automatically labeled with the following:

| Tag                 | Purpose                                                                                                      |
| ------------------- | ------------------------------------------------------------------------------------------------------------ |
| `needs-triage`      | To indicate that the issue needs to be reviewed by triage team                                               |
| `customer-reported` | To distinguish community created issues from those created by the SDK team for development tracking purposes |
| `question`          | To indicate issue type. (The assumption is that the issue is a question.)                                    |



The triage team will go through the issues and assess who might be the best owner to assign for an issue or whether another team is best suited to assist.  Labels will be added or removed as needed to help categorize and ensure that it is seen by those best able to assist.   Some common tags are:

| Tag                      | Purpose                                               |
| ------------------------ | ------------------------------------------------------ |
| `<Service Name>`         | To indicate what service the issue is referring to     |
| `CXP Attention`          | Added if the support team should assist with the issue |
| `Service Attention`      | Added if the issue needs to be routed to another team  |
| `bug`, `feature-request` | These are the other issue types                        |

For issues that need to be routed to teams best able to assist, i.e. those tagged `Service Attention`, there will be a comment that says the following: 

    Thanks for the feedback! We are routing this to the appropriate team for follow-up. cc @GitHubHandle

This will bring attention to the mentioned GitHub handle(s) that they need to help resolve the issue. As the engineers gain more insight into the issue during their investigations, they'll also adjust the labels accordingly. 

Note that for issues that need routing, sometimes it may take a while to find the right contacts, and so response will be slower than usual. When this happens, we encourage you to leave us a comment. 

### 2. Response and follow ups

Depending on the nature of the issue, several rounds of back-and-forth may be needed to resolve the problem after the initial response, which we do our best to provide *within 3 business days* of issue creation. You may also be asked for more information — for instance error logs or code to replicate the problem — to help with the investigation. To facilitate this back-and-forth process, we use two labels, `needs-author-feedback` and `needs-team-attention`. 

When asking you for more input, we also add the `needs-author-feedback` label to the issue. When tagged as such, our bot will remind either you or us to look at the issue depending on which side has responded: 
- when you respond, it adds `needs-team-attention` to get our attention (and removes `needs-author-feedback`)
- when you don’t respond *7 days after* `needs-author-feedback` is added, it'll add `no-recent-activity` and send you a friendly reminder
- if there’s no response from you after *another 14 days* (total 21 days), it'll close the issue
- if you respond *within 7 days* of issue closure, it'll reopen the issue 

## Issue types and when they're resolved

Most of the issues in the repositories are questions. Questions can be addressed without a change in the product; they also include suggestions. As such, questions can be expected to be resolved faster than bugs and feature requests.  

Bugs and feature requests are issues that require a change to an existing behavior or an addition of a new behavior in the product (documentation, code, samples, etc.) to be resolved. We may or not have estimates of when these issues will be resolved. When we do, we add milestones to them. When we don't, we follow up as often as possible to provide updates. 

## Issues not under consideration

Sometimes there are requests or suggestions that we don't feel align with the direction of the product or would positively impact the majority of customers. When that is the case, we close the issue with an explanation. 

There are also cases where an issue is about something that we will not and/or cannot fix — for example, libraries that have been deprecated or endpoints that have been removed. This is especially true for older issues; we've seen 2+ year-old issues about older versions of a product that we no longer have sufficient knowledge on. When that is the case, we close the issue with a brief explanation. 

Finally, it's also possible that the problem brought up in an issue is not considered in the short term. In this case, the issue is put in the backlog. This means other work items are prioritized first, and we're uncertain about when the issue will be resolved. 

## Reopening issues

Our current support process has room for improvement. Sometimes we or the bot might make the wrong judgment and close an issue prematurely. If that's the case, you're welcome to reopen the issue and ping us to help by leaving a comment. 

## Feedback

We're always looking for ways to improve this process, so please feel free to leave us any feedback and/or suggestion in any of the repositories above!
