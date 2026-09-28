---
id: decision-uat-data-disposable
type: decision
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-02
updated: 2026-09-02
depends_on: []
blocks: []
source: Aurel Mrruku, direct instruction to the agent session, 2026-09-02
---

# Decision - UAT data is disposable in Fase 1

**Records in the Pienissimo UAT sandbox carry no value that has to be
preserved.** Deleting them is not a loss to be recovered from, and no migration
of existing test rows is owed.

Stated by Aurel Mrruku on 2026-09-02, in these terms: _"here we are in test
environment and we dont care about the data if we delete them"_.

## What it settles

- **The 37 deleted `Biglietto__c` records need no recovery.** The recycle-bin
  window that closed around 12 September was the only decaying deadline in the
  record; it decays to nothing that matters. Nobody needs to ask Anita Aga
  whether an export was taken before commit `5d8cdb3`
  ([the risk, now resolved](../risks/Risk%20-%20the%20Biglietto%20UAT%20ticket%20dataset%20was%20deleted.md)).
- **The same holds for tranche data.** Tranche and Order Item rows in UAT are
  equally disposable.
- **Asset going 4 -> 5 rather than 4 -> 41 is not a failed migration.** There
  was never a migration to perform. `Biglietto__c` -> Asset is a **build from
  scratch**, which is what [OI-41](../items/OI-41%20Asset%20and%20ticket%20data%20model.md)
  and [OI-74](../items/OI-74%20Asset%20state%20machine.md) already require.

## What it does not settle

- **Code is not data.** The seven Biglietto Apex components deleted in the same
  28 August deploy were never in this repository on any branch, and deleted Apex
  does not go to a recycle bin. That loss is separate, is not covered by this
  decision, and stays open —
  [the risk](../risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).
- **Empty data is not evidence of built code.** "0 of 18 order items carry a
  tranche" can no longer be cited as proof that propagation is unbuilt. That
  claim now rests on the source: no Apex in `force-app/` writes
  `OrderItem.Tranche__c` — `QuoteTrancheController` touches only `QuoteLineItem`
  and `Tranche__c`, and the two classes that do touch `OrderItem`
  (`OrderBigliettoTriggerHandler`, `WoocommerceOrderService`) never mention
  tranche. Verified in the repository at `326d362` on 2026-09-02.
- **Production data is out of scope.** This decision is about the UAT sandbox in
  Fase 1. It says nothing about the Zoho -> Salesforce import
  ([OI-79](../items/OI-79%20Migration%20volumes%20and%20mapping%20method.md)).

## Queued consequence

Aurel Mrruku will separately ask for **a purge of old and mismatching data** in
UAT. Not scheduled; recorded on
[the ROMI action board](../../docs/task-status.md) so it is not lost. Do not act
on it before it is requested.

Related: [Apex coverage is not a Fase 1 concern](Decision%20-%20Apex%20coverage%20is%20not%20a%20Fase%201%20concern.md).
