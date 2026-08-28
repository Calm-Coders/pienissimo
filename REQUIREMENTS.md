# Requirements Document — Pienissimo Salesforce Project

**Client:** Pienissimo · **Supplier:** ROMI S.r.l. · **Project:** Zoho CRM → Salesforce migration
**Version:** 1.4 — draft for approval · **Date:** 24 August 2026

> **What changed in 1.4.** The target ticket object is now decided: use the standard Salesforce Asset object. The direct instruction did not identify the decision-maker. The custom `Biglietto__c` implementation in UAT must be replaced or migrated; the effort is not yet estimated. Version 1.3 recorded Aurel Mrruku's Quote-side tranche decision.
>
> **What changed since 1.0.** The two draw.io design files have been read and merged in — `Flows & Objects.drawio` by Elena Spini and `Workflow Pienissimo 23-7-26.drawio` annotated by Marco Montesi — both re-decoded in full on **20 August 2026**, at which point each had been modified that same afternoon — 15:36 UTC and 14:28 UTC respectively (this document previously said 6 August and 4 August). ⚠ **Neither of those edits is minuted, so nothing below was changed on the strength of them**; the three points where the drawings have now moved ahead of this text are listed in §17. They produce the new **§16** (state machines, picklist values, 17 requirements that existed only in the drawings) and **§17**, which lists the points where the sources disagree. Two of those corrections are our own errors: the order-typology list in DM-15 was invented, and one item we had presented as a contradiction — the reminder cadence — was not one. Both are described in §17.
> **Sign-off session:** Thursday 6 August 2026, 15:00–17:00 — "Chiusura ultimi punti aperti"

> English mirror of `REQUISITI.it.md`. The **Italian version is the one presented to and signed by the client**; this copy exists for the ROMI team. If the two ever diverge, the Italian text prevails.

---

## 0. How to read and approve this document

This document gathers **every requirement agreed** across the analysis meetings held between 27 May and 31 July 2026 and states them in a single, numbered, verifiable form. Once signed, it **freezes the project scope**.

Every requirement carries a stable identifier (e.g. `SAL-04`), a priority and a status.

| Status | Meaning                                                                                              |
| :----: | ---------------------------------------------------------------------------------------------------- |
|   ✅   | **Agreed** in a meeting. On signature it becomes binding and cannot change without a change request. |
|   🟡   | **To confirm** in this session. Proposed by ROMI or discussed but not closed.                        |
|   🔴   | **Open**: a decision or a client input is missing. All listed in §12.                                |

| Priority | Meaning                                                  |
| :------: | -------------------------------------------------------- |
|  **M**   | _Must_ — indispensable for the 6 October 2026 go-live.   |
|  **S**   | _Should_ — important, but go-live can happen without it. |
|  **C**   | _Could_ — desirable, delivered if time allows.           |
|  **F2**  | Explicitly deferred to **Phase 2**, after go-live.       |

> **Rule of engagement.** From signature onward, any new requirement or substantive change to a ✅ requirement follows the change procedure in §14: impact assessment on time and cost, and written approval before work starts. ROMI stated this verbally on 31 July 2026; it is formalised here.

---

## 1. Context and objectives

| ID     | Requirement                                                                                                                                                         | Pri. | Status |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :----: |
| CTX-01 | Replace Zoho CRM with Salesforce as Pienissimo's single operational CRM.                                                                                            |  M   |   ✅   |
| CTX-02 | **Go-live date: 6 October 2026**, focused on the WooCommerce and Mexal integrations. Minor integrations move to Phase 2.                                            |  M   |   ✅   |
| CTX-03 | The Zoho contract expires **31 October 2026**. The parallel-running window is therefore roughly three weeks and cannot be extended.                                 |  M   |   ✅   |
| CTX-04 | During dual-run, tickets are entered twice (Zoho + Salesforce) and stage-sale invoicing stays on Zoho through the Food Marketing Festival on 29 September.          |  M   |   ✅   |
| CTX-05 | Guiding principle: **no workarounds**. Processes are redesigned for Salesforce, not replicated from Zoho. Start simple and manual; automate what proves repetitive. |  M   |   ✅   |
| CTX-06 | Every design decision must serve the **final statistics and reporting**: if a figure cannot be traced or aggregated, the solution is reworked.                      |  M   |   ✅   |
| CTX-07 | Org language: **Italian**, with custom labels translated through the Translation Workbench.                                                                         |  M   |   ✅   |
| CTX-08 | Reference terminology is Salesforce's: Lead → Opportunity → Quote → Order. Zoho's pre-acceptance "ordine" maps to the Salesforce **Quote**.                         |  M   |   ✅   |

### 1.1 Fixed calendar

| Date                | Event                                       | Project impact                                                           |
| ------------------- | ------------------------------------------- | ------------------------------------------------------------------------ |
| ~1 September 2026   | Data import into Salesforce                 | Preceded by cleanup: ~6,000 leads/accounts against ~7,500 paying clients |
| 7–19 September 2026 | Tour (free events)                          | ~90% new audience, client-typed data                                     |
| 29 September 2026   | Food Marketing Festival                     | Peaks of 100–150 invoices per day                                        |
| **6 October 2026**  | **Go-live**                                 | WooCommerce + Mexal operational                                          |
| 29 October 2026     | Launch event, 1,500+ attendees              | First full-scale event on Salesforce                                     |
| 31 October 2026     | Zoho contract expiry                        | End of dual-run                                                          |
| 3 November 2026 🔴  | Camerieri Venditori — or postponed to April | Date to confirm                                                          |
| 24–26 November 2026 | Pienissimo Live                             | Ticket delivery 60 days ahead in the as-is 🔴                            |

---

## 2. Scope

### 2.1 In contractual scope

Everything described in §3–§11 with priority **M**, **S** or **C**.

### 2.2 Out of contractual scope

| ID     | Item                                                                                                    | Rationale                                                                                          | Status |
| ------ | ------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- | :----: |
| OUT-01 | **GLS** integration (delivery confirmation for the book flow)                                           | Not discussed pre-sale, not in the contract                                                        |   🔴   |
| OUT-02 | **Teachable** integration (course-completion API)                                                       | Not discussed pre-sale, not in the contract                                                        |   🔴   |
| OUT-03 | **Salesforce ↔ Zoho** integration for Pienissimo Pro orders belonging to **Pienissimo Software S.r.l.** | A legally distinct company from this project's client; not discussed pre-sale, not in the contract |   🔴   |

> ⚠ **To be settled in this session.** ROMI flagged these three as out of contract in three consecutive weekly statuses (10, 24 and 31 July). Pienissimo (Sabatino, Fabrizio) maintains that at least the Zoho item was discussed, and escalated to Daniela. **Until this closes, these three cannot be planned and do not count toward the 6 October date.** ROMI has committed to a separate quotation should they re-enter scope as an evolutiva.

### 2.3 Deferred to Phase 2 (post go-live, in scope)

| ID    | Item                                                                            |
| ----- | ------------------------------------------------------------------------------- |
| F2-01 | Product sales via WooCommerce/GLS (books, video courses) — full e-commerce flow |
| F2-02 | Pienissimo Pro flows                                                            |
| F2-03 | Data Cloud / Data 360 analytics                                                 |
| F2-04 | Remaining automation and minor integrations                                     |
| F2-05 | Meta/Google Ads integration for acquisition cost and origin campaign            |

---

## 3. Data model

| ID    | Requirement                                                                                                                                                                                                                                                                                                                                                                                                                      | Pri. | Status |
| ----- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :----: |
| DM-01 | **Lead** — holds only self-serve actions with no purchase intent (live-stream signup, free video download, quiz). Early workflow states live here. Owned by marketing.                                                                                                                                                                                                                                                           |  M   |   ✅   |
| DM-02 | **Account** = company, with a dedicated **local name** field alongside the registered name.                                                                                                                                                                                                                                                                                                                                      |  M   |   ✅   |
| DM-03 | Every Opportunity requires an Account. Forms auto-create "primordial" accounts and contacts; sales completes the registry after first contact.                                                                                                                                                                                                                                                                                   |  M   |   ✅   |
| DM-04 | Duplicate rules: **email OR phone** for forms; **email + VAT** for WooCommerce orders; VAT/company matching on lead → account conversion.                                                                                                                                                                                                                                                                                        |  M   |   ✅   |
| DM-05 | **Opportunity** — created directly, skipping the Lead, for explicit contact-request forms (sponsored landings, live QR codes) and for all requests from existing clients.                                                                                                                                                                                                                                                        |  M   |   ✅   |
| DM-06 | Four Opportunity stages (negotiation with sub-levels → postponed / lost / won). _Closed won_ is driven by **payment**, confirmed manually by administration.                                                                                                                                                                                                                                                                     |  M   |   ✅   |
| DM-07 | **Mandatory** loss reason, with **two distinct picklist sets**: one for Opportunity stages, one for Quote stages. The value "errato" must not exist for quotes.                                                                                                                                                                                                                                                                  |  M   |   ✅   |
| DM-08 | Separate **Record Types** for the commercial and e-commerce flows, to keep statistics clean.                                                                                                                                                                                                                                                                                                                                     |  M   |   ✅   |
| DM-09 | Track **existing-client vs new-business** origin on every Opportunity.                                                                                                                                                                                                                                                                                                                                                           |  M   |   ✅   |
| DM-10 | **Quote** — always under an Opportunity; multiple quotes per Opportunity allowed. Five-day validity; "expired" is a routine state. Retry is by **cloning** the expired quote, preserving history.                                                                                                                                                                                                                                |  M   |   ✅   |
| DM-11 | The Quote is a single PDF carrying general conditions and the economic summary.                                                                                                                                                                                                                                                                                                                                                  |  M   |   ✅   |
| DM-12 | **Order** — one order object. Product lines inherit their Quote-side tranche reference and payment due date. Zoho's child-order / "blocchi" pattern is abolished.                                                                                                                                                                                                                                                                |  M   |   ✅   |
| DM-13 | At most **one bundle per order**; never bundle plus loose product in the same order (two separate orders instead).                                                                                                                                                                                                                                                                                                               |  M   |   ✅   |
| DM-14 | The order is **immutable once invoiced**, with a narrow permission set (1–2 admin users) for corrections.                                                                                                                                                                                                                                                                                                                        |  M   |   ✅   |
| DM-15 | Two distinct fields, not one. **Order type** = `STANDARD` · `BUNDLE` · `PLUS`, the three design values that drive automation. **Sales typology** = the seven entries from the client's own Excel: stage sales, tutor packages, tutor combo, tutor one-shot, Performance Plus, product sales, Pienissimo Pro. ⚠ The six-value list in v1.0 of this document was our error: it appears in no source and is withdrawn (§17, RC-04). |  M   |   🟡   |
| DM-16 | Orders and products originating in Mexal are **read-only** in Salesforce.                                                                                                                                                                                                                                                                                                                                                        |  M   |   ✅   |
| DM-17 | **Tranche** (renaming of "rate") — custom object created on the **Quote**, after products are selected, through a guided action that asks which Quote Line Items to include and the planned payment due date. Each selected line stores the tranche reference and date; both propagate to the corresponding Order Item.                                                                                                          |  M   |   ✅   |
| DM-18 | **Campaign = event**: one campaign per edition. Campaign members are participants with check-in status (attended / no-show), feeding no-show and room-composition analytics.                                                                                                                                                                                                                                                     |  M   |   ✅   |
| DM-19 | **Contract** (Performance Plus) — standard Contract object with custom logic: start/end/renewal dates, amount, linked quote and invoices, renewals panel, invoiced vs collected, service block on serious arrears.                                                                                                                                                                                                               |  S   |   ✅   |
| DM-20 | **Credit note** — linked to both the order and the **order line**, to handle partial reversals on multi-event bundles.                                                                                                                                                                                                                                                                                                           |  S   |   ✅   |
| DM-21 | **Invoice** — created in Salesforce as a reference shell when the order closes; Mexal invoices and returns number and status into dedicated, searchable fields.                                                                                                                                                                                                                                                                  |  M   |   ✅   |
| DM-22 | **Ticket** — one standard Salesforce **Asset** record per ticket, with the lifecycle in §6. The custom `Biglietto__c` object currently delivered in UAT must be replaced or migrated to Asset without losing its fields, relationships or required automation.                                                                                                                                                                   |  M   |   ✅   |

---

## 4. Sales flow — lead to order

| ID     | Requirement                                                                                                                                                                                                           | Pri. | Status |
| ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :----: |
| SAL-01 | Form routing is decided by **source, not content**: pre-filled hidden fields (source, category, sub-category, UTM) discriminate. Source A → Lead; source B → Opportunity with automatic account and contact creation. |  M   |   ✅   |
| SAL-02 | Forms change roughly every 15 days: a repeatable field-mapping process is needed, self-manageable by Pienissimo. New fields must pre-exist in Salesforce.                                                             |  M   |   ✅   |
| SAL-03 | Multi-service interest must land on the Opportunity readable and **reportable**, with every value individually countable.                                                                                             |  M   |   ✅   |
| SAL-04 | Marketing converts Leads into Opportunities; tutors handle recalls through automatic tasks and dedicated states. Qualified contacts bypass the early stages.                                                          |  M   |   ✅   |
| SAL-05 | **SLA**: a new Opportunity must move to "in lavorazione" within **48 working hours**, otherwise escalation to the sales manager.                                                                                      |  M   |   ✅   |
| SAL-06 | A **"qualificato da ricontattare"** state with a 48-hour parking task/alert.                                                                                                                                          |  M   |   ✅   |
| SAL-07 | A **manual quote-creation button**.                                                                                                                                                                                   |  M   |   ✅   |
| SAL-08 | The **quote expiry date is mandatory** when the tutor sends it.                                                                                                                                                       |  M   |   ✅   |
| SAL-09 | Automatic alerts to tutor and client on the **second day** after sending and on the **expiry date**.                                                                                                                  |  M   |   ✅   |
| SAL-10 | List of preset validity times per product category and business line. 🔴 _Input owed by Marco Montesi._                                                                                                               |  M   |   🔴   |
| SAL-11 | Stage transitions are **manual at go-live**; automation assessed later.                                                                                                                                               |  M   |   ✅   |
| SAL-12 | Tutors work on a **fixed price list**, with no discretionary discounts unless authorised.                                                                                                                             |  M   |   ✅   |
| SAL-13 | Instalment dates must always leave the client **fully paid before attending** the event.                                                                                                                              |  M   |   ✅   |
| SAL-14 | Daily-activity dashboard per tutor plus a cross-tutor manager dashboard. Dashboards default to the current user.                                                                                                      |  M   |   ✅   |
| SAL-15 | Notification channel (Salesforce bell vs email). 🔴 _Pienissimo decision._                                                                                                                                            |  S   |   🔴   |
| SAL-16 | **Accept/reject buttons inside the quote email** updating Quote/Opportunity status directly. 🟡 _ROMI to assess feasibility and the risk of external parties mutating CRM data._                                      |  C   |   🟡   |
| SAL-17 | Order-acceptance and contract-handling procedure. 🔴 _To be defined with Daniela and communicated to ROMI by 6 August._                                                                                               |  M   |   🔴   |

---

## 5. Bundles and product master

| ID     | Requirement                                                                                                                                                                                                                                                                                       | Pri. | Status |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :----: |
| BUN-01 | The bundle is a **custom container**, not Revenue Cloud/CPQ (unlicensed and oversized).                                                                                                                                                                                                           |  M   |   ✅   |
| BUN-02 | The bundle has a **fixed price** set at configuration; components carry **spread prices** so per-product revenue statistics remain valid. **This is the acceptance criterion for the bundle solution.**                                                                                           |  M   |   ✅   |
| BUN-03 | The spread lives on the **bundle↔product link** (`BundleComponent__c` junction), not on the product: the same product can therefore belong to several bundles at a different spread in each.                                                                                                      |  M   |   ✅   |
| BUN-04 | **Both** modes are available: fixed bundle price, or automatic calculation from components. The choice is per bundle. With a fixed price, instalments are set manually.                                                                                                                           |  M   |   ✅   |
| BUN-05 | Invoicing is per **elementary product** composing the bundle, never a lump sum. The bundle name becomes the description passed to Mexal; code and due date stay at line level.                                                                                                                    |  M   |   ✅   |
| BUN-06 | Bundles are **created by administration only** in Salesforce; individual products stay configured in Mexal.                                                                                                                                                                                       |  M   |   ✅   |
| BUN-07 | A bundle is never modified after sale nor reused: it is activated and deactivated. Three to five bundles per event, identical for all buyers.                                                                                                                                                     |  M   |   ✅   |
| BUN-08 | Classification: **anno solare** (master) → **evento** (dependent picklist) + **bundle typology** (independent). ⚠ "Anno solare" is distinct from "anno accademico" (May→September), which drives ticket generation.                                                                               |  M   |   ✅   |
| BUN-09 | Picklist values are **rebuilt clean**, not migrated from the legacy LIVELLO_3/4 columns. Event seed: Tour, Food Marketing Festival, Pienissimo Live, Academy, Sold Out, O.D.B. Live, Camerieri Venditori, Mastery. 🔴 _Definitive list owed by Fabrizio._                                         |  M   |   🔴   |
| BUN-10 | UI: the bundle appears as **one order line**, expandable to show components.                                                                                                                                                                                                                      |  M   |   ✅   |
| BUN-11 | The article master is imported from Mexal. The legacy **C/Z/BLO/PACK apparatus is not migrated**: it existed only to build instalment bundles in Mexal.                                                                                                                                           |  M   |   ✅   |
| BUN-12 | A **"Genera biglietto" (yes/no)** flag on the article: defines the set of codes that generate a ticket, admin-editable with no development.                                                                                                                                                       |  M   |   ✅   |
| BUN-13 | A **"Solo bundle" (yes/no)** flag on the article: marks codes usable only inside bundles, not selectable by tutors in direct sales (no agent commission on bundles).                                                                                                                              |  M   |   ✅   |
| BUN-14 | Article codes are **unique and stable** over time.                                                                                                                                                                                                                                                |  M   |   ✅   |
| BUN-15 | Roughly **10 new bundle-only article codes**, one per event, on the "(B)" convention. 🔴 _3–5 samples owed by Fabrizio before September._                                                                                                                                                         |  M   |   🔴   |
| BUN-16 | €0 "omaggio" codes and BLO blocks are **abolished**: real product codes at 100% discount are used instead. ⚠ To be highlighted at invoicing.                                                                                                                                                      |  M   |   ✅   |
| BUN-17 | A **non-zero spread variance must block saving** the bundle. 🟡 _Today the variance is only displayed. The case has already occurred in UAT: the ACADEMY 2026 bundle carries a variance of −1,422, with correspondingly wrong per-product statistics. ROMI recommends making the check blocking._ |  M   |   🟡   |
| BUN-18 | Coherence control on bundle composition: prevent attaching articles inconsistent with the bundle's category. 🟡 _Today mitigated only by administration's manual attention._                                                                                                                      |  S   |   🟡   |
| BUN-19 | The bundle code is passed to WooCommerce **manually and verbally**, by design, to keep flexibility close to events. 🟡 _To confirm as sustainable at go-live volumes._                                                                                                                            |  S   |   🟡   |
| BUN-20 | **Real catalogue prices** for every listed code. 🔴 _The prices and spreads currently in UAT are ROMI placeholders with no commercial meaning. Input owed by Marco/Fabrizio._                                                                                                                     |  M   |   🔴   |

---

## 6. Tickets, signature and access — the Phase 1 priority

### 6.1 Lifecycle

| Stage | Trigger                                                                    | Effect                                                                                           |
| :---: | -------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
|   1   | **Order** placed                                                           | Movement **loaded** (parked, not usable)                                                         |
|   2   | **Payment** of the linked invoice completed                                | Movement **available**                                                                           |
|   3   | **Signature** of the documents (privacy, non-compete, photo/video consent) | **QR generated** — the ticket becomes usable                                                     |
|   4   | **Check-in**: QR scanned                                                   | Movement **unloaded**; algebraic sum per client = 0. Unused tickets stay visible as no-show data |

| ID     | Requirement                                                                                                                                                                                                                 | Pri. | Status |
| ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :----: |
| BIG-01 | The four-stage lifecycle above is binding and must be implemented as stated.                                                                                                                                                |  M   |   ✅   |
| BIG-02 | Every order containing an "evento" product automatically creates a **Campaign** (if absent) and **one ticket per event article code** in the order — including multi-event bundles and tutor-entered orders.                |  M   |   ✅   |
| BIG-03 | Binding terminology: the **ticket is the record**; the **QR is a value inside it**, not the record itself.                                                                                                                  |  M   |   ✅   |
| BIG-04 | The set of ticket-generating codes is determined by the product flag (BUN-12), **not** by reading a letter from the article code. The same code generates a ticket whether sold in a bundle, by a tutor, or on the website. |  M   |   ✅   |
| BIG-05 | Participants are not the account's contacts: after payment an email goes to the referent, who fills the **participant list**; contacts are auto-created; each participant signs and receives their own QR.                  |  M   |   ✅   |
| BIG-06 | Reminder funnel at **60 / 30 / 15 / 1 days** before the event.                                                                                                                                                              |  S   |   ✅   |
| BIG-07 | A **day-of-event fallback button**: immediate email or identity check at the desk, issuing the QR on the spot. Purchases accepted until the day before.                                                                     |  M   |   ✅   |
| BIG-08 | Card payment: auto-completed. Bank transfer: manual confirmation by administration (stays manual at go-live).                                                                                                               |  M   |   ✅   |
| BIG-09 | **Zero-euro orders** (free tickets) stay in the CRM to trigger ticket generation and are **not** transferred to Mexal.                                                                                                      |  M   |   ✅   |
| BIG-10 | **Credit notes** on orders with an "evento" product automatically set the matching ticket to **Annullato**. Refunds are normally credit toward future purchases rather than bank transfers, handled by the tutor.           |  S   |   ✅   |
| BIG-11 | Check-in is by QR scan (today through an app on an internal phone).                                                                                                                                                         |  M   |   ✅   |

### 6.2 Digital signature — decision required

| ID     | Requirement                                                                              | Pri. | Status |
| ------ | ---------------------------------------------------------------------------------------- | :--: | :----: |
| BIG-12 | QR issuance is **conditional on signature**. Confirmed by direction and not in question. |  M   |   ✅   |
| BIG-13 | **Signature-collection method.** 🔴 _Decision due by 6 August._ Three options:           |  M   |   🔴   |

> **Option A — DocuSign.** AppExchange package, a single sending user (the funnel owner's mailbox), asynchronous sends N days before the event, envelope status tracking. Indicative cost €1.80–2 per document. Requires purchasing licences; negotiation still open.
>
> **Option B — Paper signature with upload to a Community page** (ROMI proposal). The client prints, signs and uploads a scan or photo to a custom Community page. Removes the per-document cost but requires **human verification** of what is uploaded: no automated check on a PDF is possible.
>
> **Option C — Paper process as-is.** PDF printed, signed and handed over at check-in. No development, no cost, no digital traceability.
>
> **Discarded:** "link signature" with a simple acceptance click — no legal standing and not GDPR-compliant.
>
> ⚠ **Technical impact:** the uncertainty affects **only the signature-collection step**. Everything upstream (order and ticket creation) and downstream (QR scanning, access control) is unchanged in all three scenarios. Absent a decision by 6 August, ROMI proceeds with **Option C** and digital signature becomes a later evolutiva.

| ID     | Requirement                                                                                                                                                                                   | Pri. | Status |
| ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :----: |
| BIG-14 | A **manual signature path** must exist for non-digital clients alongside the chosen solution.                                                                                                 |  M   |   ✅   |
| BIG-15 | Separate signature of quote and general conditions/contract: one send or sequential. 🔴 _Pienissimo internal decision._                                                                       |  S   |   🔴   |
| BIG-16 | Event dates and ticket-delivery lead times: confirm "Camerieri Venditori" (3 November or April) and whether the 60-day lead time for Pienissimo Live (24–26 November) can be pushed later. 🔴 |  S   |   🔴   |

---

## 7. Orders, tranches and the administrative cycle

| ID     | Requirement                                                                                                                                                                                                                    | Pri. | Status |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :--: | :----: |
| ORD-01 | After products are selected on the Quote, the user creates each tranche through a guided action, selecting its Quote Line Items and entering the planned payment due date.                                                     |  M   |   ✅   |
| ORD-02 | The tranche reference and date propagate from Quote Line Item to Order Item. The order passes to Mexal **in full**, carrying both values **at line level**, not as a tranche object.                                           |  M   |   ✅   |
| ORD-03 | Mexal updates payment status **per Order Item/invoice line**; Salesforce recalculates the corresponding tranche. It becomes fully paid only when every included line is fully paid. Mexal never creates or writes the tranche. |  M   |   ✅   |
| ORD-04 | At invoicing, every invoice generated by Mexal is reflected in Salesforce: **n Mexal invoices → n Salesforce invoices**.                                                                                                       |  M   |   ✅   |
| ORD-05 | **Automatic contract generation** is keyed to the **product type** on the order (e.g. the Performance Plus code), **not** to order status — the same criterion adopted for bundles.                                            |  S   |   ✅   |
| ORD-06 | Introduce **order types** (e.g. stage bundle, stage/performance) to differentiate workflows and reporting.                                                                                                                     |  S   |   ✅   |
| ORD-07 | **Overdue report**, scheduled weekly (e.g. Monday) to sales and administration — invoices issued and unpaid with a due date before the check date. Production is excluded from distribution.                                   |  S   |   ✅   |
| ORD-08 | **Expiring-tranche report**, emailed to administration before month end listing the following month's expiring tranches.                                                                                                       |  S   |   ✅   |
| ORD-09 | Both reports are permanently available and refreshed, with no manual launch.                                                                                                                                                   |  S   |   ✅   |
| ORD-10 | Invoice display policy: component lines vs instalment lines, and masking internal component prices from the client. 🔴 _Daniela/Fabrizio decision with Marco._                                                                 |  M   |   🔴   |
| ORD-11 | **Performance Plus** can originate from a stage bundle or from direct tutor entry. Both cases must be supported.                                                                                                               |  S   |   ✅   |

---

## 8. Integrations

| ID     | Integration                   | Requirement                                                                                                                                                                                                                                                                                                                              | Pri. | Status |
| ------ | ----------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :----: |
| INT-01 | **Mexal (Passepartout)**      | Integration over **REST API** (confirmed 7 July, replacing file exchange). Eight objects: agents, clients, payment conditions, destinations, invoices, products, orders, client exposure.                                                                                                                                                |  M   |   ✅   |
| INT-02 | Mexal                         | **Source of truth**: Salesforce for new records, Mexal for administrative edits, with periodic realignment.                                                                                                                                                                                                                              |  M   |   ✅   |
| INT-03 | Mexal                         | Edit rights on the synced client registry are restricted to admin users: sales must not alter it after synchronisation.                                                                                                                                                                                                                  |  M   |   ✅   |
| INT-04 | Mexal                         | **Scheduled nightly GETs**, delta only, keyed on the "data ultima modifica" field.                                                                                                                                                                                                                                                       |  M   |   ✅   |
| INT-05 | Mexal                         | Invoices require date filters and pagination (~2,300 invoices in 2025), respecting the Salesforce limits of 6 MB for synchronous and 12 MB for asynchronous callouts.                                                                                                                                                                    |  M   |   ✅   |
| INT-06 | Mexal                         | No repeated GETs on orders (the id is returned on creation); instead a **"rinvio ordine" button** to handle errors or changes.                                                                                                                                                                                                           |  M   |   ✅   |
| INT-07 | Mexal                         | An **on-demand product-import button**, in addition to the nightly sync, so new items are immediately sellable.                                                                                                                                                                                                                          |  M   |   ✅   |
| INT-08 | Mexal                         | Agents are held as **suppliers**, filtered by mastro; codes start with **610** for company "P". No agents API exists: on a new hire the code is copied manually.                                                                                                                                                                         |  M   |   ✅   |
| INT-09 | Mexal                         | A registry field referencing the previous client code and VAT, so **company-name changes** do not break history.                                                                                                                                                                                                                         |  S   |   ✅   |
| INT-10 | Mexal                         | **No Mexal test environment exists**: a test company must be created to validate POST calls and dummy orders without touching real accounting. 🔴 _Pienissimo/Kreosoft action._                                                                                                                                                          |  M   |   🔴   |
| INT-11 | **WooCommerce**               | Integration over **API**, not a plugin. Two instances to map: events/stage sales and books/marketing. 🔴 **2026-08-27 reverses the outstanding credential.** With WooCommerce pushing into Salesforce, ROMI owes Pienissimo a **Salesforce endpoint and a header token** (blocks the 31/08 tests). Whether Salesforce still reads orders back over the WooCommerce REST API — and so whether the Consumer Key and Secret are needed at all — was not decided. The two instances were not revisited. |  M   |   🔴   |
| INT-12 | WooCommerce                   | **Checkout links with Opportunity tracking**: Salesforce generates a checkout URL carrying the Opportunity id; WooCommerce stores it as order metadata and exposes it over REST; Salesforce reads the order, updates the fields and moves the Opportunity to Closed Won.                                                                 |  M   |   ✅   |
| INT-13 | WooCommerce                   | Development needed — Salesforce side: `WooCommerce_Product_Id__c` on Product, `WooCommerce_Order_Id__c` on Opportunity, a link-generator button, order-reading logic. **2026-08-27 supersedes the Pienissimo side:** the client-side component is a **WooCommerce plugin written and owned by Sabatino Rinaldi** (v1.3, always active), not the ROMI-specified _must-use plugin_ snippet. The link generator **no longer needs product and quantity pickers** — carts are Funnel Kit funnels that already contain the product, so the link carries the **opportunity id alone**. |  M   |   ✅   |
| INT-14 | WooCommerce                   | **Integration direction — SETTLED 2026-08-27: WooCommerce pushes into Salesforce.** More specific than the standing webhook recommendation: **stock WooCommerce webhooks were evaluated live and rejected** (one topic per webhook, no multi-select, no control of the body, cannot carry the customer structure). The mechanism is a **custom WooCommerce plugin using a PHP action hook on the order status transition**, sending one JSON body carrying order, customer and order lines. |  M   |   ✅   |
| INT-15 | WooCommerce                   | **Price source of truth**: WooCommerce list price, or the Salesforce negotiated price via dynamic one-shot coupons. 🔴                                                                                                                                                                                                                   |  M   |   🔴   |
| INT-16 | WooCommerce                   | **Security of the identifier in the link**: id in clear (simple but guessable) or a signed token. 🔴 _ROMI recommends the signed token._                                                                                                                                                                                                 |  S   |   🔴   |
| INT-17 | WooCommerce                   | 2×1 promotions handled as quantity 2 at 50%, keeping list price, quantity and paid price coherent.                                                                                                                                                                                                                                       |  S   |   ✅   |
| INT-18 | **Anticipay** (ex CreditSafe) | VAT lookup pre-filling registry and legal representative; alert on invalid VAT. Must fire for **all new accounts**, not only at order. 🔴 _Timing to decide: alongside Mexal (Pienissimo's request) or Phase 2 (ROMI's proposal). Foreign-VAT handling to verify._                                                                       |  M   |   🔴   |
| INT-19 | **Digital signature**         | See BIG-13.                                                                                                                                                                                                                                                                                                                              |  M   |   🔴   |
| INT-20 | **Gmail / Outlook**           | Native connectors for email and calendar sync. Urgent: tutors currently work from paper agendas.                                                                                                                                                                                                                                         |  M   |   ✅   |
| INT-21 | **3CX**                       | Call recording → CRM → coaching insights via internal AI. 🔴 _The status of the 3CX commercial setup has never been reported since the 27 May kickoff._                                                                                                                                                                                  |  C   |   🔴   |

---

## 9. Data, analytics and reporting

| ID     | Requirement                                                                                                                                                                                                                                                                                               | Pri. | Status |
| ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :----: |
| DAT-01 | **Two-way traceability chain**: invoice ↔ order ↔ quote ↔ opportunity ↔ campaign ↔ lead, with cascading ids. **Project acceptance criterion.**                                                                                                                                                            |  M   |   ✅   |
| DAT-02 | **RFM matrix** rebuilt natively in Salesforce: **order-date** based (not invoice date, which annual billing would distort), segmented by product line (courses / platform / Performance Plus), surfaced on the account page with acquisition cost and origin campaign. Replaces the current SQL-on-Mexal. |  S   |   ✅   |
| DAT-03 | **No-show analytics**: acquisition-source tag per client, no-show propensity per source, room-composition dashboards, fed by campaign check-in statuses.                                                                                                                                                  |  S   |   ✅   |
| DAT-04 | Reports exportable to Excel and schedulable by email.                                                                                                                                                                                                                                                     |  M   |   ✅   |
| DAT-05 | Monthly "what to invoice" report and a year-end revenue projection for direction (target €4–5M).                                                                                                                                                                                                          |  S   |   ✅   |
| DAT-06 | **Data cleanup** before the ~1 September import: dedupe ~6,000 leads/accounts against ~7,500 paying clients. 🔴 _Fabrizio and Elisa's action._                                                                                                                                                            |  M   |   🔴   |
| DAT-07 | **Data model workbook**: ROMI supplies the structure, Pienissimo fills in the fields currently held in Zoho for Account, Referente, Opportunity, Offerta, Ordine, Articoli, pruning unused ones. 🔴 _Delivery owed by Sabatino._                                                                          |  M   |   🔴   |
| DAT-08 | **Data 360** ingestion path: Mexal → Google Cloud Storage → ingestion → transformation → standard reports and dashboards over Data 360 objects, replacing the Zoho chain (FTP → Data Prep → warehouse → Zoho Analytics).                                                                                  |  F2  |   🟡   |
| DAT-09 | Until the September import, interim analytics stay on external tools (Power BI or equivalent).                                                                                                                                                                                                            |  S   |   ✅   |

---

## 10. Marketing

| ID     | Requirement                                                                                                                                                                                                                                        | Pri. | Status |
| ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :----: |
| MKT-01 | **Form inventory** split lead vs opportunity, with hidden source fields (source, category, UTM) driving routing. 🔴 _Pienissimo shared a list of 100+ forms; the internal review deciding which are carried into Salesforce is still outstanding._ |  M   |   🔴   |
| MKT-02 | **Double opt-in** on forms: confirm key fields before the thank-you page, to cut invalid VAT and registry data at source.                                                                                                                          |  S   |   ✅   |
| MKT-03 | Dedicated subdomain and configuration information.                                                                                                                                                                                                 |  M   |   ✅   |

---

## 11. Non-functional requirements

| ID     | Requirement                                                                                                                                                                                                                                                                                                      | Pri. | Status |
| ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: | :----: |
| NFR-01 | **Visibility model** derived from the org chart, on a **restrict-then-widen** basis, never the reverse. Around 6 sales people.                                                                                                                                                                                   |  M   |   ✅   |
| NFR-02 | Dormant-client reassignment: manual at go-live; automatic rules require Pienissimo to define thresholds and policy. 🔴                                                                                                                                                                                           |  S   |   🔴   |
| NFR-03 | **Document storage**: the org has 35.2 GB. Signed PDFs and QR codes accumulate, so a purge strategy is needed (e.g. 30 days post-event after client-side cloud backup) or linking to SharePoint/Drive. 🔴 _Decision deferred._                                                                                   |  M   |   🔴   |
| NFR-04 | **PDF generation**: fully stylable on the front end; limited server-side. Adopted pattern: generate on user action or status flag, send the stored PDF afterwards.                                                                                                                                               |  M   |   ✅   |
| NFR-05 | At least **four document templates**: order/contract with general conditions (sent only for significant packages, indicatively ≥ €10k), event participation terms acceptance, **RID mandate** (~50% of payments; dynamic template with client-filled bank details, requires the Mexal client code), quote print. |  M   |   ✅   |
| NFR-06 | **Apex code coverage ≥ 75%** as a precondition for production release. ⚠ _Check of 3 August 2026: org-wide coverage is 1% and the bundle test suite fails 9 of 10 tests following a schema change. This is a technical precondition for go-live, owned by ROMI._                                                 |  M   |   🔴   |
| NFR-07 | Labels, states and help text are translated into Italian.                                                                                                                                                                                                                                                        |  M   |   ✅   |
| NFR-08 | A **test environment** must be available for key users to validate before release.                                                                                                                                                                                                                               |  M   |   ✅   |

---

## 12. Points to close before requirements freeze

These block signature, ordered by urgency.

### 12.1 To close by 6 August 2026

|  #  | Point                                                          | Ref.         | Owner                                       |
| :-: | -------------------------------------------------------------- | ------------ | ------------------------------------------- |
|  1  | **Signature-collection method** — Option A, B or C             | BIG-13       | Sabatino, with Daniela                      |
|  2  | **Order-acceptance and contract procedure**                    | SAL-17       | Marco Montesi, Elisa Migliano, with Daniela |
|  3  | **Out-of-contract scope**: GLS, Teachable, Zoho Pienissimo Pro | OUT-01/02/03 | Daniela                                     |

### 12.2 Inputs owed by Pienissimo

|  #  | Input                                                                                                 | Ref.   | Owner                 |
| :-: | ----------------------------------------------------------------------------------------------------- | ------ | --------------------- |
|  4  | **Real catalogue prices** for listed codes                                                            | BUN-20 | Marco, Fabrizio       |
|  5  | **Definitive 7-event list** for the classification picklists                                          | BUN-09 | Fabrizio              |
|  6  | **3–5 sample bundle-only article codes**, by end of August                                            | BUN-15 | Fabrizio              |
|  7  | **Data model workbook** with the Zoho fields                                                          | DAT-07 | Sabatino              |
|  8  | **Review of the 100+ form list**                                                                      | MKT-01 | Pienissimo marketing  |
|  9  | **WooCommerce Consumer Key and Secret** for both instances — ⚠ 2026-08-27 left it undecided whether Salesforce calls WooCommerce at all | INT-11 | Sabatino              |
|  9b | **Salesforce inbound endpoint and header token** for the WooCommerce plugin — blocks the 31/08 integration tests | INT-11 | **Aurel Mrruku (ROMI)** |
| 10  | **Quote validity times** per category and business line                                               | SAL-10 | Marco Montesi         |
| 11  | **Test company in Mexal**                                                                             | INT-10 | Pienissimo / Kreosoft |
| 12  | **Key-user list**, business and technical per area — requested at the 27 May kickoff, never delivered | —      | Sabatino              |
| 13  | **3CX setup status** — never reported since kickoff                                                   | INT-21 | Sabatino              |
| 14  | **Real quote templates and client emails** per typology                                               | NFR-05 | Marco                 |

### 12.3 Technical decisions to agree

|  #  | Decision                                           | Ref.   | ROMI recommendation                              |
| :-: | -------------------------------------------------- | ------ | ------------------------------------------------ |
| 15  | WooCommerce integration direction                  | INT-14 | ✅ **Settled 27/08: WooCommerce pushes via a custom plugin on a PHP order-status hook** |
| 16  | WooCommerce price source of truth                  | INT-15 | Salesforce negotiated price with dynamic coupons |
| 17  | Security of the id in the checkout link            | INT-16 | Signed token                                     |
| 18  | Blocking spread variance                           | BUN-17 | Yes, blocking                                    |
| 19  | Anticipay timing                                   | INT-18 | Phase 2                                          |
| 20  | Document storage strategy                          | NFR-03 | 30-day post-event purge with client backup       |
| 21  | Component price exposure on invoices               | ORD-10 | Instalment lines, components masked              |
| 22  | Ticket object: custom vs standard Asset            | DM-22  | ✅ Standard Salesforce Asset decided 24 August   |
| 23  | Notification channel                               | SAL-15 | Salesforce bell                                  |
| 24  | Quote and contract signature: single or sequential | BIG-15 | Single send                                      |

---

## 13. Acceptance criteria

The project is considered compliant when all of the following are verified in the test environment by Pienissimo's key users.

|   #   | Criterion                                                                                                                                                                                                                                                         | Ref.           |
| :---: | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| AC-01 | A form-generated lead reaches an invoiced order with no unplanned manual intervention, and the traceability chain resolves in both directions.                                                                                                                    | DAT-01         |
| AC-02 | A sold bundle produces order lines per **elementary product**, with the sum of spreads exactly equal to the bundle's selling price.                                                                                                                               | BUN-02, BUN-05 |
| AC-03 | The same product placed in two different bundles at different spreads yields correct revenue statistics for both.                                                                                                                                                 | BUN-03         |
| AC-04 | An order with an event product automatically generates the campaign and the tickets, one per event article code, including multi-event bundles.                                                                                                                   | BIG-02         |
| AC-05 | The QR is issued **only** after signature, and scanning at check-in unloads the movement, bringing the client's algebraic sum to zero.                                                                                                                            | BIG-01, BIG-12 |
| AC-06 | On a Quote with several products, the user creates tranches by selecting lines and due dates; acceptance preserves those assignments on the Order Items; Mexal returns payment by line and the tranche becomes fully paid only when all its lines are fully paid. | ORD-01, ORD-03 |
| AC-07 | A credit note on an event order sets the ticket to Annullato.                                                                                                                                                                                                     | BIG-10         |
| AC-08 | A checkout link generated from an Opportunity updates that same Opportunity to Closed Won once the purchase completes.                                                                                                                                            | INT-12         |
| AC-09 | The two scheduled reports (overdue, expiring tranches) reach their recipients without manual launch.                                                                                                                                                              | ORD-07, ORD-08 |
| AC-10 | Apex code coverage is at or above 75% and the test suite is entirely green.                                                                                                                                                                                       | NFR-06         |

---

## 14. Change management

1. Every change request after signature is submitted to ROMI in writing.
2. ROMI responds with an impact assessment on **scope, time and cost** within five working days.
3. Work starts **only after written approval** from Pienissimo.
4. Requests that endanger the 6 October 2026 date are automatically candidates for Phase 2, unless the go-live date is explicitly renegotiated.
5. The items in §2.2 stay out of scope until separately quoted and accepted.

---

## 15. Approval

By signing, the parties confirm that the requirements marked ✅ are complete, correct and binding, and that the points in §12 have been closed or explicitly deferred with an owner and a date.

| Role                            | Name               | Date | Signature |
| ------------------------------- | ------------------ | ---- | --------- |
| Pienissimo direction            | Daniela            |      |           |
| Pienissimo project lead         | Sabatino Rinaldi   |      |           |
| Pienissimo administration       | Elisa Migliano     |      |           |
| Pienissimo sales                | Marco Montesi      |      |           |
| Pienissimo product and registry | Fabrizio Paganelli |      |           |
| ROMI Project Manager            | Elena Spini        |      |           |
| ROMI technical lead             | Aurel Mrruku       |      |           |

---

## 16. What was written only in the drawings

The two draw.io files carry decisions that were never minuted. From here on they are part of the scope like everything else.

### 16.1 How a record moves

A record enters as a **Lead**, becomes an **Opportunity**, carries a **Quote**, turns into an **Order** with its tranches, and emits a **Ticket**.

| Object      | States, in the order they are traversed                                                                                                                        |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Lead        | New → In Lavorazione → Primo contatto → Qualificato · or Non Risponde (automatic task with a 48h reminder, then back into In Lavorazione) · or Non qualificato |
| Opportunity | Qualificato → In trattativa (quote sent) → Chiusa/Vinta · with Da ricontattare as a parking state and Chiusa/Persa as the exit                                 |
| Quote       | Bozza → In trattativa (5-day validity) → **In attesa di accettazione** → Accettato (accounting copy received) · or Rifiutata                                   |
| Order       | CREATO → CHIUSO/ACQUISITO                                                                                                                                      |
| Tranche     | Created on the Quote → fully paid when every included line is paid. ⚠ Final API value open: `Pagata`/`Incassata` vs legacy `CHIUSO/ACQUISITO`.                 |
| Ticket      | Ordinato → Disponibile → Assegnato → Utilizzato · or Non utilizzato · or Annullato                                                                             |

⚠ **“In attesa di accettazione” is the new name for “preventivo scaduto”.** The room will keep saying “scaduto” for months: it is the same thing.

⚠ **The order of the values in the Salesforce ticket picklist is not the order of the flow.** The picklist reads Ordinato, Assegnato, Disponibile, Non utilizzato, Utilizzato, Annullato; the real flow is the one in the table above.

**Steps a person performs, not the system.** These read as standing workload, because signing them accepts them: administration confirms receipt of a bank transfer in WooCommerce; administration moves the order to CHIUSO/ACQUISITO within a maximum of 5 days; the tutor sets Accepted or Refused on a quote; the tutor puts an expired quote back into negotiation; staff scan the QR at the event.

### 16.2 Words that mean different things on different objects

| Word                   | Lives on                 | Watch out                                                                                                                                                      |
| ---------------------- | ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **In trattativa**      | Opportunity, Quote       | On the opportunity it is the negotiation; on the quote it is that quote inside its 5 days                                                                      |
| **Da ricontattare**    | Lead, Opportunity, Quote | On the Lead it is a task; on the other two a status, each with its own reason picklist                                                                         |
| **CHIUSO / ACQUISITO** | Order, Tranche           | Legacy diagram value. The 24 August decision supersedes the tranche trigger with all-lines-paid aggregation; whether this remains the final API value is open. |

When one of these words is said aloud, the object must be named too.

### 16.3 Picklist values

**Lead · Exit reason — LOST** (the lead was right but did not close): Not interested · Price too high · Chose a competitor · Service not suitable

**Lead · Exit reason — WRONGLY ENTERED** (should never have come in; dedicated sub-category, exportable to analyse source quality): Already has P.Pro · Already in contact · Inaccurate contact data · Duplicate from CRM · Out of target · Request sent by mistake · SW House, marketing or web agency · Test

**Opportunity · Closed lost:** Price too high · Chose a competitor · Delivery timing · Not aligned with expectations

**Opportunity · To recall:** Course date incompatible · Venue not open yet · Not answering · Postponing on price · Postponing for personal reasons · Postponing for business reasons · Call back after the season

**Quote · To recall:** Call back after the season · Busy · Needs to think about it

**Order type:** STANDARD · BUNDLE · PLUS · **Opportunity type:** Vendita da tutor · Recall tutor

### 16.4 The seventeen requirements to ratify

They exist only in the drawings and have never been discussed in a meeting. Signature makes them binding.

| ID     | Requirement                                                                                                                                                                                                   | Pri. |
| ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--: |
| SAL-19 | An expired quote must be returnable to negotiation by the tutor alone.                                                                                                                                        |  S   |
| SAL-20 | Two “to recall” tasks to add: after first contact and after the appointment, with a settable date.                                                                                                            |  S   |
| SAL-21 | Opportunity type field with the values “Vendita da tutor” and “Recall tutor”.                                                                                                                                 |  S   |
| SAL-22 | An INFO field explaining how to use the exit reasons.                                                                                                                                                         |  C   |
| SAL-23 | Enable the standard behaviour moving the opportunity to “quote sent” automatically.                                                                                                                           |  S   |
| ORD-06 | Order types STANDARD, BUNDLE, PLUS.                                                                                                                                                                           |  S   |
| ORD-07 | Overdue report every Monday to Marco and administration.                                                                                                                                                      |  S   |
| ORD-12 | **Corrected 2026-08-27.** A WooCommerce order reaches Salesforce when its status becomes **IN LAVORAZIONE (processing) OR COMPLETATO (completed)**, for any payment method — bank transfer, card or PayPal. Verified live against the delivered plugin; supersedes the earlier "invisible until COMPLETATO". For bank transfers administration still flips the order by hand on receipt. Every line arriving from WooCommerce is therefore already paid. |  M   |
| ORD-13 | ⚠ Legacy diagram rule: the first tranche goes to `CHIUSO/ACQUISITO` on deposit. Aurel's 24 August decision supersedes the trigger with aggregation of all included lines; the final state label remains open. |  M   |
| ORD-14 | CHIUSO/ACQUISITO is set by administration by hand within a maximum of 5 days of confirmed payment.                                                                                                            |  M   |
| ORD-15 | “Create Credit Note” button on the order, with a pop-up to pick the lines.                                                                                                                                    |  S   |
| INT-22 | Overdue amounts come from the Mexal “scoperto clienti” API.                                                                                                                                                   |  S   |
| BIG-17 | Ticket status picklist with six values.                                                                                                                                                                       |  M   |
| BIG-18 | Participant landing reached by a link carrying the Account ID; with several events the event is chosen first.                                                                                                 |  M   |
| BIG-19 | On list confirmation a flow creates or matches contacts, adds campaign members and sends the signature request.                                                                                               |  M   |
| BIG-20 | The QR contains the campaign member ID.                                                                                                                                                                       |  M   |
| BIG-21 | “Edge cases” button on the ticket, visible only from Assegnato, for name change and missing signature.                                                                                                        |  S   |

---

## 17. Where the sources disagree

Eight points, and they are not the same kind of thing. The label says which, because treating them alike would be misleading at the moment of signature.

⚠ **RC-06 to RC-08 are new in this revision and share one cause.** Both design files were edited on **20 August 2026**, 68 minutes apart, and **neither edit was minuted** — no meeting, no notes, no message. In each case the drawing now says something this document does not. **Nothing below has been changed on the strength of a drawing**; they are listed so you can rule on them.

### RC-01 · Resolved 24 August — the ticket object

The UAT org already contains a custom object `Biglietto__c` with six Apex classes for DocuSign and PDF generation. The design specifies the standard Salesforce Asset object instead.

**Decision:** use the standard Salesforce Asset object. The direct instruction did not identify the decision-maker. `Biglietto__c` is now an implementation gap rather than a choice awaiting ratification: its fields, relationships and six Apex classes must be mapped, then migrated, rewritten or retired. **The effort has not been estimated.**

### RC-02 · To clarify — what creates the campaign and the tickets

The design says the campaign is born when the EVENTO product is created in Mexal; the minutes of 22/07 say it is born when an order with an event product arrives. Once separated the two are not in conflict: **campaign on product creation, tickets on order**. The documents describe different automations only because neither says which object it means.
**If nobody decides:** it stays ambiguous, whoever builds picks one, and the other document stays wrong.

### RC-03 · Never decided — how many reminders, and on which channel

⚠ **Our error, withdrawn.** We had presented this as a contradiction between “60 and 2 days” and “60, 30, 15 and 1”. It is not.

The minutes of 08/06, line 17, read verbatim: _“Reminder funnel for uncompiled tickets (they already run a WhatsApp/60-30-15-1-day funnel)”_. That describes **your existing WhatsApp practice**, in brackets — not a requirement for Salesforce. No Salesforce cadence was ever agreed, so there is nothing to contradict.

The real question was never asked: does Salesforce replicate your four-touch cadence by email, or run two touches (60 and 2) as drawn? Four sends cost more to build and risk spam; two risk more no-shows.
**Proposal:** none until you tell us the channel. **If nobody decides:** 60 and 2, because that is what is drawn.

### RC-04 · Our correction — order types

The minutes of 30/06, line 7, record **seven** typologies from your own Excel and PDF: _stage sales, tutor packages, tutor combo, tutor one-shot, Performance Plus, product sales, Pienissimo Pro_. The design specifies **three** order types: STANDARD, BUNDLE, PLUS.

⚠ The six entries listed in v1.0 of this document (stage sale, tutor, book, video course, PP activation, PP renewal) **appear in no source**: we wrote them ourselves and they are withdrawn.

Two fields are being confused: the three values drive automation, your seven describe what is sold. Both can exist.
**Proposal:** order type = the three; sales typology = your seven, unchanged. **If nobody decides:** only the three survive and Marco loses the breakdown he supplied.

### RC-05 · Our walk-back — the credit note

On 22/07 it was **agreed** that a credit note on an event product would automatically set the ticket to Annullato. It stands as a decision taken, not an open point.

ROMI is now asking to go back and select the tickets **by hand** in a pop-up, because on a multi-event bundle a partial reversal cannot be inferred: the system cannot know which ticket the note refers to.

This is the supplier asking to undo something already approved, for a technical reason. It is not a tie-break between two sources and must not be recorded as one.
**If nobody decides:** the 22/07 decision stands — automatic cancellation, and the multi-event bundle case stays unsolved.

### RC-06 · To rule on — is `Rinuncia` a seventh ticket state?

This document and the register specify **six** asset states: `Ordinato`, `Disponibile`, `Assegnato`, `Utilizzato`, `Non utilizzato`, `Annullato`. Since 19 August the design files draw a **seventh** box, **`Rinuncia`**, annotated _"avviene nella comunicazione dei partecipanti o accetta o rinuncia"_ — the referent declining at the moment the participant list is requested. `Annullato`'s recorded triggers are a name change or a credit note, both later moments.

Read plainly these are two different events. But the 6 August record treats _rinuncia_ as loose wording for `Annullato`, and nothing since has been minuted.
**Proposal:** one sentence from Elena Spini or Sabatino Rinaldi settles it. **If nobody decides:** six states are built as specified here, and `Rinuncia` is not configured.

### RC-07 · To clarify — `Incassato` and `CHIUSO/ACQUISITO`

The 6 August session replaced the order states with **`Ordinato → Fatturato → Incassato`** and struck _Chiuso acquisito_ outright. The design file has now caught up and draws those three — **but it did not remove the old values**: `CHIUSO/ACQUISITO` and `CREATO` are still on the orders page, and the tranche rule still sends the first tranche to `CHIUSO/ACQUISITO`.

So the source now carries both vocabularies at once. **Nobody has said whether `Incassato` is `CHIUSO/ACQUISITO` renamed, or a different milestone.** Aurel's 24 August decision settles tranche creation and payment aggregation, so those mechanics can proceed; only the final tranche-state label still depends on this answer.
**Proposal:** confirm they are the same milestone under a new name, or name the second one. **If nobody decides:** the creation and roll-up can be built, but the final Order and Tranche state values cannot be configured safely.

### RC-08 · Our flag — a ticket tier changed name in a drawing

The 6 August minutes record the example product codes as **_Camerieri Venditori Gold_** and **_Camerieri Venditori Silver_**. On 20 August the design file changed `Silver` to **`Dinamond`** — most likely _Diamond_, misspelt.

This is a one-word change in a drawing against a term a meeting put on the record, and it touches the ticket-type list that is still owed with the product master.
**Proposal:** send the tier list with the product-master fields, and we will take it from there rather than from the drawing. **If nobody decides:** we build nothing, because a tier list inferred from example strings would be guesswork.

### A note on sources

The citations do not all carry the same weight, and that should be said: the minutes of 08/06, 30/06 and 23/07 are on file in `meetings/results/`; **22/07 is a set of minutes circulated by email and not present in the repository**, and RC-02 and RC-05 both rest on it; the meetings of 29/07 and 31/07 have **automatic notes only**, with no human-written minutes.

---

### Appendix A — Sources

Tracked meetings: 27/05 (kickoff), 03/06 (sales demo), 04/06 (marketing demo), 08/06 (ticketing and compliance), 16/06 (tech sales), 23/06 (marketing), 30/06 (sales types and quotes), 02/07 (Mexal invoicing), 07/07 (lead/opty and integrations), 14/07 (Mexal integration), 16/07 (bundle demo and order flow), 22/07 (bundle and ticket flow), 23/07 (product codes and bundles), 29/07 (open-topics follow-up), 31/07 (business review).

Documents: `Integrazione_Salesforce_WooCommerce.docx` (31/07), `anar_PIE_ricla.xlsx` (article master, 22/07), `Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx`, Passepartout WEBAPI credentials (15/07).

Direct decision: Aurel Mrruku, 24/08, Quote-side tranche creation, propagation to Order Items and payment roll-up.

Technical verification against the Pienissimo UAT org carried out on 3 August 2026.

Full traceability in `meetings/DEVELOPMENT-RECAP.md` and `meetings/open-items.md`.
