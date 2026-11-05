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
