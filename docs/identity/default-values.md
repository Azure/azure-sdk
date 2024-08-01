# Default Values

One of the goals of the Azure Identity Client Libraries is to provide sane defaults with minimal configuration when possible. This page attempts to list the default values used and justification for them.

## clientID

Normally a required parameter, various public client credentials will default to the Azure CLI's client ID for user authentication. While discouraged, this is the case today.

The following credentials default to Azure CLI's client ID:

- JavaScript
  - DeviceCodeCredential
  - InteractiveBrowserCredential
  - ManagedIdentityCredential
<!-- TODO: add more languages -->

## tenantID

Another required parameter, for user-authentication scenarios credentials may default to `common` or `organizations` as tenantID. These are essentially aliases for "the user's home tenant"

The following credentials use these defaults when tenantID is omitted:

- JavaScript
  - DeviceCodeCredential
  - InteractiveBrowserCredential

<!-- TODO: add more languages -->

<!-- TOOD: add more default values used throughout languages>