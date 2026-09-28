---
id: OI-178
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Rexhina Hysi
org: ROMI
raised: 2026-09-24
updated: 2026-09-25
depends_on: [OI-169]
blocks: [go-live]
severity: gating
source: git, DevMain 64b2843 vs DEV_LeadAgenteBundle 7eab757
---

# OI-178 - Two agent field implementations exist on two branches

**Two people built the agent on the account on consecutive days, by different names,
and neither branch knows about the other.**

| Branch                     | Commit                                    | Metadata                                                                                                                                                                                                  |
| -------------------------- | ----------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`DevMain`**              | `64b2843`, 24/09 13:03 CEST, Aurel Mrruku | `Account.Codice_Agente_Esterno__c`, `Account.External_CRM_ID__c`, the `Agente` **profile**, the `Agente` **permission set**, `Account_Import_UAT` permission set, `scripts/prepare_account_new_import.py` |
| **`DEV_LeadAgenteBundle`** | `7eab757`, 23/09 18:47 CEST, Rexhina Hysi | `Agente__c` on **Account, Lead, Quote and User**, the `Require_Agente_When_Qualificato` validation rule, +129 lines on `LeadConversionQueueable`                                                          |

Verified against the checked-out branches: `Codice_Agente_Esterno__c` exists **only** on
`DevMain`, `Agente__c` exists **only** on `DEV_LeadAgenteBundle`, and `DevAnita` has
neither.

## Why this is a problem, not a duplicate note

The two are not the same field wearing two names:

- **`Codice_Agente_Esterno__c` is a code**, populated from the client's customer
  extraction during the 24/09 UAT account import. **8,140 accounts already carry it.**
- **`Agente__c` is a relationship** — a lookup pattern carried across four objects, with
  a validation rule hanging off it.

🔴 **What the client was shown on 24/09 is the second one.** The `Qualificato` block was
demonstrated live and the client agreed to it, and that behaviour lives on the unmerged
branch. **What is in `DevMain`, and in the imported UAT data, is the first one.**

🟢 `DEV_LeadAgenteBundle` **now has a pull request** — **#59, opened 24/09 08:06Z, still
open**. The 23/09 finding that it had none is discharged. But it is unmerged, so the
field the client accepted is on neither `DevMain` nor UAT.

## What has to be decided

- Whether the agent on the account is **a code, a user lookup, or both** — Mexal wants
  `cod_agente`, a code; the Lead validation wants a selectable user.
- Whether the 8,140 loaded values migrate to whichever field survives, or whether both
  fields stay with a defined relationship between them.
- 🔴 **Merging PR #59 without resolving this puts two agent fields on Account**, one
  populated and one empty, in front of client users.

## Open

- 🔴 **Reconcile the two before PR #59 merges.**
- ⚠ [OI-169](OI-169%20Agent%20code%20and%20commissions%20come%20from%20the%20customer%20record.md)
  still lacks `zona` and `categoria provvigioni cliente`; Mirko Merendi supplied their
  Mexal API names on 24/09 (`cod_zona`, `cod_cat_pr`) and neither branch has them.

## 🔴 2026-09-25 — both fields are now on DevMain

**PR #59 (`DEV_LeadAgenteBundle`) merged at 08:24:45Z**, followed by PR #61
(`DEV_fixController`, 10:06Z). `origin/DevMain` at `ab318f3` now carries
**`Account.Agente__c` and `Account.Codice_Agente_Esterno__c` side by side**, plus
`User.Agente__c`. The case this item warned about has happened: the reconciliation did
not precede the merge. Which field the Mexal payload and the migration read is now a
DevMain question, not a branch question.

## ✅ 2026-09-25 — decided via drill-me: keep both, with a sync

Aurel Mrruku chose to **keep both fields with defined roles**:

- **`Account.Agente__c`** (User lookup) is the agent for people and validation: the
  `Qualificato` rule, Lead/Quote logic, and what the client accepted on 24/09.
- **`Account.Codice_Agente_Esterno__c`** (text) is the **Mexal-facing code**, the value
  sent as `cod_agente`, with its 8,140 imported values kept.
- **A sync keeps them in step** (trigger or flow, not yet chosen). Accepted cost: two
  sources of truth to maintain. The gain: no dependency on every User record carrying a
  code.

## Open (after the decision)

- 🔴 **Build the sync.** Direction, and what wins on conflict, are not defined: lookup →
  code (from `User.Agente__c`), or code → lookup, or both.
- ⚠ The sync must not fire a Mexal customer-update callout on every Account it touches.
  The 24/09 import already sent one to the live endpoint (see
  [the risk](../risks/Risk%20-%20the%20Mexal%20integration%20is%20developed%20against%20the%20production%20ERP.md)).
