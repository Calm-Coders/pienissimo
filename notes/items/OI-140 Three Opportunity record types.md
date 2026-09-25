---
id: OI-140
type: open-item
status: in-progress
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-17
updated: 2026-09-25
depends_on: [OI-49]
blocks: [OI-141]
source: notes/meetings/2026-09-17 Follow-up Interno.md
---

# OI-140 - Three Opportunity record types

Decided at [the 17/09 internal follow-up](../meetings/2026-09-17%20Follow-up%20Interno.md)
and **built and merged to `DevMain` the same afternoon.**

## The decision

Three Opportunity record types, chosen **at creation** from the offer typology,
so that a mixed product set can be routed correctly (`00:25:26`). Aurel Mrruku's
own framing of the problem in the transcript:

> _"come capirò io che recall tutor l'ordine che ha creato il tizio da
> WooCommerce è un ordine bundle? È un ordine standard o un ordine plus? Perché
> all'inizio avevamo detto che tutti gli ordini che sono recall tutor sono
> ordini bundle. Ieri però hanno detto un'altra cosa."_

That _"ieri"_ is [Data Model Parte 5](../meetings/2026-09-16%20Data%20Model%20Parte%205.md),
where Elisa Migliano corrected the assumption that tranches — and by extension
bundles — are a property of the recall-tutor flow. **The record types exist
because that assumption broke.**

⚠ **ROMI-internal. No Pienissimo attendee was present**, and the notes place the
order constraints _"in attesa della validazione finale con il cliente nella call
di venerdì"_.

## What was built

`af8a42b` (Anita Aga, 17/09 16:50:57 CEST, `DevAnita`), merged to `DevMain` in
**PR #47** at **15:01:32Z** as `d779109`.

| Record type API name       | Label                    | Business process |
| -------------------------- | ------------------------ | ---------------- |
| `Recall_Tutor`             | Recall tutor             | `Sales_Process`  |
| `Standart`                 | **Vendita Standart**     | `Sales_Process`  |
| `Plus_Attivazione_Rinnovo` | Plus Attivazione/Rinnovo | `Sales_Process`  |

All three are active and share a new `Sales_Process` business process:
`Qualificato` → `In trattativa (Prev inviato)` → `Da ricontattare - Prev.
inviato` → `Chiusa/Vinta` / `Chiusa/Persa`.

🔴 **`Standart` is a misspelling of `Standard`, and it is in both the API name
and the user-visible label.** The API name is effectively permanent once records
carry it; the label is what a tutor reads on every Opportunity. **Worth fixing
before UAT opens on 23/09**, while no data depends on it.

⚠ The Gemini summary names the third type _"vendita da tutor"_; the transcript
says _"Bundle standard oppure plus"_ and the build says _Vendita Standart_. The
build and the transcript agree; **the summary does not, and the summary is the
weaker source.**

## Also in the same commit

- A **bundle-mix constraint**, `QuoteLineItemTriggerHandler` +
  `QuoteLineItemTrigger`: a quote may hold **one Bundle or Item products, never
  both**, enforced with `addError` on the line. ⚠ The meeting decided this for
  the **order**; the build enforces it on the **Quote line items**. Whether
  that is the same rule at a different layer, or a narrower one, is not
  recorded by anyone.
- `QuoteManageProductsController` + the `quoteManageProducts` LWC and a
  `Quote.Manage_Products` quick action.
- The WooCommerce link generator — see
  [OI-49](OI-49%20WooCommerce%20checkout-link%20flow.md), where it contradicts
  the recorded design.

## Open

- 🔴 **Nobody outside ROMI has agreed the three types.** Friday's client call is
  where they are put.
- 🔴 **`Standart` → `Standard`**, both names, before records exist.
- ⚠ **Orders arriving from WooCommerce must carry their type on the API**
  (`00:29:31`). Nothing in the payload contract
  ([the WooCommerce payload contract](../The%20WooCommerce%20payload%20contract.md))
  carries an order type today, and **Sabatino Rinaldi has not been asked for
  one**. This is a third question owed by the same unreachable person.
- ⚠ **PR #49 and PR #50 both propose `DevAnitaOppTypeLogic`'s follow-on work**
  (`f4deb96`, _"logic for products that should be visible based on Opportunity
  Type"_) — **#49 targets `main`, #50 targets `DevMain`**, created 32 seconds
  apart. Merging #49 would put in-flight development straight onto `main`.

## 🔴 2026-09-22 — the misspelling is now inconsistent with itself

`Standart` survives in **six places on `origin/DevMain`** at `cf9b6b6`:
`LeadConversionQueueable.cls` · `QuoteManageProductsController.cls` ·
`Quote_Record_Page.flexipage` (×2) · `quoteManageProducts.js` ·
`Opportunity/recordTypes/Standart.recordType-meta.xml` ·
`permissionsets/Full_Permission.permissionset-meta.xml`.

🔴 **And the Lead record types added the same day are spelt correctly.** `54e0be1`
(Rexhina Hysi, 22/09 17:57 CEST, `DEV_leadDiagnose`, PR #55) adds
`Lead/recordTypes/Diretta.recordType-meta.xml` and
**`Lead/recordTypes/Standard.recordType-meta.xml`**.

So the org is heading for **`Lead.Standard` and `Opportunity.Standart` side by side**,
for the same commercial concept, with
[OI-150](OI-150%20Opportunity%20type%20comes%20from%20a%20Lead%20picklist.md) mapping one
onto the other. That is worse than a consistent typo: anyone writing a query, a report
filter or a validation rule now has to remember which object spells it which way.

⚠ **UAT opens 24 September** — in two days — and record-type API names are effectively
permanent once records reference them. The rename is still free today and will not be
tomorrow. **This is the fifth consecutive run reporting it.**

## 2026-09-23 — org-status check

Read-only check of Pienissimo UAT, 08:01–08:40Z, `DevMain` at `61f2a53`. Nothing was deployed or changed.

- ✅ All three are deployed and active: `Standart`, `Plus_Attivazione_Rinnovo`, `Recall_Tutor`. Opportunities created in the last seven days: 15 `Standart`, 5 Plus, 3 Recall, 1 with none. 🔴 **`Standart` is still misspelt** in the org, and UAT opens tomorrow. ⚠ The System Administrator profile sees **none** of the three. Only `Full_Permission` grants them. (verified)

## 2026-09-25 — the client saw the types, and one changes

At [UAT Recall Tutor e Bundle](../meetings/2026-09-25%20UAT%20Recall%20Tutor%20e%20Bundle.md), Elena Spini walked the client through the three
types at creation (Vendita standard / Recall da tutor / Plus attivazione rinnovo). Fabrizio
Paganelli: _"Per ora sì."_ The types are now client-seen. **`Recall_Tutor` is to become a
`WooCommerce` type** with a mandatory Recall Tutor / Pack Tutor origin → [OI-182](OI-182%20A%20WooCommerce%20opportunity%20record%20type%20replaces%20Recall%20Tutor.md).
🔴 `Standart` is unchanged: **seventh run**. Fixing it with OI-182 costs one deploy.

## ✅ 2026-09-25 — decided via drill-me: `Standart` is replaced, not relabelled

Handled in [OI-182](OI-182%20A%20WooCommerce%20opportunity%20record%20type%20replaces%20Recall%20Tutor.md):
new `Standard` and `WooCommerce` types, the old `Standart` and `Recall_Tutor` deactivated
once the UAT records are remapped. After seven runs, the misspelling has an owner and a
plan.
