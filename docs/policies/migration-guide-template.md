# Guide for migrating to [name of Track 2 package here] from [name of Track 1 package here] 

This guide is intended to assist in the migration to [name of Track 2 package here] from [name of Track 1 package here]. It will focus on side-by-side comparisons for similar operations between the two packages.

Familiarity with the [name of Track 1 package here] package is assumed. For those new to the [service name here] client library for [language here .Net/JavaScript/Python/Java], please refer to the [README for name of Track 2 package here](add link to track 2 readme) for rather than this guide.

## Table of contents

## Migration benefits

A natural question to ask when considering whether or not to adopt a new version or library is what the benefits of doing so would be. As Azure has matured and been embraced by a more diverse group of developers, we have been focused on learning the patterns and practices to best support developer productivity and to understand the gaps that the .NET client libraries have.

There were several areas of consistent feedback expressed across the Azure client library ecosystem. One of the most important is that the client libraries for different Azure services have not had a consistent approach to organization, naming, and API structure. Additionally, many developers have felt that the learning curve was difficult, and the APIs did not offer a good, approachable, and consistent onboarding story for those learning Azure or exploring a specific Azure service.

To try and improve the development experience across Azure services, a set of uniform [design guidelines](https://azure.github.io/azure-sdk/general_introduction.html) was created for all languages to drive a consistent experience with established API patterns for all services. A set of [add language here-specific guidelines](add link to language specific guidelines here) was also introduced to ensure that [add language here] clients have a natural and idiomatic feel with respect to the [add language here] ecosystem. Further details are available in the guidelines for those interested.

### Cross Service SDK improvements

The modern [add service name] client library also provides the ability to share in some of the cross-service improvements made to the Azure development experience, such as 
- using the new Azure.Identity library to share a single authentication approach between clients
- a unified logging and diagnostics pipeline offering a common view of the activities across each of the client libraries
- (In case of JS) use of promises rather than callbacks for a simplified programming experience
- (In case of JS) use of async iterators in paging APIs

### Performance improvements

Use this section to advertise the performance improvements in Track 2 when compared to Track 1. Skip this section if no perf improvements are found yet.

## Important changes

### Package names and namespaces

Note: This section is always applicable for .Net and Java, while being occasionally applicable to JavaScript and Python where we tend to re-use the Track 1 package name where possible. The concept of namespace does not apply to JavaScript, we use the "@azure" scope instead. Remove this section if not needed. Below example text is for .Net Event Hubs, tweak as needed.

Package names and the namespace root for the modern Azure client libraries for .NET have changed. Each will follow the pattern Azure.[Area].[Service] where the legacy clients followed the pattern Microsoft.Azure.[Service]. This provides a quick and accessible means to help understand, at a glance, whether you are using the modern or legacy clients.

In the case of Event Hubs, the modern client libraries have packages and namespaces that begin with Azure.Messaging.EventHubs and were released beginning with version 5. The legacy client libraries have packages and namespaces that begin with Microsoft.Azure.EventHubs and a version of 4.x.x or below.

### Client hierarchy and constructors

If there has been no change (other than naming) in client hierarchy or entry level classes, skip "hierarchy" from the header, otherwise talk about why the client hierarchy was changed. Compare code snippets for the client constructors for both Track 1 & 2, while pointing out differences and the reason behind them.

### Champion scenario 1

Repeat this section for the common high level usage scenarios for this library.
Show how you would accomplish these both in Track 1 & 2, pointing out the key differences, reasons and advantages.

## Additional samples

More examples can be found at [Samples for add package name here](Add link to samples here)









