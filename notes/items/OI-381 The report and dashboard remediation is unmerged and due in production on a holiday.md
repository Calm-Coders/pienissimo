---
id: OI-381
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Anita Aga, Elena Spini, Angelo Pastorelli, Gianpaolo Motta
org: ROMI
raised: 2026-11-20
updated: 2026-11-25
depends_on: [OI-376, OI-377]
blocks: [fase-1-closure]
severity: high
uncertain: client acceptance, the visibility decision and the scheduled tranche-report delivery remain unverified; the consent question of 24/11 is now answered
source: notes/meetings/2026-11-20 INTERNA Check Report.md
also_source: Slack C0B5T3RB4FM 2026-11-24 15:35-17:18 CET and 2026-11-25 10:47 CET; Slack C0C38JJ9D1T 2026-11-25 19:40 CET
---

# OI-381 - The report and dashboard remediation is unmerged and due in production on a holiday

## 🟢🔑 Update 2026-11-25 (nightly sweep) - the written consent exists, and the release went out six hours past its own deadline

🔑 **The question this note carried as its `uncertain:` is closed.** Angelo
Pastorelli answered Elena Spini's 17:18 CET question of 24 November — **as a
thread reply, which is why no channel read found it** — on 25 November at
**10:47:33 CET**:

> _"**per me puoi procedere**"_

one ✅ reaction. Immediately before it, at **10:47:28**: _"Scusa ho letto adesso,
si eravamo rimasti cosi con Daniele e le ho inviato un vocale ieri"_.

🟢 **So the deploy was consented in writing, by the gatekeeper asked, roughly
seven hours before it happened.** The _"abbiamo toccato PROD senza consenso"_
exposure Elena Spini named is answered. 🔴 **Gianpaolo Motta's ok is still
nowhere in the record**, at any point.

🔴 **The release missed its own deadline by about six hours.** The commitment was
_"domani entro le 12"_:

| | |
| --- | --- |
| Consent given | **25/11 10:47:33 CET** |
| Committed deadline | **25/11 12:00 CET** |
| PR #132 merged to `DevMain` | **25/11 18:10:26 CET** (`56a7020`, merged by `aureliii`) |
| Production deployment `0AfSW000001NQPR0A4` completed | **25/11 18:19:59 CET** (17:19:59Z) |
| Committed to `DevMain` | **`006e830` "Deploy Production"**, authored **Anita Aga**, 18:26 CET |
| Told to the marketing group DM | **19:40:25 CET** — Aurel Mrruku: _"oggi ho rilasciato in prod dashboard e report"_ |

🟢 **PR #132 is merged and the repository now has no open pull request** — the
merge-before-production practice Aurel Mrruku defended on 19/11 was honoured.

🔴 **The three things this note says are owed are still owed**, unchanged by the
release:

- **No client acceptance test.** Asked 24/11 16:15:45, never answered.
- **No decision on who may see the reports and dashboards.** Same message, same
  silence, while `Agente.permissionset` shipped with the release.
- 🔴 **The tranche report is still not scheduled**, and November now has **five
  days** left. This is the one dated commitment attached to the item.

⚠ **The release was still unaccompanied.** Nothing in this window records any
communication to the client or to the users about it — consistent with the 20/11
instruction _"senza pero fornire spiegazioni agli utenti"_, which the Gemini
notes of that meeting (found in Gmail this sweep) carry verbatim as the meeting's
one recommended next step.

## Update 2026-11-25 - production release completed with the requested fixed running user

The user explicitly changed the running-user decision: all five new dashboards must run as Amministrazione Pienissimo, rather than preserving the three viewer-based dashboards from UAT. The active production account was verified. Check-only validation `0AfSW000001NQMD0A4` succeeded for all 26 components; actual production deployment `0AfSW000001NQPR0A4` succeeded on 25 November 2026 at 17:19:59Z (18:19:59 Europe/Tirane). Deployed: five dashboards, ten reports (the nine branch reports plus the missing Lead dependency), three custom report types, four folders, the Home page/template, Sales app reporting navigation and agent reporting access. Production was retrieved again: all five dashboards are SpecifiedUser with the selected running user; all ten reports and three report types are present; the agent Home assignment, Reports/Dashboards navigation and RunReports permission are verified. All ten reports executed successfully through the Analytics REST API with allData=true. The four pre-existing dynamic dashboards were not changed. Source now includes the five running-user changes and the missing Lead report, commercial report folder and two report types. These source changes are local and uncommitted. The deployment preserves existing production application/permission settings and excludes unrelated Plus-profile assignments and Mexal LWC changes. Folder access follows the UAT shares mapped to verified active production users; two UAT recipients have no active production match and receive no substitute grant. Fixed-user dashboards display data using the selected administrator account access, as requested. The redundant all-record-types Lead filter was omitted in the deployable dependency, preserving the seven production Leads without a record type. The three existing Home donut reports were already identical and were not redeployed. No client acceptance session or scheduled tranche report subscription was performed; those remain outstanding, so this item remains in progress despite the completed technical release. Evidence is in the ignored local `.org-status-cache/report-release-2026-11-25/` directory, including completed-deployment.json and post-deploy-checks.json. No commit or push was made.

## Update 2026-11-25 - merged and validated; dynamic-dashboard capacity blocks production

PR #132 is merged into DevMain at `56a7020` (verified locally on 25 November). The user explicitly requested the production deployment in this session and selected Amministrazione Pienissimo as the running user for the two administrative dashboards. The reporting package contains five dashboards, ten reports (nine from the branch plus the missing lead dependency), three custom report types, four folders, the Home page/template, reporting navigation and agent reporting access. The three existing Home donut reports already match production and are excluded. Two report types and the lead dependency were retrieved from UAT because they are absent from Git. Production baseline application/permission metadata was preserved and only the reporting changes were added; unrelated Plus-profile assignments and Mexal LWC changes are excluded. Folder shares were mapped to verified active production accounts; two UAT recipients have no active matching production identity and are omitted from the candidate, not granted substitute access. The Lead report record-type filter retrieved as blank/Master plus both existing record types fails deployment; the candidate omits that redundant all-types predicate, retaining the seven production Leads without a record type. Final check-only validation `0AfSW000001NQE90AO` failed solely on the dynamic-dashboard limit and the resulting missing dashboard reference on Home. It reports 24/26 components valid, two component errors; this is validation, not a partial deployment. Production has four existing dynamic dashboards; the three new dynamic dashboards would require at least seven slots. Existing dashboards: Einstein Trust Layer, Activities Dashboard, Sales Engagement Sample Dashboard, Digital Wallet Consumption Insights by Tags. The user instructed that the new dashboards must behave exactly as in UAT, so they remain dynamic. Additional capacity or an explicit decision about existing dashboards is required. No actual deployment or production metadata/data change was made. No report delivery subscription was created. Evidence and the candidate ZIP are in the ignored local `.org-status-cache/report-release-2026-11-25/` directory; retrieve or rebuild them on another machine. Client acceptance and any broader access decision remain unverified.

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

## 🔑 Update 2026-11-24 - the release is back on, for tomorrow by midday, and is now waiting on one written consent

**The day after the holiday that produced nothing, direction ordered the release.
Angelo Pastorelli, in `#tproj-pienissimo` at 15:35:51 CET - the channel's first
Pienissimo traffic since the 19/11 weekly post:**

> _"[Elena Spini] io direi **manda al cliente le proposte per le call di
> formazione e mettiamo live le dashboard**"_
> — one 👍 reaction; and at **15:36:00**, _"**oggi la sento per i punti aperti**"_

🔑 **That is the instruction the 23/11 release never had.** It came from one of
the two named gatekeepers, in the project channel, in writing. What followed, in
the same channel:

| Time (CET) | Who               | What                                                                                                                                                  |
| ---------- | ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| 15:35:51   | Angelo Pastorelli | _"mettiamo live le dashboard"_                                                                                                                        |
| 16:05:56   | Elena Spini       | _"[Aurel mrruku] **quando possiamo portare report/dashboard in PROD?**"_                                                                              |
| 16:14:32   | Aurel Mrruku      | _"**domani entro le 12 va bene ?**"_                                                                                                                  |
| 16:15:45   | Aurel Mrruku      | _"**ma non facciamo dei test con loro ? devono decidere chi deve vedere sti report ?**"_                                                              |
| 16:35:05   | Elena Spini       | _"ma penso che **per ora nessuno sta usando nulla**... ma e per portarci avanti questa cosa 'che avevamo pending'"_                                   |
| 17:18:41   | Elena Spini       | _"[Angelo Pastorelli] **ci dai tu il consenso a fare questo deploy? non vorremmo mai che qualcuno dicesse che abbiamo toccato PROD senza consenso**"_ |

🔴 **Angelo Pastorelli has not answered that question.** Checked at **21:45Z /
22:45 CET on 24 November**: no reply in the channel, in the thread, or in any
conversation this account can reach. So the release is scheduled for **25
November by 12:00** and the explicit written consent its own project manager
asked for **does not exist**.

🔑 **Elena Spini's reason for asking is itself the finding.** _"non vorremmo mai
che qualcuno dicesse che abbiamo toccato PROD senza consenso"_ — the team is now
documenting consent before touching production because the client is contesting
the implementation in a formal notice. ⚠ Nothing in the record says whether
Angelo Pastorelli's 15:35 instruction is that consent or whether a further
explicit one is required; Elena Spini's 17:18 message implies she does not think
the first one is enough.

🔴 **Two things the release still does not have:**

1. 🔴 **No merge.** `origin/DevAnita19` is **still at `a25d4b3`**, unchanged since
   20/11 11:46, still 27 files / +1,132 / -71. **PR [#132](https://github.com/Calm-Coders/pienissimo/pull/132)**
   _"Reports, Dashboards and Home Page Layout edits"_ (anitaaga → `DevMain`) is
   **open, untouched since 20/11 10:46**, and its base is `46d3847` — two nightly
   commits behind `DevMain`, now at `47c2d33`. ⚠ A deployment tomorrow by midday
   either merges that PR first or deploys from a personal branch, against the
   standing practice Aurel Mrruku defended on 19/11.
2. 🔴 **No client test and no decision on who may see the reports.** Aurel
   Mrruku asked both questions at 16:15:45 and got neither answer: Elena Spini
   replied that nobody is using anything yet and the point is to clear a pending
   item. ⚠ So five dashboards and nine reports are to reach production with
   **no acceptance test by the client and no visibility model agreed** — and the
   `Agente.permissionset` change (+8 lines) rides along with them.

🟡 **The tranche report schedule is now six days from its deadline** —
_"all'amministrazione prima della fine del mese"_ — and still nothing is
scheduled. ⚠ A deployment does not discharge it; the scheduled send is a separate
act.

🟢 **No commit on any branch in the window.** `origin/DevMain` is at `47c2d33`,
this procedure's own 23/11 report commit; the working tree was clean at start.

## 🔴 Update 2026-11-23 - the date passed and nothing was released

**Monday 23 November came and went. Nothing was merged, nothing was committed,
and nothing is recorded as deployed.** Checked at 21:45Z on 23 November:

| Check                                                  | Result                                                                    |
| ------------------------------------------------------ | ------------------------------------------------------------------------- |
| Commits on any branch since 2026-11-20T22:00Z          | **None**, apart from this procedure's own 20/11 report commit `9e989b0`   |
| `origin/DevAnita19`                                    | **Unchanged** at `a25d4b3` - still 27 files, +1,132 / -71, still unmerged |
| `origin/DevMain`                                       | **Unchanged** at `9e989b0`; holds none of the reports or dashboards       |
| The stakeholder request the release was conditional on | 🔴 **No source records it being made**                                    |
| Angelo Pastorelli's and Gianpaolo Motta's ok           | 🔴 **Still not recorded, in any form**                                    |

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

| Commit    | When                       | Subject                                                    |
| --------- | -------------------------- | ---------------------------------------------------------- |
| `026cc33` | 2026-11-19 17:52:37 +01:00 | _"Reports, Dashboards and Home Page Layout edits"_         |
| `47a2a42` | 2026-11-20 11:29:54 +01:00 | _"Modifications on report and added visibility to agents"_ |
| `a25d4b3` | 2026-11-20 11:46:22 +01:00 | _"removed the sync icon from the mexal sync component"_    |

🔑 **This closes the question the 19/11 sweep could not answer** — whether
`026cc33` was the OI-377 work. It is, and two more commits followed.

**Five dashboards**, in two new folders:

| Folder                        | Dashboards                                                         |
| ----------------------------- | ------------------------------------------------------------------ |
| `Pienissimo_Dashboards`       | `Lead_per_Stato`, `Pipeline_Opportunita`, `Valori_Ordini_per_Mese` |
| `Pienissimo_Admin_Dashboards` | `Fatture_Incassi_e_Insoluti`, `Tranche_in_Scadenza`                |

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

|                    |                                                                                                                                                                             |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Decision recorded  | _"le dashboard e i report realizzati sono **completi e pronti** per l'eventuale rilascio"_                                                                                  |
| Next step recorded | _"[Aurel mrruku] Eseguire il deployment delle dashboard e dei report: **in produzione lunedi se richiesto dagli stakeholder**, senza pero fornire spiegazioni agli utenti"_ |
| Gate               | 🔴 **Angelo Pastorelli and Gianpaolo Motta.** Elena Spini's status post: _"In PROD solo dopo l'ok di Angelo e Gianpaolo"_                                                   |

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

- 🔴 **Angelo Pastorelli's answer to Elena Spini's 17:18 CET question of 24
  November**, in writing, before anything is deployed — and **Gianpaolo Motta's
  ok or refusal**, which no source has recorded at any point.
- 🔴 **A merge to `DevMain`** before anything reaches production, per the standing
  practice Aurel Mrruku defended on 19/11 — _"anche un campo, anche una label
  deve passare sempre"_.
- **A decision on whether an unexplained release is acceptable** while the
  project is under a formal notice to perform.
- **The schedule on the tranche report**, before month end.
- 🔴 **A decision on who may see the reports and dashboards**, and whether the
  client tests them before or after they are live — asked on 24/11 and unanswered.
