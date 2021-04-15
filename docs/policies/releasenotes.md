---
title: "Policies: Release Notes"
permalink: policies_releasenotes.html
folder: policies
sidebar: general_sidebar
---

# Producing Release Notes

Each release cycle, we produce release notes for every language. This process is partly automated. The `azure-sdk - generate-release-notes` once every weekday and produces pull requests with titles of the form **(Create or Update Release Notes for {Language} {YYYY-MM} release)** for dotnet, java, js, and python. Below are instructions for updating/reviewing the PRs before merging.

- The **engineering leads** for the released packages should make sure they have been picked up by the automation and that the entry is correct.
  - To prevent the conflicts between the automation and manual edits, instead of pushing new commits you should make code suggestion on the PR, then allow the release manager to take care of merging everything in.
  - Feel free to suggest edits to individual `Release Highlights` sections as you see fit. Suggestions should use the github suggest feature instead of manually pushing new commits. 
  - Suggest new release entries that should be added to the PR if it has not already been added by the automation (it most likely will be). 
  - If there are packages that should be in the release that don't appear it is probably because this automation runs once every weekday. Your package should generally get picked up by the automation within 24 hours.

- The **release manager** should remove all entries for packages that should not be in the release period, review and merge the pull request.
  - Entries will have to be removed from the `Release Highlights`, `Installation Instructions` as well as the `Updates`, `Beta` or, `GA` sections as the case may be. 
  -  **Do not** remove the entries inside the HTML comments `<!--  -->` as that will cause the automation to re-add the entry on the next run. 
  - After code complete, the release manager will do a final editorial pass before linking the release notes into the table of contents.

Release notes are part of the release and must be ready for final edit by the "Code Complete" date.

## What's in a release note?

The release notes consist of four sections:

1. A list of packages that are being released (that have developer impacting changes) and how to install the packages.
2. A list of "developer impacting changes" to each package, organized by package.
3. Boilerplate text that provides a link to the latest release information.
4. A table of links that point to the "point in time" package download, source code, and reference documentation.

> **Note**: Do not include other documentation or samples in the table of links.  These can be accessed via the standard latest release link.

## What's a "developer impacting change"?

We don't want to advertise every single bug fix as most of them do not impact the way customers think about developing the client.  The [change log](https://azure.github.io/azure-sdk/policies_releases.html#change-logs) provides an exhaustive list of changes.  We don't need to duplicate it.

However, in the release notes we do want to list critical changes for customers. A critical change is one that the developer would either need to know or want to know. Use the following section headers (*Features Added, Breaking Changes, and Key Bugs Fixed*) for the defined critical changes:

* *Features Added* - For new features to be called out in release notes
* *Breaking Changes* - For changes to be called out in release notes including, changes that break existing functionality, soon-to-be removed features, now removed features
* *Key Bugs Fixed* - For important bug fixes to be called out in release notes,including any security fixes

For example, "fixed a bug in which the event processor would stop working if you received no events for 30 minutes" does not qualify.  While you may list this under the "Fixed" heading in the changelog, the customer does not need to do anything, and it's fairly likely they have not bumped into this error, so this doesn't classify under "Key Bugs Fixed."  However, "Added a new overload to the constructor to support AzureAD credentials" would definitely be a good thing to include.

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
