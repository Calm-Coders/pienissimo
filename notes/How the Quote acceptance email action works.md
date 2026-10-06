---
id: ref-quote-acceptance-email-action
type: reference
status: active
updated: 2026-10-05
source: force-app/main/default/classes/QuoteAcceptanceEmailController.cls
---

# How the Quote acceptance email action works

Local implementation created on 16 September 2026. On 5 October the composer
was corrected so its documented editable-body behavior is implemented end to
end. The correction is not deployed. No Apex test classes were created.

Final UAT compile-only dry-run `0AfMA00000Cqyh90AB` succeeded for the controller
and LWC bundle. Test dry-run `0AfMA00000CqyPO0AZ` passed 18 of 20 existing
`QuoteDocumentsTest` methods. One failure is the now-obsolete assertion that the
visible draft contains the URL; the other is the unrelated DocuSign envelope
assertion in `envelopeIsSentWithTheSigningPdf`. The selected controller reported
71.1% coverage because no Apex test code was added for this change.

## User flow

The Quote quick action **Invia per accettazione** opens an email composer. Apex
allows it when Quote.Status is `In Trattativa` or `In Attesa Accettazione`, and
checks the status again when sending, so changing the status while the composer
is open prevents sending.

The initial recipient is `Quote.Account.Email_Contatto_Principale__c`, maintained
by the existing Contact trigger. It uses the Quote Account, not the selected
Locale or Quote Contact. If the email is blank, the user must enter one. A Quote
without an Account cannot use the action.

Recipient, subject and plain-text body are editable. The Italian default subject
identifies the Quote number; the visible body includes its number and name but
does not expose the system-managed acceptance instruction, URL or closing
signature. When sending, Apex appends the call-to-action followed by `Grazie, Il
team Pienissimo`. The HTML version renders the link as an **Apri il preventivo**
button; the plain-text alternative shows the full URL. The URL uses the current
org's Experience Cloud hostname and the current Quote Id, so the same source
resolves the correct sandbox or production site.

The composer shows this system-managed footer below the editable textarea as a
locked preview. Its **Apri il preventivo** control is visual only and cannot be
clicked; the instruction, button and signature cannot be edited. The button is
clickable only in the delivered email. Final UAT LWC dry-run
`0AfMA00000Cr0So0AJ` compiled the non-clickable preview successfully.

The same page supports acceptance and rejection. The email does not itself
change the Quote status. The user cannot edit or remove the link because it is
not part of the visible draft. No message is sent until the user clicks **Invia
email**. Cancel closes without sending.

The sender is the running Salesforce user through `Messaging.SingleEmailMessage`.
The action accepts one recipient, a nonblank single-line subject of at most 255
characters and a nonblank body of at most 32000 characters. It prevents repeat
clicks during a request and preserves the draft on failure. A successful response
means Salesforce accepted the send request, not that delivery was confirmed.
Activity logging is enabled and linked to the Quote through `setWhatId`; repeated
intentional sends are allowed.

## Placement and permissions after a future deployment

No Quote layout or Lightning record page is present in this checkout. The action
metadata is supplied without replacing an unknown existing org page.

1. Add `Quote.Invia_Per_Accettazione` to the existing Quote Lightning record page
   using Dynamic Actions in the highlights panel.
2. Set its visibility filter to show the action when **Record > Status** is
   either `In Trattativa` or `In Attesa Accettazione`.
3. Grant intended users access to `QuoteAcceptanceEmailController` and the
   `quoteAcceptanceEmail` component through the chosen permission model. No
   dedicated permission set exists in this checkout. Their existing permissions
   must allow reading Quote and the linked Account, including
   `Email_Contatto_Principale__c`; the queries run in user mode.
4. Email deliverability and sender configuration must permit sending in that org.

The visibility filter hides the button; the Apex check enforces the status rule
even if the action is exposed elsewhere. The URL is an explicit sandbox constant
in the controller and must be reviewed before any production deployment.

## Source

- [Controller](../force-app/main/default/classes/QuoteAcceptanceEmailController.cls)
- [Composer](../force-app/main/default/lwc/quoteAcceptanceEmail/quoteAcceptanceEmail.js)
- [Template](../force-app/main/default/lwc/quoteAcceptanceEmail/quoteAcceptanceEmail.html)
- [Quick action](../force-app/main/default/quickActions/Quote.Invia_Per_Accettazione.quickAction-meta.xml)

## Review scenarios for the eventual org validation

- Waiting Quote with a primary-contact email: defaults and current Id are correct.
- Missing email: manual entry is required; edited recipient, subject and body are sent.
- Status other than `In Trattativa` or `In Attesa Accettazione` at open or after
  opening: the server blocks sending.
- Invalid recipient or blank content: validation blocks sending; Apex appends
  the current acceptance link automatically.
- Send failure: draft remains editable; success closes the composer.
- Cancel: no send and no Quote update.
