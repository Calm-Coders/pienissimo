---
id: OI-220
type: open-item
status: in-progress
owner: Anita Aga
with: Aurel Mrruku
org: ROMI
raised: 2026-10-08
updated: 2026-10-08
blocks: [go-live]
source: notes/meetings/2026-10-08 Internal Test.md
---

# OI-220 - A tranche with no products was reported saveable

**At the 08/10 internal session Aurel Mrruku reported a critical case found in
testing: a tranche could be saved with no products on it, which he attributed to
a missing control. The same afternoon Anita Aga's `1468961` added an explanatory
warning and two new due-date rules to both tranche components.**

## What was reported

From [the session](../meetings/2026-10-08%20Internal%20Test.md): Aurel Mrruku
_"segnala un caso critico riscontrato nei test, in cui risulta possibile salvare
una tranche priva di prodotti a causa dell'assenza di un controllo specifico"_,
and the group confirmed it had to be accounted for.

## What the repository shows

⚠ **The two readings do not line up, and the discrepancy is recorded rather than
resolved.** On `DevMain` at `8879f08`, `isSaveDisabled` in **both**
`quoteCreateTranche.js` and `bundleCreateTranch.js` already tested the line or
component list before today's commit:

```js
!tranche.quoteLineItemIds?.length    // quoteCreateTranche, pre-existing
!tranch.componentIds?.length         // bundleCreateTranch, pre-existing
```

So the Save button was already disabled for an empty tranche in the LWC path.
**What the path Aurel Mrruku exercised actually was — a different component, the
record page, or a server-side write — is not established by this sweep**, and no
Apex or validation rule enforces the rule.

## What `1468961` added

Anita Aga, 08/10 15:13 CEST, merged to `DevMain` via **PR #87**:

- **A visible warning** where the button was previously just dead —
  _"Questa tranche non contiene prodotti. Aggiungi almeno un prodotto prima di
  salvare."_, with a second wording when the tranche can still be deleted.
- 🆕 **Duplicate due dates block save** (`hasDuplicateDueDates`).
- 🆕 **Past due dates block save** (`hasPastDueDates`, floor of today).

Both getters were added to `isSaveDisabled` on both components.

## What closing it looks like

The path that produced the empty tranche identified and closed where it
actually is, and the rule enforced server-side rather than only in the two
LWCs — a client-side getter does not survive an API write, a flow or a data
load.
