# [ROMI-PIENISSIMO] Lead/Opty Flow + Integration Logic — 2026-07-07

**Sources:** [meetings/2026-07-07-lead-opty-flow-integrations-transcript.it.md](../2026-07-07-lead-opty-flow-integrations-transcript.it.md) (original Italian transcript, 148 min)

**Attendees:** Elena Spini (ROMI), Andrea Di Cicco (ROMI), Aurel Mrruku (ROMI), Sabatino Rinaldi (Pienissimo), Fabrizio Paganelli (Pienissimo), Elisa Migliano (Pienissimo), Daniela Morgese (Pienissimo — joined ~1:44). Absent: Marco Montesi (Pienissimo sales manager — his input needed on several points). Note: the auto-transcript's speaker labels are unreliable in the second half (several of Aurel's technical explanations are attributed to others); content below is reconstructed from context.

## Decisions

- **Mexal integration will be REST API, not file exchange.** The CSV/file route ballooned to 8 files, would require Data Cloud workarounds, raise costs, and isn't Salesforce best practice; the contract also specifies API. Fabrizio approved. ROMI has already drafted an API mapping from the Passepartout docs. The one missing API (agents/sales reps) is acceptable: on each new hire the agent is created manually in Mexal and its code copied into Salesforce.
- **Bundle handling: custom solution over Revenue Cloud (CPQ), pending a visual demo.** Revenue Cloud licenses were never in the purchased package. After Aurel demoed a customized bundle from a past project (bundle as container record, fixed bundle price, component products carrying a *spread/discounted price* so product-level statistics still work), Pienissimo agreed the custom route looks adequate — Revenue Cloud is oversized for their case (no dynamic pricing rules; bundle price is fixed at configuration). Final sign-off only after ROMI shows their own custom bundle build in the test environment (within next week, not Thursday).
- **Key bundle facts settled:** an order never contains more than one bundle; a tutor never sells a bundle + extra single product in the same order (two separate quotes/orders instead) — this resolved the main design problem. Bundle price is fixed (manual extra discount allowed); product price lists with per-client discount logic apply only to single products.
- **Statistics is the overriding requirement:** revenue per individual product must remain measurable even when sold inside a bundle → components get a spread price internally. Invoice/order display (show components vs. show installments, hide internal component prices from clients) stays a Pienissimo business decision to make later — the platform supports either.
- **DocuSign confirmed as the e-signature tool.** Sabatino activated a 30-day trial and has already emailed DocuSign's (Italian) sales team; he'll negotiate per-signature pricing (~€2–3/doc) using annual event-participant volumes, then buy. Integration via the AppExchange package; Salesforce user emails must match DocuSign users; a single sending user (the funnel-owner mailbox, e.g. marketing@) suffices since sends are automated N days before the event.
- **Data Cloud (Zoho Analytics replacement) postponed:** unusable until data lives in the platform — import targeted for ~September 1, preceded by data cleanup (~6,000 leads/accounts with many duplicates vs ~7,500 paying clients). Until then Fabrizio + Elisa do analytics with other tools.
- **Lead/Opportunity flow review postponed.** Elena's connection dropped and the call ran long. The redesigned sales workflow (ROMI's proposal based on Pienissimo's flow, adapted to Salesforce logic) moves to Thursday's call; Elena will record and cut the sales-flow segment for Daniela; Sabatino acts as spokesperson and will reply same day.
- **Terminology aligned:** what Zoho called an "order" pre-acceptance is a **quote (preventivo)** in Salesforce; it becomes an Order when accepted/paid.

## Action Items

| Task | Owner | Status |
|---|---|---|
| Call Creosoft/Passepartout (tech contact: Mirko) to announce the new API integration and connect him directly with ROMI | Fabrizio | Open |
| Verify with Mexal/Passepartout whether the documented API calls cover outbound (CRM→Mexal) too — request collection/webhook examples; only orders (+ new accounts) go CRM→Mexal | ROMI (Andrea Di Cicco) | Open |
| Technical effort estimate for the custom bundle solution + internal pass with Galotto | ROMI (Andrea Di Cicco) | Open |
| Show custom bundle solution working in test environment | ROMI | Open — within next week (not Thursday) |
| Optionally involve Salesforce directly to present Revenue Cloud pros/cons | ROMI (Elena + Andrea) | Open |
| Unblock marketing: forms + subdomain answers pending since the June 23 marketing meeting — push Matteo | Sabatino | Open — marketing work is blocked on this |
| Close DocuSign purchase: negotiate with sales rep (3 signed-doc types: order/contract, event T&C acceptance, RID mandate; + quote template), then notify ROMI | Sabatino | Open — email sent, awaiting reply |
| Data cleanup (dedupe leads/accounts) ahead of ~Sept 1 import; interim analytics via other tools | Fabrizio + Elisa | Open |
| Record Thursday's call, cut the sales-flow segment, send to Daniela | Elena | Open |
| Review the cut sales-flow video and respond same afternoon | Sabatino (+ Daniela) | Open |
| Decide invoice display policy (component lines vs installment lines; hide component prices) | Daniela / Fabrizio (with Marco) | Open — platform supports either |

## Open Questions / Risks

- **Bundle license gap escalation:** Fabrizio and Daniela are unhappy that bundles (>50% of company revenue) surfaced only now, after 7–9 meetings, and weren't scoped in the license offer. ROMI's position: the real meaning of "bundle" only became concrete last week with the Excel file. Risk parked pending the custom-solution demo — if the demo disappoints, the license question (and cost attribution) reopens.
- **Mexal client code on new clients:** the RID mandate requires the Mexal client code, which the ERP assigns only after the first order. Flow design needed: account starts as *prospect* in Salesforce, order pushes account+order to ERP, account becomes *customer*, only then the RID/contract flows can fire. Elena and Aurel disagreed on whether every account eventually becomes a customer — to be settled in the data-model discussion.
- **RID (direct debit) flow — ~50% of payments:** currently sent via ZohoSign; must be rebuilt as a dynamic DocuSign template (mandatory client-filled bank fields, pre-filled company data). Banks have accepted digital signatures so far. Signed doc to be attached to the account/contact in Salesforce.
- **Document templates — 4 identified so far:** (1) order/contract incl. general conditions (sent only for big packages: Performance Plus, "year with Pienissimo" ~€10k+; never for small orders), (2) event participation T&C acceptance (privacy, non-compete, NDA — signed by each participant ~3 days before event), (3) RID mandate, (4) quote print (subset of the order doc). All need design line-by-line with ROMI; current documents are not normalized (layout inconsistencies).
- **PDF generation constraints:** front-end (button-triggered) PDF generation is fully stylable; server-side (scheduled, e.g. 3–5 days pre-event) generation is limited by the PDF library. Proposed pattern: generate the PDF via user action/status flag, then send that stored PDF through DocuSign automatically before the event.
- **File storage cost:** Salesforce storage is expensive (~10 GB threshold); Pienissimo has "lots" of documents (unquantified). Consider storing PDFs on SharePoint/Drive with links on the record. Volume estimate needed.
- **Performance Plus order model:** single annual order (e.g. €20k) split into one order line per installment (12× €1,700 monthly, same product code; quarterly uses a different code). Contract sent manually via button when the client confirms intent (clients want to see the contract before paying; "vinto" status only on payment receipt; interim status "accepted — accounting copy received" exists because clients often just wire money without formal acceptance). ~100 contracts/year, expected to grow with renewals.
- **Quote lifecycle:** tutors can edit a quote unlimited times before it becomes an order; no hard acceptance gate. Statuses and flags to be modeled in the Salesforce flow (ties into the postponed lead/opty flow discussion).
- **Missing interim meetings in the tracker:** this call references a June 23 marketing meeting (forms/subdomain minutes) and 7–9 total meetings held so far — those transcripts haven't been processed here, so the tracker has a gap between 2026-05-27 and 2026-07-07.

## Notes

- Aurel demoed a real customized-bundle implementation from a previous project (bundle container with component products, some zero-priced, discount rules by quantity/client/value) — this was the turning point that reassured Pienissimo about the custom route.
- Fabrizio's guiding principle, restated: no "accrocchi" (hacks) — prefer native growth; but the team accepted that a well-built custom object layer is not a hack, it's mostly a display-layer concern.
- Daniela's closing reminder: every design decision must keep the final statistics/dashboards in mind — "the goal isn't just doing, it's the final dashboards."
- Elena will bring an additional schema proposal for Performance Plus-type renewable orders ("keeping it for Thursday") — she wants to name them distinctly from bundles.
