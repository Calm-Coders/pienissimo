---
id: OI-366
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku, Sabatino Rinaldi
org: both
raised: 2026-11-16
updated: 2026-11-16
depends_on: [OI-327, OI-354]
blocks: []
severity: gating
source: notes/meetings/2026-11-16 Ultimi Check PROD.md
---

# OI-366 - Most Salesforce products are inactive so WooCommerce orders fail the product code match

**On the morning the users went live, the first real WooCommerce order placed with
the plugin finally switched on never reached Salesforce. It failed on a product
code match, and then three more real catalogue codes were tried and every one was
inactive. The cause is the client's own Sunday cleanup: to keep the tutors from
seeing the wrong articles, he changed their Mexal gruppo merceologico, which the
sync turns into inactive products. The test was abandoned unfinished and the shop
is live.**

## What happened

Sabatino Rinaldi activated the WooCommerce plugin flag during the 16/11 call —
it had never been switched on, despite the connection being reported live since
11 November ([OI-354](OI-354%20WooCommerce%20is%20connected%20to%20production%20by%20the%20client.md)).
He then placed a real order on the shop, bank transfer, and moved it to Completato:

> _"la e andato tutto bene, ha visto anche qual era l'opportunity di ma **non ti ha
> inviato l'ordine perche sotto c'ho l'errore come l'altra volta: product code
> match**. Non c'e quel prodotto in sales force perche era un prodotto di test."_

⚠ **"come l'altra volta"** — the same failure has happened before and is not
recorded anywhere in the vault under that name.

Aurel Mrruku's answer was to use a live article. Three were tried:

| Code as read on the call | Result |
| --- | --- |
| a `CS00…` Food Marketing Festival Diamond code | not active |
| a second `CS…` inventory code | not active |
| an `ST40…` code | active, but **generates no ticket** |

Aurel Mrruku: _"**Mi sa che li ha disabilitati Fabrizio sti prodotti**"_ and then
_"ho un prodotto attivo, **la maggior parte sono non attivi**."_

## The cause

Fabrizio Paganelli, earlier in the same call, describing his Sunday 15 November
work in Mexal:

> _"avevamo tanti codici articolo intestati alla Performance Plus che avevano
> natura attivo su Sales Force. Io sono andato a modificare e ho disattivato,
> andando a **cambiare il gruppo merceologico**, su tutti quegli articoli che i
> tutor questa mattina non avrebbero dovuto vedere."_

The article sync maps the Mexal gruppo merceologico onto the Salesforce active
flag — the mechanism deliberately agreed for the load, described in
[the 12/11 session](../meetings/2026-11-12%20Check%20Pre-Import.md) as
_"in automatico verranno come inattivi in sales force."_ It worked. Nobody
connected it to the WooCommerce catalogue.

## Why it matters now

- **The shop is live and the flag is on.** Any customer buying an article whose
  Salesforce product is inactive produces an order that stops at the integration.
- **The failure is silent to the buyer.** The shop order completes; only the
  Salesforce side errors.
- 🔴 **Nobody decided which articles the shop sells.** The deactivation was scoped
  to what the tutors should not see, not to what the shop offers, and the two sets
  were never compared.

## Not established

- **How many WooCommerce-sellable articles are currently inactive**, and which.
- **Whether the afternoon retest** — deferred to _"dopo le 3"_ when the client's
  management pulled Sabatino Rinaldi away — happened, or what it found.
- **Whether the integration retries** a rejected order, or whether the shop order
  simply stays unlinked.
- Whether the earlier occurrence of _"product code match"_ was the same cause.

## Needs a human

Someone has to reconcile the two lists: the articles the client deactivated on
15 November, and the products the live shop can sell. Owner unassigned; the
deactivation was Fabrizio Paganelli's and the shop is Sabatino Rinaldi's, and
[Sabatino Rinaldi is leaving](OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md).
