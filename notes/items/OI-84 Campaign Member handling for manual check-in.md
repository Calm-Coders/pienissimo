---
id: OI-84
type: open-item
status: in-progress
owner: ROMI
org: ROMI
raised: 2026-08-06
updated: 2026-08-24
depends_on: [OI-78]
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
---

# OI-84 - Campaign Member handling for manual check-in

When staff hand-key a substitute or a walk-up at the door, the person may never
be recorded as a **Campaign Member** with the ticket marked used.

That breaks attendance and no-show analytics — a stated goal of the whole
project, and the reason the campaign-per-event model exists at all. Every
manual entry is a hole in the statistic the CRM was bought to produce.

Elena Spini raised it. **Elisa Migliano waved it off** on the competence of the
infopoint staff. It was logged in session as "controllo check-in +
aggiornamento manuale Campaign Member" and left undesigned.

The disagreement is worth preserving: one side treats it as a data-integrity
gap needing a control, the other as a training matter. Both can be right — the
staff may well key it correctly every time, and there is still no mechanism
that shows whether they did.

Flows from the manual path in
[OI-78](OI-78%20Participant%20data%20collection.md), where the substitute
re-signs on paper and **no QR is issued** — so the QR scan, which is what
normally sets attendance, never fires.

## 2026-08-24 - membership is created at enrolment only

The [24 August Follow-up Interno](../meetings/2026-08-24%20Follow-up%20Interno.md) ruled on when a Campaign Member record
comes into existence: **only at enrolment**. The purchaser is explicitly **not**
added as a campaign member merely by buying tickets.

That matters because the buyer and the attendees are routinely different people —
a referente buys a block and then names the participants — and it means campaign
membership is a list of **attendees**, not of customers.

The [19 August session](../meetings/2026-08-19%20Flussi%20MKT%20Biglietti.md) supplies the trigger: on confirmation of the
participant list, new contacts are created if absent from the CRM (otherwise
matched), and the campaign member is added to the chosen event campaign. The QR
code then carries the **campaign member id**, which is what check-in scans.

So the chain is: participant list confirmed → contact matched or created →
campaign member created → QR issued carrying its id → scan at the event.
