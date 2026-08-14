---
id: flow-mexal
type: flow
status: in-progress
owner: Andrea Di Cicco
with: Mirko Merendi
org: both
updated: 2026-08-14
depends_on: [OI-58]
source: meetings/open-items.md row 58
requirement: INT-01
---

# The Mexal integration

Mexal (Passepartout, integrator Kreosoft) is Pienissimo's ERP and stays the
system of record for invoicing. The approach was provisionally file-based on
2026-07-02 and **reversed to REST API on 2026-07-07** once ROMI read the
delivered documentation — eight CSV files were judged unmanageable.

Mechanics settled 2026-07-14
([OI-58](../items/OI-58%20Mexal%20integration%20mechanics.md)):

- **Salesforce is the source of truth for new records; Mexal for administrative
  edits**, with periodic realignment. Edit rights on the synced client registry
  are restricted to admin users.
- **Nightly scheduled GETs keyed on "data ultima modifica"** — delta only.
  Invoice pulls need date filters and pagination: ~2,300 invoices in 2025
  against 6 MB sync / 12 MB async callout limits.
- No repeated order GETs — the id comes back on create — but a **"rinvio
  ordine" button** exists. Product import has an on-demand button as well as the
  nightly job.
- Agents live as **suppliers under mastro 610**.
- A ragione-sociale change needs a registry field referencing the previous
  code/VAT.

**WEBAPI credentials arrived 2026-07-15** (`services.passepartout.cloud`,
dominio PIENISSIMO, azienda PIE), so the build is unblocked. **There is no
Mexal test environment** — a test company still has to be created.

What travels: the whole order, all lines, with the tranche reference at **line
level** rather than as an object; Mexal updates payment status per line and
Salesforce aggregates upward — Mexal never writes the tranche
([OI-50](../items/OI-50%20Tranche%20object.md)). At invoicing, n Mexal invoices
become n Salesforce invoices. **Zero-euro orders stay in the CRM and are not
transferred** ([OI-57](../items/OI-57%20Zero-euro%20orders%20stay%20in%20the%20CRM.md)).

This integration is configured on top of
[ROMI's standard integration scaffolding](../Integration%20Configuration%20is%20standard%20ROMI%20scaffolding.md) —
`Integration_Configuration__c`, `Integration_Log__c` and `API_Callout_Engine`,
committed in early August. The scaffolding is house pattern; the Mexal-specific
configuration on top of it is the project requirement.
