---
id: ref-quote-acceptance-email-action
type: reference
status: active
updated: 2026-09-16
source: force-app/main/default/classes/QuoteAcceptanceEmailController.cls
---

# How the Quote acceptance email action works

Local implementation created on 16 September 2026. Not deployed or verified in
an org. No Apex test classes were created. Existing Markdown files were not changed.

## User flow

The Quote quick action **Invia per accettazione** opens an email composer. It
loads only when Quote.Status is exactly `In Attesa Accettazione`. Apex checks
the status again when sending, so changing the status while the composer is
open prevents sending.

The initial recipient is `Quote.Account.Email_Contatto_Principale__c`, maintained
by the existing Contact trigger. It uses the Quote Account, not the selected
Locale or Quote Contact. If the email is blank, the user must enter one. A Quote
without an Account cannot use the action.

Recipient, subject and plain-text body are editable. The Italian default subject
identifies the Quote number; the body includes its number, name and acceptance
link. The URL uses the supplied partial-sandbox site and the current Quote Id:

`https://ability-customization-52152--partial.sandbox.my.site.com/gestione-preventivo?quoteId=<current Quote Id>`

The same page supports acceptance and rejection. The email does not itself
change the Quote status. The link must remain in the body; both client and Apex
reject a submission without it. No message is sent until the user clicks
**Invia email**. Cancel closes without sending.

The sender is the running Salesforce user through `Messaging.SingleEmailMessage`.
The action accepts one recipient, a nonblank single-line subject of at most 255
characters and a nonblank body of at most 32000 characters. It prevents repeat
clicks during a request and preserves the draft on failure. A successful response
means Salesforce accepted the send request, not that delivery was confirmed.
Activity logging is disabled; repeated intentional sends are allowed.

## Placement and permissions after a future deployment

No Quote layout or Lightning record page is present in this checkout. The action
metadata is supplied without replacing an unknown existing org page.

1. Add `Quote.Invia_Per_Accettazione` to the existing Quote Lightning record page
   using Dynamic Actions in the highlights panel.
2. Set its visibility filter to **Record > Status > Equals > In Attesa Accettazione**.
3. Assign the supplied `Quote_Acceptance_Email` permission set to intended users.
   Their existing permissions must allow reading Quote and the linked Account,
   including `Email_Contatto_Principale__c`; the queries run in user mode.
4. Email deliverability and sender configuration must permit sending in that org.

The visibility filter hides the button; the Apex check enforces the same rule
even if the action is exposed elsewhere. The URL is an explicit sandbox constant
in the controller and must be reviewed before any production deployment.

## Source

- [Controller](../force-app/main/default/classes/QuoteAcceptanceEmailController.cls)
- [Composer](../force-app/main/default/lwc/quoteAcceptanceEmail/quoteAcceptanceEmail.js)
- [Template](../force-app/main/default/lwc/quoteAcceptanceEmail/quoteAcceptanceEmail.html)
- [Quick action](../force-app/main/default/quickActions/Quote.Invia_Per_Accettazione.quickAction-meta.xml)
- [Permission set](../force-app/main/default/permissionsets/Quote_Acceptance_Email.permissionset-meta.xml)

## Review scenarios for the eventual org validation

- Waiting Quote with a primary-contact email: defaults and current Id are correct.
- Missing email: manual entry is required; edited recipient, subject and body are sent.
- Wrong status at open or after opening: the server blocks sending.
- Missing link, invalid recipient or blank content: validation blocks sending.
- Send failure: draft remains editable; success closes the composer.
- Cancel: no send and no Quote update.
