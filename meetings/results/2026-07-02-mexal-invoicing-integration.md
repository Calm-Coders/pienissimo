# [ROMI-PIENISSIMO] Mexal Integration (Invoicing) — 2026-07-02

**Sources:** [meetings/2026-07-02-mexal-invoicing-integration-transcript.it.md](../2026-07-02-mexal-invoicing-integration-transcript.it.md) (original Italian transcript, 104 min)

**Attendees:** Elena Spini (ROMI), Andrea Di Cicco (ROMI), Sabatino Rinaldi, Fabrizio Paganelli, Marco (Pienissimo — several people sharing one room/camera, with recurring connection drops). Note: speaker labels are heavily garbled — most content labeled "Marco" is clearly Fabrizio (Mexal/admin process detail), and some "Sabatino" segments are Fabrizio too; reconstructed from context.

> **Cross-meeting update:** the provisional decision here to keep the CSV/FTP file integration with Mexal was **reversed on 2026-07-07** (see [2026-07-07 result](2026-07-07-lead-opty-flow-integrations.md)): once ROMI analyzed the delivered API docs, REST API was chosen.

## Decisions

- **Mexal integration (provisional, later superseded):** keep the existing CSV/FTP exchange to save analysis time given the tight schedule, and revisit API later. Andrea couldn't estimate the API route without documentation. Pienissimo committed to send **the 8 CSV files + the Mexal API manual** the next day — which is what enabled the July 07 reversal to REST API.
- **Mexal CAN invoice a single order in multiple tranches.** Confirmed with Passepartout: if every order line carries a due date (scadenza), Mexal's deferred invoicing can filter lines by date range and invoice them progressively. The old "one order = one invoice" rule was an internal policy (from a previous admin manager), not a technical limit. All installment lines can be sent to Mexal at once; Mexal sends back invoices/payments as they happen. → This kills the old child-order workaround.
- **Order model going forward:** one master order + installment lines (rate) with due dates — no more spawning child orders per installment (today Zoho creates a bundle order + N child orders, first child "closed/acquired" for the deposit, the rest "created").
- **"BLO" block codes are retired.** Current bundles are built around parent block article codes (BLO…) and zero-price "omaggio" product codes; direction no longer wants either. New packages must contain **only real product codes with real prices and discounts** (a freebie becomes a real code discounted 100%, so the client sees value given, not "€0"). The BLO codes will not be migrated to Salesforce.
- **Bundle mechanics confirmed:** packages are configured per event (3–5 per event), identical for every buyer, never modified after sale, and never reused after the event (~102 packages and 350+ block codes accumulated historically — activate/deactivate handles this in Salesforce). Bundles ≈ 40–45% of revenue. Same logic will serve time-limited sales campaigns (tutor combo).
- **WooCommerce integration will be API-based** (not the marketplace plugin — bad experience with the Zoho plugin). Sabatino's team controls WooCommerce internally and can provide API keys/webhooks/anything; Andrea will check if Salesforce standard APIs can receive the orders (near-zero cost on ROMI side). Discovery: there are **two WooCommerce instances** (one for books/marketing products, one for events/stage sales). Dedup on incoming orders must match by **email + VAT number**. The Zoho "2-for-1 promo" bug (quantity/total mismatch) is handled in Salesforce via discount lines (qty 2 at 50%).
- **Next meeting (Tuesday July 07):** integration follow-up + ROMI's redesigned Lead/Opportunity flow (Elena committed to deliver by July 7) + start of the **data model** work (Excel per Salesforce object; Pienissimo extracts field lists from Zoho and prunes unused fields). Daniela to be invited — Pienissimo stressed they have NOT pre-accepted ROMI's flow; direction has the final word. Blueprint timeline: clear scope next week, document written the week after, then sign-off and build.

## Action Items

| Task | Owner | Status |
|---|---|---|
| Send the 8 Mexal CSV files + Mexal API documentation to Elena + Andrea (zipped folder) | Fabrizio / Sabatino | Done by 2026-07-07 (ROMI analyzed the API docs in that call) |
| Verify whether current Salesforce licenses support bundles/CPQ; report back | Andrea Di Cicco | Superseded → became the custom-vs-Revenue-Cloud analysis of 2026-07-07 |
| Send Anticipay (ex CreditSafe) documentation + reference to the June 3 demo recording | Sabatino | Open |
| Send WooCommerce API keys (CK/CS) ahead of the WooCommerce call | Sabatino | Open |
| Request DocuSign license quote | Sabatino | Done by 2026-07-07 (trial active, sales rep contacted) |
| Send remaining document templates (platform modules, marketing service) — due July 7 | Elisa | Open — verify received |
| Draft the fully digital participation form and share with Elena/Andrea | Sabatino | Open |
| Deliver redesigned Lead/Opty flow proposal (due July 7) | Elena | Carried over — postponed at the 07-07 call, moved to Thursday |
| Prepare the data model Excel (per Salesforce object) for the Tuesday call; Pienissimo then fills field lists from Zoho extraction | Elena / ROMI, then Pienissimo | Open |
| Invite Daniela to the Tuesday call | Sabatino | Done (she joined on 07-07) |

## Open Questions / Risks

- **Anticipay (ex CreditSafe) VAT verification:** fires on every new VAT number entering the CRM, alerts in-CRM when a VAT is invalid or unregistered; recovers legal-representative data (needed for the contracts/e-signature flow). Pienissimo calls it vital — ~70% of clients mistype their VAT on WooCommerce, and a wrong VAT blocks the Mexal order import. Elena proposed deferring it to phase 2; Pienissimo insists it must ship **together with the Mexal integration** (data reaching Mexal must already be clean). ROMI to answer at the next call. Open sub-question: does Anticipay handle foreign VAT numbers, or must the check skip non-Italian accounts? (probably Italian-only — verify with Andrea Parmigiani/dev).
- **Dual-run risk:** while Zoho and Salesforce run in parallel, the nightly overwritten FTP files can lose or clobber data — synchronization needs explicit design (raised by Andrea; relevant even under the API route for the transition window).
- **The two-WooCommerce setup** needs mapping: which flows come from which instance, and whether both integrate at go-live.
- **Package/bundle license check** was the trigger of the escalation seen on 2026-07-07 — at this call it was still an open "let me verify" from Andrea.
- Invoice/quote print detail: quotes always include the general conditions (identical for all courses/events) + the economic summary in one document; participation sheet (sent with the ticket) includes entry policy + privacy/photo consent and will be redesigned once the digital flow lands.

## Notes

- FTP mechanics today: orders in "closed/acquired" state are dropped to the FTP folder; Fabrizio manually triggers Mexal import; nightly batch (~3:30) writes accounting data (invoices, payments, client/agent/product registries) back to the same folder where the CRM picks them up. Files are fixed-name and overwritten nightly; the orders file is moved to another folder after import.
- Zoho had a CPQ module; Pienissimo never used it — packages are configured in Mexal today.
- Fabrizio's stated worry: tight timeline; reusing the existing file exchange felt safer. Andrea's counterpoint: API is simpler long-term but needs Mexal-side involvement; the compromise ("send me the files AND the API docs, I'll analyze") is what produced the July 07 decision.
- Elena's remark on scope: "you keep adding things — packages, Anticipay…" — scope-creep tension is visible; she'll answer on Anticipay timing after internal re-planning.
