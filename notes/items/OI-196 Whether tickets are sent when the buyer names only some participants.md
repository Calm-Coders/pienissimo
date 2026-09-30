---
id: OI-196
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-09-29
updated: 2026-09-29
depends_on: [OI-126, OI-127, OI-78]
blocks: [OI-194]
requirement: BIG-06
source: notes/meetings/2026-09-29 Pre UAT Check giro MKT.md
---

# OI-196 - Whether tickets are sent when the buyer names only some participants

**A buyer with five tickets who names three and stops gets no tickets at all under
the design agreed on 29/09 — and the client's own funnel document says that buyer
has already left the nurturing funnel. Nothing sends the three. It is on the
30/09 client agenda.**

## The design as agreed internally, 29/09

At [the pre-UAT marketing session](../meetings/2026-09-29%20Pre%20UAT%20Check%20giro%20MKT.md)
(`00:00:00`–`00:15:00`) Aurel Mrruku and Fabrizio Mastracci settled on
**all-or-nothing**: the ticket send fires only when every participant on the order
is confirmed.

- Fabrizio Mastracci: _"o rinunci e non ti mando niente o accetti tutti quanti e ti
  mando i biglietti, sennò se tu sei ancora lì a decidere io non ti posso mandare
  dei biglietti."_
- Aurel Mrruku: _"Quindi il biglietto si deve mandare quando si conferma tutto."_

Both prefer two outcomes to three: _"per farlo in maniera netta… sennò poi queste
vie di mezzo ci troviamo pure in delle zone grigie."_

## 🔴 It contradicts the client's written exit rule

`SEGMENTI FUNNEL BIGLIETTI.docx`, already held under
[OI-126](OI-126%20An%20asset%20flag%20for%20incomplete%20participant%20data.md):

> _"un contatto avente 3 biglietti può decidere di partecipare anche solo con 1
> biglietto e in questo modo, una volta inseriti i dati, esce dal funnel e non
> riceve più comunicazioni."_

And Fabrizio Mastracci's own 20 August recap to the client has the reminder ladder
stopping _"finché non compila **almeno un nominativo** o clicca Rinuncia"_.

**Under the client's document, a buyer who names one of three exits the funnel and
stops being chased. Under the 29/09 design, that same buyer is never sent
anything.** The two documents are both live, both client-facing, and nobody
reconciled them in the session — the exit rule was not raised.

⚠ This is not the same question as
[OI-126](OI-126%20An%20asset%20flag%20for%20incomplete%20participant%20data.md), which
asks how Marketing Cloud *queries* completeness. This asks what the **send** does.

## The consequences named in the room

- **Tickets never arrive.** Elena Spini: _"Il biglietto non arriverà mai perché
  mancano due partecipanti."_
- **A carried-over credit.** Fabrizio Mastracci's own worry — _"rimane in credito di
  due biglietti perché non li ha compilati e quindi la campagna dopo lui ha
  praticamente da compilare quei due mancanti più altri che potrebbe aver
  comprato"_. That is the same unspecified credit
  [OI-127](OI-127%20What%20a%20total%20rinuncia%20does%20to%20orders%20and%20assets.md)
  has carried since 07/09, reaching the same dead end from the other direction.
- Aurel Mrruku on buying five and using four: _"è un casino"_ — Fabrizio Mastracci
  agreed.

## The two proposals on the table, neither adopted

1. **A deadline rule** (Aurel Mrruku): _"x giorni prima dell'evento, se non hai
   compilato, devi mandare i biglietti che hai compilato"_ — then immediately,
   _"però sta cosa è assurda e confusa a sé"_.
2. **A final-warning mail** (Fabrizio Mastracci): re-send the same mail, then a
   third with changed text saying that ignoring it renounces the unfilled tickets.
   🔴 He named its flaw himself — the registration link stays live, so the buyer can
   re-enter after the deadline. A re-entry guard would be needed.

## Rinuncia after partial entry

A second, linked question. Elena Spini wants the rinuncia button available at any
point, because _"lui voleva venire veramente, poi succede che è ammalato"_. Aurel
Mrruku's objection is mechanical, not commercial: it changes the asset state, and
_"un asset genera un QR code"_ — so a cancelled asset must drop out of Marketing
Cloud's query, **and an asset status history would have to be built** to keep the
post-event statistics honest. He asked not to add it: _"cerchiamo di non
complicare le cose… siamo molto stretti sulle giornate."_ Undecided.

## Status

📅 **On the 30/09 client agenda.** Elena Spini logged it in the session as an open
point — _"caso in cui il referente principale non compila tutti i partecipanti"_ —
and both she and Fabrizio Mastracci pressed to close it with the client rather than
leave it to interpretation: _"se lasciamo sempre a loro interpretazione ci rendono
tutte le cose più complicate."_

⚠ Elena Spini also proposed sending the client the full question list by mail
afterwards. Not confirmed sent.
