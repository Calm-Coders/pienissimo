---
id: ref-campi-oggetti-workbook
type: reference
status: active
owner: Elena Spini
org: ROMI
raised: 2026-10-02
updated: 2026-10-02
source: Drive 121CTGF0mCkL_hiQIZWL1aYEirqwdSVZs
---

# The Campi Oggetti Flussi e Utenti workbook

**`Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx` is named in the
`requirements-check` skill as a standing target and has been listed as unopened
for weeks. It was read in full on 2026-10-02. It is a field-level Zoho → Salesforce
mapping workbook, and the two things the sweeps hoped it would answer, it does not.**

Drive id `121CTGF0mCkL_hiQIZWL1aYEirqwdSVZs`, owner Elena Spini, created
2026-07-07, last modified **2026-10-02T15:04:11Z**, opened by the project account
at 15:02:40Z. ~74 KB.

🔴 **It contains live customer records** in its example columns — company names,
VAT numbers, a Codice Cliente Mexal, a PEC address, personal mobile numbers, a
private e-mail address and street addresses. **No value from it is reproduced
here or anywhere in `notes/`**, per [docs/publishing.md](../docs/publishing.md).
Anyone needing an example must open the file.

## What it covers

One block per object, each listing field label, API name, type, picklist values
and the Zoho counterpart: **Lead, Account, Referente, Opportunità, Articoli
opportunità, Preventivo, Ordine vendita, Ordine, Voci offerta, Asset, Articoli
(anagrafica), Campagne, Pricebook entry, Pricebook**, then sheets for **Flussi**,
**Caricamenti iniziali**, **Utenti** and **Profili**.

## 🔴 The two questions it was being kept for

- **It does not say which object carries the ticket send flags.** The `Asset`
  block has four fields only — Cliente, Nome articolo, Quantità, Prezzo. There is
  nothing resembling `Ready_for_Ticket_Dispatch__c`, `Ticket_Sent__c` or
  `Ticket_Sent_Date__c`. **[OI-199](items/OI-199%20The%20ticket%20send%20flag%20fields%20are%20split%20across%20Asset%20and%20Order.md)
  gets no help from here** — the hypothesis the last two traces carried is
  answered, negatively, and should stop being carried.
- **The flow register is a stub.** `Flussi` has headers for ten columns and
  **only two filled rows** — F-1 (`upsert anagrafiche`, SFDC → ERP, realtime) and
  F-2 (ERP → SFDC account update, nightly batch). F-3 to F-7 are blank, and so are
  all six `Caricamenti iniziali` rows. `Utenti` and `Profili` are headers only.
  🔴 **It is not a current description of the integration**, and
  `Flows & Objects.drawio` remains the only picture of the flows.

⚠ F-1's trigger is written as _"scatta alla prima opty won"_ — at the first
opportunity **won**. The Blueprint and the register both say the Anticipay and
Mexal customer creation fire at the **first Order**. The Blueprint is newer and
client-facing; this row is stale.

## 🔑 What it does add

- **`Campagna Figlia` carries a far richer field set than the record describes**:
  Edizione, Anno Accademico, Data Inizio/Fine Evento, **Data invio automatico
  biglietti**, Da/A Data Competenza, Indirizzo, Luogo, Parcheggio, Orario inizio,
  **Link Iscrizione Infopoint**, Zoom Meeting id, Tipologia Evento (`Live`,
  `Online`) and **Data Avvio Bruciatura**. `Campagna Padre` carries Prodotto
  (lookup `Product2`), Periodo and Ingressi.
  ⚠ **`Data invio automatico biglietti` on the edition** is worth holding against
  [OI-199](items/OI-199%20The%20ticket%20send%20flag%20fields%20are%20split%20across%20Asset%20and%20Order.md)
  and [OI-197](items/OI-197%20The%20ticket%20send%20flag%20and%20the%20Inviato%20asset%20state%20are%20agreed%20and%20unbuilt.md):
  a send date already has a documented home on the campaign, and the send design
  that was built does not use it.
- **`Articoli (anagrafica)` corroborates two live decisions.** `Unità di misura`
  is listed with example value **NR** — the value Aurel Mrruku settled on at the
  02/10 Pre-UAT, in a document that has carried it since July. `Categoria
  statistica` is annotated _"evento (da mexal)"_ and `Natura` as
  _"genera biglietto SI/NO (mexal)"_, which is the shape
  [OI-188](items/OI-188%20Performance%20Plus%20products%20are%20identified%20by%20the%20Mexal%20article%20category.md)
  built. It also lists `Tipo Biglietto` (`Executive`, `Gold`, `Diamond`) and
  `LIVELLO_0`–`LIVELLO_6`, with `LIVELLO_0` = Eventi, Consulenze, Prodotti,
  Software, Addebiti.
- **`Referente` carries the consent model**: `Consenso Finalita Commerciali` and
  `Consenso Profilazione` (`Autorizzo` / `Non Autorizzo`, default blank), plus
  `Flag Informativa Privacy`, `Flag Condizioni Generali`, `Flag Clausole
  Contrattuali`, `Flag Consenso Requisiti`, `Ruolo iscrizione`
  (`Titolare` / `Collaboratore`), `Contatto amministrativo` and `Errato Marketer`.
- **`Lead`** maps each Salesforce field to its Zoho name and keeps Zoho-only
  columns including `piva`, `quantità biglietti`, `Hai già partecipato`,
  `Relatore`, `Tipologia` and the five UTM parameters.

## How to treat it

A **field-naming and Zoho-provenance reference**, useful when deciding what a
field was called before and what the client expects to see. Not a build state, not
a flow register, and not an authority on anything the register or `notes/` covers.
