---
id: OI-112
type: open-item
status: open
owner: Fabrizio Paganelli
with: Andrea Parmeggiani
org: both
raised: 2026-09-03
updated: 2026-09-03
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
