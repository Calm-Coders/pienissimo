---
id: OI-354
type: open-item
status: in-progress
owner: Sabatino Rinaldi
with: Aurel Mrruku, Anita Aga
org: both
raised: 2026-11-10
updated: 2026-11-12
depends_on: []
blocks: []
severity: normal
source: Gmail 1a1c50aa4e66d4e8
---

# OI-354 - WooCommerce is connected to production by the client

**The client connected the live WooCommerce shop to the production org himself on
11 November. Authentication and the endpoint worked first time; the first order was
rejected by a production configuration that the manual-steps tracker already
records as done, and the second reached Salesforce but not Mexal, because the shop
let through an invalid province. On 12 November the whole chain ran correctly on
the client call.**

## How it was authorised

Sabatino Rinaldi, 2026-11-10 10:39:20Z: _"quando procediamo per collegare
ufficialmente woo commerce a Salesforce? Posso procedere in autonomia?"_

Aurel Mrruku, 10:48:33Z: _"**Se i colleghi hanno finito i test in uat**, puoi
procedere in autonomia."_

⚠ **That condition was never evidenced met.** Elena Spini asked him to wait for
the tutor training (10:58:44Z), and then released him on 11/11 13:47:44Z — _"Direi
che puoi partire"_ — on the grounds that the training had happened, which is a
different condition. 🔴 And putting WooCommerce in production ends the UAT tests:
Elena Spini, DM 10/11 11:56:20Z, _"se mette WooCommerce in PROD io non posso fare
il test in UAT?"_ → Aurel Mrruku, _"yes"_ · _"i test con woocomerce sempre"_.

## What happened on connection

| Time (11/11) | Event |
| --- | --- |
| 14:44:59Z | Sabatino Rinaldi: _"ho fatto tutto"_, asks for a production product code to test with |
| 14:52:11Z | Aurel Mrruku: every Mexal product is now in Salesforce, use any active one |
| 15:00:08Z | 🟢 _"autenticazione ed endpoint funzionano, l'ordine arriva fino a voi"_ — 🔴 but it stops on a missing Salesforce configuration: _"**Configure Default Agent Username on the WooCommerce Integration Notification Config record with an active user who has an agent code and customer commission category**"_. Product used: `CS000058` |
| 15:00:57Z | Aurel Mrruku forwards the thread to Anita Aga |
| 15:08:11Z | _"Riprova adesso"_ — fixed in eight minutes |
| 15:10:26Z | 🟢 Order accepted: _"inviato il 2026-11-11 17:09 (**Order 801SW00000hbOKjYAM**)"_ |
| 15:27:28Z | 🔴 _"L'ordine e stato creato in SF ma non va su mexal perche sul Account hai messo **la provincia in modo sbagliato. Devi mettere RN per Rimini**."_ |
| 15:36:19Z | Sabatino Rinaldi: _"No e lo stesso errore dell'altra volta…. 'alesasndria'"_ |

🔑 **The missing Default Agent Username is the manual step
[the tracker](../Manual%20Steps%20Pienissimo%20tracker.md) records as `done` in
production** — _"Add the default agent for Accounts and Orders created from
WooCommerce"_. It was not, or not completely. See
[OI-301](OI-301%20Three%20production%20manual%20setup%20steps%20are%20outstanding.md).

## 12/11 — the chain closed

🟢🔑 On the [Check Pre-Import call](../meetings/2026-11-12%20Check%20Pre-Import.md)
Sabatino Rinaldi placed another order from the live shop with a real Italian VAT
number and a Rimini address. Salesforce created the Account, **Anticipay verified
it at 11:40**, the ATECO code was returned, the Pienissimo commercial agent code
was applied, and **the order reached Mexal** — _"anticipo\[lato\] e Maxile
inviato."_ This is the first end-to-end WooCommerce → Salesforce → Anticipay →
Mexal run in production.

## What is still open

1. 🔴 **The province is free text from the shop and silently breaks Mexal.** It has
   now failed twice, each time on a different value, and nothing validates it
   before the integration call. **No fix, no owner, no item owner assigned.**
2. ⚠ **Nothing confirms the UAT WooCommerce tests were finished**, which was the
   stated precondition — and they cannot be run any more.
3. ⚠ The product code and test link Elena Spini needed for the 11/11 tutor
   training were never supplied; she ran it without them.
