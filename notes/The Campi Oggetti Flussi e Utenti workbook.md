---
id: ref-campi-oggetti-workbook
type: reference
status: active
owner: Elena Spini
org: ROMI
raised: 2026-10-02
updated: 2026-10-08
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

## 🔑 2026-10-05 - the Lead and Campagne sheets were filled in, and the flow register was not

Modified **2026-10-05 at 16:40:32Z**, during or just after
[the Lead session](meetings/2026-10-05%20Check%20Data%20Import%20Lead%20e%20Contact.md)
— the third consecutive working day this file has changed. Re-read in full.
**It is no longer a stub on the Lead side.**

### 🟢 New, and authoritative

- **`Origine Lead`**, nine Italian values: `Da Direzione, Da Tutor, Da Cliente,
Da libro, Da videocorso, Da Diretta, Da Corso, Da Marketing, Da Referral`.
  Answers Matteo Distaso's request in the session for Italian labels.
- **`Tipologia Attività`**, 21 values, on **both** the Lead and Account sheets,
  typed `Multiselect picklist` on Account and `Global picklist` **mandatory**
  on `Preventivo` —
  [OI-115](items/OI-115%20Tipologia%20Attivita%20values%20and%20its%20move%20to%20the%20quote.md).
- **Five UTM fields**: `utm_campaign`, `utm_content`, `utm_medium`,
  `utm_source`, **`utm_term`** — ⚠ the session named only four.
- **Two Lead consent flags**, both `Mapping con campo Contact`:
  `Flag Consenso Profilazione`, `Flag Informativa Privacy`. Matches the
  session's ruling exactly.
  **Implementation override, 8 October:** the user explicitly instructed that
  both fields map to Account instead. The source now follows that later
  direction; this contradicts the workbook and the 7 September client ruling.
- **A `Categoria`→`Sottocategoria` dependency.** The `Corso` branch has eleven
  sub-categories including **`Happy Team`** and **`Intensive at Home`**; the
  `Categoria` side adds **`Cassa Zucchetti`** and `Altri Servizi`. `Intensive at
Home` and `Cassa Zucchetti` appear nowhere else in this project —
  [OI-46](items/OI-46%20Bundle%20classification%20picklists.md).

### 🔑 `Articoli (anagrafica)` decodes the article registry

The sheet now defines the Salesforce product fields, and two definitions are
the key to
[`Articoli Salesforce.xlsx`](The%20Articoli%20Salesforce%20article%20registry.md):

- **`Natura` = _"genera biglietto SI/NO (mexal)"_** — the article field that
  says whether the article produces a ticket. ⚠ The registry's `Natura
Articolo` column holds `BO`, `BB`, `MS`, `HR`, `NM`, `S`, `NO`, `ND`, and
  **nothing documents which of those mean yes.** It governs whether an Asset is
  generated at all.
- **`Tipo Biglietto` = `null, Executive, Gold, Diamond`** — a three-value
  picklist, populated in the registry.
- `Categoria statistica` = _"evento (da mexal)"_; `LIVELLO_0` =
  `Eventi, Consulenze, Prodotti, Software, Addebiti`; `LIVELLO_1`–`_6` null.

### 🔑 `Campagne` is filled, and names two fields the record did not have

`Campagna Figlia`: `Edizione`, `Anno Accademico`, `Data Fine Evento`,
`Data Inizio Evento`, **`Data invio automatico biglietti`**, `Da Data
Competenza`, `A Data Competenza`, `Indirizzo`, `Link Iscrizione Infopoint`,
`Luogo`, `Orario inizio`, `Parcheggio`, `Zoom Meeting id`, **`Tipologia Evento`
(`Live`/`Online`, mandatory)**, **`Data Avvio Bruciatura`** (Date).
`Campagna Padre`: `Prodotto` (Lookup Product2), `Periodo`, `Ingressi`.

- 🟢 **`Data invio automatico biglietti` is now honoured by the build** — it is
  the source of `Event_Invitation__c.Data_Invio_Biglietto__c`, confirmed at the
  10:01 session. The 02/10 complaint that the design ignored it is withdrawn.
- 🔑 **`Data Avvio Bruciatura`** is a burn-start date on the edition — the
  mechanism [OI-196](items/OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md)
  needs for unnamed tickets being burned near the event, named here for the
  first time.
- 🔑 **`Tipologia Evento` `Live`/`Online`, mandatory** — new to the record.

### 🔴 Unchanged where it matters

- **`Flussi - elenco` is still 2 of 7.** `F-1` (upsert anagrafiche sfdc→erp,
  realtime, _"scatta alla prima opty won"_) and `F-2` (update erp→sfdc,
  **batch notturno**). `F-3`–`F-7` and `C-1`–`C-6` empty, a fourth consecutive
  reading. So `Flows & Objects.drawio` remains the only picture of the flows.
  ⚠ **`F-2` is the nightly alignment the 05/10 UAT decided to go and ask Mirko
  Merendi about** —
  [OI-209](items/OI-209%20Mexal%20anagrafica%20updates%20only%20propagate%20when%20an%20order%20is%20sent.md).
- **`Utenti` and `Profili` hold headers only** —
  [OI-186](items/OI-186%20The%20Salesforce%20user%20list%20and%20profiles%20were%20never%20agreed%20with%20the%20client.md).
- 🔴 The `Account` and `Referente` sheets still carry **live customer records** —
  a named company with its VAT number, PEC, administrative email, phone, Mexal
  customer code and named owner, and a named private individual with email and
  mobile. **No value is copied into this repository.**

## 2026-10-08 - it moved, and it was used as the data model in the room

Drive reports **last modified 2026-10-08T08:29:42Z**, replacing the
2026-10-02T15:04:11Z version this note was written against. Elena Spini posted
it to the marketing group DM at 10:09:47 CEST with the single word
_"Data model >>"_, linked to `gid=571873204`, and it was the reference open
during [the 08/10 internal session](meetings/2026-10-08%20Internal%20Test.md)'s
review of the marketing form fields.

⚠ **Not re-read.** It still contains live customer records in its example
columns, and nothing in this sweep required its values; file size is unchanged
at ~73 KB, so **what changed on 08/10 is not established**. Anyone needing the
current field list must open the file.
