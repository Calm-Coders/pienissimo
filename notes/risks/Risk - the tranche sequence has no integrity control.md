---
id: risk-tranche-sequence-integrity
type: risk
status: open
severity: medium
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-26
updated: 2026-08-26
depends_on: [OI-50]
blocks: [OI-75]
source: org-status-check against Pienissimo UAT, 2026-08-26
evidence: SOQL on Tranche__c ordered by CreatedDate; ValidationRule listing, Pienissimo UAT
---

# Risk - the tranche sequence has no integrity control

`Tranche__c.Sequenza__c` is the field
[ticket availability](../items/OI-75%20Ticket%20availability%20rule.md) reads to
decide what "every tranche before this one" means. **Nothing constrains it.**

The six tranches in Pienissimo UAT on 2026-08-26:

| Record    | Quote   | `Sequenza__c` | `Stato__c`          |
| --------- | ------- | ------------- | ------------------- |
| `TR-0000` | quote A | **null**      | Aperta              |
| `TR-0001` | quote A | **null**      | Aperta              |
| `TR-0002` | quote A | **null**      | Aperta              |
| `TR-0006` | quote B | 1             | Aperta              |
| `TR-0007` | quote B | **4**         | Aperta              |
| `TR-0009` | quote B | **3**         | Parzialmente Pagata |

Quote B's three tranches are numbered **1, 4, 3** — a gap at 2, out of creation
order, and no tranche 2 exists on any quote. Quote A's three carry **no sequence
at all**; they predate the field, which was added 2026-08-25T09:49:46Z.

There is **no validation rule on `Tranche__c`** — the org has exactly two
validation rules and both are on `BundleComponent__c` — and no Flow, so nothing
enforces uniqueness, contiguity, or presence.

## Why it matters

[OI-75](../items/OI-75%20Ticket%20availability%20rule.md) releases a ticket when
its tranche **and every tranche before it** is paid in full. "Before" is only
meaningful if the sequence is a total order over the tranches of one quote.
With the data above:

- a **gap** means a rule reading "all tranches with `Sequenza__c` < mine" can be
  satisfied while an unpaid tranche is missing from the comparison entirely;
- a **null** means the first three tranches sort undefined against each other,
  so a quote can have no first tranche;
- nothing prevents **two tranches sharing a number** on the same quote, which
  makes "before" ambiguous rather than merely wrong.

None of this has cost anything yet, because the release rule is unbuilt and
these six records are development data. It becomes expensive at the moment the
rule is written against a field the data does not support.

## Also observed: the state moved with no automation behind it

`TR-0009` reads **`Parzialmente Pagata`**; on 2026-08-25 all six tranches were
`Aperta`. There is no Flow, no trigger and no scheduled job on `Tranche__c`, and
`Integration_Log__c` is empty — so **the state was set by hand**. That is
consistent with [OI-50](../items/OI-50%20Tranche%20object.md), which records the
aggregation mechanism as unverified and unbuilt: `Completamente_Pagata__c` is
still a checkbox nothing computes.

Nothing is wrong with a manual edit in UAT. It is recorded so that a later
reader does not take a populated `Stato__c` as evidence that payment roll-up
works.

## What closes it

Decide whether `Sequenza__c` is user-supplied or system-assigned — the guided
creation UI could assign it — then enforce the decision. Until then the field
should not be treated as an ordering key by anything downstream.
