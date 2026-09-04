---
id: OI-112
type: open-item
status: resolved
owner: Fabrizio Paganelli
with: Andrea Parmeggiani
org: both
raised: 2026-09-03
updated: 2026-09-04
depends_on: [OI-94]
requirement: INT-18
source: notes/meetings/2026-09-03 Data Model Parte 1.md
---

# OI-112 - Whether Anticipay returns the ATECO code

**Three ATECO fields are staying on the customer registry, and nobody knows
whether the Anticipay call can fill them.**

Agreed at [Data Model Parte 1](../meetings/2026-09-03%20Data%20Model%20Parte%201.md):
`Codice Ateco`, `Ateco Desc` and `Ateco Stato Attivita` are classified as **Dati
Commerciali** and stay editable by the tutors. That settles where they live and
who may change them. It does not settle where the value comes from.

Fabrizio Paganelli raised the question himself and framed it as cheap:

> _"bisognerebbe chiedere ad Andrea se nell'ambaradan di quello che va a leggere
> da Anticipi quel campo lì il codice ateco esiste perché se esiste glielo
> potremmo far prendere direttamente da Anticipi."_

(The Gemini summary renders "ATECO" as "Codice Teco" throughout — the same field.)

## Why the answer matters more than it looks

**The documented Anticipay response has eleven fields and ATECO is not among
them** ([the contract](../The%20Anticipay%20middleware%20API%20contract.md)). So
on the documentation ROMI holds, the answer is already _no_.

But the documentation has been wrong by omission before: the foreign-company
error body is not in it and was found live
([OI-107 §3](OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)),
and **no lookup has ever actually run**, so no real response body has been seen.
Asking is therefore worth more than reading the PDF again.

If the answer is no, three commercial fields become **hand-keyed on every new
customer**, which is a cost nobody has priced and which the session did not
discuss.

⚠ **This is one of three questions now queued for Andrea Parmeggiani**, alongside
[the error response bodies](OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md),
[the `data_di_dascita` typo](OI-105%20The%20Anticipay%20date%20of%20birth%20field%20name%20is%20misspelled.md)
and the date `env=test` starts forwarding. **None has been sent.** They should go
in one mail.

**No date was set.**

## ✅ 2026-09-04 — resolved, and the answer is yes

**Anticipay will return the ATECO code, its description, and the codice
fiscale.** Settled at
[Data Model Parte 2](../meetings/2026-09-04%20Data%20Model%20Parte%202.md), six
minutes into the call.

Elisa Migliano did not wait for a mail to be drafted — she went to Andrea
Parmeggiani herself and reported back in the room:

> _"poi vi ha scritto, non so se avete gia visto la mail. Allora, lui passera
> anche il codice ATECO e la descrizione del codice ATECO."_

and, on a field she spotted while going through it with him:

> _"gli ho chiesto di passare anche … mi sembra il codice fiscale. … Pero ve lo
> passera direttamente lui da Anticipay."_

Aurel Mrruku confirmed both that he had seen it — _"ho visto"_, _"sto qua, lo
stavo lavorando tipo 20 minuti fa"_ — and that a codice fiscale field was already
planned. He also established the shape of the answer: **it is the same call**, not
a second one. Elisa Migliano: _"nella stessa chiamata."_

## What this changes

🟢 **The three ATECO fields are not hand-keyed.** The cost this item warned about
— three commercial fields typed by hand on every new customer — does not arise.

🟢 **The documented eleven-field response is now out of date.** The Anticipay
contract note records eleven fields with no ATECO among them
([the contract](../The%20Anticipay%20middleware%20API%20contract.md)). At least
**three more** are being added: `codice ATECO`, `descrizione ATECO`, `codice
fiscale`. This is the second time the documentation has proved incomplete rather
than wrong — the first being the foreign-company error body
([OI-107 §3](OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)).

🟢 **The queue for Andrea Parmeggiani drops from four questions to three** — the
error bodies, the `data_di_dascita` typo, and the date `env=test` starts
forwarding. **It still has not been sent.**

## ⚠ The mail confirming this is not in the swept mailbox

Elisa Migliano says Andrea Parmeggiani wrote — _"ha mandato adesso due mail
praticamente Andrea"_ — and Aurel Mrruku confirms reading it. **Neither mail
appears in `a.mrruku@romicompany.com`.** Searched by sender, by domain, and by
keyword across 4 September; the newest message from `andrea.p@pienissimo.pro`
remains 2 September 10:18Z.

So this item is resolved **on the meeting record, not on the document**. The
field list, types and exact names are in a mail nobody has retrieved, and
whoever maps the response will need it. **Ask Aurel Mrruku where it landed**
before assuming a fourth revision of the API documentation exists.
