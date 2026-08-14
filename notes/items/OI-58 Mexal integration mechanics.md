---
id: OI-58
type: open-item
status: in-progress
owner: Andrea Di Cicco
with: Mirko Merendi
org: both
raised: 2026-07-14
updated: 2026-08-14
source: meetings/open-items.md row 58
requirement: INT-01
---

# OI-58 - Mexal integration mechanics

Settled on 2026-07-14. The full mechanics — direction of truth, delta GETs,
callout limits, mastro 610, the "rinvio ordine" button — are written up in
[the Mexal integration](../flows/The%20Mexal%20integration.md).

**WEBAPI credentials were delivered on 15 July** (`services.passepartout.cloud`,
dominio PIENISSIMO, azienda PIE), so the build is unblocked.

**The field mapping is now answered.** Andrea Di Cicco sent the per-API workbook
on 2026-08-07; Mirko Merendi returned it filled in on 2026-08-11 with answers to
all eight questions — agent filter, availability formula, the two-step invoice
retrieval, client-code generation and the order serie. The detail is in
[the Mexal integration](../flows/The%20Mexal%20integration.md).

Three things still sit under this item:

- **Listino 1 versus listino 2** — Mirko deferred to Fabrizio Paganelli, who has
  not answered. Whether a third listino could ever be needed is also open.
- **There is still no Mexal test environment.** Serie `10` gives a test lane,
  but inside the **production** company — test orders land in live data. A test
  company was the ask; nobody owns it.
- A registry field referencing the **previous code and VAT** is needed so a
  ragione-sociale change does not orphan the account.

⚠ The credentials arrived by email. Treat them as
[sensitive](../../docs/publishing.md) — they must not appear in notes, recaps or
the public site.

The build sits on
[ROMI's standard integration scaffolding](../Integration%20Configuration%20is%20standard%20ROMI%20scaffolding.md),
committed in early August. That is house pattern and needs no requirement of its
own — what this item tracks is the Mexal-specific configuration on top of it.
