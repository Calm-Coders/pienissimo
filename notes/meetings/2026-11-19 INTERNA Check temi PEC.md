---
id: meeting-2026-11-19-interna-check-temi-pec
type: meeting
status: resolved
owner: Elena Spini
with: Aurel Mrruku, Fabrizio Mastracci
org: ROMI
raised: 2026-11-19
updated: 2026-11-19
depends_on: []
blocks: []
source: Drive 1JYjYFQo3gF8_gKOZu85NgX6fCvlPhq-BmEqGbc2FO_A
---

# 2026-11-19 - INTERNA Check temi PEC

**Twenty-five minutes, ROMI only, on the morning the project team learned that
Pienissimo had sent a PEC contesting the whole Salesforce implementation. It is
the meeting that stopped the project: Fase 2 halted, every other thread frozen,
and one remediation authorised — reports and a dashboard, in UAT, for the legal
reply. It also contains the only account of the PEC's contents in any source,
and a process argument about where configuration may be made.**

## Attendees

- **Elena Spini** (ROMI) — project manager, back from leave the same day; called
  the meeting
- **Aurel Mrruku** (ROMI) — technical lead
- **Fabrizio Mastracci** (ROMI) — marketing; lost connection for about a minute

🔴 **No one from Pienissimo.** Elena Spini chose Meet deliberately so there would
be a record: _"Alla fine ho pensato di fare qua, almeno e tutto anche tracciato."_

## Sources

**Sources:** Google Drive `1JYjYFQo3gF8_gKOZu85NgX6fCvlPhq-BmEqGbc2FO_A` —
`PIENISSIMO - Check temi PEC - 2026/11/19 10:08 CET - Transcript`, Google Meet
transcript, **00:25:09**, owned by Elena Spini, shared with Aurel Mrruku at
09:37:14Z. Read in full in the 19/11 nightly sweep.

⚠ **Speaker labels are unreliable, as always on this project** — the transcript
renders "Aurel" as "Augel"/"Aren"/"aure", and one of Aurel Mrruku's own lines is
attributed to him asking _"Perche chiedi a Aurel?"_. Attribution below is
reconstructed from content. The meeting was scheduled twice (11:30, then moved to
10:00) and ran from 10:08.

## Decisions

1. 🔴 **Fase 2 stops.** _"Quindi per ora fase due, stop."_ →
   [OI-342](../items/OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md),
   [OI-349](../items/OI-349%20Fase%202%20has%20no%20developer%20committed%20for%20December.md)
2. 🔴 **Everything else on Pienissimo stops.** Aurel Mrruku had already told
   Anita Aga _"di non toccare piu niente su pianissimo"_; Elena Spini confirmed
   in the DM: _"il resto fermi tutti"_ →
   [OI-376](../items/OI-376%20All%20Pienissimo%20work%20is%20frozen%20except%20reports%20and%20dashboards.md)
3. 🟡 **R0 stays in production** — Aurel Mrruku offered to remove it, Elena Spini
   said _"No, per ora lascialo"_, having written to Angelo
4. 🟢 **Reports and a Home-page dashboard on Lead/Opportunity are built in UAT**,
   by Anita Aga, reviewed internally Friday 20/11 09:30 →
   [OI-377](../items/OI-377%20Reports%20and%20dashboards%20were%20never%20built%20and%20have%20no%20requirements.md)
5. 🟢 **Marketing training gets a calendar**: Fabrizio Mastracci supplies a
   scaletta and dates for next week, three to four sessions, 3-4 hours →
   [OI-378](../items/OI-378%20Marketing%20training%20is%20undelivered%20and%20the%20client%20did%20not%20attend%20the%20final%20test.md)
6. 🔴 **Elena Spini is stood down from client contact** — _"ormai non posso piu
   parlare con il cliente"_; approvals go via **Giancarlo** and **Angelo**.
   ⚠ Surnames not established
7. 🟢 **Elena Spini builds the Fase 2 chronology** point by point from the
   meeting record, to answer the PEC's claim that all of Fase 2 is in the
   contract

## Action items

| # | Action | Owner | Due |
| --- | --- | --- | --- |
| [OI-377](../items/OI-377%20Reports%20and%20dashboards%20were%20never%20built%20and%20have%20no%20requirements.md) | Build the Lead/Opportunity reports + dashboard in UAT, plus two reports on orders and invoices | Anita Aga, via Aurel Mrruku | **20/11 09:30** review |
| [OI-378](../items/OI-378%20Marketing%20training%20is%20undelivered%20and%20the%20client%20did%20not%20attend%20the%20final%20test.md) | Scaletta of the marketing training + available days | Fabrizio Mastracci | next week |
| [OI-375](../items/OI-375%20Pienissimo%20sent%20a%20PEC%20contesting%20the%20implementation%20and%20suspending%20the%20go-live.md) | The Fase 2 point-by-point chronology for the PEC reply | Elena Spini | not stated |
| [OI-375](../items/OI-375%20Pienissimo%20sent%20a%20PEC%20contesting%20the%20implementation%20and%20suspending%20the%20go-live.md) | Confirm with Giancarlo / Angelo whether the UAT work may go to Prod | Elena Spini | before 20/11 |

## The PEC, as recounted

The whole of what this repository knows about the PEC's contents comes from this
call and from Elena Spini's Slack posts the same morning →
[OI-375](../items/OI-375%20Pienissimo%20sent%20a%20PEC%20contesting%20the%20implementation%20and%20suspending%20the%20go-live.md).
Dated **17 November**, her birthday, as she noted twice. Grounds named: missing
**reports and dashboards** (conceded as contractual), missing **marketing
training**, and **Fase 2 contested in full** with its additional cost, the client
holding that all of it is already in the Fase 1 contract. ⚠ She declined to read
it out — _"la PEC ve la risparmio perche e veramente imbarazzante"_ — so no
quotation of the document itself exists in the record.

🔑 **Aurel Mrruku's timeline, stated twice:** Monday 16/11, four hours of calls,
_"Lunedi andava tutto bene"_; then _"e arrivata la direzione"_, the client
deferred to after lunch, then past 17:00, _"e sono spariti"_; the PEC is dated
the next day. His refrain: _"abbiamo tutto registrato"_ — and Elena Spini relays
the same advice from Angelo.

⚠ **The 16 November go-live is itself contested**, which ROMI disputes because
the client proposed that date
([OI-268](../items/OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)):
_"non puoi contestare il 16 quando io ti ho fatto il favore che il 16 andava
bene?"_

## Open questions and risks

- 🔴 **The PEC's deadline is unknown.** Art. 1454 c.c. works by a fixed term and
  nothing in the record states it.
- 🔴 **The contract clause behind reports and dashboards was never recorded** and
  was not read here.
- ⚠ **Who may write to the client** is unresolved; the project manager cannot and
  nobody is named in her place.
- ⚠ **The disagreement on configuration-in-production is unresolved in
  principle**, though this instance went to UAT →
  [OI-376](../items/OI-376%20All%20Pienissimo%20work%20is%20frozen%20except%20reports%20and%20dashboards.md).

## Notes

- 🟡 **A factual correction on the record.** Elena Spini thought the 18/11 Mexal
  component had been built directly in production and had not been requested.
  Aurel Mrruku corrected both: it is a **sync panel with buttons, not a
  dashboard**, it went through UAT, and **Fabrizio Paganelli asked for it** —
  verbally on 16/11 and in writing the same day, _"darci l'istruzione per
  lanciarlo manualmente al bisogno"_ →
  [OI-370](../items/OI-370%20The%20client%20cannot%20run%20the%20Mexal%20syncs%20by%20hand.md).
- 🟡 **On the date format**, Aurel Mrruku states he announced it on Monday's call
  and shipped it with the 18/11 release, _"quindi c'e traccia del 18"_, and that
  the contract put it before the 24th →
  [OI-358](../items/OI-358%20The%20org%20is%20not%20set%20to%20Italian%20date%20and%20number%20formats.md).
- ⚠ Elena Spini thought the release was planned for the **19th**, from the shared
  document reading _"18 o 19"_, and accepted Aurel Mrruku's Monday confirmation
  once told of it: _"ok ottimo non sapevo"_. 🔴 Her own view of the release
  remains _"non avrei fatto un rilascio cosi"_ →
  [OI-374](../items/OI-374%20The%2018%20November%20release%20mail%20tells%20the%20client%20the%20order%20contract%20flow%20is%20live.md).
- **Fabrizio Mastracci's assessment**, preserved because it is the only one
  offered: the client _"si e talmente inaspito che delle volte si proietta pure
  su di noi il lavoro interno"_, ROMI _"siamo stati dietro a tutti i cambi e le
  richieste e il disordine del cliente"_, and his landing pages _"uscite dal
  nulla"_ never got a yes or no. ⚠ Opinion, recorded as said.
