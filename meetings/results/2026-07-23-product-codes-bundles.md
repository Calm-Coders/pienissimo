# [ROMI-PIENISSIMO] Check Codici Prodotto — Product Codes, Bundles & Classification Levels — 2026-07-23

**Sources:** [meetings/2026-07-23-product-codes-bundles-transcript.it.md](../2026-07-23-product-codes-bundles-transcript.it.md) (original Italian transcript, Fathom, 45 min) · reference file `anar_PIE_ricla.xlsx` (product master extract) shared by Fabrizio

**Attendees:** Aurel Mrruku (ROMI), Fabrizio Paganelli (Pienissimo — admin/Mexal), Elena Spini (ROMI — present ~1:00→13:40 and briefly, then dropped). Note: Fathom labels are reliable here (only three speakers); Aurel drove the questions, Fabrizio the answers.

> **Context:** working session to decode `anar_PIE_ricla.xlsx` — the product master extract Fabrizio sent — before ROMI starts building example bundles in Salesforce. No new architecture was decided that reverses earlier calls; this meeting **explains the source data** and **specifies the bundle-classification picklists**. It confirms and grounds the 07/02 and 07/07 bundle decisions in the actual file.

## How the Excel maps to what was decided (the point of this recap)

**The 7 `LIVELLO_` levels are legacy.** Fabrizio: they are "il retaggio di una serie di epoche storiche" — several are no longer used. He said in yesterday's email to **look mainly at LIVELLO_0 and LIVELLO_6**, the two he actually maintains. BUT two mid-levels carry the information that becomes the new Salesforce picklists:

- **LIVELLO_3 = the event/edition** the package was sold at (Academy 26, Food Marketing Festival 25, …). Has **42 distinct values**, but most are one-off promos/old stuff; only ~7 real events matter (see below).
- **LIVELLO_4 = the package type** ("Anno con Pienissimo", "Anno con Pienissimo Ripetente", + a would-be "con Performance Plus" never codified). Exactly **3 distinct values** — matches the file.

**First column `_ARTIP` — the record type — has three values, now decoded:**

| `_ARTIP` | Meaning                                          | Code prefix | Role                                                                                   |
| -------- | ------------------------------------------------ | ----------- | -------------------------------------------------------------------------------------- |
| **A**    | Ordinary product / all other articles            | (various)   | The real sellable items                                                                |
| **Z**    | **Rata (installment / block)** — a "prestazione" | `BLO-`      | One payment tranche of a bundle, carries the instalment price in the list-price column |
| **C**    | **Bundle / package** ("campionario")             | `PACK-`     | The container; associates the BLO blocks + the €0 component articles                   |

⚠ Do **not** confuse `_ARTIP = Z` (installment/block) with `LIVELLO_0 = "Z) Obsoleti"` (obsolete tree branch) — different things that both use the letter Z.

**The Mexal bundle mechanism, confirmed exactly as ROMI reverse-engineered it** (this is the legacy pattern being retired):

1. Create the `BLO-` codes first (`_ARTIP = Z`), each with a **list price = that instalment's amount**. These are the rate.
2. Create the `PACK-` bundle (`_ARTIP = C`). On Mexal you associate **both** the BLO blocks **and** every real component article — but the components are all **price €0 (omaggio)**, because Mexal only lets you value the `BLO` code. The €0 lines exist only to show the client what's inside each instalment.
3. Aurel's reading, confirmed by Fabrizio: e.g. `PACK-78` (Performance Plus Pack Tour 2025) = a bundle value split into 12 instalments; each `BLO` = one instalment; the block groups whichever items fall in that month. **The block is a payment date, not a product.**

## Decisions

- **The C / Z / BLO / PACK infrastructure will NOT be migrated to Salesforce.** Confirmed again (re-confirms 07/02 + 07/07). On Salesforce there is no bundle-of-installments-of-blocks: the bundle explodes into **order lines that are the real products, each with a date**, and ROMI **groups by date into instalments**. Elena restated it and Fabrizio agreed: "i blocchi non ci saranno più … righe direttamente dai prodotti con indicazione di data e poi raggruppiamo noi in base alla data per rata." The BLO codes and €0 omaggio lines disappear entirely.
- **This must be flagged in the project/blueprint document in "giallo fosforescente".** Fabrizio explicitly asked that the "no more blocks at invoicing — client sees only real product codes, priced, with dates" decision be highlighted, bold, bordered, stamped — because _he_ requested the block removal and wants it unambiguous when invoices later look different. → documentation action item.
- **Bundle price options — both delivered, business chooses per bundle.** ROMI's build supports (a) a **fixed bundle price** you type in, and (b) an **auto-calculated price from the components**. Fabrizio confirmed he wants both available (he didn't know Pienissimo's preferred default). If you set the fixed bundle price, the instalment split is set **manually**. (Consistent with the spread model, #43.)
- **Bundle classification = three picklist fields, with a dependency.** Agreed structure for a bundle record:
  1. **Anno (calendar year) — the master field.** ⚠ Use **"anno solare" (calendar year), NOT "anno accademico".** Fabrizio flagged that "anno accademico" is a _different_ Pienissimo concept (runs May→Sept, used for **ticket generation**) and would cause confusion if reused on bundles.
  2. **Evento — dependent on the year.** Salesforce dependent picklist: pick the year → only that year's events show. The business creates the year and its event subset **manually each year** (admin, no dev release).
  3. **Tipologia di bundle (package type)** — e.g. Anno con Pienissimo / Anno con Pienissimo Ripetente / other. **Independent** of both event and year (Fabrizio: "completamente slegati" — any package type can be sold at any event in any year).
- **The 7 real events (the Evento picklist seed).** Fabrizio's canonical list, in academic-year order: **Tour · Food Marketing Festival · Pienissimo Live · Academy · Sold Out · O.D.B. Live · Camerieri Venditori · (Happy Team — sells nothing) · Mastery.** He'll email the definitive list; Aurel opened the mail thread live to co-write it. The direction mainly cares about the **"Anno con Pienissimo"** package (client subscribes for a whole academic year).
- **"Genera biglietto" as a product-level flag, not code logic.** Every event has several ticket-type articles (paid, omaggio, additional). The _set_ of article codes that generate a ticket will be maintained by a **yes/no flag on the product record** in the imported article master — admin-toggleable, no developer intervention — rather than encoded/read from the code string. (Re-confirms an earlier idea; Aurel insisted on a flag over reading a letter in the code.) Article codes are **unique and stable** — Fabrizio confirmed they are not changed, which matters for keeping the ticket-generating set intact.
- **"Bundle-only" article codes flagged, not letter-coded.** Fabrizio will create ~**10 new article codes** (one per event, e.g. "Academy (B)") to be used **exclusively inside bundles** — tutors must not use them in direct sales, because **agents earn no commission on bundle sales**. Instead of encoding a "B" in the code (hard to read), ROMI will mark them with a **product-level "use only in bundles" flag**. Aurel adds the flag in Salesforce; Fabrizio replicates the same structure on his side.

## Action Items

| Task                                                                                                                                                                                                         | Owner                         | Status                                                                           |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------- | -------------------------------------------------------------------------------- |
| Email Aurel the definitive **7-event list** for the Evento picklist (Tour, Food Marketing Festival, Pienissimo Live, Academy, Sold Out, O.D.B. Live, Camerieri Venditori, Mastery; Happy Team sells nothing) | Fabrizio                      | Open — started live in the mail thread                                           |
| Send Aurel the **anno-solare + evento + tipologia-bundle** field spec Aurel wrote in the mail thread (confirm the master/dependent structure)                                                                | Aurel → Fabrizio (co-written) | Open                                                                             |
| Create ~**10 bundle-only article codes** (one per event, "(B)" convention) + send 3–5 examples to ROMI **before September**; flag them "use only in bundles"                                                 | Fabrizio                      | Open — committed "for tomorrow"; ROMI needs samples to start the selection logic |
| Build **example bundles in Salesforce** from the ~200 significant items (bundle structure only, no prices/dates yet); show at the **next meeting (~1 week)**                                                 | Aurel / ROMI                  | Open                                                                             |
| Show the **full bundle with instalments + component spread prices** — targeted **late August** (Aurel on holiday ~2 weeks mid-August)                                                                        | Aurel / ROMI                  | Open                                                                             |
| Configure the **anno-solare (master) → evento (dependent) picklists** + **tipologia-bundle** field on the bundle object                                                                                      | ROMI                          | Open                                                                             |
| Add **"genera biglietto" (yes/no)** and **"solo bundle" (yes/no)** flags to the product/article object at import                                                                                             | ROMI                          | Open                                                                             |
| **Blueprint doc:** highlight (Fabrizio's "giallo fosforescente") that BLO blocks + €0 omaggio lines are gone — invoices show only real, priced product codes with dates                                      | ROMI (blueprint)              | Open                                                                             |

## Open Questions / Risks

- **Which levels of `anar_PIE_ricla.xlsx` to trust:** officially only **L0 + L6** are maintained, yet the meeting relies on **L3 (event)** and **L4 (package type)** for the picklists. L3 is only ~55% populated and 42-valued (mostly noise); L4 is 3-valued but ~20% populated. The picklist values are being **re-created clean from Fabrizio's canonical lists**, not migrated from these columns — treat the Excel levels as reference, not source of truth.
- **Bundle instalment split when a fixed price is set** is manual today — no rule yet forces the instalments (or the component spreads) to reconcile to the fixed bundle price (ties to #43, variance enforcement).
- **~10 bundle-only codes not yet created**; Aurel needs at least 3–5 samples before September to build the selection logic. Fabrizio can't make them invisible on the website, so real early creation risks misuse — placeholder/fake examples acceptable to start.
- **Commission rule** (agents get no commission on bundle sales) is the _reason_ for bundle-only codes — worth capturing where commission logic is eventually modeled.

## Notes

- This session validates ROMI's independent reverse-engineering of `anar_PIE_ricla.xlsx`: `_ARTIP` A/Z/C, the `PACK-`/`BLO-` split, and the 108 bundles = offers-paid-in-instalments reading were all confirmed by Fabrizio against the live Mexal screen (he opened `PACK-78` and an "Anno con Pienissimo" order and exploded them).
- Fabrizio demoed a live Mexal order explosion: block 1 = first instalment (deposit, e.g. €900) + its component items, block 2 = second instalment + its items, and so on up to the full bundle value.
- The "Significativi" tab (~200 items) is the working set Aurel will use for the first Salesforce example bundles.
- Terminology guard captured: **anno solare (bundles) vs anno accademico (May→Sept, ticket generation)** must stay distinct fields to avoid confusion.
