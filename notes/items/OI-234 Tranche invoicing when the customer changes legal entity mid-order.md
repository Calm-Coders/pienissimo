---
id: OI-234
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-10-14
updated: 2026-10-15
depends_on: [OI-118]
source: Gmail thread 1a139e24969cbc8a
---

# OI-234 - Tranche invoicing when the customer changes legal entity mid-order

**Fabrizio Paganelli raised a case the build has no answer for: a tranche order
is opened on company A, some tranches are invoiced to A, and then during the year
the customer notifies a change of ragione sociale, so the remaining tranches must
be invoiced to company B.**

## As he put it

Mail of **2026-10-14 10:08:12Z**, to Elena Spini and Aurel Mrruku, cc
`amministrazione@pienissimo.com`, subject _"Cambi di Ragione Sociale"_:

> _"Come memo per le prossime call, dovremmo parlare di questa casistica …
> Abbiamo ordine a tranche sulla ragione sociale A · Abbiamo già fatturato alcune
> tranche sulla ragione sociale A · in corso d'anno il cliente ci comunica cambio
> di ragione sociale · Quindi dobbiamo fatturare le tranche successive sulla
> ragione sociale B. In questi casi come è meglio fare?"_

He flagged it as particularly likely on **Performance Plus** orders but not
limited to them, and offered to explain further on a call.

## The answer so far

Elena Spini replied at **13:48:59Z**:

> _"Per questo tema propongo di accorparlo con i casi limite da gestire in fase 2.
> Ne parliamo comunque al meeting di domani."_

So ROMI's proposal is **Fase 2**, with a discussion at the 15/10 Migrazione e
Go-Live meeting, whose theme list includes _"Gestione casi cambi di ragione
sociale per fatturazione tranche"_. 🔴 **The client has not accepted the Fase 2
proposal in any source.**

## Why it is its own row and not part of OI-118

[OI-118](OI-118%20Ragione%20sociale%20continuity%20on%20the%20customer%20registry.md)
is about the **registry** following a name change so statistics stay continuous —
an `Azienda Precedente` self-lookup and History Tracking, agreed and unbuilt.
This is about **billing a part-invoiced order to a different legal entity**:
the order, its tranches and the invoices already issued are on the old entity,
and nothing in the record says whether that is a new order, a reassignment of the
remaining tranches, or a Mexal-side operation. The two share a cause and have
different answers.

⚠ **It also touches a case the record has not considered**: a company whose name
changes may also change fiscal residence — the San Marino/Italy split of
[OI-215](OI-215%20Anticipay%20does%20not%20cover%20San%20Marino%20addresses.md) — and
the Mexal customer code is locked once set
([OI-117](OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)).

## What closing it looks like

A ruling on whether this is Fase 1 or Fase 2, accepted by the client, and if
Fase 1 a written procedure for the already-invoiced tranches.

## 🟢 2026-10-15 - the client accepted Fase 2, in the room and in the thread

The acceptance this row was waiting on arrived twice on 15 October.

**In the mail thread** (`Cambi di Ragione Sociale`, Gmail `1a139e24969cbc8a`),
Elena Spini had proposed on 14/10 at 13:48:59Z: _"Per questo tema propongo di
accorparlo con i casi limite da gestire in fase 2. Ne parliamo comunque al
meeting di domani."_

**In [the 15/10 session](../meetings/2026-10-15%20Migrazione%20e%20Go-Live.md)**
(`00:45`) she put it directly and he accepted:

> Elena Spini: _"per quel punto gestione cambi di ragione sociale per la
> fatturazione della tranche … Se sei d'accordo, lo mettiamo a perimetro della
> fase due, di quei famosi casi limite che dobbiamo gestire."_
>
> Fabrizio Paganelli: _"Va bene, va bene."_

The theme was one of the four on the meeting invitation, so it was reached
deliberately rather than in passing.

🔑 **So the row's open question — whether the client accepts the deferral — is
answered yes.** It moves from _"Elena Spini proposes Fase 2, the client has not
accepted"_ to a deferral agreed by both sides.

⚠ **Two things keep it from being a clean close.**

1. **Elena Spini undercut the agreement herself, seconds later**: _"Anche
   Fabrizio è mi dice va bene a tutto quello che gli dico. Anche lui stanco."_
   Recorded because it is her own assessment of the weight of the consent she had
   just obtained, not as a finding about Fabrizio Paganelli.
2. **Fase 2 still has no estimate, no offer and no plan** —
   [OI-83](OI-83%20No%20phase%202%20estimate.md) and
   [the dispute](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md).
   🟢 That did change tonight: the 17:35:47Z mail commits in writing to _"un'offerta
   e un piano di progetto dedicati in un thread separato"_ for Fase 2 — the first
   such commitment on record. Until it arrives, "agreed into Fase 2" means agreed
   into a phase with no content.

🔴 **And the business case is unchanged.** Tranches part-invoiced to company A
still have to continue on company B at some point, whichever phase owns it; the
scenario Fabrizio Paganelli described is a real one for Performance Plus orders,
and deferring it does not make the first such order easier to invoice.
