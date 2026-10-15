---
id: OI-243
type: open-item
status: open
owner: Elena Spini
with: Pienissimo
org: both
raised: 2026-10-15
updated: 2026-10-15
depends_on: [OI-246]
blocks: [go-live]
severity: gating
requirement: CTX-02
supersedes: [OI-124]
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
