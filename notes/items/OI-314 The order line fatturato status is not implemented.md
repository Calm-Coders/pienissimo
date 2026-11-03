---
id: OI-314
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-11-03
updated: 2026-11-03
depends_on: []
blocks: []
source: notes/meetings/2026-11-03 Test e2e PROD.md
---

# OI-314 - The order line fatturato status is not implemented

**Aurel Mrruku agreed on the 3 November production test to drive an order status of
`fatturato` from the Mexal invoice link, independently of payment. The `incassato`
half already works; this half does not exist. Both parties agreed it knowing the
rule as specified is imperfect.**

## The gap

Today an order reaches `incassato` when its invoices are collected. **There is no
intermediate `fatturato`** — the state the client's own model requires between
ordering and collection. Fabrizio Paganelli, in
[the e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md):

> _"noi abbiamo tre step. Arriva l'ordine, è ordinato. Poi dopo l'ordine io lo
> fatturo, diventa fatturato."_ … _"Io oggi faccio l'ordine, al primo di dicembre lo
> fatturo, al 31 di dicembre il cliente paga. Quindi quell'unico ordine nel corso di
> due mesi subisce tre stati diversi."_

## What Aurel Mrruku agreed to build

> _"Se vuoi posso fare in modo che se hai presenti su tutte le righe d'ordine le
> fatture … io posso fare un controllo che se esiste un ID, un legame con la fattura
> con tutte le righe d'ordine ma le righe d'ordine non sono state tutte pagate, allora
> sei in fatturato."_

So: **every order line has an invoice link and at least one is not collected →
`fatturato`.** When all are collected → `incassato`, which already works.

🔑 **The signal is already in the data.** The order-line related list carries the
`FT…` invoice link and `Mexal Payment = unpaid`, which together already mean
invoiced-not-paid. Fabrizio Paganelli accepted that view as _"a prova di stupido"_.

## ⚠ Agreed knowing it is wrong at the edges

Fabrizio Paganelli asked the obvious question — all order lines, or the lines of one
tranche?

> **Aurel Mrruku:** _"tutte le righe d'ordine, perché praticamente il fatturato vuol
> dire che tutto l'ordine è fatturato."_
> **Fabrizio Paganelli:** _"E dopo diamo un'informazione distorta lo stesso"_

🔑 **It was adopted anyway.** So a partially invoiced order — the normal case, since
tranche are invoiced month by month — shows nothing at order level until the last
tranche is invoiced. ⚠ **Whether a tranche-level variant is wanted is unresolved and
nobody undertook to resolve it.**

## What is explicitly out of scope

🔑 **Not on the asset.** The client's original request was an invoiced state on the
**asset**, and that was refused on a technical ground and then withdrawn by the
client — see
[the decision](../decisions/Decision%20-%20asset%20states%20stay%20as%20built%20and%20the%20ordinato%20label%20is%20not%20renamed.md).
An asset is not an invoice line; several assets hang off one order line, so no
one-to-one link exists.

## Why it is open

1. 🔴 **Nothing is built.** Aurel Mrruku: _"non l'ho messo in piedi questa logica."_
2. ⚠ **No date.** It was not given a release or a slot, and it is not in the R0
   window.
3. ⚠ **No register row covers order line states.**
