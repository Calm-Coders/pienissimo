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

Two things still sit under this item:

- **There is no Mexal test environment.** A test company has to be created
  before anything can be exercised safely. Nobody is recorded as owning that,
  and it gates every integration test.
- A registry field referencing the **previous code and VAT** is needed so a
  ragione-sociale change does not orphan the account.

⚠ The credentials arrived by email. Treat them as
[sensitive](../../docs/publishing.md) — they must not appear in notes, recaps or
the public site.

The build sits on
[ROMI's standard integration scaffolding](../Integration%20Configuration%20is%20standard%20ROMI%20scaffolding.md),
committed in early August. That is house pattern and needs no requirement of its
own — what this item tracks is the Mexal-specific configuration on top of it.
