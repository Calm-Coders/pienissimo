---
id: OI-316
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

# OI-316 - The quote line needs a net amount column

**A tutor on the phone cannot see a line total. The unit price times the quantity is
never shown, so the figure only appears when the quote PDF is printed. Agreed on the
3 November production test: add an `importo netto` column and rename the existing
field to `prezzo netto`.**

## The request

Fabrizio Paganelli, in [the e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md),
arguing from the tutor's seat:

> _"mi metto sempre nei panni di un tutor, no? Quando lì il telefono dice 'Quanti
> biglietti vuoi?' 'Due.'"_ … _"senza dover fare i conti con la macchinetta"_ …
> _"sennò qui a lui gli verrà fuori un preventivo … che però non lo vede, ma lo vede
> solo dopo alla fine quando stampa il preventivo"_

## What was agreed

| Change | Detail |
| ------ | ------ |
| 🆕 **`importo netto`** | A new line field, **quantity × net price** — the row total. Aurel Mrruku: _"importo totale"_, Fabrizio Paganelli: _"importo netto"_; **`importo netto` is the agreed name.** |
| **`nuovo prezzo` → `prezzo netto`** | Rename of the existing field. Fabrizio Paganelli: _"chiamiamolo prezzo netto anziché nuovo prezzo"_. |
| **Quantity stays put** | Elena Spini pointed out the `quantità e stato` column header already carries it; Aurel Mrruku agreed not to move it. |

⚠ Fabrizio Paganelli asked to reorder the columns to match the printed quote's
sequence. Aurel Mrruku's answer was that the layout narrows too much if everything
moves inline — _"Si possono, però poi si restringe tanto"_ — and Elena Spini backed
the current arrangement. **Aurel Mrruku's position: add the field first, then look —
_"Mettiamo il campo meglio e poi vediamo come si vede."_** So the column order is
**not settled**.

## Why it is open

1. 🔴 **Nothing is built.** It is a production layout change.
2. ⚠ **Quote totals were never released to production at all.** Fabrizio Paganelli
   noticed the quote lacked the total and discount-total fields; Aurel Mrruku:
   _"molto probabilmente non l'ho portato io in produzione"_. **So this item sits on
   top of an incomplete release.** He has done one partial production release to test
   functionality.
3. ⚠ **No register row covers quote line layout.**

## Related

- [Quote PDF field mappings](../Quote%20PDF%20field%20mappings.md)
