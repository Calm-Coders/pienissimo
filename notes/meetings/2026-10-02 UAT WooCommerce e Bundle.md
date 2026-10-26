---
id: meeting-2026-10-02-uat-woocommerce-bundle
type: meeting
status: active
owner: Elena Spini
org: both
raised: 2026-10-02
updated: 2026-10-02
source: Drive, Appunti di Gemini, 2026-10-02 10:00 CEST (doc 1-t2XHtTO9ePWyO4mdqpDBId1KA89u4enpF8y2EWaM00, structured sections read in full)
---

# 2026-10-02 UAT WooCommerce e Bundle

**The client drove WooCommerce orders through to Salesforce himself and the assets
generated correctly. Six things were agreed, two deferred, and Fabrizio Paganelli
raised one gap nobody picked up.** 02/10, 10:00 CEST, **~1h17m**.
**Aurel Mrruku · Elena Spini · Fabrizio Paganelli · Sabatino Rinaldi · Elisa
Migliano**, with `amministrazione@` and Marco Montesi invited.

The first client session in three days, and the one that produced the agreements
the whole WooCommerce leg now rests on.

## 🟢 What was tested, and what worked

Aurel Mrruku configured an edition campaign and built a €2,000 bundle live —
products, line prices and discounts summed to the total, then tranche with dates
([00:11:06](https://docs.google.com/document/d/1-t2XHtTO9ePWyO4mdqpDBId1KA89u4enpF8y2EWaM00/edit#heading=h.ceizvpbgx2tx)–[00:21:44](https://docs.google.com/document/d/1-t2XHtTO9ePWyO4mdqpDBId1KA89u4enpF8y2EWaM00/edit#heading=h.pzdehkkkeqi1)).

Sabatino Rinaldi then completed a checkout through the Salesforce-generated link
for a two-tranche bundle. Aurel Mrruku confirmed from the integration logs: order
created at €2,000, **four assets generated and the participant link with them**
([00:34:18](https://docs.google.com/document/d/1-t2XHtTO9ePWyO4mdqpDBId1KA89u4enpF8y2EWaM00/edit#heading=h.f7q3w7lxnmq4)).

A second test, an order placed autonomously on WooCommerce, **failed first time**:
the bundle/article code — the new `pienissimo lab` product — was not present in
Salesforce and had to be entered by hand. Aurel Mrruku mapped the single product
`ST054` to an edition campaign and set the flags, Sabatino Rinaldi repeated the
test with bundle code `Pack 1009`, and it arrived
([00:41:58](https://docs.google.com/document/d/1-t2XHtTO9ePWyO4mdqpDBId1KA89u4enpF8y2EWaM00/edit#heading=h.stabzd6fy6en)–[00:51:24](https://docs.google.com/document/d/1-t2XHtTO9ePWyO4mdqpDBId1KA89u4enpF8y2EWaM00/edit#heading=h.d3c6h11hdjk3)).

⚠ That failure is the whole case for the first agreement below.

## 🔑 Agreed

| Agreement | Consequence |
| --- | --- |
| **Every article code and bundle must be mapped in the edition mapping table**, against the competenza date range | Makes [OI-96](../items/OI-96%20Edition%20mapping%20table%20on%20Salesforce.md) a standing client obligation, not a one-off setup |
| **`Unità di misura` is added to the bundle configuration screen** | Built the same evening as `QuantityUnitOfMeasure` — see [the Pre-UAT](2026-10-02%20Interna%20Pre-UAT%20Plus.md) |
| **On receiving a WooCommerce order, Anticipay is called before the account and order go to Mexal** | Extends the 11/09 sequencing decision to the inbound e-commerce path |
| **A mapping table converts WooCommerce payment-method codes to Mexal's** | New requirement — [OI-204](../items/OI-204%20WooCommerce%20payment%20codes%20need%20a%20mapping%20table%20to%20Mexal.md) |
| **Checkout billing data and the paying subject populate the Account, both addresses and the primary Contact** | `Billing First/Last name` → Account; the payer/titolare becomes the primary Contact; billing **and** shipping addresses are both carried, because Mexal needs them in the anagrafica as well |
| **Sync failures mail Amministrazione and raise dedicated flags for manual handling** | Separate flags for Anticipay and for Mexal, plus a manual `Crea cliente Mexal` action. Elisa Migliano judged the procedure correct and expects the cases to be foreign customers with foreign invoices |

🔑 **Partita IVA is the external key.** Aurel Mrruku asked for it explicitly and
both Fabrizio Paganelli and Sabatino Rinaldi confirmed the check is always made on
the VAT number
([01:01:48](https://docs.google.com/document/d/1-t2XHtTO9ePWyO4mdqpDBId1KA89u4enpF8y2EWaM00/edit#heading=h.pvrzbbm70wf3)).

## 🔴 Raised and dropped

**Fabrizio Paganelli flagged that a `ditta individuale` can hold a valid VAT
number, not appear in the registro delle imprese, and not be recognised by
Anticipay.** No resolution, no owner, no action item —
[OI-202](../items/OI-202%20Anticipay%20does%20not%20recognise%20sole%20traders%20absent%20from%20the%20registro%20imprese.md).

## Deferred

- **The error message** for products used outside their valid date range —
  postponed outright.
- 🔑 **Formal approval of the integration logics is subordinated to Daniela's
  verification and validation, on Monday.** Fabrizio Paganelli will review the
  WooCommerce logic document with Elisa Migliano and Sabatino Rinaldi first, then
  present it. ⚠ The transcript says only _"Daniela"_; the only Daniela in the
  records is [Daniela Morgese](../people/Daniela%20Morgese%20-%20Pienissimo%20direction.md),
  and nothing in this sweep states the surname.

## Commitments taken in the room

| Owner | Commitment |
| --- | --- |
| Aurel Mrruku | Add the missing unit of measure to bundle configuration · configure the test bundle and map the new article codes · **document the WooCommerce ↔ Mexal payment-code mapping** |
| Fabrizio Paganelli, Elisa Migliano, Sabatino Rinaldi | Review the updated WooCommerce logic document, then present it to Daniela on Monday |
| Sabatino Rinaldi, Fabrizio Paganelli | Run card and PayPal test orders straight after the call, on a €9.90 bundle with different contacts, and notify Elena Spini and Aurel Mrruku by WhatsApp |
| Sabatino Rinaldi | Verify with Daniela that the link, tickets and logics hang together |
| Elena Spini | Send the complete Blueprint to Sabatino Rinaldi and Fabrizio Paganelli by end of day — **done at 13:55:56Z** |
| Fabrizio Paganelli | Read the Blueprint with Sabatino Rinaldi at 15:00 — **done, and they objected at 14:19:31Z** |

## 🔑 The scheduling decision

Elena Spini proposed a test call for Tuesday. Sabatino Rinaldi is away Monday 12
and already had a Mexal call Tuesday 10:00–12:00; Fabrizio Paganelli suggested
extending that existing meeting to 13:00 rather than opening a new slot. The
calendar then moved it again — at Aurel Mrruku's request, in
[the 12:22 Interna](2026-10-02%20Interna.md) — to **Wednesday 07/10, 10:00–13:00**.

⚠ Aurel Mrruku's own closing note on the state of the data: _"I finally have
understood what the M they have done with the data till now."_
