---
id: REF-anticipay-api
type: reference
status: open
owner: Aurel Mrruku
with: Andrea Parmeggiani
org: both
raised: 2026-08-31
updated: 2026-09-01
depends_on: [OI-94]
blocks: [OI-95, OI-73]
requirement: INT-18
source: Gmail thread 1a0589a4a85b5bdf - "Pienissimo - Documentazione API per chiamata informazioni aziende"
---

# The Anticipay middleware API contract

The decode of `Documentazione API - Salesforce.pdf`, the specification of the
**Pienissimo Software middleware** that Salesforce calls in place of Anticipay.
It is the technical half of
[OI-94](items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md);
the business rule it serves is
[OI-73](items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md).

## Provenance

Two mails from **Andrea Parmeggiani** (`andrea.p@pienissimo.pro`), one Gmail
thread `1a0589a4a85b5bdf`, both to Aurel Mrruku, cc Elena Spini,
`amministrazione@pienissimo.com`, Fabrizio Paganelli and Sabatino Rinaldi:

| Version | Sent                     | Body                                                                                                                          | What it carried                                    |
| ------- | ------------------------ | ----------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| v1      | **2026-08-31 16:15:00Z** | _"In allegato la documentazione della chiamata API per la lettura dei dati da Anticipay"_                                     | the contract, **without** `:env`                   |
| v2      | **2026-09-01 10:46:38Z** | _"Ho aggiunto un parametro `:env` nel path, prevede un valore tra 'test' e 'prod', in allegato la documentazione aggiornata"_ | the same contract **plus the `:env` path segment** |

**This note decodes v2**, downloaded by Aurel Mrruku on 2026-09-01 at 12:51 CEST
and read the same session. v1 was never opened; the only recorded difference is
the one Andrea Parmeggiani names himself, so nothing below is attributed to v1.

⚠ **The PDF is deliberately not preserved in this repository.** Every other
client attachment has been — `Payload woo-salesforce.json` sits in the repository
root. This one carries a **live bearer token** and the **full personal data of a
named private individual** used as the sample response. Committing it would put a
working credential into git history, where deleting the file does not remove it.
See [OI-106](items/OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md).
**This note is the record**; it is complete on structure and deliberately empty
of values.

## Endpoint

|        |                                                                    |
| ------ | ------------------------------------------------------------------ |
| Method | `GET`                                                              |
| URL    | `https://integration.pienissimo.com/salesforce/account/:env/:piva` |
| Body   | **none** — the documentation states the request takes no body      |
| Auth   | `Authorization: Bearer <token>`                                    |

### Path parameters

| Parameter | Type   | Required | Meaning                                                        |
| --------- | ------ | -------- | -------------------------------------------------------------- |
| `:env`    | string | yes      | one of `test` or `prod` — **added 2026-09-01**, absent from v1 |
| `:piva`   | string | yes      | the VAT number of the account to look up                       |

`:env` precedes `:piva`. Both environments live on **the same host** and, as
documented, behind **the same token** — the environment is a path segment, not a
deployment.

## What env=test actually does

The documentation states it directly, and it is the same rule Andrea Parmeggiani
gave in the 31 August mail body:

> _"Se parametro env inviato ha valore 'test' non verra effettuata la chiamata ad
> Anticipay se l'azienda non e gia presente sul database di Pienissimo e verra
> ritornato un errore 404, in caso l'azienda fosse gia presente verra ritornata
> la sua anagrafica."_

|                                            | `env=test`                   | `env=prod`             |
| ------------------------------------------ | ---------------------------- | ---------------------- |
| Company already in the Pienissimo database | returns its anagrafica       | returns its anagrafica |
| Company **not** in the Pienissimo database | **`404`, no Anticipay call** | forwarded to Anticipay |

🔴 **`404` is overloaded in test, and the contract now says so in writing.**
The 25 August session gave `404` exactly one meaning — _VAT number not found_.
Under `env=test` it also means _not cached yet_, and the response carries nothing
that tells the two apart. **Test-period `404` rates measure the Pienissimo cache,
not Anticipay coverage**, and no test run against `env=test` can prove the
not-found path works.

🟢 **This answers an action nobody realised had been answered.** The 25 August
session left _"Pienissimo Software owes a test environment for ROMI to point at"_
outstanding — the action Gemini had mis-assigned to Aurel Mrruku. It has been
delivered as **a path parameter on the same host**, not a separate environment.
Whether that satisfies the requirement is a ROMI decision, not a technical fact;
see [OI-106](items/OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md).

## The 200 response

```
{ "success": <boolean>, "status": <integer>, "info": { ...11 string fields... } }
```

`status` restates the HTTP status code inside the body. `info` holds the account.

| Field                                        | Type                 | Carries                                   |
| -------------------------------------------- | -------------------- | ----------------------------------------- |
| `success`                                    | boolean              | whether the request succeeded             |
| `status`                                     | integer              | the HTTP code of the response             |
| `info`                                       | object               | the account data                          |
| `info.ragione_sociale`                       | string               | company name                              |
| `info.indirizzo`                             | string               | registered-office street address          |
| `info.citta`                                 | string               | registered-office town                    |
| `info.provincia`                             | string               | province code                             |
| `info.cap`                                   | string               | postcode                                  |
| `info.pec`                                   | string               | the company PEC address                   |
| `info.nome_legale_rappresentante`            | string               | legal representative, first and last name |
| `info.codice_fiscale_legale_rappresentante`  | string               | legal representative codice fiscale       |
| `info.data_di_dascita_legale_rappresentante` | string, `YYYY-MM-DD` | legal representative date of birth        |
| `info.luogo_nascita_legale_rappresentante`   | string               | legal representative place of birth       |
| `info.indirizzo_legale_rappresentante`       | string               | legal representative **home** address     |

**Eleven fields, and no more.** There is no reliability score, no rappresentante
fiscale, no company status, no VAT-number echo — the response does not return the
`:piva` it was asked about, so a caller correlates by request only.

### Three defects in the document, all worth raising on 1 September

1. 🔴 **`data_di_dascita_legale_rappresentante` is misspelled** — `dascita` for
   `nascita`. It appears that way in **both** the sample JSON and the field
   table, so it is the wire format, not a slip in one place.
   [OI-105](items/OI-105%20The%20Anticipay%20date%20of%20birth%20field%20name%20is%20misspelled.md).
2. 🔴 **The `404` description names the wrong system**: _"nessun record
   **Salesforce** corrisponde alla P.IVA fornita"_. Salesforce is the caller.
   The middleware searches the Pienissimo database and then Anticipay. Almost
   certainly copy-paste, but it is the one line that defines what `404` means.
3. ⚠ **The sample response is visually truncated** mid-string in
   `indirizzo_legale_rappresentante`. A PDF layout overflow, not evidence about
   the API — but the sample cannot be parsed as JSON as printed.

Naming is also inconsistent across the legal-representative block —
`data_di_dascita_`, `luogo_nascita_`, `indirizzo_` — so **no field name can be
derived by pattern**. Code against the literal strings above.

## Errors

| Code  | Documented meaning                                                      |
| ----- | ----------------------------------------------------------------------- |
| `400` | invalid request - VAT number missing or malformed                       |
| `401` | token missing or invalid - authentication failed                        |
| `404` | account not found (see defect 2 above; and overloaded under `env=test`) |
| `500` | internal service error                                                  |

**The 25 August session agreed only `404` and `500`.** `400` and `401` are new
and neither has been discussed. `401` matters most: it is the failure mode of a
static shared token, and under the agreed design an expired or rotated token
produces the same stored-error-plus-notification path as a genuinely unknown
company.

⚠ **No error response body is documented.** The document gives HTTP codes and
Italian prose in a table; it does not show the JSON an error actually returns —
whether `success` and `status` are present, and what key carries the message.

🟢 **This does not block the error store, and an earlier version of this note was
wrong to say it did.** The store is `Integration_Log__c`, ROMI's standard callout
audit trail, already committed: `API_Callout_Engine` writes the HTTP status into
`Response_State__c` and **the raw response body** into
`Response_Body__c` (`LongTextArea(131072)`), whatever shape that body has. Code
and message both land, as agreed on 25 August.

🔴 **It matters for a narrower and more concrete reason.** The engine
deserialises the response into the configured wrapper **before checking the
status**, and its `catch` block rebuilds the log row **without
`Response_State__c`** — so an error body that does not match the `200` wrapper
throws, and the log records an Apex exception **with no HTTP status** instead of
"404, VAT not found". An example of each error response lets the wrapper be
written to tolerate both shapes. Full analysis, including two defects in the
house engine that are ROMI's to fix, at
[OI-107](items/OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md).

## What it confirms, and what it leaves open

🟢 **The field set matches the as-is Mexal service exactly.** OI-73 records
Elisa Migliano describing the pre-invoicing lookup as returning _"ragione
sociale, address, PEC and legal representative"_ — precisely these eleven fields.
The middleware is not a reduced view of a larger Anticipay payload; it **is** the
service Pienissimo already uses, re-exposed. That narrows
[OI-95](items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md) from
"choose from Anticipay's full response" to "choose from these eleven".

Still absent, and none of it is in the document:

- **rate limits, timeouts, retry policy** — nothing; `Integration_Configuration__c`
  has a `Timeout__c` field with no value to put in it
- **cache TTL** — how long the middleware holds a cached answer, and whether a
  stale record can be forced to refresh. The agreed **manual re-check button** in
  OI-73 has no documented way to bypass the cache
- **the date `env=test` stops being cache-only** — Pienissimo Software's to flip,
  still unnamed, still undetectable from outside
- **whether the token rotates**, and who is told when it does

## Where it lands in the org

Nothing is built. `force-app/` contains **no Anticipay client, no callout and no
VAT-check flow** — only `Account.Partita_IVA__c` and `Lead.Partita_IVA__c`, both
`Text(32)`, **neither unique nor an external id**.

`Integration_Configuration__c` — the hierarchy custom setting described in
[the integration scaffolding note](objects/The%20integration%20scaffolding%20has%20never%20been%20configured.md)
— holds **zero rows and zero object permissions**, so it is a shape and not a
configuration.

⚠ **The token does not go in `Token__c`.** `API_Callout_Engine.buildEndpoint`
composes `'callout:' + namedCredential + config.Endpoint_Path__c`, and
`setHeaders` only ever sets `Content-Type`. **Authentication comes from a Named
Credential**, so the bearer token belongs there and `Token__c` is not on the path
the engine actually takes. 🟢 A useful side effect: the engine **never populates
`Request_Headers__c`**, so the token is not written into the log.

⚠ Which named credential is chosen is **automatic and not overridable** — the
engine reads `Organization.IsSandbox` once and picks
`Named_Credential_Sandbox__c` or `Named_Credential_Prod__c`. That model assumes
**two hosts**. This API has **one host** with the environment as a path segment,
so both credentials would point at the same place and `:env` has to live in
`Endpoint_Path__c`.

### 🔴 The house callout engine cannot call this API at all

This is the hardest thing in this note and it is **not** a problem with
Pienissimo's document — it is a mismatch between the contract and ROMI's standard
scaffolding.

`Endpoint_Path__c` is a **static field on a custom setting**. The engine's only
runtime input is `callApi(apiName, request)`, and `request` is serialised to JSON
and **used only as a body** — `buildRequest` sets a body only when the method is
not `GET`:

```
if (getHttpMethod(config) != 'GET') { req.setBody(reqJson); }
```

So for a `GET`, **the caller's argument is discarded entirely**. There is no
mechanism to substitute a value into the path.

Anticipay needs **two path parameters**, and one of them —`:piva` — is different
on every single call. As it stands:

- `:env` can be baked into `Endpoint_Path__c` (one custom-setting row per
  environment, or one per `env` value);
- **`:piva` cannot be passed at all.**

Three ways out, none of them free, and **the choice has not been made**: extend
`API_Callout_Engine` with path-parameter substitution (fixes it for every future
integration, touches shared house code); give Anticipay its own small client and
skip the engine (fastest, loses the logging and config the engine provides —
which is most of why [OI-107](items/OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)
is now cheap); or write the path into `Endpoint_Path__c` per call, which means
mutating a custom setting per lookup and is not viable.

⚠ **Every previous integration on this project posts a JSON body.** Anticipay is
the first `GET`-with-path-parameters, which is why this has not come up before.
Worth deciding deliberately rather than at the keyboard.

🔴 **Nine of the eleven returned fields have nowhere to land.** Account carries
three custom fields in total (`Partita_IVA__c`, `Lead_Email__c`,
`Nome_Locale__c`). `ragione_sociale` maps to `Name` and the four address fields
to the standard billing address; **PEC and all five legal-representative fields
have no home**, and creating them is unestimated work that follows the OI-95
decision rather than preceding it.

## The personal-data problem

Six of the eleven fields describe **a natural person, not a company** — the legal
representative name, codice fiscale, date of birth, place of birth and home
address. The sample in the documentation is a real, named individual with a real
codice fiscale and a real residential address.

This is not what the 25 August session thought it was agreeing to. The minute
says the payload is _"trimmed to the needed fields"_ because Anticipay returns
_"far more information than anyone wants"_; nobody said the trimmed set would be
mostly personal data. OI-95 already recorded the retention question as
**unraised** — the document makes it concrete.
[OI-108](items/OI-108%20The%20Anticipay%20payload%20carries%20personal%20data%20of%20the%20legale%20rappresentante.md).

**Never copy a value out of the sample response** into `notes/`, the recaps,
`STATUS.md` or [site/](../site/) — the same rule that governs
[the Mexal mapping workbook](The%20Mexal%20integration%20mapping%20workbook.md)
and [the WooCommerce payload](The%20WooCommerce%20payload%20contract.md). This note
describes fields only.

## What the 1 September call added to the document

The [follow-up session](meetings/2026-09-01%20Follow-up%20Integrazione%20Anticipay.md)
ran the same morning this note was written, and settles four things the document
left open or silent. **Where the two disagree, the call is later.**

| Point                     | The document                              | The call                                                                                   |
| ------------------------- | ----------------------------------------- | ------------------------------------------------------------------------------------------ |
| Happy-path status         | `200`                                     | ✅ confirmed out loud by Andrea Parmeggiani                                                 |
| `:env` split              | a path parameter, provenance unexplained  | 🟢 **agreed in this call**, proposed by Aurel Mrruku; v2 mailed 2.5 h later                 |
| One token, both envs      | stated, unexplained                       | 🟢 **deliberate** — asked outright, answered _"sì, sì"_ ([OI-106](items/OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md)) |
| Test-mode cost and limits | not mentioned                             | 🟢 **free, no call limit** — _"non ci sono costi, possiamo fare chiamate a piacere"_        |
| Production config         | not mentioned                             | **identical to test**, save that the middleware then forwards to Anticipay                  |

### 🔴 The scope limit the document never states

**Anticipay returns data for Italian companies only.** Andrea Parmeggiani:
_"la nazione non l'ho inserita perché è scontato che sia Italia, altrimenti torna
sempre non trovato."_

So the absent `nazione` field is a **deliberate design fact, not an omission**,
and `404` now carries **three distinct meanings** on this endpoint:

1. the company is genuinely unknown to Anticipay;
2. the company is not yet in the Pienissimo cache (test period only);
3. **the VAT number is not Italian**, and never will be resolvable.

The agreed error protocol gives `404` one meaning and one notification. Recorded
against [OI-73](items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md),
where it also answers the foreign-VAT half of `INT-18` in the negative.

### Every field now has a landing place

The _"nine of eleven fields have nowhere to land"_ gap recorded above is closed as
a **decision**, not as built metadata:
[OI-95](items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md) takes
all eleven onto `Account` — PEC and the five legal-representative fields as new
custom fields, the representative's address as **one free-text field**. None of
them exist in the org yet.

⚠ **Still undocumented and still unasked after the call:** the error response
body, production rate limits and timeouts, the cache TTL, how the manual re-check
bypasses the cache, and the date `env=test` starts forwarding. The call did not
touch any of them.
