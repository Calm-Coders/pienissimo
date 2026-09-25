---
id: risk-mexal-dev-against-production
type: risk
status: open
severity: high
owner: Aurel Mrruku
with: Andrea Di Cicco
org: ROMI
raised: 2026-09-14
updated: 2026-09-24
depends_on: [OI-125]
requirement: [INT-01, INT-05]
source: Slack DM D0AQ0FMHFM1, Aurel Mrruku and Andrea Di Cicco, 2026-09-14 12:07 CEST
---

# Risk - the Mexal integration is developed against the production ERP

**The Mexal endpoint Salesforce is being built against is Pienissimo's live
billing system. A test customer was created in it from Salesforce on 14
September, and the person who said so was told afterwards.**

## The evidence

Slack DM `D0AQ0FMHFM1`, 14 September, in a thread about the customer-update PUT
([OI-125](../items/OI-125%20Mexal%20customer%20update%20needs%20a%20PUT%20method.md)):

| Time (CEST)  | Who                 | What                                              |
| ------------ | ------------------- | ------------------------------------------------- |
| 12:06:50     | Aurel Mrruku        | _"ho appena testato e va bene"_                   |
| **12:07:03** | **Andrea Di Cicco** | **_"ricordati che è sempre produzione"_**         |
| 12:07:17     | Aurel Mrruku        | _"si ho creato un mio cliente"_                   |
| 12:07:44     | Aurel Mrruku        | _"ho testato direttamente da SF e va todos bien"_ |

Read in order: the test had already run when the reminder arrived, and the
response to the reminder confirms a customer record was created.

## Why it matters

- 🔴 **There is no Mexal sandbox in this project's record.** Every Mexal call
  described anywhere in these notes — the Postman collection, the search service,
  the create and update path, both sync batches, the order chain — targets
  `services.passepartout.cloud` through one named credential. **Nothing
  distinguishes a test target from a live one**, so there is no configuration a
  developer could switch even if they wanted to.
- 🔴 **The live chain is designed to write.** `MexalCustomerCreateService`
  creates customers with `codice = '501.AUTO'`, letting Mexal assign real
  numbers; `MexalOrderSendService` creates orders. When
  [the scheduler is finally switched on](../items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md),
  a batch will run **nightly against production** on a cursor.
- 🔴 **It is the customer's accounting system, not ROMI's.** Records created
  during development sit in Pienissimo's billing data. **At least one test
  customer is now there**, created by Salesforce, and nothing in the record says
  it was removed.
- ⚠ **`anno` is still wrong in two directions** — the collection sends `2025`,
  the code sends the current year — and it is now wrong against a production
  registry, not a scratch one. Unresolved since 10 September.

## What a person must decide

1. **Is there a Mexal test company or environment at all?** Ask Andrea Di Cicco
   or **Mirko Merendi at Kreosoft**. If there is, the named credential should
   point at it for everything before go-live. If there is not, that is a
   constraint the client should be told about explicitly.
2. **What happens to records created during development?** Name who removes the
   test customer(s), or record a decision that they stay.
3. **Do not switch on the nightly schedule against production** until 1 and 2 are
   answered. That is a single `System.schedule` call away, which is precisely the
   danger.

⚠ **Nothing here is inferred about intent.** Andrea Di Cicco's message is a
reminder between colleagues, not an escalation, and both parties were plainly
aware. It is recorded because the project record did not say it anywhere, and the
next person to point the integration at a scheduler needs to know.

## 2026-09-15 — a correction, and a blunt mitigation

### Correction to the 14/09 reading

The sentence above — _"Nothing distinguishes a test target from a live one, so
there is no configuration a developer could switch even if they wanted to"_ — is
**wrong, and was already wrong when it was written**.

`MexalSearchCalloutService.buildEndpoint` has selected between
`Integration_Configuration2__c.Named_Credential_Sandbox__c` and
`Named_Credential_Prod__c` on `Organization.IsSandbox` since **`bc2ed5d`,
10 September** (PR #39), falling back to a default credential when the chosen
field is blank. The same custom setting also carries `Use_Mock__c`,
`Mock_API_Scenario__c` and `Mock_Apex_Class__c`.

**So the switch exists. What is unestablished is whether anything is behind it.**
Only one `Mexal` named credential is in `force-app/main/default/namedCredentials/`,
and **the org was not opened on this run**, so whether
`Named_Credential_Sandbox__c` is populated with a genuinely different target — a
Mexal test company — is unknown. If it is blank or points at the same host, the
fallback sends sandbox traffic to production exactly as described.

⚠ **Question 1 below is therefore sharper, not answered**: the configuration
point exists; what it points at has never been checked. The next
`org-status-check` should read the six `Integration_Configuration2__c` rows and
say.

### The mitigation that did ship

`1830fce` (2026-09-15, merged to `DevMain` in PR #43) makes
`OrderMexalIntegrationService.enqueueForCreatedOrders` return immediately when
`Organization.IsSandbox` is true. **A UAT order can no longer create an order in
Mexal production.** That is a real reduction of this risk and it arrived the
morning after this note was written.

🔴 **It is asymmetric and it costs something.** Only the order path is guarded —
the customer create and update path, the manual Account button and the sync
batches are not, so a sandbox can still write customer records to production
Mexal, which is the exact thing that already happened on 14 September. And the
guard switches the chain off rather than redirecting it, so the integration
cannot be exercised in UAT at all:
[OI-137](../items/OI-137%20The%20order%20to%20Mexal%20chain%20is%20disabled%20in%20every%20sandbox.md).

**Questions 1 and 2 remain unanswered, and nobody has been asked.** Andrea Di
Cicco's DM has carried no message since 14/09 17:28 CEST. Question 3 — do not
schedule against production — is now **three** batches, not two
([the payment return](../objects/The%20Mexal%20payment%20return%20and%20tranche%20roll-up.md)).

## 2026-09-24 — UAT Account import triggered a Mexal customer update

During the user-directed UAT import, two existing Accounts were updated. The
Account trigger started `MexalCustomerUpdateQueueable`. An integration log at
10:37:59 UTC recorded `Mexal_Clienti_Modifica` with HTTP 204 and no error.
Another log from the same run recorded a shipping-address creation failure:
`System.CalloutException: You have uncommitted work pending`. The latter callout
did not leave Salesforce; the customer update did receive a successful HTTP
response. The exact ERP-side record state has not been inspected.

The UAT integration configuration selects the `Mexal` named credential for
both sandbox and production and has `Use_Mock__c = false`. Metadata retrieved
from the UAT org on 24 September confirms its endpoint is
`https://services.passepartout.cloud`. The order-specific sandbox guard did
not prevent the Account-triggered customer update. The affected customer
record should be reconciled in Mexal before further Account updates in UAT.

## 2026-09-24 — commercial-field backfill avoided the trigger path

Before the later UAT Account backfill, the live `AccountTriggerHandler` was
read through Tooling API. It enqueues `MexalCustomerUpdateQueueable` only when
Name, `Email__c`, Phone or Partita IVA changes on an Account with a Mexal code.
No active Account Flow or workflow rule was found. The backfill changed only
new commission-category and activity-type fields, which are outside that
trigger condition. A sample and the complete bulk jobs succeeded; the count
of Mexal customer-update queueable jobs since the metadata deploy stayed zero.
This observation does not resolve the earlier HTTP 204 callout or remove the
risk from future edits to the four watched Account fields.
