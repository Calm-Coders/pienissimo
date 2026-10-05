---
id: OI-111
type: open-item
status: open
owner: Elena Spini
with: Sabatino Rinaldi
org: both
raised: 2026-09-02
updated: 2026-10-05
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

## 2026-09-08 - escalated to the client in writing, named as blocking

The status mail to Pienissimo lists DocuSign **first** among four urgent blocking
decisions:

> _"**DocuSign:** La definizione di questo punto è prioritaria, poiché blocca il
> completamento del flusso preventivi. Ci sono novità in merito all'acquisto
> delle licenze?"_

🟢 **This is the first time the question has been put to the client in writing.**
Every prior attempt was verbal — the July phone report, Elena Spini's _"richiedo
conferma, ma mi aspetto di sì"_ on 2 September, and the _"tutto confermato"_ with
Massimo owing an update on 4 September. It is now on the record, addressed to four
client recipients, with a stated consequence.

⚠ **It asks about the purchase, not the contract.** The distinction that matters
is that **the sandbox is free while production needs a signed agreement**, and
the mail does not draw it. An answer of _"sì, le abbiamo comprate"_ would not
settle whether production can send an envelope on 21 October.

⚠ **Massimo's promised update did not arrive.** It was owed "next week" as of
4 September; nothing on any source this sweep reached carries it.

⚠ **The build question is still the cheaper one and is still unanswered.** The
quote acceptance page sets `Quote.Status` on the click with no envelope. The
8 September org check confirms it again — the quote controller "does not invoke
signature processing" and **0 Assets carry QR values**.

## 🟢 2026-09-28 - the credentials arrived

The client's DocuSign account credentials were sent by **Elisa Migliano
(`amministrazione@pienissimo.com`)** to Elena Spini and Aurel Mrruku, cc Fabrizio
Paganelli and Sabatino Rinaldi, on **2026-09-28 at 10:27Z**, on the
`ID ACCOUNT SALESFORCE` thread (Gmail `1a0c3aed1b1964cb`).

🔴 **They were sent in the clear in a mail body — an account address and a
password, alongside a DocuSign document link.** **The values are deliberately not
recorded in this repository**, here or anywhere: see
[docs/publishing.md](../../docs/publishing.md). What is recorded is that they exist
and where. Anyone who needs them reads the mail.

⚠ **This is the second credential-shaped item to travel in plain text** — a
password-shaped string was posted in a Slack DM on 23/09. **Worth a standing note
on where credentials are meant to go**, which still does not exist.

🟢 **How it was unblocked:** Elena Spini raised the missing access with Fabrizio
Paganelli at [the 28/09 session](../meetings/2026-09-28%20Tema%20Contratti%20e%20Open%20Point.md)
(`00:31:00`). He had not known it was outstanding — _"Ah, vi servivano gli
accessi"_ — Elisa Migliano was out of the office, and he undertook to chase her
himself: _"Vedo di fare in modo che ve lo giro io."_ **The mail landed roughly
twenty-five minutes later.** Elena Spini confirmed receipt to Aurel Mrruku on
Slack at 12:44 CEST (_"credenziali DocuSign inviate da Elisa"_); he replied
_"viste, grz"_ at 13:01.

### What this unblocks, and what it does not

- 🟢 Everything demonstrated to the client so far ran on a **ROMI-made test account
  in the DocuSign demo environment**. There is now a client account to move to.
- 🔴 **The Named Credential still points at `demo.docusign.net`** in the Prod org,
  recorded in [MAP.md](../../MAP.md) as an open item before Prod is used. Having
  the credentials does not change the configuration; **somebody has to enter
  them.** No owner, no date.
- ⚠ **The original question in this note is still not answered on paper.** Whether
  Pienissimo holds a _licence_ — as opposed to an account someone can log into —
  was never confirmed in writing. An account arriving is strong evidence and not
  the same thing.

## 🔴 2026-10-05 - the production account is a free plan with three envelopes

The client's production account is now wired into Pienissimo Prod (Go-Live of the
existing integration key, production endpoints, principal authenticated; see
[JOURNAL.md](../../JOURNAL.md)). A read-only call to the account from Prod returned:

- `planName: DocuSignIt`, **`planClassification: free`**
- **`billingPeriodEnvelopesAllowed: 3`**, `canUpgrade: false`
- plan start 21 September 2026

**This answers the question this item has asked since 2 September, and the answer is
no.** The account the client handed over is not a commercial licence. Three envelopes
a month cannot carry the quote flow, every test spends one, and DocuSign Connect —
which writes `Completed` back to the quote and so produces `Firmato` and the order —
is very likely not on a free plan. Not verified on the account itself.

🔴 **The ask is now concrete:** Pienissimo must buy a paid eSignature plan that
includes API use and Connect, on this same account, before 21 October. Owner not yet
assigned.

## 🟢🔑 2026-10-05 (later) - the free-plan finding was the wrong account, and the client holds 2,500 envelopes a year

**Corrects the section above.** At
[the 05/10 client UAT](../meetings/2026-10-05%20UAT%20Performance%20Plus%20e%20Gestione%20date%20pagamento.md)
two facts came out that the account inspection could not see.

🔑 **There are two DocuSign accounts.** Aurel Mrruku: _"hanno due account
Elena. Allora, in qualche modo hanno creato un account, poi Docusign ha
aggiunto il loro account."_ The free `DocuSignIt` plan with three envelopes is
the `amministrazione` one, and it is **not** the account to use —
_"Io stavo facendo quella configurazione sugli user di amministrazione, però
no, dobbiamo usare user di Pienissimo, sappiatelo anche voi. Roba molto
importante."_

🔑 **A paid contract exists.** Sabatino Rinaldi, asked directly what it costs:
_"noi abbiamo chiuso un contratto per 2005, cioè abbiamo la disponibilità di
erogare **2500 buste annuali**. Ovviamente poi Docusign ragiona che ogni busta
può avere più preventivi."_ The "2005" is a transcription garble; the figure he
states is 2,500 envelopes a year, one envelope per quote, several documents per
envelope. ⚠ **No document, order confirmation or plan name has been seen** —
this is his spoken statement in a recorded call, which is more than the
project has ever had, and still not the written confirmation this item asks
for.

🟢 **Envelopes completed from production the same afternoon.** `Preventivo
00000002` was sent and reached `Completed` during the UAT (`dse_NA4@docusign.net`
11:31Z, then `dse@eumail.docusign.net` 12:55Z–13:13Z), and `Preventivo
00000003` completed at 15:14Z, forwarded by Anita Aga. The round trip works
against the client's production account.

⚠ **Retries.** Six copies of the quote-acceptance mail and four `Completed`
notices went out for quote 00000002 between 11:30Z and 13:13Z. Whatever caused
the repeats spends envelopes from a counted allowance, and Aurel Mrruku's own
intent is _"cercherò di usare il meno possibile Docusign in produzione perché
costa."_

🔴 **Still open:** the morning of 05/10 began with the production account
unreachable — _"username password non vanno bene"_ — which cost Aurel Mrruku a
clean end-to-end run and five hours. And the integration key's origin remains a
ROMI developer's personal demo account. The ask is no longer "buy a plan"; it
is **which of the two accounts is contractually the client's, and who
administers it.**
