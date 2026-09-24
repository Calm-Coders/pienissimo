---
id: OI-178
type: open-item
status: open
owner: Aurel Mrruku
with: Rexhina Hysi
org: ROMI
raised: 2026-09-24
updated: 2026-09-24
depends_on: [OI-169]
blocks: [go-live]
severity: gating
source: git, DevMain 64b2843 vs DEV_LeadAgenteBundle 7eab757
---

# OI-178 - Two agent field implementations exist on two branches

**Two people built the agent on the account on consecutive days, by different names,
and neither branch knows about the other.**

| Branch | Commit | Metadata |
| ------ | ------ | -------- |
| **`DevMain`** | `64b2843`, 24/09 13:03 CEST, Aurel Mrruku | `Account.Codice_Agente_Esterno__c`, `Account.External_CRM_ID__c`, the `Agente` **profile**, the `Agente` **permission set**, `Account_Import_UAT` permission set, `scripts/prepare_account_new_import.py` |
| **`DEV_LeadAgenteBundle`** | `7eab757`, 23/09 18:47 CEST, Rexhina Hysi | `Agente__c` on **Account, Lead, Quote and User**, the `Require_Agente_When_Qualificato` validation rule, +129 lines on `LeadConversionQueueable` |

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
