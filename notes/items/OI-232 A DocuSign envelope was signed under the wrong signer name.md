---
id: OI-232
type: open-item
status: open
owner: Aurel Mrruku
org: both
raised: 2026-10-13
updated: 2026-10-13
depends_on: [OI-231]
blocks: [go-live]
source: notes/meetings/2026-10-13 Feedback Test UAT.md
---

# OI-232 - A DocuSign envelope was signed under the wrong signer name

**In the 13 October UAT session Fabrizio Paganelli completed a DocuSign
signature and then noticed he had signed with Aurel Mrruku's name. The
signature completed anyway, the Quote accepted, and an Order was created.**

## What the record says

[The 13/10 Feedback Test UAT](../meetings/2026-10-13%20Feedback%20Test%20UAT.md),
`01:22:50`:

> _"Fabrizio Paganelli ha aperto l'email di Docusign per la revisione e la
> firma, completando la procedura ma accorgendosi di aver firmato
> inavvertitamente con il nome di Aurel mrruku."_

The envelope then completed asynchronously and the downstream chain ran: the
Quote showed completed, an Order was created, and Aurel Mrruku confirmed the
order reached Mexal with status `inviato`.

## Why it is a finding and not a test artefact

The signer name came from **whatever the send populated**, not from the person
who signed. In this run the recipient address was typed by hand into the send
screen (`01:19:58`), and the identity DocuSign presented was Aurel Mrruku's.
Three consequences follow, none of them established either way by this record:

1. 🔴 **The accepted quote carries a signer identity that is not the signer.**
   For a document the client treats as commercially binding, that is the whole
   point of the signature.
2. ⚠ **Whether the send derives the signer from the Quote's contact at all**, or
   takes the running user, is **not established**. If it is the running user, then
   every envelope a ROMI user sends is signable under that user's name.
3. ⚠ **The same mechanism feeds the participation document.**
   [OI-194](OI-194%20The%20ticket%20is%20a%20signed%20participation%20document%20not%20just%20a%20QR%20code.md)
   makes the ticket a *signed* document; a signer-identity defect there reaches
   roughly 2,500 envelopes.

⚠ **It is equally possible this was ordinary test-account confusion** — the
client clicking through a link in a mailbox and a pre-filled name he did not
read. Nothing in the session distinguishes the two, and nobody in the room
treated it as a defect. **Recorded as unresolved, not as a confirmed regression.**

## Open

- 🔴 **Establish where the signer name comes from** on the quote-acceptance
  send — the Quote contact, the Account's principal contact, or the running
  user. Owner: Aurel Mrruku. One look at the send configuration settles it.
- 🔴 **Decide whether the 13/10 envelope is void.** It produced a real Order that
  reached Mexal.
- ⚠ **Check the same path for the participation document** (OI-194).
