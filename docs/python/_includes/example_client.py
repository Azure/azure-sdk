"""Example client signatures
"""
class ExampleClient(object):

    def __init__(self, endpoint, credential, **kwargs):
        # type: (str, azure.core.credential.TokenCredential, **Any) -> None
        """Create a new example client instance

        :param endpoint: Endpoint to connect to.
        :type endpoint str:
        :param credential: Credentials to use when connecting to the service.
        :type credential: ~azure.core.credentials.TokenCredential
        :keyword apiversion: API version to use when talking to the service. Default is '2020-12-31'
        :type apiversion: str
        :keyword transport: HttpTransport to use. Default is azure.core.transport.RequestsHttpTransport.
        :type transport: ~azure.core.pipeline.transport.HttpTransport
        """
        api_version = kwargs.pop('api_version', '2020-12-31')
        transport = kwargs.pop('transport', None) or azure.core.pipeline.transport.RequestsTransport(**kwargs)
        
        # continue to build up your client...
        pipeline = ...

    @classmethod
    def from_connection_string(cls, connection_string, **kwargs):
        # type: (str, **Any) -> None
        """Optional factory method if the service supports connection strings
        
        :param connection_string: Connection string containing endpoint and credentials
        :type connection_string: str
        :returns: The newly created client.
        :rtype: ExampleClient
        """
        endpoint, credential = _parse(connection_string)
        return cls(endpoint, credential, **kwargs)

