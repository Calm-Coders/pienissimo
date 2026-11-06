---
id: OI-345
type: open-item
status: resolved
owner: Elena Spini
with: Marco Montesi
org: both
raised: 2026-11-06
updated: 2026-11-06
depends_on: [OI-300]
blocks: []
source: Gmail 1a1b0134c558b416, 2026-11-06T08:56:56Z
---

# OI-345 - Lead qualification was blocked in UAT because the tutor users had no agent code

**The six UAT tutor users created the previous evening were created without agent
codes. Marco Montesi and all six tutors found on the morning of 6 November that
lead qualification would not let them enter the agent, which is mandatory, so the
flow stopped there. Elena Spini named the cause as her own error and fixed it
within eighty minutes.**

## The sequence

| Time (CET) | Who | What |
| --- | --- | --- |
| 05/11 ~19:13 | Elena Spini | six UAT tutor users activated ([OI-300](OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md)) |
| **06/11 09:56** | **Marco Montesi** | reports the block, for himself and the tutors |
| 06/11 11:17 | Elena Spini | cause and fix stated |
| 06/11 11:24 | Marco Montesi | _";-))"_ |

**Marco Montesi**, Gmail `1a1b0134c558b416`, **08:56:56Z**, to Elena Spini, cc
Fabrizio Paganelli, `amministrazione@` and Aurel Mrruku:

> _"Ho notato pero, sia da loro ma anche da me, che al momento della **qualifica
> del lead non mi fa inserire l'agente**, bloccando il proseguimento delle azioni
> dato che e obbligatorio._
>
> _Puoi verificare?"_

**Elena Spini**, `1a1b05ce690014d8`, **10:17:09Z**:

> _"**Errore mio**, avevo creato le utenze senza i codici agenti ieri sera, quindi
> ora sono visibili e potete riprovare."_

⚠ Two screenshots were attached to the thread (`1.png` and
`Immagine 2026-10-27 133550.png`); **neither was opened** and nothing here rests
on them.

## What it says beyond itself

1. 🟢 **The fix was ROMI-side data, not a build defect.** The agent is mandatory
   at qualification by design; the users simply had no code to pick, so the
   lookup was empty.
2. 🔑 **The user-creation procedure omitted the agent code**, and the omission
   surfaced only because six people tried to use the org the next morning. The
   same six users were created against a licence ceiling the night before
   ([OI-341](OI-341%20The%20UAT%20org%20ran%20out%20of%20Salesforce%20licences.md)),
   under time pressure, with other UAT users deactivated to make room.
3. 🔴 **Production users do not exist yet.** When they are created for the
   16 November start, the same field has to be set, and
   [OI-332](OI-332%20The%20account%20import%20keys%20on%20the%20Salesforce%20agent%20code%20and%20the%20client%20file%20is%20mis-coded.md)
   records that the seven-agent code list has never been supplied by the client.
   ⚠ **Which codes Elena Spini used on 6 November is not recorded**, and no
   source in this window states where they came from.
4. 🟢 **This is the first time the tutors exercised the org themselves**, two
   working days before their training, and the first thing they touched failed.
   🟡 Nothing else was reported by them in this window.

## What is owed

- The seven agent codes as a stated list, from the client (OI-332), so Prod user
  creation does not repeat this.
- Confirmation that the six tutors completed the MFA/passkey setup before the
  9 November training — asked for on 5 November, unreported.
