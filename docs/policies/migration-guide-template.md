# Guide for migrating to (name of new package here) from (name of old package here)

This guide is intended to assist in the migration to (name of new package here) from (name of old package here). It will focus on side-by-side comparisons for similar operations between the two packages.

We assume that you are familiar with (name of old package here). If not, please refer to the README for (link to the new package here with package name as link text) rather than this guide.

## Table of contents

## Migration benefits

As Azure has matured and been embraced by a more diverse group of developers, we have been focused on learning the patterns and practices to best support developer productivity and to understand the gaps that the (language here .NET/JavaScript/Python/Java) client libraries have.

There were several areas of consistent feedback expressed across the Azure client library ecosystem. One of the most important is that the client libraries for different Azure services have not had a consistent approach to organization, naming, and API structure. Additionally, many developers have felt that the learning curve was difficult, and the APIs did not offer a good, approachable, and consistent onboarding story for those learning Azure or exploring a specific Azure service.

To improve the development experience across Azure services, a set of uniform [design guidelines](https://azure.github.io/azure-sdk/general_introduction.html) was created for all languages to drive a consistent experience with established API patterns for all services. A set of (add link to language specific guidelines here with link text like Java guidelines) was also introduced to ensure that (add language here) clients have a natural and idiomatic feel with respect to the (add language here) ecosystem. The new (name of new package here) follows these guidelines.

### Cross Service SDK improvements

The modern (add service name) client library also provides the ability to share in some of the cross-service improvements made to the Azure development experience, such as

- Using the new (Add the Identity package name here in your language) library to share a single authentication approach between clients
- A unified logging and diagnostics pipeline offering a common view of the activities across each of the client libraries
- (Add this line only for JS) Use of promises rather than callbacks for a simplified programming experience
- (Add this line only for JS) Use of async iterators in paging APIs
- (Add this line only for Java) A unified asynchronous programming model using [Project Reactor](https://projectreactor.io/).
- (Add this line only for Java) A unified way of creating clients via builders.

### Performance improvements

Use this section to advertise the performance improvements in new package when compared to the old one. Skip this section if no perf improvements are found yet.

### New features

Use this section to advertise any new features in the new package when compared to the old one. Skip this section if no new features were added

## Important changes

### Package names and namespaces

Note: This section is always applicable for .NET and Java, while being occasionally applicable to JavaScript and Python where we tend to re-use the old package name where possible. The concept of namespace does not apply to JavaScript, we use the "@azure" scope instead. Remove this section if not needed. Below example text is for .NET Event Hubs, tweak as needed.

Package names and the namespace root for the modern Azure client libraries for .NET have changed. Each will follow the pattern Azure.[Area].[Service] where the legacy clients followed the pattern Microsoft.Azure.[Service]. This provides a quick and accessible means to help understand, at a glance, whether you are using the modern or legacy clients.

In the case of Event Hubs, the modern client libraries have packages and namespaces that begin with Azure.Messaging.EventHubs and were released beginning with version 5. The legacy client libraries have packages and namespaces that begin with Microsoft.Azure.EventHubs and a version of 4.x.x or below.

### Client hierarchy and constructors

If there has been no change other than naming) in client hierarchy or entry level classes, skip "hierarchy" from the header, otherwise talkabout why the client hierarchy was changed. Compare code snippets for the client constructors between the old and new packages, while pointing out differences and the reason behind them.

### Champion scenario 1

Repeat this section for the common high level usage scenarios for this library.
Show how you would accomplish these both in the old and new packages, pointing out the key differences, reasons and advantages.

## Additional samples

More examples can be found at (Add link to samples here with link text Samples for new package name)
