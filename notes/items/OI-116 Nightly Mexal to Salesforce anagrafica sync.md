---
id: OI-116
type: open-item
status: open
owner: Aurel Mrruku
with: Andrea Di Cicco
org: ROMI
raised: 2026-09-03
updated: 2026-09-03
depends_on: [OI-58]
blocks: [go-live]
requirement: INT-01
source: notes/meetings/2026-09-03 Data Model Parte 1.md
---

# OI-116 - Nightly Mexal to Salesforce anagrafica sync

**After an account exists on Mexal, Mexal owns it. Salesforce gets the changes
back by a nightly batch — and that batch does not exist.**

Agreed at
[Data Model Parte 1](../meetings/2026-09-03%20Data%20Model%20Parte%201.md). It is
`F-2` on the client's own `Flussi` sheet — _"ogni notte aggiorniamo le anagrafiche
sfdc sulla base delle modifiche fatte su erp"_ — and Aurel Mrruku named it in the
room: _"noi lato sales[force] abbiamo il get notturno."_

## What it has to carry

Two distinct payloads have been agreed onto this one flow, in two different
sessions, and they should not be assumed to be the same job:

1. **General registry edits.** Anything amministrazione changes on Mexal after
   creation — the whole locked-field set behind
   [OI-117](OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md).
2. **Agent reassignment.** When Mexal receives an order whose agent differs from
   its own registry, it rewrites its registry and returns the new pairing on this
   flow. Fabrizio Paganelli: _"la notte, tramite il flusso di ritorno dei dati,
   va a modificare l'abbinamento che c'è tra cliente e agente."_

## Why this is a real gap and not bookkeeping

- 🔴 **Nothing is built.** `force-app/` holds no scheduled Apex, no batch and no
  Flow for it; the org held **zero project Flows** at the 2 September check.
- 🔴 **The integration scaffolding has never been configured** — zero rows in
  `Integration_Configuration__c`
  ([the note](../objects/The%20integration%20scaffolding%20has%20never%20been%20configured.md)),
  so this flow has no endpoint or principal to run against, exactly as Anticipay
  and the outbound Mexal legs do not.
- 🔴 **The direction is new.** Every Mexal leg in the record so far is
  Salesforce → Mexal or a read pulled on demand. This is the first **scheduled
  inbound** flow, and it writes to the customer registry — the object with 150
  fields and a live migration pending.
- ⚠ **Conflict handling was never discussed.** The lock in
  [OI-117](OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)
  is what keeps Salesforce from diverging, so the two are one design. If the lock
  is incomplete, the batch silently overwrites whatever a user typed.
- ⚠ **No window, no volume, no failure path.** "Nightly" is the whole
  specification. Against ~150 fields and the migration volumes in
  [OI-79](OI-79%20Migration%20volumes%20and%20mapping%20method.md), that is not
  enough to build from.

**Fase 1 development ends 10 September.** This was agreed on the 3rd, is unbuilt,
and has no estimate.
