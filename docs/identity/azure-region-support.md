# Azure ESTS-R (Entra Regional Security Token Service)

The Azure Identity client libraries prioritize 3rd party (3p) support when designing our APIs. Regional STS (ESTS-R) is a 1st party (1p) feature described as "the regional AAD authentication stack for service identities. ESTS-R offers regional isolation that reduces cross-region dependency and eliminates a single point of failure. It caches token data and metadata, and services repeat authentication requests out of cache."

ESTS-R was originally added as an optional parameter in Azure Identity; however, given the 1p-only availability as well as the limited support for ESTS-R, it was removed from the public API surface but remains available as an environment variable.

Support for ESTS-R is provided today via the `AZURE_REGIONAL_AUTHORITY_NAME` environment variable. When provided, the following credentials will pass the regional authority to MSAL when issuing token requests:

- ClientSecretCredential
- ClientAssertionCredential
- ClientCertificateCredential
