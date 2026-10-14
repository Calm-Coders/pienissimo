---
id: OI-235
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-14
updated: 2026-10-14
source: notes/meetings/2026-10-14 UAT Test e2e.md
---

# OI-235 - A contract is linked to the account but hidden in the tab

**At the 14/10 e2e Elisa Migliano expected to see two contracts on the account —
one for the activation, one for the renewal — and could not. Aurel Mrruku
established that the contract is correctly linked to the account but does not
appear in the tab view, which he attributed to the number of earlier orders on
the record.**

## What the record says

[The 14/10 e2e](../meetings/2026-10-14%20UAT%20Test%20e2e.md) (`01:58:06`): Aurel
Mrruku examined the account for order 130, had Elisa Migliano refresh the page,
confirmed no relevant filters were in play, and found

> _"il contratto è correttamente collegato all'account, ma risulta nascosto a
> causa di un problema di visualizzazione nel tab dovuto alla presenza di
> numerosi ordini precedenti."_

The next-step list assigns the investigation to him:

> **\[Aurel mrruku\] Risolvere visualizzazione contratti:** _Verificare le cause
> per cui il contratto non risiede visibile nella visualizzazione tab nonostante
> sia correttamente collegato all'account._

## Why it matters more than a display glitch

- 🔑 **The data is intact and the user cannot see it.** The failure mode is the
  one that produces wrong commercial decisions quietly: a tutor or administrator
  concludes no contract exists and issues another.
- ⚠ **The diagnosis is a hypothesis, stated once, in the room.** "Numerous
  earlier orders" is consistent with a related-list row cap or a list-view filter
  or sort, and **none of the three was checked.** Recorded as the cause he gave,
  not as an established cause.
- ⚠ **It appeared on the account the whole session used**, `pienissimo srl`,
  which by then carried both an activation and a renewal chain. A freshly
  migrated production account with years of Zoho history behind it has more
  earlier orders, not fewer, and migration is the 15/10 agenda.

## What closing it looks like

The real cause named — row cap, filter, sort or record-type visibility — the fix
applied, and both contracts visible on the account that reproduced it.
