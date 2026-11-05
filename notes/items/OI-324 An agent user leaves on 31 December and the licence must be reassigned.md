---
id: OI-324
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku
org: both
raised: 2026-11-03
updated: 2026-11-03
depends_on: []
blocks: []
source: notes/meetings/2026-11-03 Test e2e PROD.md
---

# OI-324 - An agent user leaves on 31 December and the licence must be reassigned

**One of the seven agents given production access on 3 November ceases his engagement
on 31 December and will be replaced. Recorded because the licence pool is already
oversubscribed and because the replacement lands six weeks after go-live.**

## The facts

Fabrizio Paganelli volunteered it in
[the 3 November e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md), while
the activation mails were being sent:

> _"Davide Stefani è una persona che è inquadrato come agente, non è dipendente di
> Pienissimo. **Al 31 di dicembre cesserà l'attività**, dopo lo dovremmo sostituire
> con un'altra persona nuova che entrerà. Quindi, però immagino che non ci sia problema
> da questo punto di vista."_

Aurel Mrruku confirmed it is simple: _"cambiamo la mail username a sto punto non è un
problema."_

## Why it is worth a row

1. 🔑 **It is a live user in production with an Agente profile and an agent code**, so
   it is a handover, not just a rename: the accounts assigned to his agent code need
   an owner.
2. 🔑 **The licence pool is already short.** Twelve licences were confirmed on
   2 November and the allocation already came to eleven with account sharing proposed
   to cover the gap — see
   [OI-300](OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md).
   A replacement is a swap, not an addition, **provided the swap actually happens.**
3. ⚠ **31 December is six weeks after the 16 November operational start**, inside the
   first month of live use and inside the Fase 2 R1 window.
4. ⚠ **No successor is named** and no date is set for the handover.

## 🔑 The seven, for the record

Production activation mail was sent on 3 November to seven agent users, read out on
the call: **Carmen, Davide S., Barbara, Segreteria, Sara D., Martina, Valentina V.**
By the end of the session **Carmen, Barbara, Martina and Valentina had completed
verification**. ⚠ **Verification links expire after 72 hours.**

⚠ **Seven against Marco Montesi's six.** He confirmed by mail the same day — _"Per il
momento ti confermo le 6 utenze da te indicate"_ (Gmail `1a1a1220e6f9e14f`) — against
the seven actually provisioned. **The discrepancy is unexplained**; `Segreteria` is a
shared mailbox rather than a person, which would reconcile it, but nobody said so.

⚠ **Personal employment details beyond the departure date are deliberately not
recorded here.**
