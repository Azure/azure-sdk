---
title: "Policies: Release Notes"
permalink: policies_releasenotes.html
folder: policies
sidebar: general_sidebar
---

# Producing Release Notes

Each release cycle, we produce release notes for every language. This process is partly automated. Our automation runs regularly and produces pull requests with titles of the form **({Language} release notes for the {YYYY-MM} release)** for dotnet, java, js, and python. Below are instructions for updating/reviewing the PRs before merging.

- The **engineering leads** for the released packages should make sure they have been picked up by the automation and that the entry is correct.
  - You can update the generated data at `_data/releases/YYYY-MM/{language}.yml` by adding github style suggestions to the PR that the release driver can commit to the PR when reviewed.
  - Suggest new release entries that should be added to the PR if it has not already been added by the automation (it most likely will be).
  - If there are packages that should be in the release that don't appear it is probably because the automation has not run since the package was released. Your package should generally get picked up by the automation within 24 hours.
  - The generated data in `_data/releases/YYYY-MM/{language}.yml` is pulled into the proper sections in the corresponding markdown file at `releases/YYYY-MM/{language}.md` by the Jekyll engine. Once changes to the yml file is merged into main you can see the content pulled into the github.io site at `https://azure.github.io/azure-sdk/releases/YYYY-MM/{language}.html`

- The **release manager** should hide all entries for packages that should not be in the release period, review and merge the pull request.
  - Entries can be hidden by setting the `Hidden` field to `true`.
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

However, in the release notes we do want to list critical changes for customers. A critical change is one that the developer would either need to know or want to know. Use the following section headers (`Features Added`, `Breaking Changes`, and `Bugs Fixed`) for the defined critical changes:

* *Features Added* - For new features to be called out in release notes. 
* *Breaking Changes* - For any changes that the will break the customer in some way, such as breaking existing functionality, soon-to-be removed features, or now removed features. 
* *Bugs Fixed* - For important bug fixes to be called out in release notes, including any security fixes. Include things that the customer would likely notice or need to react to in some way. 

For example, "The name of the property displayed in the ArgumentOutOfRangeException in the MaxDeliveryCount property in SubscriptionProperties was updated to use the correct property name." does not qualify as an important bug fix so shouldn't be listed under `Bugs Fixed` but can be listed under `Other Changes`.  However, "Added a new overload to the constructor to support AzureAD credentials" would be a good thing to include under `Features Added`.

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
