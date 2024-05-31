# item-taxonomy

An open source `item_type` taxonomy which builds the foundations for common reporting and carbon impact tracking across multiple libraries.

Intended use is hierarchical, so as we get more detail on categories we don't need to ascertain the emissions factor for each level of detail, as long as a parent has an approximate value.

Consumers will pull the data into their reporting engine, where they can add mappings to their own items, or overrides for specific details (eg emission factor). The `updated_at` column allows the consumer to report on updates, and present a diff to the user for the user to decide whether to update their local data store.

# Todo

- [ ] Figure out translations
- [ ] Stabilise the minimum core set of categories
- [ ] Script to auto-build the full name
- [ ] Hosted UI to build out the initial set of version 0
