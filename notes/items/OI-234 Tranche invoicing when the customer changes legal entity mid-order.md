---
id: OI-234
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-10-14
updated: 2026-10-14
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
