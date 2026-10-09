---
id: OBJ-mappatura-edizione
type: object
status: active
owner: Anita Aga
org: ROMI
raised: 2026-09-04
updated: 2026-10-09
depends_on: [OI-96]
blocks: [OI-53, OI-84]
source: git DevMain 68c4342 (PR #34), metadata and Apex read directly 2026-09-04
---

# The Mappatura Edizione object

**[OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md) is
built.** `Mappatura_Edizione__c` was merged to `DevMain` on **4 September 2026**
in **PR #34** (commit `68c4342`, Anita Aga, _"Added record types on Campaign,
custom object Mappatura Edizione, logic on Campaign mapping on Asset"_, merged
by Aurel Mrruku at 16:06 CEST).

Read from the metadata and Apex in the repository, not from the org.

## The object

Auto-numbered `ME-{0000}`, label **Mappatura Edizione**, history tracking on,
`sharingModel` ReadWrite. Its own description states the intent:
_"Mappatura manuale che associa un prodotto evento e una finestra di data ordine
alla campagna figlia dell'edizione."_

| Field            | Type                     | Required | Carries                                      |
| ---------------- | ------------------------ | -------- | -------------------------------------------- |
| `Prodotto__c`    | Lookup → `Product2`      | by rule  | the event product or bundle component        |
| `Data_Inizio__c` | Date                     | yes      | first **order date** in the window           |
| `Data_Fine__c`   | Date                     | yes      | last **order date** in the window            |
| `Campagna__c`    | Lookup → `Campaign`      | yes      | the Campagna Figlio this window maps to      |
| `Data_Evento__c` | Date                     | no       | the **real event date**, OI-96's _colonna G_ |
| `Attiva__c`      | Checkbox, default `true` | —        | whether the mapping is used                  |

Validation rules: `Data_Fine_Dopo_Inizio`, `Prodotto_Obbligatorio`.
`Campagna__c` carries a **lookup filter** restricting it to Campaigns whose
record type is `Campagna_Figlio` **and** which are active, with `deleteConstraint`
`Restrict`.

## How it matches what was agreed

🟢 **All three properties OI-96 called easy to get wrong are honoured.**

1. **It resolves per order line.** `OrderBigliettoTriggerHandler.assignCampaigns`
   works over `TicketSource` records, one per order line — **and one per bundle
   component**, so a bundle spanning two editions resolves each leg separately.
   That is the case which killed the one-active-child-campaign rule on 26 August.
2. **The windows are order-date windows**, matched against `Order.EffectiveDate`.
3. **`Data_Evento__c` is separate**, and its description says so in the same
   terms the note does: _"Data reale dell'evento, distinta dalla finestra usata
   per abbinare la data ordine."_

🟢 **Two things were built that nobody specified, and both are improvements.**

- **`Prodotto__c` is a lookup to `Product2`, not a text article code.** OI-96
  described the key as the Mexal `_ARCOD`. A lookup cannot drift from the product
  registry and cannot be broken by the article-code normalisation hazard
  ([the risk](../risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md)).
- **Overlapping windows are refused.** `MappaturaEdizioneTriggerHandler`
  validates on before-save, both **within the transaction** and **against
  existing active rows**, in one bounded SOQL over the affected products and date
  span, and blocks with _"Esiste gia una mappatura edizione attiva per questo
  prodotto con date sovrapposte."_ Nothing in the record asked for this; without
  it, the edition of an order line would be ambiguous.

## 🔴 The table is empty, hand-maintained, and now gates the order lifecycle

`assignCampaigns` **throws** rather than degrading:

- no active mapping matches the product and order date → `TicketGenerationException`
  _"Nessuna mappatura edizione trovata…"_;
- more than one matches → _"Mappature edizione sovrapposte…"_;
- the order has no `EffectiveDate` → _"Data ordine mancante…"_.

It is called from `createTicketsForConfirmedOrders`, which fires when an Order
**transitions into `Incassato`**. So an unmapped product does **not** block order
creation — it blocks the move to `Incassato`, and rolls the update back.

That is the narrow reading and it is the correct one. It is still a new hard
dependency:

- **the order lifecycle is live and in use** — the 2 September org check found
  `Incassato` on 12 of 15 orders;
- **`Mappatura_Edizione__c` is populated by hand** and no row exists in source
  control;
- **nobody has been asked to populate it.** OI-96 records the mechanism and
  Fabrizio Paganelli's worked example; it names no owner for the data, and the
  ~1000-article Mexal registry re-creation
  ([OI-98](../items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md))
  would invalidate product references anyway.

See [OI-121](../items/OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md).

## Campaign record types arrived with it

The same PR adds Campaign record types **`Campagna_Padre`** and
**`Campagna_Figlio`** with validation rules `Campagna_Figlio_Richiede_Padre` and
`Campagna_Figlio_Richiede_Date`, a `Campaign_Management` permission set, a
Campaign layout and a Mappatura Edizione layout, flexipage and tab.

🟢 **This is the first time
[the campaign parent and child model](The%20campaign%20parent%20and%20child%20model.md)
exists as metadata** rather than as a design note.

⚠ **+~230 uncovered Apex lines** across `MappaturaEdizioneTriggerHandler` (132)
and the `OrderBigliettoTriggerHandler` additions (~93), recorded against
[the coverage deficit](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
and **not acted on**.

## 2026-10-09 - category auto-mapping

`MappaturaEdizioneTrigger` now also runs **after insert**. A new mapping
creates one more mapping per product with the same `Categoria_Articolo__c` on
the same campaign. It skips products already mapped to that campaign or with an
active overlapping mapping. Rationale and checks:
[OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md).

**Searching the Prodotto lookup by category (09/10).** The search index already
finds products by `Categoria_Articolo__c`: a SOSL `FIND {E02}` in UAT returned
the 18 E02 products. The field was added after Product Code in the Product2
search layouts (lookup dialog, phone lookup, search results). It is visible in
the full results ("Mostra tutti i risultati"). UAT only, not committed.
⚠ Not verified in a browser whether the instant typeahead also matches on it.

**New form with product search (09/10).** The **New** button (Large and Small)
now opens the LWC `mappaturaEdizioneNew` through the Aura wrapper
`mappaturaEdizioneNewOverride`; action overrides need Aura.

- Its Prodotto search (`MappaturaEdizioneProductSearch`) matches name, product
  code and `Categoria_Articolo__c` **while typing**, up to 50 results with active
  products first. Each result shows code · category · active.
- Campagna and Attiva are standard fields, and saving is the standard save, so
  validation and the category auto-mapping trigger run as before.
- New from a campaign's related list pre-fills the campaign.
- Class access is on `Campaign_Management` and `Full_Permission`; in UAT,
  `Full_Permission` is UAT's version plus that one class, because of drift.
- UAT only, not committed. Checked from Apex: `SFHT0001` returns 1, `E02` 18,
  `happy` 27. ⚠ **Not tried in a browser.**
- Same day, it was restyled as a popup that mirrors the standard form:
  - an SLDS modal over a grey backdrop. Salesforce renders New overrides as a
    page, so the list is not visible behind it;
  - "* = Required Information", the two grey sections, inline labels, and
    Cancel / Save & New / Save;
  - after Save it opens the new record, or the campaign when started from its
    related list.
- Later the same day:
  - **"Informazioni di Sistema" removed.**
  - **A "Categoria Prodotto" search added next to Prodotto.** It lists the
    distinct `Categoria_Articolo__c` values grouped from Product2, with a
    description (`Evento__c` covering at least 10%, else `Livello_0__c`) and
    product/active counts.
  - **Choosing only a category saves the mapping on one product of it**
    (`findProductToMap`: active first, skipping products already on the campaign
    or with an active overlapping mapping). The trigger maps the rest.
  - **With a category chosen, the Prodotto search is limited to it.**
  - Prodotto or Categoria is required; the asterisk is dropped from both.
  - Checked from Apex in a rolled-back transaction: 23 categories, E02 18/3; an
    E02-only save gave 18 mappings.
  - **Live use:** Aurel Mrruku's own C40 mapping at 16:08 UTC created 7 mappings
    on "Test Edizione Accademy 2026" (ME-0159 to ME-0165).
- **Then moved into Salesforce's own modal** (`lightning/modal`), for the native
  close X, header and backdrop.
  - Components: the Aura wrapper → the launcher LWC `mappaturaEdizioneNew` → the
    `mappaturaEdizioneNewModal`.
  - The Apex methods are **not cacheable**, at Aurel Mrruku's request, so the
    categories and products are read live every time.
  - After Save or Cancel the user returns to the campaign when started from its
    related list; otherwise to `backgroundContext` (the list view and filter
    behind New) or, failing that, the previous browser page.
  - A token re-opens the modal on every New click, because the override page is
    cached.
