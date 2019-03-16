# Anatomy of a REST API call / what does it return?
A [HTTP/1.1 Response](https://www.w3.org/Protocols/rfc2616/rfc2616-sec6.html) has three parts:
- Status line (which includes the status code)
- Headers
- Message body

In HTTP, headers are further divided into:
* General headers
* Response headers
* Entity headers

For Azure services, there is a parallell categorization of headers:
* Headers that drives well known behavior on the client. This tends to be the response headers. Specific examples are `Location`, `Proxy-Authenticate` and `Retry-After` - all of which I expect our pipeline to handle (by the RedirectPolicy, ProxyPolicy, RetryPolicy respectively).
* Headers logically associated with the request/response instance. Specific examples include `x-ms-request-id`. 
* Headers logically associated with the connection (there is some relationship between the header values for subsequent calls on the same client). Specific examples include `x-ms-ratelimit-remaining-subscription-reads`.
* Headers logically associated with the returned entity. Specific examples include the `x-ms-meta-...` headers for storage. 

## Exposing responses in our libraries

We currently have two patterns implemented in our libraries:

### Methods return Response(Of T)

In this model, we have a response data type that ties status line, headers, response body and (optionally) the original request together in a common data structure. Each part of the response is accessed through the correspondingly named property. Headers logically associated with the returned entity may be included in T. 

##### Pros

* True(er) to wire format.
* Allows for access to the specific status code (e.g. 200 vs. 201 for a PUT operation)
* Allows direct access to *any* headers by name.
* Allows a caller to determine what format they want from the response (i.e. the deserialized format or a stream of bytes)

##### Cons

* Whenever there isn't a 1:1 mapping between client method call and HTTP request, it is less clear exactly *which* response the headers belong to.
    * Ex. Paging and polling operations
* The set of headers exposed by a service in their responses is not easy to intuit from the method signature.
* Header values are untyped, leaving it to the caller to deserialize the value. Additionally, a caller must handle the presence of multiple headers for a response.

### Methods return T
In this model, we model T independently of how information was received (header or body). Headers related to the returned entity are modeled on T itself. Headers related to the *request* (e.g. request id, request processing cost) are assumed to primarily be of interest to logging and telemetry and thus consumed/"exposed" by logging and tracing policies. The full response is available in failures as a property in the raised exception.

##### Pros
* No confusion about which response headers belong to for library methods that makes multiple requests.
* Elevates the abstraction level from the raw HTTP response structure (header/body/status code)
* Removes one level of inderection for the most common scenarios (which is accessing T directly)
    * *Note: language constructs such as implicit type conversions between Response(of T) and T can be utilized to blur the lines between the two.*

##### Cons
* It is hard to intuit how to get response headers from the method signature. 
* Name collisions may occur if headers were promoted to T, and a new property with the same/similar name is introduced in the response body in a new service version.
* Until the first response has been retreived, the client has no valid value for headers associated with the connection/session.

## Proposed solution - add capabilities to the "Method Returns T" to simplify capture of headers

### Assumptions:

* The 90%+ case is that the user only cares about T.
* The 90%+ case is that the user only cares about handling per request/response headers in their own code (beyond logging/tracing) in the case of failure.
* The user can provide their own logging callable (callback) in the pipeline to do custom logging of requests/responses.

### New Additions

* Make headers related to the connection accessible on the client object.
* Add additional parameter accepting a callback that allows for control of the shape/type of the returned object.

Examples:

1. Model header on T.

HTTP request:
```json
GET /example/thing/2
x-ms-request-id: 12
```
HTTP Response:
```
Status: 200 OK
SomeCustomMetadata: 7
{
    "hello": "world"
}
```

Python code:
```python
>>> client = ExampleClient(...)
>>> thing = client.get_thing(2)
>>> print(thing.some_custom_metadata)
>>> print(thing.hello)
7 "world"
```

2. Retrieve request Id on failed call

HTTP request:
```json
GET /example/thing/7
x-ms-request-id: 13
```
HTTP Response:
```
Status: 404 NotFound
x-ms-request-id: 13
```
Python code: 
```python
>>> client = ExampleClient(...)
>>> try:
>>>     something = client.get_thing(7)
>>> except ClientRequestError as e:
>>>     for header in e.response.headers:
>>>         print(header['x-ms-request-id'])
13
```

3. Retrieve session token for cosmos

HTTP request:
```json
GET /example/thing/8
x-ms-request-id: 14
```
HTTP Response:
```
Status: 200 NotFound
x-ms-request-id: 14
x-ms-session-token: xafg2
```
Python code: 
```python
>>> client = ExampleClient(...)
>>> client.get_thing(8)
>>> print(client.session_token)
xafg2
```

4. Capture header and include in the response:

HTTP request:
```json
GET /example/thing/2
x-ms-request-id: 15
```
HTTP Response:
```
Status: 200 OK
SomeCustomMetadata: 7
x-ms-request-id: 15
{
    "hello": "world"
}
```

Python code:
```python
>>> client = ExampleClient(...)
>>> thing = client.get_thing(2)
>>> print(thing.some_custom_metadata)
>>> print(thing.hello)
7 "world"
```

```python
>>> def my_deserializer(raw_response):
>>>     wrapped_result = raw_response.deserialize()
>>>     setattr(wrapped_result, 'request_id', raw_response.headers['x-ms-request-id'])
>>>     return wrapped_result
>>> 
>>> thing = client.get_thing(2, response_handler=my_deserializer)
>>> print(thing.request_id)
15
```

### Appendix A - known services and headers
#### Cosmos

|Header|Type|How to retrieve|Description|
|-|-|-|-|
|Content-Type|Logical entity|Callback|	The Content-Type is application/json. The SQL API always returns the response body in standard JSON format.
|Date|Per request|Logging/Callback|The date time of the response operation. This date time format conforms to the RFC 1123 date time format expressed in Coordinated Universal Time.
|etag|Logical entity|On TThe etag header shows the resource etag for the resource retrieved. The etag has the same value as the _etag property in the response body.|
|x-ms-activity-id|Per request|Logging callback|Represents a unique identifier for the operation. This echoes the value of the x-ms-activity-id request header, and commonly used for troubleshooting purposes.
|x-ms-alt-content-path|Logical entity|T|The alternate path to the resource. Resources can be addressed in REST via system generated IDs or user supplied IDs. x-ms-alt-content-path represents the path constructed using user supplied IDs.|
|x-ms-continuation|Well known|Handled by paging|This header represents the intermediate state of query (or read-feed) execution, and is returned when there are additional results aside from what was returned in the response. Clients can resubmitted the request with a request header containing the value of x-ms-continuation.|
|x-ms-item-count|Per request|Logging|The number of items returned for a query or read-feed request.|
|x-ms-request-charge|Per request|Logging|This is the number of normalized requests a.k.a. request units (RU) for the operation. For more information, see Request units in Azure Cosmos DB.|
|x-ms-resource-quota|Connection|On client|Shows the allotted quota for a resource in an account.
|x-ms-resource-usage|Connection|On client|Shows the current usage count of a resource in an account. When deleting a resource, this shows the number of resources after the deletion.
|x-ms-retry-after-ms|Well known|Handled by Retry Policy|The number of milliseconds to wait to retry the operation after an initial operation received HTTP status code 429 and was throttled.
|x-ms-schemaversion|Per request|Logging|Shows the resource schema version number.
|x-ms-serviceversion|Connection|On client|Shows the service version number.
|x-ms-session-token|Connection|On client|The session token of the request. For session consistency, clients must echo this request via the x-ms-session-token request header for subsequent operations made to the corresponding collection.

#### Storage (subset of blob properties)
|Header|Type|How to retrieve|Description|
|-|-|-|-|
|Last-Modified|Logical Entity|T|The date/time that the blob was last modified. The date format follows RFC 1123. Any operation that modifies the blob, including an update of the blob's metadata or properties, changes the last modified time of the blob.|
|x-ms-creation-time|Logical entity|T|The date/time at which the blob was created.|
|x-ms-meta-name:value|Logical entity|T|A set of name-value pairs that correspond to the user-defined metadata associated with this blob.|
|x-ms-blob-type|Logical entity|T|The blob type.|
|x-ms-copy-completion-time|Logical entity|T|Conclusion time of the last attempted Copy Blob operation where this blob was the destination blob. This value can specify the time of a completed, aborted, or failed copy attempt. This header does not appear if a copy is pending, if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List.|
|x-ms-copy-status-description|Logical entity|T|Only appears when x-ms-copy-status is failed or pending. Describes cause of fatal or non-fatal copy operation failure. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List.|
|x-ms-copy-id|Logical entity|T|String identifier for the last attempted Copy Blob operation where this blob was the destination blob. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List.
|x-ms-copy-progress|Logical entity|T|Contains the number of bytes copied and the total bytes in the source in the last attempted Copy Blob operation where this blob was the destination blob. Can show between 0 and Content-Length bytes copied. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List.
|x-ms-copy-source|Logical entity|T|URL up to 2 KB in length that specifies the source blob used in the last attempted Copy Blob operation where this blob was the destination blob. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List.|
|x-ms-copy-status|Logical entity|T|State of the copy operation identified by x-ms-copy-id. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a completed Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List.|
|x-ms-incremental-copy|Logical entity|T|Included if the blob is incremental copy blob.|
|x-ms-copy-destination-snapshot|Logical entity|T|Included if the blob is incremental copy blob or incremental copy snapshot, if x-ms-copy-status is success. Snapshot time of the last successful incremental copy snapshot for this blob.|
|x-ms-lease-duration|Logical entity|T|When a blob is leased, specifies whether the lease is of infinite or fixed duration.|
|x-ms-lease-state|Logical entity|T|Lease state of the blob.|
|x-ms-request-id|Per request|Logging|This header uniquely identifies the request that was made and can be used for troubleshooting the request.|
...
