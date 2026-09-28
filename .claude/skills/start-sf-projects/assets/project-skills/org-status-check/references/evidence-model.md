# Evidence model

Keep existence, deployment location and usability separate.

| Question                   | Primary authority                                                              | Not proof                              |
| -------------------------- | ------------------------------------------------------------------------------ | -------------------------------------- |
| What is required?          | The project's authoritative requirement record and atomic notes                | Notion or rendered recaps              |
| What is in source control? | Exact files under `force-app/` and their hashes                                | A live-org inventory                   |
| What is deployed?          | Metadata API, Tooling API and targeted read-only queries against the named org | `force-app/`                           |
| Does a field exist?        | Tooling `FieldDefinition`                                                      | `sf sobject describe` or ordinary SOQL |
| Can users access it?       | `FieldPermissions` plus object permissions                                     | field existence                        |
| What calls it?             | cited source                                                                   | semantic similarity alone              |
| Does it work?              | exact configuration plus targeted runtime evidence                             | component presence                     |

Use object-qualified component keys such as `field:OrderItem.Tranche__c`; never
key a field by its API name alone.

## Verdict axes

**Compliance:** `matches`, `partial`, `divergent`, `missing`, `unverifiable`.

**Deployment drift:** `aligned`, `repository-only`, `org-only`,
`content-mismatch`, `absent-both`, `unverifiable`.

**Operability:** `usable`, `permission-blocked`, `unconfigured`, `uncovered`,
`unproven`, `not-assessed`.

An absence finding must name the exhaustive authority searched. If the
instrument is visibility-filtered, incomplete, stale or failed, use
`unverifiable`, not `missing`. Label each conclusion `verified` or `inferred` and
state its concrete consequence separately.
