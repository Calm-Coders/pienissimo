---
id: meeting-2026-09-18-data-model-parte-6
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-09-18
updated: 2026-09-21
source: Gemini notes doc 1vGG6vfj5ArZ8NPnI4_Z7FuPTtNcdhCVnH5_y1xHK79c (read in full)
---

# 2026-09-18 Data Model Parte 6

**Client-facing.** 18/09 11:08 CEST, booked for two hours, ran **2h27m**. The
sixth and last Data Model session, on **campaigns, events and discounts**.

## Attendees

Elena Spini, Aurel Mrruku, **Fabrizio Paganelli** (left ~`01:58`), **Elisa
Migliano**, **Rebecca Marmo** (left ~`02:12`). **Sabatino Rinaldi was invited and
did not attend** — Elena had been with him on WooCommerce immediately before.

Drilled from the Gemini notes document, read in full (~42k tokens, the largest
read of the 21/09 sweep). ⚠ Speaker attribution in this project is chronically
unreliable; where the summary and the transcript disagree the transcript wins.
"Creosoft"/"Mirco" in the notes are Kreosoft / Mirko Merendi.

## Agreed

**Discounts**

- **Discounts live only on article lines.** Fabrizio Paganelli proposed an
  order-header discount for global rounding; after a technical exchange with
  Aurel Mrruku the group **removed header-level discounting entirely** to avoid
  proportional-allocation problems (`00:13:20`, `00:14:47`).
  → [OI-145](../items/OI-145%20Order%20header%20discounts%20are%20removed.md)
- **Fixed prices are preferred over percentage discounts**, because of decimal
  rounding in Mexal and SAP. Entering a fixed price **overwrites** a previously
  set percentage (`00:07:18`, `00:10:11`).
- **Bundles are excluded from manual discounting** — a bundle's price is set at
  creation (`00:06:05`).
- The invoice must show quantity, list price, total, discount applied and net
  amount, for commercial reasons. Aurel Mrruku agreed to verify with Andrea Di
  Cicco that the API carries all of them to Mexal (`00:11:45`).

**Campaigns and events**

- **Parent/child campaigns.** The parent is the event container, created
  **manually by amministrazione**, and holds the association to the
  ticket-generating product. The child is the single edition (`00:25:34`).
- **Product-to-campaign association runs through a dedicated, manually managed
  table in Salesforce**; the system then attaches the correct child campaign
  automatically from the order date against the child's competenza start/end
  dates (`00:30:14`, `00:34:01`, `00:45:02`).
- **The reference product is indicated by hand on the parent campaign**
  (`02:05:40`). Owner: Rebecca Marmo.
- **An automatic overlap check prevents two child campaigns of the same event
  from overlapping in date.** Aurel Mrruku accepted the build (`00:50:42`).
- **`tipologia evento` becomes mandatory at event creation** — live, online /
  streaming, webinar, altro (`01:22:51`).
  → [OI-148](../items/OI-148%20Tipologia%20evento%20is%20mandatory%20at%20event%20creation.md)
- **Unscanned tickets are set to `non utilizzato` automatically three days after
  the event ends**, which makes the earlier fields redundant. Tickets are bound
  to their event and **cannot be carried into the following year** (`01:06:32`).
  → [OI-147](../items/OI-147%20Unused%20tickets%20close%20three%20days%20after%20the%20event.md)
- **A new `ingressi` structure** — a child entity on the ticket/asset,
  auto-populated from the periods defined on the child campaign, recording the
  **date and time of each individual entry**. Built for multi-day events: the
  Mastery (six days across two months), Pienissimo Live, the Academy
  (`01:42:47`, `01:48:59`, `01:50:33`, `01:59:16`).
  → [OI-146](../items/OI-146%20Ingressi%20structure%20for%20multi-day%20events.md)
- **Test data arrives as an Excel template** Elena Spini supplies and the client
  fills with real data (`02:08:04`).

**Fields kept and removed on campaigns / editions**

- Kept: academic year (e.g. `2026-2027`), competenza dates, Zoom meeting ID for
  online events, the infopoint registration link, and the **first reminder send
  date** (30 or 60 days before the event — the same undecided value
  [OI-81](../items/OI-81%20Event%20communication%20funnel.md) carries).
- Removed: the dedicated ticket table, the registration-form block, emails-sent
  and opt-out counters (marketing automation owns those), the secondary email,
  the HTML text for the registration block, the cancelled-registration mode, the
  closure-expired outcome and the academic-year-update field
  (`00:32:36`, `00:41:41`, `00:58:25`, `01:19:29`, `02:03:49`).

## Deferred

- 🔑 **Instalments and tranches — the definitive agreement was deferred to a
  dedicated session with the technical and administrative teams.** It became the
  22/09 11:00 `Logiche Spacchettamento Righe` booking.
- **Scan-data integration is Fase 2.** There is **no native Salesforce API flow
  to receive scan data from the external scanning application** (`01:28:13`).
  Elisa Migliano is to ask Andrea Parmeggiani for the integration; Elena Spini
  placed the logic in Fase 2. The `edizione precedente controlla` field for
  multi-part events (Mastery part 2 requires part 1 attendance) goes with it
  (`01:26:40`).
- **The infopoint side is on hold** pending Andrea Parmeggiani's feedback;
  Rebecca Marmo is to confirm the link is used only for free-event check-in
  registration — tour, food, soldout (`01:04:03`, `01:18:13`).

## Problems raised and not solved

- 🔴 **High-value instalment products have no clean mechanism.** For a course
  such as the Mastery, splitting the order into sub-orders or multiple products
  **creates complex movement problems in both Salesforce and Mexal**, affecting
  invoicing and ticket availability. Elena Spini and Aurel Mrruku floated child
  products; **Elisa Migliano objected that this would alter the structure of the
  accounting movements** (`02:12:47`). ⚠ This is the client's operational
  authority pushing back on
  [OI-142](../items/OI-142%20Fractional%20product%20records%20for%20tranche%20payment.md),
  the fractional-product ruling ROMI took internally the day before. **Later
  evidence, and it is a client objection against a ROMI position.**
- 🔑 **Elisa Migliano's counter-proposal**: dedicated Salesforce fields for the
  instalments and their **invoice dates** (tranche), mirroring what tutors
  already type by hand, so Mexal can receive the payment plan. Aurel Mrruku
  confirmed it is technically feasible on the Salesforce side; verification with
  Mirko Merendi and Fabrizio Paganelli on the Mexal side was left open
  (`02:21:11`). → that verification is what
  [OI-143](../items/OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md)
  now answers, and the answer is worse than the proposal assumed.
- 🔴 **San Marino fiscal law requires sales revenue to be split between Italy,
  San Marino and abroad**, and the warehouse-movement causale must be tracked
  correctly through to Mexal's prima nota (`00:14:47`, `00:16:13`).
  → [OI-155](../items/OI-155%20San%20Marino%20revenue%20split%20and%20warehouse%20causale.md)
- 🔴 **Zero-price orders are a technical problem in the CRM.** Aurel Mrruku and
  Elena Spini compared generating them through an offer versus entering products
  directly, and deferred to tests the following week (`01:11:44`). The group also
  owes a test of ticket generation from zero-price offers.
- ⚠ **Rinvii to the following year are handled today by editing the academic
  year**, to avoid wrong stock movements. Elisa Migliano is worried about
  long-term traceability (`01:09:31`). Aurel Mrruku's answer is a dedicated
  report over unused tickets by child campaign (`01:15:41`, `01:16:54`).
- 🔴 **Products are missing or have been changed repeatedly.** Elena Spini
  established the need for **a single file collecting the totality of products
  and bundles** (`02:10:19`), plus a decision on Zoho-stored contracts and
  documents and whether they are associated manually in Salesforce.

## Governance

🔑 Elena Spini complained in the session about the **absence of formal feedback
on the plans and about Sabatino Rinaldi's availability** (`01:54:56`). **Fabrizio
Paganelli undertook to intercede with Daniela Morgese**, and agreed with her that
**environment testing would be run directly by Elisa Migliano and Fabrizio
Paganelli** to protect the go-live date (`01:55:50`). This is the origin of the
referent change Elena published on 21/09: the project referent moves from
Sabatino Rinaldi to Fabrizio Paganelli.

⚠ **28 and 29 September are the Food event at Riccione** (setup and running).
Elisa Migliano flagged both days; the UAT proposal accounted only for the 29th,
and no session was proposed on the 28th either way.

## Action items

| Owner                             | Action                                                                     |
| --------------------------------- | -------------------------------------------------------------------------- |
| Elena Spini, Aurel Mrruku         | Define with Andrea Di Cicco how discount values travel over the API        |
| Fabrizio Paganelli, Elena, Aurel  | Meeting with Mirko Merendi on the Mexal data flow, causali and prima nota  |
| Aurel Mrruku                      | Child-campaign date-overlap validation; asset association rules            |
| Aurel Mrruku                      | Build the `ingressi` structure ⚠ **suspended by Elena Spini on 18/09**     |
| Elena Spini                       | Marketing review meeting with Fabrizio Mastracci and Rebecca Marmo         |
| Rebecca Marmo                     | Ask Andrea Parmeggiani about the infopoint registration link               |
| Elisa Migliano                    | Ask Andrea Parmeggiani for the scan-app API integration                    |
| Elisa Migliano, Rebecca Marmo     | Populate the Excel test-data file                                          |
| Fabrizio Paganelli, Elisa Migliano| Run the environment tests                                                  |
| Aurel Mrruku                      | Create a couple of test campaigns directly in Salesforce                  |
| Elena Spini                       | Send the test calendar split by topic ✅ done 18/09 18:39 CEST             |
| Elisa Migliano                    | Brief Fabrizio Paganelli on the rate/tranche proposals before the session |

⚠ **The `ingressi` action was stopped the same evening.** Elena Spini, DM to
Aurel Mrruku 18/09 17:51:09 CEST: _"per il discorso periodo/ingressi che è uscito
oggi in call non fare nulla, ok? poi ne riparliamo lunedì"_. Monday 21/09 came
and went with no artifact revisiting it.
