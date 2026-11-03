---
id: OI-317
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

# OI-317 - The payment condition description field must become quote notes

**Tutors type bespoke instalment plans into the free-text payment-condition
description, which would make the invoices unworkable. The client asked for the field
to be obscured. It becomes `note preventivo` instead, larger, because tutors do
genuinely need somewhere to write.**

## The demonstration

Fabrizio Paganelli found the field on his test quote in
[the e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md), asked what it was,
and then showed what his tutors put in it — an agreed instalment schedule with
amounts and dates in prose. Aurel Mrruku's reaction:

> _"E buona fortuna poi con le fatture"_

Fabrizio Paganelli:

> _"se il tutor può andare a scrivere quello che gli pare, dopo entriamo in quello
> scenario dove loro qui ti mettono e cominciano a scrivere"_ … _"magari questo qui,
> fatemi la cortesia, **oscuratelo questo campo**"_

Elena Spini and Aurel Mrruku agreed on the spot.

## 🔑 But the field does not simply disappear

Fabrizio Paganelli reversed himself within two minutes, and this is the part that
matters:

> _"è anche vero che magari i tutor hanno necessità di scrivere delle note … A volte
> capita che i tutor nel preventivo debbano scrivere determinate cose perché gliele
> richiedono al cliente. Quindi lì scrivete pure **note preventivo**"_

So:

| Change | Detail |
| ------ | ------ |
| **Obscure** `descrizione condizioni di pagamento` | The structured payment condition itself stays; only the free-text description goes. |
| **Rename to `note preventivo`** | Aurel Mrruku supplied the name. |
| **Enlarge it** | _"mettere un campo più grande qua, di modo tale che quando scrivono le note, che a volte possono essere anche molto lunghe, hanno la visibilità completa"_ |

🔑 **Elena Spini confirmed the original field was deliberate** — _"era un campo che
avevamo detto a livello di data model"_ — so this is a reversal of a Fase 1 decision,
not a correction of an accident.

## ⚠ A tension to resolve before building

🔑 **ROMI ruled out free note fields on quotes and orders on 30 October**, at
Fabrizio Paganelli's own request, _"per limitarne l'uso non corretto dei
commerciali"_ — see
[OI-292](OI-292%20The%20Notes%20related%20lists%20on%20Lead%20Account%20and%20Opportunity%20are%20not%20built.md)
and the same tension already flagged on
[OI-306](OI-306%20The%20WooCommerce%20order%20number%20must%20reach%20Mexal%20in%20the%20order%20header%20note.md).

⚠ **This item re-introduces exactly that field on the quote, four days later, at the
request of the same person.** It is defensible — the objection was to payment terms
in free text, not to notes as such — **but nobody has said so, and whoever builds it
should not discover the 30 October ruling afterwards.**

## Why it is open

1. 🔴 **Nothing is built.**
2. ⚠ **Whether the renamed field prints on the quote PDF is unstated.**
3. 🔑 **Incidental finding worth keeping**: changing anything that feeds the invoice
   returns the quote to **`Bozza`** and the PDF must be regenerated. Aurel Mrruku:
   _"ogni volta che te fai dei cambiamenti che hanno a che fare con i dati che sono
   sulla fattura"_.
