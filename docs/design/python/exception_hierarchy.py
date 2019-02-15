# Logical exception hierarchy:
#
# AzureError
#   |- AzureLibraryError
#       |- AzureLibraryRequestError
#       |- AzureLibraryResponseError
#   |- ServiceRequestError
#       |- ConnectionTimeoutError
#       |- ServiceHttpRequestError
#           |- ClientRequestError
#               |- ResourceExistsError
#               |- ClientAuthenticationError
#               |- ResourceModifiedError
#           |- ServerError
#           |- TooManyRedirectsError
#           |- TooManyRetriesError

class AzureError(Error):
  pass

class AzureLibraryError(AzureError):
  """ An error has occured in the azure library.

  If request is not None, the request was attempted.
  If response is not None, this is the response received.
  """
  def __init__(self, request=None, response=None):
    self.request = request
    self.response = response

class ServiceRequestError(AzureError):
  """ A request to a service has failed. This may or may not be an HTTP service
  """
  pass

class ConnectionTimeout(ServiceRequestError):
  pass

class ServiceHttpRequestError(ServiceRequestError):
  """ A service request to a HTTP based service failed (returned an 
  unexpected non-2xx status code)
  """
  def __init__(self, request, response):
    self.request = request
    self.response = response

class ClientRequestError(ServiceHttpRequestError):
  """ A service request failed (returned a 4xx status code)

  See below for more specific exception types. 
  """
  pass

class ClientAuthenticationError(ClientRequestError):
  """ A service request failed with a 403 response.
  """
  pass

class ResourceExistsError(ClientRequestError):
  """ A service request failed (most likely with a 409 or 412) error due to the
  resource already existing.

  The client sent an if-none-match: '*' precondition in the request, and the precondition failed,
  or the service returned a 409 Conflict to a PUT/PATCH/POST request.

  This request is not retryable. The client must make some modifications to
  the request before the call will succeed. 
  """
  pass

class ResourceModifiedError(ClientRequestError):
  """ A service request failed with a 412 error due to a resource having been modified existing.

  The client sent an if-match: <etag> precondition in the request, and the precondition failed.
  This request is not retryable. The client must make some modifications to
  the request before the call will succeed. 
  """
  pass

class ResourceNotFoundError(ClientRequestError):
  """ A service request failed with a 404 or 412 error due to not finding a matching resource.

  For 412, the client sent an if-match: * precondition in the request, and the precondition failed.
  This request is not retryable.
  """
  pass

class TooManyRequestsError(ServiceHttpRequestError):
  """ A service request failed with a 429 response

  The request is usually retryable.
  """
  pass

class ServerError(ServiceHttpRequestError):
  """ A service request failed (returned a 5xx status code)
  """
  pass

class TooManyRetriesError(ServiceRequestError):
  """ Composite exception indicating that the library has run out of retries.

  The request is not retryable. 
  """
  pass

class TooManyRedirectsError(ServiceRequestHttpError):
  """ We hit the upper limits for the number of retries to follow.
  """
  pass


## Strawman usage

try:
    database = cosmosclient.create_database('mydb')
except ResourceExistsError as e:
    database = cosmosclient.get_database('mydb')

try:
    container.upsert_item({'id': 'unique'})
except ResourceModifiedError as e:
    pass

# ...was
try:
    database = cosmosclient.create_database('mydb')
except azure.common.CloudError as e:
    if e.status_code == 409: # If the service does not allow overwrites of existing resources
        database = cosmosclient.get_database('mydb')


# ...or, for some services...

try:
    database = cosmosclient.create_database('mydb')
except azure.common.CloudError as e:
    if e.status_code == 412: # If the SDK uses if-match/* in the PUT
        database = cosmosclient.get_database('mydb')

