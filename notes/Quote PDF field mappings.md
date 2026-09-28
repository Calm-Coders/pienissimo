---
id: quote-pdf-field-mappings
type: reference
status: active
updated: 2026-09-21
source:
  - force-app/main/default/pages/QuotePdf.page
  - force-app/main/default/classes/QuotePdfController.cls
  - force-app/main/default/components/QuotePdfStandardContract.component
  - force-app/main/default/components/QuotePdfContract.component
---

# Quote PDF field mappings

This note maps the two source-controlled quote PDF templates to their Salesforce
data sources.

The shared Visualforce page is
[QuotePdf.page](../force-app/main/default/pages/QuotePdf.page). It is populated
by
[QuotePdfController.cls](../force-app/main/default/classes/QuotePdfController.cls).

## Template selection

| PDF template               | Condition                                                                      | Source file                                                                                                   |
| -------------------------- | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------- |
| Standard quote PDF         | `Quote.Opportunity.RecordType.DeveloperName` is not `Plus_Attivazione_Rinnovo` | [QuotePdfStandardContract.component](../force-app/main/default/components/QuotePdfStandardContract.component) |
| Performance Plus quote PDF | `Quote.Opportunity.RecordType.DeveloperName = Plus_Attivazione_Rinnovo`        | [QuotePdfContract.component](../force-app/main/default/components/QuotePdfContract.component)                 |

## Standard quote PDF

| PDF field or section     | Salesforce source                                                                                                                                           |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Logo                     | Static resource `QuotePdfLogo`                                                                                                                              |
| Pienissimo company block | Static text in `QuotePdf.page`                                                                                                                              |
| Customer name / cliente  | `Quote.Account.Name`; fallback `Quote.BillingName`                                                                                                          |
| Legal representative     | `Quote.Account.Nome_Legale_Rappresentante__c`                                                                                                               |
| Quote number             | `Quote.QuoteNumber`                                                                                                                                         |
| Generated date           | `Date.today()` in Apex, formatted by `QuotePdfController.formatDate`                                                                                        |
| Billing address          | `Quote.BillingStreet`, `Quote.BillingPostalCode`, `Quote.BillingCity`, `Quote.BillingState`, `Quote.BillingCountry`                                         |
| Billing address fallback | `Quote.Account.BillingStreet`, `Quote.Account.BillingPostalCode`, `Quote.Account.BillingCity`, `Quote.Account.BillingState`, `Quote.Account.BillingCountry` |
| VAT / P.IVA              | `Quote.Account.Partita_IVA__c`                                                                                                                              |
| Expiration date          | `Quote.ExpirationDate`                                                                                                                                      |
| Tutor commerciale        | `Quote.Opportunity.Owner.Name`                                                                                                                              |
| Currency                 | `Quote.CurrencyIsoCode` when multicurrency is enabled; otherwise `UserInfo.getDefaultCurrency()`                                                            |
| Summary amount           | `Quote.TotalPrice`                                                                                                                                          |
| Line product name        | `QuoteLineItem.Product2.Name`                                                                                                                               |
| Line description         | `QuoteLineItem.Description`                                                                                                                                 |
| Quantity                 | `QuoteLineItem.Quantity`                                                                                                                                    |
| List price               | `QuoteLineItem.ListPrice`                                                                                                                                   |
| Amount / importo         | Derived as `QuoteLineItem.Quantity * QuoteLineItem.UnitPrice`                                                                                               |
| Discount shown           | Derived as `(QuoteLineItem.Quantity * QuoteLineItem.UnitPrice) - QuoteLineItem.TotalPrice`                                                                  |
| Net total                | `QuoteLineItem.TotalPrice`                                                                                                                                  |
| Payment due date         | `QuoteLineItem.Data_Scadenza__c`; fallback `QuoteLineItem.Tranche__r.Data_Scadenza__c`                                                                      |
| Subtotal                 | `Quote.Subtotal`                                                                                                                                            |
| Total net                | `Quote.TotalPrice`                                                                                                                                          |
| Tax                      | `Quote.Tax`; shown only when non-zero                                                                                                                       |
| Shipping                 | `Quote.ShippingHandling`; shown only when non-zero                                                                                                          |
| Grand total              | `Quote.GrandTotal`                                                                                                                                          |
| Payment method text      | `Quote.Modalita_Pagamento_PDF__c`; section shown only when populated                                                                                        |
| Notes                    | `Quote.Description`; section shown only when populated                                                                                                      |

## Performance Plus quote PDF

| PDF field or section      | Salesforce source                                                                                                                                           |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Logo                      | Static resource `QuotePdfLogo`                                                                                                                              |
| Pienissimo company block  | Static text in `QuotePdf.page` and `QuotePdfContract.component`                                                                                             |
| Customer name / cliente   | `Quote.Account.Name`; fallback `Quote.BillingName`                                                                                                          |
| Legal address in contract | `Quote.Account.BillingStreet`, `Quote.Account.BillingPostalCode`, `Quote.Account.BillingCity`, `Quote.Account.BillingState`, `Quote.Account.BillingCountry` |
| VAT / P.IVA               | `Quote.Account.Partita_IVA__c`                                                                                                                              |
| Legal representative      | `Quote.Account.Nome_Legale_Rappresentante__c`                                                                                                               |
| PEC                       | `Quote.Account.PEC__c`                                                                                                                                      |
| Quote number              | `Quote.QuoteNumber`                                                                                                                                         |
| Generated date            | `Date.today()` in Apex, formatted by `QuotePdfController.formatDate`                                                                                        |
| Billing address           | `Quote.BillingStreet`, `Quote.BillingPostalCode`, `Quote.BillingCity`, `Quote.BillingState`, `Quote.BillingCountry`                                         |
| Billing address fallback  | `Quote.Account.BillingStreet`, `Quote.Account.BillingPostalCode`, `Quote.Account.BillingCity`, `Quote.Account.BillingState`, `Quote.Account.BillingCountry` |
| Expiration date           | `Quote.ExpirationDate`                                                                                                                                      |
| Tutor commerciale         | `Quote.Opportunity.Owner.Name`                                                                                                                              |
| Currency                  | `Quote.CurrencyIsoCode` when multicurrency is enabled; otherwise `UserInfo.getDefaultCurrency()`                                                            |
| Summary amount            | `Quote.TotalPrice`                                                                                                                                          |
| Line product name         | `QuoteLineItem.Product2.Name`                                                                                                                               |
| Line description          | `QuoteLineItem.Description`                                                                                                                                 |
| Quantity                  | `QuoteLineItem.Quantity`                                                                                                                                    |
| List price                | `QuoteLineItem.ListPrice`                                                                                                                                   |
| Amount / importo          | Derived as `QuoteLineItem.Quantity * QuoteLineItem.UnitPrice`                                                                                               |
| Discount shown            | Derived as `(QuoteLineItem.Quantity * QuoteLineItem.UnitPrice) - QuoteLineItem.TotalPrice`                                                                  |
| Net total                 | `QuoteLineItem.TotalPrice`                                                                                                                                  |
| Payment due date          | `QuoteLineItem.Data_Scadenza__c`; fallback `QuoteLineItem.Tranche__r.Data_Scadenza__c`                                                                      |
| Payment method text       | `Quote.Modalita_Pagamento_PDF__c`; section shown only when populated                                                                                        |
| Notes                     | `Quote.Description`; section shown only when populated                                                                                                      |

## Generation-only fields

These fields affect PDF generation or template selection but are not printed as
ordinary PDF values.

| Purpose                               | Salesforce source                                                                    |
| ------------------------------------- | ------------------------------------------------------------------------------------ |
| Quote record id passed to Visualforce | Page parameter `id`, cast to `Quote.Id`                                              |
| Draft-only generation guard           | `Quote.Status = Bozza`                                                               |
| Template branch                       | `Quote.Opportunity.RecordType.DeveloperName`                                         |
| Line ordering                         | `QuoteLineItem.SortOrder`, then `QuoteLineItem.CreatedDate`, then `QuoteLineItem.Id` |
| Maximum supported lines               | Controller limit: 500 `QuoteLineItem` rows                                           |
