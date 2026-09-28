---
id: OI-138
type: open-item
status: open
owner: Aurel Mrruku
with: Elisa Migliano
org: both
raised: 2026-09-16
updated: 2026-09-17
depends_on: [OI-59]
blocks: [go-live]
requirement: [ORD-01, SAL-17]
source: notes/meetings/2026-09-16 Data Model Parte 5.md
---

# OI-138 - Quotes and orders freeze once the order is accepted

**Once a quote is won and its order is accepted, both records become
immutable — no line added or removed, no price changed, no article code
changed.** Agreed at
[Data Model Parte 5](../meetings/2026-09-16%20Data%20Model%20Parte%205.md) on
16 September. **Nothing implements it.**

## What was agreed

Elisa Migliano asked the question directly — can a tutor change an article code
inside an order once the quote has become one? Aurel Mrruku's answer, confirmed
in the room:

> _"in Sales[force] c'è l'entità offerta e c'è anche l'entità ordine e tu le
> modifiche le fai sull'entità offerta. Se l'offerta è stata vinta viene creato
> l'ordine e poi viene sigillato sia l'offerta che l'ordine."_
>
> _"Quando dico sigillato l'offerta vuol dire che l'offerta proprio non la puoi
> toccare, non puoi fare nessuna modifica."_

Elisa Migliano's reason for asking is the one that matters: **the contract sits
under the order**. Her own restatement — _"una volta che il cliente ha accettato
l'ordine e che c'è ordine accettato, quell'ordine [è] congelato"_.

Aurel Mrruku's reason is integrity: _"se cambia il codice articolo cambiano i
prezzi, cambia tutto"_ — the article code is the key the Mexal invoice and the
edition mapping both resolve through.

So the rule has two independent justifications, one contractual and one
technical, and both parties stated one.

## Why it is not already covered

Nothing in the register says a quote or an order is immutable at any point.
`ORD-01` describes the order **state machine**
(`Ordinato → Fatturato → Incassato`); a state machine constrains the status
field, not the lines. `SAL-17` is the order-acceptance and contract procedure,
still `open` and owned by Marco Montesi and Elisa Migliano. **Neither says the
record seals.**

⚠ **No register row was created for this tonight.** The rule is minuted and
agreed by both sides, but the register is contract-bound and this sweep does not
invent requirement ids — see the report. **A person should decide whether this
becomes a numbered requirement before the client signs**, because it is the kind
of rule that is only noticed when it is missing.

## What is actually exposed

The freeze is the **only** thing standing between an accepted contract and a
tutor editing what it says. Right now:

- `QuoteTriggerHandler` copies `Tranche__c` and `Data_Scadenza__c` from quote
  line to order line when the quote is accepted
  ([the commercial process automation](../objects/The%20commercial%20process%20automation.md)).
  Nothing prevents either record being edited afterwards.
- The **public quote acceptance page** is `public without sharing` and takes a
  bare `quoteId`
  ([the authentication risk](../risks/Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md)).
  A rule that seals the quote at acceptance also bounds what that page can be
  made to do later.
- `OrderItem` gained `Mexal_Payment_Status__c` and the tranche roll-up on
  16 September (PR #45,
  [the build](../objects/The%20Mexal%20payment%20return%20and%20tranche%20roll-up.md)).
  Those fields **must stay writable by the integration** after the freeze, so
  "immutable" cannot mean a blanket record lock.

That last point is the design question. The freeze must distinguish **what a
person may change** from **what the integration must keep changing**, and the
session did not go near that distinction.

## What a person must decide

1. **Where the boundary sits.** Lines, prices and article codes are named.
   Status, payment status, tranche roll-up and Mexal integration fields are
   written by automation after acceptance and cannot be frozen.
2. **What "accepted" means mechanically** — `Quote.Status` reaching a named
   value, `Order.Status` reaching one, or the Order simply existing. The quote
   state spellings are themselves still unreconciled
   ([OI-59](OI-59%20Quote%20workflow%20configuration.md)), so a rule keyed on them
   inherits that ambiguity.
3. **Whether anybody can unfreeze**, and who. Real contracts get amended;
   a seal with no documented exception becomes a support ticket.
4. **Whether this is a validation rule, field-level security, or a record
   lock.** Each fails differently, and only the first gives the user a sentence
   they can act on.

⚠ **Not estimated.** It arrived on 16 September, seven days before UAT opens.

## 2026-09-17 - stated a fourth time, internally, and the contract model behind it is still undefined

At [the 17/09 internal follow-up](../meetings/2026-09-17%20Follow-up%20Interno.md)
(`01:11:11`) the rule was restated in the same terms: after acceptance **both
the quote and the order are frozen and no longer modifiable**.

⚠ **This is a ROMI-internal restatement, not a new client statement** — no
Pienissimo attendee was present. It adds no authority to the rule; it shows the
rule has been absorbed by the team that has to build it.

🔴 **What the same passage adds is a gap.** The contract data model and its
activation field _"restano da definire completamente"_ — and the freeze now has
to coexist with a Contract record that is created automatically at order
transmission and then updated from Mexal with invoiced and collected amounts
([OI-141](OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md)).
**That is a second writer after acceptance**, alongside the tranche roll-up this
row already names. The seal cannot be a blanket record lock, and the list of
legitimate post-acceptance writers is now two and growing, with nobody
maintaining it.
