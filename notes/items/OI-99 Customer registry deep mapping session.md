---
id: OI-99
type: open-item
status: in-progress
owner: Fabrizio Paganelli
with: Andrea Di Cicco
org: both
raised: 2026-08-26
updated: 2026-09-03
depends_on: [OI-58]
source: notes/meetings/2026-08-26 Review Temi Integrazione Mexal.md
---

# OI-99 - Customer registry deep mapping session

**Fabrizio Paganelli asked for a dedicated hour on the Mexal customer registry**,
at the [26 August Mexal review](../meetings/2026-08-26%20Review%20Temi%20Integrazione%20Mexal.md),
because the fields that block invoicing are not the ones anybody has mapped.

> _"magari ci riserviamo un'altra oretta io, te e anche Aurel e l'Elisa, perché
> ci sono alcuni aspetti tipo la categoria provvigioni, eccetera dove è bene che
> li svisceriamo prima."_

**Attendees he named:** Fabrizio Paganelli, Andrea Di Cicco, Aurel Mrruku,
Elisa Migliano.

## What it has to cover

- **Categoria provvigioni** — required to compute agent commissions. It lives on
  a sub-screen of the customer record, under *condizioni documenti di magazzino*,
  alongside the sales price list.
- **Condizioni documenti di magazzino** generally.
- The **prealimented order fields**: *causale*, the *sezionale* number, and the
  rest of the block Fabrizio Paganelli demonstrated on a real order —
  _"sono tutte regole che impattano sugli aspetti fiscali barra dell'ufficio
  tributario."_

His stated reason is operational, not documentary:

> _"altrimenti ci si blocca la fatturazione se questi determinati campi non sono
> configurati in modo corretto."_

## Why it is not already covered

Andrea Di Cicco's
[integration mapping workbook](../The%20Mexal%20integration%20mapping%20workbook.md)
maps the customer payload — but he said in the session that he built it from
**the fields Pienissimo currently shares with Zoho**, and expects fields to exist
on each side that the other needs. This session is where that gap gets closed.

## 🟢 It is scheduled — 2 September, though the title says otherwise

**Elena Spini booked it the same evening.** In the ROMI group DM with Aurel
Mrruku and Andrea Di Cicco, an hour after the call:

- 17:27 CEST — Andrea Di Cicco: _"Elena sarai contenta di sapere che dobbiamo
  fare un altro meeting con il buon Fabri."_ Elena Spini: _"mamma miaaaaa -.-"_
- 18:15 — _"dice settimana prossima perché questa in ferie"_ and _"deve rivedere
  anche per i codici dei prodotti e aveva conferma lunedì"_
  ([OI-98](OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md)).
- 18:30 — Elena Spini: _"rimetto un follow-up per settimana prossima (stessa ora,
  stesso giorno impossibile) metterò la mattina e nel caso mi chiederà di
  spostare."_

The invitation went out ten minutes later, at **16:40 UTC**:
`[ROMI-PIENISSIMO] - Follow-up Anagrafica Articoli`, **Wednesday 2 September
10:00–11:30 CEST**, to Aurel Mrruku, `amministrazione@pienissimo.com`, Andrea Di
Cicco and Fabrizio Paganelli. Description: _"Fisso questo meeting per discutere i
punti aperti dell'anagrafica articoli."_

⚠ **The title names the article registry; the thread that produced it is about
both.** Andrea Di Cicco's reason for wanting the meeting was the customer side —
_"dobbiamo vedere che poi tutti i dati anagrafici arrivano per la fattura"_ — and
Fabrizio Paganelli's own ask in the call was the customer registry. Treat the
2 September slot as the forum for **both**, and **put the customer-registry
agenda in writing before it**, because a meeting titled for articles will drift
to articles.

⚠ **Elisa Migliano is not personally on the invitation.** She reads
`amministrazione@`, which is, so the invite reaches her — but Fabrizio Paganelli
named her explicitly as a required attendee and nobody addressed her directly.

## 🔴 The sharper version of the problem

Andrea Di Cicco stated it more bluntly on Slack than in the meeting:

> _"il fatto è che loro hanno dei valori che sono tipo per valuta: 1,2,3,4 — che
> lato nostro non sappiamo."_

**Mexal's coded-value dictionaries are unknown to ROMI.** `valuta` is the example
he reached for, but the shape of the problem is general: the API returns and
demands integer codes whose meanings live in Mexal's own base tables and are not
in the documentation. He had already asked for this by email —
_"cosa che gli avevo chiesto di fare nell'email per vedere se c'erano tutti i
campi che servivano"_ — and it is unanswered. See
[OI-97](OI-97%20Fiscal%20residence%20on%20the%20customer%20registry.md).

His own verdict on the day's work, same thread, 18:02 CEST:
**_"le integrazioni per ordini e clienti funzionicchiano"_** — they sort of work.

## Also unresolved from the same stretch of the call

Aurel Mrruku asked Andrea Di Cicco to explain the **one-to-many mapping between
tranche and product** implied by Mexal's order-row identifiers —
_"mi devi spiegare sta roba"_ — and got no answer before the call ended. It bears
on [OI-50](OI-50%20Tranche%20object.md).

## 2026-09-02 — the sessions exist, and the client asked for them

🟢 **This item's session ran on 2 September, and produced a series rather than an
answer.** Elisa Migliano raised the problem herself, with the number that makes
it a problem:

> _"l'anagrafica clienti estrapolata oggi da Zoho ha 150 campi… ho detto qui
> andiamo in confusione, sicuro. Sono andata in confusione io da sola con me
> stessa, su un'anagrafica che conosco."_

Her proposal — accepted by Andrea Di Cicco and Aurel Mrruku — is **half-hour
calls, one table at a time**, deciding for each Zoho field whether Salesforce
needs it, what it holds and how it should be fed. Andrea Di Cicco added the
integration's constraint: whatever survives must cover what Mexal needs, without
creating `piva` and `partita IVA` as two fields.

**Three sessions were booked the same morning** (Elena Spini, invitations sent
09:08-09:19Z), client-facing, with Elisa Migliano, Fabrizio Paganelli, Andrea Di
Cicco and Aurel Mrruku, Sabatino Rinaldi optional:

| Session                   | When                                |
| ------------------------- | ----------------------------------- |
| `Data Model: Parte 1`     | **3 September 11:00-12:00 CEST**    |
| `Data Model: Parte 2`     | **4 September 16:00-17:00 CEST**    |
| `Data Model: Parte 3`     | **7 September 11:00-12:00 CEST**    |

🟢 **The material for them landed the same day**: Elisa Migliano filled ROMI's
shared workbook straight after the call and Fabrizio Paganelli mailed
_"abbiamo aggiornato la tabella condivisa"_ at 14:06Z —
[OI-24](OI-24%20Data%20model%20workbook.md).

⚠ **Do not read this as the deep mapping being done.** The three sessions are
where the 150 fields get decided; the workbook is the input to them, not the
output. And they run **3, 4 and 7 September**, with Fase 1 development ending on
the **10th** and ROMI at a company event **9-11 September**.

## 2026-09-03 - Parte 1 ran

**The first of the three sessions ran on 3 September, 10:59 CEST, and overran its
hour to 2h08m** —
[the minute](../meetings/2026-09-03%20Data%20Model%20Parte%201.md). Present:
Elena Spini, Aurel Mrruku, Andrea Di Cicco, Elisa Migliano, Fabrizio Paganelli.
Sabatino Rinaldi was optional and did not attend.

🟢 **It did what Elisa Migliano asked for.** Fifteen decisions recorded as
_Concordato_, one formally deferred, sixteen actions out. The Account object was
sectioned, pruned and re-scoped field by field.

🔴 **It did not get through the agenda.** The **Lead table was deliberately
skipped** so Sabatino Rinaldi can be present for it, and Utenti, Profili, the
Ordine field list and the initial-load plan were not opened at all
([OI-24](OI-24%20Data%20model%20workbook.md)). **Two hours produced one object.**
Parte 2 (4 Sept 16:00) and Parte 3 (7 Sept 11:00) have one hour each and now
carry the whole remainder plus a Lead session that needs a participant who has
not been attending.

⚠ **Parte 3 still has no Google Meet link**, and the three ROMI-internal
`PIENISSIMO - DM TBD` holds on the same three slots are still in the calendar.
Neither was cleared today.
