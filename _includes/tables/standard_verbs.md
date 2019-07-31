| Verb              | Parameters        | Returns      | Comments |
|:------------------|:------------------|:-------------|:---------|
| `create_\<noun>`  | key, item         | Created item | Create new item. Fails if item already exists.|
| `upsert_\<noun>`  | key, item         | item         | Create new item, or update existing item. Verb is primarily used in database-like services |
| `set_\<noun>`     | key, item         | item         | Create new item, or update existing item. Verb is primarily used for dictionary-like properties of a service |
| `update_\<noun>`  | key, partial item | item         | Fails if item doesn't exist. |
| `replace_\<noun>` | key, item         | item         | Replaces an existing item. Fails if the item doesn't exist. |
| `append_\<noun>`  | item              | item         | Add item to a collection. Item will be added last. |
| `add_\<noun>`     | index, item       | item         | Add item to a collection. Item will be added at the given index. |
| `get_\<noun>`     | key               | item         | Raises an error if item doesn't exist |
| `list_\<noun>`    |                   | `Pageable[Item]` | Return an iterable of items. Returns iterable with no items if no items exist |
| `\<noun>\_exists` | key               | `boolean`    | Return `True` if the item exists. Must raise an error if the method failed to determine if the item exists (for example, the service returned an HTTP 503 response) |
| `delete_\<noun>`  | key               |              | Delete an existing item. Must succeed even if item didn't exist.|
| `remove_\<noun>`  | key               | removed item | Remove a reference to an item from a collection. This method doesn't delete the actual item, only the reference.|
