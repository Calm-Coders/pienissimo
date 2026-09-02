---
id: trace-2026-09-01-anticipay
type: reference
status: active
updated: 2026-09-01
watermark_used: none
external_watermark: none
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-01 Anticipay API drill

🔴 **This is not a `requirements-check` sweep. Do not use it as a watermark.**
The last real sweep is [the 31 August trace](Source%20trace%202026-08-31.md) and
its watermark — **2026-08-31T22:00Z** — is still the one the next run must use.
Nothing here consumed it. Slack, Drive and Fathom were **not** searched, and the
window from 31 August 22:00Z onward remains **uncovered** apart from the single
mail thread named below.

🔴 **The 1 September follow-up call ran, and this session did not drill it.**
Checked on the calendar at the end of the session: the event
(`2j4tg4tglt9iei6285jfn8i62s`, 10:00–11:00 CEST) carries a **recording timed
10:02 CEST** and a **Gemini notes document**
(`1CiCRPuxOoZvqmlUTRahWyewjAuDw4n0wgOMzs4vK0dU`). Neither was opened.
⚠ **v2 of the documentation arrived at 12:46 CEST — after the call ended** — so
the `:env` parameter is plausibly an **outcome** of the session rather than an
input to it. Everything written today comes from the document alone. **The six
questions recorded on OI-94 may already have been answered in the room; check the
minute before chasing any of them.** Drilling that meeting is the next action on
this whole area.

**What this was.** Aurel Mrruku downloaded
`Documentazione API - Salesforce.pdf` by hand and asked for it to be drilled.
That is the outstanding ask the 31 August trace listed first — _"the cheapest
outstanding ask in the record and the most valuable"_ — now discharged.

## Sources read

Read-only. **Nothing was sent, replied to, drafted or marked read.**

| Source         | Scope                                                                                       | Result                                                         |
| -------------- | ------------------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| **Local file** | `~/Downloads/Documentazione API - Salesforce.pdf`, 192 KB, downloaded 2026-09-01 12:51 CEST | text extracted and decoded in full                             |
| **Gmail**      | `from:pienissimo.pro OR subject:"Documentazione API" newer_than:14d`                        | 1 thread, `1a0589a4a85b5bdf`, **2 messages** — provenance only |
| **Repo**       | `force-app/` for any Anticipay client, callout, VAT flow or landing field                   | **nothing built**; `Integration_Configuration__c` fields read  |
| **Repo**       | `requirements/pienissimo-requirements.yaml` for `INT-18`                                    | read, **not modified**                                         |

## Found

### 1. 🟢 The contract is in the record, and there were two versions

| Version | Sent                 | Difference                                                      |
| ------- | -------------------- | --------------------------------------------------------------- |
| v1      | **31 Aug 16:15:00Z** | the contract as first written                                   |
| v2      | **1 Sep 10:46:38Z**  | _"Ho aggiunto un parametro `:env` nel path"_ — `test` or `prod` |

Both from Andrea Parmeggiani to Aurel Mrruku, cc Elena Spini,
`amministrazione@pienissimo.com`, Fabrizio Paganelli and Sabatino Rinaldi. **The
downloaded file is v2.** v1 was never opened, so nothing is attributed to it
beyond the difference Andrea Parmeggiani names himself.

Full decode:
[the Anticipay middleware API contract](../The%20Anticipay%20middleware%20API%20contract.md).
`GET https://integration.pienissimo.com/salesforce/account/:env/:piva`, bearer
token in the header, eleven response fields, four error codes.

### 2. 🟢 Two things the 31 August sweep could only infer are now specification

- **The cache-only test mode is written into the contract**, not just the mail
  body. `env=test` returns `404` for any company not already in the Pienissimo
  database and makes no Anticipay call. The 31 August reading was right.
- **The "dedicated test environment" owed by Pienissimo Software since 25 August
  appears to have been delivered as `:env`** — a path parameter on the same host,
  behind the same token. That action can probably be closed, but as something
  narrower than the phrase implied.

### 3. 🔴 Four new items, none of them anticipated

| Item                                                                                                                      |                                                                                                                                                                                                                                |
| ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [OI-107](../items/OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)     | ⚠ Rewritten same session: the store is `Integration_Log__c` and **already works**. The real defects are two in `API_Callout_Engine` — `Is_Error__c` never set for an HTTP error, and the `catch` dropping `Response_State__c`. |
| [OI-108](../items/OI-108%20The%20Anticipay%20payload%20carries%20personal%20data%20of%20the%20legale%20rappresentante.md) | **Six of eleven fields identify a private individual** — name, codice fiscale, date and place of birth, home address.                                                                                                          |
| [OI-106](../items/OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md)                   | **One static token for `test` and `prod`**, printed in a PDF mailed twice to six addresses including a shared mailbox.                                                                                                         |
| [OI-105](../items/OI-105%20The%20Anticipay%20date%20of%20birth%20field%20name%20is%20misspelled.md)                       | `data_di_dascita_legale_rappresentante` — a typo in the wire format, in both places the document names it.                                                                                                                     |

Plus, inside the contract note rather than as items: **`400` and `401` are new
error codes nobody has discussed**; the `404` description **names Salesforce as
the system searched**, which is wrong; there is **no rate limit, timeout, retry
policy or cache TTL**; and the agreed **manual re-check button** has no
documented way to bypass the cache.

### 4. 🟢 The field list answers OI-95 better than expected, and closes two candidates

The eleven fields **exactly match the as-is Mexal pre-invoicing lookup** Elisa
Migliano described on 6 August. The middleware is not a trimmed view of a larger
Anticipay payload — it is the service Pienissimo already uses, re-exposed.

Two candidates named in the 25 August session are **not available**: the
**Anticipay reliability score** Fabrizio Paganelli asked about, and
**`rappresentante fiscale`** (the document returns `legale rappresentante`, a
different role). `pec` **is** present, as the 31 August note predicted.

### 5. ⚠ Nine of the eleven fields have nowhere to land

Account carries three custom fields in total. `ragione_sociale` maps to `Name`
and the address block to the standard billing address; **PEC and all five
legal-representative fields have no home in the org.** `Integration_Configuration__c`
has the right shape for the endpoint but **zero rows and zero permissions**, and
its `Named_Credential_Prod__c` / `_Sandbox__c` split does not fit an API whose
environment is a path segment.

## What it changed

**Five notes updated, five created. No requirement changed** — the YAML register
and both prose requirement documents are untouched. Nothing the client has signed
moved today.

| Written                                 | Because                                                                                                               |
| --------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| `The Anticipay middleware API contract` | **new** — the decode; the record of a file that is not preserved in-repo                                              |
| `OI-105`, `OI-106`, `OI-107`, `OI-108`  | **new** — see above                                                                                                   |
| `OI-94`                                 | the contract table gains a "documented" column; the test environment and error codes resolved; the 1 September agenda |
| `OI-95`                                 | the real field list replaces the remembered one; score and rappresentante fiscale closed as unavailable               |
| `OI-73`                                 | the middleware contract exists; still waiting on the same two decisions                                               |
| `MAP.md`, `INDEX.md`                    | the 01/09 block and five new artifacts                                                                                |
| `JOURNAL.md`                            | session entry                                                                                                         |

Also: `open-items.md` **and** `.it.md` — four new rows **105–108** and a status
block; a new **§23** in `DEVELOPMENT-RECAP.md` **and** `.it.md`.

## Deliberately not done

- **The PDF was not copied into the repository**, breaking the precedent set by
  `Payload woo-salesforce.json`. It carries a **live bearer token** and a real
  individual's full personal data; committing it would put a working credential
  into git history where deleting the file does not remove it. The contract note
  is the record instead, and it holds structure with no values.
- **No token value, no sample personal data and no VAT number** was written to
  `notes/`, the trackers, the recaps, `STATUS.md` or [site/](../../site/).
- **`INT-18` was not edited.** ⚠ The register still reads
  `status: open, recommendation: phase_2` for _"Anticipay VAT check timing and
  foreign-VAT handling"_, while the whole record — OI-73, the 10 July project
  plan, the 25 August session — treats this as **Fase 1**. That contradiction is
  real and predates today. Fixing it means changing a signed document in both
  languages, which is not this session's to do unilaterally: raise it with
  Elena Spini.
- 🔴 **The 1 September meeting was not drilled.** Its recording and Gemini notes
  exist and were located, but reading them is the `drill-meeting` procedure's job
  and a much larger piece of work than was asked for. **It is the single most
  valuable thing outstanding on this project right now**, because it may already
  answer several of today's four new items.
- **No sweep.** Slack, Drive, Fathom and the rest of Gmail were not searched. The
  31 August watermark stands.

## Still owed, unchanged by today

Everything in the 31 August trace's list stands, **minus** the PDF, which is now
read. Newly sharpened:

- ⚠ **The error response examples** — one per code, as emitted. Downgraded from 🔴: it lets the response wrapper tolerate the error shape, not unblock the store
  ([OI-107](../items/OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)).
  This is what the build waits on.
- 🔴 **A date from Fabrizio Paganelli and Elisa Migliano** on the field selection
  ([OI-95](../items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md)).
  Held since 25 August with no date; they have had the list since 31 August.
- 🔴 **Whether an export was taken before the 28/08 destructive deploy.** Only
  Anita Aga can answer, and the recovery window still closes around
  **12 September**. Untouched by today and still the only decaying finding.

## Method notes worth keeping

- **A downloaded attachment is worth more than a well-argued inference.** The
  31 August sweep reasoned correctly from the mail body to the `404` ambiguity,
  and that inference held up. It could not have produced the misspelled field
  name, the missing error body, the two undiscussed error codes or the personal
  data — **four findings, three of which change what gets built.** When a
  document is the contract, the file has to be opened.
- **Ask what a specification does not say.** This document is complete and
  well-formed on the happy path, which is exactly why the missing error body went
  unnoticed on first reading. The gap was found by checking the document against
  **what the 25 August session asked for**, not by reading the document on its own
  terms.
- **A contract that changes twice in seventeen hours is not frozen.** v2 arrived
  the morning of the call it was written for. Nothing has been built yet so there
  is no rework — but ask whether more changes are coming before a developer starts.
