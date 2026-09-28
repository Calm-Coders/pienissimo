---
id: trace-2026-09-02-anticipay-v3
type: reference
status: active
updated: 2026-09-02
watermark_used: none
external_watermark: none
account: a.mrruku@romicompany.com
---

# Source trace 2026-09-02 Anticipay endpoint move

🔴 **Not a `requirements-check` sweep, and not a watermark.** The last real sweep
is [the 31 August trace](Source%20trace%202026-08-31.md), watermark
**2026-08-31T22:00Z**, and it is still the one the next run must use. Slack,
Drive and Fathom were **not** searched. This is a targeted drill of a third
revision of one document, plus the mail thread around it.

⚠ Separately, an **`org-status-check` ran earlier today**, 08:05–08:14Z, full
scope and reconciled. Its output is a different piece of work and is not
described here beyond the one finding that collides with this one (§4).

## Sources read

Read-only. **Nothing was sent, replied to, drafted or marked read.**

| Source         | Scope                                                                                | Result                                                                         |
| -------------- | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ |
| **Local file** | `~/Downloads/Documentazione API - Salesforce (1).pdf`, 192 KB, 2026-09-02 12:47 CEST | extracted and **diffed against the v2 extraction**                             |
| **Gmail**      | `from:pienissimo.pro newer_than:3d`                                                  | thread `1a0589a4a85b5bdf`, now **5 messages** — two of them Aurel Mrruku's own |
| **Repo**       | the record's references to the old host                                              | 10 occurrences across 9 files, updated or annotated                            |

## Found

### 1. 🟢 The endpoint moved, and works for the first time

| Time (UTC)   | Who                | What                                                                                                                       |
| ------------ | ------------------ | -------------------------------------------------------------------------------------------------------------------------- |
| **08:21:59** | Aurel Mrruku       | _"il server al momento non risulta raggiungibile… `HTTP/1.1 404 Not Found` `Content-Type: text/html; charset=iso-8859-1`"_ |
| **10:18:26** | Andrea Parmeggiani | _"Ho impostato un nuovo terzo livello: romi.pienissimo.com"_ + **v3**                                                      |
| **10:40:45** | Aurel Mrruku       | _"Confermo che adesso funziona."_                                                                                          |

**`integration.pienissimo.com` — the host in v1 and v2 — never resolved.** Every
statement written about this API before today described an endpoint that did not
exist. Two hours from report to confirmed fix.

### 2. v3 changes the host and nothing else

**Diffed, not assumed.** v2 extraction 5,529 bytes, v3 5,515; `diff` returns
**two lines**, both the hostname. Everything else is identical — so the
`data_di_dascita` typo, the missing error body, the `404` description naming
Salesforce, and **the bearer token** all survive a third revision unchanged.

⚠ **Three revisions in three days and nobody has raised the typo or the error
body.** Both asks were recorded on 1 September and neither has been made.

### 3. 🔴 A third meaning for `404`, demonstrated rather than predicted

An HTML `404` from a wrong hostname is not the API's `404`. On top of _VAT
unknown_ and _not cached under `env=test`_, `404` now also means **the endpoint
is wrong** — separable only by `Content-Type: text/html`.

**This is the concrete case that breaks
[OI-107](../items/OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)'s
second defect.** `API_Callout_Engine` deserialises into the `200` wrapper before
checking status; HTML is not JSON, so it throws, and the `catch` rebuilds the log
row **without `Response_State__c`**. A dead endpoint would be logged as an Apex
parse error with no status and no error flag. Aurel Mrruku caught it in seconds
**because he was in a mail client**; through the engine it would have been
invisible.

### 4. ⚠ The org's `Anticipay` named credential predates the move

Today's org check found it at **08:05–08:14Z** — before the new host existed, and
before the old one was reported dead. It was created against the only hostname
anyone had, so it very probably carries `integration.pienissimo.com`. Being
org-only, no diff or deploy would surface it.
[The credential risk](../risks/Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md)
now carries this; **check it in Setup before wiring anything to it.**

### 5. 🔴 Reachability is not the contract

No lookup has ever run. No `200`, no `404`, no error body has been observed. What
is proven is that the hostname resolves. **The eleven fields agreed on
1 September are still not built** — eight days to 10 September, and that work
never needed an endpoint or a token.

## What it changed

**Six notes updated, one created. No requirement changed.**

| Written                                                | Because                                                                             |
| ------------------------------------------------------ | ----------------------------------------------------------------------------------- |
| `Source trace 2026-09-02 Anticipay endpoint move`      | **new** — this note                                                                 |
| `The Anticipay middleware API contract`                | v3 provenance, the new host, the confirmed-working section, the third `404` meaning |
| `OI-94`                                                | the move, what is proven and what is not                                            |
| `OI-105`                                               | the typo survived a third revision; the window to fix it cheaply is closing         |
| `OI-107`                                               | **§2b** — defect 2 stopped being hypothetical                                       |
| `Risk - integration credentials exist only in the org` | the credential predates the host change                                             |
| `MAP.md`                                               | the 02/09 Anticipay block                                                           |

Also: `open-items.md` **and** `.it.md` row **94**; a new **§26** in
`DEVELOPMENT-RECAP.md` **and** `.it.md`.

## Deliberately not done

- **The v3 PDF was not committed**, same reasoning as v1–v2: it carries the live
  bearer token and a real individual's personal data.
- **No token value was written anywhere.**
- **The named credential was not opened.** §4 is a timing inference, stated as
  one. Somebody with the org open has to confirm it — and read the endpoint only.
- **No mail was sent.** The two overdue asks (error examples, the typo) are
  recorded, not dispatched.

## Method note

**A document can be perfectly specified and still describe nothing.** Three
sessions of analysis went into a contract whose host had never resolved, and no
amount of re-reading the PDF would have found it — it took one HTTP request. When
a spec names an endpoint, **curl it before drilling it**; the reachability check
is seconds and it bounds everything else. That is now the first thing to do with
any endpoint this project is handed.
