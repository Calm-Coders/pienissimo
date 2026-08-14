---
id: flow-quote-to-order
type: flow
status: in-progress
owner: ROMI
org: ROMI
updated: 2026-08-14
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
requirement: SAL-17
---

# The quote to order flow

Settled on 2026-08-06. It replaced the accept/reject buttons that were to sit
inside the quote email — a design that would have let an external client mutate
CRM data directly.

1. The quote email carries a **link, not buttons**.
2. The link opens a **landing page** showing preventivo + contratto + condizioni
   generali as a single PDF —
   [OI-68](../items/OI-68%20Quote%20acceptance%20landing%20page.md).
3. **Rifiuto** sets the quote _Rifiutato_. **Accetto** sends the documents via
   **DocuSign**.
4. On signature the quote flips to _Accettato_ and **the order is generated
   automatically**.
5. The order runs **Ordinato → Fatturato → Incassato** —
   [OI-69](../items/OI-69%20Order%20state%20model.md). The old "Chiuso acquisito"
   state is deleted.
6. **The Opportunity goes Closed Won only when the order reaches _Incassato_.**
   Payment closes the opportunity, not signature.

**DocuSign is in for the commercial document and out for tickets** — Elena
Spini: _"la firma digitale c'è solo per i preventivi."_ That split is what
finally closed the long-running buy-or-drop question on DocuSign.

Configuration still owed on the quote side: 5-day validity with expiry
mandatory at send, alerts on day 2 and at expiry, a "qualificato da
ricontattare" state and a manual creation button —
[OI-59](../items/OI-59%20Quote%20workflow%20configuration.md), which also waits on
Marco Montesi's list of preset expiry timings per product category.

Two order-side questions are still open: whether a fourth state _Perso_ is
needed ([OI-85](../items/OI-85%20Order%20state%20set%20may%20be%20incomplete.md)) and
how the [credit-note flow](../items/OI-54%20Credit%20note%20flow.md) reverses
lines.
