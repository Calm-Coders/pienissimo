---
id: meet-2026-10-13-feedback-test-uat
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-10-13
updated: 2026-10-13
source: Google Drive 1Lbc5Ypm-ktbSW2Sqp4ilZymvC4T-68sKoJ5FwgPScEI
---

# 2026-10-13 Feedback Test UAT

**The feedback session inserted after [the 12/10 e2e produced nothing](2026-10-12%20UAT%20Test%20e2e.md)
ran for about 1h34m on 13 October from 12:00 CEST, and it is the opposite of its
predecessor: a full Gemini record, three `Concordato` rulings, thirteen next
steps, and the client driving a quote from a bundle he built himself through
DocuSign signature to an order Mexal accepted.**

Guests, from the invitation: Elena Spini (organiser), Aurel Mrruku,
`amministrazione@pienissimo.com`, Fabrizio Paganelli. ⚠ **Only Fabrizio
Paganelli and Aurel Mrruku speak in the record**; nothing establishes who else
joined.

## 🟢 The headline: an end-to-end sale completed, with the client at the keyboard

Fabrizio Paganelli, not ROMI, performed the run (`00:25:15`–`01:26:56`):

1. **built a bundle** — a new Product2 bundle with an academic year and an
   origin event of _"Food Marketing Festival"_;
2. **added its components** through the bundle configuration UI, set quantities
   and per-line discounts so the lines summed to the agreed bundle total;
3. **configured four payment tranches**, due **31 October, 30 November,
   31 December and 31 January**;
4. **created an Opportunity and a Quote** on the `Pienissimo srl` account with
   administrative payment terms (_"RID fine mese data fattura"_), and checked
   the custom related list showing the bundle components and their tranche
   due dates;
5. **generated the quote PDF and sent it for acceptance**;
6. **signed it on DocuSign** and the envelope completed;
7. **the Quote showed as completed and an Order was created**, and Aurel Mrruku
   **confirmed the order reached Mexal with status `inviato`**, with Assets
   generated to match the order quantities (`01:26:56`).

🔑 **This is the first time any source records an order reaching Mexal from a
quote.** [The order-to-Mexal chain note](../objects/The%20order%20to%20Mexal%20integration%20chain.md)
has carried _"never run in UAT — 0 of 45 orders with a Mexal status"_ since
14/09. ⚠ The Gemini record writes the ERP as _"Bexal"_ throughout; it is Mexal.
⚠ **Which org this ran in is not stated** in the notes; the surrounding record
has UAT writing to the client's live Mexal since 09/10.

## Decisioni

### Concordato

1. **Product description is the concatenation of two Mexal fields.** The
   `descrizione estesa` and `descrizione aggiuntiva` (`descrizione_agg`) are
   concatenated into the product description, because the product **name** has
   a standard 80-character limit and Mexal splits the text in two
   (`00:01:08`, `00:05:26`, `00:08:40`).
2. **`Price_1__c` is the reference price everywhere.** Both Mexal price fields
   stay visible, and **`price 1` is the value Mexal invoicing refers to**
   (`00:36:40`). Aurel Mrruku keeps both to stay consistent with the invoicing
   Fabrizio Paganelli runs.
3. 🔑 **Category selection adds only the category's _active_ products; product
   selection adds that product alone** (`01:17:38`). **This reverses the
   population rule the same client agreed on 09/10** — see
   [OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md).

### Da approfondire

- **Bundle access by profile.** Fabrizio Paganelli raised that tutor profiles
  should not be able to quote or order on bundles; the definition of which
  profile gets what was **deferred to a later discussion**
  ([OI-233](../items/OI-233%20Bundle%20access%20for%20tutor%20profiles%20is%20undefined.md)).

## What the client found wrong

| Finding | Where | State |
| ------- | ----- | ----- |
| Description truncated by Mexal's two-field split | `00:01:08` | 🟢 fixed in the call by concatenation |
| Statistical classification levels 1–4 missing from the layout | `00:13:23` | next step, Aurel Mrruku |
| `gruppo merceologico` and `categoria merceologica` not on the layout | `00:21:00` | next step, Aurel Mrruku |
| Bundle components priced at zero | `00:28:22` | 🟢 root cause found and fixed in the call — the standard price book never followed the Mexal price. Committed as `49b49e5` |
| Prices shown with inconsistent decimals | `00:35:43` | 🟢 agreed at 2 decimals |
| Screen width 60% too narrow for standard monitors | `00:51:44` | 🟢 raised to 70–75% |
| Quote PDF shows American date format and bad translations | `01:21:32` | next step, Aurel Mrruku |
| Order record would not open for Fabrizio Paganelli | `01:24:11` | ⚠ the Dettagli read it as a browser issue solved by opening a new tab; the next-step list calls it _"il problema di accesso"_ and asks for an investigation. **Both readings are in the same record** |
| Invoice shows the net unit price, not list price plus discount | `01:30:04` | 🔴 [OI-145](../items/OI-145%20Order%20header%20discounts%20are%20removed.md), reopened — see below |
| Empty `tipo merce` fields in the Mexal order-fix procedure | `01:31:11` | ⚠ _"da verificare successivamente"_, no owner |

## 🔑 The edition-mapping mechanics, stated plainly for the first time

- **Search is by single product or by category code.** Entering a category code
  pulls in every product in that container (`00:59:55`, `01:01:12`). The worked
  example: the Mastery macrocategory holds 14 products, **1 of them active**.
- **The screen is a filter, and saving fires a trigger** that applies the
  changes. Aurel Mrruku told Fabrizio Paganelli to be very careful with it
  (`01:03:46`).
- 🔑 **Articles do not have to be duplicated every year.** Fabrizio Paganelli
  asked how to handle future years given the volume of codes; the answer is that
  categories plus campaigns with **start and end competence dates** carry it
  (`01:05:04`). **The operating order is: create the campaign with its date
  range first, then do the mapping**, so orders created inside that window link
  their products to the right campaign (`01:06:15`).
- Per-user **list views and filters** are the answer to seeing one category at a
  time (`01:14:58`).

## 🔑 A campaign structure was created live

| Field | Value |
| ----- | ----- |
| Parent campaign | _"Pienissimo lab"_, flagged active |
| Child campaign | _"Pienissimo lab 2026"_ |
| Window | **1 October 2026 → 30 September 2027** |
| Event type | **live** |
| **Data invio biglietto** | **1 December 2026** — set on Aurel Mrruku's instruction |
| Edition mapping | category **E11** |

(`01:09:11`, `01:10:18`). ⚠ **`E11` is a category key the records have not
carried before.** Aurel Mrruku also added the creation-date field to the view.

⚠ **Contrast with production:** the two TEST MKT editions in Prod still carry a
`Data Invio Biglietto` of **05/10, already past**, which Aurel Mrruku flagged the
same afternoon in the marketing DM — _"Any send logic based on that date will
treat the new links as due right away."_

## 🔴 OI-145 is reopened, and Mirko Merendi's call finally has an owner

At `01:30:04` Fabrizio Paganelli raised the invoice-pricing gap again — net unit
prices instead of list price with the discount shown — and he and Aurel Mrruku
**agreed to contact Mirko Merendi** to evaluate adding dedicated fields for the
list price and the discount calculation. The next-step list assigns it:

> **\[Fabrizio Paganelli\] Coordinamento con Mirko:** _contattare Mirko per
> discutere la mappatura del prezzo unitario, dello sconto e dell'importo netto
> nell'ordine. Chiedere se è possibile eseguire l'intervento di configurazione
> necessario per completare i campi dell'ordine._

🔑 **The owner has moved to the client side.** On 09/10 the same question was
ROMI's to carry and _"still no booking"_; it is now Fabrizio Paganelli's to
raise with Mirko Merendi. ⚠ **Still no date**, and Mirko Merendi's own standing
objection — that the alternative Mexal interface has rounding problems — is not
mentioned in this session at all.

## Next steps as recorded

| Owner | Step |
| ----- | ---- |
| Aurel Mrruku | concatenate the two description fields |
| Aurel Mrruku | add a _"Classificazione statistica prodotti"_ layout section before system information |
| Aurel Mrruku | add `gruppo merceologico` to the layout |
| Aurel Mrruku | automate the price-list update on every product price change |
| Aurel Mrruku | standardise prices to 2 decimals |
| Aurel Mrruku | set screen width to 75% |
| Aurel Mrruku | category selection adds **active products only** |
| Aurel Mrruku | fix translations and date formats in the quote PDF |
| Aurel Mrruku | investigate the order-record access problem |
| Fabrizio Paganelli | adjust product discounts so the bundle totals reconcile |
| Fabrizio Paganelli | contact Mirko Merendi on list price / discount / net in the order |
| the group | define bundle access permissions per profile |
| the group | 🔑 **test order creation for `plus`, `rinnovo`, `attivazione`, WooCommerce, `vendita libro` and `vendita da palco`** |

🔴 **`vendita libro` is in that test list.** It is the **third** statement
putting books in Salesforce scope — after the 14/10 e2e invitation's
`libro/videocorsi` — against Elena Spini's 09/10 post saying books had moved to
the new WooCommerce shop and left Salesforce _"for now"_. **The 09/10 statement
is now outnumbered and the oldest of the three; nothing has formally reversed
it.**

## Same-day build

Three of the thirteen next steps were already built and committed the same
afternoon, and the developer recorded each in `JOURNAL.md`:

- `49b49e5` — the standard price book follows `Price_1__c`, with an
  `after update` re-price (the zero-priced bundle components);
- `0816bf7` — the mappatura edizione logic: a chosen product maps only itself,
  and a category save maps **active products only**;
- `9e97f46` — standard list-view buttons hidden.

🔴 **One consequence of the active-only change lands before tomorrow's e2e:**
**15 of UAT's 23 categories have no active product at all, so a category save on
any of them now fails** — recorded in
[the Mappatura Edizione note](../objects/The%20Mappatura%20Edizione%20object.md).
