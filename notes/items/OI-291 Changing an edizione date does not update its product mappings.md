---
id: OI-291
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-27
updated: 2026-10-27
depends_on: [OI-276]
blocks: []
source: notes/meetings/2026-10-27 Anagrafica Articoli.md
---

# OI-291 - Changing an edizione date does not update its product mappings

**An edizione's date range is copied into each product-edition mapping record
when the mapping is created. Changing the date on the edizione afterwards leaves
every mapping behind, so a confirmed event date means hand-editing roughly twenty
mapping records. Nothing detects the mismatch, and the client has been told to
do it by hand.**

## Why it matters now

Events are being entered **before their dates are known**. Fabrizio Paganelli's
worked example in [the 27/10 call](../meetings/2026-10-27%20Anagrafica%20Articoli.md)
is **Food Marketing Festival 2027**: the date is not fixed, is typically
confirmed five or six months out, and orders are already landing against the
provisional range.

> _"la data oggi non ce l'abbiamo, magari la vengono a conoscere tra due mesi, io
> però qui devo mettere da data a data perché altrimenti non mi si generano i
> biglietti, quindi sto largo nel campo a data competenza e poi dopo quando la
> modifico devo cambiarla sia qui che anche nella mappatura."_

## The mechanism, as stated by its author

Aurel Mrruku, `00:11:06`–`00:13:41`:

> _"quando farai la mappatura edizione prodotto andrà a leggere quella data nel
> momento in cui te fai la mappatura … nella mappatura si prendono da data a data
> e si mettono nel record di mappatura … **se le cambi sull'edizione non ti cambia
> niente sui record**."_

An order binds to an edizione by falling inside the **mapping record's** date
range, not the edizione's. So after a date change the two disagree and the
mapping wins.

## The cost, conceded in the room

> **Aurel Mrruku:** _"sappi che tu puoi avere anche una ventina di prodotti,
> quindi una ventina di mappature con questa [edizione], quindi **devi andare 20
> volte su ogni record** a cambiare sta cosa."_
>
> **Aurel Mrruku:** _"Sì, sì, **è un casino**."_ … _"Ok, è il lavoro in più per
> te, Fabrizio."_
>
> **Fabrizio Paganelli:** _"Devo modificare anche la mappatura. Devo modificare
> anche la mappatura. Ok."_

Fabrizio Paganelli accepted it and noted he intends to reduce the number of
article codes, which would shrink but not remove the work.

## What is and is not exposed

🟢 **Orders and tickets already generated are safe.** The ticket keeps its
edizione link — _"se i biglietti sono stati generati e inviati non ti cambia
niente"_ — and Fabrizio Paganelli confirmed that is the part that matters to him:
_"l'importante è che il biglietto sia collegato a quell'edizione."_

🔴 **Orders not yet created are exposed.** Between a date change on the edizione
and the manual repair of its mappings, a new order reads the stale mapping range
and can bind to the wrong edizione — or to none.

## Open

1. 🔴 **No detection.** Nothing compares an edizione's dates against its
   mappings, and nothing warns on save.
2. 🔴 **No owner for the repair beyond the client.** The procedure as agreed is
   "Fabrizio edits twenty records"; there is no runbook, no list view and no bulk
   path. The delete path in the same object was also found to be one-by-one in
   the UI.
3. ⚠ **Not in the requirement register.** No row describes the mapping's date
   semantics, so the behaviour is defined only by the build and by this note.
4. ⚠ **Interaction with the far-future provisional date is unexamined.** The
   agreed workaround for an unscheduled event is a deliberately distant date
   (so [the ticket automation](OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md)
   does not fire), which guarantees that every such edizione will later need this
   manual repair. The two rules were agreed in the same conversation and the
   compounding was not raised.
5. ⚠ **No test.** Nothing in the record exercises an edizione date change against
   existing mappings.
