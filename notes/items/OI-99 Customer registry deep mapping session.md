---
id: OI-99
type: open-item
status: in-progress
owner: Fabrizio Paganelli
with: Andrea Di Cicco
org: both
raised: 2026-08-26
updated: 2026-09-08
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

## 2026-09-04 — Parte 2 ran to plan, and a Parte 4 appeared

🟢 **[Parte 2](../meetings/2026-09-04%20Data%20Model%20Parte%202.md) kept to its
hour** — 16:04 CEST, 1h01m33s — where Parte 1 overran by 108%. It completed the
Account cleanup and walked the **Referente (Contact)** object field by field.
Present: Elena Spini, Aurel Mrruku, Andrea Di Cicco, Elisa Migliano. Fabrizio
Paganelli was invited and does not appear.

🔴 **The four gaps are unchanged.** Utenti, Profili and the initial-load plan
(`C-1`–`C-6`) are still empty rows in the workbook; the Ordine sheet has gained a
requirement line but no field mapping. `Flussi` still holds only F-1 and F-2. The
**Lead table**, deferred from Parte 1 so Sabatino Rinaldi could attend, was not
opened either — **and he is unavailable from Tuesday 8 September**, when the
client's tour starts.

## 🔴 The calendar now disagrees with the room

In session the group agreed that Monday 11:00–12:00 was not enough, that Andrea
Di Cicco was unavailable Monday, and that the work would **move to Tuesday** with
only Elisa Migliano and Fabrizio Paganelli attending.

What was actually booked, at 15:05Z:

| Session     | When                          | Invited                                                | Status              |
| ----------- | ----------------------------- | ------------------------------------------------------ | ------------------- |
| **Parte 3** | Mon 7 Sept 11:00–12:00 CEST   | Aurel Mrruku, Elisa Migliano, Andrea Di Cicco, Fabrizio Paganelli, cc Sabatino Rinaldi | **still on the calendar** |
| **Parte 4** | Tue 8 Sept 12:00–13:00 CEST   | Aurel Mrruku, Elisa Migliano, Fabrizio Paganelli        | **new**             |

So the session was **added, not moved**. Parte 3 remains booked for Monday with
**Andrea Di Cicco invited to a slot he said he cannot attend**, and no
cancellation or update for it appeared on any source through the end of
4 September.

**Two readings, and they lead to different weeks.** Either Parte 3 stands and
Monday is a working hour with a reduced cast, or it should have been cancelled
and was not. ⚠ **Do not assume the second.** Elena Spini explicitly proposed
adding an hour with only Aurel Mrruku before proposing Tuesday, so a Monday
session with a different cast is a coherent outcome — it is just not what the
invitation reflects.

**Somebody should say which**, and it costs one message. Against a Fase 1
development deadline of 10 September, the difference is one of the four remaining
working days.

⚠ **Three ROMI-internal `PIENISSIMO - DM TBD` holds** were noted on 2 September as
duplicates on the original three slots. Nobody has cleared them, and there are now
four real sessions.

## 2026-09-07 - Parte 3 ran on Monday, and the ambiguity resolves the first way

🟢 **[Parte 3 ran](../meetings/2026-09-07%20Data%20Model%20Parte%203.md)** —
7 September 11:06 CEST, **1h12m02s**, so it overran its hour by twelve minutes.
Present: **Elena Spini**, **Aurel Mrruku**, **Elisa Migliano**, plus **Rebecca
Marmo** by telephone for about two minutes.

**That settles the calendar question this note raised on 4 September.** Of the two
readings — Parte 3 stands with a reduced cast, or it should have been cancelled
and was not — **the first is what happened**. It was not cancelled; it was held
without Andrea Di Cicco, who said so himself in the ROMI group DM at 09:12:53
CEST: _"Ragazzi io non ci sono con pienissimo oggi che ho il kick off di un altro
progetto"_. Elena Spini also sent an **updated invitation** at 09:05:50Z, so the
slot was actively reconfirmed rather than left to run.

⚠ **Fabrizio Paganelli was invited and does not speak anywhere in the
transcript.** Elisa Migliano opened with _"E Fabri ha detto che intanto possiamo
iniziare"_. Sabatino Rinaldi was cc'd and does not appear. So the session ran with
**three** of the five people Fabrizio Paganelli originally named.

🟢 **It finished the Referente object.** Elena Spini's closing count was
_"Siamo a 35"_ — thirty-five fields disposed of, one object completed, where Parte
1 took two hours to do one and Parte 2 started this one. Consents, the tag
vocabulary, the address block, the Google Ads block and the primary-contact rule
all landed
([the decision](../decisions/Decision%20-%20consents%20live%20on%20the%20contact%20and%20editions%20on%20the%20campaign.md)).

🔴 **The four gaps survive a fourth session.** Utenti, Profili, the Ordine field
list and the initial-load plan were **not opened at all**, and neither was the
Lead table that Parte 1 deferred for Sabatino Rinaldi
([OI-24](OI-24%20Data%20model%20workbook.md)). Four sessions have now produced
**two objects**.

🔴 **A new block came out of it with nowhere to go** —
[OI-123](OI-123%20The%20Zoho%20questionnaire%20fields%20have%20no%20home.md). About a
dozen Contact fields are a verbal tutor questionnaire whose natural owner is a
*locale*, an object that does not exist in this data model. They were deleted with
no destination and no date on the conversation that decides one.

## The calendar from here

| Session       | When                              | Invited                                              |
| ------------- | --------------------------------- | ---------------------------------------------------- |
| **Parte 3**   | ✅ ran Mon 7 Sept 11:06 CEST      | Elena Spini, Aurel Mrruku, Elisa Migliano (+ Rebecca Marmo briefly) |
| **Parte 4**   | Tue 8 Sept 12:00-13:00 CEST       | Aurel Mrruku, Elisa Migliano, Fabrizio Paganelli      |

Elisa Migliano closed with _"A posto, ci vediamo domani"_, so Parte 4 is expected
to run. ⚠ **Andrea Di Cicco is not on the Parte 4 invitation either**, and the
Ordine field mapping — which is his — is one of the four things still unopened.

⚠ Sabatino Rinaldi was said on 4 September to be unavailable from Tuesday 8
September when the client's tour starts. **The Lead table still needs him** and
Parte 4 is the last booked session.

## 2026-09-08 - Parte 4 ran; the series continues to Parte 6

| Session | When | Who was actually there |
| ------- | ---- | ---------------------- |
| **Parte 4** | ✅ ran Tue 8 Sept **12:01 CEST**, 1h25m58s | Elena Spini, Elisa Migliano, Aurel Mrruku |
| **Parte 5** | Wed 16 Sept 11:00-13:00 CEST | + amministrazione@, Fabrizio Paganelli, cc Sabatino Rinaldi |
| **Parte 6** | Fri 18 Sept 11:00-13:00 CEST | + **Rebecca Marmo** |

**Fabrizio Paganelli was invited to Parte 4 and did not speak** in the
transcript; **Andrea Di Cicco was not invited**, for the second session running,
and the Ordine field mapping that is his is the focus of Parte 5.

⚠ **Parte 5 was sent twice** — an invitation at 11:23:13Z and an *updated*
invitation at 11:27:42Z, three minutes apart, the change being the description.
Both carry a Google Meet link, so the `Parte 3` defect does not repeat.

🟢 **Rebecca Marmo is formally invited to a working session for the first time.**
Three separate things are owed by her — the segment logic and mail detail due
21 August ([OI-14](OI-14%20Marketing%20forms%20and%20subdomain.md)), the
landing-page hosting call that was never scheduled
([OI-86](OI-86%20Who%20hosts%20the%20participant%20landing%20page.md)), and the
missing WhatsApp templates
([OI-133](OI-133%20The%20WhatsApp%20templates%20are%20missing%20from%20the%20marketing%20material.md)).
**Parte 6 is the first forum where all three could be put to her at once.**

⚠ **Sabatino Rinaldi is cc'd on Parte 5 and 6 but not a required attendee**, and
he has been on the client's tour since 8 September. The Lead table — Parte 6 —
is the part the record says needs him.
