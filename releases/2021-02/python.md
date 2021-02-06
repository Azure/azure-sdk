---
title: Azure SDK for Python (%%MMMM yyyy%%)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

<!--
azure-storage-file-share:12.4.0
azure-storage-blob:12.7.0
azure-mgmt-batch:15.0.0b1
azure-storage-file-datalake:12.2.1
azure-mgmt-compute:18.1.0

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to make available the %%MMMM yyyy%% client library release.

#### GA
- Storage - Files Shares
- Storage - Blobs
- Resource Management - Virtual Machines

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Storage - Files Data Lake

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Resource Management - Batch

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
$> pip install azure-storage-file-share==12.4.0
$> pip install azure-storage-blob==12.7.0
$> pip install azure-mgmt-batch==15.0.0b1
$> pip install azure-storage-file-datalake==12.2.1
$> pip install azure-mgmt-compute==18.1.0

```

[pattern]: # ($> pip install ${PackageName}==${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights
### Storage - Files Shares 12.4.0 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-storage-file-share_12.4.0/sdk/storage/azure-storage-file-share/CHANGELOG.md#1240-2021-01-13)
**Stable release of preview features**
- Added support for enabling root squash and share protocols for file share.
- Added support for `AzureSasCredential` to allow SAS rotation in long living clients.

### Storage - Blobs 12.7.0 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-storage-blob_12.7.0/sdk/storage/azure-storage-blob/CHANGELOG.md#1270-2021-01-13)
**Stable release of preview features**
- Added `upload_blob_from_url` api on `BlobClient`.
- Added support for leasing blob when get/set tags, listing all tags when find blobs by tags.
- Added support for `AzureSasCredential` to allow SAS rotation in long living clients.

**Fixes**
- Fixed url parsing for blob emulator/localhost (#15882)

### Resource Management - Batch 15.0.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-mgmt-batch_15.0.0b1/sdk/batch/azure-mgmt-batch/CHANGELOG.md#1500b1-2021-01-28)
**Features**

  - Added a new user_assigned_identities on BatchAccountIdentity to specify a user managed identity
  - Added a new task_slots_per_node property on Pool so property tasks in a job can consume a dynamic amount of slots
  - Added a new identity property on Pool to specify a managed identity
  - Added new extensions property to VirtualMachineConfiguration on pools to specify virtual machine extensions for nodes
  - Added the ability to specify availability zones using a new property node_placement_configuration on VirtualMachineConfiguration
  - Added a new property user_name to ContainerRegistry

**Breaking changes**

  - Removed property username from ContainerRegistry
  - Removed max_tasks_per_node property on Pool and replaced it with task_slots_per_node

### Storage - Files Data Lake 12.2.1 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-storage-file-datalake_12.2.1/sdk/storage/azure-storage-file-datalake/CHANGELOG.md#1221-2021-01-13)
**New features**
- Added support for `AzureSasCredential` to allow SAS rotation in long living clients.

**Fixes**
- Converted PathProperties.last_modified to datetime format (#16019)

### Resource Management - Virtual Machines 18.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-mgmt-compute_18.1.0/sdk/compute/azure-mgmt-compute/CHANGELOG.md#1810-2021-01-19)
**Features**
  - Model Disk has a new parameter purchase_plan
  - Model Disk has a new parameter extended_location
  - Model Disk has a new parameter bursting_enabled
  - Model ThrottledRequestsInput has a new parameter group_by_client_application_id
  - Model ThrottledRequestsInput has a new parameter group_by_user_agent
  - Model Snapshot has a new parameter purchase_plan
  - Model Snapshot has a new parameter extended_location
  - Model DiskUpdate has a new parameter purchase_plan
  - Model DiskUpdate has a new parameter bursting_enabled
  - Model LogAnalyticsInputBase has a new parameter group_by_client_application_id
  - Model LogAnalyticsInputBase has a new parameter group_by_user_agent
  - Model PurchasePlan has a new parameter promotion_code
  - Model VirtualMachineScaleSetNetworkConfiguration has a new parameter enable_fpga
  - Model RequestRateByIntervalInput has a new parameter group_by_client_application_id
  - Model RequestRateByIntervalInput has a new parameter group_by_user_agent
  - Model VirtualMachineScaleSetUpdateNetworkConfiguration has a new parameter enable_fpga
  - Added operation DiskAccessesOperations.list_private_endpoint_connections
  - Added operation DiskAccessesOperations.begin_delete_a_private_endpoint_connection
  - Added operation DiskAccessesOperations.begin_update_a_private_endpoint_connection
  - Added operation DiskAccessesOperations.get_a_private_endpoint_connection
  - Added operation group DiskRestorePointOperations

[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
