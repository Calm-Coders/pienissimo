# [ROMI-PIENISSIMO] Demo Sales — 2026-06-03

**Sources:** [meetings/2026-06-03-demo-sales-transcript.it.md](../2026-06-03-demo-sales-transcript.it.md) (original Italian transcript, 93 min)

**Attendees:** Elena Spini (ROMI), Sabatino Rinaldi, Fabrizio Paganelli, Marco Montesi (in room), Elisa Migliano (Pienissimo); Daniela Morgese joined ~16:27 and left ~1:20. Andrea Di Cicco referenced but not speaking. Speaker labels partially garbled (some "Fabrizio"/"Daniela" lines are other speakers).

Purpose: guided demo of the Salesforce **Sales Console** on ROMI's demo org — home dashboards, lead list/Intelligence View, record pages, activities/tasks, owner reassignment, lead conversion, opportunities, quotes, visibility — plus the first sketch of the ticket/Asset flow.

## Decisions / Agreements

- **Sales demo delivered** (marketing demo scheduled for the next day, June 4). Platform will be used in Italian — standard labels auto-translated, custom labels to be translated in the org's translation workbench.
- **Lead vs Opportunity — first alignment round.** Pienissimo's definitions: *lead* = self-serve action with no purchase intent (live-stream signup, free video download); *opportunity* = explicit interest in a product/service, even from someone unknown. Daniela's framing: **lead = still marketing's job (nurturing, marketing KPIs); opportunity = commercial's job** ("when the ball is smashed to sales, the client is already hot"). A lead can self-convert within hours via a call-to-action form. No lead-with-opportunity state exists for them (that's a prospect/client). "Prospect" concept parked for a later decision with Daniela.
- **Form-based tracking**: every landing/live/event has its own form; forms also appear on YouTube videos and live QR codes. Salesforce conversion (lead → account + contact + opportunity) demoed; campaign history carries over on conversion (standard). **Sabatino to send a Google Sheet of form links, split lead-forms vs opportunity-forms.**
- **Daniela's key analytics requirement:** distinguish opportunities generated on **existing clients vs new business**, per source — today untracked; she suspects paid ads (Meta/Google) are being spent to reach clients internal marketing could serve ("we pay 50 times for the same client"). Lead = new registry with no interest yet; client requests should not consume ad spend.
- **Account-page requirements gathered:** show *nome locale* alongside ragione sociale (restaurant brand ≠ legal entity); total acquisition cost of the contact; the **RFM matrix** visible on the account; campaign origin + cost history for lifetime tracking.
- **Next Best Action (AI suggestions)** requested by Sabatino → Elena to check licenses *(answered June 16: only Marketing Cloud Einstein licensed, pay-per-use — parked)*.
- **CreditSafe/Anticipay surfaces for the first time:** existing Zoho API integration that auto-fills company registry (VAT, ragione sociale, legal seat, legal representative) — today fired at quote/order time, not at account creation. Daniela: correct data must arrive much earlier (marketing on wrong data is useless); also revealed Sabatino is implementing **double opt-in** on forms, which may fix garbage-in at the source. Timing of the CreditSafe call to be defined.
- **Opportunity stages (Pienissimo's design):** negotiation (with sub-levels: first appointment/trattativa, quote sent, quote recall) → rinviata (postponed) / perso / vinto. Sabatino sent the phase diagram via WhatsApp. Quote generation happens in Salesforce (standard Quote object → PDF → DocuSign for signature); recall/escalation tasks with delays visible to the sales manager.
- **Visibility model:** ~6 salespeople; default = restrict then widen (never the reverse); hierarchy mirrors the org chart (already provided in the survey); each rep's dashboards auto-filter to their records.
- **Invoicing phasing:** opportunity won → Order created in Salesforce → triggers Mexal invoicing. Analysis anticipated now, build in phase 2 (post-September); Fabrizio insisted invoicing rules differ per business line and must be designed before September to avoid surprises. First mention that **Pienissimo already owns Mexal API licenses** — docs to be sent.
- **Asset concept for tickets (Elena's proposal, to validate with Daniela):** Asset record joins order + contacts; states stand-by (bank transfer pending) → ready; signed privacy/non-compete docs collected as Files under the asset; **signature generates the QR code (= the ticket)**; scan at event → check-in. Fabrizio's caveats: invoice-paid flag gates availability; **not all contacts under an account attend** (the owner decides who comes, up to the ticket count); deep-dive needed — "this is the heart of our business."

## Action Items

| Task | Owner | Status |
|---|---|---|
| Send Google Sheet of form links, split lead vs opportunity | Sabatino | Open — chased on 06/08 and reviewed live on 06/16, full list still pending |
| Check Next Best Action / Einstein license availability | Elena | Done 06/16 — not licensed (Marketing Cloud only, pay-per-use); parked |
| Define CreditSafe/Anticipay call timing (account creation vs order) + re-implement integration | ROMI + Fabrizio | Open — continues as tracker #21 |
| Define double opt-in fields and flow on forms | Sabatino + Fabrizio | Open |
| Define quote recall/escalation rules, then configure flows | Joint | Open — folded into the lead/opty flow work |
| Define territory/visibility rules; configure sharing from org chart | Joint | Open |
| Send Mexal API docs to Elena | Fabrizio | Done — delivered with the 8 CSVs (early July) |
| Validate Asset/ticket flow (signature-gated QR) with Daniela | Sabatino | Done — deep-dive held 06/08, direction confirmed later |
| Send minutes; confirm June 8 technical session with Daniela | Elena / Sabatino | Done (session held 06/08) |

## Notes

- The org shown is ROMI's demo org (extra licenses visible, e.g. Einstein, Maps — "pretend it's not there").
- Dedup rules discussed (lead↔account matching keys, e.g. VAT/company) for multi-contact accounts and repeat leads.
- Sabatino's automation ask (lead arrives → auto-task to fix a call, welcome email) confirmed feasible via flows — rules to be defined in the technical meetings.
