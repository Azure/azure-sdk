"""Example client using some of the most common API patterns
"""

import models
import azure.core.pipeline.transport as transports

class Thing:
    """A simple model type representing a Thing.

    :ivar name: The name of the thing. 
    :vartype name: str
    :ivar size: The size of the thing. 
    :vartype size: int
    """

    def __init__(self, name: str, size: int) -> None:
        """Create a new Thing

        :param name: The name of the thing
        :type name: str
        :param size: The size of the thing
        :type size: int
        """

        # Please note that we are using attributes rather than properties.
        self.name = name
        self.size = size

    @classmethod
    def from_response(self, response: "azure.core.rest.HttpResponse") -> "Thing":
        """Factory method to, given a response, construct a ~Thing
        """
        return Thing(**response.context['deserialized_data'])

    def __repr__(self):
        # For simple model types, we can just dump our __dict__ and
        # truncate the output at 1024 characters.
        return json.dumps(self.__dict__)[:1024]

class ExampleClient:

    def __init__(self, endpoint: str, credential: "azure.core.credentials.TokenCredential", **kwargs) -> None:
        """Create a new example client instance

        :param endpoint: Endpoint to connect to.
        :type endpoint str:
        :param credential: Credentials to use when connecting to the service.
        :type credential: ~azure.core.credentials.TokenCredential
        :keyword api_version: API version to use when talking to the service. Default is '2020-12-31'
        :paramtype api_version: str
        :keyword transport: HttpTransport to use. Default is ~transports.RequestsHttpTransport.
        :paramtype transport: ~azure.core.pipeline.transport.HttpTransport
        """
        self._api_version = kwargs.pop('api_version', '2020-12-31')
        transport = kwargs.pop('transport', None) or transports.RequestsTransport(**kwargs)
        
        # continue to build up your client...
        self._pipeline = [
            ..., # List of policies for this specific client
            transport
        ]

    @classmethod
    def from_connection_string(cls, connection_string: str, **kwargs) -> "Thing":
        """Optional factory method if the service supports connection strings
        
        :param connection_string: Connection string containing endpoint and credentials
        :type connection_string: str
        :returns: The newly created client.
        :rtype: ~ExampleClient
        """
        endpoint, credential = _parse(connection_string)
        return cls(endpoint, credential, **kwargs)


    def get_thing(self, name: str, **kwargs) -> "Thing":
        """Get the Thing with name `name`.

        :param name: The name of the ~Thing to get
        :type name: str
        :rtype: ~Thing
        """
        model_factory = kwargs.pop('cls', Thing.from_response)
        request = self._build_get_thing_request(name)
        # Pass along all policy parameters when making the request
        response = self._pipeline.send(request, **kwargs) 
        return model_factory(response)

    def list_things(self, **kwargs) -> "azure.core.paging.ItemPaged[Thing]":
        """List all things.
        
        :rtype: ~azure.core.ItemPaged[~Thing]
        """
        ...
        return azure.core.paging.ItemPaged(...)

    def begin_restart_thing(self, name: str, **kwargs) -> "azure.core.polling.LROPoller[bool]":
        """Restart the thing

        :param name: The name of the thing to restart
        :type name: str
        """
        model = kwargs.pop('cls', dict)
        request = self._build_begin_restart_thing(name)
        # Pass along all policy parameters when making the request
        response = self._pipeline.send(request, **kwargs)

        # TODO: show how to construct the poller instance
        return azure.core.polling.LROPoller(...)






