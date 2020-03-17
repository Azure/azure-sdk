---
title: "Policies: Pipelines"
permalink: policies_pipelines.html
folder: policies
sidebar: general_sidebar
---

Whilst the Azure SDK is considered a unified set of libraries, each group of libraries ships on a separate cadence with varying levels of change as dictated by the needs of the service that those libraries support.

# Pipeline per "Service"

Our pipelines are derived by the way that we ship our libraries to customers. For example we would generally expect to ship some or all of the storage libraries together, so there is a set of pipelines for PR validation, CI and release which operate on code located in the ```sdk/storage/``` path within the repo.

This means that for each language/runtime mono-repo we have multiple pipelines, with each pipeline focused on building and releasing those packages. The entry point to each pipeline is located at ```sdk/[service]/ci.yml``` which defines any custom variables and selects appropriate templates for that pipeline.

Creation of the pipeline within Azure Pipelines is automated. When a ```ci.yml``` file is added to the repository, an automated process runs (every hour, unless manually triggered) which creates a public and internal pipeline.

# Pipeline Optimization and Special Case Pipelines

In general each pipeline that ships a library (or set of libraries) to customers should be optimized to perform necessary build, test and static analysis steps for just that set of libraries. Where it is desirable to run analysis across the entire repository, these tasks should be pulled out into special case pipelines.

The reason for this is that we don't want a static analysis failure in one part of the code base blocking the release of an unrelated library. Additionally, repo-wide analysis steps generally take a long time and it is inappropriate to bog down the pipelines for this activity.