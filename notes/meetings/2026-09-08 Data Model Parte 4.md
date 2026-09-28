---
id: MTG-2026-09-08-data-model-parte-4
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-09-08
updated: 2026-09-08
depends_on: [OI-24, OI-99, OI-123]
source: Appunti di Gemini, Drive 1yH35OnOYKOCN7I6Z4o4GjDeIwcAkOaLPVgS9XHZkRao
---

# 2026-09-08 Data Model Parte 4

**The fourth data-model session, and the first one that finished an object and
opened the next. It gave the `locale` a home — as an Account record type, not a
new object — and it cleared the Opportunity field list. 1h25m58s against a
booked slot; drilled from the full transcript.**

Client-facing, started **12:01 CEST**, ran **1h25m58s**.

**Present** (by speaking turn in the transcript): Elena Spini (423 turns),
Elisa Migliano (415), Aurel Mrruku (307). Invited but not speaking:
Fabrizio Paganelli. **Andrea Di Cicco did not attend**, as in Parte 3.

## 🟢 The locale becomes an Account record type

This is the session's substance and it
**resolves [OI-123](../items/OI-123%20The%20Zoho%20questionnaire%20fields%20have%20no%20home.md)**.

Elisa Migliano brought Marco Montesi's answer: the questionnaire holds **2022
operating data** — coperti medi, tipo di attività, stagionalità — and **one
company can own several locali with different conditions**. Aurel Mrruku noted
the data model has no native hierarchy for that. Agreed:

- **`Locale` records are Account children of the billing company.**
- **Only the parent companies are sent to Mexal.** Locali live on Salesforce
  only.
- **Quotes carry a lookup to the specific locale** of that company.

Recorded under `Concordato` as _"I locali vengono configurati come account figli
dell'azienda di fatturazione su Salesforce, mentre a Mexal vengono inviate
unicamente le aziende padri."_

⚠ OI-123 warned that a locale object would mean "a new object, its relationships,
its layouts and its migration". It did not: the answer was a **record type on an
object that already exists**, which is why the build landed the same evening
([the decision](../decisions/Decision%20-%20Account%20record%20types%20split%20Azienda%20and%20Locale.md)).

## 🟢 Contracts, quotes and tickets go to the billing company's principal

For legal reasons Elisa Migliano was explicit that contracts and tickets go
**only to the legal representative or titolare registered as `contatto
principale` of the billing company** — never to an individual locale. Elena Spini
flagged that the tutors have to be instructed on this. Aurel Mrruku added that
**DocuSign sends will allow additional CC addresses**.

The quote's reference contact stays **editable by free search, defaulting to the
principal** — as agreed in Parte 2 — and **each child account initially inherits
the parent's principal contact**. Whether that search can be widened to include
the contacts of child locali is
[OI-132](../items/OI-132%20Whether%20the%20quote%20contact%20search%20can%20include%20child%20locale%20contacts.md).

## 🟢 Ticket dispatch is a marketing calendar decision, not a payment trigger

Aurel Mrruku asked how tranche payment gates ticket dispatch. Elisa Migliano and
Elena Spini answered that **there is no fixed rule tied to payment**: marketing
plans the send against the annual event calendar and the customers' own working
patterns — the example given was avoiding a Thursday evening send.

⚠ This does not answer the tranche questions in
[OI-50](../items/OI-50%20Tranche%20object.md); it says dispatch is not driven by
them.

## 🟢 The Opportunity field list was cleaned

- Custom fields duplicating standard Salesforce functionality are **removed**.
- The address detail block (provincia, città, CAP), sales-cycle duration and
  lead conversion time are **removed**.
- The Pienissimo Software / Zoho hand-off checkboxes are **removed for now**,
  to be recreated when that flow is actually analysed — which is Fase 2 work.
- The **closed-lost reason** standard field is **kept**, per Marco Montesi.
- The tutor field is confirmed as the **standard owner**, editable to reassign.
- The Opportunity **amount will be driven automatically from the primary quote**.
- Opportunity naming from QR-code scans and web forms will be **standardised by
  Marketing Cloud plus a back-end trigger**, keyed to the form's provenance.

Two specifications are now owed by the client before this can be built:
[OI-130](../items/OI-130%20The%20opportunity%20category%20and%20subcategory%20dependency%20matrix.md)
and [OI-131](../items/OI-131%20The%20lead%20origin%20picklist%20values.md).

## 🟢 Duplicate control moves to the Lead, on email AND phone

Aurel Mrruku established that duplicate handling belongs **at the Lead, before
conversion**, not on the Opportunity — the Zoho-inherited phone-check fields on
Opportunity are deleted.

The rule was chosen deliberately after Aurel Mrruku set out the two options:
**"combo"** (both email and phone must match) versus **either-or** (one match is
enough). Elisa Migliano's constraint was that a customer can hold several email
addresses. **Agreed: combo — email and phone together.**

## The calendar

Elena Spini proposed **two-hour** sessions to stop losing time; agreed.

| Session | When | Focus |
| ------- | ---- | ----- |
| **Parte 5** | Wed **16 September**, 11:00–13:00 CEST | Prodotti, Preventivi, Ordini |
| **Parte 6** | Fri **18 September**, 11:00–13:00 CEST | Campagne, Lead — **with Rebecca Marmo** |

Aurel Mrruku asked for **products first**, as propedeutico to quotes and orders.
Invitations went out the same morning (11:23, 11:27, 11:28Z); **Parte 5 was
re-sent as an update** three minutes after the original.

⚠ **The Lead table has now been deferred from Parte 1, 2, 3 and 4 to Parte 6** —
the same deferral [OI-24](../items/OI-24%20Data%20model%20workbook.md) has carried
since 3 September.

## What is still not open after four sessions

**Utenti, Profili, the Ordine field list and the initial-load plan** — unchanged
since 2 September. Parte 5 covers Ordini; Utenti, Profili and the load plan are
in no booked session.

## Method note

The session opened with Elena Spini and Aurel Mrruku disagreeing about whether
to review the model **field by field with the client** or ask the client to
pre-filter. Aurel Mrruku's objection was that the client would enter values
Salesforce cannot take; Elena Spini's was the time cost. They settled on a joint
preliminary pass — which is the working method for Parte 5 and 6, and the reason
Elena Spini's status mail to the client that afternoon calls the data model
_"a 4 mani campo per campo"_ and says it is taking too long.
