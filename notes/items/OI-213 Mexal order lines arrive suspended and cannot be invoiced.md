---
id: OI-213
type: open-item
status: open
owner: Aurel Mrruku
with: Mirko Merendi
org: both
raised: 2026-10-07
updated: 2026-10-08
blocks: [OI-134, go-live]
severity: gating
source: notes/meetings/2026-10-07 Temi Integrazione Mexal.md
---

# OI-213 - Mexal order lines arrive suspended and cannot be invoiced

**Order lines transmitted from Salesforce land in Mexal in state `S` (sospeso)
instead of `E` (eseguibile), and an order whose lines are suspended cannot be
turned into an invoice. Fabrizio Paganelli hit it on two separate test orders
and had to correct the lines by hand before invoicing would run.**

## The symptom

At [the 07/10 Mexal call](../meetings/2026-10-07%20Temi%20Integrazione%20Mexal.md)
Aurel Mrruku reported orders reaching Mexal but refusing to convert to an
invoice, with an error about an unknown line. Fabrizio Paganelli identified the
cause: _"c'era la riga ordine in stato sospeso anziché in stato eseguibile,
quindi dopo li ho modificati a mano e poi dopo la fattura è andata."_

The same failure appeared earlier the same morning at
[the WooCommerce session](../meetings/2026-10-07%20UAT%20Integrazione%20WooCommerce%20e%20Mexal.md)
on the order recorded as sezionale 10 number 12, alongside a terminal-in-use
conflict. Fabrizio Paganelli completed that invoice only after correcting the
contropartite and the line state by hand.

## The fix, as named by the vendor

Mirko Merendi gave the parameter in the call: the field is
**`Tipo_B_Stato_Bigga`** on the order line, nothing is currently being passed,
so Mexal applies its default of `S`, and `E` must be set on every line.

> _"Tipo stato riga si chiama. Tipo_B_Stato_Bigga. E lì e adesso non state
> passando niente, quindi default prende S che è sospeso e gli dovete mettere la
> E. Quindi su tutte le righe gli metti la E."_

⚠ **The field name is transcribed from speech.** `Tipo_B_Stato_Bigga` is what
the notes carry; the exact API spelling must be taken from the names Mirko
Merendi undertook to send Aurel Mrruku in chat, not from this note.

## Scope beyond the line state

Mirko Merendi's committed customisation covers **line state, causale,
contropartita, goods type and IVA rate** together — Fabrizio Paganelli had
flagged missing automatic contropartite and goods type, and an IVA code
defaulting to `E01` (IVA-exempt goods) even for services. Mirko Merendi has also
asked Passepartout to expose those fields at API level in future versions, on
San Marino's behalf. Elena Spini separately noted at the WooCommerce session
that she owed Mirko Merendi exactly this request.

## What closing it looks like

Salesforce sets the line state on every transmitted line, an order sent from
Salesforce converts to an invoice in Mexal with no manual correction, and the
vendor customisation for causale, contropartita, goods type and IVA is in place.

## Update 08/10 - the IVA code now comes from the article

On the Salesforce side, `MexalOrderSendService` now sends each line's
`cod_iva` from the article's own VAT code. That code is Mexal's `alq_iva`,
synced onto `Product2.Alq_Iva__c`; see
[the article sync note](../objects/The%20Mexal%20article%20sync%20to%20Product2.md).
A product without a code falls back to the old fixed default, `E01` for `OC`
and `E10` for `BC`.

- **Deployed to Pienissimo UAT only**, not committed and not in Prod.
- After the full UAT re-sync on 08/10, **933 of 1,068 Item products carry a
  code**. The other 135 are blank: 118 have no code in Mexal, and 17 are not in
  Mexal's response. Those lines still go out with the `E01`/`E10` fallback.
- ⚠ **Not verified end to end.** Proving it means sending an order to Mexal,
  and that has not been done.
- This is the Salesforce half only. Mirko Merendi's vendor customisation, which
  pulls the IVA code inside Mexal, is separate and still open.
