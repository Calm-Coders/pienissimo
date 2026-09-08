---
id: OI-123
type: open-item
status: resolved
owner: Elisa Migliano
with: Marco Montesi
org: Pienissimo
raised: 2026-09-07
updated: 2026-09-08
depends_on: [OI-24]
source: notes/meetings/2026-09-08 Data Model Parte 4.md
---

# OI-123 - The Zoho questionnaire fields have no home

**A block of about a dozen Contact fields turned out to be a verbal intake
questionnaire. They were deleted from the Contact in Parte 3 with no decision on
where they go, and one of the candidate homes does not exist in the data model.**

## What the fields are

Named by Elisa Migliano across
[Data Model Parte 3](../meetings/2026-09-07%20Data%20Model%20Parte%203.md):

`Coperto medio` · `Apertura locale` (annuale or stagionale) ·
`Attuale posizione su TripAdvisor` · `Numero collaboratori` · `Numero coperti` ·
`Quanti giorni alla settimana lavori` · `Nuova apertura` · `Tipologia cliente` ·
`In quale servizio lavori maggiormente` · `La più grande difficoltà adesso` ·
`Provenienza iscrizione` · `Data questionario`

They are not a form anybody sends. A **tutor runs the questions by voice** when
calling a prospect, and types the answers into the record in front of them.

## Why they are on the Contact

Elisa Migliano explained it and disowned it in the same breath:

> _"non riuscivamo con Zo a tenerlo esterno e perché i tutor volevano che fosse
> in un'unica pagina rispetto al contatto che chiamavano … è per quello che
> l'abbiamo messo all'interno del contatto, perché non volevano una pagina
> esterna su cui atterrare … che è sbagliatissimo."_

So the placement is a **Zoho workaround for a UI constraint**, not a data model
decision, and Pienissimo already knows it is wrong.

## 🔴 Why this is not simply "move them to the Account"

Elisa Migliano was explicit that the Account is not right either:

> _"più di locale, perché un account può avere più tipologie di locali diverse."_

The natural owner of these answers is a **locale** — an individual premises. An
account can hold several, of different kinds. **There is no locale object
anywhere in the Salesforce data model**, in the register, in the workbook or in
the design diagram. Creating one is not a field decision.

⚠ The same problem was already visible on the **Account** side: the 3 September
Parte 1 session met the same questionnaire fields there. This is the second
object they have been deleted from without a destination.

## What has to happen

**Elisa Migliano takes it to the responsabile commerciale** — Marco Montesi —
with two questions, in her own framing:

1. Are the tutors **actually using** these fields?
2. **How should they be managed** if they are?

Only after that does the placement question have an answer worth building
against.

## ✅ Resolved the next day - the locale is an Account record type

**[Data Model Parte 4](../meetings/2026-09-08%20Data%20Model%20Parte%204.md), 8
September**, answered it. Elisa Migliano brought Marco Montesi's response: the
questionnaire holds **2022 operating data** — coperti medi, tipo di attivita,
stagionalita — and **one company can own several locali on different terms**,
which is exactly the objection she raised in Parte 3.

Agreed, under `Concordato`:

- **`Locale` records are Account children of the billing company.**
- **Only parent companies are sent to Mexal.** Locali exist on Salesforce only.
- **Quotes carry a lookup to the specific locale** of that company.

So the questionnaire's owner is a **record type on an object that already
exists**, not a new object
([the decision](../decisions/Decision%20-%20Account%20record%20types%20split%20Azienda%20and%20Locale.md)).

**It was built the same evening.** Commit `c877631` (Anita Aga, PR #35, merged
18:21 CEST) adds the `Azienda` and `Locale` record types, two validation rules
enforcing that a `Locale` has a parent and that the parent is an `Azienda`,
`AccountTriggerHandler`, `CommercialAccountResolver` and ten Account fields.

⚠ **This note predicted the expensive outcome and got the cheap one.** It warned
that a locale object would mean "a new object, its relationships, its layouts and
its migration, arriving after the Fase 1 development deadline". The record-type
answer costs almost none of that — the hierarchy is the standard `ParentId`.

## What is still open, as a separate row

Answering *where* the fields go did not answer *which* fields, or how the data
gets there. Both are
[OI-129](OI-129%20The%20locale%20questionnaire%20field%20list%20and%20the%20locale%20API.md):

- Marco Montesi's actual field list — **the dozen names above are the Zoho set as
  Elisa Migliano recited them**, and may not be what he asks for.
- Whether an **API exists for the locale anagrafica** at all. Locali are in no
  migration plan, because until 8 September they were not in the model.

⚠ **The tutors' side of the original question was never answered.** Parte 3 sent
Elisa Migliano to Marco Montesi with two questions — are the tutors using these
fields, and how should they be managed. Parte 4 answered the second. **Whether
the tutors actually use them is still not on the record**, and it is the question
that decides whether any of this migrates.
