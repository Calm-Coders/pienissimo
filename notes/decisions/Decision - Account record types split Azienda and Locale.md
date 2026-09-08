---
id: DEC-2026-09-08-account-record-types
type: decision
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-08
updated: 2026-09-08
source: notes/meetings/2026-09-08 Data Model Parte 4.md
depends_on: [OI-123]
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


## 2026-09-08 - the client agreed the same thing, in the same hours

This note was written from an internal instruction. **The client session of the
same day reached the same model independently**, which is worth recording because
it is the rare case where an internal design decision and a client decision
corroborate each other rather than one being reconstructed from the other.

[Data Model Parte 4](../meetings/2026-09-08%20Data%20Model%20Parte%204.md), 12:01
CEST, under `Concordato`:

> _"I locali vengono configurati come account figli dell'azienda di fatturazione
> su Salesforce, mentre a Mexal vengono inviate unicamente le aziende padri."_

The client session adds three things this note did not have:

1. 🟢 **The Mexal boundary.** **Only parent `Azienda` records are sent to Mexal.**
   Locali are a Salesforce-only construct. That is a hard integration rule and it
   was not in the internal framing.
2. 🟢 **The reason the model is needed.** The `locale` is the natural owner of the
   tutor questionnaire that Parte 3 deleted from the Contact with nowhere to put
   it — this **resolves
   [OI-123](../items/OI-123%20The%20Zoho%20questionnaire%20fields%20have%20no%20home.md)**.
   Elisa Migliano's constraint was that one company can own several locali on
   different terms.
3. 🟢 **Quotes get a lookup to the specific locale** of that company, and each
   child account **initially inherits the parent's principal contact**.

## ✅ Built and committed the same evening

**Commit `c877631`** (Anita Aga, PR **#35**, merged by Aurel Mrruku **18:21
CEST**) implements it:

- `Account/recordTypes/Azienda` and `Account/recordTypes/Locale`
- `locale_requires_parent_azienda` and `parent_must_be_azienda` validation rules —
  the two hierarchy guards this note asked for
- `AccountTriggerHandler` (53 lines) with company-delete protection — the deletion
  restriction
- `CommercialAccountResolver` (66 lines) — the Locale-to-parent normalisation
- ten Account fields, and `WoocommerceOrderService` and `LeadConversionQueueable`
  updated to resolve through the parent

**The closing sentence of this note is now out of date**: the metadata *has* been
built. Left in place above as the record of what was true when it was written.

⚠ **The 8 September org check called these components org-only drift.** It ran
**16:31-16:39 CEST**, ninety minutes before the merge, and reported
`AccountTriggerHandler`, `CommercialAccountResolver`, `AccountTrigger`, the record
types and ten Account fields as present in UAT and absent from the checkout. They
were committed at 17:53 and merged at 18:21. **The drift closed itself; the check
was a photograph of a moving branch** — the same lesson as 4 September, from the
same direction. **Diff `DevMain` before trusting any drift claim.**

⚠ **What the check found and the commit does *not* close**: the live
`WoocommerceOrderService` also sets `Order.OpportunityId` from the payload, and
`AnticipayAccountService` gained ATECO, description, tax-code and
refresh-timestamp mapping. Both classes are touched by `c877631` — **whether the
committed versions match what UAT is running was not re-verified after the merge.**
