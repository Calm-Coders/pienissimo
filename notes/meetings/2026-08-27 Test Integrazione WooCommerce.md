---
id: MTG-2026-08-27-woocommerce-test
type: meeting
status: resolved
owner: Aurel Mrruku
org: both
raised: 2026-08-27
updated: 2026-08-27
source: meetings/2026-08-27-test-integrazione-woocommerce-transcript.it.md
---

# 2026-08-27 Test Integrazione WooCommerce

**Working session, 27 August 2026, 15:59–16:16 CEST, 17m13s.** Gemini notes,
**full transcript** and a recording exist. Booked at 08:46Z the same morning by
Elena Spini, out of
[the 10:00 session](2026-08-27%20Integrazione%20WooCommerce.md).

**Present: two people — Aurel Mrruku and Sabatino Rinaldi.** Elena Spini was on
the invitation and said in the morning call she would not join
(_"Io non mi collego"_); she does not appear in the transcript. Elisa Migliano
was offered the slot by Fabrizio Paganelli and did not attend. **So the
decisions below were taken by two people and are minuted only by Gemini** — see
the caveat at the foot of this note.

This is the first WooCommerce→Salesforce integration in this project to be
**demonstrated working end to end**, against Pienissimo's live shop.

## What was demonstrated

Sabatino Rinaldi built the plugin between the two sessions and drove it live.

- 🟢 **The plugin exists and works. Version 1.3, always-on.** It replaces the
  test PHP file agreed in the morning: _"non fare il PHP, ma creare un plugin
  comodo"_. It will be permanently active on the Pienissimo shop.
- 🟢 **Trigger: order status `in lavorazione` (processing) OR `completato`
  (completed)** — verified live, and **independent of payment method**. Bank
  transfer, card and PayPal all fire. Sabatino Rinaldi: _"arrivano già se
  vengono effettuati con bonifico bancario, con carta o con PayPal, arrivano
  tutti."_
- 🟢 **HTTP 200 on the wire**, logged as a note on the WooCommerce order.
- 🟢 **A manual re-send button exists on the order** — _"reinvio web a sales
  force"_ — so a corrected order can be pushed again without waiting for a state
  change. Aurel Mrruku: _"hai controllo totale sul processo anche forzando la
  chiamata"_.
- 🟢 **Carts are built with Funnel Kit**, a WooCommerce/WordPress plugin, and
  this was new information to ROMI. It changes the checkout link: **the product
  id no longer needs to be in the URL**, because the funnel already contains the
  product. _"non serve più nell'URL inserire l'ID prodotto perché prende il nome
  del funnel che in questo caso contiene già il prodotto all'interno."_ The link
  Salesforce emits therefore carries the **opportunity id and nothing else**.

## Payload fields seen on screen

Read off the live POST body. This is an **observation of the demo**, not a
schema; the authoritative copy is the text file Sabatino Rinaldi mailed at
14:20Z, which no connected tool can open.

| Level | Fields observed |
| ----- | --------------- |
| Order | WooCommerce **order key**, order status/event, totals, **traffic/tracking source** |
| Customer | nome, ragione sociale, **partita IVA** — carried **twice**, once WooCommerce-native and once in the Funnel Kit shape |
| Line | **`SC` product code**, product name, quantity, subtotal, total |

- **`SC` is the product code Fabrizio Paganelli has been asking for**, per
  Sabatino Rinaldi: _"È il codice prodotto che vuole Max, che vuole Fabrizio
  sempre"_. Aurel Mrruku will match Salesforce products on it. This ties the
  WooCommerce line directly to
  [the article code namespace](../objects/The%20article%20code%20namespace.md) and so to
  [OI-98](../items/OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md).
- **The duplicated customer block was left as-is** by agreement; Sabatino
  Rinaldi could not explain the difference and Aurel Mrruku will keep the
  WooCommerce-native one.
- ⚠ **No line-level status, by design.** Everything that arrives is already
  paid, because only `processing`/`completed` orders are pushed. Aurel Mrruku:
  _"se mi arriva un order da WooCommerce tutte le linee sono [pagate]"_,
  confirmed by Sabatino Rinaldi: _"a noi ci entrano solo ordini che sono stati
  pagati"_.

## Salesforce-side decisions Aurel Mrruku stated

Not yet built, and not minuted anywhere else:

- **A distinct order type keyed on the WooCommerce order key**, so a
  Woo-originated order is identifiable in Salesforce — _"devo creare una
  tipologia di ordine con quella chiave"_.
- **Match products on the `SC` code.**
- **Create the customer in Salesforce when the payload's customer is not found.**
- **Every incoming line lands paid** (see above).

## The one reversal

🔴 **No P.IVA check on the inbound WooCommerce order.** Aurel Mrruku first argued
a second check was needed on arrival, then corrected himself in the same
exchange: _"Quando l'ordine viene inviato poi a Mexal si fa il check là. È
facile."_ The validation stays on the **Salesforce → Mexal** leg.

⚠ This needs confirming with the people who agreed the original rule.
[OI-73](../items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md) records
the 6 August client decision — proposed by **Elisa Migliano**, approved by
**Elena Spini** — that the check fires **at the first order of an Account**, so
that the data pushed to Mexal is already clean. Placing it on the outbound leg
is compatible with that intent for orders that flow on to Mexal, but it is not
obviously the same rule, and **neither Elisa Migliano nor Elena Spini was in the
room**. Sabatino Rinaldi named the exposure before agreeing: _"altrimenti poi in
fatturazione Fabrizio ha lo stesso problema"_.

## Owed out of this session

| Owner | Owes | By |
| ----- | ---- | -- |
| Sabatino Rinaldi | the payload, as a text file, cc Andrea Di Cicco | ✅ **delivered 27/08 14:20Z** |
| Aurel Mrruku | the Salesforce **endpoint + authentication token** for the header | before the next test — [OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md) |
| both | full integration tests **directly on Salesforce** | week of 31 August |
| Sabatino Rinaldi | deactivate the test plugin | ✅ **done in session** |

Aurel Mrruku asked for _"Andrea Tico"_ in CC; the mail that arrived at 14:20Z
cc's `a.dicicco@romicompany.com` and `e.spini@romicompany.com`, so the request
was met and "Tico" is Andrea Di Cicco mis-transcribed.

## 🔴 Real orders reached a third-party test server

While testing, Sabatino Rinaldi saw **real customer orders** arriving at the
throwaway endpoint the plugin was pointed at: _"mentre facevo dei test ci sono
stati degli ordini reali e quindi io me li vedevo lì nel server finto"_. He
deactivated the plugin at the end of the call for that reason — _"spengo quel
plugin prima che mi dimentico, sennò entrano dati su server non nostri"_.
Recorded, with values deliberately not copied, at
[the risk note](../risks/Risk%20-%20real%20WooCommerce%20orders%20reached%20a%20third-party%20test%20server.md).

## Caveat on the record

Two participants, no ROMI project manager, no client business owner, and no
minute except Gemini's. The morning session was properly attended and its
decisions are safe; **this session's decisions — the trigger states, the P.IVA
placement, the paid-lines rule — are technical agreements between two engineers**
and should be restated in a client-facing forum before anything is built on
them.
