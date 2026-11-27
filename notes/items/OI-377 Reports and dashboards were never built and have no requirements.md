---
id: OI-377
type: open-item
status: in-progress
owner: Anita Aga
with: Aurel Mrruku, Elena Spini, Marco Montesi
org: both
raised: 2026-11-19
updated: 2026-11-27
depends_on: [OI-375]
blocks: []
severity: gating
uncertain: that reports and dashboards are a contract deliverable rests on Elena Spini's statement on the 19/11 call - the contract itself was not read in this sweep and the requirement register carries no reporting requirement
source: notes/meetings/2026-11-19 INTERNA Check temi PEC.md
---

# OI-377 - Reports and dashboards were never built and have no requirements

**Reports and dashboards are the first named ground of the PEC. ROMI's project
manager accepts they are in the contract and were never built, and states the
client never gave a requirement for them. On 19 November ROMI began inventing
one so that the PEC reply can say the deliverable exists.**

First surfaced as a PEC ground on
[the 19/11 internal call](../meetings/2026-11-19%20INTERNA%20Check%20temi%20PEC.md).
Parent: [OI-375](OI-375%20Pienissimo%20sent%20a%20PEC%20contesting%20the%20implementation%20and%20suspending%20the%20go-live.md).

## What is admitted

Elena Spini, on the call:

> _"una delle contestazioni … di PEC e appunto che **manca dashboard e report**"_
> — and later, flatly: _"**le dashboard che mancano, che sono nel contratto e
> mancano**, ok?"_

🔴 **So the deliverable is accepted as contractual and accepted as absent.**
⚠ The contract was not read in this sweep, and
[the requirement register](../../requirements/pienissimo-requirements.yaml) is at
**v1.6** with no reporting or analytics requirement in it. **Which contract
clause this is has never been recorded anywhere in this repository.**

## The requirement problem

🔴 **There is no requirement.** _"dato che allora **non c'hanno dato nessun
requisito**"_, and again: _"cioe non ho neanch'io il requisito. Se vuoi che mi
invento qualcosa te lo invento."_

The only requirement in existence is one sentence, attributed to **Marco
Montesi**: _"vogliono capire la situazione di lead e opportunity"_. ⚠ He is the
commercial lead who has resigned
([OI-357](OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md)),
so the only stated requirement has no owner on the client side.

🔑 **A requirements meeting was planned and never held.** Elena Spini: _"dovevamo
fare dei … un meeting di requisiti"_. That meeting is one of the things the PEC
is now about.

## What is being built instead

See [OI-376](OI-376%20All%20Pienissimo%20work%20is%20frozen%20except%20reports%20and%20dashboards.md)
for the authorisation and its limits.

| | |
| --- | --- |
| Content | Lead and Opportunity reports — standard report types, standard folders, _"tutto standard. Base."_ — one Home-page dashboard for the agents; plus two reports on orders and invoices, added on Aurel Mrruku's offer |
| Environment | **UAT**, explicitly not production |
| Builder | **Anita Aga**, from 19/11 |
| Review | internal, **20/11 09:30 CET** |
| Purpose, as stated | _"cosi almeno nella risposta noi diciamo che abbiamo tutto"_ |

🔴 **It is being specified by the supplier to answer a legal notice, not by the
client to meet a need.** Aurel Mrruku objected to exactly that — _"inventiamo
qualcosa, mandiamo la mail, confermiamo, poi buttiamo su la roba perche stiamo
facendo la stessa cosa dall'inizio di questo progetto"_ — and built it anyway.

⚠ **Fabrizio Mastracci's reading of the ask** is worth keeping, because it is the
only estimate of its real size on the record: _"uno gli fa un report lead status
equal new e gli risbatte dentro una dashboard"_, and _"vogliono tre report … con
lead uguale new. Se questa e motivo di contenzioso, tieni, prenditi questa
cosa."_

## What is owed

- 🔴 **The contract clause** that makes reports and dashboards a deliverable,
  quoted, so the scope of the obligation is known rather than guessed.
- 🔴 **A written requirement from the client**, or an explicit record that ROMI
  specified it unilaterally and why.
- **A ruling on whether this goes to production at all**, given the freeze and
  the UAT-only instruction.
- ⚠ **Whether the register needs a reporting requirement at v1.7.** If reports
  are contractual they belong in it; nothing has been agreed and the register is
  untouched.

## 🟢 2026-11-20 - it is built, it is accepted, and it is still uninstructed

**The gap is closed as a build.** Anita Aga delivered it in a day; it was
demonstrated and accepted at
[the 09:30 internal review](../meetings/2026-11-20%20INTERNA%20Check%20Report.md)
and it is in source control. Full inventory and the release problem:
[OI-381](OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md).

🟢 **What exists, on `origin/DevAnita19` (unmerged, 27 files, +1,132 / -71):**

- **Five dashboards** — `Lead_per_Stato`, `Pipeline_Opportunita`,
  `Valori_Ordini_per_Mese` in `Pienissimo_Dashboards`; `Fatture_Incassi_e_Insoluti`
  and `Tranche_in_Scadenza` in `Pienissimo_Admin_Dashboards`.
- **Six reports** in `Pienissimo_Dashboard_Reports` — the _"sei report"_ exactly:
  `Fatture_da_Incassare`, `Fatture_per_Stato_Pagamento`, `Scadenze_Insolute_Prime_5`,
  `Scadenze_da_Incassare_30_Giorni`, `Tranche_Prossime_5_Scadenze`,
  `Tranche_in_Scadenza_30_Giorni`.
- **Three more reports and a report type** —
  `Informazioni_generali_sul_Opportunity`, `Informazioni_generali_sul_Order`,
  `Preventivi_con_Righe_e_Tranche`, type `Preventivi_Righe_e_Tranche`.
- The Home surface — `Getting_Started_Home.flexipage`, `salesHomeTemplate`,
  `standard__LightningSales.app` — and `Agente.permissionset`, the
  _"added visibility to agents"_ commit.

🔑 **The scope grew beyond the one sentence.** The 19/11 authorisation was Lead
and Opportunity plus two reports on orders and invoices. What shipped covers
leads by status, the opportunity pipeline by amount, orders by month, tranches
due in 30 days, invoices by payment status and the insoluti — six reports behind
five dashboards.

🟢 **One line of it is traceable to a client ask.** Aurel Mrruku on the call:
_"they asked Fabrizio Pienissimo usually ask that can we see the fature that
needs to be paid"_ — Fabrizio Paganelli, on outstanding invoices, which Elena
Spini matched to the insoluti report. ⚠ That is the only requirement behind any
of it that originates with the client, and it is a recollection, not a document.

🔴 **The rest remains invention, and both of them said so.** Aurel Mrruku: _"we
have **invented** six of them."_ Elena Spini: _"we can invent [...] report. It was
something that we have to do it."_ ⚠ **So the contract clause is still unquoted,
the client requirement is still absent, and the register is still v1.6 with no
reporting requirement in it.** The build does not cure any of those three.

🟡 **One commitment attached to it is real and dated**: the tranche report is to
be **scheduled to administration before the end of the month**, for the following
month's expiring tranches — a flow previously discussed with the client. Standard
scheduled reporting suffices. ⚠ Nothing is scheduled yet and November ends in ten
days.

⚠ **It is not what the client asked for at the 14:30 meeting.** The client's
stated want, hours after this was accepted, was the **scadenziario** and the
**credit notes** → [OI-380](OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md).

## 🔴 Update 2026-11-24 - the gap is about to reach production unrequirement-ed

**Direction ordered the build live.** Angelo Pastorelli, `#tproj-pienissimo`
**15:35:51 CET**: _"mettiamo live le dashboard"_; the deployment is planned for
**25 November by 12:00** →
[OI-381](OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md).

🔴 **Nothing about this note's substance changed.** Five dashboards and nine
reports are about to be production metadata on a contested implementation with:

| | |
| --- | --- |
| A written client requirement | 🔴 **None.** _"we have invented six of them"_ |
| A requirement in the register | 🔴 **None.** The register stays **v1.6** |
| A client acceptance test | 🔴 **None.** Aurel Mrruku asked for one on 24/11 at 16:15:45 — _"ma non facciamo dei test con loro ?"_ — and was told _"per ora nessuno sta usando nulla"_ |
| An agreed visibility model | 🔴 **None.** _"devono decidere chi deve vedere sti report ?"_ — unanswered, while `Agente.permissionset` changes with the release |
| The contract clause making them a deliverable | 🔴 **Still not quoted from the contract**, a sixth day |

🔑 **Elena Spini's stated reason for releasing is process, not requirement**:
_"e per portarci avanti questa cosa 'che avevamo pending'"_ (16:35:05 CET). ⚠ That
makes this the clearest live instance of the project's pattern — a deliverable
asserted, built, accepted and shipped entirely inside ROMI.

🟡 **The tranche report schedule is now six days from its deadline** and still
nothing is scheduled.

## 🔴 Update 2026-11-25 - it is production metadata now, and all three gaps survived the release

**The build is live.** Deployment `0AfSW000001NQPR0A4` completed 25/11 18:19:59
CET: five dashboards, ten reports, three custom report types, four folders, the
Home page and template, Sales app reporting navigation and agent reporting
access →
[OI-381](OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md).

🔴 **Nothing this note is about was cured by shipping it:**

| | |
| --- | --- |
| A written client requirement | 🔴 **None** |
| A requirement in the register | 🔴 **None.** The register stays **v1.6** |
| The contract clause making them a deliverable | 🔴 **Still not quoted**, a **seventh** day |
| A client acceptance test | 🔴 **None.** Asked 24/11 16:15:45, never answered |
| An agreed visibility model | 🔴 **None.** Same message, same silence — and `Agente.permissionset` shipped |
| The tranche report schedule | 🔴 **Not created.** **Five days** to month end |

🟡 **The 20/11 meeting's own record surfaced this sweep**, in the Gemini notes
mailed for `[PIENISSIMO] - Interna Check Report` (auto-generated 20/11 09:47
CET). Its single recommended next step is _"[Aurel mrruku] Eseguire il deployment
delle dashboard e dei report: in produzione lunedi se richiesto dagli
stakeholder, **senza pero fornire spiegazioni agli utenti**"_ — which corroborates
the instruction already held, verbatim, from an independent source. ⚠ It also
confirms that an **unexplained** release was the plan of record from 20 November
onward, and the release of 25/11 was in fact unaccompanied.

## 2026-11-26 - now named in a client-facing commercial document, with a wrong date

🆕 **The reporting work appears in a client-facing document for the first time**,
as item `01` of the `CRONOPROGRAMMA` slide added to the Fase 2 offer deck on
**26/11 11:43:11Z**: _"**Report & dashboard — In produzione lunedi**"_
([OI-386](OI-386%20The%20residual%20Fase%201%20list%20omits%20the%20scadenziario%20and%20the%20credit%20notes.md)).

⚠ **The date is wrong.** The release went to production on **Wednesday 25
November at 18:19:59 CET**
([OI-381](OI-381%20The%20report%20and%20dashboard%20remediation%20is%20unmerged%20and%20due%20in%20production%20on%20a%20holiday.md)).
Either the line predates the release and was not updated when the deck was
edited, or it means a future Monday. **Not resolvable from the file.**

🔴 **The underlying defects of this item are untouched by that.** Being listed in
a sales deck is not a requirement: the register is still **v1.6** with no
reporting requirement, **the contract clause that makes reports and dashboards a
deliverable is still unquoted — an eighth day**, there is still no acceptance
test, no visibility decision, and **the tranche report schedule is still
unscheduled with four days to month end**.

## 2026-11-27 - live, credited to direction, and consumed by nobody

🟢 **The release is now stated as authorised in a written status.** Elena Spini's
weekly post, `#tproj-pienissimo` **27/11 17:00:00 CET**: _"Report e dashboard:
**in PROD dal 25/11, con l'ok di Angelo**"_. That is the first time the consent is
attributed to **Angelo Pastorelli** by name in a status document.

🔴 **But the client is not using the platform at all.** The same post states
_"Pienissimo non la usa ancora"_ and that the client has gone on working in Zoho
([OI-387](OI-387%20The%20client%20is%20not%20using%20Salesforce%20and%20has%20asked%20for%20a%20new%20import%20and%20a%20new%20start%20date.md)).
⚠ **So the first PEC ground was answered with five dashboards and nine reports
that nobody at the client is opening**, and the acceptance test has no taker.

🔴 **Everything this note has asked for is still owed, with the month ending in
three days:**

- the **contract clause** that makes reports and dashboards a deliverable,
  quoted - a **ninth** day;
- the **requirement register entry** - still **v1.6**, untouched;
- an **acceptance test** and a **visibility decision**;
- 🔴 **the tranche report schedule, due before month end - three days left**, and
  the author is being moved to another project from 1 December
  ([OI-384](OI-384%20Anita%20Aga%20is%20being%20reallocated%20off%20Pienissimo%20while%20Fase%202%20is%20stopped.md)).

⚠ The residual-Fase-1 slide of 26/11 still lists this as item `01` with the wrong
date, and the 27/11 status does not correct it
([OI-386](OI-386%20The%20residual%20Fase%201%20list%20omits%20the%20scadenziario%20and%20the%20credit%20notes.md)).
