---
id: OI-384
type: open-item
status: open
owner: Aurel Mrruku
with: Anita Aga, Davide Losco
org: ROMI
raised: 2026-11-24
updated: 2026-11-27
depends_on: [OI-376]
blocks: [fase-2]
severity: high
uncertain: no source says the reallocation was agreed with Anita Aga, approved by anyone above Aurel Mrruku, or made formal - it is an offer made in a one-to-one chat and accepted in principle by the receiving project; the start date and the share of her time are unstated
source: Slack D0CEWML860G 2026-11-24 14:40-15:34 CET
---

# OI-384 - Anita Aga is being reallocated off Pienissimo while Fase 2 is stopped

**The freeze has started to cost the project its team. On 24 November Aurel
Mrruku offered Anita Aga to another ROMI project, on the express premise that
Pienissimo Fase 2 will not start. She is the developer who built the reports and
dashboards that are the project's only live work, and the author of the open pull
request that has to be merged before they can be released.**

## What was said

Aurel Mrruku to Davide Losco, in their direct message, at **15:06:00 CET**:

> _"**Ho anita che in teoria se non parte pienissimo fase 2 e libera**"_

The context is a departure on another ROMI project, which Aurel Mrruku reported
in the same conversation at **14:40:20 CET** and for which he offered to put a
second resource alongside — _"stavo pensando di affiancare un altra risorsa se
per te va bene"_, and failing that _"se no faccio tutto io"_. Davide Losco
accepted in principle at **14:54:20**: _"si certo per me va bene chi ci puoi
mettere, capiamo un attimo come renderlo operativo"_, and at **15:33:52**,
_"penso vada bene"_. ⚠ **The person who left is named in the cited messages and
is deliberately not copied here** — it is another project's staffing matter and
personal to them; what belongs to this project is only the consequence for Anita
Aga's availability.

| | |
| --- | --- |
| Premise | 🔴 **That Pienissimo Fase 2 does not start** — stated as a conditional, _"in teoria"_ |
| Where it was decided | A one-to-one Slack DM between two ROMI project leads |
| Agreed with Anita Aga? | 🔴 **No source says so** |
| Approved above Aurel Mrruku? | 🔴 **Nothing recorded.** Neither Angelo Pastorelli nor Gianpaolo Motta appears in the exchange |
| Start date, share of her time | 🔴 **Unstated** |

## Why it matters to this project

1. 🔴 **She is the only person who has built anything on Pienissimo since 19
   November.** The five dashboards and nine reports of
   [OI-377](OI-377%20Reports%20and%20dashboards%20were%20never%20built%20and%20have%20no%20requirements.md)
   are hers, built by hand in a day, and
   **PR [#132](https://github.com/Calm-Coders/pienissimo/pull/132)** from
   `DevAnita19` is hers and still open.
2. 🔴 **That release is scheduled for 25 November by 12:00**
   ([OI-381](OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md)),
   and the open items attached to it — who may see the reports, whether the
   client tests them, the tranche report schedule due before month end — are all
   work on her build.
3. ⚠ **It converts the freeze into a staffing fact.** On 19 November she was told
   _"di non toccare piu niente su pianissimo"_ and described as _"libera ormai"_
   ([OI-376](OI-376%20All%20Pienissimo%20work%20is%20frozen%20except%20reports%20and%20dashboards.md));
   on 24 November that availability is being spent. 🔑 **If Fase 2 restarts,
   the capacity assumed for it is already promised elsewhere.**
4. ⚠ **It is a planning assumption about a decision nobody has taken.** Fase 2 is
   contested by the client in the PEC
   ([OI-375](OI-375%20Pienissimo%20sent%20a%20PEC%20contesting%20the%20implementation%20and%20suspending%20the%20go-live.md))
   and ROMI's own direction has not ruled on it
   ([OI-380](OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md)).
   This is the first source in which ROMI acts as though Fase 2 will not happen.

## What is owed

- 🔴 **A decision, by someone who can take it, on whether Anita Aga stays
  assigned to Pienissimo** until the reports release and the Fase 2 ruling are
  settled.
- 🔴 **Confirmation that she is not moved before PR #132 is merged and the
  release and its follow-ups are closed.**
- **The start date and the share of her time**, if the move goes ahead.
- **Whether Angelo Pastorelli and Gianpaolo Motta know**, given that Fase 2's
  fate is theirs to rule on.

## 🟢 Update 2026-11-25 - she was still on Pienissimo today, and the release she owned is closed

🟢 **The first thing this note said was owed has effectively happened**: PR #132
was **merged at 18:10:26 CET** and the reporting release reached production at
**18:19:59 CET**, with the follow-up commit `006e830` **"Deploy Production"**
authored by **Anita Aga** at 18:26 CET →
[OI-381](OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md).
**She was not moved before it closed**, and the repository now has no open pull
request.

🔴 **Everything else is unmoved.** No source in this window mentions the
reallocation: the DM where it was offered (`D0CEWML860G`) has **no new
messages**, and a Slack search on her name across the window returns **0
results**. So:

- 🔴 **Still not agreed with her** in any source.
- 🔴 **Still not approved above Aurel Mrruku** — and Fase 2's fate remains
  Angelo Pastorelli's and Gianpaolo Motta's to rule on.
- 🔴 **Still no start date and no share of her time.**
- ⚠ **The premise has not changed, and it is now weaker-looking**: ROMI told the
  client on 25 November that it will plan **a new migration**
  ([OI-385](OI-385%20A%20scope%20perimeter%20call%20and%20a%20new%20migration%20are%20planned%20for%2030%20November.md)),
  which is work, while the staffing plan assumes _"se non parte pienissimo fase 2
  e libera"_.

⚠ **The follow-ups the release left open are hers in practice** — the tranche
report schedule, due before month end, and whatever the client acceptance test
turns into.

## 🔑 2026-11-27 - the move has a date: she starts on the other project on 1 December

🔑 **The start date this note has asked for twice now exists, and it was agreed in
the same one-to-one channel as the offer.** Davide Losco to Aurel Mrruku, direct
message `D0CEWML860G`:

| Time CET | Who | Said |
| --- | --- | --- |
| **15:58:57** | Davide Losco | _"Ciao **Abilito Anita a VFL1 su clockify** ok?"_ |
| **16:38:26** | Aurel Mrruku | 🔑 _"ciao **ok** , fino il 30 non mette niente"_ |
| **16:38:35** | Aurel Mrruku | 🔑 _"**poi dal 1 inizia lei**"_ |

So: **time booking on the receiving project is enabled, Aurel Mrruku approved it,
and Anita Aga starts there on 1 December**, with nothing booked until 30 November.
⚠ The receiving project is named in the messages as `VFL1`; it is another ROMI
client and nothing further about it belongs in this record.

🔴 **The two gaps that remain are the ones that matter:**

- 🔴 **Still not agreed with her in any source.** She does not appear in the
  exchange, and no message from her is on the record.
- 🔴 **Still not approved above Aurel Mrruku.** Fase 2's fate is Angelo
  Pastorelli's and Gianpaolo Motta's to rule on; neither appears, and neither has
  ruled.
- ⚠ **The share of her time is still unstated** - _"dal 1 inizia lei"_ says when,
  not how much.

🔴 **The premise was contradicted the same afternoon.** Three hours after this
exchange, ROMI published a weekly status planning **a new migration and a new
start date** for Pienissimo at the client's own request
([OI-387](OI-387%20The%20client%20is%20not%20using%20Salesforce%20and%20has%20asked%20for%20a%20new%20import%20and%20a%20new%20start%20date.md)),
and left both the project close date and the days-to-finish _"da definire dopo la
call del 30/11"_. The staffing decision rests on _"se non parte pienissimo fase 2
e libera"_; **the project it frees her from has just acquired unscoped work.**

⚠ **1 December is also the day the final marketing check runs in production**, and
the day Aurel Mrruku has twice said he is absent
([OI-385](OI-385%20A%20scope%20perimeter%20call%20and%20a%20new%20migration%20are%20planned%20for%2030%20November.md),
[OI-378](OI-378%20Marketing%20training%20is%20undelivered%20and%20the%20client%20did%20not%20attend%20the%20final%20test.md)).
**From 1 December this project has neither of them.**
