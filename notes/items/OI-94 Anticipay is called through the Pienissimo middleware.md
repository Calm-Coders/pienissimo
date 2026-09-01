---
id: OI-94
type: open-item
status: open
owner: Andrea Parmeggiani
with: Aurel Mrruku
org: both
raised: 2026-08-25
updated: 2026-09-01
depends_on: [OI-73]
blocks: [OI-73, OI-105, OI-106, OI-107, OI-108]
source: notes/meetings/2026-08-25 Integrazione Anticipay.md
---

# OI-94 - Anticipay is called through the Pienissimo middleware

> 🟢 **The technical contract is now in the record.**
> `Documentazione API - Salesforce.pdf` was read on **2026-09-01** and decoded at
> [the Anticipay middleware API contract](../The%20Anticipay%20middleware%20API%20contract.md).
> Read that note for the endpoint, the field list and the errors; this item keeps
> the decision and its consequences. The 1 September section at the foot records
> what the document changed.

**Decided 2026-08-25, with the client.** Salesforce does **not** call Anticipay.
It calls an API exposed by **Pienissimo Software Srl**, which sits in front of
Anticipay, caches the results and returns a standardised payload.

Two reasons were given and both were accepted:

1. **Cost.** Andrea Parmeggiani raised it — Anticipay charges per lookup, and
   Pienissimo already holds much of the data. The middleware stores what it
   fetches so the same VAT number is not paid for twice.
2. **Insulation.** Aurel Mrruku added it — if Anticipay changes its endpoints,
   only the middleware has to move, not the Salesforce integration.

## The contract, as far as it is agreed

Everything in this table still holds. The **Documented 2026-09-01** column adds
what the API specification says, and marks the two rows where the document goes
further than the session did.

| Element       | Agreed 2026-08-25                                                                                          | Documented 2026-09-01                                                                                                                                                                                        |
| ------------- | ---------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Caller        | Salesforce                                                                                                 | unchanged                                                                                                                                                                                                    |
| Callee        | Pienissimo Software middleware — **not Anticipay**                                                         | `GET https://integration.pienissimo.com/salesforce/account/:env/:piva`                                                                                                                                       |
| Trigger       | first Order inserted for an Account                                                                        | not addressed — a caller concern                                                                                                                                                                             |
| Auth          | a **token in the HTTP request header**                                                                     | `Authorization: Bearer <token>`, **one static token for both environments** ([OI-106](OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md))                                 |
| Errors        | `404` = VAT number not found · `500` = generic; **code and descriptive message both returned**             | ⚠ **also `400` and `401`, neither ever discussed**; and **no error body is specified at all** ([OI-107](OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)) |
| Error storage | codes and messages **saved in Salesforce and kept for three months**                                       | not addressed — a ROMI concern                                                                                                                                                                               |
| Error use     | raise **internal notifications** from the stored record                                                    | not addressed — a ROMI concern                                                                                                                                                                               |
| Conflicts     | the value returned **overwrites** what Salesforce holds                                                    | not addressed — a ROMI concern                                                                                                                                                                               |
| Payload       | trimmed to the needed fields — see [OI-95](OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md) | **eleven fields, fixed**; six of them personal data ([OI-108](OI-108%20The%20Anticipay%20payload%20carries%20personal%20data%20of%20the%20legale%20rappresentante.md))                                       |
| Environments  | a dedicated test environment would be created                                                              | ⚠ delivered as **`:env=test` on the same host, same token**                                                                                                                                                  |

Field-level detail is in
[the contract](../The%20Anticipay%20middleware%20API%20contract.md), not here.

## What is owed, and by whom

- **Andrea Parmeggiani owes the API structure example**, error codes included.
  He committed to **the end of the week commencing 31 August** — so on or before
  **Friday 4 September**. A follow-up call is booked for **Tuesday 1 September
  10:00 CEST**, cancellable if the material lands first.
- **Pienissimo Software owes the test environment.** ROMI's own test environment
  already exists — it is the UAT org — so what is missing is **theirs, for ROMI
  to point at**. The Gemini minute assigns this to Aurel Mrruku; that is wrong
  and was corrected by him on Slack the same afternoon, with Elena Spini
  accepting the correction. **The client-facing calendar invitation still carries
  the wrong wording** and has not been re-sent.

Nothing can be built against this until the payload example arrives. There is no
endpoint, no schema and no token yet.

## 🔴 Why this is more than a technical choice

A **Fase 1** integration now has a **hard build dependency on Pienissimo Software
Srl** — the separate legal entity ROMI argues is not this project's client, and
which sits at the centre of
[the phase 2 scope dispute](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md).

Until 25 August the crossover was only that
[Andrea Parmeggiani](../people/Andrea%20Parmeggiani%20-%20Pienissimo%20Software%20maintenance%20manager.md)
was the named contact. Now Fase 1 cannot go live unless Pienissimo Software
**builds and hosts a service**, stands up a test environment for it, and keeps
it running. Nobody in the session named the entity question, and no note in the
record says who pays for that work or who owns the middleware's uptime once the
project closes.

Elena Spini restated the corporate structure on Slack the same morning, so the
distinction is live in her mind: _"La loro società è Pienissimo SRL che
rivenditore del software Pienissimo Pro, di proprietà di un'entità legale
distinta, Pienissimo Software SRL."_

**This needs Elena Spini or Aurel Mrruku, not a developer.** It is a commercial
question wearing an architecture diagram.

## What it does not change

The business rule in
[OI-73](OI-73%20VAT%20validation%20moves%20into%20Salesforce.md) is untouched —
the VAT check still fires at the first order of an Account, still writes back to
the account, still notifies administration on failure. Only the counterparty on
the wire changed. The `consolidato` flag, the manual re-check button and the
administration address Pienissimo still owes all stay as recorded there.

## 2026-08-31 - the documentation arrived, four days early

🟢 **Andrea Parmeggiani delivered.** Mail _"Pienissimo - Documentazione API per
chiamata informazioni aziende"_, **31 August 16:15Z**, to Aurel Mrruku, cc Elena
Spini, `amministrazione@pienissimo.com`, Fabrizio Paganelli and Sabatino
Rinaldi, carrying one attachment: **`Documentazione API – Salesforce.pdf`**.

He owed this by **Friday 4 September** and sent it on Monday 31 August — the
first client commitment on this project delivered ahead of its date. The
follow-up call booked for **1 September 10:00 CEST** was made cancellable
precisely on this condition; it is now the meeting's own decision whether to run.

⚠ ~~**The attachment has not been read.**~~ **Superseded 2026-09-01 — it has now
been read**, and a second, updated version arrived the same morning. See the
1 September section below. The paragraph is kept because it records what the
31 August sweep could and could not see.

⚠ **The attachment has not been read.** This sweep can see that the PDF exists
and who it went to; it cannot open a Gmail attachment. Everything below comes
from the **mail body**, which is short and substantive. The PDF is the API
contract and it remains unread — the same shape of gap as the WooCommerce
payload attachment on 27 August, which sat unopened for a day until Aurel Mrruku
downloaded it by hand. **It should be opened before the 1 September call**, and
the contract folded into [OI-95](OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md)
and into this table.

### 🔴 The test period has different semantics from production, and nobody has recorded that until now

Andrea Parmeggiani's own words: _"Per il momento l'API ritorna i dati solamente
se già presenti sul nostro database, evitiamo di fare richieste ad Anticipay per
questo periodo di test, alla fine del test invece inoltreremo le chiamate ad
Anticipay e per voi sarà trasparente."_

|                                       | During the test period                    | After it                           |
| ------------------------------------- | ----------------------------------------- | ---------------------------------- |
| Middleware behaviour                  | serves **only from the Pienissimo cache** | forwards a miss on to Anticipay    |
| A VAT number they do not already hold | **returns nothing**                       | returns Anticipay's answer         |
| Change required on the ROMI side      | none — the switch is theirs               | none, _"per voi sarà trasparente"_ |

This is new. The 25 August contract in the table above describes the **production**
behaviour and says nothing about a cache-only test mode. Two consequences follow
and neither has been discussed:

- 🔴 **A test that queries an unknown VAT number will look like a `404`
  when it is really "not cached yet".** The agreed error semantics give `404` a
  single meaning — _VAT number not found_ — and during the test period it will
  carry two. Any test evidence gathered before the switch cannot distinguish a
  genuine unknown company from a cold cache, so **do not treat test-period `404`
  rates as a measure of Anticipay's coverage.**
- The switch from cache-only to pass-through is **Pienissimo Software's to
  flip**, on a date nobody has named. ROMI has no signal for when it happens and
  no way to detect it from the outside. Ask for the date, and ask to be told when
  it is done.

Neither point invalidates anything already agreed — the counterparty, the
trigger, the header token, the three-month error retention and the overwrite rule
all stand as recorded. It narrows what the **first round of testing can prove**.

## The design file records the change on one page and not the other

`Flows & Objects.drawio` was edited **during the call** (2026-08-25T08:23:31Z,
10:23 CEST). The **LEAD-OPTY** page now reads _"chiamata API **al middleware
Pienissimo** per check P.IVA Account"_ — while the **Ordini** page still reads
_"chiamata API **Anticipay**"_. See
[the newest design diagram](../The%20newest%20design%20diagram.md). The master
now contradicts itself on this rule; the LEAD-OPTY wording is the later and
correct one.

## 2026-09-01 - the document was read, and a second version arrived the same morning

🟢 **The API contract is in the record.** Aurel Mrruku downloaded the PDF at
**12:51 CEST** and it was decoded the same session into
[the Anticipay middleware API contract](../The%20Anticipay%20middleware%20API%20contract.md).
The blocker that has stood since 25 August — _"nothing can be built against this
until the payload example arrives"_ — **is discharged on the happy path.**

**Andrea Parmeggiani sent a second version at 10:46:38Z**, in the same thread:

> _"Ho aggiunto un parametro `:env` nel path, prevede un valore tra 'test' e
> 'prod', in allegato la documentazione aggiornata."_

So the contract moved **twice in seventeen hours**, and the version ROMI holds is
the second. Nothing has been built yet, so no rework — but it is a reminder that
this specification is being written as it is read, and that **the endpoint is not
frozen**. Ask at the call whether further changes are expected before build.

### What the document settles

- **The endpoint exists**, with a shape, an auth scheme and a documented `200`.
- **The field list is fixed at eleven** — which converts
  [OI-95](OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md) from
  "choose from Anticipay's full response" to "choose from these eleven". 🟢 The
  eleven **exactly match** the as-is Mexal lookup Elisa Migliano described on
  6 August — ragione sociale, address, PEC, legal representative.
- **The cache-only test mode is now written into the contract**, not just the
  mail body: `env=test` returns `404` for anything not already in the Pienissimo
  database, and makes no Anticipay call. The 31 August section above stands
  unchanged and is now specification rather than inference.
- 🟢 **The `env=test` mechanism appears to be the "dedicated test environment"**
  owed by Pienissimo Software from 25 August. If so, that action is discharged —
  but as a path parameter on the production host behind the production token,
  which is not what the phrase normally means. **Close it explicitly or restate
  what is wanted**: [OI-106](OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md).

### What it does not settle, and what it newly breaks open

|                                                                                                                     |                                                                                                                                                                                                                                                                                                                                                                                       |
| ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 🔴 [OI-107](OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)     | 🟢 **The three-month error store is `Integration_Log__c` and already works** — an earlier draft of this row wrongly said it could not be built. 🔴 But `Is_Error__c` is **never set for an HTTP error**, so the **internal notification agreed in this item is silent for every `404`**; and a non-matching error body makes the engine drop `Response_State__c`. Both are ROMI-side. |
| 🔴 [OI-108](OI-108%20The%20Anticipay%20payload%20carries%20personal%20data%20of%20the%20legale%20rappresentante.md) | **Six of the eleven fields identify a private individual** — name, codice fiscale, date and place of birth, home address. Not what "trimmed to the needed fields" was understood to mean.                                                                                                                                                                                             |
| 🔴 [OI-106](OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md)                   | **One static token for both environments**, printed in a PDF mailed twice to six addresses including a shared mailbox.                                                                                                                                                                                                                                                                |
| ⚠ [OI-105](OI-105%20The%20Anticipay%20date%20of%20birth%20field%20name%20is%20misspelled.md)                        | `data_di_dascita_legale_rappresentante` — a typo in the wire format. Decide whether it gets fixed **before** anyone codes against it.                                                                                                                                                                                                                                                 |
| ⚠                                                                                                                   | **`400` and `401` are new error codes**, never discussed, and they mean _our call is broken_ rather than _the company is unknown_. The agreed design puts all four in one bucket with one notification.                                                                                                                                                                               |
| ⚠                                                                                                                   | **No rate limit, timeout, retry policy or cache TTL.** The agreed **manual re-check button** in [OI-73](OI-73%20VAT%20validation%20moves%20into%20Salesforce.md) has no documented way to bypass the cache — so a re-check may return the same stale answer.                                                                                                                          |

⚠ **The entity question in the section above is untouched by any of this.** A
Fase 1 integration still depends on Pienissimo Software Srl building, hosting and
running a service, and the document — which is theirs — does not say who owns its
uptime after the project closes. Reading a specification is not the same as
having a commitment.

### The six questions the document raises

⚠ **The 1 September call ran, and this session did not read its minute.** The
calendar event carries a **recording timed 10:02 CEST** and a Gemini notes doc,
so the follow-up went ahead rather than being cancelled. Note also that **v2 of
the documentation arrived at 12:46 CEST — after the call ended at 11:00** — which
makes the `:env` addition plausibly an outcome of the session rather than
something the session had in front of it.

**So treat the list below as questions raised by the document, not as an agenda.**
Every one of them may already have been answered in the room. **Check each against
the minute first; chase only what is genuinely still open.** The recording and the
Gemini notes are attached to the calendar event and neither has been drilled.

In priority order:

1. **The error response body** — one example of each, exactly as emitted
   ([OI-107](OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)).
2. **Which fields Salesforce stores, and a date for that decision** — Fabrizio
   Paganelli and Elisa Migliano have held it since 25 August with no date, and
   have had the list since 31 August
   ([OI-95](OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md),
   [OI-108](OI-108%20The%20Anticipay%20payload%20carries%20personal%20data%20of%20the%20legale%20rappresentante.md)).
3. **The token** — one or two, does it rotate, can it be rotated before go-live
   ([OI-106](OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md)).
4. **The date `env=test` becomes pass-through**, and how ROMI is told.
5. **The `dascita` typo** — fix or freeze
   ([OI-105](OI-105%20The%20Anticipay%20date%20of%20birth%20field%20name%20is%20misspelled.md)).
6. **Rate limits, timeout and cache TTL**, including how the manual re-check
   button forces a refresh.

🔴 **Development on Fase 1 must end 10 September** — seven working days away, and
the answers to items 1 and 2 are what the build waits on.

🔴 **The next action on this item is to drill the 1 September minute**, not to
send questions. The recording and Gemini notes are on the calendar event
(`2j4tg4tglt9iei6285jfn8i62s`); until they are read, nobody knows which of the six
are still open — and a chase for something already settled in the room costs more
credibility than it saves time.
