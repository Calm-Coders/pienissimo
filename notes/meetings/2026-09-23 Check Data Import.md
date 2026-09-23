---
id: meeting-2026-09-23-check-data-import
type: meeting
status: active
owner: Elena Spini
org: both
raised: 2026-09-23
updated: 2026-09-23
depends_on: [OI-165, OI-154]
source: Google Drive, "[ROMI-PIENISSIMO] - Check Data Import - 2026/09/23 09:59 CEST - Appunti di Gemini"
---

# 2026-09-23 - Check Data Import

**2h29m**, 23/09 09:59–12:29 CEST. The longest client session of the project so far,
and the one that settles what migration actually means.

**Attendees** (from the invitation and the transcript): Elena Spini, Aurel Mrruku
(ROMI); Fabrizio Paganelli, Elisa Migliano (Pienissimo, the latter joining on the
`amministrazione@pienissimo.com` invitation).

**Source.** One Google Docs artifact carrying both the Gemini notes and the full
transcript (165,114 chars read). **No separate transcript document exists** and the
recording is 1.13 GB — not opened. Per the standing caveat, speaker labels were
checked against content; the attributions below come from the transcript, not the
summary.

⚠ **The summary and the transcript disagree once, and it matters** — see
`Errori QR` under *What the summary got wrong*.

## What was decided

**Account anagrafica**

- **The external join key is `codice cliente esterno`**, not the system id, which is
  kept for technical reasons only (`00:17:04`).
- **`codice fiscale` and `partita IVA` are not forced equal.** Both come from the
  **Anticipay call**; they are set equal *only* when Anticipay returns no codice
  fiscale, because for some `società di capitali` they genuinely differ (`00:20:54`).
- **`codice SDI`** will start being taken from Anticipay too — it is empty on historic
  San Marino records because it was never managed there (`00:22:04`).
- **ATECO code and description both come from Anticipay**; the ATECO activity state
  becomes a **restricted picklist**, so external values are accepted without blocking
  the flow (`00:48:01`, `00:57:48`).
- **Leading asterisks in `ragione sociale` are meaningful** — they mark customers with
  known problems — and must be preserved (`00:19:54`).
- **`classificatore rete` is renamed `categoria provvigioni cliente`**, to match Mexal,
  and **`zona` moves off the tutor user onto the account**, because it varies by
  province and drives commissions (`00:53:31`). Elena Spini updated the data model in
  session (`00:54:42`).
- A **test-company flag** and a **`dormiente` company-state picklist** for automarketing
  are confirmed (`01:00:33`).
- **`nazione`, not `paese`** is Elisa Migliano's preference, to avoid operator error;
  Aurel Mrruku noted the Salesforce standard field translates itself to *paese* and that
  turning on the ISO standard lists could conflict with Mexal (`00:25:08`–`00:28:41`).
  ⚠ Recorded as a preference; no final naming was minuted.

**Locali**

- **The `IBAN` field is removed from the data model** — unused for orders and invoices,
  and a source of confusion (`01:04:17`).
- **A free-text `Categoria statistica Mexal` takes its place**, to be synchronised later
  with the Mexal accounting field of the same name (`01:05:19`).
- **`tipologia attività` becomes a multi-select picklist** and lives **on the locale
  object**, not on the parent account (`01:01:54`).
- **The complex customer-state fields are deleted** rather than left unvalued for a
  future FileMaker phase three: Aurel Mrruku and Elisa Migliano objected that hidden
  fields get forgotten. The seasonality field stays (`01:10:07`–`01:12:49`).

**Campaigns and events**

- **Child editions stay separate per tour city** — `Tour Napoli, Roma, Catania` is to be
  cleaned up into distinct children, not unified, because tickets and competence dates
  match on the edition id (`01:18:58`, `01:24:09`).
- The **registration-form block field is removed**; the **infopoint registration link is
  confirmed present** on the child campaign (`01:26:45`, `01:29:03`).
- **Asset `bruciatura` defaults to three days after the event** when no explicit date is
  given (`01:32:05`). Parcheggi stay free text; the Zoom Meeting integration is kept.

**Contacts and leads**

- **Only contacts with a company name are imported.** A large share of referenti records
  carry no company; Fabrizio Paganelli explained they come from free events and
  sponsorships and must not be deleted at source (`01:33:14`–`01:36:24`).
- **`is primary` is mandatory in practice** — Salesforce requires a primary contact to
  create a quote — and the import assigns the flag to the last qualifying record
  (`01:39:22`, `01:41:54`).
- 🔴 **Contacts without a company are deferred to the direzione.** Sabatino Rinaldi is
  to give directions **from 1 October**; until then the records load as *both* lead and
  contact **for test purposes only** (`01:46:21`, `01:48:54`).

**Migration scope — the session's most important ruling**

> **Elena Spini** (`02:04:53`): _"Una cosa super importante. Tutto ciò che è preventivi
> non verrà \[portato\] su Salesforce, quindi tutto ciò che non è un ordine, che è stato
> confermato, pagato, chiamiamolo come volete, non verrà portato su Salesforce. […] Verrà
> portato su Salesforce tutto ciò che deve finire su Mexal, che è già su Mexal per storico."_

→ [OI-172](../items/OI-172%20Historical%20quotes%20and%20offers%20are%20not%20migrated.md)

**Quote data model**

- Line-level only: **listino price on the product, sale price net of bundle/offer
  discounts on the line**; **header discounts are confirmed excluded**.
- Unit of measure is **not** needed on the offer line — it already lives on the product,
  so the line binds product + price + quantity.
- **`PricebookEntry` records are generated automatically** by ROMI from the price on the
  client's product registry; **omaggi are price zero** in the price book.

**Mexal fiscal handling**

- 🔴 The San Marino regime needs **fatturazione elettronica, sezionale IVA and a PDF-
  attachment flag driven by fiscal residence**, on both the anagrafica and the order.
  **Anticipay does not derive this**, so a **transcoding table** is required and a
  dedicated call with Mirko Merendi was scheduled (`00:37:39`, `00:41:10`). →
  [OI-173](../items/OI-173%20San%20Marino%20fiscal%20transcoding%20table.md)
- The **`flag annullato` on the product registry is not boolean in Mexal**. Aurel Mrruku
  will transform it on import; Fabrizio Paganelli owes the exact values (`00:05:59`,
  `00:12:26`). Disabled products stay visible on existing offers and orders and are
  blocked only on new ones. → [OI-175](../items/OI-175%20The%20Mexal%20flag%20annullato%20values%20are%20not%20boolean.md)
- 🟢 **A nightly 02:00 job already syncs Mexal → Salesforce** for accounts, invoices and
  scadenziari. Which side owns which field is deferred to a later test pass (`01:06:32`).

**Ingressi — the 22/09 written request is answered, and the answer is no**

See [the decision](../decisions/Decision%20-%20ingressi%20live%20on%20the%20campaign%20edition%20and%20are%20Fase%202.md)
and [OI-146](../items/OI-146%20Ingressi%20structure%20for%20multi-day%20events.md).

## Data quality found in session

- 🔴 The **locali file has identical ids on every row but row 20** (`01:07:58`). Fabrizio
  Paganelli agreed to re-check and re-save as **V1** so the next-day test import could run.
- 🔴 The **account key field contained an HTTP address plus an identifier** and overran
  the 40-character limit; resolved by a `RIGHT()` extraction of the last 15 characters.
- A sample of records **with P.IVA and a company id** is to be hand-filtered for the
  24/09 test import, rather than loading the unstructured block (`01:51:24`).

## What the summary got wrong

⚠ The Gemini *Passaggi successivi* block lists **_"\[Aurel Mrruku\] Implementare errori
QR"_ as an action item of this session.** The transcript (`01:56:20`–`02:01:26`) puts the
whole entry-block mechanism, the scan API and the speaking error **explicitly in Fase 2**,
with Elena Spini closing the topic: _"questa cosa qua è appunto la fase due […] secondo me
è inutile parlare adesso."_ **It is not work in flight.** Recorded because the 22/09 run
established that this project's auto-summaries list agreements and miss their limits.

## Scheduling changed here

- The **orders / migration session planned for 24/09 10:00 was postponed** at Aurel
  Mrruku's request — _"m'hanno fatto già 10 domande sulle cose che ho dato da fare ieri,
  quindi li devo seguire un attimo"_ — and Elena Spini agreed (`02:03:59`). The 24/09
  10:00 slot is **`Temi Mexal Anagrafiche/Indirizzi`** with Mirko Merendi instead.
- A new **`Check Data Import: Lead/Contact`** was booked for **Mon 5 Oct 17:15–18:00**,
  replacing a cancelled `[PIENISSIMO] - Follow-up Interno` in the same slot.
