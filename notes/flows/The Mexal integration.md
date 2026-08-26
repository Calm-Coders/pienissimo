---
id: flow-mexal
type: flow
status: in-progress
owner: Andrea Di Cicco
with: Mirko Merendi
org: both
updated: 2026-08-26
depends_on: [OI-58]
source: meetings/open-items.md row 58
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
