---
id: OI-249
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-15
updated: 2026-10-15
depends_on: [OI-247]
source: notes/meetings/2026-10-15 Migrazione e Go-Live.md
---

# OI-249 - An agent reassignment reaches Mexal only at the next order

**Changing a customer's agent in Salesforce does not propagate to Mexal
immediately, and not overnight either — only when that customer's next order is
sent. There is a `crea cliente Mexal` action and no update action. Established
on the record, and the use case that breaks it was put in the same exchange.**

Established at [the 15/10 session](../meetings/2026-10-15%20Migrazione%20e%20Go-Live.md)
(`01:00`–`01:05`).

## The behaviour, as stated

Fabrizio Paganelli asked the question directly — if Marco Montesi changes the
agent on a customer in Salesforce, when does Mexal see it?

Aurel Mrruku: _"né immediatamente né alla notte, al successivo ordine, quindi
quando si farà l'ordine successivo si può fare l'aggiornamento."_

And on the missing action: _"se vi serve, vi possiamo già creare il puls[ante],
come questo, crea cliente Mexal. Qua io gli ho detto crea cliente Mexal, solo
che … non ho previsto un tasto di aggiorna su Mexal."_

The rest of the model was confirmed and is not in dispute:

- The agent **on an order** is frozen at order creation — Fabrizio Paganelli:
  _"la gente che c'è sull'ordine, una volta che l'ordine è stato fatto, deve
  rimanere quello e lì non ci piove."_
- A new order created after the change does carry the new agent's code, read from
  the User — _"nel momento in cui ha creato l'ordine con l'agente aggiornato, già
  l'ordine avrà il codice aggiornato di quell'agente."_
- Mexal's own side has a counterpart: Fabrizio Paganelli describes a Mirko
  Merendi procedure that reads the agent on the incoming order and updates the
  Mexal customer record if it differs. ⚠ Recorded as his description; no source
  in this repository documents that procedure.
- The reverse direction works nightly: Mexal-owned fields flow back into
  Salesforce on the nightly job, so a `categoria statistica` set in Mexal appears
  in Salesforce the next morning. Only a defined subset flows Salesforce → Mexal
  (shipping address, name, surname, VAT number and one other), and _"i campi
  commerciali … non triggerano un aggiornamento"_.

## 🔴 Why the gap matters

The case was put by Fabrizio Paganelli in the same breath, and it is not an edge
case — it is the commercial lead's routine work:

> _"può succedere che io che sono responsabile commerciale decido di cambiare le
> assegnazioni del gruppo dei clienti. Io posso prendere 100 clienti di Fabrizio
> e darli ad Elena, prendere 150 di clienti di Elena e darli ad Aurel."_

After a bulk reassignment of that kind, Mexal keeps the old agent on every one of
those customers until each places an order. For customers who do not order, it
never updates. 🔴 **Commission attribution, zone reporting and the `categoria
provvigione` all sit on the Mexal side**, so for an unknown period the two
systems disagree about who owns the customer — and Fabrizio Paganelli's stated
requirement for the whole exchange was _"una delle cose fondamentali è che le due
[ana]grafiche siano perfettamente allineate"_.

⚠ **It is also a decision nobody took.** Aurel Mrruku offered the button; nobody
said yes, and the session moved on. The offer is on the record and unanswered,
which is the same shape as several other asks this month.

⚠ **The right scope may be the bulk operation rather than the button.** A
per-record "update Mexal customer" action does not help someone reassigning 250
customers, which is the use case given. Nothing in the session addressed volume.

Closing it means a ruling: accept the lag and say so, or build the update path —
and if built, whether it is per record, on save, or a batch, and who may run it.
