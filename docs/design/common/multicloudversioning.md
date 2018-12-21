# Azure SDK guidelines for multi-cloud development

Given the presence of multiple clouds, each providing a potentially different set of services, and for each service, a different set of versions of the protocol used to communicate with the service, customers (developers) require some specific capabilities in order to build applications

## Scenarios (in priority/commonality order)

1. Customer is targeting public Azure only (single cloud)
2. Customer is a targeting a single national/government cloud (single cloud)
3. Customer is targeting multiple clouds, but does not do feature light-up based on capabilities of the target cloud (multi-cloud, highest common denominator api version)
4. Customer is targeting multiple clouds and does feature light-up based on capabilities of the target cloud (multi-cloud, dynamic api version)

### In order to accomplish their goals, customers must be able to:

1. list the capabilities of the cloud they are targeting
2. find an aquire an appropriate SDK/version for their application based on the target cloud's capabilities/versions
3. use different API versions for the same service from within their application
4. find documentation for the version of the SDK/api version that they are targeting
