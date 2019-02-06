## Create resource using POST, stepwise long running operation
```http
POST https://api.contoso.com/orders
Accept: application-json
Content-Type: application/json

{
  "value": [
    {
      "productId": "snowShovel57",
      "quantity": 1
    }
  ] 
}
```

```http
HTTP/1.1 202 Accepted
Operation-Location: https://api.contoso.com/operations/4711
```

The client can check the status of the operation by following the `Operation-Location` header:

```http
GET https://api.contoso.com/operations/4711
```

```http
HTTP/1.1 200 Ok
Retry-After: 30

{
  "status": "processing"
}
```

The client determines if the operation is done by checking the `status` attribute in the response body. It will eventually reach on of the predetermined *terminal* states (`"succeeded"` or `"failed"`). 

Since in this case, the operation is not done, the client has to continue polling...

```http
GET https://api.contoso.com/operations/4711
Accept: application/json
```

```http
HTTP/1.1 200 Ok

{
  "status": "succeeded",
  "resourceLocation": "https://api.contoso.com/orders/alfi1
}
```

## Create order (hybrid)
```http
POST https://api.contoso.com/orders
Accept: application-json
Content-Type: application/json

{
  "value": [
    {
      "productId": "snowShovel57",
      "quantity": 1
    }
  ] 
}
```

In this scenario, the initial request returns both a pointer to an operation (`Operation-Location`)
as well as the location (`Location`) of the newly created resource, optionally along with 
a (partial) representation of the resource in the response body.
```http
HTTP/1.1 201 Created
Location: https://api.contoso.com/orders/alfi3
Operation-Location: https://api.contoso.com/operations/4712

{
  "value": [
    {
      "productId": "snowShovel57",
      "quantity": 1
    }
  ],
  "status": "creating"
}
```

As before, you can check the operation status...

```http
GET https://api.contoso.com/operations/4712
```

```http
HTTP/1.1 200 Ok
Retry-After: 30

{
  "status": "creating"
}
```

...until it's all done...

```http
GET https://api.contoso.com/operations/4711
Accept: application/json
```

```http
HTTP/1.1 200 Ok

{
  "status": "succeeded",
  "resourceLocation": "https://api.contoso.com/orders/alfi3"
}
```

### Example Python code for all long running operations above: 
```python

# The begin_create_order method returns a msrest.polling.poller.PollingMethod-like object
order_request = client.begin_create_order([
    OrderLine(product_id='snowShovel57', quantity=1)
)

# One can (optionally) wait on the operation to complete
order_request.wait(2)

# ...and if you want to check if the operation is done, call done()
if order_requests.done():
  pass

# One can also register a callback to be called when done
order_request.add_done_callback(lambda polling_method: ...)

# But the simplest way is to just get the result. Which is blocking when using the 
# synchronous APIs. 
order = order_request.result()
```

## Create order (sync)
Client sends a create request:
```http
POST https://api.contoso.com/orders

{
  "value": [
    {
      "productId": "snowShovel57",
      "quantity": 1
    }
  ] 
}
```

```http
HTTP/1.1 201 Created
Location: //api.contoso.com/orders/alfi2
```

The client turns around to get the created order as indicated in the `Location` header:
```http
GET https://api.contoso.com/orders/alfi2
```

```http
HTTP/1.1 200 Ok

{
  "value": [
    {
      "productId": "snowShovel57",
      "quantity": 1,
      "orderStatus": "pending"
    }
  ] 
}

```

### Example Python: 
```python

# The create_order method returns the order
order = client.create_order([
    OrderLine(product_id='snowShovel57', quantity=1)
)
```

## List orders (paged)

Get the first page of items:

```http
GET https://api.contoso.com/orders
```

```http
HTTP/1.1 200 Ok

{
  "value": [
    {
      "productId": "snowShowvel47",
      "quantity": 1,
      "status": "delivered"
    }
  ],
  "nextLink": "https://api.contoso.com/orders?continuationToken=VHFN"
}
```

The `nextLink` property in the response is an opaque pointer to the next page...

```http
GET https://api.contoso.com/orders?continuationToken=VHFN
```

```http
HTTP/1.1 200 Ok

{
  "value": [
    {
      "productId": "beachChair17",
      "quantity": 2,
      "status": "delivered"
    }
  ]
}
```
No `nextLink` provided - we are done...

### Example Python code:
```python
# Paging is done transparently by the 
for order in client.list_orders():
    print(order)

# I can also "manually" walk through the pages:
orders = client.list_orders()
page = orders.advance_page()
while page:
    print(page)
```
