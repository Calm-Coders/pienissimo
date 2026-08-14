---
id: OI-68
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-08-06
updated: 2026-08-14
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
requirement: SAL-17
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
