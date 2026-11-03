---
id: decision-asset-states-unchanged
type: decision
status: resolved
owner: Fabrizio Paganelli
org: Pienissimo
raised: 2026-11-03
updated: 2026-11-03
depends_on: [OI-314]
blocks: []
source: notes/meetings/2026-11-03 Test e2e PROD.md
---

# Decision - asset states stay as built and the ordinato label is not renamed

**Fabrizio Paganelli spent the last twenty minutes of the 3 November production test
arguing that an asset should show an invoiced state. He then checked with Rebecca and
withdrew it in writing the same afternoon. The two asset states stay, the `ordinato`
label stays, and nothing is built on the asset.**

## The argument

In [the e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md) Fabrizio
Paganelli put the client's model:

> _"noi abbiamo tre step. Arriva l'ordine, è ordinato. Poi dopo l'ordine io lo
> fatturo, diventa fatturato."_ … _"fatturato e incassato, quindi barra pagato, sono
> due cose diverse, non è la stessa cosa."_

**The built behaviour**: an asset is `ordinato` from order creation and becomes
`disponibile` **only on actual collection of the invoice**. There is no `fatturato`
on the asset. Elena Spini: _"questo flusso è stato condiviso miliardi di volte,
quindi su questo sono ferma."_

🔑 **His concern was reporting, not accounting.** Whoever pulls a list of available
and unavailable assets sees `ordinato` and cannot tell an invoiced-not-collected
asset from an untouched one — _"chi guarda questa schermata senza avere una logica
contabile … fanno casino"_.

## 🔑 Why a per-asset invoiced state cannot simply be added

**An asset is not an invoice line.** Assets are the **quantity** on an order line, so
several assets hang off one line:

> _"diversi asset sono collegati alla stessa riga, quindi … non hai modo di mettere
> insieme un legame uno a uno, un asset fatturato con una riga fatturata, perché sono
> diversi asset"_

Aurel Mrruku named two possible routes — propagate the order line's status to all its
assets, or **invent an ad-hoc field on the asset** — and **neither was chosen**.

## 🔑 Where the information already is

On the **order line** related list: the `FT…` invoice link plus `Mexal Payment =
unpaid`. Fabrizio Paganelli accepted that view on screen as _"a prova di stupido"_
and said _"questa maschera qui a me mi è chiarissima"_.

## The resolution

🔴 **Not settled on the call.** Aurel Mrruku left for another meeting, Fabrizio
Paganelli went to phone **Rebecca**, and Elena Spini floated renaming the label to
**`non ancora disponibile`**.

🟢🔑 **Settled by mail at 12:37 CET**, Gmail `1a1a13322fc6fb23`, Fabrizio Paganelli to
Aurel Mrruku and Elena Spini, cc Rebecca and amministrazione:

> _"mi sono confrontato con Rebecca per gli stati dell'asset. **Va bene così come
> impostato ad oggi.**"_

Elena Spini, 13:01 CET: _"Ok grazie dell'update."_

**So:** the two states stay, the `ordinato` label stays, the `non ancora disponibile`
rename is not done, and no asset-level field is built.

## What survives the decision

🆕 **The order-line `fatturato` status is still to be built** — that part Aurel Mrruku
agreed to, independently of payment, and it is not affected by this decision. See
[OI-314](../items/OI-314%20The%20order%20line%20fatturato%20status%20is%20not%20implemented.md).

⚠ **A further session with Rebecca is still owed** to check the asset labels and the
invoicing logic, per the e2e session's own next steps — this mail answered one
question, not that session.
