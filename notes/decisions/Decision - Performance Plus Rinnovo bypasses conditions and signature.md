---
id: DEC-2026-10-05-plus-renewal-no-signature
type: decision
status: active
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-05
updated: 2026-10-05
depends_on: [OI-151, OI-188]
source: User instruction to Codex on 2026-10-05
---

# Decision - Performance Plus Rinnovo bypasses conditions and signature

The exception applies only when
`Quote.Opportunity.Tipo_Opportunita__c = Performance Plus - Rinnovo`. The logic
must not infer renewal from Product category, Quote lines, or Opportunity record
type.

For that exact Opportunity type:

- the generated Quote PDF omits the contractual conditions component;
- the customer still confirms through the public Quote acceptance page;
- **Accetta** moves the Quote directly to `Firmato` and sets `Is_Signed__c`;
- Salesforce does not enqueue or send a DocuSign envelope; and
- the existing `Firmato` automation generates the Order.

Performance Plus Attivazione and non-Plus Quotes retain their existing PDF and
DocuSign flow.

Implemented locally on 5 October 2026. UAT compile-only dry-run
`0AfMA00000CqyKZ0AZ` succeeded for the two controllers and Visualforce page.
Test dry-run `0AfMA00000Cr44z0AB` passed 37 of 39 existing Quote tests; the two
failures were the already-known stale visible-email-link assertion and unrelated
DocuSign envelope assertion. No Apex test code was changed.

## 🟢🔑 2026-10-05 (later) - the client confirmed this in the room

This decision was written from an internal instruction. It now has client
agreement, taken at
[the 05/10 Performance Plus UAT](../meetings/2026-10-05%20UAT%20Performance%20Plus%20e%20Gestione%20date%20pagamento.md)
with Fabrizio Paganelli, Elisa Migliano, Sabatino Rinaldi and Marco Montesi
present, and recorded there as a `Concordato`:

> _"**Gestione dei rinnovi contrattuali senza Docusign** — Per i rinnovi dei
> contratti Performance Plus è stato stabilito di non utilizzare Docusign,
> inviando direttamente l'ordine tramite Salesforce e impostando lo stato
> direttamente su firmato."_

Fabrizio Paganelli gave the reason: the twelve-month contract renews tacitly,
so _"non è necessario inviare né far firmare un nuovo contratto completo"_ —
but a record must still be generated that tracks the new contractual period,
which is the Contract object's purpose per
[OI-141](../items/OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md).

🔑 **Two refinements the original decision does not carry.**

- **Only the last page goes out** — the quote/order summary table, not the full
  document. Agreed between Aurel Mrruku, Fabrizio Paganelli, Elena Spini and
  Sabatino Rinaldi, explicitly to avoid consuming envelopes: _"evitando firme
  superflue che consumerebbero buste inutilmente."_
- **An automatic redirect to the signature page** on renewal is owed by Aurel
  Mrruku as a next step, bypassing DocuSign.

⚠ That summary table is a customer-facing commercial document and
[OI-207](../items/OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md)
records that it is missing the list price, quantity, unit of measure, line
discount and net price the same session required on every document.

🟢 Envelope cost is no longer the constraint it looked like: the client holds
2,500 a year ([OI-111](../items/OI-111%20DocuSign%20licences%20are%20not%20confirmed%20with%20the%20client.md)).
