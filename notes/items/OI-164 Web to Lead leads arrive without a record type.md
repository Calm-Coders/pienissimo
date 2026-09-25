---
id: OI-164
type: open-item
status: resolved
owner: Rexhina Hysi
with: Aurel Mrruku
org: ROMI
raised: 2026-09-22
updated: 2026-09-24
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

## 🔴 2026-09-23 — the root cause was published at 10:26 CEST and the defect was still live at 18:28

**The fix did not happen today.** The morning org check named the cause and the
configuration change; the evening found the symptom unchanged.

| Time (CEST)  | Event                                                                                                            |
| ------------ | ---------------------------------------------------------------------------------------------------------------- |
| 08:01–08:40Z | Org check finds the cause: `Amministratore Pienissimo` sees neither Lead record type and lacks `Full_Permission` |
| 10:26:46     | Posted to the dev group as step 1 of three, _"before tomorrow's Lead UAT"_                                       |
| 12:51:05     | Elena Spini, DM: _"questo per caso avete fatto il check? domani vorrei far vedere il lead diretta"_              |
| 16:35–18:09  | Internal dress rehearsal ([Test Pre Demo](../meetings/2026-09-23%20Test%20Pre%20Demo.md))                        |
| **18:28:13** | 🔴 **Elena Spini, DM: _"il rt è sempre blank"_**                                                                 |
| 18:47:45     | Aurel Mrruku: _"domani in mattinata fanno le ragazze che mi stavo occupando di docusign."_                       |

🔴 **The fix is now scheduled for the morning of the UAT day**, hours before the client
session at 15:00 CEST, and it is delegated because Aurel Mrruku spent the evening on
[OI-174](OI-174%20ROMI%20mail%20blocks%20DocuSign%20envelopes%20to%20the%20dev%20team.md).

### A second requirement arrived with the same message

Elena Spini, same DM, **18:28:13 CEST**:

> _"dal rt Diretta mi aspetto solo 2 status (new/qualificato) del lead (avevamo detto
> possiamo togliere anche il path e ciao)"_

🔑 **The `Diretta` record type should expose only two lead statuses** — `New` and
`Qualificato` — and she is content to drop the path assistant on that record type
entirely. ⚠ This is a **new expectation about an existing build**, stated the evening
before the session that tests it, and **nothing in the record says it was accepted**.
`7eab757` (18:47 CEST, `DEV_LeadAgenteBundle`, unmerged) touches
`Default.pathAssistant-meta.xml` and the Lead layout, but whether it narrows the status
picklist per record type is not established here.

🟢 She also confirmed the cosmetic work landed: _"grazie per aver messo i colori e resto
tutto + carino"_ — Anita Aga's branding set and Lightning theme, `7d0f990` / PR #57.

## 🟢 2026-09-24 — RESOLVED. Leads now carry a record type; they carry the wrong one

**The fix landed on the morning of the UAT day, as scheduled.** `ec2dcfe`
(`DEV_LeadAgenteBundle`, 24/09 10:02 CEST, Rexhina Hysi, **PR #59**) adds
`Lead_Diretta.pathAssistant`, `Lead_Standard.pathAssistant` and a
`Require_Tipo_Opp_When_Qualificato` validation rule.

🟢 **In the 15:00 CEST client session both record types were present and selectable.**
Aurel Mrruku at `00:44:08`: _"Qua hai le due record type"_, creating a `Standard` lead by
hand. The created leads carry a record type. **The defect this note records — a Lead
landing with none — is closed.**

🟢 **Elena Spini's second expectation is met exactly.** She asked on 23/09 for the
`Diretta` record type to expose only `New` and `Qualificato`. The delivered
`Lead_Diretta.pathAssistant` has precisely two steps:

| Step          | Field prompted |
| ------------- | -------------- |
| `New`         | `Company`      |
| `Qualificato` | `Agente__c`    |

⚠ She had said she was content to **drop** the path assistant on `Diretta`; what was built
is a two-step path rather than no path. The states are as she asked.

### 🔴 The defect that replaces it

Every lead the form creates is typed **`Diretta`**, including those that should be
`Standard`. Elena Spini in session (`00:41:46`): _"Sono tutti record type diretta… quindi
è sbagliato"_, and in the DM at 15:43:58 CEST: _"nulla mette solo rt diretta"_. That is a
different fact with a different cause and it has its own row →
[OI-176](OI-176%20Web%20to%20Lead%20assigns%20every%20lead%20the%20Diretta%20record%20type.md).

⚠ **`ec2dcfe` is on a branch, not on `DevMain`.** PR #59 was open as at this sweep, so the
path assistants and the new validation rule are in neither `DevMain` nor, by this
repository's arithmetic, UAT. The session ran against the org, which had them.
