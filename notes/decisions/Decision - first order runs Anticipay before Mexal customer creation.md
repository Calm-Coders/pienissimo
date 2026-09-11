---
id: DEC-2026-09-11-first-order-antici-pay-before-mexal-customer
type: decision
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-11
updated: 2026-09-11
depends_on: [OI-73, OI-94, OI-95, OI-116, OI-125]
source: Aurel Mrruku, direct instruction to the agent session, 2026-09-11
---

# Decision - first order runs Anticipay before Mexal customer creation

**For the first Order of an Account, Salesforce must run Anticipay first and
only then create the customer in Mexal.** This resolves the overlap between the
Anticipay Account enrichment and the Mexal customer creation call.

## First Order For An Account

When an Order is created for an Account that has no previous Orders:

1. Salesforce creates a queued job.
2. The queued job calls Anticipay.
3. Salesforce waits for the Anticipay response.
4. Salesforce updates the Account with the Anticipay response data.
5. After the Account update, Salesforce starts the queued Mexal customer
   creation step.
6. Mexal creates the customer.
7. Salesforce waits for the Mexal response.
8. Salesforce updates `Account.Codice_Cliente_Mexal__c` with the Mexal customer
   code returned by the create response.
9. The same queued integration chain then creates/sends the Order to Mexal.

No Mexal update call is needed in this first-order path, because the decision
assumes this is the Account's first Order and the customer is not already created
in Mexal.

## Later Orders For The Same Account

When an Order is created for an Account that already has at least one previous
Order:

1. Salesforce does not call Anticipay again.
2. Salesforce creates a queued job for Mexal.
3. The Mexal call uses the customer update flow, not the customer creation flow.
4. The update is the `Modifica Cliente` path, keyed by
   `Account.Codice_Cliente_Mexal__c`.
5. The same queued integration chain then creates/sends the Order to Mexal.

## Queue Rule

Both paths must run through queued/asynchronous work. The integration should not
perform these external calls inline in the Order trigger. The queued work also
owns the Order creation/send step toward Mexal, after the customer create/update
step has completed.

## Meaning Of The Decision

The ordering is intentional: Anticipay enriches the Salesforce Account first, so
the first customer creation sent to Mexal uses the refreshed Account data.

This decision does not activate the Mexal update button or the Order-to-Mexal
flow by itself. It records the sequencing rule that the later implementation
must follow.
