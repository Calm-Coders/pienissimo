---
id: OI-245
type: open-item
status: open
owner: Mirko Merendi
with: Aurel Mrruku
org: external
raised: 2026-10-15
updated: 2026-10-15
blocks: [OI-244]
severity: gating
source: notes/meetings/2026-10-15 Migrazione e Go-Live.md
---

# OI-245 - Whether a Mexal order survives invoicing is disputed

**Aurel Mrruku says an invoiced order is deleted in Mexal and becomes an invoice.
Fabrizio Paganelli says the order archive persists and only the front-end view
loses it. The entire migration method agreed in the same session depends on
which is true, and the session ended without resolving it.**

Raised at [the 15/10 session](../meetings/2026-10-15%20Migrazione%20e%20Go-Live.md)
(`00:30`).

## The two accounts

**Aurel Mrruku**, reporting what Mirko Merendi told him, and reporting it as
something he had already tested:

> _"non mi risulta perché Mirko ha detto esplicitamente che se un ordine viene
> fatturato … quell'ordine sparisce e tutto il dato diventa fattura."_

> _"dopo che tu hai fatturato l'ordine che avevo creato da Sales Force, ho
> chiesto a Mirko come mai non lo ricevo più tramite l'[A]PI lo stesso ordine e
> lui mi ha detto perché questo ordine è stato rasato via perché è diventato una
> fattura e nella fattura c'è la referenza dell'ordine."_

🔑 **That is an observed symptom, not just a claim**: an order he created from
Salesforce stopped coming back through the API after it was invoiced, and the
explanation came from the integrator.

**Fabrizio Paganelli**, who uses Mexal daily:

> _"Non è così, nel senso che … è così a livello di utente … quell'ordine mi
> diventa fattura e mi sparisce dalla schermata di degli ordini. Però i dati
> dentro ci sono tutti. Non è visibile dall'utente, ma dentro io ho l'archivio
> degli ordini e l'archivio delle fatture."_

> _"ho un archivio dove ho data fattura, numero fattura e nello stesso record
> data ordine, numero ordine … volendo io un'estrapolazione di tutti gli ordini
> che sono stati fatturati, te la posso fare."_

He also offered to show it on screen there and then.

## Why it blocks rather than being a curiosity

The migration method adopted in the same session
([OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md))
is: Fabrizio Paganelli extracts the historical **orders** from Mexal into a
spreadsheet. If Aurel Mrruku and Mirko Merendi are right about the data model,
there is no order archive to extract in the form being promised — only invoices
carrying an order reference. The migration would then be reconstructing orders
from invoices, which is a different job with different fidelity, and the ~51,000
order-line figure Fabrizio Paganelli quoted would be coming from somewhere other
than where he thinks.

⚠ **Both accounts can also be true at once**, and that is the likeliest reading:
the order may be absent from the **API surface** Aurel Mrruku queries while
present in the **database archive** Fabrizio Paganelli reports from. Nobody said
this in the room, and it is a hypothesis here, not a finding. If it holds, the
migration works and the API behaviour is a separate, smaller fact.

## The resolution that was proposed and not scheduled

Aurel Mrruku: _"Se vuoi facciamo un altro giro con Mirko."_ No date, no owner
beyond that sentence, and the session moved straight to field lists.

🔴 **This is the fourth ask now pointing at Mirko Merendi about the Mexal
tracciato, from three different people, uncoordinated**:
[OI-145](OI-145%20Order%20header%20discounts%20are%20removed.md) (list price,
discount and net onto the order — Fabrizio Paganelli undertook to contact him on
13/10, unrecorded since),
[OI-236](OI-236%20The%20Mexal%20order%20carries%20no%20tipo%20merce%20and%20no%20provvigioni%20percentage.md),
[OI-237](OI-237%20Mexal%20invoices%20cite%20the%20preventivo%20instead%20of%20the%20order%20number.md),
and now this. 🔴 **No Kreosoft mail has appeared in any sweep for five
consecutive runs and Mirko Merendi appears in no source**, while the asks
accumulate.

Closing it means one answer, from Mirko Merendi, in writing: after an order is
invoiced, what remains queryable, through the API and in the archive, and with
which keys.
