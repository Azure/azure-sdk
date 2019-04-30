# Hierarchical clients

For services that expose a hierarchy of items, each level above the leaf levels SHOULD have their own corresponding client. The leaf node MAY have an associated client if there is a large number of operations associated with any given instance. Any intermediate levels MAY be omitted by promoting all associated methods to the parent client if the number of methods on the client is low, or if common scenarios require clients to manipulate properties of both the resource and its parent.

Each parent client has a `get_<child>_client(self, name)` method. The `get_<child>_client(self, name)` method MUST return a child client even if the corresponding child resource does not yet exist.
Additionally, in addition to getting the client from its parent, it MUST be possible to create a child client created by providing the path (i.e. URL or list of [grandparent name, parent name, child name]) to the client requested.

Creation and deletion of a resource is exposed on the corresponding client. Bulk operations such as properties for all children are exposed on the parent client.

Getting properties for an individual resource is exposed on the corresponding client. If there is no client for the level (e.g. leaf nodes or omitted client levels), the get properties method is on the parent.

The most common convenience methods MAY be exposed as module level methods. 

## Client constructors

All clients should take a base url or name, a credentials object and an options object. For any create patterns that cannot easily be expressed this way (i.e. a connection string generally includes both base url and credentials), it should be exposed as a static or class methods named `from_<argument type>` (i.e. `from_connection_string` in the example of a connection string)


### Example structure

```
ExampleService
    |
    |- Child(ren)
        |
        |- Item(s)
```

```python

def mutate_children(base_ufl, client_name, credentials, options):
    """ Example module level method performing the most common operation on children
    """
    ...

class ExampleServiceClent:
    """ Root client.
    """

    def __init__(self, base_url, credentials, options):
        ...

    @staticmethod
    def from_connection_string() -> ExampleServiceClient:
        ...

    def get_child_client(self, name) -> ChildClient:
        ...

    def list_child_properties(self) -> Iteratable[ChildProperties]:
        ...

class ChildClient:

    def __init__(self, base_url, name, credentials, options):
        ...

    def create_child(self, name, properties) -> ChildProperties:
        pass

    def delete_child(self, name):
        ...

    def get_properties(self, name) -> ChildProperties:
        ...

    def list_items(self) -> Iteratable[Item]:
        ...

    def get_item(self, name) -> Item:
        ...

    def get_item_properties(self, name) -> ItemProperties:
        ...

class ChildProperties:
    ...

class Item:
    ...

class ItemProperties:
    ...

```
