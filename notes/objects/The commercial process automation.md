---
id: OBJ-commercial-automation
type: object
status: active
owner: Anita Aga
org: ROMI
raised: 2026-09-09
updated: 2026-09-09
depends_on: [DEC-2026-09-08-account-record-types]
blocks: [OI-50, OI-59, OI-121]
source: git DevMain a53345a (PR #37), metadata and Apex read directly 2026-09-09
---

# The commercial process automation

**Commit `a53345a`** (Anita Aga, _"Added automations for opportunity, order and
relating commercial processes to Azienda record type"_), **PR #37**, merged to
`DevMain` by Aurel Mrruku at **18:41 CEST on 9 September** as `0fe07f6`.
**30 files, +1,499 / -74 lines; +729 net Apex lines.**

It is the second half of
[the Azienda/Locale split](../decisions/Decision%20-%20Account%20record%20types%20split%20Azienda%20and%20Locale.md):
PR #35 built the Account record types, this one carries them through
Opportunity, Quote and Order — and, in passing, builds the **quote-to-order
generation** that no code has ever performed.

⚠ **This was read from the repository, not from the org.** Nothing here has been
verified against UAT, and no test was run.

## What it builds

### 1. The Opportunity stage model exists at last

`standardValueSets/OpportunityStage` is now in source control with five values:

| Value                          | Probability | Forecast  | Closed / Won   |
| ------------------------------ | ----------- | --------- | -------------- |
| `Qualificato` (**default**)    | 10          | Pipeline  | —              |
| `In trattativa (Prev inviato)` | 75          | BestCase  | —              |
| `Da ricontattare - Prev. inviato` | 35       | Pipeline  | —              |
| `Chiusa/Vinta`                 | 100         | Closed    | closed **won** |
| `Chiusa/Persa`                 | 0           | Omitted   | closed         |

An `opportunityCustomPath` LWC (252 lines JS, plus markup and CSS) renders the
path.

🟢 **These five match the register character for character** at
`state_machines.opportunity.states`. The looser spelling in
[OI-59](../items/OI-59%20Quote%20workflow%20configuration.md)'s table comes from
the 6 August diagram and is the stale copy — **the build is right**.

🔴 **The Quote states remain the disagreement**, and this commit adds a third
class hard-coding the code spelling rather than the register's. Detail and the
comparison table: [OI-59](../items/OI-59%20Quote%20workflow%20configuration.md).

### 2. The opportunity advances by itself

- `QuoteTriggerHandler` moves an Opportunity from `Qualificato` to
  `In trattativa (Prev inviato)` when a Quote is created, or reaches any of
  `Bozza`, `Nuovo Preventivo`, `In Trattativa`, `In Attesa Accettazione`,
  `Accettato`. Only opportunities actually sitting in `Qualificato` move.
- `OrderTriggerHandler.closeWonOpportunitiesForConfirmedOrders` moves the
  Opportunity to `Chiusa/Vinta` when its Order enters **`Incassato`**.

🟢 The close-won rule is the register's own, implemented as written:
_"Chiusa/Vinta requires at least one quote sent; payment confirms the win."_

🔴 **Nothing moves an opportunity to `Chiusa/Persa`, and nothing implements
`Da ricontattare - Prev. inviato`.** Both are values a user must set by hand. The
day-2 / expiry alerts and the 5-day validity of
[OI-59](../items/OI-59%20Quote%20workflow%20configuration.md) are still unbuilt.

### 3. An accepted quote now generates the order — the first time this has existed

`QuoteTriggerHandler.createOrdersForAcceptedQuotes` fires on a Quote transition
**into `Accettato`** from any other status, and:

- creates one `Order` per quote — `AccountId`, `OpportunityId`, `Pricebook2Id`,
  `EffectiveDate = TODAY`, `Status = 'Ordinato'`, `Quote__c`, `Locale__c`,
  `Origine__c = 'Salesforce'`;
- copies every `QuoteLineItem` to an `OrderItem`, carrying `PricebookEntryId`,
  `Quantity`, `UnitPrice`, `Description`, **`Tranche__c`** and
  **`Data_Scadenza__c`**;
- guards against double generation by querying `Order.Quote__c` for the accepted
  quote ids first.

🟢 **That is the tranche propagation
[OI-50](../items/OI-50%20Tranche%20object.md) has carried as its central gap
since 25 August.** A writer for `OrderItem.Tranche__c` finally exists.

🔴 **DocuSign is absent from the whole diff.** The agreed design has the accepted
quote produce a signed envelope and then the order; this builds the order half
and no envelope. It lands seven days after
[OI-111](../items/OI-111%20DocuSign%20licences%20are%20not%20confirmed%20with%20the%20client.md)
recorded that nobody has confirmed the client owns DocuSign, and **nothing in
the commit connects the two. Ask, do not infer.**

### 4. Locale is carried through the commercial objects

- New `Locale__c` **lookups to Account** on **Opportunity, Order and Quote**,
  each `SetNull` on delete.
- `OpportunityTriggerHandler.normalizeCommercialAccounts` (before save): if an
  Opportunity is booked against a `Locale` Account, it resolves the parent
  through `CommercialAccountResolver`, **moves the locale into `Locale__c` and
  rewrites `AccountId` to the parent Azienda**. This is exactly the
  normalisation the decision note asked for.
- `QuoteTriggerHandler.copyLocaleFromOpportunity` (before save) inherits the
  opportunity's locale onto the quote when blank, and **raises a field error if
  the two disagree** — _"Il Locale del Preventivo deve coincidere con il Locale
  dell'Opportunita."_
- Validation rule `Opportunity.Locale_must_belong_to_azienda`: the chosen locale
  must be of record type `Locale` **and** have the opportunity's Account as its
  parent.
- `WoocommerceOrderService` now stamps `RecordTypeId = Azienda` on accounts it
  creates, and **throws `WooCommerceOrderException` when the record type is not
  found**.

⚠ **That last point is a new hard failure mode on a live inbound route.** A shop
order arriving at an org without the `Azienda` record type fails outright where
it previously created an account. In UAT the record type exists (PR #35); in
**production, which has never been deployed to**, it does not.

### 5. Lead conversion was refactored, not changed

`LeadConversionTriggerHandler` (248 lines) is new and `LeadConversionQueueable`
loses 57 lines and gains 191. Read as an **extract-to-handler refactor** rather
than a behaviour change; the trigger now delegates. ⚠ **Not verified line by
line** — if lead-conversion behaviour matters to a later question, diff it
properly.

## What it does not change

- 🔴 **`assignCampaigns` still throws** when no active `Mappatura_Edizione__c`
  row matches a ticket-generating product at the order date, and it still runs
  on the transition into `Incassato`
  ([OI-121](../items/OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md)).
  The new quote-to-order path creates orders in `Ordinato`, so it does not fire
  the throw at creation — it creates more orders that will later meet it.
- 🔴 **Nothing writes `Tranche__c` on orders that did not come from a quote** —
  WooCommerce orders and hand-created ones still have none.
- 🔴 **Tranche payment aggregation is still unbuilt.**
  `Completamente_Pagata__c` remains a checkbox nothing computes.
- 🔴 **No test class was added**, and none should be —
  [coverage is a separate task](../decisions/Decision%20-%20Apex%20coverage%20is%20not%20a%20Fase%201%20concern.md)
  Aurel Mrruku requests in one pass. The **+729 Apex lines** are recorded in
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)
  as brief, not as an action.

## Why this needs a second look

🔴 **The unauthenticated community page can now create records.**
`QuoteAcceptanceController.act()` sets `Status = 'Accettato'` on a quote
identified by a bare id, with no application-level authentication. Before this
commit that flipped a picklist. After it, the same anonymous click **inserts an
Order and its OrderItems** — and drives the Opportunity's stage. The blast
radius of
[the community authentication risk](../risks/Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md)
grew without the risk being reconsidered.
