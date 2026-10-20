---
id: OI-243
type: open-item
status: superseded
owner: Elena Spini
with: Pienissimo
org: both
raised: 2026-10-15
updated: 2026-10-20
depends_on: [OI-246]
blocks: [go-live]
severity: gating
requirement: CTX-02
supersedes: [OI-124]
superseded_by: [OI-268]
source: notes/meetings/2026-10-15 Migrazione e Go-Live.md
---

# OI-243 - Go-live moved from 21 October to 2 November

**On 15 October Elena Spini told Pienissimo in writing that go-live is 2 November
2026, with a Go/No-Go decision due by 27 October, and asked for written
acknowledgement. The register still says 21 October. This is the second move of
the date and the pattern of [OI-124](OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md)
repeats exactly — including that the register does not move until the client
replies.**

## What was decided, and where

Proposed in [the 15/10 session](../meetings/2026-10-15%20Migrazione%20e%20Go-Live.md)
(`00:04`–`00:05`) and sent the same evening at **17:35:47Z**, into the
`[ROMI-PIENISSIMO] - Stato Avanzamento Progetto` thread (Gmail
`1a140a297babe037`) — **the same thread that carried the 6 → 21 October move**.
To Fabrizio Paganelli, `amministrazione@pienissimo.com`, Sabatino Rinaldi and
Marco Montesi; cc Daniela Morgese, Aurel Mrruku, Fabrizio Mastracci.

| Milestone                                   | New date                       |
| ------------------------------------------- | ------------------------------ |
| Test and Key User training                  | the next two weeks (19–30/10)  |
| **Approvazione Fase 1 (Go/No-Go)**          | **_"entro e non oltre il 27/10"_** |
| **Go-Live Effettivo**                       | **02/11**                      |

Her stated reason is the accepted changes, not slippage: _"per poter accogliere
ed implementare le diverse modifiche e richieste nelle ultime settimane (che
abbiamo comunque preso in carico per garantire la massima aderenza alle vostre
esigenze), si è reso necessario riallineare la tempistica operativa."_

In the room it was put as _"martedì 27 go o no go per andare in produzione
effettivamente operativi il due"_, with ROMI moving everything to production
from the 27th onward.

🟢 **The plan deck exists and matches.** `Pienissimo_Project Plan v3.pptx`
(Drive `1Gtkfsj9HHKjdI9ySPwQItpzW3XqOmTBu`, created 13:30:01Z, last saved
17:14:30Z — twenty-one minutes before the mail) carries **"GO-LIVE FASE 1
(02/11)"** and **"Approvazione Fase 1 (entro 27/10) Go/No-Go"**. _"UAT Ready
Fase 1 (entro 23/09)"_ is unchanged. Its Fase 1 integration list is unchanged
(WooCommerce, Mexal, Anticipay, App Info Point — _"solo update QR code in questa
fase"_), as is the Fase 2 exclusion list (GLS, Teachable, Ordini Pienissimo Pro).
v1 and v2 of the deck were also re-saved the same afternoon, 13:31 and 13:38.

## 🔴 What comes with the date: the scope is frozen

The mail adds a constraint the session only gestured at:

> _"Potranno essere presi in carico solo affinamenti minori o piccole correzioni
> puntuali; non potranno pertanto essere accettate o incluse ulteriori modifiche
> sostanziali rispetto a quanto già sviluppato e consegnato. Eventuali nuove
> esigenze o Change Request sollevate durante questo periodo saranno prese in
> carico nella Fase 2, per la quale invieremo un'offerta e un piano di progetto
> dedicati in un thread separato."_

🔑 **That is the first written commitment to send a Fase 2 offer and plan.**
[OI-83](OI-83%20No%20phase%202%20estimate.md) has recorded the absence of a Fase 2
estimate since August and
[the scope dispute](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md)
has been open just as long. ⚠ **It is also a unilateral freeze**: the client has
agreed to no such thing, and the record is full of asks the freeze would now
reclassify — among them
[OI-242](OI-242%20The%20community%20Rinuncia%20button%20must%20show%20the%20public%20refusal%20text.md)
(already deferred to the production rollout),
[OI-238](OI-238%20The%20tacit%20renewal%20path%20skips%20client%20acceptance%20and%20its%20approval%20workflow%20is%20undecided.md)
and [OI-233](OI-233%20Bundle%20access%20for%20tutor%20profiles%20is%20undefined.md).

## 🔴 The client's product lead said in the session that the date will not hold

Two hours before the mail went out, Fabrizio Paganelli said so twice, on the
record, and his reason is training rather than build:

> _"da oggi che il 15 di ottobre al 2 di novembre non ce la facciamo … Non non
> ce la facciamo a a formare 7-8 persone che ci sono di là nel commerciale ad
> utilizzare Sales Force entro il 2 di novembre."_

> _"son sicuro che per il due non ce la facciamo, dai. Però, ecco, lavoriamo per
> quello, però non illudiamoci di riuscire a farcela."_

**None of this appears in the mail**, which presents 02/11 without qualification
and asks only for acknowledgement. See
[OI-246](OI-246%20Key%20User%20training%20cannot%20be%20completed%20before%20the%20new%20go-live.md).

⚠ He is confident about **his own** scope: _"la settimana prossima sono sicuro di
riuscire a finire i test lato amministrativo"_, naming Performance Plus
activation and renewal and the standard sales as already seen. The gap is
everyone else — _"la Rebecca, Marco, Sabatino del marketing, un'utenza, non ce
l'hanno ancora"_.

## 🔴 The consequence nobody in the session mentioned

**Zoho CRM expires 31 October 2026. Go-live is now 2 November.** The dual-run
window is not narrow any more, it is **negative** — a two-day gap in which the
client has neither system in production. The register still states the
assumption as _"Zoho expires 31 October 2026; dual-run window is ~3 weeks"_.

Recorded as
[its own risk](../risks/Risk%20-%20go-live%20now%20falls%20after%20the%20Zoho%20contract%20expires.md).
**Zoho is named nowhere in the session and nowhere in the mail.**

## 🔴 What the register says, and why this sweep did not change it

Unchanged, in the same nine places
[OI-124](OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md) listed:

| Where                                                | What it still says                                                            |
| ---------------------------------------------------- | ----------------------------------------------------------------------------- |
| `REQUIREMENTS.md` / `REQUISITI.it.md` — **`CTX-02`** | Go-live **21 October 2026**                                                   |
| Both documents, priority key                         | `M` = _indispensable for the 21 October 2026 go-live_                         |
| Both documents, milestone table                      | **21 October 2026 — Go-live**                                                 |
| Both documents, §14 Fase 2 rule                      | requests endangering **21 October 2026** are automatically Fase 2 candidates  |
| `requirements/pienissimo-requirements.yaml`          | `go_live: 2026-10-21`                                                         |

**The register was deliberately left alone, on the rule OI-124 established and
the client then validated.** That row's instruction reads: _"The date has been
proposed to the client in writing but **not yet accepted**. This sweep left the
register at 6 October for that reason — the Italian is the operative text and it
is not moved by a mail that is still awaiting reply."_ The register moved on
9 September, the same day Fabrizio Paganelli replied _"presa visione"_.

Tonight the mail is **four hours old and unanswered**. `REQUISITI.it.md` is the
document presented to Pienissimo for signature; it does not move on a proposal.

⚠ **And this time there is a second reason to wait.** In September the client's
only recorded reaction was acknowledgement. This time the client's product lead
has said, before the mail was sent, that the proposed date is not achievable. A
register change made tonight would record as contractual a date one party has
already disputed on the record.

**When the acknowledgement lands**, `CTX-02`, the `M` definition, both milestone
tables, the §14 Fase 2 rule and `go_live:` change **in both languages in the
same session** — and the dual-run assumption at
`requirements/pienissimo-requirements.yaml:469` must change with them.

## What a human has to do

1. **Decide whether `CTX-02` moves now or on the acknowledgement.** The
   precedent says wait; the Zoho gap is an argument for not waiting silently.
2. **Reconcile the mail with what the client said in the room.** One of the two
   is wrong about 2 November and the client has not been told that ROMI heard
   him.
3. **Say what happens to Zoho between 31 October and 2 November**, or get the
   contract extended. Nobody has raised it.
4. **Re-examine the §14 Fase 2 escalation rule for the second time.** It reads
   _"unless the go-live date is explicitly renegotiated"_ — the date has now been
   renegotiated twice, and the 15/10 mail converts the rule into a blanket
   freeze.
5. **Confirm the acknowledgement actually reaches the people who sign.** OI-124
   closed on one reply out of four addressees, and
   [OI-128](OI-128%20Client%20confirmation%20of%20the%2021%20October%20plan%20and%20the%20Fase%202%20perimeter.md)
   records that Daniela Morgese — who signs commercially — was only ever cc'd.
   She is cc'd again.

## 🟡 2026-10-16 — the client has read it; nobody has accepted it

Two acknowledgements of receipt arrived, both weaker than the written reply
[OI-124](OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md)'s rule asks
for.

**1. Verbally, in session.** At the close of
[the 16/10 UAT](../meetings/2026-10-16%20UAT%20Flussi%20MKT%20Biglietti.md)
(`02:09:12`) Elena Spini pressed it and Sabatino Rinaldi confirmed only that he
had seen it:

> **Elena Spini:** _"Considerate che io ieri ho mandato il piano … quindi
> qualsiasi vostra decisione poi mette in discussione il piano. … prendete,
> rivedete la mail, l'ho mandata ieri sera, questo stato avanzamento
> progetto."_
>
> **Sabatino Rinaldi:** _"Ah, sì, sì, sì, sì, l'ho vista prima di entrare in
> call."_

🔑 **That is receipt, not agreement** — and Sabatino Rinaldi is not the person
who disputed the date. **Fabrizio Paganelli was in the same call and said
nothing about it**, having argued the previous day that 02/11 cannot be met
([OI-246](OI-246%20Key%20User%20training%20cannot%20be%20completed%20before%20the%20new%20go-live.md)).
**No reply has been sent in the mail thread**, which is where the 09/09
acknowledgement of the previous move landed.

**2. Internally, in ROMI's own status channel.** Elena Spini, `#tproj-pienissimo`
16/10 19:20 CEST:

> _"Go-live slittato al 02/11 (era il 21/10): ieri (15/10) ho mandato al cliente
> il nuovo piano. Go/No-Go entro il 27/10, settimana del 19/10 per i test dei key
> user, formazione dal 26 al 30/10."_

🟢 **This adds detail the mail did not carry**: the key-user test week is
**19–23/10** and training runs **26–30/10** — so training ends on the Friday
before a Monday go-live, with no buffer.

🔑🟢 **And it records the objection, which the mail to the client did not:**

> _"Fabrizio P. in call si è preso il ritardo, ma è il primo a dire che forse
> per il 2 non ce la fanno."_

So ROMI has written down internally that the client's product lead doubts the
date — see OI-246. ⚠ **It is still not in anything the client has received.**

### The register still does not move

**Unchanged: version stays 1.6, `go_live:` stays `2026-10-21`.** OI-124's rule
is a written acknowledgement in the thread, and what exists is one verbal
_"l'ho vista"_ from a participant who is not the objector, with the objection
itself recorded only on ROMI's side. ⚠ **Moving the register tonight would
record as contractual a date that one party has disputed on the record and no
party has accepted in writing.**

⚠ **Second night this has been deferred.** When the acknowledgement lands, the
nine places listed in the 15/10 trace change in one session, together with
`requirements/pienissimo-requirements.yaml:469`'s dual-run assumption.


## 🔴 2026-10-19 — three client people, 01:45, and nobody said the date

**The strongest negative yet.** [The 19/10 walkthrough](../meetings/2026-10-19%20Test%20UAT%20Commerciali.md)
put **Fabrizio Paganelli, Sabatino Rinaldi, Elisa Migliano and Marco Montesi** in
one call with Elena Spini for 01:45:49, on the first day of the key-user test
week, and **2 November was never mentioned by anyone.** Neither was 21 October.
The only forward-looking commitments made were this week's: the client's own
Friday review and the Wednesday migration meeting.

🔴 **Fabrizio Paganelli — the person who disputed the date — talked about
timetables twice in the session** (declining a ROMI meeting this week, booking
Wednesday) **and did not refer to go-live either time.** The mail thread remains
unanswered.

🔴 **So the register was deliberately not moved a fourth night.** OI-124's rule is
a written acknowledgement in the mail thread. What exists is still one verbal
_"l'ho vista prima di entrare in call"_ from Sabatino Rinaldi on 16/10, from
someone who is not the objector. **Moving `go_live:` to 2026-11-02 tonight would
record as contractual a date one party disputed on the record and no party has
accepted in writing** — and it would be the second contract-bound date to move
without the client's signature in two weeks.

⚠ **The window is closing on the ordinary reading.** Today is 19 October; the
signed date is 21 October, two days away. **From 22 October the register will
state a go-live that has demonstrably not happened**, which is a different and
worse kind of wrong than stating a date the client has not yet acknowledged.
When the acknowledgement lands — or on 22 October, whichever comes first — the
nine places listed in the 15/10 trace change in one session, plus
`requirements/pienissimo-requirements.yaml:469`'s dual-run assumption.

## 🔴 2026-10-20 — superseded: the client proposed 16 November instead

**This row's date never received the written acknowledgement it asked for, and on
20 October the client replaced it with a calendar of their own.** 2 November was
proposed on 15 October and was never accepted, disputed, or acknowledged in any
source. It is now overtaken.

Tracked from here as
[OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md).
`status:` moves to `superseded`; the row stays because its numbering is cited in
the client-facing tracker and because two of its findings outlive the date:

1. 🔴 **The unilateral Fase 1 scope freeze is still unilateral**, and two more
   pieces of new build scope have landed since
   ([OI-250](OI-250%20The%20reminder%20wait%20intervals%20must%20be%20configurable%20per%20edizione.md)
   at 15 interval fields,
   [OI-269](OI-269%20Event%20communications%20must%20be%20differentiated%20by%20ticket%20type.md)
   the ticket-type communications) without either being called a change request to
   the client. A third,
   [OI-259](OI-259%20A%20lost%20lead%20marked%20non%20interessato%20must%20carry%20a%20mandatory%20free%20text%20reason.md),
   **was** called a CR internally — _"digli che è una CR"_ — and the client was
   not told.
2. 🔴 **The written commitment to send a Fase 2 offer and plan is unmet.** The only
   internal artefact is the unshared draft described in
   [the 20/10 call](../meetings/2026-10-20%20Follow-up%20Interno.md), which still
   carries **21 October** as the go-live.

🔑 **And the Go/No-Go of 27 October has quietly lapsed.** This row set
_"Approvazione Fase 1 (Go/No-Go) entro e non oltre il 27/10"_. The client's new
calendar does not mention a Go/No-Go at all, and no source replaces it. **A
decision gate that both parties have stopped referring to is not a gate.**
