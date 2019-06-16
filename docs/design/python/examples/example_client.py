""" The example_client shows the canonical shape of a simple non-hierarchical sync client

This particular example is intended to run on both Python 2.7 and 3.5+.
"""

import azure.core as core
import azure.core.transport as core.transport
import azure.core.transport.policies = core.pipelinepolicies


class Example(object):

    def __init__(self, name, contents, difficulty):
        ...

class ExampleClientOptions(object):

    # TODO: this should just take **kwargs. 
    def __init__(self, max_retries=3, max_redirects=None, custom_json_encoders=None, custom_json_decoders=None, enable_network_tracing=False):
        self.headers_policy = core.pipelinepolicies.HeaderPolicy(),
        self.authentication_policy = core.pipelinepolicies.BearerTokenAuthenticationPolicy(),
        self.content_decode_policy = core.pipelinepolicies.ContentDecodePolicy(custom_json_encoders, customer_json_decoders), 
        self.redirect_policy = core.pipelinepolicies.RedirectPolicy(max_redirects=max_redirects),
        self.retry_policy = core.pipelinepolicies.RetryPolicy(max_retries=max_retries),
        self.logging_policy = core.pipelinepolicies.NetworkTracePolicy(enable_network_tracing)

class ExampleClient(object):
    """ A client for interacting with the Azure Example service.

    The Azure Example service does not exist. But if it did, it would allow for creation, listing and
    deletion of examples. It would also let users run their scenarios. These made-up methods have been
    selected to cover as much as possible of the Azure client library API shape as possible.
    """

    def __init__(self, service_url, credentials, options=None, transport=None, **kwargs):
        """ Create a new instance of an ExampleClient.
        """
        # type: (str, Any, ExampleClientOptions, SyncTransport, Mapping[str, Any]) -> None
        
        if not transport:
            # The default sync transport is the RequestsTransport.
            # TODO: According to azure.core's documentation, the configuration takes a type, 
            # not a Transport instance...
            transport = core.transport.RequestsTransport()

        # TODO: Don't like that you can pass in options and **kwargs
        options = options or self.create_options(**kwargs, transport) 

        policies = [
            options.headers_policy,
            options.authentication_policy,
            options.content_decode_policy, # TODO: azure.core's documentation does not allow the caller to change this. Not sure why...
            options.redirect_policy,
            options.retry_policy,
            options.logging_policy            
        ]
        self._pipeline = core.Pipeline(transport, policies = policies)

    @classmethod
    def create_options(cls, **kwargs):
        # (type, Mapping[str, Any]) -> ExampleClientOptions
        ...


    # Service methods:
    def create_example(name, contents, fail_if_exists=False, **kwargs):
        """ Create a new example with the given `name`.
        :param str name: The name of the new example.
        :param str contents: The example's content.
        :param boolean fail_if_exists: If True, the method fails if an example with the given `name` already exists.
        :param int difficulty: The difficulty level. A number from 0 to 100. Default is 0.
        TODO: Add documentation for additional **kwargs here...

        :raises `azure.core.errors.ResourceExistsException`: If a resource with the given name already exists and fail_if_exists is set to True.
        """

        if not name:
            # We validate the name because it is required in order to make the correct request to the service.
            # A missing/empty name will result in us constructing the wrong path. Which may be a valid endpoint
            # on the service, but which will do the completely wrong thing...
            raise ValueError('Name must be a non-empty string')

        difficulty = kwargs.pop('difficulty', None)
        custom_headers = kwargs.pop('headers', {}) # TODO: Should be a case-insensitive dict...
        response_hook = kwargs.pop('response_hook', None)

        # Construct the request body and URL
        body = dict(
            content=content,
            difficulty=difficulty
        )

        if fail_if_exists:
            headers['if-none-match'] = '*'
        
        url = urlparse.urljoin('/examples/', urllib.quote(name))
        raw_request = core.HttpRequest('PUT', url, body)
        raw_response = self._pipeline.run(raw_request, **kwargs)

        if raw_response.status_code == 412 and fail_if_exists:
            # We know that the caller tried to 
            raise core.errors.ResourceExistsException()

        deserialized_response = self.deserialize(raw_response, Example)

        if response_hook:
            # We always pass the raw response headers and deserialized information
            # to the response_hook if provided.
            response_hook(raw_response.headers, deserialized_response)