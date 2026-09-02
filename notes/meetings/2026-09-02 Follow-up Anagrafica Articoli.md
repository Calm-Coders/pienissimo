---
id: MTG-2026-09-02-anagrafica
type: meeting
status: open
owner: Elena Spini
org: both
raised: 2026-09-02
updated: 2026-09-02
source: Gmail - "Notes: '[ROMI-PIENISSIMO] - Follow-up Anagrafica Articoli' 2 Sept 2026", gemini-notes@google.com, 2026-09-02T09:21:42Z
---

# 2026-09-02 Follow-up Anagrafica Articoli

**Client-facing session, 2 September 2026, 10:00-11:30 CEST.** Booked by Elena
Spini on 26 August _"per discutere i punti aperti dell'anagrafica articoli"_.
Invited: Aurel Mrruku, Andrea Di Cicco, Fabrizio Paganelli and
`amministrazione@pienissimo.com` (Elisa Migliano).

🔴 **This note is written from the Gemini notes alone.** They were auto-generated
at 11:19 CEST and are a summary, not a record of what was said. **No transcript
and no recording have been read**, and the Gemini summary itself carries the
standard _"may contain errors"_ warning. Everything below is therefore an
**action list, not a minute** - treat every line as a lead to confirm, and run
the full [drill-meeting](../../.agents/skills/drill-meeting/SKILL.md) pipeline
against the transcript when it is available.

## What the summary says was covered

Three themes, in the summary's own words:

- **Gestione anagrafica e bundle** - _"Definizione della gestione manuale dei
  codici articolo su Salesforce e configurazione dello staging per i bundle."_
- **Integrazione ordini e fatturazione** - _"Approvazione della mappatura per la
  residenza fiscale e impostazione delle causali per gli ordini di servizi e
  libri."_
- Field-by-field mapping of the customer registry between Zoho and Salesforce.

🟢 **The manual management of article codes on Salesforce was defined**, which is
the decision the [bundle-only codes](../The%20Anagrafica%20Articoli%20workbook.md)
needed. ⚠ The summary does not say **what** was defined, only that it was.

🟢 **The fiscal-residence mapping was approved** -
[OI-97](../items/OI-97%20Fiscal%20residence%20on%20the%20customer%20registry.md).
⚠ Which of the five values map where is not in the summary.

## Actions, as Gemini recorded them

| Owner           | Action                                                                                                                      |
| --------------- | --------------------------------------------------------------------------------------------------------------------------- |
| Aurel Mrruku    | **`Tipo Biglietto` field on Salesforce, editable exclusively by system administrators**                                     |
| Aurel Mrruku    | **`Stato Bundle` field** for the "in lavorazione" state, plus **logic to change state on completed confirmation**           |
| Elisa Migliano  | Put every relevant Zoho field into the shared interface/mapping file, and confirm completion to the technical team          |
| Elisa Migliano  | Insert the agreed fields into the **data model file**, and publish it **immediately after the call**                        |
| Andrea Di Cicco | Configure the customer fields needed for invoicing in the interface, and run a test that they populate correctly            |
| Andrea Di Cicco | Add the discussed fields to the **JSON file** and send a test                                                               |
| Elena Spini     | Send calendar invitations for follow-up sessions **tomorrow, Friday and Monday**                                            |
| The group       | Schedule periodic mapping meetings for Zoho -> Salesforce, and decide for each registry field whether and how it is handled |

## What these actions settle and disturb

🟢 **`Tipo Biglietto` is confirmed as a Salesforce field restricted to
administrators**, which is exactly the shape
[OI-76](../items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md) recorded
on 24 August - _"a manually maintained Salesforce field owned by
amministrazione"_. It is now an **assigned build action on Aurel Mrruku**, and
the workbook supplies its first three values (`Executive`, `Diamond`, `Gold`).
⚠ The summary does not say whether it is a picklist or free text.

🔴 **`Stato Bundle` is new and is not in the record anywhere.** A bundle state
of _"in lavorazione"_ with a transition on confirmation is a state machine
nobody has specified, on an object whose composition rules are still open
([OI-13](../items/OI-13%20Bundle%20effort%20estimate%20and%20client%20demo.md),
[the spread variance](../items/OI-43%20Spread%20variance%20does%20not%20block%20saving.md)).
**It needs a tracker row of its own** and does not have one - see the caveat
below.

⚠ **Three of the eight actions produce files** - the mapping file, the data model
file and the JSON. Elisa Migliano's data model was to be published _"immediately
after the call"_. **None has been checked for.** A sweep for them is the obvious
next step and was not run here.

⚠ **"Tomorrow, Friday and Monday"** means **3, 4 and 7 September** follow-up
sessions. Only the 7 September ROMI-internal MKT session is currently in
[the calendar block of MAP.md](../../MAP.md). If Elena Spini sent those
invitations, three client-facing sessions are unrecorded.

## What is missing from this record

- **The "paio di domande"** Fabrizio Paganelli flagged in his 1 September mail
  were to be answered _"anche in base ad un vostro parere"_. The Gemini summary
  does not contain them, and they are not in the workbook. **What he asked, and
  what ROMI answered, is unknown.**
- **Nothing here mentions the event-name mismatches or the code collisions** that
  [the workbook decode](../The%20Anagrafica%20Articoli%20workbook.md) found. They
  were found after the meeting, so they were almost certainly not raised.
- No new tracker rows were minted from this meeting. `Stato Bundle` and the
  follow-up sessions need them; **ids are not invented outside the full drill**,
  per [the write protocol](../Retrieval%20and%20write%20protocol.md).
