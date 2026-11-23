---
id: OI-381
type: open-item
status: open
owner: Aurel Mrruku
with: Anita Aga, Elena Spini, Angelo Pastorelli, Gianpaolo Motta
org: ROMI
raised: 2026-11-20
updated: 2026-11-23
depends_on: [OI-376, OI-377]
blocks: [fase-1-closure]
severity: high
uncertain: whether a deployment happened outside source control - the 23 November date passed with no commit, no merge and no recorded approval, and the org was not opened
source: notes/meetings/2026-11-20 INTERNA Check Report.md
---

# OI-381 - The report and dashboard remediation is unmerged and due in production on a holiday

**The reports and dashboards exist. They were reviewed and accepted on 20
November, they are in UAT, and they are in source on `DevAnita19` — three
commits, 27 files, never merged to `DevMain`. The release plan is Monday 23
November, a public holiday, by one developer working unannounced, explicitly
without explaining anything to the users, and only if a stakeholder asks and
Angelo Pastorelli and Gianpaolo Motta approve.**

The remediation authorised by
[OI-376](OI-376%20All%20Pienissimo%20work%20is%20frozen%20except%20reports%20and%20dashboards.md)
for the gap in [OI-377](OI-377%20Reports%20and%20dashboards%20were%20never%20built%20and%20have%20no%20requirements.md).
Reviewed at [the 20/11 internal meeting](../meetings/2026-11-20%20INTERNA%20Check%20Report.md).

## 🔴 Update 2026-11-23 - the date passed and nothing was released

**Monday 23 November came and went. Nothing was merged, nothing was committed,
and nothing is recorded as deployed.** Checked at 21:45Z on 23 November:

| Check | Result |
| --- | --- |
| Commits on any branch since 2026-11-20T22:00Z | **None**, apart from this procedure's own 20/11 report commit `9e989b0` |
| `origin/DevAnita19` | **Unchanged** at `a25d4b3` - still 27 files, +1,132 / -71, still unmerged |
| `origin/DevMain` | **Unchanged** at `9e989b0`; holds none of the reports or dashboards |
| The stakeholder request the release was conditional on | 🔴 **No source records it being made** |
| Angelo Pastorelli's and Gianpaolo Motta's ok | 🔴 **Still not recorded, in any form** |

⚠ **The org was not opened**, so this is a source-control answer and not a
production one. Nothing says a deployment was made outside git - and nothing
says it was not. What the record does hold is the developer standing himself
down: _"ciao, in teoria oggi sono off"_, to Elena Spini at **11:39 CET**.

🔑 **So this note's `uncertain:` resolved by default.** The deployment was
either never asked for or the ask never reached any record this account can
reach. The gate held, and the reports are exactly where they were on 20
November - built, accepted, in UAT, unmerged.

🟡 **The tranche report schedule is now seven days from its deadline** -
_"all'amministrazione prima della fine del mese"_ - and nothing is scheduled.

## What exists, in source

🟢 **`origin/DevAnita19`, unmerged, 27 files, +1,132 / -71 lines**, three commits
by **Anita Aga**:

| Commit | When | Subject |
| --- | --- | --- |
| `026cc33` | 2026-11-19 17:52:37 +01:00 | _"Reports, Dashboards and Home Page Layout edits"_ |
| `47a2a42` | 2026-11-20 11:29:54 +01:00 | _"Modifications on report and added visibility to agents"_ |
| `a25d4b3` | 2026-11-20 11:46:22 +01:00 | _"removed the sync icon from the mexal sync component"_ |

🔑 **This closes the question the 19/11 sweep could not answer** — whether
`026cc33` was the OI-377 work. It is, and two more commits followed.

**Five dashboards**, in two new folders:

| Folder | Dashboards |
| --- | --- |
| `Pienissimo_Dashboards` | `Lead_per_Stato`, `Pipeline_Opportunita`, `Valori_Ordini_per_Mese` |
| `Pienissimo_Admin_Dashboards` | `Fatture_Incassi_e_Insoluti`, `Tranche_in_Scadenza` |

**Six reports** in `Pienissimo_Dashboard_Reports` — `Fatture_da_Incassare`,
`Fatture_per_Stato_Pagamento`, `Scadenze_Insolute_Prime_5`,
`Scadenze_da_Incassare_30_Giorni`, `Tranche_Prossime_5_Scadenze`,
`Tranche_in_Scadenza_30_Giorni` — which is the _"sei report"_ of Elena Spini's
status post, counted exactly.

**Three further reports and a custom report type**:
`Informazioni_generali_sul_Opportunity`, `Informazioni_generali_sul_Order`,
`Preventivi_con_Righe_e_Tranche`, and the report type
`Preventivi_Righe_e_Tranche`.

**And the surface they sit on**: `Getting_Started_Home.flexipage` (+97 lines),
the `salesHomeTemplate` aura component (cmp, css, design),
`standard__LightningSales.app`, and `Agente.permissionset` (+8 lines) — the
_"added visibility to agents"_ of `47a2a42`.

🟡 **`mexalSyncPanel` also changed in the same branch** — the sync icon was
removed from the component and its html, js and jest test edited. That is
[OI-370](OI-370%20The%20client%20cannot%20run%20the%20Mexal%20syncs%20by%20hand.md)
work riding along on a reports branch, already live in Prod since 18/11 in its
earlier form.

## The release plan, as agreed

From [the 20/11 meeting](../meetings/2026-11-20%20INTERNA%20Check%20Report.md):

| | |
| --- | --- |
| Decision recorded | _"le dashboard e i report realizzati sono **completi e pronti** per l'eventuale rilascio"_ |
| Next step recorded | _"[Aurel mrruku] Eseguire il deployment delle dashboard e dei report: **in produzione lunedi se richiesto dagli stakeholder**, senza pero fornire spiegazioni agli utenti"_ |
| Gate | 🔴 **Angelo Pastorelli and Gianpaolo Motta.** Elena Spini's status post: _"In PROD solo dopo l'ok di Angelo e Gianpaolo"_ |

## 🔴 Why this is an item and not a completed task

1. 🔴 **The branch is unmerged.** `DevMain` is at `9d7868d` and holds none of it.
   A production deployment on Monday would either merge first or deploy from a
   personal branch; nothing records which.
2. 🔴 **Monday 23 November is a public holiday.** Aurel Mrruku intends to work
   anyway and said so off the record on the call — _"I'm going to work on Monday
   don't tell anyone... I need to catch up on other projects"_ — which means the
   release would land on a day with no second pair of hands.
3. 🔴 **The release is explicitly unaccompanied.** _"senza pero fornire
   spiegazioni agli utenti"_; on the call, _"I can do it, but I'm not going to
   explain them. Nothing... I don't have the will to talk with them."_ ⚠ The
   client's first written release note of 18/11 is already an open item for
   saying more than the delta contained
   ([OI-374](OI-374%20The%2018%20November%20release%20mail%20tells%20the%20client%20the%20order%20contract%20flow%20is%20live.md));
   this would be the mirror failure — a release the users are not told about at
   all, during a formal contestation.
4. ⚠ **There is still no requirement.** Elena Spini on the call: _"we can invent
   [...] report. It was something that we have to do it"_; Aurel Mrruku: _"we
   have invented six of them."_ The acceptance is ROMI's own, on both sides of
   the table — see [OI-377](OI-377%20Reports%20and%20dashboards%20were%20never%20built%20and%20have%20no%20requirements.md).
5. ⚠ **It would break the UAT-only instruction of 19 November** — _"confermo
   niente PROD per i report/dashboard"_ — which no source records as withdrawn.
   The 20/11 meeting planned past it without referring to it.

## The one scheduling commitment attached to it

🟡 **The tranche report is to be scheduled**, not just built. Agreed on the call:
_"predisporre la pianificazione e l'invio schedulato del report delle tranche
**all'amministrazione prima della fine del mese**"_, covering the tranches
falling due the following month. Aurel Mrruku confirmed standard scheduled
reporting is enough and no batch is needed. ⚠ **Nothing is scheduled yet**, and
November ends in ten days.

## What is owed

- 🔴 **Angelo Pastorelli's and Gianpaolo Motta's ok, or refusal**, in writing.
- 🔴 **A merge to `DevMain`** before anything reaches production, per the standing
  practice Aurel Mrruku defended on 19/11 — _"anche un campo, anche una label
  deve passare sempre"_.
- **A decision on whether an unexplained release is acceptable** while the
  project is under a formal notice to perform.
- **The schedule on the tranche report**, before month end.
