---
id: OI-58
type: open-item
status: in-progress
owner: Andrea Di Cicco
with: Mirko Merendi
org: both
raised: 2026-07-14
updated: 2026-08-24
source: meetings/open-items.md row 58
---

# OI-58 - Mexal integration mechanics

Settled on 2026-07-14. The full mechanics — direction of truth, delta GETs,
callout limits, mastro 610, the "rinvio ordine" button — are written up in
[the Mexal integration](../flows/The%20Mexal%20integration.md).

**WEBAPI credentials were delivered on 15 July** (`services.passepartout.cloud`,
dominio PIENISSIMO, azienda PIE), so the build is unblocked.

**The field mapping is answered, and the workbook has now been read.** Andrea Di
Cicco sent the per-API workbook on 2026-08-07; Mirko Merendi returned it filled
in on 2026-08-11. `Integrazioni pienissimo.xlsx` was opened on 2026-08-14 and
its contents — seven sheets, three previously unrecorded calls, the target
column structures — are in
[the Mexal integration](../flows/The%20Mexal%20integration.md).

🔴 **It exposed a gap:** `Get Fatture` maps `numero_ordine` but **no order-line
number**, which is the key
[ticket availability](OI-75%20Ticket%20availability%20rule.md) was agreed to match
on. Raise it at the 27 August call.

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

## 2026-08-24 - a field-level mapping exists for the first time

Andrea Di Cicco created **`Integrazioni pienissimo.xlsx`** on 2026-08-24 and
presented it at [the Follow-up Interno](../meetings/2026-08-24%20Follow-up%20Interno.md) the same afternoon. See
[the Mexal integration mapping workbook](../The%20Mexal%20integration%20mapping%20workbook.md) for what it covers — entity list
with methods, Mexal manual page references, sync cadence, and a per-field
customer payload mapping.

Until now this item rested on meeting narration. It now has an artifact.

**Also settled at that session:**

- **The sandbox test pattern** — new customers under code **501**, new orders on
  **series 10**.
- **GET calls run once a day** for changed records.
- Andrea Di Cicco to send **the Postman collection** to Aurel Mrruku.

**Still open, and named as the hard part:**

- **The invoice-to-order-line link.** Instalment invoices against order lines are
  not yet understood; Andrea Di Cicco holds the action to study the detail call
  that confirms payment status.
- **Agent vs supplier filtering** on the read calls — needs Fabrizio Paganelli.

⚠ The **Mexal WEBAPI credentials** promised since July have still not arrived,
and Mirko Merendi's technical mail to Fabrizio Paganelli is still unanswered —
Fabrizio Paganelli was asked on 20 August to reply before the 26 August review.
