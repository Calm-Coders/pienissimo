---
id: quote-pdf-generation-bozza
type: reference
status: in-progress
org: ROMI
raised: 2026-09-16
updated: 2026-09-16
source: User request and locally supplied seven-page sample PDF, 2026-09-16
---

# Quote PDF generation for Bozza quotes

Implemented in local source on 16 September 2026. Not deployed or verified in
Salesforce. The user explicitly requested no test classes, no deployment and
no edits to existing Markdown files; this new note is the session handoff.

## Behavior

- **Genera PDF** appears on the Quote record page only for `Status = Bozza`.
  The action and Visualforce controller independently enforce that status.
- The action allows optional payment instructions. Changed instructions are
  saved to `Quote.Modalita_Pagamento_PDF__c` in a separate UI API transaction,
  with a last-modified check, before rendering. They remain saved if rendering
  subsequently fails. No status change is performed by the generator.
- Apex renders the Visualforce page and creates a new Salesforce File linked
  to the Quote. The action shows success and an **Apri PDF** preview button.
  Each intentional subsequent generation creates a separate file; earlier
  documents remain available. Repeated clicks during generation are disabled.
- The service checks and locks the Quote after rendering and before saving,
  rejecting a Quote that has left Bozza. Queries and the File insert run in
  user mode; record sharing, object access and field permissions apply.
- Empty Quotes and Quotes with more than 500 lines are rejected. Missing
  optional values remain blank. Missing permissions produce an error, not a
  partially populated customer document.

## Template and mappings

The supplied document has five contract pages followed by a variable quote
section. Its contract and Performance Plus annex text are preserved in a
Visualforce component, with explicit section page breaks. The original logo
was extracted as a PNG static resource. Customer-specific values in the sample
were replaced with merge fields; the original PDF is not copied into the repo.
No sample customer identity, catalogue prices or article codes are recorded here.

| PDF content                         | Source                                                                    |
| ----------------------------------- | ------------------------------------------------------------------------- |
| Fixed contract and annex            | `QuotePdfContract.component`, supplied Performance Plus text              |
| Contract customer and legal address | `Quote.Account.Name` and Account billing address                          |
| VAT, representative and PEC         | `Account.Partita_IVA__c`, `Nome_Legale_Rappresentante__c`, `PEC__c`       |
| Quote number and document date      | `Quote.QuoteNumber` and generation date                                   |
| Invoice address                     | Quote billing address, falling back to Account billing address            |
| Valid until                         | `Quote.ExpirationDate`, omitted if absent                                 |
| Commercial tutor                    | `Quote.Opportunity.Owner.Name`                                            |
| Article and description             | `QuoteLineItem.Product2.Name` and line `Description`                      |
| Quantity and list price             | Line `Quantity` and `ListPrice`                                           |
| Gross amount                        | Line `Quantity * UnitPrice`                                               |
| Discount amount                     | Gross amount minus Salesforce `TotalPrice`                                |
| Net amount                          | Salesforce line `TotalPrice`                                              |
| Payment deadline                    | Line `Data_Scadenza__c`, otherwise tranche `Data_Scadenza__c`             |
| Totals                              | Quote `Subtotal`, `TotalPrice`, `Tax`, `ShippingHandling`, `GrandTotal`   |
| Currency                            | Quote currency when multi-currency is enabled, otherwise default currency |
| Payment instructions                | `Quote.Modalita_Pagamento_PDF__c`, editable in the action                 |
| Notes                               | `Quote.Description`                                                       |

Lines preserve Salesforce sort order, with creation time and ID as deterministic
tie-breakers. The line table repeats its header across pages. Dates use
`dd/MM/yyyy`; monetary values use Italian separators. The document uses stored
Salesforce totals and does not recalculate tax or infer payment terms. Currency
is stated for the table rather than repeated in every cell.

The fixed template is specifically **Performance Plus** for every generation,
as requested for this sample. There is no automatic selection of different
contracts by product. Account billing address is the available legal-address
mapping, and Opportunity owner is the commercial-tutor mapping; neither was
validated against a live org in this session. This is a reconstruction of the
layout, not a pixel-identical copy or a signature integration.

## Source and later setup

- [PDF service](../force-app/main/default/classes/QuotePdfService.cls)
- [PDF data controller](../force-app/main/default/classes/QuotePdfController.cls)
- [PDF page](../force-app/main/default/pages/QuotePdf.page)
- [Fixed contract](../force-app/main/default/components/QuotePdfContract.component)
- [Lightning action](../force-app/main/default/lwc/quoteGeneratePdf/quoteGeneratePdf.js)
- [Quote record page](../force-app/main/default/flexipages/Quote_Record_Page.flexipage-meta.xml)
- [Permission set](../force-app/main/default/permissionsets/Quote_PDF_Generation.permissionset-meta.xml)

After a separately authorized deployment, assign **Quote PDF Generation** to
users who already have commercial access to Quotes, line items, Products,
Accounts and Opportunities, and permission to create Salesforce Files. This
additive permission set grants the new Apex classes, Visualforce page, custom
fields used by the PDF and read access to tranches. Record sharing still applies.
The action is wired to `Quote_Record_Page`; other assigned record pages would
need the same action. Payment instructions are editable directly in the action,
so no existing Quote page layout was changed.

## Validation and remaining checks

Local checks: Apex syntax parsed by the Prettier Apex parser; Lightning JS and
HTML compiled with the installed LWC compiler; ESLint and metadata XML parsing
passed. Contract extraction replaced the sample customer and PEC, and a source
scan checked for the sample customer's identifiers. These are local checks,
not Salesforce compilation or an execution test.

`vault:check` was run and is blocked by an existing broken link in
`notes/How the Quote acceptance email action works.md`, pointing to the absent
`Quote_Acceptance_Email.permissionset-meta.xml`. The new note's links passed;
the existing note was not edited. Five non-blocking trace warnings also remain.

Live rendering, pagination, actual permission assignments and File preview
remain to be checked after an authorized deployment. Check a discounted Quote,
multiple pages of lines, an empty Quote, missing dates, insufficient permissions,
and a status change during generation. The new Apex has no test classes or
measured coverage; the existing coverage records were left unchanged under the
user's explicit restriction on editing existing Markdown.

The code index could not answer because its Ollama provider was unavailable.
The requested intelligence refresh also failed because Python is not installed;
source discovery therefore used direct metadata inspection.
