---
id: OI-95
type: open-item
status: open
owner: Fabrizio Paganelli
with: Elisa Migliano
org: Pienissimo
raised: 2026-08-25
updated: 2026-08-25
depends_on: [OI-94]
blocks: [OI-73]
source: notes/meetings/2026-08-25 Integrazione Anticipay.md
---

# OI-95 - Which Anticipay fields land in Salesforce

**Open, and owned by the client.** The 25 August session agreed that the
middleware returns **only the fields that are actually needed**, not Anticipay's
full response — which Andrea Parmeggiani and Aurel Mrruku both described as
carrying far more information than anyone wants. Nobody has yet said which
fields those are.

**Fabrizio Paganelli and Elisa Migliano hold the action** to analyse the
candidate fields and decide what is worth integrating. No date was given.

The prerequisite is on the other side: **Andrea Parmeggiani owes an example of
every field Anticipay returns**, at Fabrizio Paganelli's request, so the choice
can be made against a real list rather than from memory. Until that arrives this
item cannot move.

## Candidates named in the session

Raised in discussion, none of them decided:

- **ragione sociale** and **rappresentante fiscale** — Andrea Parmeggiani and
  Aurel Mrruku, as the obvious minimum beyond the VAT number itself
- **legale rappresentante**
- **the Anticipay reliability score** for the customer — Fabrizio Paganelli
  wants to know whether the scoring can come across, which would make this a
  credit-risk signal and not only a registry lookup
- **electronic-invoice routing via PEC**

Fabrizio Paganelli framed the whole thing as an opportunity to revisit which
fields Mexal carries too, not only Salesforce — so the answer may widen the
Mexal mapping as well as the Salesforce object.

## Why it matters more than a field list usually would

Two of the candidates are not registry data. **A reliability score is a
commercial judgement about a customer**, and **PEC routing is invoicing
configuration**. Both would put data in Salesforce that nothing in the signed
requirements asks for, on an object the client's own administration reads. Decide
what the field is *for* before agreeing to store it — and check it against
[the publishing rules](../../docs/publishing.md) before any of it reaches the
recaps or [site/](../../site/).

The three-month retention agreed for **error** codes in
[OI-94](OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md)
was not stated to cover the returned **data**. Nobody asked how long the
retrieved company details are kept, or under what basis. That question is
unraised, not answered.
