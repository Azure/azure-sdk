# Azure SDK for Javascript Preview 1 Release Notes 

TODO High level info about the release what goals, what libraries are coming with this release, key new features.

## Installation Instructions
To install all the of the packages, copy and paste the below into a terminal.

TODO Update code below
    
    npm install @azure/event-hubs@5.0.0-preview.1 @azure/keyvault-keys @azure/keyvault-secrets @azure/storage-queue@12.0.0-preview.1  npm install @azure/storage-file@12.0.0-preview.1 npm install @azure/storage-blob@12.0.0-preview.1

To install them individually

    $> npm install @azure/event-hubs@5.0.0-preview.1
    $> npm install @azure/keyvault-keys
    $> npm install @azure/keyvault-secrets
    $> npm install @azure/storage-queue@12.0.0-preview.1
    $> npm install @azure/storage-file@12.0.0-preview.1
    $> npm install @azure/storage-blob@12.0.0-preview.1

## Feedback
If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/auzre/azure-sdk-for-js/issues)

## Changelog
Detailed change logs are linked to in the Quick Links below. Here are some critical call outs.

TODO: Needs more word smithing
- Use of @azure/identity library for auth across all libraries
- Use of @azure/abort-controller library to cancel async operations across all libraries
- Introduction of async iterators across all libraries
- Proxy Support in Storage and Event Hubs libraries

## Quick Links
| Service  | Install | Quickstart |  API Reference | Changelog | Samples
| -- | -- | -- | -- | -- | -- |
| [Event Hubs](https://azure.microsoft.com/en-us/services/event-hubs/) | [Package](https://www.npmjs.com/package/@azure/event-hubs) | [Readme.md](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/eventhub/event-hubs) | [API Reference Documentation](https://azure.github.io/azure-sdk-for-js/event-hubs/index.html) | [Changelog](https://github.com/Azure/azure-sdk-for-js/releases/tag/%40azure%2Fevent-hubs_5.0.0-preview.1) | [Samples](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/eventhub/event-hubs/samples)
| [Keys in Keyvault](https://azure.microsoft.com/en-us/services/key-vault/) | [Package](https://www.npmjs.com/package/@azure/keyvault-keys) | [Readme.md](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/keyvault/keyvault-keys) | [API Reference Documentation](https://azure.github.io/azure-sdk-for-js/keyvault-keys) | [Changelog](https://github.com/Azure/azure-sdk-for-js/releases/tag/%40azure%2Fkeyvault-keys_4.0.0-preview.2)  | [Samples](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/keyvault/keyvault-keys/samples)
| [Secrets in Keyvault](https://azure.microsoft.com/en-us/services/key-vault/) | [Package](https://www.npmjs.com/package/@azure/keyvault-secrets) | [Readme.md](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/keyvault/keyvault-secrets) | [API Reference Documentation](https://azure.github.io/azure-sdk-for-js/keyvault-secrets) | [Changelog](https://github.com/Azure/azure-sdk-for-js/releases/tag/%40azure%2Fkeyvault-secrets_4.0.0-preview.2) | [Samples](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/keyvault/keyvault-secrets/samples)
| [Storage Blobs](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blobs-overview) | [Package](https://www.npmjs.com/package/@azure/storage-blob) | [Readme.md](https://github.com/Azure/azure-sdk-for-js/tree/feature/storage/sdk/storage/storage-blob) | [API Reference Documentation](https://azure.github.io/azure-sdk-for-js/storage-blob/index.html) | [Changelog](https://github.com/Azure/azure-sdk-for-js/releases/tag/%40azure%2Fstorage-blob_12.0.0-preview.1) | [Samples](https://github.com/Azure/azure-sdk-for-js/tree/feature/storage/sdk/storage/storage-blob/samples)
| [Storage Files](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-introduction) | [Package](https://www.npmjs.com/package/@azure/storage-file) | [Readme.md](https://github.com/Azure/azure-sdk-for-js/tree/feature/storage/sdk/storage/storage-file) | [API Reference Documentation](https://azure.github.io/azure-sdk-for-js/storage-file/index.html) | [Changelog](https://github.com/Azure/azure-sdk-for-js/releases/tag/%40azure%2Fstorage-file_12.0.0-preview.`) | [Samples](https://github.com/Azure/azure-sdk-for-js/tree/feature/storage/sdk/storage/storage-blob/samples)
| [Storage Queues](https://docs.microsoft.com/en-us/azure/storage/queues/storage-dotnet-how-to-use-queues) | [Package](https://www.npmjs.com/package/@azure/storage-blob) | [Readme.md](https://github.com/Azure/azure-sdk-for-js/tree/feature/storage/sdk/storage/storage-queue) | [API Reference Documentation](https://azure.github.io/azure-sdk-for-js/storage-queue/index.html) | [Changelog](https://github.com/Azure/azure-sdk-for-js/releases/tag/%40azure%2Fstorage-queue_12.0.0-preview.1) | [Samples](https://github.com/Azure/azure-sdk-for-js/tree/feature/storage/sdk/storage/storage-queue/samples)


