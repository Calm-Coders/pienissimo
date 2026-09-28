---
id: OI-153
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-18
updated: 2026-09-23
depends_on: [OI-137]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-09-18 Interna Temi Mexal.md
---

# OI-153 - There is no full UAT sandbox

Stated by Aurel Mrruku at
[the 18/09 internal](../meetings/2026-09-18%20Interna%20Temi%20Mexal.md):

> **_"noi non ce l'abbiamo un ambiente di UAT vero e proprio. Noi abbiamo un
> ambiente di partial e produzione, non abbiamo una full."_**

Everything the plan, the client-facing calendar and this record call "UAT" runs in
a **Partial Copy sandbox**. Corroborated independently: every sandbox URL shared
across Slack and every Salesforce exception mail in this window names
`ability-customization-52152--partial`.

## Why it matters now

- 🔴 **It compounds
  [OI-137](OI-137%20The%20order%20to%20Mexal%20chain%20is%20disabled%20in%20every%20sandbox.md).**
  The order-to-Mexal chain is switched off by an unconditional `isSandbox()`
  guard, so the environment the client accepts in is both a partial copy **and**
  one where the integration does nothing.
- 🔴 **A Partial Copy carries a data subset, not the production dataset.** The
  environment was empty of data until the client's own extraction arrived on
  21/09, and Aurel Mrruku planned a general cleanup of his own test records before
  loading it. Acceptance on 13 October therefore rests on data hand-loaded from
  spreadsheets.
- ⚠ **Nothing in the record ever claimed a Full sandbox existed** — but nothing
  said it did not, and the client-facing plan says "ambiente di UAT" without
  qualification. This is the first time the environment's actual class is in the
  record.

## Open

- 🔴 **Decide whether the client should be told which sandbox class they are
  accepting in**, before the 13 October sign-off. This is a disclosure question,
  not a technical one.
- 🔴 **The UAT user accounts promised for 6–13 October** are to be created in this
  same partial sandbox. Who creates them, and with which permission sets, is
  unassigned — and the 21/09 pre-UAT session had to work around a permissions gap
  by sharing Aurel Mrruku's own login
  ([the session note](../meetings/2026-09-21%20Test%20Interni%20Pre-UAT.md)).
- ⚠ Aurel Mrruku needs **a final record list and a couple of days** to load it.
  The client's extraction arrived 21/09 and is incomplete
  ([OI-154](OI-154%20The%20client%20import%20extraction%20is%20missing%20the%20article%20classification.md)).

## 2026-09-23 — org-status check

Read-only check of Pienissimo UAT, 08:01–08:40Z, `DevMain` at `61f2a53`. Nothing was deployed or changed.

- ⚠ **The org has three active human users, all System Administrators**: Aurel Mrruku, `ROMI COMPANY` and `Amministratore Pienissimo`. The other three active users are integration users. **No client tester account exists yet.** Only **two** users hold `Full_Permission`, the only set that grants the Lead and Opportunity record types. Neither the System Administrator profile nor the guest profile sees them. The client accounts were promised for 6–13 October, so this is not a defect for 24/09. It does mean every session before then runs on ROMI admin logins. (verified)
- ⚠ **`ROMI COMPANY` is shared.** This morning it deployed code that is in no commit ([OI-171](OI-171%20A%20bundle%20discount%20was%20deployed%20to%20UAT%20from%20no%20commit.md)), and the org cannot say which person did it.
