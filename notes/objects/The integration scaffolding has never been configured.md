---
id: obj-integration-scaffolding-empty
type: object
status: active
owner: Aurel Mrruku
org: ROMI
raised: 2026-08-26
updated: 2026-08-26
depends_on: [OI-58, OI-49, OI-73, OI-94]
source: org-status-check against Pienissimo UAT, 2026-08-26
evidence: SOQL counts on Integration_Configuration__c and Integration_Log__c, NamedCredential listing
---

# The integration scaffolding has never been configured

[ROMI's standard integration scaffolding](../Integration%20Configuration%20is%20standard%20ROMI%20scaffolding.md)
is deployed in Pienissimo UAT and **holds no configuration and no history**.

| Component                                  | State in the org                           |
| ------------------------------------------ | ------------------------------------------ |
| `Integration_Configuration__c` (16 fields) | **zero records**                           |
| `Integration_Log__c` (10 fields)           | **zero records**                           |
| `API_Callout_Engine` (109 lines of Apex)   | zero coverage, no log implies it never ran |
| `NamedCredential`                          | **one — `DocuSign`**                       |
| `RemoteSiteSetting`                        | **zero**                                   |

`Integration_Configuration__c` is the row that tells `API_Callout_Engine` where
to call, with what method, and whether to mock. With no rows, **no outbound
integration on this project has an endpoint defined in the org**. With no
`Integration_Log__c` rows, nothing has been called through the engine and
succeeded or failed — the log is written on both paths.

## What this settles, per integration

None of these is a new decision; each is the build state of a decision already
recorded elsewhere.

- **Mexal** ([OI-58](../items/OI-58%20Mexal%20integration%20mechanics.md)) — no
  endpoint row, no named credential, no log. The mapping work of 24 August has
  no counterpart in the org.
- **WooCommerce** ([OI-49](../items/OI-49%20WooCommerce%20checkout-link%20flow.md))
  — no endpoint row and no credential. The `WooCommerce_Product_Id__c` and
  `WooCommerce_Order_Id__c` fields exist and are populated on **zero records**.
  Credentials were expected 26 August.
- **VAT via the Pienissimo middleware**
  ([OI-73](../items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md),
  [OI-94](../items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md))
  — nothing, which is correct: the payload example is owed by Andrea Parmeggiani
  on 4 September and nothing is buildable before it. Recorded here so the
  absence reads as _expected_ rather than as a gap.

**DocuSign is the exception and the proof.** It is the one integration with a
named credential, and it is the one that has demonstrably run: 19 of the 37
`Biglietto__c` records carry a `DocuSign_Envelope_Id__c`. It does not use this
scaffolding — it runs through the org-only `BigliettoDocuSignService` /
`BigliettoDocuSignQueueable` classes, which are
[not in source control](../risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).

## Why record it

`API_Callout_Engine` is committed to `force-app/`, so a reader checking "is the
integration layer built?" finds 109 lines of working engine and concludes the
plumbing is in place. It is — and it is wired to nothing. The engine is not the
integration; the configuration row is. This is the same shape of misreading as
[the build ahead of the record](The%20build%20ahead%20of%20the%20record.md)
describes, one level down.

Do **not** re-flag the scaffolding itself as unrequested implementation — that
is already recorded and settled.
