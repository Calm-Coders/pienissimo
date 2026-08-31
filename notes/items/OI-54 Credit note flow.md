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

**The cancellation state has two names, and the diagram wins.**
[The newest design diagram](../The%20newest%20design%20diagram.md) (6 August 15:22)
specifies a button _"Crea Nota di Credito"_ at order level opening a popup to
pick the order lines, and states that credit notes on `evento` products update
the manually selected assets to **`Annullato`**. Elena's `PIENISSIMO - Project
Status.docx`, same day, calls the same state **"rinuncia al servizio"**.

**Build `Annullato`** — see [OI-74](OI-74%20Asset%20state%20machine.md) — and
correct the prose document.

**The requirement is older than the tracker row.** Pienissimo asked for exactly
this on **11 June 2026**, in
[their own requirements document](../The%20client%20June%20requirements%20document.md),
as an internal open point owned by **Fabrizio Paganelli**: _"cliente che rinuncia
a servizio già parzialmente fatturato (nota di credito + chiusura ordine, oggi
'chiuso perso' su Zoho)"_. So the flow has a named owner on the client side who
has never been asked for it here.

Volume is ~30 a year, some large. Not urgent, but it must be diagrammed —
Elena Spini owns the diagram, ROMI the build.

This **supersedes the licensing-only framing** of the original credit-note item,
which asked merely whether the standard object was licensed.

It is also the reason [OI-85](OI-85%20Order%20state%20set%20may%20be%20incomplete.md)
is open: the proposed fourth order state _Perso_ exists only because of credit
notes.
