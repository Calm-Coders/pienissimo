---
id: OI-115
type: open-item
status: open
owner: Elisa Migliano
with: Elena Spini
org: both
raised: 2026-09-03
updated: 2026-09-03
depends_on: [OI-59]
requirement: SAL-16
source: notes/meetings/2026-09-03 Data Model Parte 1.md
---

# OI-115 - Tipologia Attivita values and its move to the quote

**`Tipologia Attività` leaves the customer registry and becomes a field on the
Preventivo.** Agreed at
[Data Model Parte 1](../meetings/2026-09-03%20Data%20Model%20Parte%201.md), and
written into the client's own workbook the same hour — the Preventivo sheet now
carries the line `Tipologia Attività — Picklist non restrittiva >> PIENISSIMO TO
DO: Inserire i valori esistenti`
([OI-24](OI-24%20Data%20model%20workbook.md)).

Two things were decided and one is owed.

**Decided.** It moves from Account to Quote, and it is a **non-restrictive**
picklist — users may type a value that is not in the list.

**Owed.** Elisa Migliano is to extract and send the existing values from Zoho.

## Why the move is more than a relocation

The field describes the **kind of business being sold to**, and putting it on the
quote rather than the account means it is captured **per deal, not per customer**.
That is a deliberate choice — a customer can be sold to in different capacities —
but it also means the account no longer carries the classification at all, so any
report or segmentation that assumed it lived there has to reach through the
quotes.

⚠ **A non-restrictive picklist is a decision to accept dirty data.** It is the
right call for a migration where the value set is unknown, and the wrong one to
leave in place afterwards. Nothing in the session said when it should be
tightened — worth a line in the Parte 2 or Parte 3 wrap-up.

⚠ It also lands on the Quote object while
[OI-59](OI-59%20Quote%20workflow%20configuration.md) is still reconciling that
object's own state machine and layout, and while the new
[quote acceptance page](../objects/The%20Landing%20Page%20community.md) reads
Quote fields directly. **Whoever adds the field should check the acceptance page
still renders.**

**No date was set for the values.**
