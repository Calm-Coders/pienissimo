---
id: OI-196
type: open-item
status: resolved
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-09-29
updated: 2026-10-06
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
asks how Marketing Cloud _queries_ completeness. This asks what the **send** does.

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

## 🟢 2026-09-30 — resolved by the client, against the 29/09 design

**The client ruled the opposite of what ROMI agreed internally the day before:
the named tickets are sent, and the unnamed ones are burned.** At
[the 30/09 ticket UAT](../meetings/2026-09-30%20UAT%20Biglietti%20Asset%20Campagne%20ed%20Eventi.md)
(`01:02:22`–`01:03:48`), with Fabrizio Paganelli, Rebecca Marmo, Sabatino Rinaldi
and Elisa Migliano present.

Fabrizio Paganelli, on the exact five-tickets-three-named case this note was
opened for:

> _"il cliente ha comprato cinque biglietti, li ha già pagati tutti, però non ha
> le persone per venire. È chiaro che lo nomina, i biglietti vengono nominati solo
> per i tre che parteciperanno, gli altri due glieli bruceremo."_

Rebecca Marmo added that the unnamed two **stay `Disponibile`** so a buyer who
changes their mind can still use them. The consensus recorded in the session
notes: compiled tickets are sent **within a few hours**, unnamed ones remain
available and are burned close to the event if unused.

🔑 **The premise of the 29/09 design was also wrong.** The all-or-nothing rule was
justified by an indiscriminate daily reminder that does not exist. Rebecca Marmo,
who runs the sends:

> _"in realtà non continuo a ricevere comunicazioni di nominare anche gli altri
> due, perché io controllo anche se ha già effettuato delle iscrizioni"_ ·
> _"metto un ritardo orario che decido io di 2 5 7 8 10 giorni"_

Fabrizio Paganelli translated it for the room: the send is _"tra virgolette
manuale"_ — automated, but launched on a chosen day and stepped up near the event,
**not fired daily by date**.

**So the client's own written exit rule wins**, exactly as this note argued:
`SEGMENTI FUNNEL BIGLIETTI.docx` and Fabrizio Mastracci's 20/08 recap were right
and the 29/09 room was wrong. Neither of the two proposals recorded above was
needed — no deadline rule, no final-warning mail, no re-entry guard.

🟢 **The linked rinuncia question is settled too.** Sabatino Rinaldi, `01:44:11`:
_"lasciamolo lì e nel momento in cui lui nomina almeno un biglietto, quel tasto
sparisce e abbiam finito."_ The button stays visible until the first nomination,
then disappears — which is Elena Spini's _"always available"_ position **only up
to the first name**, and removes Aurel Mrruku's asset-status-history objection,
because a partially-named order can no longer be renounced at all.

⚠ **This ruling is what the build now has to follow, and the build does not.** The
trigger becomes **at least one** confirmed participant, not all — carried into
[OI-197](OI-197%20The%20ticket%20send%20flag%20and%20the%20Inviato%20asset%20state%20are%20agreed%20and%20unbuilt.md).
Elena Spini owns configuring the button visibility; her action item has no date.

**Resolved on the rule. The build is [OI-197](OI-197%20The%20ticket%20send%20flag%20and%20the%20Inviato%20asset%20state%20are%20agreed%20and%20unbuilt.md).**

## 2026-10-02 — partial participant save implemented in source

`participantRegistrationPage` now enables its save action when at least one row
is complete, sends only complete rows, and leaves blank ticket rows available for
later. A partly filled row still blocks the save until it is completed or
cleared. `ParticipantRegistrationController.savePage` now accepts that submitted
subset while continuing to reject empty, invalid, duplicate or stale ticket
inputs. The existing `TicketingTest` registration scenario now saves the two
participants one at a time and checks that the first save leaves the page
`READY` and the other Asset `Disponibile`.

All four fields now use `lightning-input`'s supported `change` event, which fires
as its value changes. Phone sanitization runs inside that same handler. This
avoids the native `input` event, which did not reliably cross the base component
boundary and left the row badge at `Da compilare`. The LWC test completes one
ticket while leaving another blank and asserts that the save button enables.

The save action no longer depends on that live badge state at all. It remains
enabled whenever editable tickets exist, synchronizes the values currently
visible in every input when clicked, and then validates the resulting rows.
Empty and partial submissions are still rejected, while one complete row opens
confirmation even if another row is blank. The regression test sets visible
values without dispatching field events and verifies the one-participant
confirmation.

The page also snapshots started participant rows before a `Rinuncia` action and
restores those drafts after the server refresh for every ticket that still exists
and remains editable. Data entered for another edition is therefore not lost;
the renounced edition is deliberately not restored. An LWC regression test
covers this two-edition case.

The page response now also retains Assets already in `Rinuncia`. The LWC keeps
them out of the editable edition groups and lists them in a read-only **Biglietti
in rinuncia** summary at the end of the page, after the assigned-ticket summary.
This also makes the result of a successful rinuncia visible immediately after
the server refresh.

This is a repository implementation only in this session; it was not deployed.
It implements the nomination-page half of the 30/09 ruling. The downstream send
contract and field placement remain tracked separately by OI-197 and OI-199.

## 🔴 2026-10-06 - the follow-up half is given up for go-live

This row resolved the send question: each participant gets their ticket as soon
as the referente confirms their data, without waiting for the others. **The
chasing question has now been answered too, and the answer is that nobody
chases.**

[The 06/10 client session](../meetings/2026-10-06%20Form%20Link%20per%20partecipanti.md),
`Concordato`:

> _"Esclusione dei flussi di follow-up per nomine parziali: si stabilisce di
> mantenere la configurazione esistente, rinunciando temporaneamente ai flussi di
> follow-up per le nomine parziali in vista del go-live."_

Sabatino Rinaldi had proposed the opposite — dynamic follow-ups to chase the
remaining nominations, plus per-ticket deletion or renunciation. **Elena Spini
and Elisa Migliano declined on time grounds**, _"la scadenza del go-live fissata
a 2 settimane"_, and Sabatino Rinaldi and Rebecca Marmo accepted.

### What it means in the funnel

[The send contract](../The%20marketing%20ticket%20send%20logics%20as%20written%20by%20Marketing.md)
implements it as an exit clause: the contact continues only _"se non ha
completato almeno 1 iscrizione (Iscr effettuate è minore di 1)"_. So **one
nomination of five ends the eleven-step funnel**, and the other four tickets are
never chased again.

⚠ Elena Spini stated the consequence herself and accepted it anyway —
_"per me è no sense e rischiano di aver i biglietti nominati a metà ma se va bene
a loro"_. **The deferral is marked `temporaneamente` and has no Fase 2 row**: no
item, no owner and no date carries the follow-up flows forward. If this is meant
to come back, nothing in the records will bring it back.
