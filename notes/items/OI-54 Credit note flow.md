---
id: OI-54
type: open-item
status: open
owner: Elena Spini
with: ROMI
org: ROMI
raised: 2026-07-22
updated: 2026-08-14
source: meetings/open-items.md row 54
---

# OI-54 - Credit note flow

Agreed at high level on 2026-07-22 and specified further on 2026-08-06.

Administration creates the credit note and links it to **both the order and the
order line** — partial reversals matter because a multi-event bundle may need
only one component reversed. Credit notes on "evento" products **auto-set the
matching asset to _Annullato_**. Refunds are normally issued as credit toward
future purchases rather than bank transfers, handled by the tutor.

The 2026-08-06 session specified the mechanism: a **button at order level**
opening a popup to select the specific order lines to reverse, partially or
fully.

**The cancellation state is named.** Elena Spini's `PIENISSIMO - Project Status`
document (6 August) specifies that the individual tickets are selected and
cancelled by setting the asset to **"rinuncia al servizio"** — a state missing
from [the agreed state machine](OI-74%20Asset%20state%20machine.md), which stops
at _Utilizzato / Non utilizzato_.

Volume is ~30 a year, some large. Not urgent, but it must be diagrammed —
Elena Spini owns the diagram, ROMI the build.

This **supersedes the licensing-only framing** of the original credit-note item,
which asked merely whether the standard object was licensed.

It is also the reason [OI-85](OI-85%20Order%20state%20set%20may%20be%20incomplete.md)
is open: the proposed fourth order state _Perso_ exists only because of credit
notes.
