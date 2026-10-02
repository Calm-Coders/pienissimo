---
id: OI-160
type: open-item
status: open
owner: Fabrizio Paganelli
org: both
raised: 2026-09-22
updated: 2026-10-02
depends_on: [OI-143]
blocks: [go-live]
source: notes/meetings/2026-09-22 Test Mexal.md
---

# OI-160 - Payment conditions cannot vary by order line

**Asked by the client on 22/09 at 11:22 and answered by the Mexal vendor at 15:00
the same day. The answer is no, and the agreed remedy is to change how the business
sells.**

## What the client wanted

Fabrizio Paganelli and Elisa Migliano want a **coded payment condition per block of
order lines** — his example `A1` meaning 50% now, 50% later — instead of what happens
today: the tutor writes the plan in the **order notes**, and administration reads the
note and **edits the payment method by hand before issuing each invoice**.

His worked case at
[the 11:22 session](../meetings/2026-09-22%20Logiche%20Spacchettamento%20Righe.md):
a tutor bundle where one block is due 30/09 and an Academy block is invoiced 31/12
with 50% on 31/12 and 50% on 31/01.

## The vendor's answer

Mirko Merendi, at
[Test Mexal](../meetings/2026-09-22%20Test%20Mexal.md):

- The payment condition exists **only on the order header**, never on the line.
- **The only field available on an order line is the due date.**
- There are **no hidden fields** in Mexal. Additional line-data views exist but
  require constant manual interaction, and extra descriptions **get printed on the
  invoice** unless removed by hand.

## The decision

🔴 **Unanimous: do not force the system.** The header condition commands, so any
per-line plan would mean editing every generated invoice by hand. The group chose to
**adapt commercial behaviour** instead. Fabrizio Paganelli will **delete the obsolete
payment-condition codes and create new structured ones for use with Salesforce**,
deliberately kept loose because customers move between bonifico, Ri.Ba. and recovery
plans.

## What is still unresolved

- 🔴 **Nobody has defined what "adapt commercial behaviour" means.** No rule, no
  owner, no date. The tutors are the people who would have to change, and no tutor
  was in either session.
- 🔴 **The Mastery has no mechanism.** A single high-value ticket (~€6,0xx) cannot be
  split into several product lines — _"non posso mettere più righe per lo stesso
  biglietto"_ — so a split payment plan on one ticket has neither the tranche
  mechanism nor a payment condition. Fabrizio Paganelli deferred it:
  _"ragioniamoci."_ It is the case
  [OI-142](OI-142%20Fractional%20product%20records%20for%20tranche%20payment.md) was
  invented for, and the only case that survives it.
- ⚠ **The new payment-condition codes are owed** and will need mapping into
  Salesforce.
- ⚠ Elena Spini left the Test Mexal session before this was closed and flagged the
  topic for a later pass with Aurel Mrruku and Fabrizio Paganelli.

## 2026-10-02 - the four Mexal payment codes are live in UAT

Aurel Mrruku supplied `Codici Pagamento.xlsx` (Fabrizio Paganelli, 24/09 10:08:51Z,
_"sono solo 4"_) and set the design: **picklist API name = Mexal code, label =
description**, the API name goes to Mexal, the field keeps the name **Condizione di
Pagamento**, and the values live in a **Global Value Set** so Quote and Order share them.

- New GVS `Condizione_di_Pagamento` with the four codes. `Condizione_di_Pagamento__c`
  on **Quote** now uses it; a new field of the same name on **Order** uses it too.
- The quote → order copy (`QuoteTriggerHandler`) and the Mexal send
  (`MexalOrderSendService`, `id_pagamento`) now read `Condizione_di_Pagamento__c`.
  The PDF prints its label via `toLabel`. Both page layouts show it.
- `Codice_Pagamento_Mexal__c` (text, Quote + Order) is **no longer read or written by
  any code** and was empty in UAT; it is left in place, not deleted.
- 🟢 **Deployed to Pienissimo UAT** (`0AfMA00000CpvqB0AR`, `NoTestRun`) after Aurel
  Mrruku promoted the Quote field's local picklist to the GVS in Setup — the Metadata
  API refuses that conversion (_"Cannot change which global value set this picklist
  uses"_). Both fields verified restricted with the four values.
  `MexalIntegrationTest` passed against the change (50/50) in a rolled-back run; the
  deploy went without tests because UAT enforces per-class coverage and the classes
  covering `QuoteTriggerHandler` / `QuotePdfController` are not in UAT, while
  `QuoteCommercialTest` fails **15 of 19 in UAT before and after this change**
  (`INVALID_CROSS_REFERENCE_KEY` on `RecordTypeId`) — see
  [OI-64](OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md).
- ⚠ One UAT test quote still holds the retired value `RID FINE MESE DF`; it will fail
  the restricted picklist on its next save until re-set.
- In Prod neither field exists; a deploy creates both directly on the GVS.
- ⚠ The five-vs-four discrepancy from the 24/09 call is still unreconciled, and the
  **new structured codes** promised on 22/09 have not arrived — these four are the
  24/09 file.
