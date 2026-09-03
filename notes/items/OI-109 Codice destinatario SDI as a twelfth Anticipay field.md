---
id: OI-109
type: open-item
status: resolved
owner: Elisa Migliano
with: Andrea Parmeggiani
org: both
raised: 2026-09-01
updated: 2026-09-03
depends_on: [OI-94]
requirement: INT-18
source: notes/meetings/2026-09-02 Follow-up Anagrafica Articoli.md
---

# OI-109 - Codice destinatario SDI as a twelfth Anticipay field

✅ **Resolved 2026-09-02 — withdrawn by the person who asked for it**, one day
later and in a different meeting. Nothing to build and nothing to chase; Andrea
Parmeggiani's action falls away. See [the withdrawal](#the-withdrawal-2026-09-02)
at the foot of this note.

**Raised by Elisa Migliano at the
[1 September call](../meetings/2026-09-01%20Follow-up%20Integrazione%20Anticipay.md).**
She asked whether the middleware can also return the **codice destinatario SDI**
— the Sistema di Interscambio routing code used for Italian electronic invoicing.

It is **not among the eleven fields** in
[the documented contract](../The%20Anticipay%20middleware%20API%20contract.md), so
this is a change request to Pienissimo Software, not a field-selection choice.

## Why she wants it, and why she said it is not urgent

Both halves matter, and the record should carry both:

- **Not critical.** Pienissimo sends electronic invoices **via PEC**, not via SDI
  code, so nothing breaks without it. `pec` is already in the payload and already
  decided onto the Account.
- **But valuable anyway.** Her reason was about Mexal, not Salesforce: _"noi
  adesso nell'anagrafica di Mexal abbiamo una valanga di clienti dove lo SDI non
  è valorizzato."_ A large part of the existing customer registry has an empty
  SDI field, and a lookup that fills it would repair data the migration will
  otherwise carry across empty.

That second reason is the interesting one. It makes this field **a data-quality
win on the as-is registry**, which is a different argument from anything else in
the Anticipay integration, and it lands squarely in the same territory as
[OI-98](OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md) and
the customer-registry mapping session.

## Status

**Andrea Parmeggiani holds the action** to check whether Anticipay exposes the
value, add it to the mapping if it does, and tell Aurel Mrruku either way.

⚠ **His first impression in the room was negative** — _"mi sembra da un'occhiata
veloce di non trovarlo. Dopo ci riguardo con più calma. Se lo trovo lo aggiungo e
ti avviso."_ So the likely outcome is that it is not available. Treat "no answer
yet" as leaning toward no rather than toward yes.

**No date was set.** Aurel Mrruku costed his own side at _"un 5 minuti di
mappatura"_ plus creating the field, so if the answer is yes this is small work;
if it is no, the item closes with nothing to build.

## Do not let it hold anything up

This must not become a reason to delay the eleven fields already decided.
[OI-95](OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md) is
resolved and buildable as it stands; a twelfth field, if it arrives, is an
additive change to a mapping that will already exist. With Fase 1 development
ending **10 September**, build the eleven and add the twelfth if and when Andrea
Parmeggiani confirms it.

## The withdrawal, 2026-09-02

At the
[2 September Anagrafica Articoli session](../meetings/2026-09-02%20Follow-up%20Anagrafica%20Articoli.md),
reading the Mexal customer screen aloud, **Elisa Migliano dropped it herself**:

> _"potevamo portarci dentro il codice destinatario SDI nel caso delle cose
> italiane, ma non lo andiamo a recuperare mi sa dalla da anticipay, comunque
> **non ci serve**."_

Nobody prompted her; it came up while listing the fields the integration must
carry, and she moved straight past it. So the item closes as **not wanted**,
rather than as _not available_ — which is the outcome Andrea Parmeggiani's first
impression was pointing at anyway.

## ⚠ What the withdrawal did not address

Her 1 September argument for the field was **not** about Salesforce needing it.
It was a repair argument about Mexal:

> _"noi adesso nell'anagrafica di Mexal abbiamo una valanga di clienti dove lo
> SDI non è valorizzato."_

**That reason was never re-examined.** On 2 September she is looking at the
integration contract, where the field genuinely is not needed because invoicing
runs on PEC; the empty SDI values in the existing registry are still empty, and
the migration will still carry them across empty.

That is not a reason to reopen this item — the client has said what it wants —
but it is a live data-quality fact for
[the migration mapping](OI-79%20Migration%20volumes%20and%20mapping%20method.md)
and for the registry re-creation
([OI-98](OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md)).
**Record it there, do not chase it here.**

## ⚠ 2026-09-03 - the field is back, from a different source

This item was closed on 2 September because Elisa Migliano withdrew the request —
_"comunque non ci serve"_. That withdrawal stands and **this item stays
resolved**, because it was about getting the SDI **from Anticipay**.

But at [Data Model Parte 1](../meetings/2026-09-03%20Data%20Model%20Parte%201.md)
the next day, **Fabrizio Paganelli asked to keep the SDI field and to have the
Mexal integration populate it**:

> _"di far sì che nell'integrazione anticipay porti anche lo sd. Non si sa mai che
> un domani possa cambiare qualcosa nella normativa e se dopo non ce l'abbiamo
> alimentato e non abbiamo il campo... Se non serve lo lasci vuoto. Se serve
> almeno ce l'abbiamo."_

The field is present in the client's workbook under the MEXAL section, and Andrea
Di Cicco left the session owing _"Includere il campo Codice Destinatario
nell'integrazione tra Salesforce e Mexal"_.

⚠ **Two people asked for the same field within 24 hours, for opposite reasons,
and neither knew about the other.** Elisa Migliano dropped it as unnecessary;
Fabrizio Paganelli kept it as insurance against a regulatory change. Both are
recorded. **Nobody has reconciled them, and the transcript is ambiguous about
which integration he means** — he says _"integrazione anticipay"_ while the action
list and the field's placement both say Mexal.

**Worth one sentence at Parte 2**: is the SDI fed from Mexal, from Anticipay, or
by hand? Do not treat the build as decided.
