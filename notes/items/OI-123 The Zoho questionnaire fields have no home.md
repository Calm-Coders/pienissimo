---
id: OI-123
type: open-item
status: open
owner: Elisa Migliano
with: Marco Montesi
org: Pienissimo
raised: 2026-09-07
updated: 2026-09-07
depends_on: [OI-24]
source: notes/meetings/2026-09-07 Data Model Parte 3.md
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

## Why it matters now

- The fields are **deleted from the working model**, so the default outcome is
  that they do not migrate. If the tutors are using them, that is data loss at
  cutover.
- If the answer is a **locale object**, that is a new object, its relationships,
  its layouts and its migration — arriving after the Fase 1 development deadline
  of 10 September, against a go-live that
  [OI-124](OI-124%20Go-live%20moved%20to%2021%20September%20in%20an%20internal%20session.md)
  has just moved to 21 September.
- ⚠ **Nobody put a date on the conversation with Marco Montesi.**
