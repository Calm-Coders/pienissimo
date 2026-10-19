---
id: OI-246
type: open-item
status: open
owner: Elena Spini
with: Marco Montesi
org: both
raised: 2026-10-15
updated: 2026-10-16
depends_on: [OI-240, OI-186]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-10-15 Migrazione e Go-Live.md
---

# OI-246 - Key User training cannot be completed before the new go-live

**The client's product lead said on the record that seven or eight commercial
staff cannot be trained between 15 October and 2 November, and that he can only
sign off the administrative half. ROMI's plan, sent two hours later, schedules
the training into those two weeks and says nothing about the objection.**

Stated at [the 15/10 session](../meetings/2026-10-15%20Migrazione%20e%20Go-Live.md)
(`00:10`, `00:40`–`00:45`).

## What the client said

Fabrizio Paganelli, twice:

> _"se noi vogliamo iniziare a usare Sales force il due, quindi con tutto il
> ciclo degli ordini, la fatturazione eccetera eccetera, bisogna che tutte le
> persone internamente siano formate su questo e da oggi che il 15 di ottobre al
> 2 di novembre non ce la facciamo … Non non ce la facciamo a a formare 7-8
> persone che ci sono di là nel commerciale ad utilizzare Sales Force entro il 2
> di novembre."_

> _"son sicuro che per il due non ce la facciamo, dai. Però, ecco, lavoriamo per
> quello, però non illudiamoci di riuscire a farcela."_

And on the limit of what his own sign-off is worth:

> _"Va bene anche che il 27 ci diciamo sì andiamo in go[-l]ive oppure no … però
> bisogna che anche le altre persone … abbiano l'utenza e siano in qualche modo
> formate nell'utilizzo della piattaforma perché sennò te lo dico io, sì, ma te
> lo dico solo lato ordini e fatturazione che è un po' limitativo."_

🔑 **So the 27 October Go/No-Go would be given by two people, for one third of
the system.** Fabrizio Paganelli is confident he and Elisa Migliano can finish
the administrative tests in the week 19–23 October. Rebecca Marmo, Marco Montesi
and Sabatino Rinaldi have no login at all.

⚠ **Capacity is the stated cause, and he put it bluntly**: _"Siamo solo io e
lei"_ — he and Elisa Migliano are the whole administration, and _"ci siamo
trovati a fare i call da soli, a portare avanti il progetto da soli
praticamente"_. He was explicit that the remark was aimed at his own side.

## ROMI's plan for it

**Train the trainer.** Elena Spini: show the platform to one master user who then
teaches the agents, rather than running group sessions — _"io, Aurel, anche voi,
insomma una call in cui facciamo vedere a Marco come dovrà fare dal due in
avanti i preventivi, … e poi sarà lui a insegnare direttamente agli utenti"_.
Her reason is that she would use vocabulary the users do not have, where Marco
Montesi can give _"esempi un po' più concreti e reali nei casi d'uso"_.

The shape, as proposed in the room:

| When            | What                                                     |
| --------------- | -------------------------------------------------------- |
| Mon **19/10**   | Elena Spini and Marco Montesi one to one, lead flow      |
| 19–23/10        | Fabrizio Paganelli and Elisa Migliano finish admin tests |
| **26–30/10**    | dedicated training sessions, _"se volete"_               |
| **27/10**       | Go/No-Go                                                 |
| **02/11**       | go-live                                                  |

_"abbiamo comunque ore di formazione a disposizione"_ — contracted training
hours exist. ⚠ **How many, and whether they cover eight users, is in no source
this repository holds.**

Fabrizio Paganelli accepted the shape conditionally and pushed the decision to
the right person: _"anche qui ti dovrebbe rispondere Marco e non io"_.

## 🔴 Why it is a gating row

1. **The written plan does not carry the objection.** The 17:35:47Z mail
   ([OI-243](OI-243%20Go-live%20moved%20from%2021%20October%20to%202%20November.md))
   presents the two weeks as _"per svolgere le sessioni di formazione dedicate ai
   Key User"_ and asks only for acknowledgement. The client has not been told
   that ROMI heard him say it will not fit.
2. **Training depends on users, which depend on profiles, which do not exist.**
   [OI-240](OI-240%20Marco%20Montesi%20needs%20a%20Salesforce%20user%20before%20go-live.md)
   is answered only by giving Marco Montesi **System Admin** as an interim, and
   [OI-186](OI-186%20The%20Salesforce%20user%20list%20and%20profiles%20were%20never%20agreed%20with%20the%20client.md)
   records that the user list and profiles were never agreed. **Training eight
   commercial users on a profile nobody has defined cannot start**, and Aurel
   Mrruku named exactly that as the hard part: _"le cose che io mi aspetto che
   siano difficili da spiegare [sono] i campi che non vedono, oppure se abbiamo
   dato qualche permesso in più, qualche permesso in meno."_
3. **The same two weeks carry the test completion, the permissions build, the
   production deployment and the migration rehearsal.** They are not two weeks of
   training.
4. ⚠ **Marketing is held back from autonomous testing** in the same session —
   configuration unfinished — so one of the three audiences cannot even begin.

Closing it means a named training schedule with Marco Montesi's agreement, a
profile for the users being trained, and either a date the client accepts or a
recorded decision to go live with the commercial team untrained.

## 🟢 2026-10-16 — ROMI wrote the objection down, and the training window is now dated

Elena Spini's `#tproj-pienissimo` status (16/10 19:20 CEST) does two things this
row was waiting for.

🟢 **It records Fabrizio Paganelli's objection in a ROMI-side written source**,
where previously it existed only in the 15/10 transcript:

> _"Fabrizio P. in call si è preso il ritardo, ma è il primo a dire che forse
> per il 2 non ce la fanno."_

🟢 **It dates the training**, which the project plan did not:

| Window | Dates |
| --- | --- |
| Key-user tests | **19–23 October** |
| Training | **26–30 October** |
| Go/No-Go | **by 27 October** |
| Go-live | **2 November** |

### 🔴 What the dates expose

🔑 **Go/No-Go falls on 27 October — the second day of a training week that runs
to the 30th.** So the decision to go live is taken with training four days from
finished, which is the same ordering problem this row was raised about, now with
dates attached.

🔴 **The capacity objection is untouched.** Fabrizio Paganelli's _"non ce la
facciamo a formare 7-8 persone"_ gets a five-day window for 7–8 people across
orders, invoicing, commercial and marketing. Nothing says how the five days are
divided, by whom, or whether the people are available.

🔴 **The contracted training hours are still unknown** — second run on the
unreachable list — so nobody can say whether 26–30/10 is enough or even
purchased.

🔴 **Whether Marco Montesi accepts the train-the-trainer role is still
unanswered**, second run. He was invited to the 16/10 session and did not
attend; his own first access is now **19/10 15:00**
([OI-240](OI-240%20Marco%20Montesi%20needs%20a%20Salesforce%20user%20before%20go-live.md)),
**the first day of the key-user test week he would be training people for.**

⚠ **And the sign-off perimeter is unchanged.** Fabrizio Paganelli can approve
only orders and invoicing. The 16/10 session showed the marketing flows to
Sabatino Rinaldi, Matteo Distaso and Rebecca Marmo for the first time — so three
more people have now seen a flow they cannot sign off, and **none of them has a
login.**
