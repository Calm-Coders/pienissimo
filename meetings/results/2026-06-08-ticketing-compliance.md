# [ROMI-PIENISSIMO] Focus Requirements: Ticketing & Compliance — 2026-06-08

**Sources:** [meetings/2026-06-08-ticketing-compliance-transcript.it.md](../2026-06-08-ticketing-compliance-transcript.it.md) (original Italian transcript, 70 min)

**Attendees:** Elena Spini, Andrea Di Cicco (ROMI); Sabatino Rinaldi, Fabrizio Paganelli (Pienissimo); Daniela Morgese joined ~40:56. Speaker labels heavily garbled (much "Sabatino" content is Fabrizio or Daniela); reconstructed from context.

Purpose: dedicated deep-dive on the ticket/Asset flow sketched at the June 3 demo — this closes the demo phase; technical analysis meetings start next.

## Decisions / Agreements

- **The three-stage ticket lifecycle takes shape** (this reconciles what later looked like a contradiction on 06/30):
  1. **Order placed** → ticket/warehouse movement is *loaded* (parked, not usable);
  2. **Invoice fully paid** → movement becomes *available* (today: automatic nightly procedure reads the Mexal payment schedule and updates Zoho availability — to be replicated in the Mexal integration);
  3. **Signed documents returned** (privacy, non-compete, etc., via DocuSign or similar) → **only then the QR code (= the usable ticket) is generated**;
  4. At the event: QR scanned → unload movement → per-client algebraic sum = 0; no-shows keep visible available tickets.
  The signature-gate (step 3) is ROMI's proposal — Pienissimo likes it ("the idea isn't bad") but reserves the direction's final OK (still pending on 06/16, confirmed before 06/30).
- **Participants ≠ contacts under the account.** The buyer (often owner or admin staff) buys N tickets; attendees rotate (waiter turnover), may be decided the day before, and may not exist in the CRM. Adopted pattern (Andrea's prior-project experience): after payment → email to the referent with a link → referent fills the **participant list** → contacts auto-created in Salesforce → signature request per participant → QR issued on signature. Reminder funnel for uncompiled tickets (they already run a WhatsApp/60-30-15-1-day funnel); **day-of-event fallback**: staff button sends the instant email / verifies identity (name/email/phone) and issues the QR on the spot — they already do something similar for free events via a dev-built link.
- **Campaign object = event.** Each event is a Campaign; campaign members = participants with check-in status (participated / no-show) → feeds room-composition and no-show analytics. Multi-event orders (one order with lines for Sept + Nov + Dec events) split naturally: one order line per event, each linked to its campaign; product codes stay cross-year (event year handled via campaign dates + competence year on ticket movements).
- **Timeline reality-check (heated):** **Zoho expires October 31** (correcting the kickoff's "end of September"); Food Marketing Festival = Sept 29; tour = Sept 7–19. Agreed reality: **dual-run until the end of October** — stage-sale invoicing stays on Zoho through Food Marketing, ticket data double-entered in both systems during the transition; the Mexal↔Salesforce integration must start well before September (Fabrizio alarmed about manual ticket-unblocking at Food Marketing scale: 100–150 invoices/day). Elena: dates are very tight; deliverable scope to be confirmed after the analysis meetings; target = as much as possible by Oct 31.
- **Storage checked live: 35.2 GB file storage** (not 5 TB as hoped). Signed PDFs + QR files will accumulate → plan a purge (e.g. batch deletes files 30 days post-event after client-side cloud backup). Where files live (per contact vs per campaign/event) to be decided in the final proposal.
- **Performance Plus contracts scoped for a dedicated session:** annual agency contracts (~€24k, 3–4 tranches), manual order by sales, renewable yearly; need a contracts panel (start/end/renewal dates, invoiced vs collected per contract) feeding the delivery team (block service on serious arrears). Base = standard Contract object + custom order/reminder logic.
- **Demo phase closed.** Next: Pienissimo consolidates internally this week; then analysis meetings (sales + marketing in parallel); Sabatino to send the lead/opportunity form links (still pending from 06/03).

## Action Items

| Task | Owner | Status |
|---|---|---|
| Direction's OK on the signature-gated QR proposal | Sabatino → Daniela | Done between 06/16 and 06/30 (flow "confirmed and validated" per 06/30 call) |
| Design Campaign-participant object + Files/QR placement + storage/cleanup plan | ROMI | Open — feeds the blueprint |
| Schedule sales + marketing analysis sessions; then Mexal integration + contracts/subscriptions sessions | Sabatino + Elena | Done (tech sales #1 held 06/16) |
| Send lead/opportunity form links | Sabatino | Open — reviewed live 06/16, full list pending |
| Send minutes | Sabatino | Done |

## Open Questions / Risks

- Free events skew incentives: forcing paperwork on free-ticket holders raises no-show risk ("what costs little returns little") — calibrate reminder pressure per event type.
- Ticket-availability check will be **manual** until the Mexal integration exists (bonifico payments especially — automation of bank transfers isn't feasible); at Food Marketing volumes this is painful, hence the pressure on integration timing.
- Buyer-side purchases keep arriving until the day before the event — the flow must accept last-minute orders, signatures and QR issuance at the door.

## Notes

- Today's scanning: internal phone app scans QR → tags contact "arrived" → warehouse unload. Staff verify signatures at the door.
- The current Zoho "magazzino biglietti" is a parallel archive with load/available/unload movements — the model Salesforce must reproduce (Asset/custom object + Campaign).
- Zoho remains active for Pienissimo Software SRL regardless (see 06/16).
