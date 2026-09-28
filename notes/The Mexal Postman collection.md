---
id: ref-mexal-postman-collection
type: reference
status: active
owner: Andrea Di Cicco
with: Aurel Mrruku
org: ROMI
raised: 2026-08-25
updated: 2026-08-26
depends_on: [OI-58]
source: Slack DM Andrea Di Cicco to Aurel Mrruku, 2026-08-25 11:52 CEST
evidence: Mexal Dev.postman_collection.json, 14186 bytes, read 2026-08-26
---

# The Mexal Postman collection

`Mexal Dev.postman_collection.json` — Andrea Di Cicco's working collection for
testing the Passepartout WEBAPI, sent to Aurel Mrruku on Slack on 2026-08-25 and
**read on 2026-08-26**. Postman schema v2.1.0, **nine requests, no folders, no
saved responses**.

It is the first artifact in this project that shows the **actual HTTP calls**
rather than a plan for them. Everything below is decoded from the file itself.

⚠ **The file carries a working credential and is pointed at the production
company.** It is not in the repository and must not be committed. See the
security section at the foot of this note.

## What it settles: the real endpoint paths

Every call is a **`POST` to a `/ricerca` sub-resource** under
`https://services.passepartout.cloud/webapi/risorse/…`, with a JSON filter body.

| Entity                  | Path (under `/webapi/risorse/`)    | Confirmed by                          |
| ----------------------- | ---------------------------------- | ------------------------------------- |
| Clienti                 | `clienti/ricerca`                  | request `Ricerca Clienti`             |
| Agenti                  | `fornitori/ricerca`                | request `Ricerca Agenti`              |
| Condizioni di pagamento | `dati-generali/pagamenti/ricerca`  | request `Ricerca pagamenti`           |
| Prodotti                | `articoli/ricerca`                 | request `Ricerca Prodotti`            |
| Scadenziario            | `scadenzario/ricerca`              | request `Ricerca Scadenziario`        |
| Ordini clienti          | `documenti/ordini-clienti/ricerca` | ⚠ the request named `Ricerca Fatture` |

**`fornitori/ricerca` for agents confirms the mastro-610 design** — agents really
are suppliers on this API, exactly as Mirko Merendi settled on 2026-08-11.

**`dati-generali/pagamenti/ricerca` is new.** The mapping workbook listed
_Condizioni pagamento_ at manual page 122 with no path; this is the first record
of where it actually lives.

## The request contract

Eight of the nine bodies are identical in shape:

```json
{
  "filtri": [
    { "campo": "data_ult_mod", "condizione": ">=", "valore": "20260716 000000" }
  ]
}
```

Three things follow, none of them previously recorded:

- **The filter DSL is `{campo, condizione, valore}`** in a `filtri` array — a
  generic operator-based filter, not a fixed query string.
- **The timestamp format is `YYYYMMDD HHMMSS`**, space-separated, no timezone.
- **The delta key is `data_ult_mod`**, which confirms the "delta only, keyed on
  data ultima modifica" mechanic that until now rested on meeting narration.

`Ricerca pagamenti` sends an **empty body `{}`**, so an unfiltered full fetch is
a legal call on at least that resource.

## 🔴 What it does not settle, and the record should not assume it does

**1. There is no invoice endpoint in the collection at all.**
Mirko Merendi specified `Get Fatture` on 2026-08-11 as a **two-step N+1** via
`documenti/movimenti-magazzino`, then one call per document to get the lines.
**`movimenti-magazzino` appears nowhere in this file.** The two requests named
_Fatture_ both call `documenti/ordini-clienti/ricerca`, which is the **customer
orders** resource.

So the call that [ticket availability](items/OI-75%20Ticket%20availability%20rule.md)
keys on has **not been tested**, and this collection does not show how to make
it.

**2. No saved responses.** All nine requests have an empty `response` array, so
the file proves the _requests_ and shows **no payloads and no field lists**. It
therefore says nothing about whether `Get Fatture` returns the **numero riga
d'ordine** — the gap
[OI-58](items/OI-58%20Mexal%20integration%20mechanics.md) and
[OI-75](items/OI-75%20Ticket%20availability%20rule.md) both turn on. That
question is exactly as open as it was.

**3. No pagination anywhere.** No page, limit, offset or cursor parameter on any
request. [The Mexal integration](flows/The%20Mexal%20integration.md) records that
invoice pulls need pagination against ~2,300 invoices a year and the 6 MB sync /
12 MB async callout limits. Nothing here addresses it.

**4. No write calls.** The collection is entirely read-side. `Creazione Cliente`
(`501.AUTO`, code returned in a response header) and `Creazione ordini`
(serie `1` production, serie `10` test) are **untested** — and they are the half
of the integration where Salesforce is the source of truth.

**5. The watermark is hard-coded.** Every filter carries the literal
`20260716 000000` — **16 July 2026**, a fixed test date, not a rolling window.
Fine for a manual probe; it is not a nightly-delta implementation.

**6. 🔴 The gestionale year and the date filter disagree.** All nine requests
send `Coordinate-Gestionale: Azienda=PIE Anno=2025`, while every filter asks for
records modified since **`20260716`**. `Anno` selects the accounting-year
archive in Passepartout, so the collection is querying the **2025 archive for
changes made in mid-2026**.

That combination should return little or nothing, and it would present as _"the
API gives us no data"_ rather than as _"we asked the wrong archive"_. It is the
most likely single explanation for the collection being unfinished, and it is
**one header away from being testable** — re-run any request with `Anno=2026`
before concluding anything about the endpoints.

## The authentication contract, confirmed against a live 401

The `Authorization` header is **three whitespace-separated tokens**, and the
scheme word is the literal `Passepartout`:

```
Authorization: Passepartout <base64(utente:password)> Dominio=<dominio>
```

Two things follow that are easy to get wrong and were both proved on
2026-08-26 by a live call:

- **`Dominio` travels inside the `Authorization` header**, not in
  `Coordinate-Gestionale`. The header therefore carries a credential **and** a
  routing coordinate together, which is unusual and is not how any of the
  project's other integrations are shaped. `Coordinate-Gestionale` carries only
  `Azienda` and `Anno`.
- **The base64 half alone is not a valid header.** Sending it without the
  `Passepartout` scheme word and the `Dominio=` token returns

  ```
  401  1006 - Authentication header non specificato correttamente (schema o tokens)
  ```

  That error means _"I cannot parse this"_, **not** _"these credentials are
  wrong"_ — a useful distinction when debugging, because it rules out the
  credential and points at the header shape.

⚠ **This matters for the build, not just for Postman.** Whoever configures the
Mexal callout in `Integration_Configuration__c` has to assemble all three tokens.
The object has a `Token__c` field and an `Apikey__c` field, and neither is
shaped like _"scheme + credential + domain in one header"_ — so the assembly has
to happen in `API_Callout_Engine` or in the configuration value itself. Storing
only the base64 will reproduce the 1006 error in Apex exactly as it did in
Postman.

## ⚠ Three requests are pointed at the wrong resource

This is what Andrea Di Cicco meant by _"devo ancora aggiungere quella parte che
dicevamo ieri sera"_ — the collection carries copy-paste artefacts, and a reader
who trusts the request **names** will build the wrong calls:

| Request name                      | Actually calls                     | Should call                                                   |
| --------------------------------- | ---------------------------------- | ------------------------------------------------------------- |
| `Ricerca Fatture`                 | `documenti/ordini-clienti/ricerca` | an invoice resource — `movimenti-magazzino` per Mirko Merendi |
| `Ricerca Fatture Copy`            | `documenti/ordini-clienti/ricerca` | duplicate of the above, byte-identical                        |
| `Ricerca Ordini Clienti`          | **`scadenzario/ricerca`**          | `documenti/ordini-clienti/ricerca`                            |
| `Ricerca Indirizzo di spedizione` | **`scadenzario/ricerca`**          | an `indirizzi-spedizione` resource                            |

**No shipping-address call exists.** The mapping workbook listed _destinazioni_
(`Indirizzi-spedizione`, manual pages 180–188) with cadence _"da verificare"_.
It is still unverified, and the request that claims to cover it is a placeholder
pointed at the payment schedule.

**Read the URL, never the name.** The path inventory in the table above is
recoverable; the labels are not trustworthy.

## ⚠ The workbook's `Method` column is wrong

[The mapping workbook](The%20Mexal%20integration%20mapping%20workbook.md) lists
_condizioni pagamento_, _destinazioni_, _fatture_, _prodotti_, _ordini_ and
_scoperto cliente_ as **GET**. Every call in this collection is a **POST** to a
`/ricerca` endpoint with a filter body.

The workbook's column is describing the _semantics_ (a read), not the HTTP verb.
**Anyone configuring `Integration_Configuration__c` from that column will
configure the wrong method** — and that object's `HTTP_Method__c` field is
exactly where the mistake would land. Build from the collection's paths and
verbs, not from the workbook's.

## Security

The file carries **two enabled credential headers on all nine requests**:

- **`Authorization`** — a custom scheme, `Passepartout <token>`. Enabled.
- **`Coordinate-Gestionale`** — `Azienda=PIE Anno=2025`, identical on all nine.
  These are coordinates, not secrets: the same `azienda PIE` this record already
  names. Enabled.
- A third header, `Passepartout`, is **disabled** on every request. Its value is
  base64 of a `ROMICOMPANY:<password>` pair with `Dominio=PIENISSIMO` — a real
  user credential, recoverable by anyone who opens the file.

⚠ **It is a dev collection, but it is not a dev environment.** The file is named
`Mexal Dev` and Andrea Di Cicco uses it for testing; the coordinates point at
**`Azienda=PIE`**, which
[the Mexal integration](flows/The%20Mexal%20integration.md) and
[OI-58](items/OI-58%20Mexal%20integration%20mechanics.md) both name as the
company the 15 July credentials were issued for. Both notes also record that
**there is still no Mexal test environment** — serie `10` is a test lane _inside
the production company_. Nothing in this file contradicts that; it is consistent
with it. Treat the credential as production-scoped until a real test company
exists.

**No value from any of them is recorded here, and none may be.** They are the
Mexal WEBAPI credentials that [docs/publishing.md](../docs/publishing.md) names
explicitly as forbidden in `notes/`, in the recaps, in [site/](../site/) and in
a commit.

🔴 **Do not commit this file.** It is a Slack attachment sitting in a downloads
folder with live production credentials in cleartext, against an ERP that is the
system of record for invoicing. If it is wanted in the repository, the
credentials must be replaced by Postman variables first and the values delivered
by another channel — and even then, `docs/publishing.md` would need to be
consulted.

⚠ **It also contradicts a standing claim in the record.**
[OI-58](items/OI-58%20Mexal%20integration%20mechanics.md) carries both
_"WEBAPI credentials were delivered on 15 July"_ and, in its 24 August section,
_"the Mexal WEBAPI credentials promised since July have still not arrived"_.
**This file proves working credentials exist and are in use by ROMI.** Whichever
set is still owed, it is not the one Andrea Di Cicco is testing with — and the
"still absent" line should be qualified rather than repeated.

## What to do with it

The collection is a **probe, not a contract**. It is worth exactly one thing
today: it is the concrete brief for the **26 August 16:00 CEST client Mexal
review**, where four questions can now be asked with a URL beside each —

1. Which resource returns **invoices with their lines**, and does it carry the
   **numero riga d'ordine**? (`OI-75`, and the collection has no invoice call.)
2. What is the **pagination** contract on `/ricerca` endpoints?
3. What is the real **indirizzi-spedizione** path? (`destinazioni`, still _da
   verificare_.)
4. Can an **unpaid** entry in `scadenzario/ricerca` drive an asset backwards?
   ([OI-92](items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md) —
   the endpoint is confirmed reachable, the semantics are not.)

Related: [the Mexal integration](flows/The%20Mexal%20integration.md),
[the mapping workbook](The%20Mexal%20integration%20mapping%20workbook.md),
[the integration scaffolding has never been configured](objects/The%20integration%20scaffolding%20has%20never%20been%20configured.md).
