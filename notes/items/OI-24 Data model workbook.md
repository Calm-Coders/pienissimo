---
id: OI-24
type: open-item
status: open
owner: Sabatino Rinaldi
with: Elisa Migliano
org: both
raised: 2026-07-02
updated: 2026-09-02
blocks: [go-live]
severity: gating
source: meetings/open-items.md row 24
---

# OI-24 - Data model workbook

An Excel sheet per Salesforce object: ROMI supplies the structure, Pienissimo
extracts the field lists from Zoho and prunes what is unused — including the
nome-locale versus ragione-sociale distinction that produced
`Account.Nome_Locale__c`.

The file is `Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx` in
the `[Pienissimo] Fase Progettuale` Drive folder. Pienissimo owes the Zoho
field lists for **Account, Referente, Opportunity, Offerta, Ordine, Articoli**.

Committed by Sabatino Rinaldi on 22 July "within next week". Still open.
Mapping method and volumes settled on 2026-08-06 —
[OI-79](OI-79%20Migration%20volumes%20and%20mapping%20method.md).

Two build decisions must fold into it:
[the product flags](OI-47%20Product%20flags%20at%20import.md) `genera biglietto`
and `solo bundle`, and
[the bundle classification fields](OI-46%20Bundle%20classification%20picklists.md)
anno solare, evento and tipologia.

This gates the **~1 September import**, which gates every realistic test of the
[ticket lifecycle](../flows/The%20ticket%20lifecycle.md) before the September
events.

⚠ It also gates a ROMI-side deliverable that had no tracker row until the
2026-08-14 sweep: **the import template Pienissimo loads the Zoho export into**
— [OI-88](OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md).

## 2026-09-02 — the workbook was filled in, and read

🟢 **The deliverable open since 2 July has substantially arrived.** Elisa Migliano
committed to it at the end of the
[2 September session](../meetings/2026-09-02%20Follow-up%20Anagrafica%20Articoli.md) —
_"faccio quel copia incolla su quel file che avevate dato voi e vi do la conferma
che abbiamo fatto il lavoro"_ — the Drive file was modified at **14:05:38Z**, and
Fabrizio Paganelli mailed _"Abbiamo aggiornata la tabella condivisa. A domani"_
at **14:06:38Z** to Elena Spini, Aurel Mrruku and Andrea Di Cicco, cc
`amministrazione@pienissimo.com`. Read the same evening.

⚠ **The mail carries no link and names no file.** It was matched to
`Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx` by the one-minute
gap between the modification and the mail, and by Elisa Migliano's own commitment
on the recording. That is strong, but it is inference, not a statement.

### What it now carries

Zoho field lists, by sheet:

| Sheet                  | Zoho list                                                                 |
| ---------------------- | ------------------------------------------------------------------------- |
| Lead                   | ✅ present                                                                |
| **Account**            | ✅ present, and **grouped into sections** — see below                     |
| Referente              | ✅ present                                                                |
| Opportunità            | ✅ present                                                                |
| Offerta (Quote)        | ✅ present                                                                |
| Articoli (anagrafica)  | ✅ present, plus a **`Nuovi Campi`** column                               |
| **Ordine**             | 🔴 **absent** — standard Salesforce fields only, plus a three-line note   |
| Asset                  | 🔴 four fields and an `F-14` marker                                       |
| Articoli opportunità, Voci offerta, Pricebook, Pricebook entry | standard Salesforce only                  |
| **Utenti**, **Profili** | 🔴 **headers only, empty**                                               |
| Flussi                 | 🟡 **F-1 and F-2 filled, F-3 to F-7 empty**                              |
| Caricamenti iniziali   | 🔴 **C-1 to C-6 all empty**                                              |

So the six field lists this item asked for — Account, Referente, Opportunity,
Offerta, Ordine, Articoli — are **five delivered and one missing**, with Lead
supplied as a bonus.

### 🟢 The Account sheet does more than list fields

It **classifies** them into sections, which is the pruning half of this item's
brief rather than the extraction half:

`Dati Anagrafici` · `Dati Tecnici` · `LEGALE RAPPRESENTANTE` · `MEXAL` ·
`MEXAL - DATI PER PROVVIGIONI` · **`NON UTILIZZATO O OBSOLETO`** ·
`UTILIZZATO PER PERFORMANCE`

**`NON UTILIZZATO O OBSOLETO` is the single most useful thing in the file** — it
is the client saying, field by field, what not to migrate, and it is the largest
section on the sheet. It is also exactly what Elisa Migliano described on the
call: many Zoho fields _"erano già presenti e semplicemente non sono state
eliminate."_

### 🔴 Two findings that collide with decisions already taken

1. **The legal representative's address is already split in Zoho.** The
   `LEGALE RAPPRESENTANTE` section carries separate residence fields for street,
   town, province, postcode and country, plus surname, first name, codice
   fiscale, place and date of birth, and a phone. **On 1 September the room
   agreed to model the representative's address on Account as ONE free-text
   field** ([OI-95](OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md)).
   Migrating a structured source into one text field is lossy and irreversible.
   **Raise it at Data Model Parte 1 before the build starts.**
2. **`SDI` is a field in the client's own Mexal section**, which is worth knowing
   next to [OI-109](OI-109%20Codice%20destinatario%20SDI%20as%20a%20twelfth%20Anticipay%20field.md),
   withdrawn the same day on the ground that it is not needed.

### The `Flussi` sheet: two integration flows, numbered

| # | Flow                | Source → target      | Object  | Frequency         | Operation       | Returns  | Note                                                    |
| - | ------------------- | -------------------- | ------- | ----------------- | --------------- | -------- | ------------------------------------------------------- |
| **F-1** | upsert anagrafiche | Salesforce → ERP | account | realtime          | update + insert | ERP id   | _"scatta alla prima opty won"_                           |
| **F-2** | update            | ERP → Salesforce  | account | **nightly batch** | update          | —        | overnight realignment of accounts from ERP-side edits    |

Both restate what [the Mexal integration](../flows/The%20Mexal%20integration.md)
already holds; the value is that **the client has numbered them**, and the Account
sheet cross-references `F-1` per field. **F-3 to F-7 are empty**, so every other
integration — WooCommerce included — has a slot and no content.

### 🔴 Personal and commercial data: recorded, never copied

**The workbook is populated with live examples, not blanks.** Each object sheet
carries one real record beside the field list — a real company with its VAT, PEC
and IBAN, a named legal representative with codice fiscale, date and place of
birth and home address, a named lead and a named contact with personal email and
mobile, and a real quote with its line values.

**None of it is reproduced in this repository, and none of it may be.** Treat the
file as a source to read in Drive, never to extract from. Same rule as
[the publishing policy](../../docs/publishing.md): describe a field, never a
value.

### What is still owed

- **The Ordine field list** — the one sheet with no Zoho content. In its place is
  a note that the order must carry `Codice Agente`, `Classificatore Rete` and
  `Codice Zona`, which is [OI-110](OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md).
- **Utenti and Profili** — untouched, and they are half this file's title.
- **Caricamenti iniziali** — the initial-load plan, empty, with import due around
  1 September and [ROMI's import template](OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)
  still owed.

⚠ **Nothing here says which parts arrived on 2 September.** The file was last
opened by ROMI on 3 August and no earlier extract exists in the repository, so
this is the state of the workbook, not a diff. Do not attribute any single sheet
to yesterday's edit.
