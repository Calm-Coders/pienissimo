---
id: OI-84
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-08-06
updated: 2026-08-14
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
