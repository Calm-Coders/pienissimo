---
id: meeting-2026-11-20-interna-check-report
type: meeting
status: resolved
owner: Elena Spini
with: Aurel Mrruku, Anita Aga
org: ROMI
raised: 2026-11-20
updated: 2026-11-25
depends_on: []
blocks: []
source: Drive 1r82xuJWwSqyj69tDhrFzx3MUGezgY8hnn_52m-Y4Nn4
also_source: Gmail thread 1a1f824f6302f5cc - Gemini notes mailed 2026-11-20 09:48Z, auto-generated 09:47 CET
---

# 2026-11-20 - INTERNA Check Report

**Thirteen minutes, ROMI only, the morning after the project was frozen and four
hours before the client meeting. Anita Aga demonstrates the reports and
dashboards she built by hand in a day; they are accepted as complete, a Monday
production release is agreed in principle, and the tranche report is to be put on
a schedule to administration before month end. It closes with the landing-page
domain, which nobody had told the marketing team about.**

## Attendees

- **Elena Spini** (ROMI) — project manager; called the meeting, chaired it, left
  for the 14:30 client call
- **Aurel Mrruku** (ROMI) — technical lead
- **Anita Aga** (ROMI) — Salesforce developer; built and demonstrated the work

| | |
| --- | --- |
| Invitation | sent by Elena Spini 2026-11-19 09:31:46Z, for **20/11 09:30-10:30 CET** |
| Duration | **00:13:05** — the slot was an hour |
| Record | Google Meet, recorded; **Gemini notes and full transcript** in Drive, `1r82xuJWwSqyj69tDhrFzx3MUGezgY8hnn_52m-Y4Nn4`, with a shortcut folder. Gemini notes also mailed to Aurel Mrruku at 08:48:54Z |
| 🔴 Fathom | **nothing** — a second recorded Pienissimo call in two days that Fathom did not capture |

**Drilled from the full transcript**, per `drill-meeting`. Cost ~6k tokens.

## What was shown

🟢 **Anita Aga built it by hand.** Aurel Mrruku opened by saying so explicitly,
and that it was worth knowing: _"Anna ha fatto un ottimo lavoro ieri... e poi
l'ha fatto a mano, non con lei, giusto per saperlo."_

The dashboards, in the order demonstrated:

1. **Lead by status**, on the Home page. Anita Aga noted the grouping can change
   if the client dislikes status.
2. **Opportunities — sum of amount per status.** ⚠ She limited it to the active
   statuses because most are interactive.
3. **Orders by month** — amount by month. Aurel Mrruku glossed it: _"each month,
   how many orders have been concluded?"_
4. **Tranches due in the next 30 days**, with pagination.
5. **Invoices by payment status** — _"fatura non pagata, pagata, parzialmente
   pagata, senza scadenza"_.
6. **Scadenze da incassare**, by week, convertible to month — the **insoluti**
   report.

🔑 **Aurel Mrruku confirmed the shape**: every dashboard has a report behind it,
and the visualisation type is free — _"everything has a rapard behind the chain...
you can do pi, you can do columns, you can do whatever you want."_

🟢 **Aurel Mrruku tied the invoice reports back to an actual client ask**, the
only requirement traceable to anyone: _"they asked Fabrizio Pienissimo usually
ask that can we see the fature that needs to be paid"_ — Fabrizio Paganelli, on
invoices outstanding. Elena Spini matched it to the insoluti report:
_"parzialmente pagata, non pagata, is insoluti, right?"_

## Decisions

### 🟡 The tranche report goes on a schedule

Elena Spini recognised one of the dashboards as a commitment already made:

> _"when we were creating the flow in DR we were talking about scheduling report
> and we have a report that discuss with them that is actually this one... **Report
> schedulato ed inviato all'amministrazione prima della fine del mese per le
> tranche del mese successivo in scadenza.**"_

Agreed: prepare the scheduled send to administration before month end, for the
following month's expiring tranches. Aurel Mrruku ruled out needing a batch —
_"I think you can do it by standard here... with scheduled you can do scheduled"_
— so it is standard scheduled reporting. ⚠ **Nothing was scheduled on the call**
and November ends in ten days → [OI-381](../items/OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md).

### 🟢 The set is complete

_"le dashboard e i report realizzati sono completi e pronti per l'eventuale
rilascio."_ Elena Spini: _"I think that is enough I would say... We already done
enough. Totally fine."_ Aurel Mrruku offered more — reports keyed on which
accounts exist in Mexal, or on invitations sent per month — and she declined for
now: _"not for now. Don't care... let's see what they ask."_

🔴 **Six reports, and both of them called it invention.** Aurel Mrruku: _"**we
have invented six of them**."_ Elena Spini: _"we can invent [...] report. It was
something that we have to do it. I know."_ That is the supplier specifying a
contractual deliverable to answer a legal notice, said out loud by both sides of
the table → [OI-377](../items/OI-377%20Reports%20and%20dashboards%20were%20never%20built%20and%20have%20no%20requirements.md).

### 🔴 Production on Monday, if asked, and unexplained

The recorded next step:

> _"[Aurel mrruku] Eseguire il deployment delle dashboard e dei report: **in
> produzione lunedi se richiesto dagli stakeholder, senza pero fornire
> spiegazioni agli utenti**."_

How it was actually said:

- Elena Spini: _"If they ask, we can deploy this Monday"_, then _"I will propose
  on Monday. Ah, no. Monday is holiday"_, then _"can I say if they want on Monday
  that we deploy on Monday or not?"_
- Aurel Mrruku: _"Yes, we can do it deployment. **I can do it, but I'm not going
  to explain them. Nothing**... I don't have the will to talk with them."_
- And, unprompted: _"keep in mind that **I'm going to work on Monday don't tell
  anyone** because I need to catch up on other projects... better don't put me
  meeting."_

⚠ **The 19/11 UAT-only instruction was never mentioned.** Elena Spini had
confirmed _"niente PROD per i report/dashboard"_ the previous morning
([OI-376](../items/OI-376%20All%20Pienissimo%20work%20is%20frozen%20except%20reports%20and%20dashboards.md));
this meeting planned past it without referring to it, and her evening status post
re-gated it on Angelo Pastorelli and Gianpaolo Motta → [OI-381](../items/OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md).

⚠ **"Lo stakeholder" is not named.** The condition on the release is a request
from someone the minute does not identify.

## The landing-page domain

Raised by Elena Spini at 00:09:54, as the meeting ended, and it is a real gap →
[OI-383](../items/OI-383%20The%20landing%20page%20domain%20must%20be%20re-raised%20with%20the%20marketing%20team.md).

She had asked Fabrizio Paganelli whether to replace the default customisation
domain with a `pienissimo` one and he had said he did not mind — but she had
discussed it **only with the client's administration**, and 🔑 _"that domain it
will appear also on landing page... **I totally forgot about marketing
actually**"_, and, Aurel Mrruku adding, on the **community** too.

So Fabrizio Paganelli's instruction, relayed: tell the marketing team, because
they may want to change it, and the change open to them is the **landing-page
domain only**. Elena Spini closed it precisely: _"it's not changing the domain in
Salesforce, is changing if they want it only the landing page domain."_ Aurel
Mrruku's caveat stands: anything requiring Salesforce endpoints to be
re-communicated is a different matter.

## 🔑 The mood, which is part of the record

The call opens on the PEC without naming it — Aurel Mrruku: _"a prescindere da
tutto quello che succedera, Anna ha fatto un ottimo lavoro"_ — and closes on the
client meeting four hours away. Elena Spini twice: _"Let's see what happen
today"_, _"Let's see what they will ask today"_, and last of all _"wish me good
luck"_. What happened is
[OI-380](../items/OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md).

## What this meeting changed

| Item | Change |
| --- | --- |
| [OI-377](../items/OI-377%20Reports%20and%20dashboards%20were%20never%20built%20and%20have%20no%20requirements.md) | the remediation is **built and accepted** — five dashboards, six reports; still with no client requirement |
| [OI-376](../items/OI-376%20All%20Pienissimo%20work%20is%20frozen%20except%20reports%20and%20dashboards.md) | the UAT-only boundary now has a **Monday production exit**, gated on Angelo Pastorelli and Gianpaolo Motta |
| [OI-381](../items/OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md) | 🆕 opened — unmerged branch, holiday release, no explanation to users, unscheduled tranche report |
| [OI-383](../items/OI-383%20The%20landing%20page%20domain%20must%20be%20re-raised%20with%20the%20marketing%20team.md) | 🆕 opened — the landing-page domain |
| [OI-370](../items/OI-370%20The%20client%20cannot%20run%20the%20Mexal%20syncs%20by%20hand.md) | the Mexal sync panel's icon was removed in the same branch, `a25d4b3` |

## 🟡 2026-11-25 - a second, independent record of this meeting exists

Found in Gmail once the connector was restored: the **Gemini notes** for
`[PIENISSIMO] - Interna Check Report`, mailed 20 November 09:48Z, content
auto-generated 09:47 CET (thread `1a1f824f6302f5cc`). They corroborate what this
note already held, from a source that does not depend on the Drive document:

- Sections: _Presentazione dashboard e report_ · _Schedulazione e insoluti_
  (_"Verifica dei report per le tranche e le fatture insolute"_) ·
  _Pianificazione del rilascio_ (_"**Approvazione del deployment delle dashboard
  per lunedi**"_).
- 🔑 Its **single** recommended next step, verbatim: _"[Aurel mrruku] Eseguire il
  deployment delle dashboard e dei report: in produzione lunedi se richiesto
  dagli stakeholder, **senza pero fornire spiegazioni agli utenti**."_

⚠ Nothing new in substance — recorded because it independently attests the
unexplained-release instruction that
[OI-381](../items/OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md)
and [OI-377](../items/OI-377%20Reports%20and%20dashboards%20were%20never%20built%20and%20have%20no%20requirements.md)
turn on, and because the Drive document is not the only copy.
