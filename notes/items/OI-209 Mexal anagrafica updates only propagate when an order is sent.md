---
id: OI-209
type: open-item
status: open
owner: Aurel Mrruku
with: Kreosoft
org: both
raised: 2026-10-05
updated: 2026-10-05
depends_on: [OI-58, OI-112]
source: notes/meetings/2026-10-05 UAT Performance Plus e Gestione date pagamento.md
---

# OI-209 - Mexal anagrafica updates only propagate when an order is sent

**Fabrizio Paganelli raised at the 05/10 client UAT that a correction to a
customer's registry data in Salesforce reaches Mexal only when an order is
transmitted, so a fix made on one side alone leaves the two systems
divergent.** The session deferred it to a technical call with Mirko Merendi.

Aurel Mrruku had just demonstrated the automation that derives fiscal
residence, the two- and three-letter country codes, the description and the VAT
sezionale from the billing address — so the newly computed values are exactly
the ones at risk of never arriving. Fabrizio Paganelli then widened it to
anomalies from data entered wrongly by customers or by operators.

The agreed next step, from the session's `Da approfondire`:

> _"La gestione della sincronizzazione e dell'aggiornamento notturno degli
> indirizzi e delle anagrafiche tra Salesforce e Mexal è stata rimandata a un
> confronto tecnico successivo con Mirko."_

## 🔑 The client's own workbook already specifies it

[The Campi Oggetti workbook](../The%20Campi%20Oggetti%20Flussi%20e%20Utenti%20workbook.md)
has carried both legs in its `Flussi - elenco` sheet since July — they are the
only two rows that sheet has ever had filled:

| # | Flow | From | To | Object | Mode | Operation |
| --- | --- | --- | --- | --- | --- | --- |
| `F-1` | upsert anagrafiche | sfdc | erp cliente | account | realtime | update+insert, returns the ERP id — _"scatta alla prima opty won"_ |
| `F-2` | update | erp cliente | sfdc | account | **batch notturno** | update — _"ogni notte aggiorniamo le anagrafiche sfdc sulla base delle modifiche fatte su erp"_ |

🔴 **`F-2` is the nightly alignment the room decided to go and ask Mirko
Merendi about.** It was specified by the client, in the client's own document,
three months ago. This is the third instance of the same pattern in four days,
after `Data invio automatico biglietti` and the commercial quote fields in
[OI-207](OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md).

⚠ `F-1` is also narrower than what is built: it fires _"alla prima opty won"_,
whereas the behaviour Fabrizio Paganelli described is a send on every order.

## State

- No nightly Account read from Mexal exists. The 24/09 data jobs created
  **zero** Mexal customer-update queueables, and no new job has appeared since.
- 🔴 It compounds
  [the Mexal write risk](../risks/Risk%20-%20Mexal%20writes%20fail%20after%20their%20own%20log%20insert.md):
  the shipping address write already cannot complete, so even the
  order-triggered propagation is not reliable today.
- Unresolved: which system wins on a conflict, whether the nightly read
  overwrites a Salesforce-side correction, and who owns the exception queue —
  the same unassigned operational duty
  [OI-200](OI-200%20The%20client%20was%20asked%20to%20confirm%20logics%20whose%20open%20points%20were%20removed.md)
  and [OI-202](OI-202%20Anticipay%20does%20not%20recognise%20sole%20traders%20absent%20from%20the%20registro%20imprese.md)
  both record.

Due at `[ROMI-PIENISSIMO] - Temi Integrazione Mexal`, **Wed 07/10 12:15**.
