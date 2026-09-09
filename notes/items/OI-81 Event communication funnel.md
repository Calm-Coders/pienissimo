---
id: OI-81
type: open-item
status: open
owner: Elena Spini
with: Rebecca Marmo
org: both
raised: 2026-08-06
updated: 2026-09-08
blocks: [OI-86]
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
requirement: BIG-06
---

# OI-81 - Event communication funnel

The event communication funnel **automates at 60 days before the event** — a
30-to-60-day window, chosen to cut no-shows — driven by account tags plus the
event date, and auto-sending the participant-data link.

**Multi-event bundles get per-event communications**, each on its own
countdown. That is the detail that makes this more than a scheduled email: one
purchase can produce several independent funnels running months apart.

A dedicated marketing-funnel meeting is to be held with Rebecca Marmo, Marco
Montesi and Matteo, and Rebecca is to join **all** flow, field and ticket calls
from now on.

📅 **Now scheduled: 19 August 2026.** Elena Spini's 7 August status names it —
_"il 19.08 meeting per definire i due flussi MKT"_ — and notes that **both
marketing flows will be ticket-focused**, now that the ticket flow is confirmed.
It carries [OI-86](OI-86%20Who%20hosts%20the%20participant%20landing%20page.md)
with it, which blocks
[OI-78](OI-78%20Participant%20data%20collection.md).

⚠ The marketing workstream has its own long-standing block —
[OI-14](OI-14%20Marketing%20forms%20and%20subdomain.md), open since 23 June — so
this funnel is being designed on top of a stream that is not itself unblocked.

## 2026-08-19 - a second send, with no date on it

[The 19 August ticket flow diagram](../The%20ticket%20flow%20diagram%20of%2019%20August.md)
draws the funnel as **two communications, not one**: the known one _"A 30-60
giorni dall'evento"_, and a second marked **_"A XX giorni dall'evento"_**. The
`XX` is literal — a placeholder left in the file. So the funnel's second send
exists in the design and **its timing is an open decision**, owned with the rest
of this item.

**Whether the 19 August session actually took place is unconfirmed.** The
diagram landed that afternoon and matches the subject, but there is no
recording, no canvas entry and no message — see the diagram note. If the
session did run, **it is unminuted**, and this item cannot close on a drawing.

## 2026-08-24 - two flows, one unresolved number, and a hard style constraint

The [19 August MKT session](../meetings/2026-08-19%20Flussi%20MKT%20Biglietti.md) specified the funnel:

- **Two distinct flows, not one.** The first, at **30 or 60 days** before the
  event, exists to reduce the no-show rate. The second, close to the event,
  sends the participant-list link and collects the data.
- ⚠ **30 vs 60 is not settled.** The minute carries both figures and then an
  action for Elisa Migliano and Rebecca Marmo to **confirm with Matteo Distaso
  which it is**. Elsewhere in the same session the participant-list request is
  said to go out "usually 60 days before, though it can vary by case".
- **Style is a constraint, not a preference.** Matteo Distaso specified plain
  text — **no header, no images, no buttons** — written so as to read as coming
  from Giuliano personally. This rules out the graphical newsletter template a
  Marketing Cloud build would otherwise default to, and it should be recorded
  before anyone designs one.
- The current Zoho funnel drives off **tags on the contact** (`rinuncia`,
  `iscritto`, `presente`) and if/else branches checking whether the user filled
  the form or clicked a link. Rebecca Marmo and Matteo Distaso owe screenshots so
  [Fabrizio Mastracci](../people/Fabrizio%20Mastracci%20-%20marketing%20automation%20ROMI.md)
  can rebuild it.

The master diagram's `A 30-60 giorni dall'evento` and `A XX giorni dall'evento`
boxes match this exactly — the `XX` is genuinely undecided, not a placeholder
someone forgot.

## 2026-08-28 - the two flows are confirmed, and the build has started

Elena Spini's weekly status in `#tproj-pienissimo` (**12:13:32Z**) records the
approval: _"sono stati confermati i 2 flussi lato MKT (ci sta lavorando
Fabrizio)"_ — the two-flow design above is **confirmed**, and
[Fabrizio Mastracci](../people/Fabrizio%20Mastracci%20-%20marketing%20automation%20ROMI.md)
is building it.

🔴 **`30 vs 60` is still not settled by this.** The status confirms *two flows*;
it says nothing about the number, and no source since 19 August records Elisa
Migliano or Rebecca Marmo confirming it with Matteo Distaso. The first flow's
trigger point remains **undecided while it is being built** — that is the thing
to close first, and it is one question to one person.

⚠ The style constraint above (plain text, no header, no images, no buttons,
written as if from Giuliano personally) has **never been restated to whoever is
building it**. It is easy to lose in a Marketing Cloud build and expensive to
retrofit. Put it in front of Fabrizio Mastracci.

The funnel screenshots owed under
[OI-14](OI-14%20Marketing%20forms%20and%20subdomain.md) are still unconfirmed on
every source this sweep reaches, and the 100+ form review is confirmed by the
same post as **still outstanding**.

## 2026-08-31 - a forum finally exists for both open questions

🟢 Elena Spini scheduled **`[PIENISSIMO]- Interna Flussi MKT`** for **Monday 7
September, 10:00–11:00 CEST** (invitation sent 31 August 16:07Z). Attendees:
**Elena Spini, Aurel Mrruku and Fabrizio Mastracci** — ROMI-internal, no client
present.

This is the first marketing-flow session since **19 August**, and it is the
natural place to close the two things this note has been carrying:

1. **`30 vs 60`** — undecided while the flow is being built. One question to one
   person, and it decides the trigger point of a flow already under construction.
2. **The style constraint** — plain text, no header, no images, no buttons,
   written as if from Giuliano personally. Never restated to the builder, and
   Fabrizio Mastracci will be in the room.

⚠ Both questions have a **client-side** dependency that this internal meeting
cannot discharge: `30 vs 60` was Elisa Migliano's and Rebecca Marmo's to confirm
with Matteo Distaso, and no source since 19 August records that happening. An
internal decision on 7 September would be ROMI choosing on the client's behalf.
That may be the right call this late — but it should be taken knowingly and
minuted as such, not slipped in.

⚠ Recorded from the calendar invitation alone. **No agenda was published**, so
what this meeting will actually cover is not known — the two items above are what
the record says *should* be on it, not what is.

## 2026-09-07 - the session ran, and the number is settled without the client

🟢 **[The session ran](../meetings/2026-09-07%20Interna%20Flussi%20MKT.md)** —
7 September 10:00 CEST, Elena Spini, Aurel Mrruku, Fabrizio Mastracci, about an
hour, ROMI-internal as booked.

🟢 **`30 vs 60` is now stated as a window, not a choice**: communications run
**between 30 and 60 days before the event** to cut no-show, and the
**data-collection mail goes roughly 60 days before**. That is the trigger point
the build needed.

🟢 **It is corroborated in the client's own copy.** Fabrizio Mastracci's **20
August recap**, written to Marco Montesi, Matteo Distaso and Rebecca Marmo and
forwarded into ROMI's mailbox at 08:48Z the same morning, says the nurturing flow
is _"avviato 30-60 giorni prima dell'evento"_ and adds detail this note did not
hold: the reminders run to **10–11 communications** until the recipient either
enters a name or clicks Rinuncia, and the second flow fires on data entry, tags
the contact `iscritto` and sends the ticket and QR code by **email and WhatsApp**.

🔴 **The single figure is still ROMI's own.** This note warned on 31 August that
an internal decision would be ROMI choosing on the client's behalf, because the
confirmation was Elisa Migliano's and Rebecca Marmo's to get from Matteo Distaso.
**No source records that happening.** The window is documented to the client; the
trigger point inside it is not. Taken knowingly is fine — but it is taken.

🔴 **The style constraint was still not restated.** This note has flagged since 24
August that Matteo Distaso's plain-text rule — no header, no images, no buttons,
written as if from Giuliano personally — has never been put in front of whoever
builds the flow. **Fabrizio Mastracci was in the room, is now starting the first
email's configuration, and nothing in the summary, decisions or details mentions
it.** The 20 August recap does carry it in writing —
_"solo testo, senza header/immagini/pulsanti, per restare personali"_ — and he
wrote that himself, so the risk is lower than it was. It is still not confirmed
as an instruction to the build.

🟢 **The tag machinery this funnel drives off is being retired underneath it.**
Fabrizio Mastracci proposed keying flow entry off **CampaignMember creation or
ticket state** rather than the inherited Zoho tags; three hours later
[Data Model Parte 3](../meetings/2026-09-07%20Data%20Model%20Parte%203.md) deleted
the tag fields and moved the states to CampaignMember
([the decision](../decisions/Decision%20-%20consents%20live%20on%20the%20contact%20and%20editions%20on%20the%20campaign.md)).
Both sides reached it independently on the same day. The `Rinuncia`, `Iscritto`
and `Presente` vocabulary survives as **status values**, not as tags.

🔴 **Rinuncia leaves the email.** Agreed in the same session — the option is
removed from the marketing mail and handled on the community page instead
([the decision](../decisions/Decision%20-%20rinuncia%20moves%20from%20the%20marketing%20email%20to%20the%20community.md)).
The mail still has to link there.

**Two new rows out of it**:
[OI-126](OI-126%20An%20asset%20flag%20for%20incomplete%20participant%20data.md) — a
Salesforce flag marking tickets whose participant data is not filled in, so
Marketing Cloud can query it simply; and
[OI-127](OI-127%20What%20a%20total%20rinuncia%20does%20to%20orders%20and%20assets.md) —
what a total rinuncia does to the order and to the credit Elena Spini mentioned.

⚠ **Rebecca Marmo is owed a call for the third time.** Fabrizio Mastracci is to
contact her and the group is to schedule a session. She joined Parte 3 by phone
the same morning for two minutes and settled a consent question on the spot.

**Follow-up booked: `[PIENISSIMO] - Flussi MKT Parte 2`, Tuesday 8 September
14:30–15:30 CEST**, Aurel Mrruku and Fabrizio Mastracci, invited 09:02:42Z.

## 2026-09-08 - the tag vocabulary is complete, and the send timing has a home

[Flussi MKT Parte 2](../meetings/2026-09-08%20Flussi%20MKT%20Parte%202.md) ran
14:32 CEST for 42m21s. Elena Spini collected the client's funnel material into a
new Drive folder `02 Marketing` during the call.

### 🟢 The tag scheme has four members, not two

`SEGMENTI FUNNEL BIGLIETTI.docx` completes the vocabulary Parte 3 half-decoded.
Using `FMF_2026` as the worked example:

| Tag | Meaning |
| --- | ------- |
| `<EVENT>` | the **contatto principale holding at least one ticket** for the event |
| `<EVENT>_I` | the contact — principal or not — **once participant data is entered** on the ticket |
| `<EVENT>CP` | the **contatto principale** once *their own* participant data is entered |
| `<EVENT>_R` | the contact who **renounces** the event |

⚠ **Only `_R` is a Tag Associati value.** The other three are written by the CRM
into Automation's **contact properties** — so three of the four are integration
outputs, not tags a person sets, and the split matters for whoever builds the
Salesforce side.

### 🟢 The exit rule is written down

> _"un contatto avente 3 biglietti può decidere di partecipare anche solo con 1
> biglietto e in questo modo, una volta inseriti i dati, esce dal funnel e non
> riceve più comunicazioni."_

**Partial completion exits the funnel.** That is the operative criterion behind
[OI-126](OI-126%20An%20asset%20flag%20for%20incomplete%20participant%20data.md) and
it is stricter than a per-ticket flag: the segment turns on *iscrizioni
effettuate* against tickets held, not on any one ticket's state.

### 🟢 The 60-day question is answered by data, not by a flow

The window stays **30–60 days**, but the interval is no longer computed. Agreed:
put **`data evento`** and **`data invio`** directly on the invitation record, so
the Marketing Cloud flow fires on `data invio = today` and never queries the
Campaign. 🔴 Aurel Mrruku named the cost — **triggers to propagate a changed
Campaign date onto every invitation record**, unbuilt and unestimated.

⚠ **Reminders were deliberately parked.** Build to Rebecca Marmo's example flows
as given; raise the cadence question at a follow-up. Whether reminders also vary
per campaign is unanswered, and it is the same "ROMI choosing for the client"
pattern this row has carried since August.

🔴 **None of it can be tested end to end** —
[OI-134](OI-134%20The%20marketing%20flows%20cannot%20be%20tested%20before%20a%20production%20release.md).

⚠ **The plain-text style constraint was still not restated** to Fabrizio
Mastracci, for the second session running.
