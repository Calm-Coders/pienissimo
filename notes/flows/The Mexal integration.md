---
id: flow-mexal
type: flow
status: in-progress
owner: Andrea Di Cicco
with: Mirko Merendi
org: both
updated: 2026-09-03
depends_on: [OI-58]
source: notes/meetings/2026-09-02 Follow-up Anagrafica Articoli.md
---

# The Mexal integration

Mexal (Passepartout, integrator Kreosoft) is Pienissimo's ERP and stays the
system of record for invoicing. The approach was provisionally file-based on
2026-07-02 and **reversed to REST API on 2026-07-07** once ROMI read the
delivered documentation — eight CSV files were judged unmanageable.

Mechanics settled 2026-07-14
([OI-58](../items/OI-58%20Mexal%20integration%20mechanics.md)):

- **Salesforce is the source of truth for new records; Mexal for administrative
  edits**, with periodic realignment. Edit rights on the synced client registry
  are restricted to admin users.
- **Nightly scheduled GETs keyed on "data ultima modifica"** — delta only.
  Invoice pulls need date filters and pagination: ~2,300 invoices in 2025
  against 6 MB sync / 12 MB async callout limits.
- No repeated order GETs — the id comes back on create — but a **"rinvio
  ordine" button** exists. Product import has an on-demand button as well as the
  nightly job.
- Agents live as **suppliers under mastro 610**.
- A ragione-sociale change needs a registry field referencing the previous
  code/VAT.

**WEBAPI credentials arrived 2026-07-15** (`services.passepartout.cloud`,
dominio PIENISSIMO, azienda PIE), so the build is unblocked.

## Field mapping, answered 2026-08-11

Andrea Di Cicco sent a per-API field-mapping workbook on 2026-08-07 with eight
open questions; **Mirko Merendi (Kreosoft) answered them on 2026-08-11** and
returned `Integrazioni pienissimo.xlsx` with the mapping filled in. The answers
are integration contract, not opinion:

| Call                     | What Mirko settled                                                                                                                                                                                                              |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Get Clienti**          | Picks up client changes in the **last 24 hours**. Mapping confirmed.                                                                                                                                                            |
| **Get Agenti**           | It is Get **Fornitori** — filter agents by **code starting `610`**. Three fields only: codice, nome, email. Nothing further needed.                                                                                             |
| **Get Product**          | **Availability is computed, not stored**: `inventario + carico − scarico − ordini`. Listino 1 vs 2 still owed by Fabrizio Paganelli.                                                                                            |
| **Get Scoperto clienti** | Take **only causale `FE`** — fatture emesse.                                                                                                                                                                                    |
| **Get Fatture**          | **Two-step, N+1.** First `documenti/movimenti-magazzino` for sigla + serie + numero only, then `documenti/movimenti-magazzino/sigla+serie+numero` **one document at a time** to get the full field set **including the lines**. |
| **Creazione Cliente**    | Send `501.AUTO` in the codice field; the generated code comes back in a **response header** field.                                                                                                                              |
| **Creazione ordini**     | **Serie `1` in production; serie `10` for tests.**                                                                                                                                                                              |

## The workbook itself, opened 2026-08-14

`Integrazioni pienissimo.xlsx` has seven sheets: **General** plus one per call.
Each maps the Mexal API field to the field in today's file-based exchange and to
the target column, type and obligatoriness.

**The General sheet lists three calls the notes never mentioned**, with their
page in the Passepartout documentation:

| Entity                   | Page    | Method | Mexal name           | Cadence             |
| ------------------------ | ------- | ------ | -------------------- | ------------------- |
| Clienti                  | 98      | POST   | —                    | changes in last 24h |
| Agenti                   | —       | POST   | Fornitori            | once a day          |
| **Condizioni pagamento** | 122     | GET    | —                    | **once a day**      |
| **destinazioni**         | 180–188 | GET    | Indirizzi-spedizione | _"da verificare"_   |
| fatture                  | 146     | GET    | Documenti            | —                   |
| prodotti                 | 68      | GET    | Articoli             | —                   |
| **ordini**               | 146     | GET    | ordini clienti       | —                   |
| scoperto cliente         | 222     | GET    | Scadenziario         | —                   |

Outbound: `Cliente` POST _"quando l'account viene creato su SF va su Mexal"_,
`Ordine` POST, and a _"pulsante per rinvio verso gestionale"_.

**Key details from the sheets:** `totale_riga` is **not returned** — _"campo che
devi calcolare (qta\*prezzo)-sconto"_. `Get Scoperto` gives `stato_pagamento` as
`P` = pagato, empty = non pagato, and confirms the agent code prefix in its
example (`610.00010`). `Get Agenti` confirms three target fields only — codice,
nome, email.

🔴 **`Get Fatture` has no order-line number** — only `numero_ordine`
(`serie_ordine/numero_ordine`). That breaks the agreed ticket-release key; see
[OI-75](../items/OI-75%20Ticket%20availability%20rule.md).

⚠ **The workbook contains a real customer's registry record as its worked
example** — company name, VAT, address, phone, email and PEC, plus a real
agent's VAT. Never copy those values into `notes/`, the recaps or
[site/](../../site/).

Two consequences worth carrying:

- The invoice retrieval is **one callout per document**, against ~2,300 invoices
  a year and the 6 MB sync / 12 MB async limits. It is also the only way to get
  the **numero riga d'ordine** that
  [ticket availability](../items/OI-75%20Ticket%20availability%20rule.md) matches
  on — so the N+1 is on the critical path, not an optimisation detail.
- **There is still no Mexal test environment**, but serie `10` gives a test lane
  inside production. That is narrower than the "test company" OI-58 asks for,
  and it means test orders land in the live company.

What travels: the whole order, all lines, with the tranche reference and planned
payment date copied from the Quote and carried at **Order Item level** rather
than as a tranche object. Mexal updates payment status per line and Salesforce
aggregates upward; the tranche becomes fully paid only when every one of its
lines is fully paid. Mexal never creates or writes the tranche
([OI-50](../items/OI-50%20Tranche%20object.md)). At invoicing, n Mexal invoices
become n Salesforce invoices. **Zero-euro orders stay in the CRM and are not
transferred** ([OI-57](../items/OI-57%20Zero-euro%20orders%20stay%20in%20the%20CRM.md)).

This integration is configured on top of
[ROMI's standard integration scaffolding](../Integration%20Configuration%20is%20standard%20ROMI%20scaffolding.md) —
`Integration_Configuration__c`, `Integration_Log__c` and `API_Callout_Engine`,
committed in early August. The scaffolding is house pattern; the Mexal-specific
configuration on top of it is the project requirement.

## 2026-08-26 - the Postman collection was read, and it gives the real paths

[The collection](../The%20Mexal%20Postman%20collection.md) — nine requests, sent
by Andrea Di Cicco on 25 August — was decoded on 26 August. It is the first
artifact showing the **actual HTTP calls** rather than a plan for them.

**Every call is a `POST` to a `/ricerca` sub-resource** under
`https://services.passepartout.cloud/webapi/risorse/…`, with a JSON filter body
of the form `{"filtri":[{"campo","condizione","valore"}]}`. The delta key is
`data_ult_mod` and the timestamp format is **`YYYYMMDD HHMMSS`**.

| Entity                  | Path                               |
| ----------------------- | ---------------------------------- |
| Clienti                 | `clienti/ricerca`                  |
| Agenti                  | `fornitori/ricerca`                |
| Condizioni di pagamento | `dati-generali/pagamenti/ricerca`  |
| Prodotti                | `articoli/ricerca`                 |
| Scadenziario            | `scadenzario/ricerca`              |
| Ordini clienti          | `documenti/ordini-clienti/ricerca` |

`fornitori/ricerca` for agents **confirms the mastro-610 design** on the wire.
`dati-generali/pagamenti/ricerca` is **new** — the workbook gave that call a
manual page and no path.

### ⚠ Two corrections to what is written above

🔴 **The `Method` column in the workbook table above is wrong as an HTTP verb.**
It lists _condizioni pagamento_, _destinazioni_, _fatture_, _prodotti_, _ordini_
and _scoperto cliente_ as **GET**; every real call is a **POST** to `/ricerca`.
The column describes a read, not a verb. Configuring
`Integration_Configuration__c.HTTP_Method__c` from it would be wrong on six
calls.

🔴 **The two-step `Get Fatture` is not in the collection.** Mirko Merendi
specified `documenti/movimenti-magazzino` then one call per document;
`movimenti-magazzino` appears **nowhere**. Both requests named _Fatture_ call
`documenti/ordini-clienti/ricerca`, which is the customer-orders resource. So
the N+1 invoice retrieval described above — the one on the critical path for
[ticket availability](../items/OI-75%20Ticket%20availability%20rule.md) — is
**untested and unshown**.

### What the collection still does not give

**No saved responses**, so no payloads and no field lists — it says nothing
about whether the invoice call returns the **numero riga d'ordine**. **No
pagination** parameter of any kind, against the 6 MB / 12 MB limits recorded
above. **No write calls**, so `Creazione Cliente` and `Creazione ordini` are
untested. And the delta watermark is **hard-coded to 16 July 2026** rather than
rolling.

⚠ The file carries **live, enabled credentials** and must never be committed —
detail and handling in [the collection note](../The%20Mexal%20Postman%20collection.md).

## 2026-08-26 - the first write calls succeed, and the classification contract lands

At the [26 August review](../meetings/2026-08-26%20Review%20Temi%20Integrazione%20Mexal.md)
Andrea Di Cicco exercised the two untested write calls live, **against
production**, and both worked:

- `Creazione Cliente` → customer **`501.08721`**, "Test Roni"
- `Creazione ordini` → order **`OC11`** on **serie 10**

Fabrizio Paganelli confirmed both on his own Mexal screen. The new order shows
status `S` (*sospeso*), which he explained is normal and flips when the order is
transformed into an invoice.

### Which Mexal fields carry which project concept

Settled in this session, each verified by editing in Mexal and watching the API
response change:

| Mexal field            | API name                           | Carries                        | Notes                                                   |
| ---------------------- | ---------------------------------- | ------------------------------ | ------------------------------------------------------- |
| `natura`               | `COD_Natura`                       | genera biglietto sì/no         | Lookup to a managed base table, **not free text**       |
| `categoria statistica` | `Sigla cat sta` + `Numero cat sta` | the event (Campagna Padre)     | **Splits into two API fields**                          |
| `gruppo merceologico`  | `GRP merch`                        | candidate for tipo biglietto   | Hierarchical in Mexal; **the level did not come over**  |
| `Gest. annullato`      | `Gest. annullato`                  | product disabled in Salesforce | `n` = active, `S` = cancelled                           |

**Mexal offers at most three classification fields on an article**, and they were
entirely unused before this session. That constraint is why ticket type and
bundle-only visibility keep being pushed onto the Salesforce side.

**The values themselves are not chosen.** Fabrizio Paganelli takes the scheme to
Pienissimo's direction on 31 August.

### Invoicing stays Mexal-driven

Andrea Di Cicco had worked out the JSON to create an invoice from Salesforce.
Fabrizio Paganelli declined it for now — _"per il momento preferisco che venga
pilotata solo da Mexal la fatturazione"_ — and put a revisit at roughly **six
months** after go-live. Salesforce reads invoices; it does not create them.

### 🔴 The documentation is not the contract

Andrea Di Cicco hit several **mandatory fields absent from the documentation**:
_"tutti sti campi non c'erano sulla documentazione."_ Two are recorded:

- `tipo nazionalità` — mandatory, and it is *residenza fiscale*. See
  [OI-97](../items/OI-97%20Fiscal%20residence%20on%20the%20customer%20registry.md).
- `valuta` — set to `1` by trial. **Nobody knows whether `1` is euro.**

`codice listino` was answered: **only listino 1 is used**, though products carry
two.

⚠ Still unexplained: the **one-to-many relationship between a tranche and the
order rows** implied by Mexal's row identifiers. Andrea Di Cicco described the
row-id structure as what makes per-tranche invoicing of a bundle possible; Aurel
Mrruku asked him to explain it — _"mi devi spiegare sta roba"_ — and the call
ended first. It bears on [OI-50](../items/OI-50%20Tranche%20object.md).

## The document rules, dictated 2026-09-02

**The second half of the
[2 September session](../meetings/2026-09-02%20Follow-up%20Anagrafica%20Articoli.md)
is Elisa Migliano reading her own Mexal screens aloud while Andrea Di Cicco maps
them.** This is the first time the order tracciato has been written down. Treat
it as the client's own statement of the contract — and note that several values
were recalled rather than read, which is flagged where it happened.

### Order header

| Field                     | Rule                                                                                  |
| ------------------------- | ------------------------------------------------------------------------------------- |
| `codice conto`            | the customer code                                                                     |
| `data documento`          | the date the order is created                                                          |
| `sigla` / `serie` / `numero` | fixed except `numero`; send **0** and Mexal assigns the next value                 |
| **`sigla`**               | **`OC` for services, `BC` for books** — never mixed in one order                      |
| **`causale`**             | derived from sigla × fiscal residence — see the table below                            |
| **magazzino di uscita**   | **1** for `OC`, **2** for `BC`                                                        |
| **`costi ricavi`**        | **3** (servizi) for `OC`, **1** (materie prime) for `BC`                              |
| `agente`                  | on the order header                                                                   |
| `origine`                 | today the Zoho order number; after go-live the Salesforce one                          |

**Causale by document type and fiscal residence:**

| Causale | Sigla | Applies to                    |
| ------- | ----- | ----------------------------- |
| 1       | `OC`  | services, Italy               |
| 2       | `OC`  | services, San Marino          |
| 3       | `OC`  | services, everywhere else     |
| 4       | `BC`  | books, Italy                  |
| 5       | `BC`  | books, San Marino             |
| 6       | `BC`  | books, abroad                 |

Elisa Migliano restated it herself to be sure: _"nel caso che l'ordine sia di
tipo OC, la causale può essere 1 2 o 3… nel caso in cui l'ordine è di tipo BC, la
causale può essere 4 5 o 6, sempre in base alla nazionalità del cliente."_

⚠ **`BC` was a late catch** — _"quando facciamo la vendita del libro, la sigla
dell'ordine non è OC, è BC. Questa c'era sfuggita effettivamente."_ Everything
written before 2 September assumed one order type.

⚠ **The cost-centre values were recalled, not read**: _"l'uno, se non ricordo
male, vero?"_ Confirm both against a real document before coding.

### Order lines

`codice articolo`, `descrizione`, `unità di misura`, `quantità`, `prezzo`,
`sconti`, `importo`, `IVA` — and:

🔴 **`data di scadenza` on every line, and it is the tranche due date.** Andrea Di
Cicco: _"è per le tranche."_ Elisa Migliano: _"su Mexal sarebbe la data di
scadenza della tranche… oggi noi non la gestiamo, però un domani andrà messa."_
So the tranche stops being a Salesforce-only concept and becomes part of the
order tracciato — see [OI-50](../items/OI-50%20Tranche%20object.md).

**VAT is exempt on both types**, with different exemption codes. Elisa Migliano
gave them, corrected herself once, and the correction is what stands: **`E01` for
`OC`, `E10` for `BC`** — _"per gli ordini BC non è E01, è E10. Ho invertito i
due."_ ⚠ Read off memory mid-sentence; verify before use.

🔴 **`codice agente`, `zona` and `classificatore rete` are wanted on the header
and Andrea Di Cicco could not find them** in the field set the read call returns
— [OI-110](../items/OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md).

### Customer registry

| Field                      | Rule                                                                                     |
| -------------------------- | ---------------------------------------------------------------------------------------- |
| `codice paese`             | full country list; a `paese` table in the API holds the codes — **identified, unread**   |
| `residenza fiscale` / `tipo nazionalità` | **derived from the country code**, five values — [OI-97](../items/OI-97%20Fiscal%20residence%20on%20the%20customer%20registry.md) |
| `tipo fattura elettronica` | B2B for Italian companies, **blank** (_"non gestita"_) for all others                     |
| `PEC`                      | _"fondamentale… è quello che guida la fatturazione elettronica"_                          |
| `codice agente`            | on **every** customer, for the commission run                                             |
| `valuta`                   | **Euro only**, fixed — this retires the 26 August _"non so se 1 è euro"_ unknown          |
| listino                    | **listino 1 only**, confirming 26 August                                                  |
| `tipo società`, `pubblico` | not used — _"non ci interessa, non la gestiamo"_                                          |

⚠ **The B2B code was guessed on the call, not read**: _"Potrebbe essere S." —
"Potrebbe essere S. Sì, esatto."_ They then verified the **other** half properly,
looking up a real non-managed customer and confirming the field is blank. So the
blank is evidence and **`S` is a guess** — confirm it.

### The sales network, and why the agent code matters

Pienissimo's sellers are the **tutors**. All of them have CRM access; some are
employees paid through payroll, and **two work under an agency contract and are
paid commission**. Every customer therefore carries an agent code, _"anche se non
è codice agente, per avere una pulizia generale"_ — that is, the code is assigned
to every tutor whether or not commission is actually calculated for them.

This is the same population as the agents already known to live in Mexal as
**suppliers under mastro 610**.

## 2026-09-03 - the customer registry leg, from Data Model Parte 1

[The session](../meetings/2026-09-03%20Data%20Model%20Parte%201.md) specified the
anagrafica side of this integration for the first time. Four rules:

1. **Salesforce creates the account**, and pushes it to Mexal **immediately before
   the order is created**. The client's own `Flussi` sheet calls this `F-1` and
   dates it differently — _"scatta alla prima opty won"_ — which is
   [an unreconciled discrepancy](../items/OI-24%20Data%20model%20workbook.md).
2. **Mexal owns the registry thereafter.** Post-creation changes are made on
   Mexal only.
3. **A nightly batch returns them** — `F-2`, Aurel Mrruku's _"get notturno"_. It
   is unbuilt:
   [OI-116](../items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md).
4. **Salesforce locks its administrative fields** once `Codice Cliente Mexal` is
   populated:
   [OI-117](../items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md).

### Agent reconciliation on the order

Mexal, on receiving an order, compares the order's `codice agente` against its own
customer registry. If they differ it **rewrites its registry** and returns the new
customer-agent pairing on the nightly flow. Nothing has to be pushed or notified
from Salesforce. The three commission fields themselves originate from the
Salesforce user assigned as tutor —
[OI-110](../items/OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md).

### Two new Mexal-side fields named for the first time

- **`codice alternativo`** — where Mexal stores the code of a customer's previous
  ragione sociale, fed from Salesforce's `Azienda Precedente` lookup
  ([OI-118](../items/OI-118%20Ragione%20sociale%20continuity%20on%20the%20customer%20registry.md)).
- **The SDI / codice destinatario**, which Fabrizio Paganelli asked the
  integration to populate even though San Marino ↔ Italy traffic uses the PEC
  ([OI-109](../items/OI-109%20Codice%20destinatario%20SDI%20as%20a%20twelfth%20Anticipay%20field.md)).

### One behaviour replicated deliberately

**Codice fiscale is pre-populated from the partita IVA** on creation in
Salesforce, because that is what Mexal does. Fabrizio Paganelli noted the two
**can diverge after a change of ragione sociale**, so it is a default and not a
mirror — which matters to any matching rule keyed on either field.

⚠ **Whether Mexal requires both the billing and the shipping address to create a
customer is untested** and is the session's only formally deferred question:
[OI-113](../items/OI-113%20Whether%20Mexal%20requires%20both%20addresses%20to%20create%20an%20account.md).
