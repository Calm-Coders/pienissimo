---
id: RISK-lead-conversion-queueable
type: risk
status: resolved
owner: Aurel Mrruku
with: Anita Aga
org: ROMI
raised: 2026-08-27
updated: 2026-08-28
depends_on: [OI-100]
source: Salesforce error mail, 2026-08-27T15:08:13Z, job 707MA00000jTvGJ
resolved_by: org-status-check 2026-08-28T14:45-14:56Z
---

# Risk - LeadConversionQueueable is broken in the Pienissimo sandbox

> ✅ **Resolved 2026-08-28 by an org inspection.** The condition described below
> no longer holds in the org: `Lead.Servizio_Interesse__c` **exists**, and
> **neither** the deployed class **nor** the repository's copy selects it. Read
> [the resolution](#2026-08-28---resolved-against-the-org) before acting on
> anything in this note. The account of 27 August is kept intact because it was
> written **without org access** and its central inference turned out to be
> wrong — that is worth keeping, not overwriting.

**A Lead-conversion job failed at runtime in the Pienissimo partial sandbox on
27 August 2026 at 15:08:13Z**, and the class that failed is **not the class in
this repository**.

Salesforce sent the unhandled-exception mail to `a.mrruku@romicompany.com`:

```
Organization: Pienissimo srl (ability-customization-52152--partial.sandbox.my.salesforce.com)
Failed to process Queueable job for class LeadConversionQueueable for job ID 707MA00000jTvGJ.
caused by: System.QueryException: No such column 'Servizio_Interesse__c' on entity 'Lead'.
Class.LeadConversionQueueable.execute: line 22, column 1
```

## What the repository says

`force-app/main/default/classes/LeadConversionQueueable.cls:22` is the opening
line of the `execute` method's SOQL:

```apex
List<Lead> leadsToConvert = [
  SELECT Id, FirstName, LastName, Company, Email, OwnerId, Status, IsConverted
  FROM Lead
  ...
```

**It does not select `Servizio_Interesse__c`.** The line number matches exactly,
so the org is running a version of this class with that field added to the same
SELECT.

Meanwhile `Lead.Servizio_Interesse__c` **does exist in `force-app/`** — a 255
character Text field, described as _"Servizio o prodotto di interesse indicato
dal Lead, usato per lettura commerciale e routing iniziale"_ — committed with
the Lead flow work in `225b172 Added logic for Lead flux`, and referenced from
the Lead layout and the `Lead_Management` permission set.

## So the org and the repository have diverged, both ways at once

| | In `force-app/` | In the partial sandbox |
| - | --------------- | ---------------------- |
| `LeadConversionQueueable` selecting `Servizio_Interesse__c` | ❌ no | ✅ yes (it threw) |
| `Lead.Servizio_Interesse__c` | ✅ yes | ❌ **absent** — that is what the error says |

The likely reading is a **partial deploy**: the class went to the sandbox with
the field in its query, the field's metadata did not. Two alternatives that
have not been ruled out — the field was deployed and later removed, or the class
in the org is hand-edited and was never committed.

⚠ **Not the `sf sobject describe` false negative.** That pattern
([the method note](../How%20to%20read%20the%20org%20schema%20without%20a%20false%20negative.md),
and [OrderItem.Tranche__c](Risk%20-%20OrderItem%20Tranche%20is%20invisible%20to%20every%20user.md))
is about a field being invisible to the running **user**. This is a SOQL
compilation failure inside Apex, which resolves fields against the org's schema,
not the user's permissions. Treat the field as genuinely missing — but confirm
against the org, because this note was written **without org access**.

## What it costs

- 🔴 **Lead conversion does not run in the partial sandbox.** Every qualified
  Lead handed to this queueable dies. `LeadConversionTrigger` →
  `LeadConversionTriggerHandler` → `LeadConversionQueueable` is the whole path.
- 🔴 It is a **silent** failure from the business side: a queueable throws to an
  error mail, not to the user who qualified the Lead.
- The Lead flow is fresh work — merged into `DevMain` in the
  `DevAnitaSeptember` line — so this is most likely a deploy-hygiene defect from
  the last few days, not an old wound.
- It sits directly under
  [OI-100](../items/OI-100%20Same%20lead%20email%20with%20different%20VAT%20during%20conversion.md),
  which asks Aurel Mrruku to decide how conversion should treat a repeated email
  with a different VAT. **That question cannot be tested against an org where
  conversion throws.**

## What closes it

Deploy `Lead.Servizio_Interesse__c` to the partial sandbox, **or** retrieve the
org's copy of `LeadConversionQueueable` into `force-app/` and reconcile the two.
Either way the repository and the org must end up agreeing — this is the same
disease as
[the build ahead of the record](../objects/The%20build%20ahead%20of%20the%20record.md)
and
[the Biglietto Apex stack not in source control](Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md),
seen from the other side.

**Do not write an Apex test for this.** Coverage is a separate task Aurel Mrruku
requests in one pass before the production deploy —
[the deploy risk](Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md).

## 2026-08-28 - Resolved against the org

The `org-status-check` run of **2026-08-28, 14:45–14:56Z** against
`00DMA000004nMMr2AM` (partial sandbox, API 67.0) inspected exactly the two facts
this note could not, and **both come back the other way**:

| | 27 Aug — inferred, no org access | 28 Aug — inspected |
| - | -------------------------------- | ------------------ |
| `Lead.Servizio_Interesse__c` in the org | ❌ absent (_"that is what the error says"_) | ✅ **exists** |
| Deployed `LeadConversionQueueable` selects it | ✅ yes (_"it threw"_) | ❌ **no** |

The run further reports that the org-vs-repo difference in this class is
**Prettier line-wrapping only, semantically identical**, and that all other
deployed Apex is byte-identical to source. So the divergence table above — the
"diverged both ways at once" reading — describes a state that is not there.

**The two-line fix is therefore not needed**: nothing has to be deployed and
nothing has to be retrieved and reconciled.

### What the 15:08:13Z failure actually was, and what it was not

The error mail is a **real, dated event** and is not in question — a job did
throw, in that org, at that minute. What is now excluded is the standing
condition inferred from it. The most economical reading consistent with both
observations is that the exception recorded a **transient state on 27 August**
which was subsequently corrected — a partial deploy that later completed, or a
class version rolled forward — between the failure and the following afternoon.

⚠ **This is a reconstruction, not an observation.** Nothing in the record shows
who changed what, or when, between 27/08 15:08Z and 28/08 14:45Z. Do not write
it up as though someone fixed it deliberately, and do not attribute it.

### What it leaves open

- 🟢 **[OI-100](../items/OI-100%20Same%20lead%20email%20with%20different%20VAT%20during%20conversion.md)
  is unblocked.** It was blocked here solely because conversion was believed to
  throw in the only org available to test it. That reason is gone; the question
  itself — how conversion should treat a repeated email with a different VAT —
  is untouched and still needs Aurel Mrruku.
- The **method** stands and is the lesson worth keeping: an error mail proves an
  event, never a standing state. This note said so itself — _"confirm against the
  org, because this note was written without org access"_ — and the confirmation
  is what overturned it. Read
  [how to read the org schema without a false negative](../How%20to%20read%20the%20org%20schema%20without%20a%20false%20negative.md)
  alongside it: the 25 August `OrderItem.Tranche__c` finding failed the same way
  in the opposite direction.

**Basis for this section: the org, inspected 2026-08-28.** This sweep did not
open the org itself; it is recording a run that did.
