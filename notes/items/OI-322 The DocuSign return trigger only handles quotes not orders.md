---
id: OI-322
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-11-03
updated: 2026-11-03
depends_on: [OI-304]
blocks: []
severity: gating
source: notes/meetings/2026-11-03 Follow-up Interno.md
---

# OI-322 - The DocuSign return trigger only handles quotes not orders

**When a signed document comes back from DocuSign, a trigger finds the Opportunity
and the Quote and sets the quote to `Firmata`. For a stage-sale order there is never
a Quote. The existing logic has to be reworked to tell an order document from a quote
document, and Aurel Mrruku has never done it. None of this is in the analysis the
client received.**

## The gap

Aurel Mrruku, in [the 3 November internal follow-up](../meetings/2026-11-03%20Follow-up%20Interno.md):

> _"dall'altra parte noi abbiamo un trigger che quando ci arriva il documento vai a
> vedere l'opportunità, il preventivo lo passi in firmata, invece qua no. Dobbiamo
> mettere mano anche su quello che c'è"_

> _"questi contratti, questi documenti, li dobbiamo collegare all'ordine a sto punto e
> dobbiamo spostare la logica. Quindi **ogni volta che ci arriva un documento da
> DocuSign dobbiamo capire se quel documento fa parte a un ordine oppure fa parte di
> una quota**. E qua sarà un bagno di sangue perché **non l'ho mai fatto, ho sempre
> usato le quote**"_

🔑 **The signature trigger point also moves.** Today the signature fires on quote
acceptance — _"firma prima scattava quando tu facevi accettato, quindi dobbiamo
intervenire anche su quando invia il documento"_ — which is why rows 7 and 8 of the
delivered flow table were reworded to _"momento in cui scatta la firma elettronica"_
and _"momento in cui il PDF firmato torna su Salesforce"_.

## 🟢 One piece of luck

> _"meno male che non abbiamo usato il preventivo standard perché sta cosa non veniva
> poi gestita, perché il preventivo standard si fa solo con le quote"_

🔑 **The custom quote object is what makes this possible at all.** Had Fase 1 used
standard Salesforce Quotes, the order path could not have been built.

## Why it is open and why it matters

1. 🔴 **Nothing is built**, and it is work on **existing production logic**, not new
   code alongside it. That is the risk: the Fase 1 signature path is live and in use.
2. 🔴 **It is absent from [the functional analysis](../The%20stage%20sale%20contract%20functional%20analysis.md)
   the client received.** RF3 says only _"Il documento firmato torna su Salesforce e
   viene tracciato"_. The rewiring is invisible in the scope and in the price.
3. 🔴 **R0 is sized at 6-7 days** — _"diciamo 7 giorni alla fine"_ — covering this,
   the new template, the bundle classification, the signature status and the resend
   button. Aurel Mrruku's own view: _"Ho la paura che abbiamo messo davvero poche
   giornate."_
4. ⚠ **The documents must also be linked to the Order**, not just routed. Another
   change to the existing model.
5. 🔑 **The build window is the week of 9 November**, which is the technical go-live
   week.

## Related

- [OI-326](OI-326%20A%20second%20PDF%20template%20is%20needed%20for%20corsi%20and%20for%20Plus.md)
- [OI-328](OI-328%20A%20bundle%20containing%20a%20Plus%20product%20must%20be%20flagged%20as%20a%20Plus%20bundle.md)
- [How the Quote acceptance email action works](../How%20the%20Quote%20acceptance%20email%20action%20works.md)
