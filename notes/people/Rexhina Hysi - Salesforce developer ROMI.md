---
id: person-rexhina
type: person
status: active
org: ROMI
team: Calm-Coders
updated: 2026-10-30
---

# Rexhina Hysi - Salesforce developer ROMI

Salesforce developer on this project, part of the
[Calm-Coders team working for ROMI](../Calm-Coders%20on%20GitHub%20means%20ROMI.md).

On 5 August she deleted `ProductTrigger` as inactive and no longer needed
(commit `ba842ad`, merged in PR #8), which completes half of
[OI-44](../items/OI-44%20Delete%20the%20deprecated%20bundle%20fields.md). The
tracker still shows that item blocked on Andrea Di Cicco's review. The
`Parent__c` and `Calculated_Bundle_Price__c` fields she did not touch are still
present.

Works on `DevRexhina_*` branches. Slack `@r.hysi`
(`r.hysi@romicompany.com`), timezone Europe/Amsterdam.

Her surname was recorded as unknown until **2026-08-14**, when Aurel Mrruku
supplied it. It matches the sister project's records, so the two are the same
person.

## 2026-09-02 — joining the project, on "the community"

Aurel Mrruku engaged her on Pienissimo on 2 September, once she finished her
previous engagement, and told Gianpaolo Motta so the same afternoon: _"Rexhina mi
ha detto che oggi finisce la parte di banca Etica e lo ingaggio su pienissimo."_

Her assignment, in his words in their DM at 11:04 CEST: **_"nga ana jote dua qe
te punosh me community te pienissimo"_** — work on the Pienissimo community. ⚠
**Which community is not stated**, and the record has three candidates and no
decision — see
[OI-86](../items/OI-86%20Who%20hosts%20the%20participant%20landing%20page.md).

Access: he shared the Pienissimo 1Password vault with her the same morning after
a false start (_"akoma se shoh pienissimon ne 1 pass"_), and **removed her from
the Notion workspace** while reorganising it — _"te hoqa nga notion se po bej ca
rregullime… i kishte me lek membersat"_, the members were costing money. Her
1 September request for the `PIENISSIMO - Open Items` Notion page has therefore
**almost certainly not been left unanswered — it has been overtaken by a
deliberate cost decision**. ⚠ He did not say so in those words, and the two facts
are a day apart; but the sweeps carrying "Rexhina's Notion access is pending" as
an open ask should stop treating it as an oversight to chase.

## 2026-09-03 - first delivery on Pienissimo, one day after being assigned

Assigned to _"the Pienissimo community"_ in a Slack DM on 2 September at 11:04
CEST. On **3 September** she opened PR **#31** at 14:21Z and it was merged by
Aurel Mrruku at 15:02Z: **82 files, +4,402 lines** — an Experience Cloud site with
the participant registration page, the quote acceptance page and their two Apex
controllers
([the build](../objects/The%20Landing%20Page%20community.md)). She posted the PR
link to Aurel Mrruku in their DM at 16:24 CEST.

That is a substantial delivery inside 24 hours of assignment, and it lands two
external-facing pages the project has been designing since 6 August.

⚠ Two things about it belong on the work, not on her:

- **The scope was never decided.**
  [OI-86](../items/OI-86%20Who%20hosts%20the%20participant%20landing%20page.md) is
  still open, and she was given a one-line instruction in a DM.
- **The pages have no application-level authentication**, which is
  [the third instance of the same project-wide pattern](../risks/Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md)
  and not a new habit of hers.

⚠ The Notion access question is settled and should stop being carried as an
oversight — Aurel Mrruku removed her while reorganising it, on cost.

## 🔴 2026-10-30 - reassigned off the project, full time

🔑 **She is no longer working on Pienissimo.** Aurel Mrruku, to Elena Spini in
[the 30 October alignment](../meetings/2026-10-30%20Rapido%20Allineamento%20Aurel%20Elena.md):

> _"c'è solo **Anita** perché **Regina ormai è su un altro progetto full time**"_

⚠ _"Regina"_ is the transcript's rendering of her name; the same session also gives
_"Regina Ana"_ and _"Anna"_ for Anita Aga. The referent is unambiguous from context
— the developer who built the agent permissions.

🔑 **She has not left ROMI.** Earlier runs of these records carried _"Rexhina
Hysi's leaving date"_ as an open question, on the strength of a 26/10 remark. **This
is a reassignment, not a departure**, and it supersedes the departure reading.
⚠ She is still invited, as optional, to the `Test PS Tutor` permissions session of
3 November (Gmail `1a18c2bf516096d6`, cc `r.hysi@romicompany.com`), and she owns the
`Manual Steps Pienissimo` sheet behind
[OI-301](../items/OI-301%20Three%20production%20manual%20setup%20steps%20are%20outstanding.md),
touched 29/10.

### What she leaves behind

🔑 **The `Agente` profile and permission set are hers**, with the restrictive test
users that could not touch bundles or orders — the whole basis of the tutor access
plan in
[OI-300](../items/OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md).
Aurel Mrruku has not tested them himself: _"io personalmente non l'ho fatto, ma
l'ha fatto Regina"_.

🔴 **Two of her branches are unmerged and now unowned**: `Devmain_LeadChecks`
(`5302d29`, 26/10) and `Devmain_QuoteTriggerChanges` (`1c40cd9`, 26/10). ⚠ **Nobody
is recorded as inheriting them.**

🔴 **Anita Aga is now the only developer on Pienissimo**, seventeen days from
go-live, carrying the Lead field, the picklists, the lookup filter and whatever the
2 November contract meeting produces.
