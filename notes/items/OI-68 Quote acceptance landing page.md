---
id: OI-68
type: open-item
status: in-progress
owner: ROMI
org: ROMI
raised: 2026-08-06
updated: 2026-08-26
requirement: SAL-16
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
---

# OI-68 - Quote acceptance landing page

Replaces the accept/reject buttons that were to sit inside the quote email.

A link opens a landing page showing **preventivo + contratto + condizioni
generali** as a single PDF, with **Accetto / Rifiuto**. Accept sends the
documents via **DocuSign**; on signature the quote flips to _Accettato_ and the
**order is generated automatically**. Reject sets the quote _Rifiutato_.

The reason for the change is worth keeping: buttons in an email would have let
an external client mutate CRM data directly. The landing page puts a controlled
surface in between.

**Design agreed, build pending.** It is the entry point of
[the quote to order flow](../flows/The%20quote%20to%20order%20flow.md) and the
first thing that needs DocuSign wired up — which makes it the reason
[the DocuSign code missing from source control](../risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md)
matters commercially and not just hygienically.

Configuration around it is [OI-59](OI-59%20Quote%20workflow%20configuration.md).

## 2026-08-24 - the mechanism is chosen and a PoC is owned

The [24 August Lead/Opty session](../meetings/2026-08-24%20Interna%20per%20update%20flusso%20Lead-Opty.md) settled how the quote reaches the client:
**both by email and as a link to a custom landing page / portal**, built as a
custom **LWC** specifically to control external access.

**Aurel Mrruku owns the proof of concept** — it is on his action list from that
session as _"Creare PoC landing page"_. That makes this the first item in the
quote chain with a named owner and a concrete technology.

The [master diagram](../The%20newest%20design%20diagram.md) carries the surrounding flow: on `Status Quote == In
Trattativa`, a mail goes out with the redirect link to a landing page holding the
quote plus the contract with general conditions and **ACCETTATO / RIFIUTO**
buttons; on acceptance, the DocuSign signature mail follows, and on signature the
quote moves to `ACCETTATO` with the order created as a copy in state `ORDINATO`.

⚠ The diagram's worked example for this flow is a **real customer order**,
carrying a live company name and VAT number. Keep it out of the notes, the recaps
and `site/`.

Not settled: who hosts it, and whether it is the same surface as the participant
landing page in [OI-86](OI-86%20Who%20hosts%20the%20participant%20landing%20page.md).
