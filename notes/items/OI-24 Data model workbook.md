---
id: OI-24
type: open-item
status: open
owner: Sabatino Rinaldi
with: Elisa Migliano
org: both
raised: 2026-07-02
updated: 2026-09-04
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

## 2026-09-03 - the Account sheet was rebuilt to match Data Model Parte 1

Modified **11:11:04Z**, minutes after
[the session](../meetings/2026-09-03%20Data%20Model%20Parte%201.md) ended at
roughly 11:07Z. Elena Spini's action from that call was _"Pulire il file dei
campi, rimuovendo le voci superflue"_, and she did it immediately. Read in full.

**The `NON UTILIZZATO O OBSOLETO` block is gone.** Yesterday's reading recorded a
large section of fields the client was flagging as not to migrate; the sheet no
longer carries it. The pruning agreed in the session has been applied to the
file, not merely minuted.

**The Account sheet is now sectioned**, with columns `SEZIONE · NOME CAMPO · API
Name SFDC · Modifica da SFDC · Mandatory · Tipo Campo · Esempio`, and four
sections that match the meeting exactly:

| Section                       | Holds                                                        |
| ----------------------------- | ------------------------------------------------------------ |
| `Dati Commerciali`            | the three ATECO fields, `Azienda obsoleta`, owner/tutor, `E-mail Commerciale`, `Stato Azienda` |
| `Dati Tecnici`                | `Azienda Test`, `Id Zoho`, `Ultima Verifica Anticipay`       |
| `MEXAL`                       | addresses, ragione sociale, the admin phone and mail, `Azienda Precedente`, `Codice Cliente Mexal`, codice fiscale, IBAN, partita IVA, PEC, SDI |
| `MEXAL - DATI PER PROVVIGIONI`| `Classificatore_rete`, `Codice_agente`, `Zona`               |

The sections are not cosmetic — they are the boundary of the field lock in
[OI-117](OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md).

**Also new in this version**

- The **Preventivo** sheet carries `Tipologia Attività — Picklist non restrittiva
  >> PIENISSIMO TO DO: Inserire i valori esistenti`
  ([OI-115](OI-115%20Tipologia%20Attivita%20values%20and%20its%20move%20to%20the%20quote.md)).
- **`Azienda Precedente`** appears, typed `Lookup (con se stessa)`
  ([OI-118](OI-118%20Ragione%20sociale%20continuity%20on%20the%20customer%20registry.md)).
- **`Codice Cliente Mexal`** — the rename agreed in the session, already applied.
- An **Asset** sheet tagged `F-14`, with Cliente / Nome articolo / Quantità /
  Prezzo.
- The **Articoli** sheet's `Nuovi Campi` column carries `LIVELLO_0` through
  `LIVELLO_6` alongside the Mexal classification fields. ⚠ **Seven level fields
  are in no note and were not discussed in any minuted session.** Ask before
  building anything from them.

### 🔴 What is still empty, unchanged from 2 September

- **The Ordine field list** — still only the standard Salesforce fields, with the
  same free-text note that the order must carry `Codice Agente`,
  `Classificatore Rete` and `Codice Zona`
  ([OI-110](OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md)).
- **Utenti and Profili** — header rows only. Half the file's title, untouched
  through two client sessions.
- **CARICAMENTI INIZIALI, `C-1` to `C-6`** — the initial-load plan, empty, with
  the data import nominally due around 1 September.
- **`Flussi` still holds only F-1 and F-2.** Every other integration —
  WooCommerce, Anticipay, the article registry — has no row.

**A two-hour session moved the Account sheet and none of these.** They should be
named explicitly as the agenda for Parte 2 or Parte 3, or they will arrive at
go-live unwritten.

⚠ The file still carries **live customer records** — a real company with its VAT,
PEC and IBAN, a named legal representative, a named lead and contact, a real
quote with values. **Recorded, never copied.** Unchanged rule.

⚠ **F-1's trigger contradicts the room.** The sheet says the Salesforce → ERP
upsert _"scatta alla prima opty won"_; the session said the account is pushed to
Mexal **immediately before the order is created**. Those are different moments.
Confirm at Parte 2.

## 2026-09-04 — rebuilt again, during Parte 2

`Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx`, modified
**15:03:03Z** — during the session, as on 3 September when it was rebuilt four
minutes after the call ended. Read in full.

**What moved:**

- 🟢 **The `Referente` sheet is now the detailed one**, carrying the Contact work
  from [Parte 2](../meetings/2026-09-04%20Data%20Model%20Parte%202.md): a
  `Contatto principale — isPrimary` flag, `Ruolo — Vedi nota`, `Keap Id Esterno`,
  `E-mail secondaria — otherEmail`, `Nome Locale`, and
  `Modalita iscrizione annullata` sourced from `Zoho campaigns`.
- 🟢 **The `Ordine` sheet gained a requirement**, though not a field list:
  _"Nell'ordine e importante che ci siano le seguenti informazioni: Codice
  Agente, Classificatore Rete, Codice Zona"_
  ([OI-110](OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md)).
- 🟢 **The Account sheet carries `Azienda Precedente — Lookup (con se stessa)`**,
  the self-lookup agreed for
  [OI-118](OI-118%20Ragione%20sociale%20continuity%20on%20the%20customer%20registry.md),
  and the empty shipping-address fields the mirroring decision needs.

**What did not move — the same four gaps, third session running:**

| Gap                                 | State                                    |
| ----------------------------------- | ---------------------------------------- |
| **Utenti**                          | header row only, still empty             |
| **Profili**                         | header row only, still empty             |
| **Initial-load plan** `C-1`–`C-6`   | six empty rows                           |
| **Ordine** field mapping            | standard Salesforce fields + one note    |
| `Flussi`                            | still only **F-1** and **F-2**           |

🔴 **`Ruolo` carries `Amministrativo/Commerciale/Piattaforma`**, which is not the
value set agreed in the session hours earlier —
[OI-120](OI-120%20The%20contact%20role%20picklist%20values%20disagree%20between%20the%20workbook%20and%20the%20session.md).

⚠ **`LIVELLO_0` through `LIVELLO_6` are still in the Articoli sheet's `Nuovi
Campi` column**, unexplained and in no minuted session for a second day.

⚠ **The file still holds live customer records** — real companies with VAT, PEC
and IBAN, and named individuals with contact details, on the Account, Referente
and Preventivo sheets. **Recorded; nothing copied.**
