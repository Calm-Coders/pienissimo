---
id: OI-236
type: open-item
status: open
owner: Elisa Migliano
with: Mirko Merendi
org: both
raised: 2026-10-14
updated: 2026-10-14
depends_on: [OI-145]
source: notes/meetings/2026-10-14 UAT Test e2e.md
---

# OI-236 - The Mexal order carries no tipo merce and no provvigioni percentage

**Looking at the order Salesforce had just sent — `OC 1023`, €20,000 — Elisa
Migliano found the tipo merce and the commission percentage absent, and took it
on herself to report both to Mirko Merendi.**

## What the record says

[The 14/10 e2e](../meetings/2026-10-14%20UAT%20Test%20e2e.md) (`01:04:04`,
`01:05:26`): she

> _"individua l'ordine OC 1023 su Maxal per un importo di 20.000 € e rileva
> l'assenza del tipo merce e della percentuale delle provvisioni"_

and decided to flag the gaps to Mirko Merendi while fixing the order up for
invoicing in the meantime. The next step reads:

> **\[Elisa Migliano\] Segnalare dati mancanti:** _Comunicare a Mirko la mancanza
> del tipo merce e della percentuale delle provvisioni negli ordini._

## Why this is the third instance of one pattern

🔑 **The Mexal order tracciato is missing commercial data for the third time, and
each time the answer has been to ask Mirko Merendi.**

| Missing on the order | Raised by | Row |
| --- | --- | --- |
| list price, discount, net amount | Fabrizio Paganelli, 18/09 then 09/10 then 13/10 | [OI-145](OI-145%20Order%20header%20discounts%20are%20removed.md) |
| commercial fields on the layouts | ROMI | [OI-207](OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md) |
| tipo merce, provvigioni % | Elisa Migliano, 14/10 | this row |

⚠ **Whether these are fields Salesforce fails to send or fields the tracciato
does not have is not established here.** OI-145 settled that question for the
price breakdown — _"non ci sono i campi per prezzo di listino eccetera sui campi
che ha fornito Mirko"_ — and the same may hold for these two. Nobody checked the
tracciato in the session.

🔴 **Provvigioni are agent commission.** The agent is now frozen on the quote
(`Quote.Codice_Agente_Esterno__c`,
[OI-214](OI-214%20The%20Mexal%20order%20send%20requires%20an%20agent%20code%20WooCommerce%20orders%20lack.md)),
so Salesforce knows which agent earns on the order while the order Mexal
receives carries no rate. ⚠ **No source states where the commission rate is
meant to live** — on the agent, the product, or the order.

## What closing it looks like

Mirko Merendi says whether the order tracciato can carry tipo merce and the
commission percentage; if it can, the mapping is agreed and built; if it cannot,
a ruling on where commissions are computed instead. **It should go to him with
OI-145's ask, not separately** — three separate approaches to the same person
about the same tracciato is how the first one sat for a month.
