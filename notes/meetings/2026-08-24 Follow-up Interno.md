---
id: MTG-2026-08-24-followup
type: meeting
status: resolved
owner: Elena Spini
org: ROMI
raised: 2026-08-24
updated: 2026-08-24
source: Drive - "[PIENISSIMO] - Follow-up Interno - 2026/08/24 17:29 CEST - Appunti di Gemini", doc 1IW6Lb_FLWVIekj5R3CLohNNsbXSuhgrXczug_wFBztU
---

# 2026-08-24 Follow-up Interno

**ROMI-internal session, 24 August 2026, 17:29 CEST** — Elena Spini, Aurel
Mrruku, Andrea Di Cicco, Fabrizio Mastracci. Gemini notes, transcript and a
recording exist. It ran immediately after
[the Lead/Opty session](2026-08-24%20Interna%20per%20update%20flusso%20Lead-Opty.md).

This is where the **Mexal integration became concrete** and where the campaign
model agreed with the client on 20 August was turned into a Salesforce
configuration.

⚠ ROMI-internal. Not put to the client.

## Agreed

- **Mexal test pattern is fixed** — new customers are created under code **501**,
  new orders on **series 10**. This is the sandbox convention for the
  integration work.
- **Campaigns on Salesforce are a manual process**, to handle the several
  editions of each event. This confirms the 20 August client agreement.
- **The parent campaign code goes on the Product**, as a **lookup field**, so the
  asset can be attached automatically to the correct active child campaign. The
  lookup is **populated by hand after the campaign is created**.
- **The asset-to-child-campaign automation keys on the campaign code** checked as
  the order descends from Mexal.
- **Campaign membership is created only at enrolment** — the purchaser is
  explicitly **not** added as a campaign member merely by buying. See
  [OI-84](../items/OI-84%20Campaign%20Member%20handling%20for%20manual%20check-in.md).

Two further configuration rulings appear in the actions rather than the decision
list, and are drawn into the design file the same afternoon:

- **Two Record Types on Campaign**, one for parent and one for child.
- **Only one child campaign active per parent**, enforced by automation.

All of this is written up as
[the campaign parent and child model](../objects/The%20campaign%20parent%20and%20child%20model.md).

## The integration mapping

Andrea Di Cicco shared an Excel mapping the fields between the Mexal integration
and Salesforce, and walked through it — GET calls run **once a day** for changed
records. It is now in Drive as
[the Mexal integration mapping workbook](../The%20Mexal%20integration%20mapping%20workbook.md).

Open at the end of the session:

- **The invoice-to-order-line link is not yet understood.** Instalment invoices
  against order lines were called out as the complex part, and Andrea Di Cicco
  took the action to study the detail call that would confirm payment status.
- **Agent and supplier filtering is undefined** — the group has to ask Fabrizio
  Paganelli which filter distinguishes agents from suppliers on the read calls.

The scadenziario was confirmed as the mechanism that lets Salesforce realign an
asset's state when an invoice is changed — which is the answer
[OI-92](../items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md)
was routed to Andrea Di Cicco to get on 20 August. It is **an approach confirmed,
not a built mechanism**.

## Actions

| Owner | Action |
| ----- | ------ |
| Andrea Di Cicco | Verify the invoice field mapping; work out how to retrieve the detail that confirms payment status |
| Andrea Di Cicco | Send the Postman collection to Aurel Mrruku |
| Andrea Di Cicco | Test customer creation with code 501 and order creation on series 10 |
| Andrea Di Cicco | Investigate the detail call linking invoice to order line, and how to update payment status |
| Elena Spini | Send the minutes and the link to the updated workflow on Drive |
| The group | Contact Fabrizio Paganelli to define the agent filtering logic |
| The group | Create the parent-campaign-code lookup field on Product |
| The group | Split campaigns into two Record Types, parent and child |
| The group | Automate "only one active child campaign per parent" |

Elena Spini's action to circulate the minutes and the updated workflow link is
consistent with `Flows & Objects.drawio` being modified at **16:34 UTC that
day** — see [the newest design diagram](../The%20newest%20design%20diagram.md).
