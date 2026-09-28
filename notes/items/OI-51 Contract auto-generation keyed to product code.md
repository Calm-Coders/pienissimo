---
id: OI-51
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-07-22
updated: 2026-08-14
depends_on: [OI-70, OI-71]
source: meetings/open-items.md row 51
---

# OI-51 - Contract auto-generation keyed to product code

The Performance Plus contract — dates, status, total, invoiced, collected,
overdue — is triggered by the **product code on the order**, not by order
status. That mirrors the bundle discriminator: the product decides what
happens, not the workflow state.

Also raised in the same session: **"tipi ordine"** (bundle da palco, palco,
performance) to differentiate workflows and reporting, which interacts with the
order-typology field.

Decision taken, configuration pending. Nothing exists —
`Order` carries no custom fields in the repository.

Two inputs have to be settled first:
[opportunity typing](OI-70%20Performance%20Plus%20opportunity%20typing.md), since
attivazione versus rinnovo determines which contract is generated, and
[the service start date](OI-71%20Service%20start%20date%20owned%20by%20the%20Strategist.md),
since the generated contract has a period nobody knows at signature.

The contracts-as-database reporting that Pienissimo asked for at kickoff —
renewals panel, invoiced versus collected per contract, service-block on
arrears — all sits downstream of this.
