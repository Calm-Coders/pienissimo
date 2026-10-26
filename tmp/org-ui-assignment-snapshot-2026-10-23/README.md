# Pienissimo UI assignment snapshot

Retrieved from the `partial pienissimo` org on 2026-10-23.

This is a pruned assignment-only snapshot. Salesforce stores UI assignments
across several metadata types:

- `unpackaged/unpackaged/profiles/*.profile`: page-layout assignments in
  `<layoutAssignments>`.
- `unpackaged/unpackaged/applications/*.app`: app, profile, record-type, and
  form-factor Lightning page assignments in `<profileActionOverrides>`.
- `record-page-objects/unpackaged/unpackaged/objects/*.object`: org-default
  Lightning record-page assignments in `View` `<actionOverrides>`. This second
  retrieve explicitly includes all standard and custom objects referenced by
  the retrieved record pages because a wildcard `CustomObject` retrieve omits
  standard objects.

Retained assignment metadata:

- 27 profiles
- 6 applications containing page-assignment overrides
- 15 record-page objects containing FlexiPage assignments

Retrieve jobs:

- Full assignment package: `09SMA00000BaI6Y2AV`
- Explicit record-page objects: `09SMA00000BaMi22AF`

The retrieved layout definitions, FlexiPage definitions, duplicate wildcard
object definitions, applications without assignment overrides, the object
without a FlexiPage assignment, generated manifests, and temporary ZIP
archives were removed because they do not carry additional assignment
information. No metadata was deployed and no files under `force-app/` were
overwritten by this retrieval.
