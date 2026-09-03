---
id: OI-110
type: open-item
status: open
owner: Andrea Di Cicco
with: Elisa Migliano
org: both
raised: 2026-09-02
updated: 2026-09-03
depends_on: [OI-58]
requirement: INT-01
source: notes/meetings/2026-09-02 Follow-up Anagrafica Articoli.md
---

# OI-110 - Agent and network fields are missing from the Mexal order call

**Pienissimo needs three commission fields on the order header, and the Mexal
call ROMI is building against does not appear to carry them.**

Found live at the
[2 September session](../meetings/2026-09-02%20Follow-up%20Anagrafica%20Articoli.md).
Elisa Migliano, reading her own order screen:

> _"a livello di ordine io ho bisogno che passi anche l'informazione del codice
> agente, zona, classificatore rete."_

Andrea Di Cicco looked for them in the field set his integration works from and
did not find them:

> _"quella di creazione dell'ordine è quella un po' più complicata perché questa
> chiamata per leggere i dati su Mexal ti dà un set di campi, poi se vuoi il
> dettaglio devi fare un'ulteriore chiamata. Quindi qui non li vedo, a meno che
> non abbia un nome tecnico un po' strano."_

## Why it matters

The three fields are how commission is calculated. **The tutors are the sales
network**: all of them have CRM access, some are employees on payroll, and **two
work under an agency contract and are paid commission** on what they sell. Every
customer already carries a `codice agente`; the same identification has to travel
on the order for the commission run to attribute it.

So this is not a nice-to-have field: without it an order reaches Mexal
unattributed, and the commission calculation either fails or has to be repaired
by hand.

## What is actually unknown

Two different things, and they need separating before anyone asks Kreosoft:

1. **Whether the fields exist on the Mexal order header at all** under a
   different technical name. Andrea Di Cicco raised that possibility himself.
2. **Whether they are reachable on the create call** rather than only on the
   per-document detail call. The Mexal order API is already known to be
   **two-step, N+1** for invoices
   ([the integration](../flows/The%20Mexal%20integration.md)); the same shape on
   orders would explain the absence.

⚠ This is the same failure mode as
[OI-97](OI-97%20Fiscal%20residence%20on%20the%20customer%20registry.md): a field
Pienissimo treats as obvious that is not in the documentation ROMI works from.
Treat the Mexal WEBAPI documentation as a partial description of the contract and
**ask Mirko Merendi at Kreosoft**, who answered eight such questions on
11 August in one pass.

## Where it sits

Andrea Di Cicco left the call owing a **JSON update plus a test send** covering
every field agreed in the session. This one cannot be closed by that update
alone - it needs an answer from Mexal's side first. **No date was set.**

## 🟢 2026-09-03 - half answered, and from the other direction

[Data Model Parte 1](../meetings/2026-09-03%20Data%20Model%20Parte%201.md) settled
where the three values come from, and it is not Mexal.

**`Classificatore rete`, `Codice agente` and `Zona` are inherited from the
Salesforce user — the tutor — assigned to the account.** Fabrizio Paganelli
demonstrated the existing behaviour on screen: change the account's owner and the
agent code, zone and network data follow automatically. They are properties of
the user record, not data to be read back from Mexal.

**On the order they freeze.** Fabrizio Paganelli:

> _"Se io sono un tutor e oggi ho generato un ordine, su quell'ordine le
> provvigioni le devo prendere io come tutor."_

Aurel Mrruku's restatement, confirmed in the room: _"tu puoi cambiare l'agente a
livello di account, ma a livello di ordine deve rimanere quello precedente."_

**And Mexal reconciles the mismatch by itself.** On receiving an order whose agent
differs from its own customer registry, Mexal **updates its registry** and returns
the new pairing overnight on the flow that is now
[OI-116](OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md).
Salesforce notifies nothing — Aurel Mrruku asked explicitly whether a button or a
notification was needed and the answer was no.

### What this changes

The item's framing — _"the Mexal call ROMI is building against does not appear to
carry them"_ — was looking in the wrong place for the **source**. That half is
answered: the values originate on the ROMI side.

### 🔴 What is still open

**Whether the Mexal order-creation call can carry the three fields on the wire.**
The session established provenance, not transport. Nobody tested a create call
with `codice agente`, `zona` and `classificatore rete` on the header, and Andrea
Di Cicco's JSON update plus test send from 2 September are **still outstanding
and have appeared on no source**.

Until that runs, the commission attribution has a designed source and an untested
destination. **Keep this item open**; it is now one question, not two.

⚠ The requirement to carry the three fields is written into the client's own
workbook, on the Ordine sheet, in free text — not as a field list
([OI-24](OI-24%20Data%20model%20workbook.md)).
