---
id: OI-163
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-09-22
updated: 2026-09-22
depends_on: [OI-149]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-09-22 Update Interno Aurel Elena.md
---

# OI-163 - Lead conversion has no agreed duplicate rule

**Raised by the developers during testing on 22/09**, relayed by Aurel Mrruku at
[the internal update](../meetings/2026-09-22%20Update%20Interno%20Aurel%20Elena.md).
**Lead and Opportunity UAT is 24 September.**

Conversion creates **Account + Contact + Opportunity**. What happens when the
counterpart already exists is undefined.

| Case | Behaviour |
| ---- | --------- |
| Account already exists | the contact attaches to it — both agreed |
| **Contact exists, different `partita IVA`** | undecided |
| **Contact exists, different `ragione sociale`** | undecided |
| **Same P.IVA, two different ragioni sociali** | undecided |
| **Same ragione sociale, two different P.IVA** | undecided |

Aurel Mrruku: the same contact on two accounts _"non può essere. Non ha senso."_

## The working direction, not yet a decision

**Deduplicate on `partita IVA` alone**, not on the pair with `ragione sociale`:

- the P.IVA is also what drives the **Anticipay** call at first order, so two
  accounts with the same P.IVA must not exist;
- a typo is far likelier in the company name than in the VAT number — Elena Spini:
  _"è più facile sbagliare a scrivere qualcosa di diverso sulla ragione sociale che
  sulla partita IVA"_;
- ⚠ **the behaviour already happens this way**: the 21/09 Anticipay test attached to
  the pre-existing account carrying that P.IVA, and that was the reason.

## Why it is gating

- **Conversion uses custom trigger logic with deduplication**, not the standard
  component ([OI-149](OI-149%20Two%20Lead%20record%20types.md)), so there is no
  platform default to fall back on.
- Rejecting a Lead leaves it **stuck in its state** with no defined exit. Elena
  Spini's only concrete proposal was an error message; Aurel Mrruku's objection:
  _"rimarrai in quello stato."_
- Lead data quality is **deliberately unconstrained** — leads arrive from public
  forms. Aurel Mrruku: _"sulla qualità dei dati me ne frego."_
- The client has never been asked. Elena Spini's plan is to raise it **as a point of
  attention during UAT**; Aurel Mrruku's position is that the case will certainly
  occur, because a mistyped ragione sociale or P.IVA is routine.

## Open

- 🔴 **Rule the duplicate cases before 24 September**, or accept that UAT will hit
  them live.
- 🔴 **Define the failure path** for a Lead that cannot convert.
- ⚠ No register row covers Lead deduplication.
