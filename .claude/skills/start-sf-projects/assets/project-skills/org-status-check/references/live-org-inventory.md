# Live-org inventory

Collect read-only JSON evidence into a gitignored cache outside `force-app/`.
Record the org alias and id, observation time, repository commit, command or
query, and any failed or unsupported metadata types.

## Structure

- Enumerate relevant Metadata API component names in the selected scope.
- Inventory repository files exactly and use object-qualified keys.
- Use Tooling `FieldDefinition` for field existence. `sf sobject describe` and
  ordinary SOQL are field-level-security filtered and cannot prove absence.
- Query Tooling `FieldPermissions` and `ObjectPermissions`; field access is
  usable only when the same permission principal grants both.
- Read `ApexCodeCoverageAggregate`; do not execute tests to populate it.

A type-list or query failure makes related negative claims `unverifiable`; it
does not mean the result set is empty.

## Exact configuration

Metadata listing proves a name, not complete configuration. If a precise
picklist, layout, permission or Flow assertion requires retrieved XML, create an
explicit run directory under a gitignored cache, resolve it, verify it remains
inside that cache, and retrieve only the named component there with
`--target-metadata-dir` and `--unzip`.

Never use `--source-dir`; never target the repository root, `force-app/`,
`notes/`, `requirements/` or `meetings/`. Do not rely on `retrieve preview` for
an org without source tracking.

## Runtime evidence

Use only aggregates needed by a mapped requirement: counts, null counts, status
distributions or configuration-row counts. Never cache customer data,
credentials, endpoint URLs, catalogue prices or product codes.

Graphify and code indexes help locate relationships and implementation paths;
neither is an exhaustive inventory or proof of deployed state.
