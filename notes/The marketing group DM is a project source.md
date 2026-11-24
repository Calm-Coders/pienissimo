---
id: ref-mkt-group-dm
type: reference
status: active
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-29
updated: 2026-11-24
---

# The marketing group DM is a project source

**Slack group DM `C0C38JJ9D1T`, named "PIENISSIMO - Interna" — Aurel Mrruku, Elena
Spini, Fabrizio Mastracci. Created 24 September 2026. No sweep before 29/09 listed
it, and it held the mechanism behind a five-week-old blocker.**

## Why it was missed

`requirements-check` step 3 names `#tproj-pienissimo` and "direct messages". The
prior runs read **Elena Spini's DMs** by `from:` filter, which surfaces her messages
wherever they are — but a `from:` sweep of one person cannot show a conversation's
shape, and the two messages it did return on 24–25/09 read as scheduling chatter.
**Reading the conversation is not the same as matching its author.**

This is the second retrieval correction in two nights, after
[the channel](The%20Pienissimo%20Slack%20channel%20and%20its%20id.md).

## What it held

- 🔑 **Marketing Cloud cannot be installed in the UAT sandbox** — Fabrizio
  Mastracci, 24/09, discovered with Carol on 23/09. The mechanism behind
  [OI-134](items/OI-134%20The%20marketing%20flows%20cannot%20be%20tested%20before%20a%20production%20release.md),
  which had described the symptom.
- **Aurel Mrruku's 25/09 refusal** to push developments to production —
  _"sarebbe un doppio lavoro di pulizia"_ — reversed four days later.
- **The Business Blueprint's Drive id**, posted 24/09 20:12 CEST with _"Habemus
  BPP"_: `1oa5iIHxu86wx6v7qZaBjM7g5Sk7bmuK9`. See
  [OI-179](items/OI-179%20The%20Business%20Blueprint%20goes%20to%20the%20client%20with%20unchecked%20points.md).
- **`Event_Invitation__c`'s field list**, pasted as a working SOQL query by Aurel
  Mrruku on 24/09: `Account__c`, `Campaign__c`, `Last_URL_Error__c`,
  `Recipient_Contact__c`, `Registration_Url__c`, `Send_After__c`, `Status__c`,
  `URL_Refreshed_At__c`, `URL_Status__c`.
- **The link to the participation document**, 29/09 10:05 CEST — the find behind
  [OI-194](items/OI-194%20The%20ticket%20is%20a%20signed%20participation%20document%20not%20just%20a%20QR%20code.md).

## It is now the project's only live channel

🔑 **Since the contestation it carries the project on its own.** On
**20/11** it held 33 messages, including ROMI's PEC reply pasted verbatim
([OI-379](items/OI-379%20ROMI%20replied%20to%20the%20PEC%20and%20contested%20it%20in%20full.md))
and the outcome of the 14:30 client meeting
([OI-380](items/OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md)).
On **23/11** its single message - Elena Spini at 18:44:29 CET, on Angelo
Pastorelli's evening call with the client's direction - was **the only
Pienissimo-relevant message in any source for three days**, with
`#tproj-pienissimo` silent and Gmail unreachable. ⚠ A conversation nobody
minutes is now the project's primary record.

### 2026-11-24 - it stopped being the only one, and lost the day's substance

🟢 **`#tproj-pienissimo` broke five days of silence on 24/11**, and that is where
the day's two decisions are: Angelo Pastorelli ordering the dashboards live and
the training proposals sent, and the deploy consent Elena Spini then asked him
for ([OI-381](items/OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md)).

🔴 **What landed in this DM instead was the call itself** — _"ho appena finito
una call, ci colleghiamo al volo tutti?"_, 17:11:06 CET, and _"5 min"_ — the
follow-up that delivered the briefing promised for 24 November. ⚠ **Four chat
lines are the entire record of it**; no recording, no transcript, no notes
([OI-380](items/OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md)).
🔑 So the pattern holds in a new form: the channel carries the decisions, and
this DM carries the fact that an unminuted call happened.

## Standing instruction

**Read `C0C38JJ9D1T` directly on every sweep**, alongside `C0B5T3RB4FM`
(`#tproj-pienissimo`) and `C0BQD34LLF4` (the dev group). It is where the marketing
workstream actually talks, and the marketing workstream is most of what is left.
