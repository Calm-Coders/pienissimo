---
id: flow-update-contact-consent-prod
type: flow
status: active
org: ROMI
raised: 2026-07-31
updated: 2026-11-05
source: Pienissimo Prod Tooling API FlowDefinition and Flow plus SetupAuditTrail read on 2026-11-05
uncertain: The human behind ROMI COMPANY and the runtime effect of the Email equals false start filter are not established.
---

# The Update Contact Consent flow in production

Read-only inspection of **Pienissimo Prod**, 2026-11-05. No org changes or
runtime execution were performed.

## Provenance

`Update_Contact_Consent`, label `Update Contact Consent`, was created by the
**ROMI COMPANY** user on **31 July 2026 at 10:22:25 Europe/Rome**. SetupAuditTrail
confirms creation at 10:22:26 by the same user, with no delegated user recorded.
This identifies the Salesforce account, not the individual operating it.

Definition `300SW00000yn80PYAQ`; active and latest version
`301SW00000cm2BMYAY`, version **1**, created at 10:29:05 and last modified at
10:29:39 that morning, also by ROMI COMPANY.

## Configured behavior

- Marketing automation event trigger `IndivRelatedRecord`, object `Contact`,
  `CreateAndUpdate`; it is not an ordinary Contact after-save flow.
- `Get_Consent_Records` reads the first
  `ssot__CommunicationSubscriptionConsent__dlm` record whose
  `ssot__ContactPointValueText__c` equals `$Input.Email`.
- If the returned email equals the input email, the flow ends.
- Otherwise, `Opt_In` calls `createConsent` with the input email and status
  **OptIn**, targeting the **Marketing** communication subscription and the
  **Email** engagement channel in data space `default`.
- No email-send action, Contact record update, Mexal call, or opt-out branch is
  present in this version.

## Configuration concerns

The serialized start condition is **`Email EqualTo boolean false`**. This is
anomalous for an email field; do not reinterpret it as Email is not blank or
claim the flow runs for every Contact. Actual triggering was not tested.

The lookup filters on email only, with no subscription, channel or consent-status
filter. Thus an existing matching consent causes the flow to stop regardless of
its status or subscription. If the create branch is reached, OptIn is fixed;
there is no check of `HasOptedOutOfEmail` or other explicit consent flag in this
flow. This is configuration evidence, not proof of any actual consent created.

## 2026-11-05 evening - it was deactivated for the bulk load, with marketing's agreement

The record above describes the version read in production on the morning of
5 November. That evening it was switched off deliberately. In the marketing group DM:

| Time (CET) | Who | Said |
| --- | --- | --- |
| 17:55 | Aurel Mrruku | _"hai fatto te sto flow in prod? update_contact_consent ti serve?"_, after pasting the inspection findings above |
| 17:58 | Fabrizio Mastracci | _"sisi, **non cancellarlo**"_ |
| 17:59 | Aurel Mrruku | _"**lo disattivo** perche sto facendo caricamento massivo"_ |
| 17:59 | Fabrizio Mastracci | _"ok, no problem"_ |

🟢 **So the deactivation was agreed, not unilateral**, and the owner is now on the
record: **Fabrizio Mastracci** confirms the flow is his and is needed, which the
provenance above could only attribute to the `ROMI COMPANY` account.

🔑 **It was restored as version 2, because this flow type cannot be reactivated.**
Version 2 is logic-identical to v1 (Tooling metadata compared) plus a description;
deploy `0AfSW000001LDjF0AW`, active version **`301SW00000hKT1uYAG`**. The
17,652-contact Referenti load therefore ran with no consent flow and created no
Marketing email Opt-In — see
[OI-290](../items/OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md).

⚠ **The configuration concerns above are unchanged in v2** — the `Email EqualTo
boolean false` start condition and the email-only lookup were carried over, not
fixed. 🔑 They now matter more: the two public website forms collect a consent tick
that has no field to land in
([OI-340](../items/OI-340%20The%20website%20lead%20forms%20have%20no%20field%20for%20the%20marketing%20consent.md)),
so this flow is the only thing creating marketing consent for a new contact, and it
creates `OptIn` without reading any explicit consent flag.
