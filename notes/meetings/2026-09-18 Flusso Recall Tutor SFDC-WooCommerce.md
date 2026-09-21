---
id: meeting-2026-09-18-flusso-recall-tutor
type: meeting
status: resolved
owner: Aurel Mrruku
org: both
raised: 2026-09-18
updated: 2026-09-21
source: Gemini notes doc 15OhNxIgldS0Eo05uskRZR-vSz9szwAkyvHH2jMXeKd8 (read in full)
---

# 2026-09-18 Flusso Recall Tutor SFDC-WooCommerce

**Client-facing, 35m24s, 18/09 10:32 CEST.** Elena Spini, **Sabatino Rinaldi**,
Aurel Mrruku. Originally booked for 16:00 and **brought forward at Sabatino
Rinaldi's request by WhatsApp** that morning.

**This is the session that settled the checkout link.** It ran the day after
[the 17/09 evening sweep](../traces/Source%20trace%202026-09-17%20evening.md)
reported the built link as contradicting the recorded design, and it resolved the
contradiction against **both** of the shapes then on record.

## Agreed

- 🔑 **The link carries the WooCommerce funnel name, not a product ID.**
  Sabatino Rinaldi identified the generated link as wrong: the platform builds its
  carts and checkout pages with **Funnel Kit**, so
  `…/checkout/?add-to-cart=<id>` lands on a static page, not a cart
  (`00:15:39`). The correct anatomy is keyed on the **funnel name**. Aurel Mrruku
  agreed to make the URL's leading portion **static** up to `checkout`, the
  **funnel name dynamic** (typed by the user in Salesforce while generating the
  link), and to keep the opportunity id as a query parameter (`00:19:02`,
  `00:22:01`). In his own words: _"invece di chiamarlo prodotto WooCommerce, lo
  chiamo funnel WooCommerce."_
- 🔑 **One product or bundle per checkout link; multi-product is deferred.**
  Aurel Mrruku asked how to concatenate several product ids. **Sabatino Rinaldi:
  _"mi vien da dire che è impossibile che debba inserire due prodotti"_** — on
  WooCommerce a bundle behaves as a single product, and the stage-sale example he
  gave (the tour pack, sold with a deposit) is exactly that shape (`00:05:21`,
  `00:06:35`). Decision: keep the single-product configuration, leave
  concatenation for later if a case appears (`00:07:42`).
- **The Postman collection's JSON is integrated into Sabatino Rinaldi's own
  plugin** for authentication and order creation (`00:26:54`, `00:31:47`).
- **The schedule was restated to him**: UAT from 24–25 September to 6 October in
  guided sessions, then credentials for autonomous testing, approval of the
  solution by 13 October, **go-live 21 October** (`00:10:35`, `00:11:49`).
- A 30-minute joint test was fixed for **Monday 21 September 16:00–16:30**
  (`00:34:07`). ⚠ The Gemini decisions block renders this as _"lunedì 21
  ottobre"_; the transcript and the calendar invitation both say 21 September.

## Why this closes two questions

The two answers [OI-49](../items/OI-49%20WooCommerce%20checkout-link%20flow.md)
had been recording as owed by Sabatino Rinaldi since 16/09 — *is the product id
always a bundle id*, and *what happens to multi-product offers with no single
bundle* — **are both answered here, by him, and they are answered by removing the
premise.** The link no longer carries a product id at all, so there is no bundle-id
question; and multi-product offers are explicitly out of scope for now.

His original constraint, that **a tutor must never type an id**, is honoured: a
funnel name is not an id, and marketing supplies it. The catalogue-sync cron the
record said this design depended on is **not needed** under this anatomy.

## Marketing forms — the first movement in nine weeks

🔑 Elena Spini asked Sabatino Rinaldi to **send by email the Zoho form links that
are absolutely indispensable**, out of the ~100 in the workbook, so the flows can
be configured with Fabrizio Mastracci. He agreed: _"ti mando i link di Zoho, dei
form che in assoluto dobbiamo avere subito"_ (`00:13:07`, `00:14:38`).

🔴 **No such mail has arrived as of 2026-09-21T22:00Z**, three days on.
→ [OI-14](../items/OI-14%20Marketing%20forms%20and%20subdomain.md)

🔑 He also named **Matteo** as the person on the client side who owes the
marketing material — _"se non riusciamo subito a darvi quella roba lì da parte di
Matteo"_. That is
[Matteo Distaso](../people/Matteo%20Distaso%20-%20Pienissimo%20marketing%20lead.md),
Responsabile Marketing at Pienissimo and **the same Matteo
[OI-14](../items/OI-14%20Marketing%20forms%20and%20subdomain.md) has named since 23
June** — the oldest live blocker on the project. So the forms are still sitting
with the same person they have sat with for thirteen weeks, and Sabatino Rinaldi
offered to route around him.

## Recorded, and worth keeping

- ⚠ **Sabatino Rinaldi never opened the 8 September endpoint mail** — _"non l'ho
  proprio aperta. Io ero in tour"_ (`00:26:54`). Aurel Mrruku re-sent it at
  08:59:18Z the same morning. The eight-day silence on
  [OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)
  has a mundane explanation.
- **Token mechanics**: a static token obtains an access token valid **up to 24
  hours**, which is then used per call (`00:29:37`).
- 🔴 **The endpoint Sabatino Rinaldi now uses is the test environment**, and Aurel
  Mrruku confirmed the credentials **must be swapped when Salesforce goes into
  production** — _"Questo è ambiente di test… quando il SF sarà operativo la
  dovremmo cambiare"_ (`00:29:37`). **No owner and no date for that rotation.**
- ⚠ Aurel Mrruku asked him not to over-test, because each call creates an order
  and duplicates accumulate.
- ⚠ Elena Spini is **not certain Daniela Morgese was aligned on the go-live
  move**: _"Fabrizio ha detto che l'ha letta e aveva allineato Daniela, poi non so
  se è successo"_ (`00:11:49`).
  → [OI-124](../items/OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md)
- Sabatino Rinaldi asked about the Zoho subscription expiring end of October;
  Elena Spini confirmed there is still margin.
- He named the Mexal integration as the most important item and assumed it was
  settled — _"Credo che quella l'avete fatto, cioè siete riusciti a trovare la
  quadra"_. ⚠ On the evidence of
  [the 21/09 Mexal internal](2026-09-21%20Interna%20Temi%20Mexal.md), it was not.
