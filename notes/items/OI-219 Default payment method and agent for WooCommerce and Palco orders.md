---
id: OI-219
type: open-item
status: open
owner: Aurel Mrruku
with: Elisa Migliano
org: both
raised: 2026-10-07
updated: 2026-10-07
blocks: [OI-214, go-live]
source: notes/meetings/2026-10-07 UAT Integrazione WooCommerce e Mexal.md
---

# OI-219 - Default payment method and agent for WooCommerce and Palco orders

**The 07/10 session mapped the WooCommerce payment methods onto Mexal codes but
deferred the default for bundles, pending formal proposals from Aurel Mrruku and
Elisa Migliano. The mapping table itself is still unwritten, and the equivalent
default for orders arriving from Palco is undefined.**

## What was settled

`Concordato` at [the WooCommerce session](../meetings/2026-10-07%20UAT%20Integrazione%20WooCommerce%20e%20Mexal.md):

| WooCommerce payment | Mexal code | Meaning |
| ------------------- | ---------- | ------- |
| Credit card, PayPal (through BrainTree) | `2` | rimessa diretta |
| Bank transfer | `12` | bonifico data fattura |

Fabrizio Paganelli and Elisa Migliano also named **`20`** for _bonifico fine
mese data fattura_, and later Fabrizio Paganelli raised **`64`** for fine-mese or
RID inside bundles. `12` is the code adopted for the WooCommerce tests
specifically, not a general rule.

## What was deferred

`Da approfondire`, in the session's own words: _"L'adozione di un metodo di
pagamento predefinito per i bundle è stata rinviata in attesa di proposte
formali da parte di Aurel ed Elisa."_

Open with it:

- **The mapping table is Aurel Mrruku's to write**, from the results of the card
  and PayPal tests Sabatino Rinaldi still owes.
- **The default agent and payment method for Palco orders** are a single next
  step assigned to Aurel Mrruku, undefined at the end of the session.
- **Where in each flow the values get set** is the question Aurel Mrruku himself
  posed — he and Elisa Migliano agreed to analyse the order and payment fields
  and propose configurations.
- Fabrizio Paganelli's framing was **protective**: critical information such as
  the payment method must not be freely alterable by agents, so he proposed
  mandatory fields or defaults. That ties this item to the field lock in
  [OI-209](OI-209%20Mexal%20anagrafica%20updates%20only%20propagate%20when%20an%20order%20is%20sent.md).

## What closing it looks like

A written mapping of every channel's payment methods to Mexal codes, a named
default for bundles and for Palco, the point in each flow where the value is
applied, and the fields protected from arbitrary edits — all agreed with Elisa
Migliano and Fabrizio Paganelli rather than inferred from the test run.
