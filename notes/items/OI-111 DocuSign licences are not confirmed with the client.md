---
id: OI-111
type: open-item
status: open
owner: Elena Spini
with: Sabatino Rinaldi
org: both
raised: 2026-09-02
updated: 2026-09-04
blocks: [OI-68]
requirement: INT-19
source: Slack DM Aurel Mrruku / Elena Spini, 2026-09-02 15:47-15:49 CEST
---

# OI-111 - DocuSign licences are not confirmed with the client

**Nobody at ROMI knows whether Pienissimo has actually bought DocuSign**, and the
quote-signature design assumes they have.

Aurel Mrruku asked Elena Spini directly on Slack, 2 September:

> _"alla fine con docusign hanno parlato? si sono messi d'accordo?"_
> — _"hanno già un contratto con loro?"_

Elena Spini's answer separates the two things cleanly, and only one of them is
settled:

> _"si DocuSign per la firma del preventivo lo vogliono"_ … **_"richiedo
> conferma, ma mi aspetto di sì"_**

So **the want is confirmed and the contract is not.** She holds the action to
ask. No date.

## Why this is not a detail

Aurel Mrruku named the risk in the same exchange: _"per l'ambiente di test non ci
sono problemi ma quando andiamo in prod"_. A DocuSign developer sandbox costs
nothing and needs no client involvement; **the production tenant needs a
commercial agreement Pienissimo has to sign**, and go-live is 6 October.

The design that depends on it is already committed:

- **DocuSign is in for quotes and contracts and out for tickets**, settled
  6 August, and the quote lifecycle flips to _Accettato_ on signature
  ([OI-68](OI-68%20Quote%20acceptance%20landing%20page.md),
  [the quote to order flow](../flows/The%20quote%20to%20order%20flow.md)).
- The org already carries a **`DocuSign` named credential and a `DocuSign`
  permission set, both org-only**
  ([the credential risk](../risks/Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md)) —
  so somebody has already wired something to an account nobody can name.

## ⚠ This has wobbled before, twice

The record shows the client changing direction on DocuSign without telling ROMI,
which is why "I expect so" is not good enough:

- **24 July**, Elena Spini's status post: _"in settimana hanno detto che forse non
  vogliono DocuSign (ad inizio settimana Sabatino invece mi aveva confermato
  telefonicamente che stavano procedendo con l'acquisto delle licenze -.-)"._
- **6 August** settled it the other way, for quotes and contracts only.

**A licence purchase was claimed in July and has never been confirmed since.**
`BIG-13` still carries `status: open` in the register, and its Option A says in
as many words: _"Requires purchasing licences; negotiation still open."_

## The ask

One question to Sabatino Rinaldi, and it is a yes/no: **does Pienissimo hold a
DocuSign account today, on what plan, and who administers it.** If the answer is
no, `BIG-13`'s fallback is already written — Option C, paper as-is, with digital
signature deferred to an evolutiva — and the sooner that is said the less is
built against an account that does not exist.

## ⚠ 2026-09-03 - a quote acceptance page shipped without DocuSign in it

`quoteAcceptancePage` and `QuoteAcceptanceController` merged to `DevMain` at
15:02:59Z —
[the Landing Page community](../objects/The%20Landing%20Page%20community.md). The
accept action sets `Quote.Status` to `Accettato` directly. **There is no DocuSign
envelope in the class**, where
[OI-68](OI-68%20Quote%20acceptance%20landing%20page.md)'s agreed design has
acceptance send the documents for signature and the status flip follow the
signature.

**Read this carefully, because two readings are open and they point opposite
ways:**

1. **A first pass that has not reached the signature step.** The same PR is
   missing order generation too, which is also part of the agreed flow. On this
   reading DocuSign is still needed and this item is as urgent as it was.
2. **A quiet substitution** — a click-through acceptance replacing a signature,
   in which case the licence question is moot and `BIG-13` needs rewriting.

**Nothing distinguishes them.** No commit message, PR description, mail or Slack
message mentions DocuSign at all. Elena Spini's answer of 2 September —
_"richiedo conferma, ma mi aspetto di sì"_ — has produced no follow-up on any
source.

🔴 **Ask Aurel Mrruku directly.** This is now a question about ROMI's own build,
not only about the client's procurement, and it is cheaper to answer than the
licence question it depends on.

## 2026-09-04 — reconfirmed verbally, with a named contact and a date of sorts

Aurel Mrruku asked again at the close of
[Data Model Parte 2](../meetings/2026-09-04%20Data%20Model%20Parte%202.md) —
_"ma DocuSign alla fine abbiamo…"_ — and Elena Spini answered with the first
substantive update since 2 September:

> _"Io ho parlato con Sabatino, quando poi e sparito, mi ha risposto e poi e
> sparito. E sono presi da questo evento. Comunque **tutto confermato**. In
> realta poi li hanno anche rimbalzati a loro stessi perche poi sono andati in
> ferie quelli commerciale DocuSign. Comunque tutto confermato, ha detto che
> **Massimo settimana prossima ci fa sapere**."_

🟢 **Three things are new.**

- **The delay has an explanation that is not the client's silence.** It is
  attributed to **DocuSign's own commercial team** being on holiday and bouncing
  the request internally — a different failure from the one this item assumed.
- **There is a named person on the DocuSign side: `Massimo`.** First appearance
  in the record. No surname, no company role stated; treat as uncertain.
- **There is a promised update: "next week"** — the week beginning 7 September.

🔴 **And nothing has actually changed.**

_"Tutto confermato"_ is Sabatino Rinaldi's assurance relayed by Elena Spini, one
step further from evidence than her own 2 September _"richiedo conferma, ma mi
aspetto di si"_. **Still nothing written names a plan, a tenant or an
administrator**, which is exactly what this item asks for. The same phrasing has
been recorded before and did not hold: a licence purchase was reported by phone
in July and reversed within a week.

⚠ **Sabatino Rinaldi is now harder to reach, not easier.** Elena Spini's Slack
status the same evening records that he has stopped answering his phone because
of the client's event, and Elisa Migliano confirmed in the session that **the
tour starts Tuesday 8 September** and neither he nor Matteo will be available.
The window for a written confirmation before Fase 1 development ends on
**10 September** is effectively **Monday 7 September**.

⚠ **The build question this item picked up on 3 September is untouched.** The
quote acceptance page still sets `Quote.Status` on the click with no envelope, and
nobody has said whether that is a first pass or a design change. **That question
does not depend on the licence and is still the cheaper one to answer.**
