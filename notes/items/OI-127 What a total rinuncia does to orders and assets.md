---
id: OI-127
type: open-item
status: open
owner: Fabrizio Mastracci
with: Rebecca Marmo
org: both
raised: 2026-09-07
updated: 2026-09-07
depends_on: [OI-74]
blocks: [OI-78]
source: notes/meetings/2026-09-07 Interna Flussi MKT.md
---

# OI-127 - What a total rinuncia does to orders and assets

**Rinuncia cancels every ticket in one action. Nobody has said what that does to
the order behind them, or to the credit Elena Spini mentioned.**

## The questions, as raised

Aurel Mrruku put three to the room at
[the 7 September marketing session](../meetings/2026-09-07%20Interna%20Flussi%20MKT.md)
and none was answered:

1. **What happens to the order** when a customer renounces entirely?
2. **What happens to the assets**?
3. **Elena Spini mentioned a credit towards future events.** Is that real, how is
   it represented, and who tracks it?

Action on Fabrizio Mastracci to ask **Rebecca Marmo**, and on the group to
schedule a call with her.

## 🟢 Half of question 2 is already answered, in writing, and is three weeks old

Fabrizio Mastracci's own **20 August recap** to Pienissimo — forwarded into this
mailbox by Elena Spini at 08:48Z the same morning, hours before the session —
states it plainly:

> _"finché non compila almeno un nominativo o clicca "Rinuncia" (che annulla
> tutti i biglietti, non è parziale)"_

So **rinuncia is all-or-nothing at ticket level**: it cancels every ticket, and
there is no partial rinuncia. The asset side has an answer.

⚠ **It was not brought into the session by the person who wrote it.** The
question was asked and treated as open in a room containing its author, on a day
when the document had just been circulated. Whoever chases Rebecca Marmo should
chase **the order and the credit**, not the ticket behaviour.

## What is genuinely open

- **The order.** Assets become `annullato`; the Order they came from has a
  lifecycle of its own — `Ordinato → Fatturato → Incassato` — and by the time a
  nurturing flow runs the order is typically **`Incassato`**, meaning paid.
  Cancelling the tickets against a paid order leaves a state nothing describes.
- **The credit.** If a renouncing customer keeps value towards a future event,
  that is an object, a balance and an expiry that exist nowhere in the data
  model, the register or the workbook. Elena Spini raised it; nobody confirmed it.
- **The invoice.** Invoices are generated **manually on Mexal by Fabrizio
  Paganelli**
  ([the 7 September follow-up](../meetings/2026-09-07%20Follow-up%20Interno.md)),
  so a rinuncia after invoicing is a manual credit note nobody has scoped. The
  scadenzario correction path that would touch it was **deferred to Fase 2** in
  the same session, and Fase 2 is parked pending payment.

## Why it blocks

[OI-78](OI-78%20Participant%20data%20collection.md) is now being built with
**rinuncia inside the community page**
([the decision](../decisions/Decision%20-%20rinuncia%20moves%20from%20the%20marketing%20email%20to%20the%20community.md)).
The page has to do something when the button is pressed. Cancelling the assets is
implementable today; touching the order or issuing a credit is not, because
neither behaviour has been specified.

⚠ **This is the third recorded commitment to get Rebecca Marmo into a session.**
[OI-81](OI-81%20Event%20communication%20funnel.md) records that from 6 August she
was to join **all** flow, field and ticket calls; the deciding call in
[OI-86](OI-86%20Who%20hosts%20the%20participant%20landing%20page.md) was never
scheduled and the page was built without it. She did join
[Data Model Parte 3](../meetings/2026-09-07%20Data%20Model%20Parte%203.md) for two
minutes by telephone and settled a consent question immediately. **She answers
things fast when she is in the room.**
