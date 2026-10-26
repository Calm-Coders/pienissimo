---
id: MTG-2026-10-06-form-link-partecipanti
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-10-06
updated: 2026-10-06
depends_on: [OI-75, OI-196, OI-199, OI-200, OI-203, OI-207, OI-209]
source: Drive 111bChRGKcZDEShys3gjPHTFcvhzShkTjqb8InanRUns (Gemini notes)
---

# 2026-10-06 Form Link per partecipanti

**Client session, 10:02 CEST, ~1h30m.** Elena Spini · Aurel Mrruku ·
**Fabrizio Paganelli · Sabatino Rinaldi · Elisa Migliano** · **Rebecca Marmo**.

🔑 **This is the consultation the link change was deferred to**, on grounds of
fatigue, at the end of
[the Lead session](2026-10-05%20Check%20Data%20Import%20Lead%20e%20Contact.md) the
previous evening. It is also the first session to take up the paragraph the
client rejected on 02/10
([OI-203](../items/OI-203%20The%20client%20contested%20the%20agreed%20ticket%20logics%20before%20confirming%20them.md)).

⚠ **Rebecca Marmo is not on the calendar invitation** (invitees were Fabrizio
Paganelli, `amministrazione@`, Sabatino Rinaldi, Elena Spini, Aurel Mrruku) but
speaks throughout the second half of the notes. Recorded as present on the
strength of the notes, not the invitation.

## Concordato — six rulings

- 🔑 **Nomination links are generated per edition, not per order.** _"Viene
  adottata la logica di generare un link di nomina separato per ciascuna
  edizione inclusa in un ordine anziché un link unico per ordine."_ Elena Spini
  presented it; nobody dissented. **This closes the contested point 1** —
  see [OI-203](../items/OI-203%20The%20client%20contested%20the%20agreed%20ticket%20logics%20before%20confirming%20them.md).
- 🔑 **Mexal-managed registry fields are locked in the Salesforce UI, and a
  nightly sync brings Mexal's changes back through a dedicated user that
  bypasses the lock.** Commercial fields stay editable in Salesforce. Registry
  corrections are made **in Mexal**, not Salesforce. This answers the design
  question [OI-209](../items/OI-209%20Mexal%20anagrafica%20updates%20only%20propagate%20when%20an%20order%20is%20sent.md)
  deferred to Mirko Merendi — and it is `F-2` of the client's own workbook.
- **Marketing links unlock and send only against assets paid in full to saldo**,
  and only on the configured send date. Elisa Migliano, Elena Spini and Aurel
  Mrruku: the **whole reference tranche** must be settled, not the order
  ([OI-75](../items/OI-75%20Ticket%20availability%20rule.md)).
- **Telephone uniqueness controls stay at database level** — the same number
  cannot be entered for two participants **within the same edition**. Raised by
  Rebecca Marmo, confirmed by Aurel Mrruku.
- 🔴 **Follow-up flows for partial nominations are dropped for go-live.** The
  existing configuration stands; the flows are given up _"temporaneamente… in
  vista del go-live"_ ([OI-196](../items/OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md)).
- **Changing a ticket's nominativo is deferred to Fase 2.** Release proceeds
  without it. Exceptions are handled by the system administrator editing the
  referente directly in Salesforce.

## Da approfondire — one

- **Follow-up criteria and the text of the follow-up emails.** Deferred to a
  written proposal from Fabrizio Paganelli and, if needed, a dedicated meeting.

## 🔑 Go-live is stated in the room as two weeks away

The reason given for deferring every structural change: _"la scadenza del
go-live fissata a 2 settimane."_ Sabatino Rinaldi proposed dynamic follow-ups
and per-ticket deletion or renunciation; **Elena Spini and Elisa Migliano
declined on time grounds** and Sabatino Rinaldi and Rebecca Marmo accepted the
deferral. Two weeks from 06/10 is consistent with the 21/10 Fase 1 date in
[OI-124](../items/OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md).

## Rulings on the Rinuncia button

- After a **partial** save — two nominativi of three — the **Rinuncia button
  disappears** from the interface and the filled tickets go to `Assegnato`.
  Demonstrated live by Aurel Mrruku.
- **Rinuncia applies to the whole block, not to single tickets.** Elena Spini
  stated it; per-ticket renunciation is part of what went to Fase 2.
- **No automatic email on a full renunciation.** Aurel Mrruku confirmed none is
  planned; Elisa Migliano suggested Fase 2.
- 🔑 **The direct Rinuncia button is removed from the email.** Rebecca Marmo,
  Elena Spini and Elisa Migliano agreed to remove or redefine it so the
  participant is sent to the web page, where both nomination and renunciation
  are handled. ⚠ See
  [the send contract](../The%20marketing%20ticket%20send%20logics%20as%20written%20by%20Marketing.md)
  for the field this leaves unaccounted for.

## Other points of record

- **Edition-move exception.** Where a customer asks to move purchased tickets
  from one edition to another (2026 → 2027), Elisa Migliano, Sabatino Rinaldi
  and Aurel Mrruku agreed to handle it by **changing the academic year, or
  creating a zero-value offer tied to an internal control file**. ⚠ No build and
  no owner; recorded as a ruling, not as a mechanism.
- **QR check-in has a window.** The scanning application calls Salesforce to
  set the asset to `utilizzato` **within a predefined interval of 5 days from
  the event date**. ⚠ First time this project has recorded the window; the
  5-day figure is Aurel Mrruku's in the notes, with no configuration named.
- **Asset-state reporting** reviewed by Fabrizio Paganelli and Aurel Mrruku:
  `in attesa` (unpaid), `disponibili` (paid, not yet nominated), `inviati`,
  `assegnati`.
- **Ticket state stays `Assegnato` regardless of download.** Aurel Mrruku:
  Salesforce does not track whether the recipient opened or downloaded the PDF.
- **Rebecca Marmo asked for send tracking across both channels** — email and
  WhatsApp are both used to deliver tickets, and detailed marketing tracking
  needs dedicated checks.
- **Layout.** Aurel Mrruku took the action to add the ticket-sent field and its
  date to the layout, **in Italian** — the surface side of
  [OI-199](../items/OI-199%20The%20ticket%20send%20flag%20fields%20are%20split%20across%20Asset%20and%20Order.md).
- The QR code stays unchanged when the data associated with the product changes.
- Quote acceptance runs through Salesforce and DocuSign; participant collection
  runs through the marketing funnels. Different paths, stated explicitly.

## Passaggi successivi — eleven

| Owner | Action |
| --- | --- |
| Fabrizio Paganelli | Map the fields that stay editable from the Salesforce interface for the Mexal integration |
| Il gruppo | Create the utenze needed for the integration between the systems |
| Fabrizio Paganelli | Mail the reminder logic and the handling of the Rinuncia button in the communications |
| Il gruppo | Review the text and content of the participant nomination mail, for the accept and renounce buttons |
| Fabrizio (Paganelli) | Mail a recap of every point discussed on flows and operational logic |
| Aurel Mrruku | Add the ticket send date and send status fields to the Salesforce layout |
| Elena Spini | Produce a detailed release plan for the remaining functionality, after the current tests |
| Il gruppo | Finalise the definitive follow-up and renunciation logics |
| Elena Spini | Re-send the documentation |
| Fabrizio (Paganelli) | Write up the doubts on the reminders section |
| Il gruppo | Schedule a dedicated call with Rebecca Marmo and the marketing team once the clarifications arrive |

🟢 **Elena Spini's re-send happened the same day**, 12:47:00Z — see
[OI-200](../items/OI-200%20The%20client%20was%20asked%20to%20confirm%20logics%20whose%20open%20points%20were%20removed.md).

## Not read

The **524 MB recording** (`1DhM2LFoRGeawo8IK8LICsvW4_IdEqxb3`) was not opened.
The verbatim transcript inside the notes document was not read beyond the
structured sections; the `Dettagli` entries are timestamp-linked to it.
