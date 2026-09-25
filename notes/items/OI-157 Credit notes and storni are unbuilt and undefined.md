---
id: OI-157
type: open-item
status: open
owner: Aurel Mrruku
org: both
raised: 2026-09-18
updated: 2026-09-24
source: notes/meetings/2026-09-18 Interna Temi Mexal.md
---

# OI-157 - Credit notes and storni are unbuilt and undefined

Stated by Aurel Mrruku at
[the 18/09 internal](../meetings/2026-09-18%20Interna%20Temi%20Mexal.md):

> _"Note di credito, non ho manco iniziato a farle."_

and:

> _"Non mi è proprio chiaro come verrà gestita la nota di credito."_

So: **unstarted, and the mechanism is not understood.**

## How it was descoped

Elena Spini had seen credit notes and storni listed as a topic and treated them as
an edge case — _"è un caso limite, per l'amor di Dio"_ — and considered dropping
them from the UAT calendar. **The 6 October invitation went out titled only
`Integrazione Mexal ↔ Salesforce`.**

🔴 **So the topic left the plan without a decision.** Nobody told the client it was
out of scope, and nobody recorded it as deferred to Fase 2. It simply stopped
being on an agenda.

## What it was for

Aurel Mrruku's recollection ties it to **cancelling an asset**. Elena Spini's
earlier design for the adjacent problem — correcting an incasso booked against the
wrong tranche, via an amministrazione-only button on the Asset — **was abandoned in
the same conversation** (see the session note). Stated frequency for that case:
**20–30 times a year**.

## Open

- 🔴 **Decide explicitly whether credit notes are in Fase 1.** If they are not, the
  client should be told before the 13 October sign-off, not discover it after.
- 🔴 **If they are, nothing exists**: no object, no flow, no Mexal leg. The 6
  October Mexal UAT session is eleven days from now.
- ⚠ **The asset-cancellation path is the same gap**
  [OI-136](OI-136%20Public%20participant%20link%20can%20mark%20an%20order%20Incassato.md)
  keeps pointing at: a real administrative need to reverse a payment state, scoped
  twice and built never.

## 2026-09-24 — the Business Blueprint gives credit notes a shape, still unbuilt

`Business_Blueprint_Pienissimo.docx` (§2 deliverables and §6.5 edge cases) describes what
this note records as undefined
([OI-179](OI-179%20The%20Business%20Blueprint%20goes%20to%20the%20client%20with%20unchecked%20points.md)):

- A **"Crea Nota di Credito" button at Order level**, with point selection of the order
  lines and Assets to reverse.
- For a multi-event order, a **popup to pick the ticket/order line**, so the credit note
  and the Asset → `Annullato` transition apply only to that line, not the whole order.
  The client's administration flagged it as **not urgent but to be kept in the design**.
- Participant name change is handled separately, by a `caso limite` button on the Account:
  the existing Asset is cancelled and a **new Asset with a new QR code** is created, never
  updated in place, to preserve history.

⚠ **Both deliverable bullets carry the author's `● Check con Aurel` marker**, and nothing
is built. This note stays open; what it gains is a described design and a client-visible
commitment to it.
