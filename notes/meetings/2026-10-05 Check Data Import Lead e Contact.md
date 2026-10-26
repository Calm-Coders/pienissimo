---
id: MTG-2026-10-05-check-data-import-lead
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-10-05
updated: 2026-10-05
depends_on: [OI-14, OI-78, OI-115, OI-127, OI-165, OI-186, OI-203]
source: Drive 14nkqoZ1vgEb21jq0jeRRG8Z50zRbH7_7Whdt94ALlz4 (Gemini notes)
---

# 2026-10-05 Check Data Import Lead e Contact

**Client session, 17:15 CEST, ~1h10m.** Elena Spini · Aurel Mrruku ·
**Fabrizio Paganelli · Sabatino Rinaldi · Matteo Distaso · Elisa Migliano**.
A field-by-field review of the Salesforce `Lead` object against Zoho — the
first session this project has held on the Lead, and the one that finally put
numbers on the form fields.

## What a Lead is, agreed

Elena Spini defined it and nobody dissented: a Lead is a potential contact who
reaches the CRM having shown interest in a Pienissimo product — _"come la
semplice iscrizione a una diretta"_ — and becomes a qualified Account and a
Contact **only** when they ask for a quote or for prices.

## Concordato — six rulings

- **`Settore` is replaced by `Tipologia di attività`**, a multiselect picklist
  of venue types, using Elisa Migliano's values. The authoritative list —
  21 values — now sits in
  [the Campi Oggetti workbook](../The%20Campi%20Oggetti%20Flussi%20e%20Utenti%20workbook.md)
  ([OI-115](../items/OI-115%20Tipologia%20Attivita%20values%20and%20its%20move%20to%20the%20quote.md)).
- **Lead deduplication runs on email and telephone**; the decisive check is
  **Partita IVA, mandatory at conversion**, which is what stops a duplicate
  customer reaching the Anticipay-linked registry. Aurel Mrruku was explicit
  that same email plus same phone does **not** auto-discard a later lead: it
  needs manual qualification and the VAT check before conversion.
- **Consents reduce to two flags on the Lead** — the privacy notice
  (mandatory) and commercial profiling (optional). The wider consents stay on
  the Contact, filled automatically when a customer signs a contract or
  attends an event; only the two are marketing's.
- **Obsolete fields go**: fax, first visit, first page visited, device type,
  Skype id, second email, ratings, ad groups, ad ids, annual revenue, average
  time spent, click type, conversion cost, days visited. **Kept**: address,
  description, number of employees, Partita IVA, ticket quantity.
- **Removed from the forms**: visitor score, `ID campagna Z`, postcode — the
  last because the address already carries it.
- **UTM parameters stay hidden**, auto-populated from the URL and never
  visible to the customer. Sabatino Rinaldi named `campaign`, `content`,
  `medium`, `source`; ⚠ **the workbook carries a fifth, `utm_term`.**

## 🔑 Da approfondire — the link moves from per-order to per-edition

Elena Spini raised the participant-link logic and the points Fabrizio
Paganelli had put on the document sent earlier. **The discussion was deferred
to the next day on grounds of fatigue** — _"a causa della stanchezza
accumulata durante la giornata"_ — but she previewed the proposal:
**move from one link per order to one link per edition**, changing the
approach for bundles that unlock several courses at once, naming Food
Marketing and Academy.

⚠ **It was already built.** Commit `4a6fe3f` — _"event invitation lik for each
campaign"_ — landed at **17:39 CEST**, during or immediately after this
session, and the design is documented in
[Decision - Event Links belong to Order Campaign pairs](../decisions/Decision%20-%20Event%20Links%20belong%20to%20Order%20Campaign%20pairs.md).
So the change the client is to be consulted on tomorrow was in the repository
before the consultation. It is also the direct answer to the objection in
[OI-203](../items/OI-203%20The%20client%20contested%20the%20agreed%20ticket%20logics%20before%20confirming%20them.md)
— the `aggregazione multievento per ordine` they said did not add up.

The follow-up is booked for **06/10 10:00–11:00**, on the calendar as
`[ROMI-PIENISSIMO] - Form: Link per partecipanti`, with `amministrazione@`,
`fabrizio.p@` and `sabatino.r@`.

## Owed, with dates

| Owner | Action | Due |
| --- | --- | --- |
| **Matteo Distaso** | Flag the hidden and non-hidden fields in Elena Spini's shared file, for the `Pienissimo Live` and `Camerieri Venditori` forms | **by the morning of 06/10** |
| **Matteo Distaso** | Map every hidden field of those two forms against the data-model file; drop fields the data model does not carry | 06/10 |
| **Sabatino Rinaldi** | Review the Zoho field mapping against the shared data model | — |
| **Sabatino Rinaldi** | **Read the Business Blueprint** | before 06/10 |
| Matteo Distaso · Sabatino Rinaldi | Check the coherence of lead status and lead source against business requirements | — |

🔑 The two named forms are the ones Matteo Distaso prioritised in writing on
02/10 ([OI-14](../items/OI-14%20Marketing%20forms%20and%20subdomain.md)), so the
form workstream has a dated next step for the first time in nine weeks.

⚠ **Sabatino Rinaldi had not read the Blueprint** three days after it was
delivered, and Elena Spini asked everyone to read it before tomorrow. His
colleagues Fabrizio Paganelli and he had already replied rejecting a different
document on 02/10.

## Noted in passing

- Matteo Distaso asked for Italian labels on `lead source` for less
  experienced operators. Elena Spini and Sabatino Rinaldi: the platform is in
  Italian but some standard options need review. 🟢 The workbook now carries a
  nine-value Italian `Origine Lead` list.
- Elena Spini said plainly that the form logic cannot be understood without an
  overall view, and Sabatino Rinaldi answered that **Fabrizio Paganelli
  already holds that information** from an earlier discussion. ⚠ It has never
  reached the repository or, on Elena Spini's account, her.
