---
title: "Policies: Release Notes"
permalink: policies_releasenotes.html
folder: policies
sidebar: general_sidebar
---

# Producing Release Notes

Each release cycle, we produce release notes for every language.  To do this:

* The release manager (within the PM organization) will create a new folder within the `/releases` directory of the `azure/azure-sdk` repository (named in `YYYY-MM` format) and create the necessary files.
* The engineering leads for the packages being released will fill in the details of the release notes via the normal PR process.
* The release manager will review and merge the PRs for the release notes.

## What's in a release note?

The release notes consist of four sections:

1. A list of packages that are being released (that have developer impacting changes) and how to install the packages.
2. A list of "developer impacting changes" to each package, organized by package.
3. Boilerplate text that provides a link to the latest release information.
4. A table of links that point to the "point in time" package download, source code, and reference documentation.

> **Note**: Do not include other documentation or samples in the table of links.  These can be accessed via the standard latest release link.

## What's a "developer impacting change"?

We don't want to advertise every single bug fix as most of them do not impact the way customers think about developing the client.  The change log provides an exhaustive list of changes.  We don't need to duplicate it.

A critical change is one that the developer would either need to know or want to know.

* Security fixes, no matter how small.
* Changes to the API.
* Behavioral changes

For example, "fixed a bug in which the event processor would stop working if you received no events for 30 minutes" does not qualify.  The customer does not need to do anything, and it's fairly likely they have not bumped into this error.  However, "Added a new overload to the constructor to support AzureAD credentials" would definitely be a good thing to include.

Ensure the release notes are written from the perspective of the user.   We don't want to tell them about a new change without ALSO telling them how to take advantage of the change with either a link to the documentation or a short snippet of code.

## How to produce quick links?

> Heath will provide this section

## Who publishes the release notes?

The release manager will merge and publish the release notes.
