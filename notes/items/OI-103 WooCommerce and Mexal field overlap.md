---
id: OI-103
type: open-item
status: open
owner: Andrea Di Cicco
org: ROMI
raised: 2026-08-27
updated: 2026-08-27
depends_on: [OI-98, OI-99]
uncertain: no owner was assigned in session
source: meetings/2026-08-27-integrazione-woocommerce-transcript.it.md
---

# OI-103 - WooCommerce and Mexal field overlap

**Andrea Di Cicco raised it early in the
[27 August design session](../meetings/2026-08-27%20Integrazione%20WooCommerce.md)
and nobody picked it up.**

> _"il punto è che noi abbiamo l'integrazione con e-commerce e poi l'integrazione
> con Mexal, quindi poi dovremmo fare un attimo il un merge di quelle che sono
> le informazioni che arrivano da WooCommerce, quelle che arrivano su Mexal onde
> evitare di creare 12.000 campi e ridurre il numero di campi."_

Two inbound integrations carry **overlapping descriptions of the same customer
and the same order**, and they are being specified separately, weeks apart, by
different people:

|          | WooCommerce                                                                                    | Mexal                                                                                                                                       |
| -------- | ---------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| Customer | nome, ragione sociale, partita IVA — and a **second, duplicated copy** in the Funnel Kit shape | full anagrafica clienti, plus `tipo nazionalità` fiscal residence ([OI-97](OI-97%20Fiscal%20residence%20on%20the%20customer%20registry.md)) |
| Order    | order key, totals, traffic source                                                              | serie, numero, righe, scadenziario                                                                                                          |
| Line     | `SC` product code, name, qty, subtotal, total                                                  | article code, natura, categoria statistica, gruppo merceologico                                                                             |

Left alone, each side lands its own field on the same Salesforce object. The
concrete risk Andrea Di Cicco named is field sprawl on Account, Order and
OrderItem; the quieter one is **two fields holding the same fact and disagreeing**
— which the project has already hit once, on the customer block **inside a
single payload**
([the flow note](../flows/The%20WooCommerce%20order%20integration.md)).

## State

🔴 **Open, and no owner was assigned.** It appears in neither session's next
steps and in neither Gemini decision list. Owner is set to Andrea Di Cicco here
because he raised it and owns the Mexal side; **that is this note's inference,
not a decision anyone took.**

## Why it cannot wait long

- Both payloads are now concrete. The WooCommerce one was demonstrated on
  27 August; the Mexal one was exercised live on 26 August, with Andrea Di
  Cicco creating a real customer and order against production.
- 🔴 The Mexal article registry is being **closed and re-created** —
  [OI-98](OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md)
  — and the WooCommerce line's `SC` code is drawn from that same registry. A
  merge decided after the re-creation is a merge decided twice.
- The **2 September** customer-registry session
  ([OI-99](OI-99%20Customer%20registry%20deep%20mapping%20session.md)) is the
  natural forum for the customer half, and its agenda is currently titled for
  the article registry only.
- Fase 1 development ends **10 September**.

## What settling it looks like

A single mapping table, per object, saying which source owns which Salesforce
field and which of the two is discarded — the WooCommerce equivalent of
[the Mexal integration mapping workbook](../The%20Mexal%20integration%20mapping%20workbook.md).
