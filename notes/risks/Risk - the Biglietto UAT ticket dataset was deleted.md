---
id: risk-biglietto-dataset-deleted
type: risk
status: resolved
severity: critical
owner: Aurel Mrruku
with: Anita Aga
org: ROMI
raised: 2026-08-31
updated: 2026-09-02
depends_on: [OI-41]
blocks: [OI-74, OI-75]
requirement: BIG-03
source: org-status-check 2026-08-31 09:36-09:52Z, commit 5d8cdb3
---

# Risk - the Biglietto UAT ticket dataset was deleted

✅ **Resolved 2026-09-02 by decision** - the data is disposable, so nothing here needs recovering. The account of what was deleted is kept because it is still the evidence for how the ticket lifecycle behaved. See [the decision](../decisions/Decision%20-%20UAT%20data%20is%20disposable%20in%20Fase%201.md) and the closing section.

**`Biglietto__c` and all 37 of its records are gone from Pienissimo UAT.** The
deletion had a recovery window that was running down when this note was written;
it has since been allowed to lapse deliberately.

Verified by the `org-status-check` run of **2026-08-31, 09:36–09:52Z** against
`00DMA000004nMMr2AM`: Tooling `EntityDefinition` returns zero rows for the
object and `SELECT ... FROM Biglietto__c` no longer parses.

## What was lost, and what was not migrated

The 37 records were **not** moved to standard Asset. Asset held **4** records on
28 August and holds **5** today — exactly one was added, not thirty-seven. So the
migration [OI-41](../items/OI-41%20Asset%20and%20ticket%20data%20model.md) calls
for did not happen; the dataset was simply removed.

Those 37 records are the only evidence the record holds of how the ticket
lifecycle behaved in UAT — 30 parked in `In attesa firma`, 7 in `Caricato`, and
**19 carrying a populated `DocuSign_Envelope_Id__c`**, which was the only proof
on the project that the DocuSign leg had ever successfully run. See
[the Biglietto build](../objects/The%20Biglietto%20build.md).

## The mechanism, which the org check did not establish

It was **deliberate and it is in the repository.** Commit **`5d8cdb3`** — _"Deleted
the Biglietto metadata and related references"_, **Anita Aga, 28 August 18:10
CEST** — removes the object and its twelve fields from `force-app/` and adds
`manifest/biglietto-cleanup-destructiveChangesPost.xml`, a destructive-changes
manifest naming the object, its tab, layout and list view, six Apex classes, a
trigger and a Visualforce page.

So this was a planned cleanup deploy following the 24 August decision to move to
standard Asset, not an accident. **What is not established is whether an export
was taken first.** Nothing in the commit, the manifest or any message on Slack or
in mail says one was. That question is the whole of the recovery decision and it
is unanswered.

## ~~Why it is urgent rather than merely bad~~ - superseded 2026-09-02

> ⚠ **The section below is kept as written on 2026-08-31 and is no longer
> operative.** The window it describes is real and was allowed to lapse on
> purpose. Do not act on it.

Salesforce retains a deleted custom object and its rows in the recycle bin for
approximately **15 days**, so on a 28 August deletion the window closes around
**12 September** — one day after Fase 1 development is due to end on 10
September. This is the one finding in the current record that **decays if nobody
acts**: every other open item will still be there next week in the same state.

⚠ The ~15 day figure is standard Salesforce behaviour, not something this run
measured in the org. Treat the date as an estimate to act well inside, not a
deadline to run to.

## ~~What a human has to decide~~ - answered 2026-09-02

> ⚠ **All three questions below were answered on 2026-09-02** - see the closing
> section. None of them needs putting to anyone.

1. **Was an export taken before the destructive deploy?** Anita Aga ran it and is
   the only person who can answer. If yes, most of this closes.
2. **If not, is the dataset worth undeleting?** It is a superseded design holding
   records parked against states the 6 August lifecycle abolished — a real
   argument that losing it costs little. But that argument has never been made
   and accepted; the records were removed without it.
3. **Either way, the DocuSign evidence is separately worth recovering**, because
   nothing else on the project demonstrates that integration working.

Nobody has raised any of this. It is recorded here from an org check whose own
findings were never published — see
[the trace](../traces/Source%20trace%202026-08-31.md).

Related: [the code half of the same deploy](Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md),
which is worse, [the Biglietto build](../objects/The%20Biglietto%20build.md),
[the ticket lifecycle has never run end to end](Risk%20-%20the%20ticket%20lifecycle%20has%20never%20run%20end%20to%20end.md).

## 2026-09-02 - closed by decision, not by recovery

Aurel Mrruku, asked what mattered most on the project, answered that the
question above does not: _"Biglietto\_\_c records shoud not be migrated, here we
are in test environment and we dont care about the data if we delete them, same
on the tranche"_.

So all three questions this risk posed are answered at once:

1. **Was an export taken?** It no longer matters, and nobody needs to ask Anita
   Aga.
2. **Is the dataset worth undeleting?** No. The argument that it is a superseded
   design holding records parked against abolished states — made in this note and
   never accepted — is now accepted by the owner.
3. **Is the DocuSign evidence worth recovering?** Not as _data_. The 19
   populated envelope ids were the only proof the integration had run, and that
   proof is gone; but the decision covers records, and re-proving DocuSign is a
   test of the rebuilt Asset flow, not an archaeology exercise.

⚠ **This does not extend to the code.** The seven Apex components deleted in the
same 28 August deploy were never in source control, and deleted Apex is not in a
recycle bin.
[That risk stays open](Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md)
and is not covered by this decision.

The recycle-bin window around **12 September** is therefore no longer a deadline
on this project, and MAP.md no longer carries one. Nothing in the current record
now decays if nobody acts.

Source: [the decision](../decisions/Decision%20-%20UAT%20data%20is%20disposable%20in%20Fase%201.md).
