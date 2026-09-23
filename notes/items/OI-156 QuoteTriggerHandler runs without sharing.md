---
id: OI-156
type: open-item
status: open
owner: Anita Aga
org: ROMI
raised: 2026-09-18
updated: 2026-09-23
depends_on: [OI-136]
blocks: [go-live]
severity: gating
source: git 2d31ebe on DevMain via PR #50
escalation_source: git ab47b42 on DEV_leadDiagnose via PR #55
---

# OI-156 - QuoteTriggerHandler runs without sharing

`2d31ebe` (Anita Aga, 18/09 18:20:32 CEST) changes one line:

```diff
-public with sharing class QuoteTriggerHandler {
+public without sharing class QuoteTriggerHandler {
```

**Merged to `DevMain` in PR #50 on 2026-09-21T11:00:06Z**, so it is in the branch
UAT deploys from, three days before the client tests.

## Why it is a finding

- **Sharing enforcement was removed from the quote trigger**, which runs on every
  quote insert and update — including the ones reached from the **public community
  quote page**. `QuoteAcceptanceController` is already `public without sharing` on
  a bare `quoteId`, a standing finding since 16/09.
- **The likely motive is on record, obliquely.** At
  [the 21/09 pre-UAT session](../meetings/2026-09-21%20Test%20Interni%20Pre-UAT.md)
  Rexhina Hysi attributed a quote-creation failure to **community guest-user
  permissions**. Widening the handler makes that failure go away. ⚠ **Nobody has
  written down that this is why**, and the inference is not attributed to anyone.
- **No requirement authorises it.** No PR description, no review, no comment.
- 🔴 **It is the same shape as
  [OI-136](OI-136%20Public%20participant%20link%20can%20mark%20an%20order%20Incassato.md)**:
  a guest-reachable write path widened so a flow would work, discovered by reading
  the diff rather than from any decision.
- ⚠ **It is one line inside a 1,068-line commit** titled about the Manage Products
  component — the same pattern that hid the `isSandbox()` guard inside PR #43 on
  15/09 ([OI-137](OI-137%20The%20order%20to%20Mexal%20chain%20is%20disabled%20in%20every%20sandbox.md)).
  Two of the three most severe security findings on this project have arrived as
  incidental lines in large, undescribed commits.

## Open

- 🔴 **Establish whether the widening is necessary**, and if it is, scope it — a
  targeted `without sharing` helper rather than the whole handler.
- 🔴 **If it exists to serve the guest quote page, that is a design decision about
  what an unauthenticated visitor may write**, and it belongs with whoever ruled
  on the equivalent question for the participant page. **Nobody ruled on that one
  either.**
- ⚠ Verify in the org what the community guest profile can actually reach through
  it. This note is repository arithmetic; **the org was not opened.**

## 🔴 ESCALATED 2026-09-22 — four more, and the commit message says so

`ab47b42` (**Rexhina Hysi, 22/09 09:52:51 CEST, `DEV_leadDiagnose`**), whose subject
line is _"batch to updated state and **added some without sharing**"_:

```diff
-public with sharing class QuoteAcceptanceEmailController {
+public without sharing class QuoteAcceptanceEmailController {
-public with sharing class QuoteLineItemTriggerHandler {
+public without sharing class QuoteLineItemTriggerHandler {
-public with sharing class QuoteLineItemsController {
+public without sharing class QuoteLineItemsController {
```

plus a **new class created that way**: `QuoteNegotiationAgingBatch` is
`public without sharing` from its first line.

**Open in PR #55 against `DevMain`** as at this sweep. Together with
`QuoteTriggerHandler` and `QuoteAcceptanceController`, that makes **five classes in the
quote stack running without sharing enforcement**, plus a scheduled batch.

⚠ **For context**, `origin/DevMain` at `cf9b6b6` already carries eleven
`without sharing` classes: `API_Callout_Engine`, `ContactTriggerHandler`,
`EventInvitationService`, `ParticipantCommunityUrl`, `ParticipantRegistrationController`,
`ProductCodeTriggerHandler`, `QuoteAcceptanceController`, `QuotePdfController`,
`QuotePdfService`, `QuoteTriggerHandler`, `WoocommerceOrderService`. This is now a
**house style on the guest-reachable paths**, not an isolated line.

## What changes about the finding

- 🟢 **It is no longer hidden.** The commit says what it did, which is an improvement on
  `2d31ebe`.
- 🔴 **It is still undecided.** No requirement, no PR description, no review, and still
  nothing in the record stating that guest-user access is the reason.
- 🔴 **`QuoteAcceptanceEmailController` is the sharpest of the three**: the same commit
  rewrites it heavily (+124/-…) and adds a `Quote_Acceptance_Request` email template, so
  the class that composes and sends the customer-facing acceptance mail now runs with
  sharing off.
- ⚠ **The armed trigger of 21/09 fires**: _"if `QuoteTriggerHandler` is still
  `without sharing` when UAT opens, and no note records why."_ It is, nothing does, and
  **four more were added the day before UAT opens.**

## 🔑 The same commit changes the quote state machine

`QuoteNegotiationAgingBatch` implements `Batchable` and `Schedulable`, job name
`Quote Negotiation Aging - Daily`, cron `0 0 3 * * ?`: a quote in **`In Trattativa`** for
**5 days** — measured on a new `In_Trattativa_Dal__c` field, falling back to
`LastModifiedDate` — is moved to **`In Attesa Accettazione`**.

- 🟢 **It implements an already-agreed rule.** The register's `state_machines.quote`
  carries _"Validity 5 days"_ and _"'In attesa di accettazione' is the new label for the
  former 'preventivo scaduto'"_. This is that rule, automated — the first movement on the
  quote state machine in fifteen days.
- ⚠ **It confirms which labels are stale.** The code uses `In Trattativa` and
  `In Attesa Accettazione`; the register carries `"In trattativa (Prev inviato)"` and
  `"In attesa di accettazione"`. The register's own reconciliation block already flags
  this and says an org check does not amend the register — **so a human still owns it.**
- 🔴 **The register's other quote rules are not implemented here**: no day-2 alert to
  tutor and client, and no alert at expiry. The batch only advances the state.

## 2026-09-23 — org-status check

Read-only check of Pienissimo UAT, 08:01–08:40Z, `DevMain` at `61f2a53`. Nothing was deployed or changed.

- ⚠ **The 22/09 changes are on `DevMain` but not in UAT.** `force-app/` has **19** classes declared `without sharing`. The org has **15**: `LeadConversionQueueable`, `QuoteLineItemTriggerHandler`, `QuoteLineItemsController` and `QuoteNegotiationAgingBatch` still run `with sharing` in UAT. So what the client tests is not what `DevMain` would deploy. **Whether those four should change is still undecided.** Deploying `DevMain` for [OI-170](OI-170%20DevMain%20is%20ahead%20of%20UAT%20on%20the%20Lead%20conversion%20and%20quote-line%20paths.md) makes that decision by default. (verified)
