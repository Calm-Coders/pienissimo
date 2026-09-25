---
id: OI-165
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-09-22
updated: 2026-09-24
depends_on: [OI-154, OI-24]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-09-22 Update Interno Aurel Elena.md
---

# OI-165 - Data migration was never planned or estimated

**Stated plainly by Aurel Mrruku at
[the internal update](../meetings/2026-09-22%20Update%20Interno%20Aurel%20Elena.md),
22/09 14:31 CEST:**

> _"sulla migrazione degli ordini… sinceramente io non avevo messo in piano, non avevo
> calcolato il tempo per la migrazione dei dati. Non sarà una cosa che si farà in un
> giorno."_

**Go-live is 21 October and Zoho expires 31 October.**

## What makes it more than a schedule gap

- 🔴 **The environment sequence is unbuilt.** Today's work is in a sandbox. Production
  means **moving the structures, migrating the data, then granting access** — in that
  order, with no slot for it on the calendar.
- 🔴 **The data is not clean.** Aurel Mrruku's specific worry is **missing links
  between the ids**, and the **insertion order** that would restore them. Elena Spini
  on the extraction: _"fanno cagare."_
- ⚠ **Historical orders are the hard part.** Fabrizio Paganelli kept the full product
  and customer registries deliberately, because a historical order portfolio cannot be
  imported if its article codes were filtered out: _"se non ci metto il codice
  articolo, come faccio a portarmi dentro i dati?"_ So the migration cannot be trimmed
  to the clean subset.
- ⚠ **The demo will use real records, not test ones** — Elena Spini's call, because
  _"conoscendo i miei polli, se vedono 'test' si agitano, non capiscono niente"_. That
  makes a partial, imperfect import a UAT dependency rather than a post-UAT task.
- **A field was added to the model on 22/09** (the product tranche count,
  [OI-167](OI-167%20Plus%20orders%20explode%20from%20a%20tranche%20count%20on%20the%20product.md)),
  so the mapping is still moving while the import is being prepared.

## What is scheduled

🟢 **`Check Data Import`, 23/09 10:00–12:00**, booked in-session at
[the 11:22 client call](../meetings/2026-09-22%20Logiche%20Spacchettamento%20Righe.md) —
Aurel Mrruku, Elena Spini, Fabrizio Paganelli, Elisa Migliano. Its purpose is to walk
the field list object by object and decide what travels. Fabrizio Paganelli offered as
many sessions as it takes: _"possiamo fare anche 10 call su questo argomento, perché se
scaziamo qui scaziamo tutto."_

🟢 On 23/09 the team also intends to **import the client's accounts and delete the test
ones**, per
[the pre-UAT session](../meetings/2026-09-22%20Test%20Interni%20Pre-UAT%20Parte%202.md).

## Open

- 🔴 **Estimate the migration and put it on the plan.** Nobody has. Elena Spini's
  `#tproj-pienissimo` post of 21/09 carries `Stima giornate a finire: 30` with no unit
  stated, and this work is not visibly inside it.
- 🔴 **Decide the production sequence and who does it.**
- ⚠ The 2026 extraction is a **Saturday snapshot** from Zoho, re-extractable by design,
  so a cut-over refresh is possible — but not planned.

## 2026-09-23 — the perimeter exists now; the plan still does not

**[Check Data Import](../meetings/2026-09-23%20Check%20Data%20Import.md), 2h29m with the
client.** This is the first session that treats migration as its own subject.

### 🟢 What is now decided

- **The perimeter.** Orders only; quotes, offers and opportunities start ex novo →
  [OI-172](OI-172%20Historical%20quotes%20and%20offers%20are%20not%20migrated.md).
- **The account join key** is `codice cliente esterno`, not the system id.
- **Contacts import only where a company name exists**; the rest await the direzione
  **from 1 October**, and load as both lead and contact for testing only.
- **Test data is hand-filtered** to records carrying P.IVA and a valid company id,
  rather than loading the unstructured block.
- 🟢 **A real load ran the same day.** 1,010 articles were upserted by Bulk API with
  zero failures, with Standard Price Book entries for all of them. Recorded by the
  developers on `DEV_LeadAgenteBundle`, in the
  [OI-154](OI-154%20The%20client%20import%20extraction%20is%20missing%20the%20article%20classification.md)
  note; **that note was not edited on `DevMain`** — see the 23/09 trace.

### 🔴 What the session exposed

- **The locali extraction is broken**: every row carries the same id except row 20.
  Fabrizio Paganelli owes a corrected **V1** file.
- **The account key field overran the 40-character limit** — it held an HTTP address plus
  an identifier — and was patched in Excel with a `RIGHT()` of the last 15 characters.
  ⚠ A join key produced by a spreadsheet formula on the client's side is a **cut-over
  fragility**, not a fix.
- **The migration/orders session was postponed**, at Aurel Mrruku's request, because he
  was fielding questions from the developers. Its 24/09 10:00 slot went to
  [OI-173](OI-173%20San%20Marino%20fiscal%20transcoding%20table.md) instead, and **no new
  date was set for it** in this window.

### 🔴 Unchanged

**There is still no estimate, no production sequence and no owner for the cut-over.**
Go-live is **21/10** and Zoho stops **31/10**. Everything above is UAT test data, which
[the standing decision](../decisions/Decision%20-%20UAT%20data%20is%20disposable%20in%20Fase%201.md)
says is disposable — **none of it is the production migration.**

## 2026-09-24 — Account_NEW loaded into UAT

At the user's direction, the `Account_NEW` sheet of the supplied Excel snapshot
(SHA-256 `e264a2e656a0c43641754f8be18d10011b9953f34b4453c95f68a9b0b6c84d1f`)
was mapped and loaded into **Pienissimo UAT**. Of 8,597 source rows, 457 without
Partita IVA were excluded and 8,140 qualified Accounts were imported: 8,138
new records and 2 updates to existing Accounts. The final UAT query found
8,140 Accounts with the new external CRM ID, all with Partita IVA, Mexal code,
`Agente__c`, the `Azienda` record type and an inactive Agent user. The two
existing Account owners were preserved; new Accounts belong to the active
`Amministratore Pienissimo` user. The row's original `Codice_agente` is in
`Codice_Agente_Esterno__c` on 8,139 Accounts; one source value was blank.

The load had 59 duplicate-rule alerts and one invalid PEC. All 60 rows were
recovered by individual REST upserts using the rule's `Allow` action; the
invalid PEC was left blank. No source customer rows or values are committed
to the repository. The local preparation script is
`scripts/prepare_account_new_import.py`.

**This is UAT test data, not the production migration.** Production cut-over,
historical orders, and the migration estimate remain open. The two existing
Account updates also triggered a Mexal customer update; see
[the ERP risk](../risks/Risk%20-%20the%20Mexal%20integration%20is%20developed%20against%20the%20production%20ERP.md).

## 2026-09-24 — commercial fields added to the UAT Account load

At the user's direction, the later `Account Salesforce_V2.xlsx` snapshot
(SHA-256 `edf51cbb214ee7633ac7a852b7539b0e1523ab1f5bae0a308f8586d5721bb2f3`)
was matched by its 8,140 CRM IDs to the same 8,140 UAT Accounts. Four Account
fields were deployed: commission category (Text), zona (Text), activity type
(multi-select picklist) and seasonal (Checkbox). The Account and Locale layouts
and record pages now expose the applicable fields. The data update filled
8,138 commission categories and 181 activity types. Zona had no source values;
the snapshot had no seasonal column, so the checkbox has only its technical
default `false`, not a verified business classification. Two source category
values were blank. A full source-to-UAT read-back found zero mismatches in the
two imported fields.

The update CSVs held only Salesforce Account IDs and the new commercial fields.
The live Account trigger enqueues Mexal customer updates only when Name,
`Email__c`, Phone or Partita IVA changes; none of those was in the update.
No `MexalCustomerUpdateQueueable` job appeared after the deploy or data jobs.
This was still a **UAT** load, not production cut-over.

## 2026-09-24 — ATECO activity state backfilled in UAT

The current Account model workbook identifies three ATECO fields. Code and
description already existed in UAT and the imported `Account_NEW` data held
1,141 codes and 1,134 descriptions. `Ateco_Stato_Attivita__c` was added as an
unrestricted picklist with the three source values. It was populated on 377
of the 8,140 eligible Accounts; the other source values were blank. Read-back
of every imported Account showed zero mismatches. The update CSVs contained
only Account ID and the new ATECO-state field. No Mexal customer-update job
appeared after the update. This remains UAT data, not production cut-over.

## 2026-09-24 — the Business Blueprint names the perimeter; the plan is still missing

`Business_Blueprint_Pienissimo.docx` §5 states the initial load as **one shot**, covering
four entities from Zoho: **Lead, Account/Aziende/Locali, Contatti, Ordini/Righe**. It
confirms [OI-172](OI-172%20Historical%20quotes%20and%20offers%20are%20not%20migrated.md)
by omission — quotes and offers are not on the list — and adds that product master data
is born on Mexal and imported by **nightly batch**, with the bundle the sole exception.

🔴 **A list of entities is not a plan.** Still no estimate, no production sequence, no
cut-over owner, no date for the orders/migration session that was postponed on 23/09.
**Go-live 21 October, Zoho expires 31 October.**

🔑 The UAT account load gives the first real measure of effort: Aurel Mrruku, session
`02:04:26`, spent **about six hours** loading the accounts into a Partial Copy sandbox and
still had fields to correct — and bad input (wrong email addresses, missing P.IVA) breaks
order generation downstream.
