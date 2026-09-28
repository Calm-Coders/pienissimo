---
id: OI-152
type: open-item
status: open
owner: Elena Spini
org: both
raised: 2026-09-21
updated: 2026-09-21
depends_on: [OI-151]
source: Slack DM Elena Spini to Aurel Mrruku, 2026-09-21 19:46 CEST
---

# OI-152 - The RID mandate form promised to customers does not exist

Raised by Elena Spini in her DM to Aurel Mrruku, **21/09 19:46:08 CEST**, while
working through the contract email copy for
[OI-151](OI-151%20Quote%20signature%20step%20before%20the%20order%20is%20generated.md):

> _"la cosa che mi spaventa un po di più è che nel corpo delle email dice **'Le
> rate successive dovranno essere saldate tramite Rid bancario; riceverai via email
> un modulo già pronto da compilare e firmare.'**"_

and forty-eight seconds later:

> _"ma la parte di sto modulo RID proprio non la trovo 😞"_

## What it means

The client's own contract email copy — the copy ROMI is being asked to reproduce
in Salesforce — **promises the customer a ready-to-sign bank direct-debit (RID)
mandate form, by email, for the instalments after the first.** Elena Spini cannot
find that form anywhere in the material she was given.

So there is a **customer-facing commitment in text the client has already been
sending**, with:

- no artifact,
- no owner,
- no place in the flow that generates or sends it,
- and no requirement covering it.

## Why it matters

- 🔴 **It sits directly on the instalment path**, which is the most fragile area of
  the build: tranches, Performance Plus, and the manual Mexal invoicing step
  ([OI-143](OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md)).
  Every instalment-paying customer receives this sentence.
- 🔴 **If Salesforce sends the email copy verbatim, Salesforce makes the promise.**
  Nothing in the build fulfils it.
- ⚠ **It may exist on the client side and simply not have been shared.** Elena
  Spini's statement is that she cannot find it, which is a claim about the material
  she holds — not proof the form does not exist.
- ⚠ RID mandates carry bank details. **Whatever is decided, no such data belongs in
  this repository.**

## Open

- 🔴 **Ask Elisa Migliano or Fabrizio Paganelli for the RID form**, and for who
  sends it today.
- 🔴 **Decide whether the sentence stays in the Salesforce email copy.** If it
  stays and the form is out of scope, that is a gap the client should agree to
  knowingly.
- ⚠ Payment-date handling is the **5 October** UAT session,
  `Performance Plus + Gestione date pagamento`. That is where a customer-facing
  promise with no mechanism will surface.
