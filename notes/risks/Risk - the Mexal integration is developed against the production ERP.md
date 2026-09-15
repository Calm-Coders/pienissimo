---
id: risk-mexal-dev-against-production
type: risk
status: open
severity: high
owner: Aurel Mrruku
with: Andrea Di Cicco
org: ROMI
raised: 2026-09-14
updated: 2026-09-14
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

| Time (CEST) | Who              | What                                            |
| ----------- | ---------------- | ----------------------------------------------- |
| 12:06:50    | Aurel Mrruku     | _"ho appena testato e va bene"_                 |
| **12:07:03**| **Andrea Di Cicco** | **_"ricordati che è sempre produzione"_**   |
| 12:07:17    | Aurel Mrruku     | _"si ho creato un mio cliente"_                 |
| 12:07:44    | Aurel Mrruku     | _"ho testato direttamente da SF e va todos bien"_ |

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
