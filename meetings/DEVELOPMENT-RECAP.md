# ROMI-PIENISSIMO — Salesforce Development Recap

> Consolidated from the 8 tracked meetings (2026-05-27 → 2026-07-23), **latest decision wins**. Each item cites its source meeting date. Status legend: ✅ DECIDED · 🟡 CONDITIONAL (decided, pending a verification) · 🔴 OPEN (blocks build — see §9).
> Companion files: per-meeting recaps in `results/`, rolling tracker in `open-items.md`.
> ⚠ **Precedence, newest first: §25 → §24 → §23 → §22 → §21 → §20 → §19 → §18 → §17 → §16 → §15 → §14 → §13 → §12 → [§11](#11-update-2026-08-06--closing-session-on-open-points) → [§10](#10-update-2026-08-03--multi-source-sweep) → §1–§9.**
>
> §17, §19, §22 and §25 are **build-state checks** against the Pienissimo UAT
> org, on 25/08, 26/08, 31/08 and 02/09. Where one contradicts an earlier
> section about what **exists**, the most recent wins. Where an earlier section
> records what was **agreed**, that section stands. §25 withdraws §19's claim
> that the org held no email templates — the instrument could not see them.
> §1–§9 are current to 2026-07-23. §10 carries the 07/24 → 08/03 delta; §11 the 06/08 closing session; §12 the 14/08 document sweep; §13 the 24/08 product workbook; §15 the standard-Asset selection; §16 the four meetings recovered on 24/08. **§14 is Aurel Mrruku's direct tranche decision and overrides every earlier statement that tranches are created from Order Items or imported from `BLO-` codes.** **§17 and §19 are build-state checks against the live UAT org, on 25/08 and 26/08 — where they contradict an earlier section on what _exists_, the newer wins; where an earlier section records what was _agreed_, that section still governs. §19 corrects one finding of §17 outright.** §18 is the 25/08 Anticipay call.

---

## 1. Project frame

| Fact                               | Value                                                                                                                                                                         | Source              |
| ---------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------- |
| Zoho CRM contract expiry           | **October 31, 2026** (corrects kickoff's "end September")                                                                                                                     | 06/08               |
| Dual-run window                    | Zoho + Salesforce in parallel until end of October; stage-sale invoicing stays on Zoho through Food Marketing; ticket data double-entered                                     | 06/08               |
| Hard calendar                      | Tour (free events): Sept 7–19 · Food Marketing Festival: Sept 29 · Big kickoff event (1,500+): Oct 29                                                                         | 05/27, 06/08        |
| Data import into Salesforce        | ~September 1, after dedupe (~6,000 leads/accounts vs ~7,500 paying clients)                                                                                                   | 06/30, 07/07        |
| Phase 1 (by end September, usable) | Everything the Zoho CRM does today: lead/opty flow, quotes/orders, **ticket warehouse + attendance** (top priority), Mexal + WooCommerce integrations                         | 05/27, 06/08        |
| Phase 2 (by end October)           | Product sales via WooCommerce/GLS (books, video courses), Pienissimo Pro flows, Data Cloud analytics, remaining automation                                                    | 06/30               |
| Method                             | ROMI writes the **blueprint** doc → Pienissimo approves → configure (partly in parallel) → key-user reviews in test env                                                       | 05/27               |
| Guiding principles                 | No "accrocchi" (hacks) — redesign don't replicate; start simple/manual, automate what proves repetitive; every design decision must serve the **final statistics/dashboards** | 05/27, 06/16, 07/07 |
| Org language                       | Italian (translate custom labels via translation workbench)                                                                                                                   | 06/03               |

## 2. Data model

| Object                               | Usage / decisions                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | Status                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Lead**                             | Only self-serve actions with no purchase intent (live-stream signup, free video download, quiz). Early workflow stages (in lavorazione, non risponde, primo contatto, da ricontattare, prequalifica) live here. Owned by marketing.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ✅ 06/30                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| **Account / Contact**                | Account = azienda (add **nome locale** field alongside ragione sociale). Opportunity always requires an account: forms create "primordial" account+contact automatically; sales completes registry after first call. Dedup keys: **email OR phone** (forms), **email + VAT** (WooCommerce orders). Converted-lead origin stays visible.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ✅ 06/16                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| **Opportunity**                      | Created directly (skipping Lead) for: explicit contact-request forms (sponsored landings, live QR) and all existing-client requests. 4 phases (negotiation w/ sub-levels → rinviata / persa / vinta). Closed-won driven by **payment** (admin manual). Mandatory loss reason, **two picklist sets** (opportunity-stage vs quote-stage; "errato" must not exist for quotes). SLA: new → in lavorazione within **48 working hours**, else escalation to sales manager. Manual stage transitions at go-live. **Record Types** separate commercial vs e-commerce flows for clean statistics (decided drill-me 07/13; dynamic forms may complement field-level layout inside each type). Track **existing-client vs new-business** origin per opportunity (Daniela's ad-spend attribution).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ✅ 06/16–06/30                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| **Quote (Preventivo)**               | Always under an opportunity; multiple quotes per opportunity; 5-day validity → "scaduto" substatus is routine; retry = **clone** the expired quote (keeps history). Statuses follow the opportunity. Quote = "condizioni generali + economic summary" in one PDF. Terminology: Zoho's pre-acceptance "ordine" = Salesforce **Quote**.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ✅ 06/30                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| **Order**                            | ONE order object; **one order line per installment** with due date (kills the Zoho child-order/"blocchi" pattern). Max **one bundle per order**, never bundle + loose product (two orders instead). Immutable once invoiced (narrow admin correction permission set). Needs an **order typology** field (stage sale / tutor / book / video course / PP activation / PP renewal…) driving admin processes. Orders/products from Mexal are **read-only** in Salesforce.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ✅ 06/30–07/07                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| **Bundle (custom)**                  | Custom container record (NOT Revenue Cloud/CPQ — not licensed, oversized). Fixed price defined at configuration (manual extra discount only); components carry **spread/discounted prices** so product-level revenue stats survive (acceptance criterion). Configured per event (3–5 per event), identical for all buyers, never modified after sale, never reused (activate/deactivate). BLO block codes and €0 omaggio lines are dead: real product codes at 100% discount instead; BLO codes not migrated. UI: bundle as one order line, expandable to components. **Data model (07/16): `BundleComponent__c` junction — the spread price lives on the bundle↔product _link_, not on the product**, so the same product sits in several bundles at a different spread in each (`Spread_Total__c` / `Spread_Variance__c` on the bundle must reconcile to the fixed price). The earlier `Parent__c` self-lookup is retired: one bundle per product only, no per-bundle spread, and it computed the price upward from components. **Pricing (07/23): both a fixed bundle price _and_ an auto-calc-from-components option are delivered; business picks per bundle (fixed → instalments set manually).** **Classification (07/23): three fields — `Anno solare` (master) → `Evento` (dependent picklist) + `Tipologia bundle` (independent). Event seed = 7 canonical events (Tour, Food Marketing Festival, Pienissimo Live, Academy, Sold Out, O.D.B. Live, Camerieri Venditori, Mastery). Values re-created clean, NOT migrated from the legacy LIVELLO_3/4 columns.** | 🟢 07/16 — built and passing in UAT (`proposals/2026-07-16-bundle-spread-demo.md`), junction accepted internally; source file `anar_PIE_ricla.xlsx` decoded & bundle mechanism confirmed with Fabrizio 07/23; 🟡 still to be **shown to Pienissimo** + Andrea's effort estimate (#13, #46). Revenue Cloud question reopens only if the demo disappoints. 🟡 08/18 — the event list and bundle codes (#46, #48) were **delivered on 07/08 as `Prodotti e Bundle.xlsx`** and surfaced when Elena forwarded the thread on 18/08; **the file is still unread**, so the picklist seed data cannot yet be configured |
| **Product / Article master**         | Imported from Mexal (`anar_PIE_ricla.xlsx` = the extract). Legacy structure decoded 07/23: `_ARTIP` **A** = ordinary product · **Z** = rata/block (`BLO-` codes, carry the instalment price) · **C** = bundle (`PACK-` codes). The whole C/Z/BLO/PACK apparatus is **NOT migrated** — it only existed to build bundles-of-instalments on Mexal. The 7 `LIVELLO_` levels are legacy (only L0 + L6 maintained; L3 ≈ event, L4 ≈ package type, but picklists are rebuilt clean not migrated). Two admin-managed flags added at import: **`Genera biglietto` (yes/no)** — the set of ticket-generating codes, toggleable without dev; **`Solo bundle` (yes/no)** — bundle-only codes tutors can't sell directly (no agent commission on bundles). Article codes are **unique & stable** (not changed).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ✅ 07/23                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| **Standard Asset — ticket movement** | Reproduces the Zoho "magazzino biglietti": joins order + contacts; states track the ticket lifecycle (§3.4). **Decision 2026-08-24: standard Salesforce Asset, one Asset record per ticket.** The direct instruction did not identify the decision-maker. UAT still uses custom `Biglietto__c`; its fields, relationships and automations must be mapped and migrated, rewritten or retired.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ✅ Object choice closed 08/24 · ⚠ Asset migration unbuilt and unestimated                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| **Campaign = event**                 | One campaign per event edition; campaign members = participants with check-in status (participated / no-show) → feeds no-show and room-composition analytics. Product codes stay cross-year; year handled via campaign dates + competence-year field on movements.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ✅ 06/08                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| **Contract (Performance Plus)**      | Standard Contract object + custom logic: contracts-as-database (start/end/renewal dates, amount, linked quote/invoices/payments), renewals panel, invoiced-vs-collected per contract, service-block flag on serious arrears. Annual, invoiced in N tranches (12× monthly = same product code; quarterly = different code). Contract sent manually (button) on client's confirmed intent. ~100/year and growing. Elena to propose a distinct name/type for renewable orders (not "bundle").                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ✅ 06/08–07/07 (dedicated analysis session still to hold)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| **Invoice**                          | Created in Salesforce as reference shell when order closes → Mexal invoices → returns number/status into dedicated searchable fields. Same pattern for every order origin.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ✅ 06/16                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| **Credit note**                      | ~30/year, some large. Check license for standard object, else custom.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | 🔴 06/30 — license check pending (Andrea)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |

## 3. Core flows to build

### 3.1 Lead/Opportunity intake (form routing)

- Routing decided by **source, not form content**: hidden pre-filled fields (fonte, categoria, sottocategoria, UTM) discriminate. Source A → Lead; source B → Opportunity (+auto account/contact). Forms change ~every 15 days → repeatable field-mapping process; new fields must pre-exist; Pienissimo can self-manage mappings; consider Marketing Cloud forms/landings. (06/16)
- Multi-select service interest must land readable + reportable on the opportunity (multi-picklist or `;`-joined text + "contains" reports; every value individually countable). (06/16)
- ⚠ Elena's rewritten Salesforce-oriented flow (states, actions) is 🔴 **still not reviewed** — postponed on 07/07; direction has NOT pre-accepted it.

### 3.2 Sales flow (tutor)

- Quote sent → statuses per §2; "da ricontattare" = task/alert (48h parking). New-opportunity SLA 48h. Tutor daily-activities dashboard + manager cross-tutor dashboard (standard components identified). Notification channel (bell vs email) 🔴 TBD by Pienissimo. (06/16, 06/30)
- Tutors on fixed price list, no discretionary discounts unless authorized; installment dates must always keep the client fully paid **before** attending. (06/30)

### 3.3 E-commerce parallel flow (phase 2 build, design now)

- Book: WooCommerce order arrives closed → GLS delivery confirmation (greenfield integration) → **+15 days** → nightly job creates non-commercial opportunity. Video course: Teachable completion API → opportunity immediately → **48 working-hours** task SLA. Opportunity chosen over bare task (funnel reporting). (06/16) Architecture: **Record Types** (decided drill-me 07/13).

### 3.4 Ticket lifecycle — THE priority (phase 1)

Three stages (this reconciles all meetings — state it verbatim in the blueprint):

1. **ORDER** placed → movement _loaded_ (parked, not usable);
2. **PAYMENT** of the linked invoice completed → movement _available_ (today: nightly Mexal→Zoho procedure; replicate via Mexal integration; manual check until then — painful at Food Marketing volumes, 100–150 invoices/day);
3. **SIGNATURE** of docs (privacy, non-compete, photo/video consent) via DocuSign → **QR code (usable ticket) generated**;
4. **CHECK-IN**: QR scanned (internal phone app today) → unload movement → per-client algebraic sum 0; unused tickets stay visible (no-show data).

- **Ticket-generation set = a product-level `Genera biglietto` flag** (07/23), admin-toggleable, not a letter read from the code; the same four+ article codes generate a ticket regardless of whether sold in a bundle, by a tutor, or on the website. Codes are unique & stable. ⚠ The **"anno accademico" (May→Sept)** used here for ticket generation is a **different field** from the bundle's **"anno solare"** — keep them separate (07/23).
- Participants ≠ account contacts: post-payment email to referent → fills **participant list** → contacts auto-created → per-participant signature → QR. Reminder funnel (60/30/15/1 days); **day-of-event fallback button** (instant email / identity check → QR at the door); last-minute purchases accepted until day before. (06/08)
- Payment split: card = auto-completed; bonifico = manual admin confirmation (stays manual at go-live). (06/30)

### 3.5 Documents & signatures

- **DocuSign** (AppExchange package; Salesforce user emails must match DocuSign users; ONE sending user = funnel-owner mailbox; async sends N days pre-event). Purchase in negotiation (Sabatino). (07/07)
- 4+ templates: order/contract (incl. general conditions — sent only for big packages ≥ ~€10k; never small orders), event T&C participation acceptance, **RID mandate** (~50% of payments; dynamic template, client-filled bank fields, requires Mexal client code → prospect→customer flow), quote print. Line-by-line design with ROMI; current docs not normalized. (07/07)
- PDF generation: front-end (button) fully stylable; server-side limited → pattern: generate PDF on user action/status flag, send stored PDF via DocuSign later. (07/07)
- Storage: org has **35.2 GB**; plan purge batch (e.g. 30 days post-event after client cloud backup) or SharePoint/Drive links. (06/08, 07/07)
- 🔴 Quote+contract double-signature vs sequential — Pienissimo internal decision pending. Manual-signature fallback path needed. (06/30)

### 3.6 Performance Plus contracts → §2 Contract. Monthly "what to invoice" report, exportable + schedulable by email; year-end revenue projection for direction (target €4–5M). (05/27, 07/07)

## 4. Integrations map

| #   | Integration                                               | Direction / notes                                                                                                                                                                                                                                                                                                                                                         | Status                   |
| --- | --------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| 1   | **Mexal (Passepartout)**                                  | **REST API** (reversed from CSV/FTP on 07/07). Inbound: clients, agents, payment conditions, destinations, invoices, orders, products, exposure. Outbound: orders (+ account creation for prospects, together with the order). Agents API missing → manual code copy on hire. Contact: Mirko (Creosoft) — Fabrizio connecting him with ROMI. Dual-run sync design needed. | 🟡 in analysis           |
| 2   | **WooCommerce ×2** (events/stage-sales + books/marketing) | API (not plugin). Check Salesforce standard APIs suffice; CK/CS keys from Sabatino; dedup email+VAT; 2×1 promos = qty 2 @50%.                                                                                                                                                                                                                                             | 🟡                       |
| 3   | **DocuSign**                                              | AppExchange; envelope status tracking; three signed-doc types + quote template.                                                                                                                                                                                                                                                                                           | 🟡 awaiting purchase     |
| 4   | **Anticipay (ex CreditSafe)**                             | VAT lookup auto-filling registry + legal representative; must fire for ALL new accounts (not only at order); alert on invalid VAT; probably Italian VAT only (verify foreign skip). Timing decision (with Mexal integration per Pienissimo vs phase 2 per ROMI) 🔴 pending.                                                                                               | 🔴                       |
| 5   | **GLS**                                                   | Delivery confirmation events (book flow trigger). Greenfield.                                                                                                                                                                                                                                                                                                             | phase 2                  |
| 6   | **Teachable**                                             | Course-completion API (confirmed easy).                                                                                                                                                                                                                                                                                                                                   | phase 2                  |
| 7   | **Pienissimo Software SRL (Zoho)**                        | Orders containing the P-Pro product auto-pass to the software company (separate entity, keeps Zoho). Discriminator = product.                                                                                                                                                                                                                                             | 🟡 design                |
| 8   | **Gmail/Outlook**                                         | Native connectors, email + calendar sync — urgent (paper agendas).                                                                                                                                                                                                                                                                                                        | ✅ decided, to configure |
| 9   | **3CX + internal AI**                                     | Call recording → CRM → coaching insights. Status of 3CX commercial setup NEVER reported (open since kickoff).                                                                                                                                                                                                                                                             | 🔴 stalled               |
| 10  | **Meta/Google Ads**                                       | Acquisition cost + origin campaign on contact (feeds RFM panel).                                                                                                                                                                                                                                                                                                          | later                    |

## 5. Analytics & reporting requirements

- **Traceability chain both directions**: invoice ↔ order ↔ quote ↔ opportunity ↔ campaign ↔ lead — cascading IDs; blueprint acceptance criterion. (06/16)
- **RFM matrix rebuilt in Salesforce**: order-date base (not invoice date — annual billing falsifies), segmented per product line (courses / platform / PP), on the account page with acquisition cost + origin campaign. Replaces Fabrizio's SQL-on-Mexal. Dedicated workshop. (06/16)
- **No-show analytics**: acquisition-source tag per customer + no-show propensity per source + room-composition dashboards (fed by campaign check-in statuses). (05/27, 06/08)
- Dashboards: rep-filtered by default; manager cross-view; per-source opportunity counts incl. existing-client vs new-business split. (06/03)
- Reports exportable to Excel + schedulable by email. (05/27)

## 6. Security & visibility

- ~6 salespeople; sharing model mirrors the org chart (in survey). Default **restrict-then-widen**, never the reverse. Reassignment (dormant clients) manual now; automatic rules once Pienissimo defines dormancy thresholds (🔴 open since kickoff). Order edit lock post-invoicing with 1–2 admin exceptions. (06/03, 06/30)

## 7. Cross-cutting configuration decisions

- Italian translations for custom labels/states/guidance. (06/03)
- Terminology reference = Salesforce: lead → opportunity → quote → order. (06/30)
- Start simple: manual stage transitions, automate later. (06/16)
- Duplicate rules: forms email OR phone; WooCommerce email + VAT; lead↔account VAT/company matching on conversion. (06/16, 07/02)

## 8. What's already resolved (don't re-litigate)

Morris AI discarded (internal AI instead) · demo phase done · Zoho deadline = Oct 31 · NBA/Einstein parked (not licensed) · signature-gated QR approved by direction · Mexal multi-tranche invoicing confirmed possible (line-level due dates) · file-vs-API reversed to API · BLO codes retired · WooCommerce = API · one-bundle-per-order confirmed · ticket-trigger "contradiction" was terminology (3-stage lifecycle) · opportunity flow separation = **Record Types** (drill-me 07/13) · bundle data model = **junction, spread on the link**, so one product can live in many bundles (07/16) — `Parent__c` self-lookup retired · product master `anar_PIE_ricla.xlsx` decoded (07/23): `_ARTIP` A=product / Z=BLO rata / C=PACK bundle; the C/Z/BLO/PACK apparatus is **not migrated**; bundle classification = anno-solare→evento (dependent) + tipologia-bundle, rebuilt clean; **"anno solare" (bundles) ≠ "anno accademico" (tickets)**.

## 9. 🔴 Blocking decisions / inputs — chase these before the blueprint freezes

1. ~~**Lead/opty flow review** with Daniela (Elena's rewrite + recorded segment) — the last big unapproved design; postponed AGAIN past July 9, no news as of 07/13 → chase hard. (#19)~~ → ✅ **CONFIRMED in the 07/31 business review**; only configuration items remain (#59). See §10.
2. **Custom bundle demo** — ✅ built and passing in UAT 07/16 on the `BundleComponent__c` junction; accept/reject criterion (product-level stats via spread prices) is met, including one product in two bundles at different spreads. Now needs **showing to Pienissimo** + Andrea's effort estimate. (#13)
3. **Marketing forms + subdomain** answers from Matteo — blocking the whole marketing stream since 06/23. (#14)
4. **DocuSign purchase** closure. (#16)
5. **Anticipay timing** (with Mexal integration vs phase 2) + docs + foreign-VAT rule. (#21)
6. **Quote+contract signature flow** decision (Pienissimo internal). (#27)
7. **Key-users list** (never delivered since kickoff) and **3CX status** (never reported). (#1, #3)
8. **Data model workbook** kickoff: ROMI structure + Pienissimo field lists from Zoho. (#24) ⚠ **Must carry the 24/08 rule that `_ARCOD` is an opaque string** — codes differing by one leading zero are different products, and `Product2.Code__c` is a unique external id. See §13.6.
   8b. 🔴 **`Product2.Evento__c` is wrong against the client's own event list** — no `Happy Team` value although Happy Team is priced and sits in the Academy bundle at qty 2; `Camerieri` truncated; an invented `ND`; and the `Anno_Solare__c` dependency matrix has **no client source at all**. Fix before any product import. (#46, §13.2)
9. Pienissimo inputs still due: quote templates + real client emails (#26), form-links Google Sheet with hidden-source fields (#33), WooCommerce CK/CS keys (#22), dormancy rules (#8), notification-channel choice.
10. Feasibility confirmation: scope achievable by Sept 29 / Oct 31 with the current integration list — ROMI to re-plan and commit. (#4)

---

## 10. Update 2026-08-03 — multi-source sweep

Compiled 2026-08-03 from Slack `#tproj-pienissimo`, Gmail, Google Drive and Fathom, covering five sessions never folded into §1–§9: **07-14** Mexal integration, **07-16** bundle demo + order flow, **07-22** bundle + ticket flow, **07-29** follow-up temi aperti (no minuta circulated), **07-31** business review. Where this section contradicts §1–§9, this section wins.

### 10.1 Timeline — the date is 6 October 2026

Elena has published the same line in every weekly status since 26/06: **go-live 6 October 2026, focus on the WooCommerce + Mexal integrations**, with minor integrations deferred to a second phase. The §1 "Phase 1 by end September / Phase 2 by end October" framing predates that and is superseded — though the Zoho contract still expires **31 October**, so the dual-run window is now ~3 weeks, not a month plus. Elena's own 31/07 note: the go-live date "is starting to stop being good news given the timings." A **closing session is booked for Thursday 6 August, 15:00–17:00** ("Chiusura ultimi punti aperti"), and several client-side answers are due _before_ it.

### 10.2 What got approved

- **Lead/Opportunity flow — CONFIRMED (07/31).** Marketing converts leads into opportunities; tutors handle recalls through automatic tasks and dedicated states; qualified contacts bypass the early stages to speed up negotiation. The single largest unapproved design in the project is now closed. Remaining work is configuration: "qualificato da ricontattare" state, manual quote-creation button, mandatory expiry field at send, automatic alerts on day 2 and at expiry. Marco Montesi owes the preset validity timings per product category and business line.
- **Bundle — APPROVED (07/22–24).** Confirmed with Daniela: **invoicing is per elementary product**, never a lump sum. The bundle name becomes the description carried to Mexal; code and due-date references stay at line level. **Only administration** creates bundles in Salesforce; single products keep being configured in Mexal. Residual: Andrea's effort estimate, plus a real gap — nothing stops administration attaching an article incoherent with the bundle's category (manual attention only today).

### 10.3 Order flow — tranche, contracts, reports

- **"Rate" is renamed "tranche"** (custom object). Tranches are auto-built from **order-line due dates**: lines sharing a due date form one tranche. The full order goes Salesforce → Mexal with the tranche reference travelling **at line level**, not as an object. Mexal updates payment status per line; Salesforce aggregates upward to the tranche — Mexal never writes the tranche directly. At invoicing, **n Mexal invoices → n Salesforce invoices**.
- **Contract auto-generation is keyed to the product code, not the order status** — the Performance Plus contract and its logic (dates, status, total, invoiced, collected, overdue) fire off the product code, exactly as bundles do. "Tipi ordine" (bundle da palco, palco/performance) were floated to separate workflows and reporting.
- **Two standing reports**: _insoluti_ weekly (e.g. Monday) to sales + administration — invoices issued and unpaid with a due date before the check date, production removed from distribution; and _tranche in scadenza_ mailed to administration before month end for the following month. Both permanently available and refreshed, no manual launch.
- **Performance Plus** can originate from a stage bundle or from direct tutor entry. Marco's read — an opinion, not a certainty — is that stage-selling this service is now unlikely given the shift to a tutor-led consultative model; keep it as a supported case anyway.

### 10.4 Tickets & signature — DocuSign reversed

- **Asset generation rule**: every order containing an "evento" product automatically creates a **Campaign** (if absent) plus **one Asset per event article code** — including multi-event bundles and tutor-entered orders. Terminology settled: the **Asset is the record**, the **QR is a value inside it**.
- 🔴 **DocuSign is no longer certain.** On 07/22 Sabatino reported that, per his latest exchange with Daniela, DocuSign may be dropped and the current **paper process kept temporarily** (PDF printed, signed, handed over at check-in). Aurel proposed a middle path: paper signature with the scanned/photographed document uploaded to a **custom Community page**, avoiding the ~**€1.80–2 per document**, but needing human verification since no automated check on a PDF is possible. "Firma in link" was discarded — no legal/GDPR standing. Andrea flagged that some clients won't manage download → sign → re-upload and will arrive with paper regardless. **31/07: Sabatino must find a working solution by 6 August, otherwise prepare the printed-contract procedure.** Elena's ultimatum stands: no news = paper as-is. ⚠ The uncertainty touches **only the signature-collection step** — order/asset creation upstream and QR scanning/access control downstream are unaffected.
- **Credit notes** (upgrade of §2's licensing question into a real flow): administration creates the credit note and links it to **both the order and the order line** — line level matters for partial reversals on multi-event bundles. Credit notes on "evento" products **auto-set the matching Asset to Annullato**. Refunds are normally granted as credit toward future purchases rather than bank transfers, operated by the tutor. Not urgent, but Elena owes a dedicated diagram.

### 10.5 New workstream — WooCommerce checkout links (Salesforce → WooCommerce)

Decided 07/31, specified in `Integrazione_Salesforce_WooCommerce.docx` (Sabatino, 31/07). The tutor generates a checkout URL from the Opportunity that carries the Opportunity id, so the resulting order comes back attributable:

1. **Salesforce** builds `https://<sito>/checkout/?add-to-cart=<woo_product_id>&sf_opp_id=<opportunity_id>` (optionally `quantity[...]` and a `coupon`).
2. **WooCommerce** — a must-use plugin (`wp-content/mu-plugins/sf-opportunity-tracker.php`, deliberately _not_ `functions.php`) captures `sf_opp_id` into session + a 30-day cookie, writes it on order creation as meta `_sf_opportunity_id`, and re-exposes it through the REST API as `sf_opportunity_id`.
3. **Salesforce** reads `/wp-json/wc/v3/orders/{id}` with Consumer Key/Secret, matches the Opportunity by id, writes `WooCommerce_Order_Id__c`, Amount and CloseDate, and moves the stage to **Closed Won**, firing downstream automation.

Build list — Salesforce: `WooCommerce_Product_Id__c` on Product (populated per catalogue item), `WooCommerce_Order_Id__c` on Opportunity, the link-generator button with product/quantity pickers (Aurel), the order-read logic. Pienissimo: install the mu-plugin, generate REST credentials, hand them over, build the pre-filled email template (Sabatino), schedule the joint technical call (Sabatino), then end-to-end test (Aurel + Sabatino).

🔴 **Three decisions still open**: pull job vs WooCommerce webhook (webhook recommended for production); price source of truth — WooCommerce listino vs Salesforce negotiated prices via **dynamic one-shot coupons**; and whether the id travels in clear (guessable) or as a signed token.

### 10.6 Mexal — unblocked

**WEBAPI credentials were delivered on 15/07** by Mirko Merendi (Kreosoft): `https://services.passepartout.cloud/`, dominio **PIENISSIMO**, azienda **PIE**, dedicated user, password sent separately to Fabrizio. Mechanics agreed 07/14:

| Topic           | Decision                                                                                                             |
| --------------- | -------------------------------------------------------------------------------------------------------------------- |
| Source of truth | **Salesforce** for new records; **Mexal** for administrative edits; periodic realignment                             |
| Permissions     | Edit rights on the synced client registry restricted to admin users — sales must not alter it post-sync              |
| Sync strategy   | Scheduled **nightly GETs**, delta-only, keyed on "data ultima modifica"                                              |
| Invoices        | ~**2,300 invoices in 2025** → date filters + pagination, against 6 MB sync / 12 MB async callout limits              |
| Orders          | No repeated GETs (the id returns on create); instead a **"rinvio ordine" button** for errors/changes                 |
| Products        | Configured in Mexal; an **on-demand import button** (not only nightly) so new items are sellable immediately         |
| Agents          | Live in Mexal as **suppliers**, filtered by mastro — codes start with **610** for azienda "P"                        |
| Test env        | **None exists** → a test company must be created to validate POSTs and dummy orders without touching real accounting |
| Registry        | Add a field referencing the previous client code/VAT so **ragione-sociale changes** don't break history              |

Also fixed on 07/14: **zero-euro orders** (free tickets) stay in the CRM to fire the ticket-generation flow and are **not** pushed to Mexal; VAT is the primary client key and Anticipay currently validates only at order import, which today blocks Zoho→Mexal transfers on bad data.

### 10.7 Analytics — Data 360 ingestion path

Internal answer from Davide Bocchieri (29/06), not yet designed or shown to the client: the as-is chain (Mexal nightly CSV → FTP on Zoho Work Drive → Zoho Data Prep ETL → data warehouse → Zoho Analytics) maps onto Salesforce as **Mexal → Google Cloud Storage → Data 360 ingestion → transform → standard reports/dashboards over Data 360 objects** — external data usable for reporting without loading everything as CRM records. Licensing is covered via MC Growth. Transformation capability inside Data 360 has limits worth testing before committing.

### 10.8 🔴 Commercial dispute — out-of-contract scope

Elena has flagged the same red item in three consecutive weekly statuses: **GLS, Teachable and the Salesforce↔Zoho integration** (Pienissimo Pro orders belonging to **Pienissimo Software Srl — a different legal entity from this project's client**) were never discussed pre-sale, **do not appear in the contract**, and should be scoped and priced as a separate evolutiva, as agreed with Andrea G. Sabatino and Fabrizio pushed back, insisting Zoho was discussed, and escalated to Daniela. ROMI owes a quotation for the Salesforce↔Zoho build should it stay in scope. **Still unresolved on 03/08** — and it directly contradicts §4's integration map, which lists GLS and Teachable as ordinary phase-2 deliverables.

### 10.9 Other open threads from the sweep

- **Marketing partially unblocked**: the subdomain was created and the requested information delivered; ROMI-side ownership passed to **Fabrizio Mastracci**. Still waiting on Pienissimo's review of the **100+ form** Excel.
- **Data model workbook**: Sabatino committed on 07/22 to complete it within the following week — `Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx` in the `[Pienissimo] Fase Progettuale` Drive folder. Pienissimo owes the Zoho field lists for Account, Referente, Opportunity, Offerta, Ordine, Articoli.
- **Order-acceptance and contract procedure**: Marco Montesi + Elisa Migliano must settle it with Daniela and tell Elena **before Thursday 6 August**.
- **Accept/reject buttons inside the quote email** driving the Preventivo/Opportunity status: ROMI to assess feasibility and the risk of external clients mutating CRM data.
- **Event dates**: "Camerieri Venditori" 3 November or postponed to April; **Pienissimo Live 24–26 November** ticket-delivery lead time (60 days as-is — can it be pushed?).
- **Bundle code → WooCommerce is communicated manually, verbally**, by design, to keep flexibility close to events.

---

## 11. Update 2026-08-06 — closing session on open points

Compiled from the **06/08 "Chiusura ultimi punti aperti"** session (2h30m, Google Meet + Gemini notes), surfaced 07/08 from the Slack `#tproj-pienissimo` canvas. This is the session §10.1 anticipated but could not report on. **Where this section contradicts §1–§10, this section wins.** It is the most decision-dense meeting since 07/22 and the last substantive working session before the Italian August break — everyone returns ~**24–26 August**.

⚠ Source caveats: the Gemini auto-summary contains at least one outright error (it claims assets stay _Disponibile_ until use — Sabatino reversed himself 40 seconds later and kept _Assegnato_), and it credits admin/technical statements loosely — the operational authority throughout is **Elisa Migliano**, who runs the event infopoint herself and made the decisive corrections on invoicing and matching. Note also that **Fabrizio Mastracci, though on the invite, disconnected at 00:01:30** and contributed nothing. This section follows the transcript. **Return dates agreed in session:** Elisa 17 Aug · Aurel 24 Aug · Sabatino 25 Aug (asks to be booked from the 26th) · Fabrizio Paganelli ~31 Aug · Andrea Parmeggiani third week of August. Working window: **26–29 August**. Full detail: [`results/2026-08-06-chiusura-punti-aperti.md`](results/2026-08-06-chiusura-punti-aperti.md).

### 11.1 Signature — DocuSign is settled, split in two

§10.4's 🔴 "DocuSign may be dropped" is **resolved**, by splitting the question:

- ✅ **Quotes / contracts → DocuSign is IN.** Flow: email with a **link, not buttons** → landing page showing preventivo + contratto + condizioni generali (**a single PDF**) → client clicks **Accetto / Rifiuto** → reject sets the quote _Rifiutato_; accept sends the documents **via DocuSign** → signature flips the quote to _Accettato_ → **the order is generated automatically**. The quote goes out while the opportunity is _in trattativa_, and **the 5-day validity starts there**; once it lapses the opportunity sits in _in attesa accettazione_ and **the same landing page still works** — the client can accept weeks later and the flow proceeds unchanged. ROMI's reason for rejecting Elisa's in-email buttons: _"noi non abbiamo controllo su quello che mandiamo a livello di email, dobbiamo per forza rimanere sul CRM."_
- ✅ **Ticket / participant documentation → DocuSign is OUT.** Elena: _"la firma digitale c'è solo per i preventivi."_ Participants sign **on paper** at check-in. The planned "mancata firma digitale" edge case was struck from the design.

This also **kills the §10.9 accept/reject-buttons-in-email idea** — the landing page replaces it, and with it the risk of external clients mutating CRM data directly.

### 11.2 Order and opportunity state models

- ✅ **Order states: Ordinato → Fatturato → Incassato.** The old **"Chiuso acquisito" is deleted** (Fabrizio Paganelli: _"non serve più"_). 🟡 A fourth state **_Perso_**, tied to credit notes, was floated and left undecided (_"Non lo so come funzionerà"_), and Elena flagged the set as thin: _"mi sembrano troppo pochi"_.
- ✅ **Opportunity goes Closed Won only when the order reaches _Incassato_** — payment closes the opportunity, not signature. This binds §2's "closed-won driven by payment" to an explicit state.
- ✅ **Performance Plus opportunities must be typed by the tutor at creation** — **attivazione** vs **rinnovo**, mandatory and manual, because contract generation depends on it.
- ✅ **Service start/end date belongs to the Strategist, not the contract.** Signature ≠ service start; clients queue days-to-weeks (Marco Montesi). The department head enters the real start date at kick-off. ROMI to build a **banner/alert or email when the start-date field is empty**.

### 11.3 Tickets and assets — the state machine, final as of 06/08 and queried again on 19/08 and 20/08

| State                           | Trigger                                                       |
| ------------------------------- | ------------------------------------------------------------- |
| **Ordinato**                    | The order lands (e.g. from WooCommerce); the asset is created |
| **Disponibile**                 | The invoice carrying that order line is **collected in full** |
| **Assegnato**                   | Documentation + QR code emailed to the named participant      |
| **Utilizzato / Non utilizzato** | Set by the QR scan at the event                               |

_Assegnato_ was nearly dropped once signature left the ticket flow; **Sabatino kept it for reporting** — _"ci fa statistica per capire quante persone hanno il biglietto nelle mani."_

🔴 **Queried 19/08, and not yet resolved.** A new `Flusso Biglietti.drawio` appeared in `[Pienissimo] Fase Progettuale` on 19 August, drawn by Elena Spini. It draws the status row with **seven boxes**, adding **`Rinuncia`** — annotated _"avviene nella comunicazione dei partecipanti o accetta o rinuncia"_ — as a box distinct from `Annullato`. Until 19/08 the record treated _rinuncia_ as loose prose for `Annullato`; on this drawing they are two different moments, the first when the referent declines at the participant-list request, the second on a name change or credit note. The same file adds an admin-only **`Aggiornamento Incasso`** button that moves an asset **backwards**, `Disponibile → Ordinato`, when an amount was booked against the wrong tranche (#91). ⚠ **No minute, recording or message accompanies the drawing**, so nothing here is agreed — the picklist must not be reconfigured on it. See #74, #91.

🔴 **Escalated 20/08 — it is in the master now.** `Flows & Objects.drawio` was re-decoded on 20 August at its 15:36 UTC version and the seven-box row **has been folded into the master file**, on the `Flusso Biglietti` page, with the same annotation — as has the `Aggiornamento Incasso` button. `Rinuncia` is therefore no longer confined to a side drawing: it now sits in **the file the requirement register is validated against**. The register was still not changed, because the edit remains unminuted, but the gap between the register and its own source document is now real. A **new question** was drawn beside the button the same day: _"Scadenziario MEXAL - Check con Andrea. Capire se da fattura NON pagata (Scadenziario) è possibile aggiornare ASSET allo stato prima"_ — i.e. whether an **unpaid** Mexal invoice could drive the same reversal automatically, which would make it an integration behaviour rather than a button (#92). There is a forum for it: the client-facing **Mexal review of Wed 26/08**. ⚠ Elisa Migliano's asset meeting, called for 20/08, left **no recording, no canvas entry and no message**; whether it ran is unrecorded. See #74, #91, #92.

⚠ **The availability rule in §10 was ambiguous; the agreed wording is "fattura pagata a livello di rata/tranche".** Elisa: _"quel biglietto è disponibile quando la fattura con la quale l'ho fatturato deve essere integralmente pagata, tutta pagata."_ Partial payment releases **nothing**. Order lines are grouped into tranches by **due date** (events 1+2 → tranche 1 at 31 Jan, events 3+4 → tranche 2 at 28 Feb, …); each tranche is invoiced separately, and when _that_ invoice is fully collected _those_ tickets go Disponibile. ⚠ Critically, **tranche composition follows customer payment convenience, not events** — _"ci sono tot rate che vengono suddivise sulla base della gestione del cliente, non sulla base dell'evento"_ — so an event's ticket can sit behind unrelated items in the same invoice.

**The invoice must arrive in Salesforce, and the match is on order-line number — not date, not product.** Two candidate keys were tested and killed in session, both by Elisa:

- **By date** — fails because the tranche date is the _presumed collection date_ and Pienissimo invoices **in advance** (tranches due 31 Jan are invoiced in early January).
- **By product** — fails because _"un tutor può mettere anche lo stesso codice due volte nello stesso ordine"_.

The Mexal invoice carries **cliente, numero documento, riferimento numero d'ordine, codice articolo and numero di riga d'ordine**; the match is on **numero di riga d'ordine**, on Elisa's principle: _"è bene lavorare su elementi che sono nascosti ai tutor."_ Aurel suggested a "lines paid" signal would suffice without the invoice; **Elena overruled** — the invoice is required for the agreed reporting logic.

Also decided:

- ✅ **A Mexal event product auto-creates the matching Salesforce Campaign** on the nightly sync, so attendance indexes against the campaign at scan time.
- ✅ **Ticket type becomes a picklist on the product record** (Gold / Silver / Executive …). Precise position: each type **already has its own product code** (Camerieri Venditori Silver ≠ Gold), but a code is not reliably filterable, so Elisa agreed to add the field — _"mettiamo un campo in anagrafica, un menù a tendina tipo biglietto"_. Fabrizio Paganelli additionally adds an **event flag** (distinct from the existing bundle-eligibility flags).
- ✅ **A multi-event bundle auto-creates one asset per event.**
- ✅ **Participant data collection**: the buyer — always the company owner who paid, and initial holder of **all** the tickets — receives a landing page with one row per purchased ticket and enters **name, surname, email and phone** per participant → Salesforce links contact to asset, **creates the contact if absent**, adds a **Campaign Member**. Each participant then receives their own QR document and prints it. ⚠ ROMI's assumed "choose your event" step is **deleted** — Sabatino: _"No, non scelgono mai loro. Noi gli diciamo cosa devono fare."_
- ✅ **Two distinct edge-case paths — do not conflate them.** _Name change **before** the event_: a button on the account lists that account's assets; cancel the old name, enter the new one, **a new QR is generated** (the document prints participant name and event above the code) and updated documentation is emailed **to the new person's address**. _Substitution or missing documents **at** check-in_: staff verify ticket + order + payment at the infopoint, the attendee **re-signs the paper form**, staff key the data in — **no QR is issued in this path**. The commonest case is not substitution but people who never printed or never received the email; Elisa named a live root cause — clients who had **unsubscribed from marketing email** stopped receiving tickets, _"un cane che si mordeva la coda"_.
- 🔴 **The manual path has an unclosed tracking gap**: a hand-keyed substitute may never be recorded as Campaign Member with the ticket marked used. Elena raised it; Elisa waved it off on staff competence. **Campaign Member handling for manual entries is still undesigned** — and attendance/no-show analytics is a stated project goal.
- ✅ **Credit notes**: a button at **order level** selects the order line(s) to reverse, partially or fully; for _evento_ products it also cancels the linked **asset**.

### 11.4 Bundles — duplication removed

✅ **Bundles are created only in Salesforce, only by administration**; single products keep coming from Mexal. The previously-planned duplication for stage sales vs tutor recall is gone — that distinction now rides on the **Opportunity typing**. ✅ Confirmed again: **no per-bundle composition validation**. Precise scope — two product-level flags **do** exist (bundle-eligible, bundle-only, confirmed by Aurel when Fabrizio Paganelli challenged the point); what does **not** exist is validation that an eligible product belongs in _this particular_ bundle. The §10.2 gap is therefore **accepted, not fixed**.

### 11.5 WooCommerce — webhooks, and a build start date

- ✅ **Integration is via Webhooks**, decided against polling. This closes the first of §10.5's three open decisions.
- ✅ **"Crea link" button on Opportunity for the "Recall tutor" opportunity type**, generating the checkout link carrying the Salesforce Opportunity id, emailed to the client.
- 📅 Credential exchange and payload testing start **26 August** (Sabatino + Aurel).
- 🔴 §10.5's other two decisions — **price source of truth** (WooCommerce listino vs Salesforce negotiated prices via one-shot coupons) and **clear-text vs signed opportunity id** — were **not** discussed and remain open.

### 11.6 Data quality and migration

- ✅ **VAT validation moves into Salesforce and runs at the FIRST order of an account**, not at account creation. The as-is runs pre-invoicing in Mexal: read the order's VAT, check the Mexal registry, and if absent call a **business-information service** returning ragione sociale, address, PEC and legal representative — a registry _"corretta al 99,5%"_. **Elisa proposed relocating the call to Salesforce at order generation**, writing the official data straight into Salesforce _"per cui quando Salesforce passa i dati a Mexal siamo sicuri che i dati sono già puliti"_; Elena: _"Questo mi piace molto."_ Same rule for WooCommerce orders. Elisa's cost argument: free events draw 3,000–6,000 registrants (6,000 at Food Marketing last year) of whom perhaps 250 buy. An already-checked account carries a **"consolidato" flag** and is never re-checked; failures send a **notification email to an administration address Pienissimo will supply**; a **manual re-check button** sits on both order and account (account-side manual, same API). Today a failed VAT blocks order generation in Mexal and admin phone the client to fix it by hand. ⚠ The provider is **not named unambiguously** — the audio garbles it; prior meetings say **Anticipay**, **CreditSafe** also appears. Elisa confirmed the service is **already live at Pienissimo** and she can hand over the references. Technical call with **Andrea Parmeggiani** (`a.parmeggiani@pienissimo.pro`), third week of August.
- ✅ **Partita IVA becomes mandatory on the live-stream lead forms** — accepted knowing free-event registrants will enter junk ("00"), corrected at payment time. The order-time validation above is what actually catches it.
- ✅ **Migration volumes corrected**: ~**17,000** records in the Zoho client registry, of which only ~**8,500** are real clients with a registered ragione sociale; the rest is deleted before import. The operative cleanup filter is the **Mexal client code** — _"andremo a caricare solo i clienti che hanno il codice cliente Mexal."_ _(This supersedes §1's "~6,000 leads/accounts vs ~7,500 paying clients".)_
- ✅ **Field mapping keeps the original Zoho labels** in the shared workbook. The client module holds ~**150 fields of which about a quarter are used**; Pienissimo lists only what is worth moving, and Aurel maps at insert time after a **joint field-by-field call**. Mapping was ~95% done in session, promised for the next day. 🟡 **Lead and Referente/Contatti are the exception** — Elisa declined to do them alone (_"non sono sufficientemente competente"_); to be done three-handed with Sabatino and Marco. 🟡 **Asset fields deliberately deferred** until the flow review: today Pienissimo hold **evento/edizione, anno accademico, anno di competenza** (the last drives the ticket "magazzino" movement).
- 📅 Andrea Di Cicco sends a file of open **Mexal field-mapping questions**; Elisa answers, escalating to Kreosoft if needed.

### 11.7 Marketing and leads

- ✅ **Event communication funnel automates at 60 days before the event** (30–60 day window, to cut no-shows), driven by account tags + event date, auto-sending the participant-data link. Multi-event bundles get **per-event** communications, each on its own countdown — not all at once.
- ✅ **Trigger design**: a **nightly job** reading the Campaign start date and selecting accounts holding ≥1 ticket for that event at start-date − 60 days. The funnel keys off a **tag** applied in the CRM to accounts that have paid and hold tickets.
- ✅ **The per-participant QR email is sent from Salesforce, not marketing**; only the opening funnel communication is marketing-side. 🟡 **Who hosts the participant-data landing page is undecided** (Salesforce community vs marketing platform).
- 📅 Dedicated marketing-funnel meeting after **17 August** with **Rebecca Marmo** (`rebecca.m@pienissimo.com`, owns the ticket funnels), Marco and Matteo. Rebecca joins **all** flow/field/ticket calls from now on. Sabatino wants **both** ready-made funnels pointed at tickets. ➖ The 100+ marketing-form review was **deprioritised by the client** in session.
- 🟡 **Lead routing**: today Zoho round-robins one lead per tutor and Marco says it no longer works. Agreed direction is **queues by service type and/or geography** with automatic assignment. ⚠ **Load-based automatic assignment is not available on their licences** (a Case-oriented capability), so the practical answer is **rules + mass transfer** — select many leads, reassign in two clicks. **Marco owes the concrete desiderata** once he has seen the real platform.

### 11.8 🔴 Programme and the commercial dispute

- ✅ **Daniela approved the Phase 1 / Phase 2 timeline** as sent — Sabatino: _"l'ha vista tutta, mi ha dato l'ok, non mi ha chiesto niente."_
- 🔴 **But she was never told the scope dispute exists.** Sabatino, 02:24:17: _"Tutto questo è pienissimo pro, però **Daniela non sapeva questa informazione qui**, quindi tocca rifare un altro giro, ma questo giro me lo faccio dopo le ferie."_ Her approval therefore cannot be read as scope or budget acceptance, and the correcting conversation is deferred to after the holidays. The §10.8 dispute — **GLS, Teachable and the Zoho integration for Pienissimo Pro orders (Pienissimo Software Srl)** — still needs _"valutazione economica contrattuale con Daniela per definire se il lavoro rientra in una fase aggiuntiva quotata o potrà essere gestita internamente da Pienissimo."_ Elena raised it; **Sabatino admitted he had not read the minuta** flagging it (_"Io non l'ho nemmeno letto quello, ho preso direttamente il link"_). Fourth consecutive meeting/status carrying this item. **Risk: the timeline approval gets cited later as scope acceptance.** No Phase 2 cost/effort estimate exists — explicitly deferred to "on return from holidays".
- 🔴 **Schedule risk is now concentrated in one week.** Sabatino, Aurel and Andrea Parmeggiani are out until ~24–26 August. The WooCommerce webhook build, the VAT-service integration, the Zoho mapping, the asset-flow review and the marketing funnels **all** start in the final week of August — against a **6 October go-live** and a **31 October Zoho expiry**. Elena in-session: _"a voi scade il contratto di Zoho."_
- 🟡 **The asset/ticket flow still needs a dedicated review** — both Elisa and Elena said it is not fully specified. Meeting after 17 August, Rebecca included. Sabatino's own prediction: _"vedrai che anche dopo lo sviluppo esce qualcosa che tocca cambiare."_

---

## 12. Update 2026-08-14 — document sweep, no meeting

Compiled from a full sweep of Gmail (67 threads back to April), the whole `[Pienissimo] Fase Progettuale` Drive folder, Slack and Fathom. **No meeting took place** — everything here comes from documents that already existed and had never been read. **Where this section contradicts §1–§11, this section wins.**

### 12.1 🔴 Development on Fase 1 ends 10 September, not 6 October

`Pienissimo_Project Plan.pptx` (Elena Spini, 10 July, in the Drive project folder) sets the full milestone chain, and had never been opened:

| Date             | Milestone                                     |
| ---------------- | --------------------------------------------- |
| **10 September** | **Fine sviluppi Fase 1**                      |
| 25 September     | Approvazione Soluzione 1                      |
| 6 October        | **GO-LIVE Fase 1**                            |
| 24 October       | Fine sviluppi Fase 2                          |
| 31 October       | Approvazione Soluzione 2 · Zoho expires       |
| **9 November**   | **GO-LIVE Fase 2**, then post go-live support |

The 6 October everyone quotes is **go-live**; UAT, fine tuning, bug fixing, training and the ~1 September data import all sit before it. With the team back 24–26 August that is **about two weeks of build**. **The 9 November Fase 2 go-live appears in no meeting record, tracker or recap.** ⚠ The plan is dated 10 July and may have been revised — confirm with Elena before planning against it.

### 12.2 The phase split is in ROMI's own plan, and it cuts both ways

The same deck lists **Fase 1**: WooCommerce → SFDC · Mexal ⇆ SFDC · Anticipay (ex CreditSafe) → SFDC. **Fase 2**: GLS → SFDC · Teachable → SFDC · Ordini Pienissimo Pro → Zoho Pienissimo Software SRL.

It supports ROMI's "separate phase" position. It does **not** support "outside the project" — the three appear in ROMI's own plan as scope, and that plan is what Sabatino says Daniela approved. See §12.3.

### 12.3 The client put the three disputed items in writing on 11 June

`Salesforce - Requisiti e Domande per Elena (16-06-2026).pdf` — Pienissimo's own requirements paper, seven pages, absent from every tracker until now. §2.9 lists **GLS** and **Teachball** under _"Integrazioni richieste"_; §2.7 describes **Pienissimo Pro** with _"instradamento diretto alla Software"_; **question 10** asks about GLS and Teachable, **question 11** about routing Pienissimo Pro to the software team.

⚠ **This does not decide the dispute and must not be presented as if it does.** 11 June is _after_ the 27 May kickoff, so it says nothing about the pre-sale conversation ROMI's position rests on. It does explain why Sabatino and Fabrizio are confident, and it means the argument cannot be won by asserting the topics never came up. The deciding question is narrower: **were they in the contract.** The pre-sale record is not in Aurel's mailbox — his earliest Pienissimo mail is 24 June, a month after kickoff.

The same document is the origin of **"rinuncia al servizio"** (an internal open point owned by Fabrizio Paganelli) and of a still-unanswered question on whether to introduce a **Prospect** state (#90).

### 12.4 🔴 The ticket-release key is missing from the Mexal mapping

`Integrazioni pienissimo.xlsx` — Kreosoft's completed field mapping, answered by Mirko Merendi on 11 August — defines **Get Fatture** as `numero_fattura`, `data_fattura`, `codice_cliente`, `codice_agente`, `note_testata`, `codice_prodotto`, `quantita`, `prezzo_unitario`, `sconto`, `totale_riga`, `aliquota_iva`, `codice_pagamento`, **`numero_ordine`**.

**There is no order _line_ number.** §11 fixed ticket availability on _numero di riga d'ordine_ because Elisa killed by-date and by-product — the latter precisely because a tutor can put the same code twice on one order. The order number alone cannot separate those lines.

The data exists at source (the per-document call returns the lines), so this is a **mapping gap, not a Mexal limitation**. **Raise it at the 27 August call.** Until then ticket release is unimplementable as specified (#75).

Other mapping facts now known: three calls nobody had recorded — **Condizioni pagamento** (p.122, daily), **destinazioni / Indirizzi-spedizione** (p.180–188, _"da verificare"_), **ordini** (p.146); `totale_riga` is **not returned** and must be computed as (qta × prezzo) − sconto; `Get Scoperto` carries `stato_pagamento` (`P` = paid, empty = unpaid) and is the better payment-state source; agents filter on code prefix **610**; order **serie 1 in production, serie 10 for tests** — a test lane inside the production company, not the test company that was asked for.

### 12.5 State machines — the register was right; two gaps remain

`Flows & Objects.drawio` was decoded in full. **The requirement register's extracted state machines match the current diagram** — six asset states including `Annullato`, the tranche states, the `preventivo scaduto → In attesa di accettazione` rename flagged as a retired label, and `CHIUSO/ACQUISITO` documented as a deliberate Order/Tranche **name collision**. No re-extraction was needed.

Two real gaps were found:

- 🔴 **`order.states` still reads `[CREATO, CHIUSO/ACQUISITO]`** — the diagram's values, not §11.2's `Ordinato → Fatturato → Incassato`. **Nobody has said whether `Incassato` is `CHIUSO/ACQUISITO` renamed or a different milestone**, and the tranche rule still depends on the old name. Now marked `status: conflict` in the register, owner Elena Spini. **Must close before Order or Tranche is configured** (#69, #50). **⚠ Updated 20/08 — the diagram moved, the question did not close.** `Flows & Objects.drawio` now **draws** `Ordinato · Fatturato · Incasato` (one `s`, as drawn) on the LEAD-OPTY page as a new `ORDINE` block and again on the Ordini page, with the rule _"Status Order == Incassato >> Aggiornamento dell'Opty in **Chiusa Vinta**"_ — confirming that the Opportunity closes on payment, not signature. **But it did not strike the old values**: `Order Status SF == CHIUSO/ACQUISITO` and `== CREATO` remain on the Ordini page and the tranche rule still sends the first tranche to `CHIUSO/ACQUISITO`. The source now carries **both vocabularies at once**, which removes the excuse that the drawing simply predated the decision — and still does not say whether the two are the same milestone. Only three states are drawn; **no `Perso`** (#85). The register was deliberately left unchanged: the edit is unminuted.
- ✅ **`opportunity_types` was missing `Plus + Attivazione o Rinnovo`** — added.

⚠ **Naming:** the asset cancellation state is **`Annullato`** in both the diagram and the register. Elena's `PIENISSIMO - Project Status.docx` and the client's June document both call it _"rinuncia al servizio"_. **Build `Annullato`**; the prose is the outlier.

📌 The register recorded both diagrams as modified **31 July**; Drive says **6 August** (DGM-2) and **4 August** (DGM-1). Provenance dates corrected in the register, `README.md`, `REQUIREMENTS.md` and `REQUISITI.it.md`. The extracted content was verified against the current versions and did not change.

### 12.6 The restart calendar is fixed

**19 Aug** marketing funnels, both now ticket-focused · **20 Aug** asset flow, requested by Elisa because _"ci sono delle cose di cui non abbiamo mai parlato"_ · **25 Aug** Anticipay with Andrea Parmeggiani · **27 Aug** WooCommerce webhooks and credential exchange.

⚠ **Two of the four are design discovery, not build.** Both internal ROMI follow-ups (10 and 17 August) were cancelled on 7 August, so there is no checkpoint before the 19th.

### 12.7 People — the April org chart resolves four gaps and adds one

`Organigrammi Pienissimo (EV - SW) (APRILE 26).pdf`: **Matteo = Matteo Distaso, Responsabile Marketing** — holder of the #14 blocker, surname unknown until now · **Sabatino Rinaldi = Growth Manager** · **Fabrizio Paganelli = Responsabile Amministrazione**, with Elisa Migliano in Accounting under him · **Rebecca Marmo = Content Creator**, not a decision-maker although two designs are parked pending her call.

New: **G. Lanzetti is CEO of both Pienissimo Srl and Pienissimo Software Srl**, with Daniela Morgese General Executive of both — and he appears in no meeting record. ⚠ **Andrea Parmeggiani works for Pienissimo Software Srl**, the entity at the centre of the scope dispute, while being the named technical contact for a Fase 1 integration.

### 12.8 Other items raised

- **#88 NEW** — the **Zoho import template is a ROMI deliverable** with no prior tracker row, and the only migration item ROMI owns. Gates the ~1 September import.
- **#89 NEW** — `BigliettoPdfQueueable` fails at runtime: _"Callout not allowed from this future method"_ (sandbox mail, 17 July). This is the mechanism behind "17 envelopes sent, 0 QR codes generated" in the 03/08 org check. The class is in the org but not in `force-app/`.
- **#90 NEW** — whether to introduce a **Prospect** state, open since 11 June.
- **#49** — the WooCommerce spec was read in full. It closes with **five** points to agree; the trackers carried two. Newly recorded: the **URL parameter name** and the **ID format**. Coupons are **excluded from phase 1**, which settles the price-source question in favour of the WooCommerce listino.

### 12.9 ⚠ Data hygiene

Three project artifacts use **real customer data** as worked examples: the design diagram (`SO_Ordine Nr. SO-72216 … DUOMO 2.0 SRL`), the Mexal mapping workbook (a full client registry record with VAT, address, phone, email and PEC), and the contents of `01 Documenti forniti dal cliente/Documenti inviati ai clienti/`. None of those values may enter `notes/`, these recaps, or `site/`.

---

## 13. Update 2026-08-24 — the `Prodotti e Bundle` workbook, read at last

**Source:** `Prodotti e Bundle.xlsx`, Fabrizio Paganelli → Elena Spini, 2026-08-07 12:17 CEST, forwarded 2026-08-18, **opened 2026-08-24**. A copy now lives in the repository root beside `anar_PIE_ricla.xlsx`. Decode: [notes/The Prodotti e Bundle workbook.md](../notes/The%20Prodotti%20e%20Bundle%20workbook.md). ⚠ **It carries real list prices — private repo only. Never into `notes/`, these recaps, or `site/`.**

No meeting produced this section. It is a client document that answered four questions and was not read for seventeen days.

### 13.1 The prices arrived — #87 resolved, #42 not

`Lista Prodotti` holds **29 articles across 9 events, with `Prezzo Listino` populated on every row** — the client's own registry export. That closes **#87**.

It does **not** close **#42**: UAT still holds the `[PLACEHOLDER …]` numbers. The input arrived, the load has not happened, and until it does every price-bearing output stays internal.

⚠ **Coverage is partial and it bites the demo.** There is **no bundle price anywhere** — `Esempio di Bundle` shows composition only, and `PACK-93` carries no price. So a bundle still cannot be demoed at a number Pienissimo would recognise, and **#13 stays short of what it needs**.

### 13.2 🔴 The event list is eleven events, and the built picklist is wrong

`Lista Eventi` is **11 events in 4 types**, against the 7-event seed the register has carried since 23/07. It also carries a `tipologia evento` column nobody asked for and no field exists for: `a pagamento` (7), `a pagamento/gratuito` (Food Marketing Festival — attendable both ways), `gratuito` (Sold Out, Tour), `annullato` (**Golden Numbers**), `in fase di ridefinizione` (**Pienissimo Intensive**).

**Golden Numbers and Pienissimo Intensive appear nowhere else in this project's entire record.** Neither has articles, consistent with their state. Whether either belongs in the picklist is undecided.

🔴 **"Happy Team sells nothing" is a misreading, and it put a hole in the build.** The 23/07 transcript says _"c'è Happy Team, ma durante l'Happy Team non vendiamo niente"_ — **we don't sell _during_ Happy Team**. It was recorded as "Happy Team has nothing to sell". The registry disagrees: `CS-00154 HAPPY TEAM` is priced, has a complimentary twin, and is **a component of the Academy bundle at quantity 2**.

`Product2.Evento__c` is a **restricted** picklist and has **no `Happy Team` value**. A Happy Team article therefore cannot be classified, and the asset it generates has no event. Two further built values do not match the client's names — `Camerieri` (truncated from _Camerieri Venditori_) and `Odb Live` — plus an invented `ND` with no counterpart in the client's list. Values are supposed to be re-created clean from Fabrizio's lists, so his spelling governs.

⚠ **The `Anno_Solare__c` → `Evento__c` dependency matrix has no client source.** It is already built with a specific mapping — FMF on 2026+2028, Mastery on 2026+2027, Pienissimo Live on 2026 only. **The workbook has no year column at all**; the only year in it is the literal `2026` inside the six Tour article names. The controlling half of the mechanism #46 specifies is ROMI guesswork. Ask Fabrizio which events run in which calendar years.

### 13.3 Tier vocabulary settled — `Silver` and `Dinamond` both die

The registry's real tiers are **`EXECUTIVE`, `GOLD`, `DIAMOND`**. Food Marketing Festival carries all three; Camerieri Venditori carries `EXECUTIVE` alone; the other seven selling events carry none.

So both contested values are wrong. **`Dinamond` is `Diamond` misspelt** — the unminuted 20/08 diagram edit was a typo, not a new tier. **`Silver` exists nowhere in the registry**, and the minuted 06/08 line _"camerieri venditori Silver ha un codice diverso da camerieri venditori gold"_ names two tiers for an event that has neither. The example was illustrative and was read as literal.

⚠ **Tier is not a uniform attribute.** Seven of nine selling events have none, and only one event has more than one. A three-value restricted picklist on every product would be mostly blank and would invite an admin to invent a tier.

**#76 stays open, because the field does not exist.** `Lista Prodotti` has four columns — `LIVELLO_6`, `_ARCOD`, `Articolo`, `Prezzo Listino`. No ticket type, no event flag. Tier is still readable only by parsing the article name, which is the exact practice #76 and #47 exist to end.

**The build is ahead of the record again:** `Product2.Genera_Biglietto__c` and `Solo_Bundle__c` already exist in `force-app`, with nothing upstream to populate them.

### 13.4 A bundle is two levels deep, and the junction is flat

`Esempio di Bundle` is the first whole bundle the client has ever shown:

```
PACK-93   ACADEMY 2026 - UN ANNO CON PIENISSIMO (NUOVI)
  BLO-0299  BLOCCO I    → 2 articles, qty 1 each
  BLO-0300  BLOCCO II   → 2 articles, qty 2 each
  BLO-0301  BLOCCO III  → 1 article,  qty 2
  BLO-0302  BLOCCO IV   → 1 article,  qty 2
  BLO-0303  BLOCCO V    → 1 article,  qty 2
```

The five `BLO-` rows are **filled green in the source file** — the client formatted them as the grouping level deliberately. This confirms the 23/07 decode of `anar_PIE_ricla.xlsx` (`_ARTIP` **A** = product, **Z** = `BLO-`, **C** = `PACK-`) from an independent document for the first time.

⚠ **ROMI decided on 23/07 not to migrate the C/Z/BLO/PACK apparatus.** The client's 07/08 deliverable describes its target bundle model **in that same apparatus**, two weeks later.

**The middle level is the tranche — the sheet's own headings say _"i componenti delle tranche"_.** That gives **#50** a problem the register does not currently see: this grouping exists **in the catalogue, before any order**, with its own article code, whereas #50 derives a tranche from **order-line due dates after the sale**. Two things, one name. **Decide which before building `Tranche__c`** — it sets whether the object is created at import from `BLO-` codes or at order time from due dates.

**`BundleComponent__c` is a flat junction** (bundle → article, with a per-bundle `Spread_Price__c`). It cannot currently express `PACK-93 → BLO-0300 → CS-00003` at all. Either the blocco collapses into a field on the junction or it becomes a record. Undecided.

**Quantity is per blocco, not per bundle.** This one bundle yields **twelve tickets across seven articles**. Any asset-generation rule assuming one asset per component line is wrong (#53).

### 13.5 🆕 #93 — the client wants bundle components to carry their price

The sheet draws `PACK-93` **twice**, and the two headings are the whole request: `BUNDLE COME SONO ADESSO` _(i componenti delle tranche sono articoli omaggio)_ versus `BUNDLE COME LO VORREMMO` _(… articoli non omaggio)_. Same bundle, same five blocchi, same quantities — only the component codes change, each `OMAGGIO` swapped for its priced twin.

**One does not swap:** `CS-00002 SOLD OUT OMAGGIO` stays complimentary in both, consistent with Sold Out being an `Evento gratuito` with no priced article at all. So the rule is not "nothing is free" — it is "a component that _has_ a price should carry it".

**No stated reason.** The mail has no body and the workbook no comment. The revenue-attribution reading is plausible but is **ROMI inference — do not present it back to Pienissimo as their reason.**

⚠ **This may already be built. Do not assume it is.** `BundleComponent__c.Spread_Price__c`, `Bundle_Selling_Price__c`, `Spread_Total__c` and `Spread_Variance__c` exist for exactly this purpose. **But they are not the same mechanism:** the client asks to change _which article code_ sits in the bundle; ROMI keeps the code and attaches a spread price to the junction. Same revenue answer, **different data** — and which code Mexal receives, and which one an asset is generated from, is a different question.

Also unresolved: the components' list total is not the bundle price (none was supplied), and the swap uses **base** articles, never the `AGGIUNTIVO` ones, even where a blocco takes quantity 2 — so what `AGGIUNTIVO` is for remains unexplained.

### 13.6 ⚠ `_ARCOD` is an opaque string — a rule for the September import

Three code shapes coexist in one 29-row sheet: `CS` + 6 digits (`CS000114`, 9 of them), `CS-` + 5 digits (`CS-00001`, 18), `CS-` + 4 digits (`CS-0118`, 2). There is no rule behind which article gets which.

**Two pairs differ only by a separator or a leading zero:**

- `CS-00061` and `CS-0061` — **different events, different prices**, one leading zero apart.
- `CS000058` and `CS-00058` — the priced and complimentary twins of the same product, separator apart. Merging them destroys the exact distinction **#93** turns on.

`Product2.Code__c` is `unique`, `externalId` **and `caseSensitive=false`**, so a normalising import does not fail cleanly. It either **overwrites** a product silently, or throws an opaque duplicate-value error **at load time** — around the ~1 September import, far from the transform that caused it.

**The rule: match `_ARCOD` byte-for-byte. No trim, pad, separator-strip or case-fold, in any import mapping, matching rule, dedup or Mexal reconciliation.** If a readable form is needed, carry it in a separate field and never key on it. This binds the **import template (#88)** and the **data model workbook (#24)**, both still being written and both cheap to get right now.

### 13.7 The Tour is six articles, one per city

Padova, Brescia, Milano, Pescara, Roma, Catania — six codes, all free, each named `TOUR PIENISSIMO 2026 <CITTA>`. One event, six saleable instances, with **the year and the city readable only out of the name string**. That bears on Campaign auto-creation (#77) — six products for one event — and on `Evento__c` carrying a single `Tour` value.

### 13.8 Still owed

The 22/07 session paired the workbook with an action on Aurel Mrruku to **attend a review meeting on the anagrafica prodotti after receiving it**. The file arrived on 07/08. **The meeting has not happened.** #46, #48, #76 and #93 all want the same forum: the **26/08 client Mexal review**, where Fabrizio Paganelli is an invitee and which is the first client-facing session since the workbook landed.

## 14. Update 2026-08-24 — tranche creation decided by Aurel Mrruku

This is a direct architecture decision by Aurel Mrruku, not a reconstructed
meeting statement.

- The operational payment tranche is created **on the Quote, after products
  have been selected**.
- A guided action asks which Quote Line Items belong to the tranche and the
  planned payment due date. Every selected line stores the tranche reference
  and date; one line belongs to one tranche.
- When the accepted Quote generates the Order, both values propagate to the
  corresponding Order Items. The Order inherits the plan; it does not recreate
  tranches by merely grouping equal dates.
- Mexal updates payment status per Order Item / invoice line. Salesforce rolls
  those states up, and the tranche reaches its final paid state only when
  **every included line is fully paid**. Partial payment closes nothing; Mexal
  never creates or writes the tranche.
- The `BLO-` middle level in the product catalogue is a separate bundle block.
  It does not create `Tranche__c` during import. This closes the ambiguity raised
  in §13.4.
- The final state API value is **still open**. Conceptually it is
  `Pagata`/`Incassata`; the legacy `CHIUSO/ACQUISITO` value must not be assumed
  until #69 is resolved.

`Tranche__c`, the Quote-side action and fields, propagation to Order Items and
the roll-up automation are all still unbuilt.

## 15. Update 2026-08-24 — standard Asset selected for tickets

The ticket-object decision in #41 is closed: the target is the **standard
Salesforce Asset object**, with one Asset record per ticket. The direct
instruction did not identify the decision-maker, so this recap does not assign
personal attribution.

This decision does not describe the current UAT build. UAT still uses the
custom `Biglietto__c` object, with ticket fields, relationships, order-trigger
logic and six active Apex classes for DocuSign/PDF behaviour. Those elements
must be mapped to Asset and then migrated, rewritten or retired. The migration
effort is not estimated, and no standard-Asset replacement exists yet.

#41 is resolved as a design decision; the implementation divergence remains an
open delivery risk.

## 16. Update 2026-08-24 — four meetings recovered in one nightly sweep

The nightly `requirements-check` folded in **four previously untracked
sessions**. Two of them — 19 and 20 August — had been reported missing by three
consecutive sweeps and are now fully minuted. Sources: canvas entries added
between 21 and 24 August, and Elena Spini's own minute forwarded on 24 August.

| Date  | Session                             | Nature                                                            | Weight                                                        |
| ----- | ----------------------------------- | ----------------------------------------------------------------- | ------------------------------------------------------------- |
| 19/08 | Flussi MKT Biglietti                | Client + ROMI marketing                                           | Gemini notes + transcript                                     |
| 20/08 | Flusso Asset/Biglietti              | Client, called by Elisa Migliano                                  | **Elena Spini's minute, sent to the client the same evening** |
| 24/08 | Interna per update flusso Lead/Opty | ROMI-internal (Elena + Aurel)                                     | Gemini notes + transcript                                     |
| 24/08 | Follow-up Interno                   | ROMI-internal (Elena, Aurel, Andrea Di Cicco, Fabrizio Mastracci) | Gemini notes + transcript                                     |

⚠ **Aurel Mrruku was in neither client session.** The 20/08 technical decisions
were taken without ROMI's technical lead, and the minute reached him four days
later.

### 16.1 🔴 The event edition is not an attribute of the product

Fabrizio Paganelli, minuted to the client on 20/08:

- **Mexal article codes are transversal across years** — no code per edition.
- Classification is **Evento → Tipo Biglietto → Edizione**, and the **edition is
  determined by the order date, not by the product**.
- **Mexal supports at most three article classifications**, insufficient for
  event + ticket type + variants.

The built `Product2.Anno_Solare__c` picklist and its `Evento__c` dependency
matrix assume the year lives on the product. **The question is no longer what
values the picklist needs but whether the field should exist.** §13's finding
that the matrix was ROMI guesswork now has its answer: there is no client source
because there is no client concept. Blocks #46; needs Aurel Mrruku's ruling.

Compounding it: Elisa Migliano's 19/08 example was the **academic year
2026-2027**, and Rebecca Marmo described Zoho's hierarchy as **four** levels
(Evento → Edizione Evento → Evento Biglietto → Evento Biglietto Prodotto)
against the build's two.

### 16.2 🆕 What carries the edition instead: a three-level campaign model

Agreed with the client 20/08, configured internally 24/08:

**Campagna Padre** (grouping container, statistics) → **Campagna Figlio** (the
annual edition — dates, venue, check-in) → **Campaign Member** (participants).

- Created **manually, once a year, ~10 a year**, with cloning. Fabrizio
  Paganelli confirmed the volume is manageable by hand, so **no generation
  tooling is owed**.
- **Two Record Types** on Campaign, parent and child.
- **A lookup on Product holding the parent campaign code**, populated **by hand
  after the campaign is created**.
- **Automation enforcing one active child campaign per parent**, so the asset can
  resolve "the current edition".
- **Campaign membership is created at enrolment only** — buying does not make the
  purchaser a member.

**Entirely unbuilt.** This supersedes the flat model in §11 and rewrites the
scope of #77 and #84. ⚠ The whole edition-resolution mechanism hangs on a lookup
an administrator must remember to fill in, ten times a year, with no minuted
control that catches an empty one.

### 16.3 ✅ Settled

- **#76 — ticket type is a manually maintained Salesforce field**, owned by
  **amministrazione (Fabrizio Paganelli + Elisa Migliano)** with periodic
  verification reminders; the **one-off mass update at go-live is ROMI's**. It
  cannot come from Mexal — hence 16.1's three-classification limit. This
  reverses the standing instruction to ask for a tier _column_: ask for the
  agreed **value list** instead.
- **#50 — the tranche is created and managed manually on the Quote**, before the
  order; **products and tranches are editable only in `Bozza`**.
- **#75 — ticket availability follows the tranche chronologically**: an unpaid
  earlier instalment blocks the later events, so availability is a function of
  the order's whole payment history.
- **#73 — the VAT provider is `Anticipay`**, called on the **first order for an
  Account**; unhappy path is an email to amministrazione.
- **#82 — resolved.** The dedicated asset-flow review is the 20/08 session.
- **#59 — the quote lifecycle is fully specified**, and the **picklist values now
  exist** (in the design diagram, not the register): `Motivazione da
Ricontattare` and `Motivazione da Ricontattare - Preventivo Inviato`.
- **#58 — a field-level Mexal mapping exists** for the first time
  (`Integrazioni pienissimo.xlsx`, Andrea Di Cicco, 24/08): entities, methods,
  cadence, per-field customer payload. Sandbox pattern fixed — **code 501 for
  new customers, series 10 for new orders**.

### 16.4 🔴 Two contradictions that block building

1. **#59 — "Da ricontattare".** The 20/08 minute told the **client** it generates
   **no automatic task**, using an informational banner instead. The 24/08
   internal session specifies a validation rule, a trigger and reminder
   notifications on the same state. A banner and a validation rule can coexist,
   but the "no automatic task" line is a client-facing commitment the internal
   session never referenced. **Neither is buildable until reconciled.**
2. **#53 — asset generation.** The 19/08 minute says it two ways in one document:
   the **Dettagli** say the asset is created when an **order** with an
   event-type product is generated (with the motivation — avoiding assets
   created at quote stage); the auto-generated **Decisioni** line says "order
   **or quote**". Prefer the Dettagli, but get it ruled on.

Still unruled and now sharper: **#74 — `Rinuncia`.** The 19/08 minute describes
_rinuncia_ as a marketing tag and funnel opt-out applying to the **whole
participation**, and does not list it among the asset states; the master diagram
still draws it as a state box. Diagram and minute now disagree.

### 16.5 The design file moved a fourth time — and this edit is minuted

`Flows & Objects.drawio` re-decoded at **2026-08-24T16:34:34Z**. For the first
time the edit is downstream of a meeting: it lands the same afternoon as Elena
Spini's action to circulate the minutes and the updated workflow link, and its
new content restates that session's decisions — the campaign lookup rule, the
two `RULES + FLOW` specification blocks with the picklist values, a third loss
reason list (`Motivazioni CHIUSA PERSA`), and `Anticipay`.

⚠ The last two **cannot be dated** to 24/08 — they are present now and absent
from the 20/08 prose write-up, but prose is not a byte-level record. Recorded as
_present, not previously registered_.

### 16.6 Not done, deliberately

**No requirement was changed.** `requirements/pienissimo-requirements.yaml`,
`REQUIREMENTS.md` and `REQUISITI.it.md` were not touched. Several of these
decisions bear on signed requirement text — most directly #46 and #76 — but a
nightly sweep is not the right instrument for rewriting a contractual document.
**Flagged for Aurel Mrruku and Elena Spini.**

⚠ `Integrazioni pienissimo.xlsx` **holds real customer records** — company name,
address, VAT number, personal email, telephone. Existence and coverage are
recorded; **no value from it is in this repository**. It is the third artifact
with this problem, after the master diagram and `anar_PIE_ricla.xlsx`.

## 17. Update 2026-08-25 — org check against the Pienissimo UAT org

A **read-only check of the live Pienissimo UAT org** (`a.mrruku@pienissimo.uat`),
cross-checked against `force-app/` on `DevMain`. It supersedes the 2026-08-03
verification, which was stale in both directions.

⚠ **This section records build state only.** No requirement moved, no design
decision moved, and nothing here reopens a settled point. Where it contradicts
an earlier section on **what exists**, §17 wins; where an earlier section records
**what was agreed**, that section still governs. Full gap table: the
org-verification block in `open-items.md`.

### 17.1 ✅ The tranche is built — the record said it existed nowhere

`Tranche__c` is live, with state, due date, planned amount, sequence and a Quote
lookup, plus `QuoteLineItem.Tranche__c`. Six records, all open. The manual
creation path agreed in §14 — quick action, LWC and controller — **exists and
works**.

⚠ Two qualifications, both material:

- The creation UI (`quoteCreateTranche` and its controller) is **org-only** — it
  is not in source control and has no test.
- **Propagation to Order Item and payment aggregation are not built.**

So #50 moves from "not started" to **partly built**, and its remainder is
narrower and better understood than the tracker had it.

### 17.2 🔴 There is not one Flow in the org

**Every declarative automation designed since June is absent.** All automation in
the org is three Apex triggers — `BigliettoTrigger`, `BundleComponentTrigger`,
`OrderBigliettoTrigger`.

Nothing stands behind: asset generation (#53), the quote alerts and reminders
(#59), the participant funnel (#78), campaign members (§16.2 — `Campaign` has
zero custom fields, no record types and no validation rules), or the Lead/Opty
validation specified on 24/08.

The flows in §3 and §11 are therefore **designs with no implementation**, not
partial builds.

### 17.3 🔴 Every state machine is still stock Salesforce

Order, Quote, Lead and Opportunity carry the **out-of-the-box picklists**. Not
one agreed value is configured. The order vocabulary settled on 06/08 (#69) and
the quote lifecycle specified on 24/08 (#59) — picklist values included — exist
on paper only.

### 17.4 🔴 The repository is now ahead of the org, and behind it, at the same time

Both directions at once, which is why a claim about "what is built" has to name
which side it was read from:

- **`OrderItem.Tranche__c` is committed to `force-app/` and absent from the
  org.** Tranche-to-order propagation cannot run, while the repository reads as
  done.
- **Seven `Biglietto` components and the whole tranche creation stack exist only
  in the org** and are not in source control — so a scratch org or a refresh
  loses them.

### 17.5 🔴 Thirty-seven tickets are parked in a state deleted on 6 August

None has ever reached `Disponibile`; thirty await a signature step the design
removed. The ticket lifecycle has still **never run end to end**.

Meanwhile the decided migration target — standard **Asset** — carries **zero
custom fields**, so #41's target object is empty and the mapping is unestimated.
This sharpens #74 rather than settling it.

### 17.6 🔴 Nothing can deploy today

Apex coverage is **0%** against the 75% platform floor — 24 classes and triggers,
1028 uncovered lines, zero covered, measured 2026-08-25. #64 and #66 gate every
other item on this list. The suite is written as **one task, requested
separately before the production deploy**, and is not to be started as a side
effect of other work.

### 17.7 The classification apparatus is not merely disputed — it is empty

Measured across the 280 products in the org:

| Field                                             | Populated                                        |
| ------------------------------------------------- | ------------------------------------------------ |
| `Genera_Biglietto__c`                             | true on **4 of 280**                             |
| `Solo_Bundle__c`                                  | true on **0 of 280**, and no automation reads it |
| `Anno_Solare__c` · `Evento__c` · `Bundle_Type__c` | **1 of 280**                                     |
| `WooCommerce_Product_Id__c`                       | **0 records**                                    |

So the `Anno_Solare__c` question raised in §16.1 — whether the field should exist
at all — costs almost nothing to answer either way. There is no populated data to
migrate off it.

### 17.8 Not done, deliberately

**No requirement was changed.** An org check records what is built; it does not
rewrite a contractual document. The rulings still owed from §16 — #46
(`Anno_Solare__c`), #53 (asset generation stated two ways) and #59 ("Da
ricontattare") — are **unaffected by this check and still owed**.

---

## 18. Update 2026-08-25 — the Anticipay technical call

Source:
[2026-08-25 Integrazione Anticipay](../notes/meetings/2026-08-25%20Integrazione%20Anticipay.md).
Client-facing, 10:00 CEST. Elena Spini, Aurel Mrruku, Andrea Di Cicco for ROMI;
Andrea Parmeggiani (Pienissimo Software), Fabrizio Paganelli and Elisa Migliano
for Pienissimo. Gemini notes, transcript and recording exist. This is the call
#73 had been waiting for since 6 August.

### 18.1 🔴 Salesforce will not call Anticipay

**The counterparty changed.** Salesforce calls an API **built and hosted by
Pienissimo Software Srl**, which fronts Anticipay, caches lookups and returns a
standardised payload. New item **#94**.

Two reasons, both accepted in the room:

- **Cost** — Andrea Parmeggiani's argument. Anticipay charges per lookup, and
  Pienissimo already holds much of the data, so the middleware stops the same VAT
  number being paid for twice.
- **Insulation** — Aurel Mrruku's addition. If Anticipay changes its endpoints,
  only the middleware moves.

### 18.2 The contract as far as it is agreed

| Element         | Agreed                                                                           |
| --------------- | -------------------------------------------------------------------------------- |
| Caller → callee | Salesforce → **Pienissimo middleware**, not Anticipay                            |
| Trigger         | the **first Order inserted for an Account** — confirmed, unchanged               |
| Authentication  | a **token in the HTTP request header**                                           |
| Errors          | `404` VAT not found · `500` generic — **code and message both returned**         |
| Error storage   | **saved in Salesforce, kept three months**, used to raise internal notifications |
| Conflicts       | the returned value **overwrites** Salesforce                                     |
| Payload         | **trimmed** to the needed fields — see §18.3                                     |

### 18.3 Which fields is now its own open item

The payload is deliberately trimmed, and **nobody has said what to keep**. New
item **#95**, owned by Fabrizio Paganelli and Elisa Migliano. Candidates raised
and none decided: ragione sociale, rappresentante fiscale, legale rappresentante,
the **Anticipay reliability score**, and **e-invoice routing via PEC**. Fabrizio
Paganelli framed it as a chance to revisit the Mexal registry fields too.

⚠ Two of those are not registry data. A reliability score is a commercial
judgement about a customer; PEC routing is invoicing configuration. The
three-month retention agreed for **error codes** was **not** stated to cover the
returned **data**, and nobody asked how long the company details are kept.

### 18.4 Nothing is buildable yet, and the dates are tight

No endpoint, no schema, no token, no test environment. **Andrea Parmeggiani owes
the API structure example by Friday 4 September** — committed as "end of next
week" — plus an example of every field Anticipay returns. A follow-up call is
booked for **Tuesday 1 September, 10:00 CEST**, cancellable if the material
arrives first.

Set against the **10 September** end of Fase 1 development, that leaves roughly
four working days between the specification arriving and development closing.

### 18.5 ⚠ One action is wrongly assigned in the client-facing invitation

The Gemini minute assigns _"create a dedicated test environment"_ to **Aurel
Mrruku**. That is not what was agreed. Elena Spini put the list to him on Slack
at 15:03 CEST and he corrected it: ROMI's test environment already exists — it is
UAT — and what is needed is **Pienissimo's, for ROMI to point at**. Elena Spini
accepted the correction.

**The calendar invitation sent to the client at 13:17 UTC carries the
uncorrected wording and has not been re-sent.**

### 18.6 🔴 A Fase 1 integration now depends on the disputed entity

Anticipay → SFDC is **Fase 1** in ROMI's own project plan. As of this session,
Fase 1 cannot go live unless **Pienissimo Software Srl** — the separate legal
entity ROMI argues is not this project's client, and the entity at the centre of
the phase 2 scope dispute — writes a service, stands up a test environment for
it, and keeps it running.

Who pays for that work, and who owns the middleware's uptime after go-live, was
not raised. The decision was taken on technical merit and both arguments are
good ones; the point is that a **commercial boundary moved inside a technical
decision**, and nobody in the session said so.

### 18.7 The master diagram now contradicts itself

`Flows & Objects.drawio` was edited **during the call**, at 08:23 UTC. The
**LEAD-OPTY** page now reads _"chiamata API **al middleware Pienissimo** per
check P.IVA Account"_. The **Ordini** page still reads _"chiamata API
**Anticipay**"_. The LEAD-OPTY wording is the later and correct one.

### 18.8 Also landed on 25 August, from Slack rather than a meeting

- 🟢 **The Postman collection** — `Mexal Dev.postman_collection.json`, sent by
  Andrea Di Cicco at 11:52 CEST, closing an action from 24 August. **Incomplete
  and he says so.** (#58)
- 🟢 **The invoice-to-order-line link is answered.** A single Mexal invoice
  carries the list of its items, so per-line payment status is reachable —
  _"quindi per le trance sappiamo come capire quando sono state pagate"_. That is
  the input the tranche aggregation needs. It is a reading of the data, not a
  built call, and **how tranches are created on the Mexal side is still
  unknown**. (#50, #58)
- 🟢 **Marco Montesi's reminder-email copy arrived**, owed since 20 August. A
  quote-expiry reminder built from merge fields. The **preset expiry timings** he
  also owes are still outstanding. (#59)

### 18.9 Not done, deliberately

**No requirement document was touched.** `pienissimo-requirements.yaml`,
`REQUIREMENTS.md` and `REQUISITI.it.md` are unchanged. §18.1 bears directly on
the signed integration text — the counterparty in a Fase 1 integration is not a
detail — but rewriting a contractual document off a nightly sweep is a human's
call. Flagged, not done.

---

## 19. Update 2026-08-26 — org check against the Pienissimo UAT org

A second **read-only check of the live Pienissimo UAT org**
(`a.mrruku@pienissimo.uat`), one day after §17, cross-checked against
`force-app/` on `DevMain` at `dc513c6`. It supersedes §17 on build state.

⚠ **This section records build state only.** No requirement moved, no design
decision moved, and nothing here reopens a settled point. Where it contradicts
an earlier section on **what exists**, §19 wins; where an earlier section
records **what was agreed**, that section still governs. Full gap table: the
2026-08-26 org-verification block in `open-items.md`.

### 19.1 ❌ §17.4 was wrong, and the instrument was at fault

§17.4 reported `OrderItem.Tranche__c` as _"committed to `force-app/` and absent
from the org"_. **The field is in the org.** It was created 24/08 at 15:18Z,
one minute after its Quote-side twin.

`sf sobject describe` — the instrument §17 used — **filters its field list by
the running user's field-level security**. This field is granted to no profile
and no project permission set, so it is invisible to every user including System
Administrator, and `describe` omitted it exactly as it would omit a field that
was never created. Every field comparison from §17 was re-run against Tooling
`FieldDefinition`, which is not filtered. **Only this one finding changed.**

The consequence §17.4 drew still holds, for different reasons: **propagation
cannot run.** No user can read the field, and nothing in `force-app/` writes it
— not the classes, not the triggers, not the LWC. The `Tranche_Management`
permission set grants the `QuoteLineItem` twin read and edit, and omits the
`OrderItem` side entirely.

### 19.2 🟢 The first agreed state machine reached the org

`Quote.Status` now carries **`Bozza · Nuovo Preventivo · In Trattativa · In
Attesa Accettazione · Accettato · Rifiutato`**, with the eight stock English
values deactivated. That is the lifecycle specified on 24/08 (#59), including
`In Attesa Accettazione`, the rename that item singles out as mattering most.

§17.3 said every state machine was still stock. **That is now true of Order,
Lead and Opportunity, and no longer true of Quote.**

🔴 One qualification: **the records were left on the old values.** Three of the
four quotes in UAT still sit on deactivated stock values. Four development
records is nothing — but it is a rehearsal for the same operation against the
**37 tickets** stranded at #74, and it went the wrong way.

### 19.3 🟢 The retrieve gap closed within a day

§17.4 recorded the tranche creation stack as org-only. PR #12 (`dc513c6`,
merged 26/08) brought `QuoteTrancheController`, the `quoteCreateTranche` LWC,
`Quote.Crea_Tranche`, two `Tranche__c` fields and the `Tranche_Management`
permission set into `force-app/`. The committed controller is **byte-identical
to the org copy**.

**One component is still org-only: the `Tranche__c-Tranche Layout`.** And the
Biglietto stack has not moved since 22/07 — it is in fact **three components
larger** than recorded, since the `BigliettoPdf` Visualforce page, the
`DocuSign` named credential and the `BundleComponent__c` custom tab were never
on the list. Without the page and the credential the stack could not run in a
fresh org even if the six classes were retrieved.

### 19.4 🔴 §17.2 understated the absence

There is still not one Flow. The check was widened, and the rest is empty too:
**zero** `WorkflowRule`, `ApprovalProcess`, `EmailTemplate`,
`CustomNotificationType`, and **no scheduled Apex**. Two validation rules exist
in the whole org, both on `BundleComponent__c`.

So there is no declarative automation, **no notification channel, no email
template and no timer**. Three designed behaviours have nothing to sit on:
Marco Montesi's reminder copy (#59, delivered 25/08), the reminder
notifications specified on 24/08, and the automatism that moves unscanned
tickets three days after an event.

### 19.5 🔴 The integration scaffolding has never been configured

New finding, not in §17. `Integration_Configuration__c` and
`Integration_Log__c` hold **zero records**, the org has **one** named credential
(`DocuSign`) and no remote site settings.

So no outbound integration — Mexal (#58), WooCommerce (#49), VAT through the
middleware (#73, #94) — has an endpoint defined in the org. `API_Callout_Engine`
is committed, working, and wired to nothing. The engine is not the integration;
the configuration row is.

DocuSign is the exception and the proof: it is the one integration with a
credential and it has demonstrably run — `DocuSign_Envelope_Id__c` is populated
on **19 of the 37** tickets — and it does not use this scaffolding. It runs on
the org-only classes above.

### 19.6 🔴 The tranche ordering key cannot be trusted

`Tranche__c.Sequenza__c` is what ticket release (#75) reads to mean "every
tranche before this one". It runs **1, 4, 3** on one quote — a gap, out of
creation order — and is **null** on the three older records. No validation rule,
no Flow, nothing enforcing presence, uniqueness or contiguity.

One tranche also moved to `Parzialmente Pagata` **by hand**; no automation
exists that could have set it. Payment roll-up remains unproven, as §17.1 said.

### 19.7 Unchanged since §17

The ticket stall (§17.5): still **37 tickets**, 30 in `In attesa firma`, **0**
ever `Disponibile`, **0** QR codes. Standard **Asset** still zero custom fields
— confirmed against `FieldDefinition`, so this is not an FLS artefact — holding
one record named `Test`. Campaign and Campaign Member both still zero custom
fields, so the parent/child model of §16.2 remains entirely unbuilt.

Deployability (§17.6): coverage **0%**, now **1069** uncovered lines across the
same 24 classes. The rise from 1028 is entirely `QuoteTrancheController`, whose
body has not changed since 25/08 12:50Z — the snapshot caught up with the
deploy, the code did not grow.

The classification apparatus (§17.7) is unchanged, with one number worth adding:
`Tipologia__c` is populated on **249 of 280** products, which no earlier check
recorded.

### 19.8 Not done, deliberately

**No requirement was changed.** `pienissimo-requirements.yaml`,
`REQUIREMENTS.md` and `REQUISITI.it.md` carry no edit from this check beyond the
register's own `build_state` block, which exists to record exactly this.

Two things are **flagged for a human, not corrected**: the register's
`state_machines.quote.states` still carries the older DGM-derived labels and now
disagrees with both the org and #59; and the rulings owed since §16 — #46, #53
and #59's "Da ricontattare" contradiction — are untouched by an org check and
**still owed**.

---

## 20. Update 2026-08-26 — the Mexal review, and the edition mechanism changes again

The **26 August `[ROMI-PIENISSIMO] - Review Temi Integrazione Mexal`** client
session, 16:00–17:26 CEST, 1h25m45s, recovered by the nightly
`requirements-check` sweep the same evening. Gemini notes, full transcript and
recording all exist and were read; the transcript is preserved at
`meetings/2026-08-26-review-temi-integrazione-mexal-transcript.it.md` and the
bilingual recap at `meetings/results/2026-08-26-review-temi-integrazione-mexal.md`.

**First Mexal session since 14 July.** Present: Elena Spini (left ~01:02), Aurel
Mrruku, Andrea Di Cicco (ROMI); Fabrizio Paganelli, Elisa Migliano (Pienissimo).
Sabatino Rinaldi was invited and never spoke.

⚠ **This section records decisions, not build state.** Where it meets §19, §19
still governs what exists in the org.

### 20.1 🔴 §16.2's active-child-campaign rule is dead

§16.2 records the edition being carried by **a parent-campaign code in a lookup
on Product, plus a rule enforcing one active child campaign per parent**. Both
halves were abandoned on 26 August.

**The edition now comes from a hand-maintained Salesforce table**, one row per
`article code × data inizio × data fine → edizione`. At order time each **order
line** is matched on the **order date** against its article's window and takes
the edition from the matching row.

Elena Spini killed her own rule in the session: a bundle spanning two events
cannot resolve to a single active edition — _"quello che avevamo pensato Aurel,
cioè non può esistere perché… se prendi il bundle, cioè come fai?"_ Aurel Mrruku
accepted the replacement: _"non mettono il flag campagna attiva… mettono solo le
date, faccio io il check nel momento in cui si genera l'ordine."_

Three properties are easy to get wrong and all three are load-bearing:

- **It resolves per order line, not per order.** Elena Spini asked; Fabrizio
  Paganelli confirmed — _"a livello di riga ordine."_ One order legitimately
  splits across editions.
- **The windows are arbitrary.** They are the period during which orders for an
  edition are taken, set by hand, and are **not** the edition's calendar year and
  **not** the event's own dates. Aurel Mrruku restated it and got confirmation:
  _"puoi mettere data a piacere… io mi baso solo su quelle date."_
- **The order date governs, not the tranche date.** Fabrizio Paganelli:
  _"le tranche ci servono a noi solo per definire i pagamenti."_

A **separate hand-entered event date** — column G of the same table — carries the
real event date and is what the post-event no-show deactivation keys on.

Recorded as **#96**. ⚠ **Agreed in principle and explicitly not finished.** The
Gemini decisions list files the order-line-to-campaign mapping under
_"Da approfondire"_, the only item there, and Aurel Mrruku asked for a dedicated
hour of concrete worked examples first. **That session is not scheduled.**

### 20.2 §16.1 is confirmed, and now has a mechanism

§16.1 records the client's ruling that the edition is not an attribute of the
product. Fabrizio Paganelli restated it unprompted in the first two minutes —
_"l'anno accademico avevamo detto di no perché deve essere derivato in base alla
data dell'ordine"_ — and §20.1 is the mechanism it always lacked.

**This settles what #46 turns on.** `Product2.Anno_Solare__c` does not merely
lack a client source for its dependency matrix; its job now belongs to #96. It is
populated on 1 of 280 products, so removing it costs one record.

The **event** half gets a carrier too, and it is not a Salesforce picklist: it
descends from Mexal's `categoria statistica`.

### 20.3 🟢 The three Mexal classification fields are assigned and tested on the wire

Fabrizio Paganelli's constraint, stated at the top of the call: **the Mexal
article registry has at most three fields available to classify a product**, and
none of them is in use — _"siamo liberissimi di fare come è più comodo per noi."_

Each assignment below was proved during the session, Fabrizio Paganelli editing
in Mexal while Andrea Di Cicco diffed the API response in real time.

| Mexal field            | API name                           | Carries                        | Verified                                                   |
| ---------------------- | ---------------------------------- | ------------------------------ | ---------------------------------------------------------- |
| `natura`               | `COD_Natura`                       | genera biglietto sì/no         | ✅ set on `CS_00154`, seen over the API                    |
| `categoria statistica` | `Sigla cat sta` + `Numero cat sta` | the event (Campagna Padre)     | ✅ `C01` then `P02`. **Two API fields**                    |
| `gruppo merceologico`  | `GRP merch`                        | candidate for tipo biglietto   | ⚠ hierarchical; **only the code came over, not the level** |
| `Gest. annullato`      | `Gest. annullato` — `n`/`S`        | product disabled in Salesforce | ✅ `CS58` cancelled and restored live                      |

`natura` resolves against a managed base table, **not free text** — which answers
Andrea Di Cicco's objection that an operator could type anything.

⚠ **The values themselves are not chosen.** Fabrizio Paganelli takes the scheme to
Pienissimo's direction on **Monday 31 August**.

This answers the question §16 left open at #47: **the event flag falls on the
Mexal side.**

### 20.4 🔴 The bundle twin needs its own article code — #48 reverses

The record read on 24 August that `Product2.Solo_Bundle__c` made the `(B)`
convention obsolete. Aurel Mrruku established the opposite: _"devi per forza
avere due prodotti, non lo puoi fare un unico prodotto."_ Fabrizio Paganelli
agreed and named it — code A outside the bundle, code B for tutors.

The flag marks which is which; it does not remove the twin. The codes will be
minted inside §20.7's registry re-creation, and the `(B)` string was never
mentioned — **ask for the convention when the new registry arrives.** Two such
articles are promised as a test next week.

### 20.5 Obsolete products disabled via `Gest. annullato`, at a known manual cost

~1000 legacy article codes exist and tutors pick from them. Mexal's
`annulla/ripristina` sets the flag, the integration maps it to an inactive flag on
`Product2`, the product stops being selectable. Tested against a real invoice:
the cancelled article's line stayed visible on the issued invoice.

⚠ **Elisa Migliano supplied the failure mode from live experience** — tutors have
quoted a code while administration cancelled it underneath, the quote then failed
to reach Mexal and was fixed by hand. Andrea Di Cicco confirmed Salesforce
behaves the same: **nobody can re-select a disabled product, master and
administration users included**, but an existing order line can be edited to swap
in the replacement code. Both accepted that cost.

### 20.6 New: fiscal residence is mandatory, and the API documentation is incomplete

Andrea Di Cicco's live customer-creation call failed on **`tipo nazionalità`**,
which is `residenza fiscale` in the Mexal UI. It must distinguish **Italia, San
Marino, Città del Vaticano, Unione Europea, extra-Unione Europea**, because it
drives invoice transmission to the San Marino _ufficio tributario_. Whether
Salesforce carries or derives the value **was not discussed** — **#97**.

⚠ It was not the only undocumented mandatory field: _"tutti sti campi non
c'erano sulla documentazione."_ `valuta` was set to `1` by trial and **nobody
knows whether 1 is euro**. Treat the Mexal documentation as a partial description
of the contract.

Once set, both write calls worked: customer `501.08721` and order `OC11`, on
serie 10 — **in production**. 🔴 **There is still no Mexal test environment.**

### 20.7 🔴 The entire Mexal article registry is scheduled to be re-created

The opening statement of the meeting, and the largest thing in it by consequence:

> _"vorrei chiudere tutti i codici prodotto che abbiamo adesso e crearne di nuovi
> in base alle regole che ci siamo dati fino ad oggi… è probabile che ci sia
> l'intenzione di rivedere un attimo i listini."_

It goes to Pienissimo's direction on **31 August**; the revised registry is
promised "next week". Recorded as **#98**.

It renders provisional almost everything derived from `Prodotti e Bundle.xlsx` —
the event list (§13, #46), the tier evidence (#76), the bundle-only codes (#48),
the priced-component request (#93) — and the 280 `Product2` rows in UAT. ⚠ Price
lists are in scope, so the prices delivered on 07/08 have a shelf life; record
that they change, never the values. **Nobody connected it to the 10 September end
of Fase 1 development.**

### 20.8 ✅ Settled, and one thing removed from scope

- **Only listino 1 is used.** _"usiamo solo l'uno."_ Open since July, deferred by
  Mirko Merendi to Fabrizio Paganelli — now answered (#58).
- **Ticket tiers are Executive, Gold and Diamond**, said out loud by Fabrizio
  Paganelli and matching the registry. `Silver` and `Dinamond` are both dead
  (#76). ⚠ Where the tier _lives_ reopened and did not close — see §20.10.
- 🟢 **Invoicing stays piloted by Mexal for roughly six months.** Andrea Di Cicco
  had the JSON; Fabrizio Paganelli declined — _"per il momento preferisco che
  venga pilotata solo da Mexal la fatturazione."_ Salesforce reads invoices, it
  does not create them. That removes an unestimated build item.
- **Multi-edition bundles of the same article are out of scope** —
  _"questa qui è una cosa che non facciamo."_ Read narrowly: different articles
  with different windows still split across editions in one order.
- **New requirement:** when a no-show is manually given a goodwill ticket for the
  next edition, **the Asset must be linked to the next Campagna Figlio by hand**,
  or the reminder automation never fires again. No control catches it.

### 20.9 🔴 #92 was the question this meeting existed to answer, and was never asked

The scadenziario question — can an _unpaid_ Mexal invoice drive an Asset back to
its previous state? — was minuted on 20 August as an action for this forum. Its
proposer (Fabrizio Paganelli) and its owner (Andrea Di Cicco) were both in the
room for 1h25m. **The word _scadenziario_ does not appear once** in the
transcript, the notes, the decisions or the next steps.

It now has **no scheduled forum**: 27 August is WooCommerce, and the 2 September
`Follow-up Anagrafica Articoli` is scoped to the article registry. Put it on an
agenda explicitly.

### 20.10 Open questions this session leaves behind

- ⚠ **Ticket type has two live answers.** The 20 August client minute says a
  Salesforce-only field; this session put Mexal's `gruppo merceologico` back on
  the table without retracting it and ended on _"facciamo una prova"_. **Later
  evidence does not win here** — the discussion did not conclude. Treat 20 August
  as standing and Mexal as an open alternative.
- ⚠ **The four-value encoding scheme was proposed and abandoned mid-discussion.**
  Aurel Mrruku floated packing two booleans into `natura`, backed off when ticket
  type turned out to have three values, and Andrea Di Cicco called it
  _"un po' complicato"_. **Do not build against it.**
- ⚠ **The tranche-to-order-row relationship is still unexplained.** Aurel Mrruku
  asked Andrea Di Cicco directly — _"mi devi spiegare sta roba"_ — and the call
  ended first. It bears on #50.
- 🟢 **The customer-registry session was booked the same evening** — 2 September
  10:00–11:30 CEST — though the invitation is titled
  `Follow-up Anagrafica Articoli` and the thread that produced it covers both
  registries. **Put the customer-registry agenda in writing before it** (**#99**).
- 🔴 **Mexal's coded-value dictionaries are unknown to ROMI as a class.** Andrea
  Di Cicco on Slack at 18:16 CEST: _"loro hanno dei valori che sono tipo per
  valuta: 1,2,3,4 — che lato nostro non sappiamo"_. He had already asked for them
  by email and is unanswered. His verdict on the day's work:
  _"le integrazioni per ordini e clienti funzionicchiano"_.
- ⚠ **The master design file is now stale on campaigns.** `Flows & Objects.drawio`
  moved a **sixth** time on 26 August at 14:06Z — six minutes into this meeting —
  and **no tracked text cell changed**. It still carries _"Sulle campagne figlie
  deve esserci logica solo una campagna attiva"_ and the manual product→parent
  lookup, both superseded here, and the Ordini page still reads _Anticipay_
  against LEAD-OPTY's _middleware Pienissimo_ (§18.7), unfixed after two further
  edits.

### 20.11 Not done, deliberately

**No requirement was changed.** `pienissimo-requirements.yaml`, `REQUIREMENTS.md`
and `REQUISITI.it.md` carry no edit from this session. Two of its decisions —
§20.1's replacement of the edition mechanism and §20.4's twin-code rule — plainly
bear on `BIG-02`, `BUN-12`, `BUN-13` and the campaign requirements, but the
session settled a **mechanism** rather than a contractual clause, and #96 is
explicitly unfinished. **Raise the register change with Aurel Mrruku once the
worked-examples session has run**, so the Italian text the client signs is
written against a design that is finished.

The rulings owed since §16 — #46, #53 and #59's "Da ricontattare" contradiction —
are unchanged by this session. #46 is now decidable; the other two are not.
---

## 21. Update 2026-08-27 — the WooCommerce integration is built, on the client side

Source: two client sessions the same day, both with Gemini notes, a **full transcript** and a recording — [Integrazione WooCommerce](results/2026-08-27-integrazione-woocommerce.md) (10:00–10:48 CEST, 48m20s, Elena Spini chairing, six present) and [Test Integrazione WooCommerce](results/2026-08-27-test-integrazione-woocommerce.md) (15:59–16:16 CEST, 17m13s, **two people**). Found by the nightly `requirements-check` sweep of 2026-08-27.

### 21.1 🟢 The integration direction is settled, and more specifically than "webhook"

**WooCommerce writes into Salesforce.** Standard WooCommerce webhooks were evaluated on screen and **rejected** — one topic per webhook, no multi-select, no control of the body; they would push every order in every state and could not carry the customer structure. The agreed mechanism is a **custom WooCommerce plugin using a PHP action hook on the order status transition**, composing one JSON body.

`INT-14` moves **open → agreed**. The pre-existing design was the opposite shape: Sabatino Rinaldi's own platform **polling** WooCommerce on a cron, which Aurel Mrruku identified as both asynchronous and pointing the wrong way for Salesforce. Full contract: [the WooCommerce order integration](../notes/flows/The%20WooCommerce%20order%20integration.md).

### 21.2 🟢 The client side is built and demonstrated working

Sabatino Rinaldi wrote the plugin **between the two sessions** and drove it live against the production shop: **version 1.3, always active, HTTP 200 on the wire**, with a manual re-send button on the order. Trigger verified live: order status `in lavorazione` **or** `completato`, **any payment method** — bank transfer, card, PayPal.

Payload observed: order key, totals, traffic source · customer with nome, ragione sociale and partita IVA · lines with the **`SC` product code**, name, quantity, subtotal, total. The authoritative copy is a text file mailed at 14:20Z that **no connected tool can open**.

### 21.3 🔴 `ORD-12` is corrected

The register and the design diagram said a WooCommerce order is **invisible in Salesforce until COMPLETATO**. The delivered plugin fires on **processing as well**, verified live. Later evidence wins: the rule is **IN LAVORAZIONE or COMPLETATO**, both dates cited in the register. The bank-transfer half stands — administration still flips the order manually on receipt.

Consequence: **every line arriving from WooCommerce is already paid**, and the payload carries no line-level status.

### 21.4 🔴 The mu-plugin and the link anatomy both shrink

Carts are built with **Funnel Kit**, which ROMI did not know. The funnel URL already contains the product, so the checkout link Salesforce generates carries the **opportunity id alone** — no `add-to-cart`, no `quantity`. The link-generator button therefore needs **no product or quantity pickers**, which removes work from the `INT-13` build list. And the client-side component is **Sabatino Rinaldi's plugin, owned by Pienissimo**, not the ROMI-specified mu-plugin.

⚠ The three spec points still open — id in clear vs signed token, URL parameter name, id format — are now being **decided by the implementation** rather than agreed. `INT-16` still recommends a signed token; the demo URL appeared to carry the id in clear.

### 21.5 🔴 The credential owed has reversed direction

`INT-11` has recorded **WooCommerce CK/CS owed by Sabatino Rinaldi** since 14 July, promised again for this session's invitation — _"comprensiva dello scambio di credenziali"_ — and never raised. With WooCommerce pushing, the blocking credential is **ROMI's: a Salesforce endpoint and a header token**, which Aurel Mrruku committed to and which blocks the integration tests set for the **week of 31 August** ([OI-102](../notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)).

Whether Salesforce still reads orders back over the WooCommerce REST API — and so whether CK/CS are needed at all — was **not decided**. Report them neither as owed nor as closed.

### 21.6 🔴 A VAT rule moved in a two-person room

**No P.IVA check fires on an inbound WooCommerce order**; validation stays on the Salesforce → Mexal leg. Aurel Mrruku corrected himself into this mid-exchange and Sabatino Rinaldi agreed.

⚠ [OI-73](../notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md) is a **client decision of 6 August** — proposed by Elisa Migliano, approved by Elena Spini — that the check fires **at the first order of an Account**. That is Account-scoped and once-only; this is per-order, and a WooCommerce order that never reaches Mexal would never be checked. **Neither Elisa Migliano nor Elena Spini was in the room.** Have it restated.

### 21.7 🔴 Stage sales are the money, and they are untested

Fabrizio Paganelli, unprompted at the close of the design session: WooCommerce is used _heavily_ for **vendite da palco** — customer in the room, QR code, **€8,900–9,000 and up** against ~€97 for a book or a stream — and a stage sale **triggers downstream mechanisms, contract generation among them**. He asked for both cases in the tests. The afternoon session ran **one €50 product through the happy path**; stage sales were deferred to the Salesforce-connected round. [OI-101](../notes/items/OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md).

### 21.8 🔴 Two things nobody owns

- **The WooCommerce and Mexal field sets will collide.** Andrea Di Cicco raised it early — _"onde evitare di creare 12.000 campi"_ — and nobody picked it up. It is in neither session's next steps. [OI-103](../notes/items/OI-103%20WooCommerce%20and%20Mexal%20field%20overlap.md).
- **There is no WooCommerce test lane.** Testing runs on the production shop; during the tests **real customer orders reached a throwaway third-party endpoint** before Sabatino Rinaldi deactivated the plugin. Same shape as Mexal's serie 10. [The risk](../notes/risks/Risk%20-%20real%20WooCommerce%20orders%20reached%20a%20third-party%20test%20server.md).

### 21.9 🔴 Off the meetings: Lead conversion is broken in the sandbox

Not from either session. A Salesforce error mail at **15:08:13Z** reports `LeadConversionQueueable` failing in the Pienissimo **partial sandbox**: _"No such column 'Servizio_Interesse__c' on entity 'Lead'"_ at line 22. **The repository's copy of that class does not select that field**, and the field's metadata **is** in `force-app/`. So the org runs a different version of the class, and the sandbox is missing a field the repository has. **Lead conversion does not complete there.** [The risk](../notes/risks/Risk%20-%20LeadConversionQueueable%20is%20broken%20in%20the%20Pienissimo%20sandbox.md).

✅ **Resolved on 2026-08-28, and the reading above was wrong.** The paragraph stands as the record of what was believed on 27 August, written **without org access**. An org check on **28 August (14:45–14:56Z)** found `Lead.Servizio_Interesse__c` **present** in the org and **neither** the deployed class **nor** the repository's copy selecting it — the only org-vs-repo difference in that class is Prettier line-wrapping. The failure at 15:08:13Z was real, but it recorded a **transient state on 27 August**, not a standing divergence; nothing in the record shows what changed between the two observations, so it is not attributed. 🟢 It no longer blocks testing [OI-100](../notes/items/OI-100%20Same%20lead%20email%20with%20different%20VAT%20during%20conversion.md).

### 21.10 Status of the WooCommerce build

| Side                                                                                      | State                                                                                                                                                                                                                        |
| ----------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Pienissimo — plugin, trigger, payload, re-send**                                        | 🟢 **built and demonstrated**                                                                                                                                                                                                |
| **ROMI — endpoint, token**                                                                | ⚠ **corrected 31/08** — the endpoint **is deployed and taking live traffic** (`WoocommerceOrderService`, unversioned); the **token is still not created**, and the endpoint has no authentication of any kind (§22.3, §22.5) |
| **ROMI — link-generator button, email template, order type, `SC` match, customer-create** | 🔴 nothing exists                                                                                                                                                                                                            |
| Org configuration                                                                         | 🔴 no Flow, no named credential, no integration configuration row (26/08 org check; `Integration_Configuration__c` still 0 rows and 0 object permissions on 31/08)                                                           |

The client side is real and waiting on ROMI, eleven working days from the **10 September** end of Fase 1 development.

## 22. Update 2026-08-31 — a destructive deploy, and the first client commitment met early

Neither of these came from a meeting. Both come from an `org-status-check` run at
**09:36–09:52Z** which, for the **second consecutive run**, published nothing to
the record, and from a client mail that evening.

### 22.1 🔴🔴 `Biglietto__c` was deleted from the org, with all 37 records

Tooling `EntityDefinition` returns zero rows and SOQL against the object no
longer parses. **The records were not migrated**: Asset held 4 on 28 August and
holds 5 today — one was added, not thirty-seven.

The deletion was **deliberate and is in the repository**. Commit `5d8cdb3`
(28 August 18:10 CEST) removes the object from `force-app/` and adds
`manifest/biglietto-cleanup-destructiveChangesPost.xml`, a destructive-changes
manifest naming the object, its tab, layout and list view, six Apex classes, a
trigger and a Visualforce page. It follows the 24 August decision to adopt
standard Asset, so it is a planned cleanup — **but nothing anywhere records that
an export was taken first**, and that is the whole of the recovery decision.

Salesforce retains a deleted custom object and its rows for roughly **15 days**,
so the window closes around **12 September** — one day after Fase 1 development
is due to end. This is the only item in this document that **decays if nobody
acts**. [The risk](../notes/risks/Risk%20-%20the%20Biglietto%20UAT%20ticket%20dataset%20was%20deleted.md).

### 22.2 🔴🔴 Seven Apex components went with it, and none was in source control

`BigliettoTriggerHandler`, `BigliettoDocuSignService`,
`BigliettoDocuSignQueueable`, `BigliettoPdfService`, `BigliettoPdfQueueable`,
`BigliettoPdfBatch`, `BigliettoTrigger` and the `BigliettoPdf` page are gone from
the org — 31 Apex classes now against 37 on 28 August.

**Verified against the whole of git history: not one of them ever existed in this
repository, on any branch.** So roughly **270 lines of the DocuSign send path and
the PDF generation stack** are gone from the only copy that existed. That code had
demonstrably run — **19 of the 37 deleted records carried a populated
`DocuSign_Envelope_Id__c`**, the only evidence on this project that the DocuSign
leg ever worked.

⚠ The org check reported this as _"the Biglietto Apex source-control drift is
resolved, albeit by deletion from both sides."_ **There were never two sides.** The
drift is not resolved; the unversioned half was destroyed. A deleted object can be
undeleted from the recycle bin; **deleted Apex has no equivalent user-facing
restore**, so the code is the harder half, not the same problem.
[The risk](../notes/risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).

⚠ **The project now has neither ticket implementation** — the old one removed, and
standard Asset carrying 8 custom fields, 5 records and none of the agreed
lifecycle. §3.4 and the Asset row in §1 should be read with that in mind.

### 22.3 🔴 The same pattern is live again, on WooCommerce

|              | In `force-app/`                           | In the org                               |
| ------------ | ----------------------------------------- | ---------------------------------------- |
| Class        | `WooCommerceOrderEndpoint` (16,789 chars) | `WoocommerceOrderService` (23,087 chars) |
| `urlMapping` | `/woocommerce/orders/*`                   | `/woocommerce/orders/*`                  |
| Deployed     | no                                        | **yes, modified 31 August**              |
| Versioned    | yes                                       | **no**                                   |

A clean deploy from this repository would **publish a second class on a route
that already has one** and orphan the class currently serving the plugin. The org
copy is live and busy — 16 inbound integration logs and 7 Woo-keyed orders — and
it is the largest single uncovered class at 396 lines. **Retrieving it is one
command and nobody has run it.**
[The risk](../notes/risks/Risk%20-%20a%20clean%20deploy%20would%20orphan%20the%20live%20WooCommerce%20endpoint.md).

### 22.4 🔴 The duplicate-order contract changed without telling the counterparty

A duplicate delivery now returns **HTTP 200 with `duplicate: true`** and updates
the Opportunity, where on 28 August it returned **409**. Idempotent-success is a
defensible choice; changing it silently on a live integration is not. Sabatino
Rinaldi's plugin can no longer distinguish "created" from "already existed" by
status code, and the integration tests run **this week**. §21.10 and
[OI-104](../notes/items/OI-104%20The%20WooCommerce%20payload%20has%20no%20idempotency%20key.md)
both still say 409; the org is right.

### 22.5 🔴 `INT-16` survived a full rewrite, still unauthenticated

The rewritten service is still `global without sharing` with **no token and no
signature check anywhere**. Its only handling of `Authorization` redacts the
header for logging (lines 418–427) — proof it is received and stored safely, and
none that it is verified. The endpoint has been taking **real production traffic
with no application-level authentication for four days**, and the token owed under
[OI-102](../notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)
remains the entire authentication.

### 22.6 Coverage: the number fell, and it is not progress

**0% of 1,571 lines across 21 classes**, down from 1,769 across 28. ⚠ **The whole
of the decrease is the deleted Biglietto code. No test was written.** Largest
uncovered: `WoocommerceOrderService` 396, `QuoteTrancheController` 386,
`LeadConversionQueueable` 148 — and the largest of the three cannot be read from
the repository. The register still records `current: "1%"`; it has been 0% on
every measurement since 25 August.

### 22.7 Also verified, unchanged since 28 August

`Integration_Configuration__c` still holds **0 rows and 0 object permissions**, so
Anticipay and Mexal still have neither an endpoint nor a principal that can read
one. Permission sets still reach **one user each against 8 active users**, so
business users still cannot exercise UAT. `OrderItem.Tranche__c` is null on
**15 of 15** order lines, up from 10 of 10 — five new lines arrived with no
tranche. A **half-deployed bundle-price feature** silently displays the spread
total instead of the calculated price, with no error. And the register's
`build_state` cites **`QUO-01` and `QUO-06`, which are not among the 154
requirement ids**.

### 22.8 🟢 The Anticipay API documentation arrived, four days early

Andrea Parmeggiani sent `Documentazione API – Salesforce.pdf` at **16:15Z** to
Aurel Mrruku, cc Elena Spini, amministrazione, Fabrizio Paganelli and Sabatino
Rinaldi. It was owed by **4 September** — the first client commitment on this
project delivered ahead of its date, and it turns the 1 September follow-up into a
review rather than a chase.

⚠ **The PDF has not been read.** The nightly sweep cannot open a Gmail attachment,
so the API contract is still not in the record.

🔴 **The mail body alone changes something.** For the test period the middleware
**serves only from the Pienissimo cache and does not call Anticipay**: _"l'API
ritorna i dati solamente se già presenti sul nostro database … alla fine del test
invece inoltreremo le chiamate ad Anticipay e per voi sarà trasparente."_ So an
uncached P.IVA returns nothing, and a test-period **`404` cannot be distinguished
from a genuine not-found** — the agreed error semantics give `404` one meaning and
during testing it carries two. Do not read test-period 404 rates as a measure of
Anticipay's coverage. The switch to pass-through is Pienissimo Software's to flip,
on **no named date**, with no signal to ROMI when it happens.
[OI-94](../notes/items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md) ·
[OI-95](../notes/items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md).

### 22.9 🟢 A marketing session is booked at last

`[PIENISSIMO]- Interna Flussi MKT`, **Monday 7 September 10:00–11:00 CEST**
(invitation 31 August 16:07Z): Elena Spini, Aurel Mrruku, Fabrizio Mastracci —
ROMI-internal, no client. First marketing session since 19 August, and the natural
forum for `30 vs 60` and the plain-text style constraint. ⚠ Both have a
client-side dependency an internal meeting cannot discharge; deciding `30 vs 60`
internally is ROMI choosing on the client's behalf and should be minuted as such.
No agenda was published.

## 23. Update 2026-09-01 — the Anticipay API contract, read at last

No meeting. Aurel Mrruku downloaded `Documentazione API - Salesforce.pdf` by hand
at **12:51 CEST** and it was drilled the same morning — the outstanding ask §22
listed as _"the cheapest in the record and the most valuable"_. Full decode at
[the contract](../notes/The%20Anticipay%20middleware%20API%20contract.md).

### 23.1 🟢 There were two versions, seventeen hours apart

| Version | Sent                 | Difference                                                                          |
| ------- | -------------------- | ----------------------------------------------------------------------------------- |
| v1      | **31 Aug 16:15:00Z** | the contract as first written                                                       |
| v2      | **1 Sep 10:46:38Z**  | _"Ho aggiunto un parametro `:env` nel path, prevede un valore tra 'test' e 'prod'"_ |

Both from Andrea Parmeggiani, same recipients. **ROMI holds v2.** Nothing has
been built, so there is no rework — but a specification that moves twice in
seventeen hours, the second time on the morning of the call it was written for,
**is not frozen**. Ask whether more changes are expected before a developer starts.

### 23.2 The contract

`GET https://romi.pienissimo.com/salesforce/account/:env/:piva`, with a
**bearer token in the `Authorization` header** and no request body. `:env` takes
`test` or `prod` and precedes the VAT number. A `200` returns
`{ success, status, info }`, where `info` carries **eleven string fields**.

🟢 **The eleven fields exactly match the as-is Mexal pre-invoicing lookup** that
Elisa Migliano described on 6 August — ragione sociale, the registered-office
address block, PEC, and the legal representative. The middleware is **not** a
trimmed view of a larger Anticipay response; it is **the service Pienissimo
already uses, re-exposed**. Her rating of that registry, _"corretta al 99,5%"_,
therefore applies to the same data Salesforce will read.

### 23.3 🟢 Two things that were inference on 31 August are now specification

- **The cache-only test mode is written into the contract.** Under `env=test` the
  middleware makes **no Anticipay call** and returns `404` for any company not
  already in the Pienissimo database. The reading taken from the mail body on
  31 August was correct, and `404` demonstrably carries two meanings during
  testing — _unknown company_ and _not cached yet_ — with nothing in the response
  to tell them apart.
- **The test environment Pienissimo Software has owed since 25 August appears to
  be `:env`.** Not a separate deployment: a path parameter on the same host,
  behind the same token, over the same database. That may be adequate for a
  cache-read lookup. It is not what the phrase normally means, and **nobody has
  said the action is now closed** — close it explicitly or restate what is wanted.

### 23.4 🟢 The error store already works — but two engine defects break the notification

The 25 August session agreed that the middleware returns error codes **together
with their descriptive messages**, that code and message are **both stored in
Salesforce for three months**, and that the stored record raises internal
notifications — Aurel Mrruku asked for precisely this so a verifiable history
would exist.

🟢 **That store exists and needs no design work.** It is `Integration_Log__c`,
ROMI's standard callout audit trail, already committed: `API_Callout_Engine`
writes the HTTP status into `Response_State__c` and the **raw response body**
into `Response_Body__c` (`LongTextArea(131072)`). Whatever shape an error body
has, code and message both land. ⚠ **An earlier draft of this section said the
store could not be built. That was wrong** — it read the missing error-body spec
as a storage problem when storage was already solved by scaffolding.

🔴 **The real defects are in that engine, and they are ROMI's to fix.**

1. **`Is_Error__c` is never set for an HTTP error.** The flag is set only when the
   configuration record is missing or an Apex exception is thrown. A `404`, `401`
   or `500` from the middleware is a **successful** HTTP send, so the row is
   written with `Is_Error__c = false` — **the agreed internal notification, built
   the obvious way, is silent for exactly the case this integration exists to
   handle**, and the error rows cannot be filtered at all.
2. **A non-matching error body loses the status code.** The engine deserialises
   into the `200` wrapper **before checking the status**; if the error body has a
   different shape the deserialise throws, and the `catch` rebuilds the log row
   **without `Response_State__c`**. So a `404` can be recorded as an Apex
   exception with no HTTP code — the precise outcome the 25 August agreement was
   written to prevent.

Both are generic scaffolding behaviour, so they affect **Mexal and every other
outbound callout** too. Fixing them once fixes them everywhere.

⚠ **This is why the missing error body still matters** — a much narrower reason
than "no store". One example of each error response lets the response wrapper be
written to tolerate the error shape without throwing. Small ask, still worth
making of Andrea Parmeggiani.

⚠ **And the three-month retention has no implementation.** The scaffolding ships
no purge job. Somebody has to write a scheduled delete, or "three months" becomes
"forever" — which interacts with §23.5: a **successful** lookup logs the full
response body, so the legal representative's personal data sits in
`Response_Body__c` regardless of which fields are mapped onto the Account.

⚠ **Two of the four codes are also new.** `400` (malformed VAT number) and `401`
(bad token) were never part of the 25 August protocol. They are a different kind
of error — `404` and `500` describe the company being looked up, `400` and `401`
describe **a defect in ROMI's own call**. The agreed design puts all four in one
bucket behind one notification, so **a broken deployment or a rotated token would
present as a run of unknown VAT numbers**.
[OI-107](../notes/items/OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md).

### 23.5 🔴 Six of the eleven fields identify a private individual

The legal representative's **full name, codice fiscale, date of birth, place of
birth and home address**, plus a PEC that in a ditta individuale is often a
person's own routing address.

Nobody hid anything. The 25 August session agreed the payload would be _"trimmed
to the needed fields"_ because Anticipay returns far more than anyone wants, and
everyone present reasonably pictured **company registry data**. The trimmed set
turns out to be **mostly personal data about someone who is not the customer
contact and has never interacted with ROMI or Salesforce**.

The stated purpose of the whole integration is _clean data pushed to Mexal_.
`ragione_sociale`, the address block and `pec` serve that; a director's date of
birth and home address do not. The three-month retention agreed on 25 August
covers **error codes**, and no retention has ever been stated for the returned
data. **Recommendation: store the company block, leave the five
legal-representative fields unmapped** — offered so the field choice is made with
this in view, not imposed.
[OI-108](../notes/items/OI-108%20The%20Anticipay%20payload%20carries%20personal%20data%20of%20the%20legale%20rappresentante.md).

### 23.6 🔴 One static token serves both environments, and it was mailed twice

There is no second token for `test`. One host, one credential, no rotation,
expiry or scope described anywhere — and it was sent to **six addresses on two
occasions**, including the shared `amministrazione@` mailbox and Sabatino
Rinaldi, who has no role in this integration.

Mailing a token is ordinary practice and the deliberately simple auth was
accepted on 25 August; nobody did anything wrong. The consequence is only that
**the token should be treated as already disclosed** when deciding whether to
rotate before go-live — and that with one credential there is no blast radius: a
token leaked from a sandbox calls `env=prod`, which after the pass-through switch
**spends money at Anticipay per lookup**, the cost control that was Andrea
Parmeggiani's own founding argument for the middleware.
[OI-106](../notes/items/OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md).

⚠ ROMI owes Pienissimo a token in the opposite direction for the WooCommerce
endpoint ([OI-102](../notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)),
where §22 found the receiving class has no application-level auth at all. Two
integrations, two static shared secrets, both distributed by mail — worth **one**
decision about how this project handles credentials.

### 23.7 ⚠ A typo in the wire format, and two answers OI-95 did not expect

The date of birth is returned as **`data_di_dascita_legale_rappresentante`** —
`dascita`, not `nascita` — identically in both the sample and the field table, so
it is the wire format rather than a slip in the document. If Pienissimo fixes it
quietly after ROMI codes against it, **the date of birth silently becomes null on
a `200 OK`**, with no error and no notification, and under the agreed overwrite
rule a null can overwrite a good stored value. Fix it now or freeze it in
writing. [OI-105](../notes/items/OI-105%20The%20Anticipay%20date%20of%20birth%20field%20name%20is%20misspelled.md).

Two candidates named on 25 August are **not available at all**:

- **the Anticipay reliability score** Fabrizio Paganelli asked about is **not
  returned** — wanting it is now a change request to Pienissimo Software, and
  would make this a credit-risk feed rather than a registry lookup;
- **`rappresentante fiscale`** is not returned either. The document returns
  `legale rappresentante`, a different role. Worth checking whether the terms were
  used loosely on the day.

**`pec` is present**, as §22 predicted.

### 23.8 ⚠ Nothing is built, and nine of the eleven fields have nowhere to land

`force-app/` contains **no Anticipay client, no callout and no VAT-check flow** —
only `Account.Partita_IVA__c` and `Lead.Partita_IVA__c`, both `Text(32)`,
**neither unique nor an external id**. `Integration_Configuration__c` has the
right shape (`Endpoint_Host__c`, `Endpoint_Path__c`, `Token__c`, `Timeout__c`)
but **zero rows and zero object permissions**; and its
`Named_Credential_Prod__c` / `_Sandbox__c` split assumes two hosts, where this API
has one host and a path segment. `:env` belongs in `Endpoint_Path__c`.

Account carries **three custom fields in total**. `ragione_sociale` maps to `Name`
and the address block to the standard billing address, so those are free — but
**PEC and all five legal-representative fields have no home in the org**, and
creating, exposing and securing them is unestimated work that follows the OI-95
decision rather than preceding it.

Undocumented and unasked anywhere: **rate limits, timeout, retry policy and cache
TTL**. The manual re-check button agreed in
[OI-73](../notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md) has
**no documented way to bypass the cache**, so it may return the same stale answer
it was pressed to escape.

### 23.9 ⚠ The 1 September call ran, and this recap has not read its minute

The follow-up **went ahead**: the calendar event carries a **recording timed
10:02 CEST** and a Gemini notes document. It had been booked as cancellable if
the material raised no questions.

⚠ Note the ordering: **v2 of the documentation arrived at 12:46 CEST, after the
call ended at 11:00.** So the `:env` parameter is plausibly an outcome of the
session rather than something the session had in front of it.

**Everything in §23 comes from the document, not from that meeting.** The six
questions below are what the specification raises; **several may already have
been answered in the room.** They are recorded so the minute can be checked
against them — not as an agenda, and not as a list to send anyone:

1. **The error response body** — one example per code, exactly as emitted. ⚠ No
   longer a blocker (§23.4): it lets the response wrapper tolerate the error
   shape, rather than unblocking the store.
2. **A date from Fabrizio Paganelli and Elisa Migliano** on which fields
   Salesforce stores. Held since 25 August with no date; they have had the list
   since 31 August and are both on the thread.
3. **The token** — one or two, does it rotate, can it be rotated before go-live.
4. **The date `env=test` becomes pass-through**, and how ROMI is told.
5. **The `dascita` typo** — fix or freeze.
6. **Rate limits, timeout and cache TTL**, including how the re-check button
   forces a refresh.

⚠ **The entity question is untouched by any of this.** A Fase 1 integration still
depends on Pienissimo Software Srl building, hosting and running a service, and
the document — which is theirs — does not say who owns its uptime after the
project closes. **Reading a specification is not the same as having a
commitment.**

🔴 **Development on Fase 1 must end 10 September** — seven working days away, and
items 1 and 2 are what the build waits on.

🔴 **The next step is to drill the 1 September minute**, not to send questions.
Until the recording and Gemini notes are read, nobody knows which of the six are
still open.

## 24. Update 2026-09-01 (evening) — the follow-up call, drilled the same night

The instruction closing §23 was to drill the 1 September minute before chasing
anything. **That has been done.** The Gemini notes, the full transcript and the
recording were all read on the night of 1 September. The call ran ~20 minutes
from 10:02 CEST with Elena Spini, Aurel Mrruku (ROMI), Andrea Parmeggiani
(Pienissimo Software) and Elisa Migliano. Fabrizio Paganelli was invited and is
addressed twice in the room but never speaks; whether he attended is uncertain.

### 24.1 🟢 The field selection is decided, and the answer is every field

**#95 is resolved.** The action Fabrizio Paganelli and Elisa Migliano had held
**undated since 25 August** — which three consecutive sweeps recommended chasing
a date for — was discharged in the room. Aurel Mrruku walked point 6 of the
documentation field by field and **all eleven fields are taken**.

| Field                                    | Lands on                                                 |
| ---------------------------------------- | -------------------------------------------------------- |
| `ragione_sociale`                        | `Account.Name`                                           |
| `indirizzo`, `citta`, `provincia`, `cap` | the standard billing address block                       |
| `pec`                                    | **a new dedicated field on Account**                     |
| `nome_legale_rappresentante`             | **a new text field on Account**                          |
| `codice_fiscale_legale_rappresentante`   | **a new field on Account**                               |
| `data_di_dascita_legale_rappresentante`  | **a new field on Account**, misspelled key and all       |
| `luogo_nascita_legale_rappresentante`    | **a new field on Account**                               |
| `indirizzo_legale_rappresentante`        | **one single free-text field**, not a structured address |

Two shape rulings sit inside that decision:

- **The legal representative goes on the Account, not on a Contact.** Aurel
  Mrruku proposed a typed Contact record; Elisa Migliano overruled it, because
  the data is _"fondamentale per la firma dei contratti"_. He accepted while
  recording a reservation — flat Account fields carry no history, and a company
  changing its director is an ordinary event.
- **The person's address is one text field.** Andrea Parmeggiani: _"non è
  importante che salviamo il CAP del legale rappresentante"_. Note the
  asymmetry — the **company** address is structured, the **person's** is not.

🔴 **This unblocks the VAT build (#73) and simultaneously commits six fields of
unestimated work** — creation, page layout and field-level security — with nine
days to the 10 September end of Fase 1 development.

### 24.2 🟢 The environment split was invented in this call, and the shared token is deliberate

Aurel Mrruku proposed **two distinct paths** so that continuous testing never
touches production. Andrea Parmeggiani agreed on the spot — _"facciamo due path
diversi"_ — and mailed the final paths **2.5 hours later**. That is v2 of the
documentation, and it settles the open question from §23: the `:env` parameter
is an **outcome** of this session, confirmed rather than inferred.

On the token, the question in **#106** was put outright and answered:

> **Aurel Mrruku:** _"si può usare anche lo stesso token perché praticamente
> l'ambiente è lo stesso?"_ — **Andrea Parmeggiani:** _"sì, sì."_

**Two paths, one token, on purpose.** The rationale is coherent — the two
environments share a database — and it converts #106 from an unnoticed gap into
a decision both sides took knowingly. It also discharges the 25 August
test-environment action as explicitly as this project is going to manage.
🔴 What remains is narrower and still open: **rotation before go-live**, on the
assumption that a value mailed to six addresses is already public. Rotation and
expiry were not discussed at all.

Also settled: the **test environment is free and uncapped** (_"non ci sono costi,
possiamo fare chiamate a piacere"_), **production is configured identically**
save that the middleware then forwards to Anticipay, and the **happy path is
`200`**, confirmed out loud.

### 24.3 🔴 Anticipay serves Italian companies only — and that answers a requirement

Andrea Parmeggiani, unprompted and in passing:

> _"Diamo per scontato che la richiesta facciamo solo per aziende italiane perché
> Anticipay dà i dati solo per aziende italiane. Quindi la nazione non l'ho
> inserita perché è scontato che sia Italia, altrimenti torna sempre non
> trovato."_

So `nazione` is **deliberately absent** from the payload, and **a non-Italian VAT
number always returns `404`** — the same code as an unknown Italian company and,
during the test period, the same code as a cold cache. **Three distinct meanings
on one status code**, against an agreed protocol that gives `404` one meaning and
one notification.

⚠ `INT-18` is _"Anticipay VAT check timing and **foreign-VAT handling**"_. The
foreign-VAT half is not deferred to phase 2 — **it is not deliverable through
this integration in any phase**. Nobody in the room connected the remark to the
requirement. This sharpens the register contradiction §23 already recorded:
`INT-18` now needs its **scope** corrected as well as its **phase**, and both are
changes to a signed document. Still Elena Spini's to raise.

### 24.4 What the call did not touch

Four of the six questions §23 derived from the document were **never raised**:

| Question                              | After the call                                                    |
| ------------------------------------- | ----------------------------------------------------------------- |
| The **error response body**           | 🔴 still open — the last technical blocker on the build           |
| Which fields, and a date              | 🟢 closed — all eleven, above                                     |
| The token — one or two                | 🟢 closed — one, deliberately                                     |
| The date `env=test` goes pass-through | 🔴 still open, never mentioned                                    |
| The `dascita` typo (#105)             | 🔴 still open — and its escape hatch closed                       |
| Rate limits, timeout, cache TTL       | ⚠ half — test is free and uncapped; **production was not raised** |

**Chase three things, not six.** Re-asking the two that closed would cost
credibility.

On **#105**: the note argued the typo might close itself if the date of birth
were dropped. It is being stored, and nobody looked at the key names — so the
item stands and is more urgent than when written. Practical guidance meanwhile:
**build against the misspelled key as documented and keep the Salesforce field
name correctly spelled**, so a later fix costs one mapping line rather than an
org rename.

### 24.5 🔴 The personal-data question was never raised, and the decision went the other way

**#108** recommended storing the company block and dropping the person block. The
room took all five legal-representative fields onto the Account.

⚠ **That is not a rejection.** The question was never put in the twenty minutes;
recording it as "considered and declined" would be false.

🟢 **One field now has a purpose on the record** — the first the record holds.
Elisa Migliano: the legal representative is _"fondamentale per la firma dei
contratti"_. That plainly justifies **the name**.

🔴 **It does not justify the other four.** Signing a contract needs to identify
the signatory; it is not obvious why it needs the signatory's **date of birth,
place of birth, codice fiscale and home address**, and none of those was reasoned
for individually. Retention, lawful basis, **field-level security** — the fields
go on the Account, which Pienissimo administration reads routinely, the exact
exposure #108 flagged — and erasure were all unmentioned.

The revised ask is small: **five minutes at the data-model call**, one purpose
sentence per personal field, and a retention.

### 24.6 New from the call

- **#109 — the codice destinatario SDI.** Elisa Migliano asked whether the
  middleware can return it: a **twelfth** field, not in the documented contract.
  She said herself it is not critical (invoices route by PEC), but Mexal has
  _"una valanga di clienti dove lo SDI non è valorizzato"_, which makes it a
  data-quality win on the as-is registry. ⚠ Andrea Parmeggiani's first
  impression was that it is **not available**. Must not delay the eleven.
- **A data-model call, owed by Elena Spini, with no date.** She asked for it
  plainly — _"ancora non abbiamo ricevuto niente"_ — and Elisa Migliano
  immediately parked further material into it, naming **tipo fatturazione
  elettronica**. It is the natural forum for the workbook owed since July, and
  for §24.5.
- 🔴 **An action with no home: switch off the test-environment call at go-live.**
  Aurel Mrruku raised it himself, since two identical configurations risk the
  test lane firing paid production lookups. _"Lo mettiamo nei punti da
  tracciare."_ It is tracked in the meeting note and nowhere else.

### 24.7 The article registry moved, and the material is unread

Separately from the call, **Fabrizio Paganelli mailed `Anagrafica Articoli.xlsx`
at 01/09 14:04Z** to Elena Spini, Aurel Mrruku and Andrea Di Cicco, for the
**2 September** _Follow-up Anagrafica Articoli_ session: an article-registry
extract **covering the courses only**, plus _"una ipotesi di nuovi codici da
gestire solo nei bundle"_ and _"un paio di domande"_ put to ROMI for an opinion.

🟢 It is the first client-side material on **#48** since 26 August and the first
tangible output of the registry re-creation (**#98**).

🔴 **It has not been read** — a sweep cannot open a Gmail attachment — so nothing
beyond the mail body is known: not the number of codes, not the convention, not
whether it matches the A/B twin scheme Fabrizio Paganelli named himself, and not
what his questions are. ⚠ It is an **extract**, and the wording does not say
whether these are the **new** codes or the **current** ones under review.

**This is the third time the same gap has cost a day**, after the WooCommerce
payload on 27 August and the API PDF on 31 August — both of which, once opened by
hand, carried findings no inference had produced. **It is needed before the
2 September meeting, not after it.**

## 25. Update 2026-09-02 — org check against the Pienissimo UAT org

> ⚠ **This section records BUILD STATE only.** It supersedes earlier sections'
> claims about what **exists** in the org. It does **not** supersede any earlier
> section's record of what was **agreed** — a decision stays decided even where
> the implementation contradicts it.

Read-only check of **Pienissimo UAT** (`00DMA000004nMMr2AM`, partial sandbox,
API 68.0) on **2026-09-02, 08:05–08:14Z**, against `force-app/` on `DevMain` at
`4a49376`. 165 repository components compared with 1,072 org components.
Method: Metadata API listing across 20 component types, Tooling
`FieldDefinition`, `FieldPermissions`, `ObjectPermissions`,
`ApexCodeCoverageAggregate`, `ApexTestRunResult`, `FlowDefinitionView`,
`PermissionSetAssignment` and targeted SOQL aggregates.

It supersedes §22 and §19 on build state.

### 25.1 🟢 Everything in the repository is deployed, and the WooCommerce collision is gone

**All 30 project components in `force-app/` exist in the org.** No
repository-only drift for project metadata.

The route collision §22 raised is **resolved on both sides**:

|                            | 31 August                           | 2 September                 |
| -------------------------- | ----------------------------------- | --------------------------- |
| `WooCommerceOrderEndpoint` | in the repository, undeployed       | **removed from both sides** |
| `WoocommerceOrderService`  | deployed, **not** in source control | **deployed and committed**  |
| REST routes claimed        | 2 classes, 1 route                  | **1 class, 1 route**        |

The deployed class body was read back and compared with the committed file:
after normalising line endings the two are **identical**. The 848-character size
difference is exactly the CRLF-versus-LF difference across the file's ~848 lines.
A clean deploy now publishes the class that is already running.

⚠ It is safe from the _deploy_, not otherwise finished — **`INT-16` is still
unauthenticated**, so the header token ROMI owes remains the entire
authentication.

### 25.2 🔴 The eleven Anticipay fields are not built

`OI-95` was resolved on 1 September precisely so this could start. `Account`
carries **three** custom fields — `Lead_Email__c`, `Nome_Locale__c`,
`Partita_IVA__c`. **No PEC, none of the five legal-representative fields, no
representative address.** Proven absent by Tooling `FieldDefinition`, which is
not filtered by field-level security.

**Fase 1 development ends 10 September.** The fields themselves are buildable
today — they need no endpoint, no token and no further client answer. What is
blocked is the callout and the error path, not the schema.

### 25.3 🔴 The org has zero project Flows, and one of them was never versioned

Verified two independent ways, because one empty listing is not proof: the
Metadata API `Flow` list is empty, and `FlowDefinitionView` returns **79** flows
of which **none is non-namespaced**.

`Lead_Non_Risponde_Follow_Up` was added on 27 August and deleted on 31 August
with its own commit message saying so — deliberate, and **recoverable from
git**. But §22's predecessor run recorded **two** Flows on 28 August, and
`git log --all` proves only **one** flow file has ever existed in this
repository. The second was org-only and is gone, and **no surviving record names
it**.

Nothing is known to have been lost with it. The point is that the project cannot
tell — the third org-only loss in six days.

### 25.4 🔴 Two named credentials exist only in the org

`Anticipay` and `DocuSign` are configured in the org and exist in **no branch**
of this repository, as do the permission sets `DocuSign`, `Full_Permission` and
`Sales_User`.

A named credential is where the endpoint and the authentication live. Losing one
produces no compile error and no missing-component message — the callout simply
fails at runtime. A sandbox refresh takes both the credential and the only record
of how it was configured.

### 25.5 The integration scaffolding is unchanged, and now blocks a dated build

|                                     | 26 August | 2 September |
| ----------------------------------- | --------- | ----------- |
| `Integration_Configuration__c` rows | 0         | **0**       |
| its object permissions              | 0         | **0**       |
| `Integration_Log__c` rows           | 0         | **21**      |
| Remote site settings                | 0         | **0**       |

The log rows are real traffic, but they come from the **inbound** WooCommerce
endpoint, which uses none of this scaffolding. **Nothing outbound has run.**
`Integration_Configuration__c` still has zero object permissions, so no user can
read it even once a row exists.

### 25.6 Coverage: the number is unmeasured, not measured at zero

`ApexCodeCoverageAggregate` reports **0 covered, 1,646 uncovered, 0%**, up from
1,571 on 31 August as code lands. Against the 75% floor, **nothing can ship —
unchanged and still gating.**

But the figure has been read too literally. **The last Apex test run in this org
is 2026-08-04** — 10 methods, **0 failed** — while classes changed continuously
through 31 August. The aggregate is populated only by a test run and is
invalidated when classes recompile, so the stored 0% measures nothing about the
current code.

**Three project test classes are deployed**, and on their last recorded run they
passed. That does not mean coverage is secretly adequate — three test classes
against 1,646 lines will not reach 75%. It means **nobody currently knows the
real figure**. No test was run, written or offered.

### 25.7 🟢 Org access is fixed, and 🔴 UAT still cannot be exercised

The 1 September lockout no longer reproduces: the check authenticated and
completed a full inventory with no authentication failure, and Aurel Mrruku
confirmed it directly — _"yes its working, we have fixed it"_.

But **every project permission set still reaches exactly one active user**
against **8** active users, unchanged since 28 August. Business users cannot
exercise UAT.

### 25.8 Also verified

- **`Biglietto__c` is confirmed absent.** Asset holds **5** records, not 41, so
  the 37-record dataset was **not migrated**. Asset carries 8 custom fields and
  a Ticket record type; the rebuild has not started.
- 🟢 **`OrderItem.Tranche__c` is now granted** read and edit to
  `Tranche_Management`, closing the 26 August blockage. **Propagation is still
  unbuilt** — 0 of 18 order items carry a tranche.
- 🟢 **The order lifecycle is live and in use** — `Incassato` on 12 of 15 orders,
  and `Order` carries 3 custom fields. This corrects §19's record that the order
  state machine was stock and the object had no custom fields.
- ⚠ **Records stranded on deactivated values, on two objects now**: 3 of 10
  quotes (`Accepted` ×2, `Needs Review` ×1) and 3 of 15 orders (`Activated` ×2,
  `Draft` ×1). A record on a deactivated value cannot be re-saved without being
  moved first.

### 25.9 Two defects in the record itself, both corrected

**The register cited requirement ids that do not exist.** The build-state block
referenced `QUO-01` (four times) and `QUO-06` — there is no `QUO-` prefix among
the 154 requirement ids; the sales area uses `SAL-`. Where the entry text names
a requirement directly it now cites `SAL-08` and `SAL-09`; the entries that
observe the quote **state machine** carry `state_machine: quote` and no
requirement ref, because the register has no id for it. Strict validation now
passes.

**The check's own inventory reported zero email templates, and was wrong.**
Metadata API `listMetadata` cannot enumerate folder-scoped types without being
given a folder, so it returned an empty `EmailTemplate` list and recorded no
unavailability. SOQL proves **88** templates, including the project's active
`WooCommerce_Checkout_Link`. §19's claim that the org held "zero …
EmailTemplate" rested on this artefact and is **withdrawn**.

> An empty result from an instrument that cannot enumerate the thing is not
> absence. It is silence.

## 26. Update 2026-09-02 — the Anticipay endpoint moved, and now works

The third revision of the API documentation in three days, and the first time
anything on this integration has been **proven rather than read**.

### 26.1 🟢 What happened, in two hours

| Time (UTC)   | Event                                                                                                                       |
| ------------ | --------------------------------------------------------------------------------------------------------------------------- |
| **08:21:59** | Aurel Mrruku reports the host **does not resolve**: `HTTP/1.1 404 Not Found`, `Content-Type: text/html; charset=iso-8859-1` |
| **10:18:26** | Andrea Parmeggiani: _"Ho impostato un nuovo terzo livello: romi.pienissimo.com"_ — **v3** attached                          |
| **10:40:45** | Aurel Mrruku: _"Confermo che adesso funziona."_                                                                             |

So **`integration.pienissimo.com`, the host in v1 and v2, never worked at all.**
Every statement written about this API before today rested on a document
describing an endpoint that did not exist. The new host is
**`romi.pienissimo.com`** and it has been exercised by ROMI.

Two hours from report to confirmed fix. That is the second time this counterparty
has turned something around inside a morning, and it is worth recording next to
the failures.

### 26.2 v3 changes the host and nothing else

Verified by diffing the extracted text of v2 against v3 — not inferred from the
mail body. **Two lines differ**, both carrying the hostname. Everything else is
byte-identical, which means all of the following **survived a third revision
unchanged**:

- the **`data_di_dascita_legale_rappresentante` typo** (§23.7, OI-105) — three
  revisions, still there, because **nobody has asked**
- the **entirely absent error response body** (§23.4, OI-107)
- the `404` description still naming **Salesforce** as the system searched
- **the bearer token** — the same string since 31 August, now sent four times

### 26.3 🔴 Reachability is not the contract

A confirmed call is not a working integration. **No lookup has ever run**: no
`200`, no `404`, no error body has been observed by anyone. What is proven is
that the hostname resolves and TLS terminates. Everything about the payload is
still a reading of a PDF.

### 26.4 🔴 The dead host produced a finding worth more than the fix

The failure Aurel Mrruku hit by hand is precisely the one the house callout
engine handles worst.

An HTML `404` from a wrong hostname gives `404` a **third meaning**, on top of
_VAT number unknown_ and _not cached under `env=test`_:

| `404` because                                 | Body                                 | Distinguishable by      |
| --------------------------------------------- | ------------------------------------ | ----------------------- |
| the VAT number is genuinely unknown           | the API's error shape (undocumented) | —                       |
| `env=test` and the company is not cached      | same as above                        | **nothing**             |
| **the endpoint is wrong or the host is down** | `text/html`                          | **`Content-Type` only** |

Trace it through `API_Callout_Engine`: the send succeeds, `Is_Error__c` is never
set (§23.4 defect 1), `deserializeResponse` tries to parse **HTML as JSON**,
throws, and the `catch` rebuilds the log row **without `Response_State__c`**
(defect 2). **A completely dead endpoint would be recorded as an Apex parse
error with no HTTP status and no error flag** — something that reads like a
Salesforce code bug, not an outage.

Aurel Mrruku diagnosed it in seconds because he was in a mail client. Through
the engine as it stands, it would have been invisible. **This raises the priority
of the status-check-before-deserialise fix**, which was previously defensive
coding against a shape nobody had seen.

### 26.5 ⚠ The org's `Anticipay` named credential predates the move

The 2 September org check (§25) found a named credential `Anticipay` configured
in the org and in **no branch of this repository** — at **08:05–08:14Z**, which
is _before_ the new host existed and _before_ Aurel Mrruku had even reported the
old one dead.

So it was created against the only hostname anyone had: the one that never
worked. **It very probably carries `integration.pienissimo.com`.** Because it is
org-only there is no diff, no review and no deploy that would surface it; it
simply fails at runtime, as the HTML `404` described above.

**Check it in Setup before anything is wired to it**, and correct the host as
part of the retrieve §25 already asks for. ⚠ Read the endpoint only — the token
must not be copied anywhere.

### 26.6 Where this leaves the build

🔴 **Still eight days to 10 September, and the eleven fields agreed on
1 September are still not built.** The endpoint working removes an excuse, not a
blocker — the field build never needed an endpoint or a token. It remains the
cheapest unblocked work on the project.

Two small asks are now overdue and belong in **one** mail to Andrea Parmeggiani:
**an example of each error response**, and **the `dascita` typo** — fix or freeze.
He has revised the documentation three times in three days; there is no reason to
think a fourth is hard.
