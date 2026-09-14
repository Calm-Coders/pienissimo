---
id: OI-116
type: open-item
status: open
owner: Aurel Mrruku
with: Andrea Di Cicco
org: ROMI
raised: 2026-09-03
updated: 2026-09-14
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

## 🟢🔴 2026-09-10 - the read half is written, on an open PR

**`bc2ed5d`** (Anita Aga, PR **#39**, **open and unmerged** against `DevMain`)
adds `MexalCustomerSearchService` and `MexalSearchCalloutService` —
**the first Mexal Apex this repository has ever held**
([the build](../objects/The%20first%20Mexal%20integration%20Apex.md)).

🟢 **Three of the four "nothing is built" bullets above are now answered.** The
callout exists, it is authenticated by Named Credential rather than a pasted
secret, it builds the agreed `data_ult_mod >=` delta filter, and it maps
**fourteen Mexal customer fields onto `Account`** — including `codice_sdi`, `pec`
and a reconstructed IBAN.

🔴 **But this is a read, not a sync, and three gaps are unmoved:**

1. **Nothing persists.** The mapped `Account` objects are returned in memory.
   **No DML, no upsert, no matching on `Codice_Cliente_Mexal__c`** exists in
   either class. Mexal's changes reach Salesforce's heap and stop there.
2. **The nightly job is deliberately not built**, and the code says why:
   _"Automatic daily search is intentionally paused while the Mexal sync schedule
   and date window are finalized."_ The `Schedulable` and the `0 0 2 * * ?` cron
   are written out **as comments**. **That blocker is this note's own** — "no
   window, no volume, no failure path" has been the specification since
   3 September, and the developer has now hit it in code.
3. **Payload 2 — agent reassignment — is not handled.** `cod_agente` is not among
   the fourteen mapped fields, and nothing reads the returned pairing.

🔴 **`Integration_Configuration__c` still holds zero rows**, so even the read
throws on its first call
([the scaffolding note](../objects/The%20integration%20scaffolding%20has%20never%20been%20configured.md)).
Two configuration rows are now needed by name: **`Mexal_Clienti_Ricerca`** and
**`Mexal_Articoli_Ricerca`**. Nobody owns creating them.

🔴 **[OI-117](OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)
is untouched**, and this note has always said the two are one design. If the
persistence half is added before the lock, a user edit is overwritten silently —
exactly the failure this row warned of.

⚠ **Fase 1 development ends today, 10 September.** This was agreed on the 3rd. It
has a read, no writer, no schedule, no configuration rows, and its lock is
unbuilt — on a pull request nobody has reviewed.

**What a person must decide:** the sync window and watermark. The code is
blocked on it and says so.

## 2026-09-11 — the writer arrived; the schedule did not

`80420cf` (PR #41, merged 18:05 CEST) gives this row **the DML it lacked
yesterday**. `MexalCustomerSearchService` now ends in

```
applySaveResults(Database.update(accountsToUpdate, false), true, result);
applySaveResults(Database.insert(accountsToInsert, false), false, result);
```

🟢 Partial-success DML, per-row errors collected, inserts stamped with the
**`Azienda`** record type, ambiguous matches **skipped rather than guessed**, and
a blank `Name` refused instead of inserted. That is a careful writer, not a
hurried one.

🔴 **The nightly job is still commented out, and the blocker is word-for-word the
one this row has carried since 3 September** — _"paused while the Mexal sync
schedule and date window are finalized."_ `MexalCustomerSearchScheduler` remains
a comment with its cron.

**So this row's diagnosis changes shape: it is no longer "a read, not a sync" but
"a sync with no schedule."** The remaining half is not code. It is the **sync
window and watermark**, unspecified for nine days, and it is now the only thing
between this and a running nightly job.

🔴 **Four configuration rows are now needed by exact name**, not two —
`Mexal_Clienti_Ricerca`, `Mexal_Articoli_Ricerca`, `Mexal_Clienti_Creazione`,
`Mexal_Clienti_Modifica` — and the table they live in **was renamed to
`Integration_Configuration2__c`** the same day. Still zero rows, still no owner.

🔴 **[OI-117](OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)
is still unbuilt, and the warning above is now live rather than hypothetical.**
This row has always said that persistence without the lock lets a user edit be
overwritten silently. The persistence half shipped today. The lock did not.

**What a person must still decide:** the sync window and watermark. Unchanged for
nine days, and now the single blocker.

## 2026-09-14 — the batch, the scheduler and the watermark all exist, in the org only

The org-status-check against Pienissimo UAT found three classes created that
morning at **09:44 UTC** that answer almost everything this row has asked for —
and **none of them is in this repository**
([the build](../objects/The%20order%20to%20Mexal%20integration%20chain.md),
[the risk](../risks/Risk%20-%20the%20Mexal%20order%20integration%20exists%20only%20in%20the%20org.md)):

- `MexalCustomerSyncBatch` — the nightly batch itself, no longer a comment;
- `MexalCustomerSyncScheduler` — its `Schedulable`;
- `MexalSyncCursorService` — **the watermark**, the thing this row has been
  blocked on since 3 September.

🟢 **Four of the blockers this note has carried are cleared.** The read has a
writer, the writer has a batch, the batch has a scheduler, and the delta has a
cursor rather than a hardcoded window.

🟢 **The configuration rows exist.** `Integration_Configuration2__c` holds **six
rows**, not zero: `Mexal_Clienti_Ricerca`, `Mexal_Clienti_Creazione`,
`Mexal_Clienti_Modifica`, `Mexal_Articoli_Ricerca`, `Mexal_Ordini_Creazione` and
`Anticipay_Account_Check`. **All four rows this row said were needed by exact
name are present.** The "zero rows, no owner" reading carried since 26 August is
superseded — see
[the scaffolding note](../objects/The%20integration%20scaffolding%20has%20never%20been%20configured.md).

🔴 **Nothing is scheduled.** The org holds **seven `CronTrigger` rows and every
one is a Salesforce platform job** — comm sitemap, SRT, ReportType, Metalytics.
`MexalCustomerSyncScheduler` has never been scheduled against them.

**So the diagnosis of 11 September stands word for word: a sync with no
schedule.** What has changed is that it is no longer blocked on a decision. The
watermark exists in code. **Someone has to run `System.schedule` and choose the
hour** — that is now the whole remaining task, and it is minutes of work.

🔴 **Payload 2 — agent reassignment — is still not handled.** `cod_agente` is
still not among the mapped fields, unchanged since 10 September.

🔴 **The conflict with [OI-117](OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)
is now live in both directions.** The org also gained
`MexalCustomerUpdateQueueable`, which pushes Salesforce admin edits **out** to
Mexal. This inbound batch writes the same fields **in**. Two writers, opposite
directions, **no conflict rule and no minute**. The silent-overwrite failure this
row has warned of since 3 September now has a second way to happen.

**What a person must still decide:** the schedule hour, and which side wins when
the nightly read and the outbound push disagree.
