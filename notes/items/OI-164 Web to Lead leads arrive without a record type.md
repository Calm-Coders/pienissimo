---
id: OI-164
type: open-item
status: open
owner: Rexhina Hysi
with: Aurel Mrruku
org: ROMI
raised: 2026-09-22
updated: 2026-09-23
depends_on: [OI-149]
blocks: [go-live]
severity: gating
source: Slack DM D0B5QHS2T7H, Elena Spini 2026-09-22 18:18 CEST
---

# OI-164 - Web to Lead leads arrive without a record type

**Elena Spini, testing the Web-to-Lead form at 22/09 18:18 CEST, minutes after
[the pre-UAT session](../meetings/2026-09-22%20Test%20Interni%20Pre-UAT%20Parte%202.md):**

> _"i lead scendono senza record type"_

She posted the submission confirmation alongside it. **The submitted form carried a
`recordType` value and the created Lead has none** — so the parameter is being sent
and not applied.

⚠ The org-side identifiers in her message (org id, record-type id, custom field ids,
the test address) are **deliberately not reproduced here**; the environment is the
**Partial Copy sandbox**.

## Why it matters now

- 🔴 **Lead and Opportunity UAT is 24 September**, and the Lead record types are the
  session's first topic.
- The whole downstream chain depends on the record type:
  [OI-149](OI-149%20Two%20Lead%20record%20types.md) splits `Diretta` from `Standard`,
  and [OI-150](OI-150%20Opportunity%20type%20comes%20from%20a%20Lead%20picklist.md)
  reads the Opportunity type off the Lead. A Lead with no record type enters that
  chain untyped.
- 🔴 **`Diretta` exists precisely for form-borne leads.** A form that cannot set it
  defeats the reason the record type was created.
- ⚠ The Web-to-Lead form was the test Aurel Mrruku had scheduled for **the end of
  23/09** and Elena Spini ran it a day early. Rexhina Hysi had only simulated
  conversion **from inside Salesforce**, which Aurel Mrruku had already called
  _"non proprio un test corretto"_.

## Open

- 🔴 **Diagnose and fix before 24/09.** The likely candidates are the record-type id
  not being honoured for the guest context, the field being overwritten by the
  conversion trigger, or the `Landing Page Profile` lacking access to the record
  type — `54e0be1` (22/09 17:57 CEST, `DEV_leadDiagnose`, PR #55) removes 13 lines
  from that profile in the same commit that adds the record types. **Not diagnosed
  in this sweep; the org was not opened.**
- ⚠ **No answer from Aurel Mrruku is in any source** as at this sweep.

## 🔑 2026-09-23 — diagnosed against the org: the default lead creator cannot see either Lead record type

The 23/09 org-status check (read-only, Pienissimo UAT, 08:01–08:40Z) **confirms the
defect at runtime and finds the cause.** Nothing was changed in the org.

- **Runtime:** all **four** `LeadSource = Web` leads created on 22/09, between 15:10 and
  16:16Z, have **no record type**. Two of them carry `Tipo_Opportunita__c`, so the
  form's hidden fields do arrive. The two leads with a record type (`Diretta` 08:44Z,
  `Standard` 09:22Z) were created **by hand inside Salesforce**. (verified, SOQL aggregate)
- **The creator:** Web-to-Lead leads are created as **`Amministratore Pienissimo`**,
  profile **System Administrator**. (verified)
- 🔑 **The cause:** a reference retrieve of that profile shows `Lead.Diretta` and
  `Lead.Standard` both **`visible=false`, and neither is the default**. The only grant
  of either record type anywhere is the **`Full_Permission`** permission set, and
  **`Amministratore Pienissimo` is not assigned it**. It holds only its profile,
  `Sales_User`, `PipelineInspectionUser` and `SalesEngagementBasicUser`. (verified)
  The record type the form sends is **not available to the creating user**, so the
  platform drops it and the Lead lands on Master. (inferred from platform behaviour, but
  consistent with every observed lead)
- This rules out the other two candidates listed above: the conversion trigger does not
  overwrite the value, and the guest `Landing Page Profile` is not the creating context.
  ⚠ That profile has both Lead record types `visible=false` too, which matters only if
  the form's creating user changes.
- ⚠ The **System Administrator profile also sees none of the three Opportunity record
  types.** Only `Full_Permission` grants them, and **two** active users hold it. See
  [OI-153](OI-153%20There%20is%20no%20full%20UAT%20sandbox.md) for the client UAT
  users, who do not exist yet.

**The fix is a configuration change, not code.** Either make both Lead record types
visible on the creating user's profile with the right default, or assign
`Full_Permission` (or a narrower set) to `Amministratore Pienissimo`. **Decide which
before 24/09.** It was not applied: this check is read-only.
