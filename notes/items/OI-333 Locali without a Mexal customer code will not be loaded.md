---
id: OI-333
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku
org: both
raised: 2026-11-04
updated: 2026-11-06
depends_on: [OI-310]
blocks: [go-live]
source: notes/meetings/2026-11-04 Continuazione Test e2e PROD.md
---

# OI-333 - Locali without a Mexal customer code will not be loaded

**A Locale is a child Account and its parent is resolved by the parent's Mexal
customer code. The client's Locali list — delivered 4 November and described by him
as provisional — has many rows with no Mexal code, which cannot be attached to a
parent. Aurel Mrruku argued against loading them; the client agreed within twenty
minutes to load only the coded rows.**

## The rule

Aurel Mrruku, in
[the 04/11 session](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md):

> _"i locali devono avere il riferimento dell'account, quindi il codice Mexal
> dell'account."_
>
> _"se un locale non ha un'azienda, per me non è collegato a un parent, quindi
> non verrà mai usato, perché quando fai le offerte lo devi per forza collegare a
> un'azienda quell'offerta."_

So an uncoded Locale is not merely incomplete — it is unreachable, because quotes
are created only on companies: _"i preventivi si devono creare solo sulle
aziende."_

Fabrizio Paganelli saw the cost immediately: _"questa la vedo più dura. Comunque
ci proviamo."_

## 🟢 The decision, settled by mail the same hour

| Time (UTC) | Who                | What                                                                                                                                                               |
| ---------- | ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 15:50      | Fabrizio Paganelli | `Lista Locali` + `Locali Salesforce.xlsx`: _"Anche questa è provvisoria. Inoltre ci sono molti locali senza codice cliente mexal. Li potete caricare ugualmente?"_ |
| 16:03      | Aurel Mrruku       | _"Secondo me è meglio di non caricare i locali che non hanno un'azienda per non rischiare di avere record zombi in produzione."_                                   |
| 16:21      | Fabrizio Paganelli | **_"Caricate allora solo quelli che hanno codice mexal."_**                                                                                                        |

🔑 **The reason given is production hygiene** — "record zombi" — not effort, and the
client accepted it without argument.

## Where it stands

🟢 **Decided.** 🔴 **Open on three counts:**

1. 🔴 **Nobody knows how many rows are excluded.** The workbook was **not opened** —
   it carries real customer records — so the count of uncoded Locali is unknown to
   this record. ⚠ The client's own words were _"molti"_.
2. 🔴 **There is no path back for the excluded rows.** No one said who re-codes
   them, when, or whether they are re-delivered in the 12-13 November delta
   ([OI-310](OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md)).
   A venue that exists in the client's business and not in Salesforce is a venue a
   tutor cannot quote against.
3. ⚠ **The file is provisional and is the only Locali source.** A second version is
   implied by _"provvisoria"_ and has no date.

## What was verified working

In the same session Fabrizio Paganelli created a Locale in production end to end
and the dependent behaviour held:

- 🟢 Locale created as a child Account with city, name and **`Tipologia Attività`
  multi-select** — _"Tipologia attività molto importante perché puoi scegliere più
  di uno."_
- 🟢 The Locale and its activity type are **carried onto the quote automatically**
  when the Locale is chosen — _"lo prendi in automatico la tipologia perché avevi
  scelto il locale."_
- 🟢 **Both creation paths end in the same place** — from the parent company or from
  the Locale itself: _"è la stessa cosa, solo che sono due punti diversi di
  creazione delle opportunità."_ The opportunity links to the parent either way.
- 🆕 Aurel Mrruku offered a quick action to create a Locale from the parent Account
  — recorded in [OI-330](OI-330%20The%20product%20selection%20screen%20is%20unusable%20for%20multiple%20products.md).

**Closing it:** the coded Locali in production, attached to their parents, and a
recorded answer for the uncoded ones.

## 🔑 2026-11-05 - the file analysed against Prod: 768 excluded, 3,918 loadable, and every one blocked by a validation rule

Read-only analysis by Claude Code of `Locali Salesforce.xlsx` against **Pienissimo
Prod**, after the 8,262-row Aziende load
([OI-310](OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md)).
Aggregates only. Nothing loaded.

- **4,686 Locali.** The parent link is the column `Codice Cliente Mexal`, the
  parent's code; the column `Azienda` is the parent's Zoho id.
- 🟢 **Open point 1 answered: 768 rows are excluded** — the code column reads
  `#N/A`, and 761 of them have no parent Zoho id either.
- 🟢 **The other 3,918 all resolve to exactly one Prod Azienda**, and wherever the
  Zoho id is present it points to the same account. Every parent has an `Agente__c`;
  none is a test account. Locale Zoho ids are unique and collide with nothing in Prod.
- 🔴 **Every loadable row fails `Tipologia_Attivita_required_for_Locale`**: the file
  has no Tipologia column, and only 187 of the parents carry one to inherit. A
  client answer (a Tipologia per Locale, inheritance plus default, or a load with
  the rule off) is needed before any insert.
- ⚠ **Four columns have no Prod field**: `Attivo` (1,380 loadable rows `No`),
  `Stato Cliente`, `Tipo Cliente`, `Tipo Locale` (Madre/Figlio). Only `Stagionale`
  maps (`Stagionale__c`).
- ⚠ 12 rows repeat a Locale name under the same parent.
- 🔑 The Locale must **not** carry the parent's `Codice_Cliente_Mexal__c`: the field
  is not unique, the code is the parent's identity, and an edit to a coded Account
  queues a Mexal customer update.

## 🟢 2026-11-05 - 3,918 Locali loaded into Prod, each under its Azienda

On Aurel Mrruku's instruction, the Tipologia blocker above was resolved by
**inheriting the parent's Tipologia (187 rows) and otherwise writing the default
`Attività diversa da somministrazione` (3,731 rows)**, with the validation rule left
active. **Inactive Locali were loaded too** (all 3,918).

- Bulk API `750SW00000bMk5NYAS` (1-row sample, checked first) and
  `750SW00000bMkdFYAS` (3,917), from 16:37Z. **3,918 succeeded, 0 failed.**
- Verified in Prod: all 3,918 are `Locale` with a `ParentId` of record type
  `Azienda`, spread over 3,544 parents; all carry the parent's `Agente__c`; **none
  carries a Mexal code**. Keyed by the Locale's Zoho id in `External_CRM_ID__c`.
  Owner `Amministratore Pienissimo`.
- 🟢 No `AsyncApexJob` and no `Integration_Log__c` since the load began.
- 🔴 **The 3,731 default Tipologie are placeholders, not data** — the client must
  supply the real value; the list was handed over as an Excel with the 768 excluded
  rows and the 12 same-name rows (kept outside the repository). `Attivo`, `Stato
Cliente`, `Tipo Cliente` and `Tipo Locale` were not loaded (no Prod field).

**Still open:** the 768 uncoded Locali (open point 2) and the real Tipologie.

## 🟢 2026-11-05 16:46Z - the exclusion list is with the client

Aurel Mrruku mailed `Locali non inseriti in Salesforce.xlsx` to Fabrizio Paganelli,
Elena Spini and amministrazione in copy (Gmail `1a1ac9aaf31e501d`):

> _"allego qui la lista dei locali non inserito con la loro mottivazione nella prima
> colona."_

🟢 **So open point 2 — what becomes of the excluded rows — is now in the client's
hands with a reason per row**, the same pattern used for the Referenti the same
evening. ⚠ **The mail states no count**, and the attachment was not opened (real
customer records); the 768 figure comes from the load record above, not from this
mail. 🔴 **No reply, and no date asked for one.**

## 2026-11-06 — the client edited the Locali file the day after getting the exception list

🔑 **`Locali Salesforce.xlsx` was modified on 6 November at 10:33:36Z**, Drive
`1GaL_3UR7S7yjZm3bbQ-RMkYmxjXdt_hl`, owner `fabrizio.pienissimo@gmail.com` — the
day after the list of rows that could not be loaded went back to him with a reason
per row (`Locali non inseriti in Salesforce.xlsx`, mailed 05/11 16:46:20Z).

⚠ **What changed is not known.** The workbook holds customer records and was **not
opened**; only its existence and modification time are recorded. No mail or message
in this window announces a revised Locali file, and the version ROMI holds is still
the provisional 4 November one.

🔴 **So there may now be a newer client list than the one the exception report was
computed against**, and nobody has said so either way. The question to ask him is
whether the 6 November edit is the promised correction of the uncoded rows.
