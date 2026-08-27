# Live-org inventory

This procedure collects read-only, sanitized evidence. The helper scripts are
the preferred path because they use JSON output, canonical component keys and a
fixed cache location.

## Standard commands

From the repository root:

```powershell
npm run org-status:snapshot:repo
npm run org-status:snapshot:org -- --target-org <alias>
npm run org-status:compare
npm run org-status:validate
```

Outputs live under `.org-status-cache/`:

- `repository.json` — exact source-file inventory and selected metadata facts;
- `org.json` — sanitized org identity, metadata names, fields, FLS and coverage;
- `comparison.json` and `comparison.md` — deterministic structural assertions.

The cache is evidence for the run, not a project source of truth. Do not commit
it or quote it after a newer snapshot supersedes it.

## Field existence and visibility

`sf sobject describe` and ordinary SOQL are filtered by the running user's
field-level security. A deployed custom field granted to nobody appears exactly
like a field that does not exist. System Administrator does not bypass this.

Use Tooling API instead:

```sql
SELECT EntityDefinition.QualifiedApiName, QualifiedApiName, DataType,
       IsNillable, IsUnique, IsExternalId
FROM FieldDefinition
WHERE EntityDefinition.QualifiedApiName = '<Object>'
ORDER BY QualifiedApiName
```

Then query field visibility and the matching object's access for the same
permission principal:

```sql
SELECT Field, Parent.Name, Parent.Profile.Name,
       PermissionsRead, PermissionsEdit
FROM FieldPermissions
WHERE Field IN ('<Object>.<Field>__c')

SELECT SobjectType, Parent.Name, Parent.Profile.Name,
       PermissionsRead, PermissionsCreate, PermissionsEdit, PermissionsDelete
FROM ObjectPermissions
WHERE SobjectType IN ('<Object>')
```

Field access is usable only when the same profile or permission set also grants
the required object access. Rows whose permission-set name begins `sfdc_` or
`sfdcInternalInt__` are
platform internals, not a project grant. Auto-named permission sets that expose a
real `Parent.Profile.Name` are profile grants and must not be discarded.

See `notes/How to read the org schema without a false negative.md` for the
failure that established this rule.

## Component inventory

Use Metadata API listing for component names and Tooling API for fields and
coverage. The helper currently inventories these types when supported:

- CustomObject, ApexClass, ApexTrigger, Flow;
- PermissionSet, Profile, Layout, QuickAction;
- NamedCredential, RemoteSiteSetting, CustomNotificationType;
- ApprovalProcess, Workflow, EmailTemplate and CustomTab.

A type-list failure is recorded as unavailable and makes related negative
claims `unverifiable`; it is not silently treated as an empty result.

Coverage comes from `ApexCodeCoverageAggregate`. Do not run tests to populate it:
this project schedules the Apex test task separately before production deploy.

## Exact metadata configuration

Metadata listing proves a component name, not its full configuration. When
Tooling queries cannot answer an exact picklist, layout, profile or Flow
question, a targeted reference retrieve is allowed only into an isolated cache:

```powershell
$run = Resolve-Path -LiteralPath '.org-status-cache/<run>'
sf project retrieve start `
  --target-org <alias> `
  --metadata '<Type>:<Component>' `
  --target-metadata-dir "$run/mdapi" `
  --unzip `
  --json
```

Before running it, create and resolve the explicit run directory and verify it
is inside `.org-status-cache/`. Never use `--source-dir`; never point
`--output-dir` or `--target-metadata-dir` at the repository root, `force-app/`,
`notes/`, `requirements/` or `meetings/`. The retrieve is reference evidence and
must not overwrite the repository's claim.

Pienissimo UAT is a partial sandbox without source tracking, so
`sf project retrieve preview` fails with `NonSourceTrackedOrgError`. Do not use
that failure as an excuse to skip repository/org comparison.

## Runtime and data-state evidence

Query only aggregates needed by a mapped requirement or a suspected mismatch:
counts, null counts, status distributions and configuration-row counts. Never
cache record names, customer data, credentials, endpoint URLs, catalogue prices
or article-code values.

Use `--json` for every Salesforce CLI call. Record the query, alias, org id and
observation time in the evidence row. A query failure makes that row
`unverifiable`.

## Intelligence routing

- Graphify is preferred for Salesforce relationships, permission reach, order
  of execution and downstream impact. Treat inferred edges and violation output
  as leads; inspect the cited metadata.
- Open Codebase Index is preferred for definitions, callers and code paths. If
  its provider is unavailable, use exact `rg` and direct file reads.
- Neither generated index is an exhaustive inventory or proof of deployed state.
