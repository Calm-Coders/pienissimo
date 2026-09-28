# [ROMI-PIENISSIMO] Salesforce Kick-Off — 2026-05-27

**Sources:** [meetings/2026-05-27-salesforce-kickoff-transcript.it.md](../2026-05-27-salesforce-kickoff-transcript.it.md) (original Italian transcript, 46 min — Fathom recording: https://fathom.video/calls/686882530)

**Attendees:** Sabatino Rinaldi (Pienissimo), Elena Spini (ROMI Company), Andrea Galotto (ROMI Company), Andrea Di Cicco (ROMI Company). Also present/referenced on the Pienissimo side: Daniela (admin/warehouse process), Fabrizio (admin/finance). Referenced but not present: Giuliano Aranzetti (Pienissimo frontman), Vittorio, Giulia, Francesco.

## Context — how Pienissimo works today (as-is)

- **Business model:** marketing-first company, verticalized in restaurants/HoReCa. Giuliano Aranzetti is the frontman; the "Metodo Pienissimo" is delivered through courses (Cameriere Venditore as entry course, Mastery for marketing, Calendar, etc.), 80–90% held by Giuliano. Two core business areas: **course/ticket sales** and **Performance Plus** (the marketing agency arm).
- **Current stack (a triad):** WooCommerce (store: products, video courses, books, tickets, stage-sale deposits) → Zoho CRM ("ZOO" — orders) → Mexal (ERP, invoicing). A custom ticket-warehouse integration built by an internal developer talks to Zoho via API.
- **Ticket lifecycle:** order on Zoho (one order line per event code) loads the warehouse → ticket exists but is **not usable** until the invoice is fully paid → once paid it becomes available ("burnable") → sent to the customer ~60 days before the event (with a WhatsApp reminder funnel, since some buy in September for a March event) → paper ticket scanned via QR at course check-in → warehouse unloaded. Residual unused tickets stay in stock (e.g. bought 4, used 2).
- **Payments are hybrid** (~50/50 to 60/40): WooCommerce online payments AND direct bank transfers after a quote from the sales office. Stage sales at events: QR code → landing page → deposit (e.g. €5,000 of a €10,000 sale) via card or transfer; the remainder is handled later by the sales team.
- **CRM history:** Salesforce is their **4th CRM** (previous ones included Keap, then back to Zoho). They explicitly do NOT want to blindly replicate current processes — open to redesigning workflows ("feel free to propose different").

## Decisions

- **Salesforce replaces Zoho CRM.** Zoho contract expires **end of September 2026** — hard deadline.
- **Priority for the first go-live scope:** ticket warehouse + in-person attendance management (who came / who didn't). Those data are declared "fundamental" and must be usable as early as possible, before the Zoho expiry. Not everything needs to be live by September, but enough to start real use and testing.
- **Project method agreed:** (1) ROMI gives a general Salesforce demo (objects, dashboards, views) for both sales and marketing, ~30–60 min; (2) dedicated per-topic meetings (with the right key users each time); (3) ROMI produces a **blueprint document** which Pienissimo approves; (4) configuration proceeds partly in parallel; (5) review sessions with key users in test environments. Cadence: weekly/bi-weekly meetings.
- **Dashboard design principle agreed:** first define what to see in dashboards, then define which data must be captured to feed them.
- **Morris (external AI) discarded** as oversized for a 6-person sales team; the internal AI (curated by Sabatino) will be used instead, potentially consuming Salesforce data (e.g. call insights, Performance Plus projections — the "project" module was removed from the Salesforce purchase, projections will go through the internal AI cockpit).

## Action Items

| Task | Owner | Status |
|---|---|---|
| Email Elena the key-users list (business + technical) per topic area | Sabatino (Pienissimo) | Open |
| Schedule the Salesforce platform demo (sales + marketing) | Elena / ROMI | Open |
| Check + email Elena the 3CX status for the commercial area (setup completeness, recording capability) | Sabatino (Pienissimo) | Open |
| Internal feasibility check: what can realistically be delivered before end of September (ticket warehouse + attendance first) | Elena / ROMI | Open |
| Propose OTP/e-signature solution for privacy consent + contractual conditions (non-compete, non-disclosure), covering both owner and collaborators with personal emails | ROMI | Open |
| Complete Salesforce account verification (email received at the billing address) and share access link internally and with Elena + Andrea | Sabatino (Pienissimo) | Started live at end of call (Wi-Fi issue) — confirm done |

## Open Questions / Risks

- **Hard deadline risk:** Zoho contract expires end of September 2026; Food Marketing event is Sept 29 and the big kickoff event (1,500+ attendees) is Oct 29. Tour + Fornaie Team Festival start in September. If migration slips near the Zoho expiry, they can't manage attendees.
- **No-show analytics:** they want each customer tagged with acquisition source (tour / sponsored ads / etc.) and a no-show propensity per source, with dashboards showing room composition (e.g. "20% of this room came from tour → 70% no-show rate") to drive fill-the-room marketing actions. Data model to be designed.
- **3CX phone system:** owned, used by the support side (separate company) but NOT by the 6 salespeople, who use personal phones/SIMs and log calls badly. Goal: calls recorded through 3CX into the CRM, with the internal AI extracting coaching insights (sales techniques, areas of attention). Actual setup status is a "black hole" — Sabatino to verify.
- **Mexal limitation:** cannot create an order with multiple payment/invoice installments (wants a single invoice per order — unworkable for e.g. €20k yearly Performance Plus contracts billed monthly/quarterly). Options: build the payment schedule model in Salesforce (order + installment deadlines + "what to invoice this month" report, exportable/schedulable via email), and/or a small Mexal customization for a master order with installments (Sabatino wants to pursue this).
- **Performance Plus cross-department visibility:** sales, admin, and service-delivery don't see each other's status on a client (payments, renewals at contract expiry). Wanted: single real-time 360° client container. ROMI confirmed this is core Salesforce (360 view, Chatter-like collaboration, granular visibility rules).
- **Revenue forecast:** direction needs instant projection of invoicing from now to year-end for Performance Plus (target €4–5M) — today a manual Excel export job. Andrea Di Cicco's early idea: installments on the order + a report per month, exportable to Excel and schedulable by email. To be confirmed in analysis.
- **Dormant-client rules:** e.g. one saleswoman has 1,600 assigned clients and auto-captures every opportunity, including marketing-driven reawakenings. Wanted: a configurable dormancy rule (6/7/8 months without purchase → "dormant" tag) so sales direction can reassign. Salesforce assignment rules can do it — **Pienissimo must define the rules**.
- **E-signature legal constraints:** viewing alone is not legally sufficient; acceptance needs OTP or an explicit "accept" click tied to name/surname. Must also cover collaborators attending with the owner, who typically only have personal emails (HoReCa staff have no corporate email). Today: paper forms printed by the client, brought to the course, stored in a physical warehouse (retrieval nightmare in legal disputes). ROMI to propose a digital flow (possibly during purchase or ticket-send, or QR at check-in).

## Notes

- Purpose of this meeting: mutual introduction, clarify systems missing from the questionnaire (Mexal was written as "Metal"), and set the project method. Deep dives deferred to dedicated calls.
- Pienissimo can follow the project at a good pace right now (first course block just finished), and commits to full participation — this area is "vital" for them.
- Leads are mostly already qualified prospects (specific course requests) rather than cold leads.
- The current warehouse container has accumulated illogical quick fixes over time — a stated reason to redesign rather than replicate.
