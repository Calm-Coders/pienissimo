---
id: OI-164
type: open-item
status: open
owner: Rexhina Hysi
with: Aurel Mrruku
org: ROMI
raised: 2026-09-22
updated: 2026-09-22
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
