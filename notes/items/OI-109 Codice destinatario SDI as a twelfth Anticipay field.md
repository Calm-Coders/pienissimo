---
id: OI-109
type: open-item
status: open
owner: Andrea Parmeggiani
with: Elisa Migliano
org: both
raised: 2026-09-01
updated: 2026-09-01
depends_on: [OI-94]
blocks: [OI-95]
requirement: INT-18
source: notes/meetings/2026-09-01 Follow-up Integrazione Anticipay.md
---

# OI-109 - Codice destinatario SDI as a twelfth Anticipay field

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
