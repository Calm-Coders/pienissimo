---
id: ref-anagrafica-articoli-workbook
type: reference
status: active
owner: Elisa Migliano
org: Pienissimo
raised: 2026-09-01
updated: 2026-09-02
source: Gmail - "Anagrafica Articoli", Fabrizio Paganelli to Elena Spini, Aurel Mrruku and Andrea Di Cicco, 2026-09-01T14:04:00Z; workbook read 2026-09-02
---

# The Anagrafica Articoli workbook

`Anagrafica Articoli.xlsx` - Fabrizio Paganelli's attachment to the mail
**"Anagrafica Articoli"**, sent **2026-09-01 at 16:04 CEST** for the 2 September
follow-up, and **read on 2026-09-02**.

⚠ **The workbook carries real catalogue prices.** This note records **structure
only, never a value** - [docs/publishing.md](../docs/publishing.md). Article
codes are recorded, because the new ones are the deliverable.

## Provenance

Author `Pienissimo`, **created 2026-09-01 13:47:52Z, last modified 13:59:38Z** -
**five minutes before Fabrizio sent it**. Built for this mail, not a recycled
export. **One sheet** (`Foglio1`), 43 article rows, 7 columns, no hidden rows or
columns, no merged cells, no formulas, no cell comments.

⚠ **The "paio di domande" are not in the file.** The mail says _"ho un paio di
domande da valutare anche in base ad un vostro parere"_ and the workbook contains
no question, note or comment anywhere. They were **put verbally at the
2 September meeting**, not sent in writing. Anyone looking for them in the
attachment will not find them; the record of them is
[the meeting](meetings/2026-09-02%20Follow-up%20Anagrafica%20Articoli.md).

## The seven columns

| Column             | Content                                                               | Salesforce target                                                                             |
| ------------------ | --------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| `Genera Biglietto` | `SI` on **all 43 rows**, without exception                            | `Product2.Genera_Biglietto__c` (Checkbox) - exists                                            |
| `Solo Bundle`      | Two values, free text - see below                                     | `Product2.Solo_Bundle__c` (Checkbox) - exists                                                 |
| `CODICE`           | The article code                                                      | `Product2.Code__c` (Text 255, unique, external id) - exists                                   |
| `Articolo`         | The article name                                                      | `Product2.Name`                                                                               |
| `Evento`           | The event, **11 distinct spellings for 9 events**                     | `Product2.Evento__c` (Picklist) - **exists and does not fit**, see below                      |
| `Tipo Biglietto`   | `Executive`, `Diamond`, `Gold` on 13 rows; empty on 30                | **no field exists** - [OI-76](items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md) |
| `Prezzo Listino`   | List price on all 33 non-bundle rows; **empty on all 10 bundle-only** | `Product2.Product_Price__c` (Currency, **scale 0**)                                           |

`Genera Biglietto` being `SI` on every row means the sheet is an extract of
ticket-generating course articles only - _"un estratto di anagrafica articoli con
solo i corsi"_ - so it says nothing about the `natura` flag's behaviour on
non-course articles.

## The bundle-only codes - the deliverable

`Solo Bundle` splits the 43 rows exactly two ways:

- **`Utilizzabile solo ordini no bundle`** - 33 rows, all existing Mexal codes
  (`CS...`, `CO...`), all priced.
- **`Utilizzabile solo in bundle`** - **10 new codes**, all unpriced.

The ten, which are the answer to
[OI-48](items/OI-48%20Bundle-only%20article%20codes.md):

| Code       | Article                           | Event                   | Tipo Biglietto |
| ---------- | --------------------------------- | ----------------------- | -------------- |
| `SFAC0001` | ACADEMY                           | Academy                 |                |
| `SFCV0001` | CAMERIERI VENDITORI EXECUTIVE     | Camerieri venditori     | Executive      |
| `SFFM0001` | FOOD MARKETING FESTIVAL DIAMOND   | Food Marketing Festival | Diamond        |
| `SFFM0002` | FOOD MARKETING FESTIVAL GOLD      | Food Marketing Festival | Gold           |
| `SFFM0003` | FOOD MARKETING FESTIVAL EXECUTIVE | Food Marketing Festival | Executive      |
| `SFHT0001` | HAPPY TEAM                        | Happy Team              |                |
| `SFMS0001` | MASTERY                           | Mastery                 |                |
| `SFOD0001` | ODB LIVE                          | ODB Live                |                |
| `SFPL0001` | PIENISSIMO LIVE LIVE              | Pienissimo Live         |                |
| `SFSO0001` | SOLD OUT                          | Sold Out                |                |

**The convention is `SF` + a two-letter event abbreviation + a four-digit
sequence.** `SF` is evidently for Salesforce: these codes **do not exist in
Mexal**, which is the point of them.

⚠ **This is a third naming convention, not the one agreed.** The 23 July ask was
a **`(B)` suffix**; on 26 August Fabrizio Paganelli named it himself as **`codice
A` / `codice B`**. What arrived is neither. The _mechanism_ is exactly what was
agreed - a twin article per sellable ticket, distinguished by `Solo_Bundle__c` -
but nobody should search for a `B` code.

⚠ **`SFPL0001` is named `PIENISSIMO LIVE LIVE`.** Almost certainly a typo for
`PIENISSIMO LIVE`. Worth one line back to Fabrizio Paganelli before it is loaded
anywhere, because the name is what a seller reads.

⚠ **Not one per event, as OI-48 assumed.** Food Marketing Festival gets **three**
(one per tier), and **Pienissimo Intensive gets none at all** despite carrying 8
articles - the largest single event block in the sheet. Whether Intensive is
deliberately excluded from bundles is unasked.

## What it says about the events

Nine events appear, in **eleven spellings**. The inconsistencies are all on the
new bundle-only rows, and they matter because `Evento__c` is a picklist:

- `Camerieri Venditori` (3 rows) vs **`Camerieri venditori`** (`SFCV0001`)
- `Odb` (2 rows) vs **`ODB Live`** (`SFOD0001`)

🟢 **`Pienissimo Intensive` now has articles** - 8 of them, in four durations
(2/4/6/8 giornate), each with a free twin. On 7 August it was _"Evento in fase di
ridefinizione"_ with **no articles at all**. The redefinition has produced a
product line, and nobody has said so.

⚠ **`Tour` and `Golden Numbers` have no articles here.** Golden Numbers is
consistent - it was cancelled. **`Tour` is not**: it was a live free event on
7 August and it is a value in the deployed picklist. Its absence is unexplained.

## Against the built org - what would actually load

Checked read-only against **Pienissimo UAT** (`00DMA000004nMMr2AM`) on
2026-09-02. `Product2` holds **281 records**.

🔴 **Only 25 of the 43 rows carry an event the picklist can accept.**

| Event in the workbook  | Rows | Deployed picklist                          |
| ---------------------- | ---- | ------------------------------------------ |
| `Pienissimo Intensive` | 8    | **absent**                                 |
| `Camerieri Venditori`  | 3    | **absent** - the picklist says `Camerieri` |
| `Happy Team`           | 3    | **absent**                                 |
| `Odb`                  | 2    | **absent** - the picklist says `Odb Live`  |
| `Camerieri venditori`  | 1    | **absent**                                 |
| `ODB Live`             | 1    | case-only mismatch with `Odb Live`         |

The nine deployed values are `Tour`, `Food Marketing Festival`,
`Pienissimo Live`, `Academy`, `Sold Out`, `Odb Live`, `Camerieri`, `Mastery`,
`ND`. Repository and org **agree exactly** here, so this is not drift - it is a
picklist that was never reconciled with the client's own event names. It extends
[the Happy Team defect](items/OI-46%20Bundle%20classification%20picklists.md) from
one missing value to **five**.

🟢 **Renaming is free.** `Evento__c` is populated on **3 of 281 products** - one
each on `Pienissimo Live`, `Academy` and `Tour`, and **blank on 278**. There is
no data migration cost to correcting these values, and no reason to prefer the
built spelling over the client's.

🔴 **`Tipo_Biglietto__c` does not exist**, in the org or the repository, so the
13 rows carrying `Executive`/`Diamond`/`Gold` have nowhere to go. Confirmed by
Tooling `FieldDefinition`. `Tipologia__c` (Text 255) exists but is a generic
field, and nothing establishes it as the ticket type. The 2 September meeting
assigned the field to Aurel Mrruku -
[OI-76](items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md).

🟢 **None of the ten `SF` codes exists in the org yet** - `Code__c LIKE 'SF%'`
returns zero rows. Nothing has been loaded, and nothing will collide.

## Why the code shapes matter

Four shapes across the 33 Mexal codes: `CS999999` (10), `CS-99999` (13),
`CS-9999` (2), `CO-9999` (8), plus the ten `SF` codes. The hyphen and the
zero-padding are **not consistent within an event or within a product family**.

🔴 **This sheet contains three code pairs that a normalising integration would
merge**, which is the first live proof of
[that risk](risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md):

| Normalised | The two real codes                                                        |
| ---------- | ------------------------------------------------------------------------- |
| `CS3`      | `CS-00003` Camerieri Venditori Executive · `CS000003` Sold Out Aggiuntivo |
| `CS58`     | `CS000058` FMF Gold · `CS-00058` FMF Gold **(OMAGGIO)**                   |
| `CS61`     | `CS-00061` FMF Gold Aggiuntivo · `CS-0061` **O.D.B. Live** Omaggio        |

Two of the three cross **different events**. The `CS58` pair is worse in kind
than it looks: it merges a **paid** ticket with its **free** twin.

⚠ **Salesforce itself will not merge them** - `Code__c` is unique and
case-insensitive, but hyphens and leading zeros are ordinary characters, so all
43 codes coexist. The danger is entirely in **our own** mapping code: `Code__c`
is an **external id**, so an upsert keyed on a normalised code would silently
overwrite one product with another.

Related: [the article code namespace](objects/The%20article%20code%20namespace.md),
[OI-98](items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md),
[the 2 September meeting](meetings/2026-09-02%20Follow-up%20Anagrafica%20Articoli.md).

## 2026-09-02 - built and loaded

The blockers above are cleared and **the ten bundle-only codes are in Pienissimo
UAT**. What was done, in order:

1. **`Product2.Evento__c`** - added `Happy Team` and `Pienissimo Intensive`,
   renamed `Camerieri` to `Camerieri Venditori` and `Odb Live` to `Odb`, with the
   dependency mappings the restricted picklist needs. The picklist now carries
   **11 values** and matches the client's own event names.
2. **`Product2.Tipo_Biglietto__c`** - new restricted picklist,
   `Executive` / `Diamond` / `Gold`.
3. **`Product2.Stato_Bundle__c`** - new restricted picklist,
   `In lavorazione` / `Confermato`. ⚠ **Provisional**: the value set and the
   choice of `Product2` as host object are inferred from a Gemini summary, and
   the field's own `description` says so.
4. **`Product_Registry_Admin`** permission set - grants edit on both new fields
   and nothing else, so "editable by system administrators only" is expressed in
   source control rather than as an org-only profile edit.
5. **The ten records**, `RecordType = Item`, `Solo_Bundle__c` and
   `Genera_Biglietto__c` both true, `Tipo_Biglietto__c` set on the four that
   carry a tier.

All five artifacts are in `force-app/` **and** deployed, so this adds no new
org-only drift.

⚠ **Three deliberate choices, none of them the client's:**

- **`Anno_Solare__c` is set to `Anno Solare 2026` on all ten.** The workbook has
  **no year column**, but `Evento__c` is a dependent picklist and will not accept
  a value without its controlling field. The year is **ROMI's assumption**, and
  it is the same field
  [OI-46](items/OI-46%20Bundle%20classification%20picklists.md) questions the
  existence of.
- **`PIENISSIMO LIVE LIVE` was loaded as written.** Correcting a client's data
  silently is worse than carrying a visible typo; it is flagged for Fabrizio
  Paganelli instead.
- **`Code__c` was populated as well as `ProductCode`.** See below - this makes
  the ten inconsistent with the other 281, in the direction of more information.

## What loading it revealed about the existing catalogue

⚠ **Correction, 2026-09-02.** An earlier version of this section claimed
`Code__c` was empty on every product, that only 9 of the workbook's 33 Mexal
articles were in the org, and that `Genera_Biglietto__c` was false on all of
them. **All three were wrong.** They came from sampling four records and
generalising. Counted properly against all 291:

🟢 **`Code__c` is the article key in use.** It is populated on **259 of 291**
products and null on 32. The two fields hold **disjoint populations**: the 259
carry `Code__c` with `ProductCode` empty, and the minority carry `ProductCode`
with `Code__c` empty. The sample that produced the wrong claim happened to land
entirely in the minority.

🟢 **29 of the workbook's 33 Mexal articles are already in the org**, matched on
`Code__c`. Four are not: `CS000057`, `CS-00058`, `CS-00141`, and `CS-00115`.

🔴 **`CS-00115` is not missing - it is spelled differently.** The workbook calls
ACADEMY OMAGGIO `CS-00115`; the org calls the same article **`CS000115`**. That
is [the normalisation risk](risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md)
appearing as a **live mismatch between the client's file and the org**, not as a
hypothetical. The other three unmatched codes may be the same thing and have not
been checked one by one.

🔴 **`Genera_Biglietto__c` is true on only 3 of the 29**, though the workbook
says `SI` for all 43. **Not corrected here** - it touches records this session
did not create, and the workbook is
[provisional against the registry re-creation](items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md).

🔴 **`Code__c` is load-bearing for the live WooCommerce integration.**
`WoocommerceOrderService` - the deployed class taking real traffic - selects
`Product2.Code__c`, matches incoming SC codes against it, and raises
_"No Salesforce Product2.Code__c match for SC code(s)"_ when it cannot. It is
also on two layouts, two flexipages, the `Bundle_Demo` permission set and three
test classes. **The field cannot be deleted while that class references it**, and
deleting it would destroy the article code on 259 products.

⚠ **The ten records this session loaded set both `Code__c` and `ProductCode`**,
which matches neither population. Harmless, but inconsistent; worth normalising
to `Code__c` alone when the registry is reloaded.

⚠ **The load also cost an hour to a trap now written down** -
[how to add a picklist value that records can actually use](How%20to%20add%20a%20picklist%20value%20that%20records%20can%20actually%20use.md).

## 2026-09-02 — who wrote it, and what the "paio di domande" were

⚠ **Elisa Migliano wrote this workbook, not Fabrizio Paganelli.** It was sent
from his mailbox and this note attributed it to him. On the recording of the
[2 September session](meetings/2026-09-02%20Follow-up%20Anagrafica%20Articoli.md)
she says so twice — _"ieri vi ho mandato quel file"_ and _"questo qui è un file
che ho fatto io a mano, ci ho aggiunto anche i campi che avevamo definito insieme
l'altro giorno"_. They attended that session from the same room. **Ask her about
its contents.**

🟢 **The _"paio di domande"_ that were in neither the mail nor the file were asked
verbally, at the top of that call, and both were answered.** This note recorded
them as unknown; they are:

1. **_"vale la pena di impegnare un campo di mexal per solo 15 codici
   articolo?"_** — is `tipo biglietto` worth a scarce Mexal field for ~15 codes?
   **Answered no**; it becomes Salesforce-only and administrator-editable
   ([OI-76](items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md)).
2. **_"prezzo di listino sui ci metto zero, dico bene?"_** — do the bundle-only
   codes carry a zero list price? **Answered no**; they keep their real price and
   the bundle price is set on the association
   ([OI-48](items/OI-48%20Bundle-only%20article%20codes.md)).

So the blank price column in the red rows is **a question in the file, not a
specification** — the reading this note took as provisional turns out to be the
right one, and it is now settled.

⚠ Her own description of the colour coding, from the call: **blue rows are
today's article codes usable only on tutor orders and never in a bundle**; **red
rows are the hypothesis for new codes usable only inside bundles**. This note
decoded the red set correctly; the blue set's _"utilizzabile solo ordini no
bundle"_ meaning had not been stated anywhere before.
