---
id: DEC-2026-10-05-plus-renewal-no-signature
type: decision
status: active
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-05
updated: 2026-10-05
depends_on: [OI-151, OI-188]
source: User instruction to Codex on 2026-10-05
---

# Decision - Performance Plus Rinnovo bypasses conditions and signature

The exception applies only when
`Quote.Opportunity.Tipo_Opportunita__c = Performance Plus - Rinnovo`. The logic
must not infer renewal from Product category, Quote lines, or Opportunity record
type.

For that exact Opportunity type:

- the generated Quote PDF omits the contractual conditions component;
- the customer still confirms through the public Quote acceptance page;
- **Accetta** moves the Quote directly to `Firmato` and sets `Is_Signed__c`;
- Salesforce does not enqueue or send a DocuSign envelope; and
- the existing `Firmato` automation generates the Order.

Performance Plus Attivazione and non-Plus Quotes retain their existing PDF and
DocuSign flow.

Implemented locally on 5 October 2026. UAT compile-only dry-run
`0AfMA00000CqyKZ0AZ` succeeded for the two controllers and Visualforce page.
Test dry-run `0AfMA00000Cr44z0AB` passed 37 of 39 existing Quote tests; the two
failures were the already-known stale visible-email-link assertion and unrelated
DocuSign envelope assertion. No Apex test code was changed.
