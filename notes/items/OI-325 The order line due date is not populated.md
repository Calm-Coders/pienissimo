---
id: OI-325
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

# OI-325 - The order line due date is not populated

**A due date per order line was asked for and agreed with Kreosoft. On at least one
production order it is empty, and nobody on the call could say why.**

## What was observed

Fabrizio Paganelli, in
[the 3 November e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md), looking
at an existing production order rather than his own test:

> _"vedete quaggiù c'era valorizzata la data di scadenza ordine. **Adesso qui non è
> valorizzata perché non lo so perché.** Questo qui è un test che avete fatto voi,
> immagino"_

Aurel Mrruku: _"Sì, penso."_ 🔴 **And the subject changed.** Nobody diagnosed it.

Fabrizio Paganelli stated the requirement in the same breath:

> _"noi avevamo chiesto a — anche parlando con Mirko — che **a livello di riga ordine
> fosse valorizzata una scadenza**"_

## Why it is open

1. 🔴 **Unexplained and uninvestigated.** The field exists and is populated on some
   orders and not on this one.
2. 🔑 **It was agreed with Kreosoft**, so the contract side is settled; this is an
   implementation or data question.
3. ⚠ **The order in question is a ROMI test order**, so it may be an artefact of how
   the test data was made rather than a defect. **Unresolved either way** — and
   [OI-315](OI-315%20Production%20test%20records%20cannot%20be%20deleted.md) means
   those orders cannot be deleted and will stay to confuse the next look.
4. 🔑 **It bears on [OI-314](OI-314%20The%20order%20line%20fatturato%20status%20is%20not%20implemented.md)**:
   the tranche due dates are what the invoicing cadence keys on, and Fabrizio
   Paganelli's whole `fatturato` argument was built on per-tranche due dates of
   30 November and 31 December. 🟢 **On his own test order, created on the call, the
   tranche due dates were set and did arrive.**

## Related

- [The Mexal integration mapping workbook](../The%20Mexal%20integration%20mapping%20workbook.md)
