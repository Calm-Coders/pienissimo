# [ROMI-PIENISSIMO] Sales Types and Quotes — 2026-06-30

**Sources:** [meetings/2026-06-30-sales-types-quotes-transcript.it.md](../2026-06-30-sales-types-quotes-transcript.it.md) (original Italian transcript, 125 min)

**Attendees:** Elena Spini (ROMI), Andrea Di Cicco (ROMI), Sabatino Rinaldi, Fabrizio Paganelli, Marco Montesi, Elisa Migliano (Pienissimo — shared room, mid-call device swap). Note: speaker labels are heavily garbled — much of the content labeled "Marco" is actually Fabrizio or Elisa; reconstructed from context.

Basis of the call: the sales-typology Excel + PDF Pienissimo delivered (stage sales, tutor packages, tutor combo, tutor one-shot, Performance Plus, product sales, Pienissimo Pro), plus their lead/opty workflow document.

## Decisions

- **Lead vs Opportunity semantics aligned (the core outcome).** Pienissimo's current flow treats everything as an "opportunity" from first touch (Zoho is opportunity-centric; so was Keap). Agreed Salesforce mapping: the early stages of their workflow — *in lavorazione, non risponde, primo contatto, da ricontattare, prequalifica* — are **Lead**; an **Opportunity** starts when there's real buying intent, i.e. from the *appointment/demo* stage onward (Elena initially placed it at quote, moved it earlier because quotes sometimes emerge at appointments). Requests from **existing clients skip the lead stage** and become opportunities directly. **Elena rewrites their workflow Salesforce-oriented and re-presents it** — this is the origin of the flow review that was then postponed on 07/07.
- **Opportunity status mechanics agreed:** quote sent with 5-day validity → "scaduto" (expired) substatus is routine (real deals take longer, especially far from events); an expired quote can be **cloned** into a new one (keeps history of the failed attempt). *Chiuso-perso* is set manually by the tutor (opportunity follows automatically); *chiuso-vinto* is driven by **payment**, confirmed manually by administration in all sales types. Marco's note that some businesses close on contract *signature* rather than payment was parked as a possible future policy.
- **"Da ricontattare" becomes a task/alert** to the salesperson (48h parking rule), not just a status.
- **No more child orders per installment.** The inherited Zoho pattern (bundle order + N child "block" orders, one per due date, manually flipped to *chiuso acquisito* each month, exported as TXT to FTP, manually imported into Mexal) is abolished. Andrea's design direction: the order is ONE object; installments become dedicated payment-schedule records, kept in Salesforce so monthly-revenue reporting and unpaid-installment visibility (Mexal feedback flow) survive. ROMI presents concrete proposals at the invoicing meeting (July 02).
- **Orders become immutable once invoiced.** Tutors have historically edited already-invoiced orders. Rule: after invoicing, no edits — with a narrow permission set (1–2 admin users) for corrections. Also confirmed: a tutor package order is immutable once the client accepts.
- **Stage-sale manual steps stay for now** (admin manually completes WooCommerce orders paid by bank transfer), possible improvement later: order enters Salesforce regardless of payment state, with distinct statuses for card (auto-completed) vs transfer (pending).
- **Phase 2 (deadline end of October):** product sales via WooCommerce/GLS (books, video courses — orders must still flow in) and Pienissimo Pro (the software SRL products).
- **Data Cloud timing question raised** (Power BI vs Data Cloud for the data-cleanup work): Pienissimo can start ~mid-July if ROMI green-lights within 1–2 weeks; Elena to check feasibility and report what's missing. *(Answered on 07/07: import ~Sept 1, Data Cloud unusable before.)*
- Fabrizio revealed **Pienissimo already pays for Mexal API licenses** and has an API manual — he'll send it (this set up the July 02 file-vs-API analysis).

## Action Items

| Task | Owner | Status |
|---|---|---|
| Rewrite the lead/opty workflow Salesforce-oriented and re-present | Elena | Carried into #19 — committed "by July 7", postponed there to the following Thursday |
| Send quote template(s) + the actual emails sent to clients (different typologies) | Marco / Pienissimo | Open — needed for Salesforce quote templates and DocuSign anchor points |
| Send the Mexal API manual (licenses already paid) | Fabrizio | Done — delivered with the 8 CSVs, basis of the 07/02–07/07 analysis |
| Decide internally how to combine quote + contract conditions signing (two signatures in one DocuSign send vs sequential) and come back | Pienissimo (Marco/Fabrizio/Elisa) | Open |
| Verify whether current Salesforce licenses include a standard credit-note object (else design custom) | Andrea Di Cicco | Open — ~30 credit notes/year, some large; today Mexal-only with a Zoho workaround |
| Check Data Cloud feasibility/timing and report what's missing | Elena / ROMI | Resolved 07/07 — import ~Sept 1 |
| Bring order/installment (rateizzazione) proposals to the next meeting | ROMI | Done — presented across 07/02 and 07/07 |

## Open Questions / Risks

- **Ticket-generation trigger conflict (flagged by Elena, unresolved):** this call stated tickets/warehouse movements are generated at order time and become *available* on payment; an earlier meeting had agreed tickets are generated **only upon document signature**. The two flows must be reconciled — it changes the asset/warehouse design.
- **Account-creation policy for free tour tickets:** the September tour is ~90% new audience; per-stop WooCommerce forms create zero-value quotes + free tickets with client-typed (unreliable) data. Under Salesforce logic, a quote implies an account — so accounts must be created for everyone, and the Anticipay VAT lookup (today fired only at order time) would need to fire for all new accounts. When/how to create accounts to keep the registry clean is open.
- **Manual-signature fallback:** some clients can't handle digital signing; need a path (print/sign/return) alongside DocuSign.
- **Corner cases parked:** buying a ticket for a different company (never knowingly happened, blocked by policy + the self-declaration in the non-compete signature); attendee name changes are handled; photo/video consent tracking at events is admittedly weak and must improve; a referral program exists and may interact with these rules.
- **Quote templates:** whether one template or several (courses vs platform vs marketing services) — Elena will judge once she receives them; what varies may just be the email body.
- Terminology debt: "ordine/preventivo/opportunità" are used interchangeably internally ("the order IS the quote") — a recurring source of confusion; Salesforce naming (lead → opportunity → quote → order) is the agreed reference language going forward.

## Notes

- The Zoho→Mexal plumbing described in detail here (report by due date → manual status flip → TXT to FTP → manual Mexal import → nightly return flow at ~3:00) is acknowledged by Pienissimo as an inherited "accrocchio" nobody can explain the origin of.
- Business rule behind installment dates: the client must always have paid the courses **before** attending; tutors' "freedom" in payment schedules is bounded by that (tickets aren't released otherwise).
- Tutor pricing: fixed price list, no discretionary discounts unless authorized; package content varies with the academic calendar (Sept–May), not per-client whim.
- Next meeting set for Thursday July 02 (Mexal/invoicing — happened as planned). Andrea Di Cicco on vacation July 4–10.
