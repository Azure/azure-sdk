| Environment Variable          | Purpose                                                                                    |
|-------------------------------|--------------------------------------------------------------------------------------------|
| **Proxy Settings**            |                                                                                            |
| HTTP_PROXY                    | Proxy for HTTP connections                                                                 |
| HTTPS_PROXY                   | Proxy for HTTPS connections                                                                |
| NO_PROXY                      | Hosts which must not use a proxy                                                           |
| ALL_PROXY                     | Proxy for HTTP and/or HTTPS connections in case HTTP_PROXY and/or HTTPS_PROXY are not defined |
| **Identity**                  |                                                                                            |
| MSI_ENDPOINT                  | Azure AD MSI Credentials                                                                   |
| MSI_SECRET                    | Azure AD MSI Credentials                                                                   |
| AZURE_USERNAME                | Azure username for U/P Auth                                                                |
| AZURE_PASSWORD                | Azure password for U/P Auth                                                                |
| AZURE_CLIENT_CERTIFICATE_PATH | Azure Active Directory                                                                     |
| AZURE_CLIENT_ID               | Azure Active Directory                                                                     |
| AZURE_CLIENT_SECRET           | Azure Active Directory                                                                     |
| AZURE_TENANT_ID               | Azure Active Directory                                                                     |
| AZURE_AUTHORITY_HOST          | Azure Active Directory                                                                     |
| **Pipeline Configuration**    |                                                                                            |
| AZURE_TELEMETRY_DISABLED      | Disables telemetry                                                                         |
| AZURE_LOG_LEVEL               | Enable logging by setting a log level.                                                     |
| AZURE_TRACING_DISABLED        | Disables tracing                                                                           |
| **General SDK Configuration** |                                                                                            |
| AZURE_CLOUD                   | Name of the sovereign cloud                                                                |
| AZURE_SUBSCRIPTION_ID         | Azure subscription                                                                         |
| AZURE_RESOURCE_GROUP          | Azure Resource Group                                                                       |
