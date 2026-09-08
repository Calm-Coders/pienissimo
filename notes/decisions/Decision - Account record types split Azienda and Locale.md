---
id: DEC-2026-09-08-account-record-types
type: decision
status: in-progress
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-08
updated: 2026-09-08
source: user instruction in Codex session, 2026-09-08
---

# Decision - Account record types split Azienda and Locale

**Aurel Mrruku requested two Account record types: `Azienda` and `Locale`.** The
model separates the legal/commercial company from its operating locations while
keeping the commercial process anchored to the company.

## Record Types

- **`Azienda`** is the parent Account type. It represents the company/customer
  that owns the commercial relationship.
- **`Locale`** is the child Account type. It represents a venue/location that
  belongs to an `Azienda`.

## Relationship Rule

Every `Locale` must be linked to an `Azienda`. A `Locale` cannot be created
without a parent `Azienda`.

The implementation should enforce that the parent Account selected for a
`Locale` is an `Azienda`, not another `Locale`, so the hierarchy does not become
ambiguous.

## Deletion Restrictions

Deletion must be restricted so that an `Azienda` with one or more child `Locale`
records cannot be deleted without first handling those children.

The intended outcome is to avoid orphaned locations and to preserve the
commercial/accounting relationship history.

## Process Ownership

Commercial and operational processes remain related to the `Azienda` Account,
even when the user starts from, or chooses, a `Locale`.

This applies at minimum to:

- Opportunities
- Quotes
- Orders
- Related downstream processes that depend on the Account commercial owner

If a process is initiated from a `Locale`, the implementation should resolve and
store the parent `Azienda` as the Account used by the process.

## Implementation Implications

This decision likely requires:

- Account record types `Azienda` and `Locale`.
- An Account-to-Account parent lookup or use of the standard parent Account
  hierarchy, with validation that `Locale` records have a parent `Azienda`.
- Validation or automation preventing invalid parent/child combinations.
- Deletion protection for `Azienda` records with child `Locale` records.
- Updates to Opportunity, Quote, Order and any related creation flows so they
  normalize the Account to the parent `Azienda` when started from a `Locale`.

This note records the decision only. It does not claim the metadata has already
been built.
