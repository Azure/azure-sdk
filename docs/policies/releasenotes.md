---
title: "Policies: Release Notes"
permalink: policies_releasenotes.html
folder: policies
sidebar: general_sidebar
---

# Producing Release Notes

Each release cycle, we produce release notes for every language.  To do this:

* The release manager (within the PM organization) will create a new folder within the `/releases` directory of the `azure/azure-sdk` repository (named in `YYYY-MM` format) and create the necessary files.
* The engineering leads for the packages being released are responsible for ensuring the details of the release notes are filled in via the normal PR process.
* The release manager will review the release notes, merging PRs.  After code complete, the release manager will do a final editorial pass before linking the release notes into the table of contents.

Release notes are part of the release and must be ready for final edit by the "Code Complete" date.

## What's in a release note?

The release notes consist of four sections:

1. A list of packages that are being released (that have developer impacting changes) and how to install the packages.
2. A list of "developer impacting changes" to each package, organized by package.
3. Boilerplate text that provides a link to the latest release information.
4. A table of links that point to the "point in time" package download, source code, and reference documentation.

> **Note**: Do not include other documentation or samples in the table of links.  These can be accessed via the standard latest release link.

## What's a "developer impacting change"?

We don't want to advertise every single bug fix as most of them do not impact the way customers think about developing the client.  The change log provides an exhaustive list of changes.  We don't need to duplicate it.

However, in the release notes we do want to list critical changes for customers. A critical change is one that the developer would either need to know or want to know. Use the following section headers (*Security Fixes, Breaking Changes, New Featues, and Key Bug Fixes*) for the defined critical changes:

* *New Features* - Adding a new API or feature
* *Breaking Changes* - Changes to an existing API or changes to the behavior of an existing API
* *Key Bug Fixes* - Major bug fixes that require a customer to do something, bug fixes that come from multiple up-votes in github or that are motivated by customer feedback
* *Security Fixes* - Any security fix, no matter how small

For example, "fixed a bug in which the event processor would stop working if you received no events for 30 minutes" does not qualify.  The customer does not need to do anything, and it's fairly likely they have not bumped into this error.  However, "Added a new overload to the constructor to support AzureAD credentials" would definitely be a good thing to include.

Ensure the release notes are written from the perspective of the user.   We don't want to tell them about a new change without ALSO telling them how to take advantage of the change with either a link to the documentation or a short snippet of code.

## What if my library is changed but doesn't have any "developer impacting changes"?

You can either leave the library out of the release notes, or add a note such as "This release contains bug fixes to improve quality."

## How to produce quick links?

The release manager will produce the point-in-time snapshot of the versions and ensure the release notes use the snapshot to generate the quick links tables.

## Who publishes the release notes and when are they published?

* For all releases, the release manager will merge and publish the release notes in the current month's release folder.

## What do I need to do for an out-of-band release?

If you need to release a library after the official release notes release date has occurred but before the next month has been released, then add your release notes to the current month's release notes. The _Language Release Owner_ will merge and publish the release notes in the current month's release folder.

For example:
1. The official release notes are announced on 9/18/2020.
1. The library you need to ship does not ship by that date, say 9/22/2020.
1. Submit a PR to add your release notes to September release notes and tag the _Language Release Owner_.

If you have any questions, please reach out to your team's _Language Release Owner_.

You may optionally provide social media outreach for out-of-band releases.  Contact the _Community Engagement Manager_ for details on this at least 7 working days prior to the release.

## Where do I go if I need help?

The _Azure SDK release manager_ is best place to start when you need help with a release. They manage the Release channel in the Azure SDK Teams team.  If you need help you can post a message in that Teams channel here: <https://aka.ms/azsdk/teams/release>

