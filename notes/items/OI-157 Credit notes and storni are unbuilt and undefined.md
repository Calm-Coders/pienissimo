---
id: OI-157
type: open-item
status: open
owner: Aurel Mrruku
org: both
raised: 2026-09-18
updated: 2026-09-28
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

## 🟢 2026-09-25 - explicitly moved to Fase 2, and the abandoned design is explained

This row recorded that the topic _"left the plan without a decision"_. 🟢 **It now
has one.** At
[the 17:00 internal session](../meetings/2026-09-25%20Interna%20post%20UAT%20Contratto%20e%20Fase%20Due.md)
Aurel Mrruku ruled on both halves as Elena Spini read them out of the Business
Blueprint:

- **Note di credito and storni** — _"Fase due. Mettila su fase due."_
- **Correzione di un pagamento** (an incasso booked against the wrong tranche, the
  case the BBP marks _"esplicitamente non risolto dalle fonti analizzate"_) — the
  same, Fase 2.

🔑 **And the reason Elena Spini's asset-level button was abandoned is now on the
record.** Aurel Mrruku: _"non è giusto perché non è a livello di asset, deve essere
le trance a livello di prodotto"_ and _"non è detto che le trance hanno solo i
biglietti, Elena."_ **Tranches sit at product level and may contain no tickets at
all**, so an Asset-rooted correction cannot reach them. Elena Spini explained she
had rooted it there because the client wanted the **asset status rolled back** as
part of the correction.

⚠ **The client has not been told.** Aurel Mrruku's stated ground for the move is
that they will accept it — _"fidati che sarà molto anche loro saranno felici"_ — and
he tied it to the credit-note button being _"semplicemente un button che qualcuno lo
preme là e doveva annullare asset"_. **Nothing records the client agreeing**, and
the Fase 2 perimeter is
[its own unresolved risk](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md) —
Elena Spini reports Fabrizio Paganelli _"non vuole spendere"_.

🔴 **So the topic has moved from "out of plan by accident" to "in Fase 2 by ROMI
decision, unconfirmed by the client."** That is an improvement in the record and not
yet an agreement.

## 🟢 2026-09-28 - the client confirmed Fase 2, and gave a reason nobody had

The sentence immediately above is now out of date. At
[the 28/09 session](../meetings/2026-09-28%20Tema%20Contratti%20e%20Open%20Point.md)
(`00:27:00`) Elena Spini put the deferral to Fabrizio Paganelli and he agreed in
his own words:

> _"rimandiamo sia al tema della nota di credito che questo qui alla fase due."_

🟢 **So it is now in Fase 2 by client agreement, not by ROMI decision alone.** Both
items were named: the **credit note** and the **wrong-payment correction** (an
administration mis-registration that has already flowed through to the ticket,
needing the asset state walked back and the invoice re-applied).

**His two reasons, both new to the record:**

1. **Volume.** _"la nota di credito ne facciamo poche, quindi fortunatamente …
   possiamo anche posticiparla e dare priorità ad altre cose."_
2. 🔑 **Mexal has no order behind a credit note**, which makes the whole flow
   different in kind from invoicing: _"mentre per le fatture abbiamo un ordine
   sottostante … per le note di credito su Mexal non passano gli ordini, quindi noi
   dovremmo fare la nota di credito a mano su Salesforce e la nota di credito a
   mano su Mexal."_ He contrasted it with a previous employer's returns-order type
   and called the gestionale _"un po' particolare"_ here.

⚠ **Point 2 is his recollection and he asked for it to be verified** —
_"questa cosa qui verifichiamola bene"_. 🔴 **Nobody was assigned the
verification.** It matters beyond Fase 2 scoping: if Mexal genuinely has no credit
note order type, then a credit note is dual manual entry forever, and that is a
design constraint rather than a build task.

🟢 **Fase 2 will be released incrementally.** Elena Spini proposed prioritising
within it — _"possiamo fare rilasci dedicati pezzettino per pezzettino"_ — and
Aurel Mrruku backed it: _"il problema è strutturare bene il data model e non
mettere cose a metà"_, because production bonifiche cost more than staged
delivery. He drew the contrast explicitly: **Fase 1 cannot be staged**, because all
the structures must exist for the Excel migration to map onto.

🔴 **Fabrizio Paganelli asked which months Fase 2 covers and did not get an
answer.** Elena Spini said the quotation is still to be done and undertook to send
the updated plan and a proposal **this week**. Still no dates, and the client is
now asking for them.
