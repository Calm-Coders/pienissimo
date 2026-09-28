# [ROMI-PIENISSIMO] Test Integrazione WooCommerce — 2026-08-27

**Sources:** [meetings/2026-08-27-test-integrazione-woocommerce-transcript.it.md](../2026-08-27-test-integrazione-woocommerce-transcript.it.md) (original Italian transcript, Google Meet + Gemini notes, **17m13s**) · [recording](https://drive.google.com/file/d/1UR-NKQmIRc8rjguIKAjTbBiuJtX9nO5I/view) · [notes & transcript](https://docs.google.com/document/d/1oqiqR46V77BA7GuyFnrrptgb-2zgmwSBYl4cGPZg_6o/edit) · found by the nightly `requirements-check` sweep of 2026-08-27

**Attendees:** **two people** — Aurel Mrruku (ROMI) and Sabatino Rinaldi (Pienissimo).
**Not present:** Elena Spini was on the invitation and said in the morning session she would not join (_"Io non mi collego"_); she does not appear in the transcript. Elisa Migliano was offered the slot by Fabrizio Paganelli and did not attend.

> **Attribution caveat.** Two speakers, cleanly separated; attribution is not in doubt here. The Gemini summary is accurate but thin — it omits the Funnel Kit finding, the manual re-send button, the paid-lines rule and the real orders reaching the test server.

> ⚠ **Weight of this record.** No ROMI project manager, no client business owner, and no minute but Gemini's. The decisions below are **technical agreements between two engineers** and should be restated in a client-facing forum before anything is built on them.

> **Context:** booked at 08:46Z the same morning out of [the 10:00 design session](2026-08-27-integrazione-woocommerce.md), to run the wire test agreed there. It is the **first WooCommerce→Salesforce integration in this project demonstrated working end to end**.

---

## The headline

🟢 **It works.** Sabatino Rinaldi built the plugin between the two sessions and drove it live against Pienissimo's production shop: order placed, plugin fired, **HTTP 200**, full payload on the wire.

---

## What was demonstrated

- 🟢 **A custom WooCommerce plugin, version 1.3, permanently active.** It replaces the test PHP file agreed in the morning — _"non fare il PHP, ma creare un plugin comodo"_.
- 🟢 **Trigger: order status `in lavorazione` (processing) OR `completato` (completed)**, verified live and **independent of payment method** — bank transfer, card and PayPal all fire. _"arrivano già se vengono effettuati con bonifico bancario, con carta o con PayPal, arrivano tutti."_
- 🟢 **HTTP 200**, logged as a note on the WooCommerce order.
- 🟢 **A manual re-send button** on the order — _"reinvio web a sales force"_ — so a corrected order can be pushed again without a state change. Aurel Mrruku: _"hai controllo totale sul processo anche forzando la chiamata."_ The WooCommerce twin of Mexal's _rinvio ordine_.
- 🟢 **Carts are built with Funnel Kit** — new information to ROMI, and it changes the checkout link. The funnel URL already contains the product, so **the product id no longer goes in the URL**: _"non serve più nell'URL inserire l'ID prodotto perché prende il nome del funnel che in questo caso contiene già il prodotto all'interno."_ The link Salesforce emits carries the **opportunity id alone**.

## Payload seen on screen

An observation of the demo, not a schema. The authoritative copy is the text file Sabatino Rinaldi mailed at **14:20Z** — see **Still unreachable**.

| Level | Fields observed |
| ----- | --------------- |
| Order | WooCommerce **order key**, status/event, totals, **traffic/tracking source** |
| Customer | nome, ragione sociale, **partita IVA** — carried **twice**, once WooCommerce-native and once in the Funnel Kit shape |
| Line | **`SC` product code**, product name, quantity, subtotal, total |

- **`SC` is the product code Fabrizio Paganelli has been asking for** — _"È il codice prodotto che vuole Max, che vuole Fabrizio sempre"_. Salesforce will match products on it, which ties the WooCommerce line to the Mexal article registry currently being **re-created** ([OI-98](../../notes/items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md)).
- The **duplicated customer block** was left as-is by agreement; ROMI reads the WooCommerce-native copy.
- ⚠ **No line-level status, by design** — everything arriving is already paid, because only processing/completed orders exist in WooCommerce.

---

## Decisions

### 1. Salesforce-side design, stated by Aurel Mrruku

A **distinct order type keyed on the WooCommerce order key**, so a Woo-originated order is identifiable (_"devo creare una tipologia di ordine con quella chiave"_) · **product match on the `SC` code** · **create the customer** when not found · **every incoming line lands paid**.

### 2. No P.IVA check on the inbound WooCommerce order — 🔴 a reversal

Aurel Mrruku first argued an inbound check was needed, then corrected himself in the same exchange: _"Quando l'ordine viene inviato poi a Mexal si fa il check là. È facile."_ The validation stays on the **Salesforce → Mexal** leg.

⚠ **This needs confirming.** [OI-73](../../notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md) records the **6 August client decision** — proposed by **Elisa Migliano**, approved by **Elena Spini** — that the check fires **at the first order of an Account**, so the data pushed to Mexal is already clean. The two formulations are not identical: one is Account-scoped and once-only with a `consolidato` flag, the other is per-order; and a WooCommerce order that never reaches Mexal would never be checked. **Neither Elisa Migliano nor Elena Spini was in the room.** Sabatino Rinaldi named the exposure before agreeing: _"altrimenti poi in fatturazione Fabrizio ha lo stesso problema."_

### 3. Full integration tests move to Salesforce, week of 31 August

Pointing at the real Salesforce endpoint with token auth. Sabatino Rinaldi deferred Fabrizio Paganelli's stage-sale cases to that round: _"anche quelli che vuole Fabrizio, li facciamo direttamente quando abbiamo il collegamento con Sales[force]"_.

---

## Action items

| # | Owner | Action | State |
| - | ----- | ------ | ----- |
| 1 | Sabatino Rinaldi | Mail the payload as a text file, cc Andrea Di Cicco | ✅ **delivered 27/08 14:20Z** |
| 2 | Aurel Mrruku | Provide the Salesforce **endpoint + header token** | 🔴 open — [OI-102](../../notes/items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md) |
| 3 | both | Full integration tests **on Salesforce** | 🔴 week of 31 August |
| 4 | Sabatino Rinaldi | Deactivate the test plugin | ✅ **done in session** |

Aurel Mrruku asked for _"Andrea Tico"_ in CC; the 14:20Z mail cc's `a.dicicco@romicompany.com` and `e.spini@romicompany.com`, so the request was met and "Tico" is Andrea Di Cicco mis-transcribed.

---

## Open questions / risks

🔴 **Real customer orders reached a third-party test server.** While testing, Sabatino Rinaldi saw live orders arriving at the throwaway public endpoint the plugin was pointed at — _"mentre facevo dei test ci sono stati degli ordini reali e quindi io me li vedevo lì nel server finto"_ — and deactivated the plugin at the end of the call for that reason. Stopped, but it exposes the underlying condition: **there is no test lane**, testing happens on the production shop against production customers, and the plugin is permanently on. [The risk note](../../notes/risks/Risk%20-%20real%20WooCommerce%20orders%20reached%20a%20third-party%20test%20server.md). No values were copied into the record.

🔴 **Somebody must decide where the 31 August test orders land** — sandbox or UAT — and how they get cleaned up. Sabatino Rinaldi expects them to flow: _"entrano tutti gli ordini anche senza l'opportunity"_.

🔴 **Stage sales still untested** — [OI-101](../../notes/items/OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md). This session ran one €50 test product through the happy path.

⚠ **`INT-16` is being decided by default.** The delivered plugin appears to pass the opportunity id **in clear** — the demo URL carried a literal opportunity value — while the register still recommends a **signed token**. Nobody said either way. Decide it explicitly.

---

## Notes

**Nothing of the Salesforce side exists.** As of the 26 August org check there is no Flow, no named credential and no `Integration_Configuration__c` row for WooCommerce, and `Product2.WooCommerce_Product_Id__c` is populated on 0 of 280 products. The client side is now real and waiting on ROMI — with Fase 1 development ending **10 September**.

**Requirement change from this session:** `ORD-12` corrected — a WooCommerce order reaches Salesforce at **IN LAVORAZIONE or COMPLETATO**, not only COMPLETATO. Landed in `pienissimo-requirements.yaml` (entry and the `orders.rules` block), `REQUIREMENTS.md` and `REQUISITI.it.md`, with both dates cited.
