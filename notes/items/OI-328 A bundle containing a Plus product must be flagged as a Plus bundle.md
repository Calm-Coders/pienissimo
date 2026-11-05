---
id: OI-328
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-11-03
updated: 2026-11-03
depends_on: [OI-304]
blocks: [OI-326]
source: notes/meetings/2026-11-03 Follow-up Interno.md
---

# OI-328 - A bundle containing a Plus product must be flagged as a Plus bundle

**R0 has to send a different contract template, and create a Contract record, when
the order is a Performance Plus order. Nothing on the order says so today. Aurel
Mrruku will derive it automatically from the bundle's contents, and it means touching
the existing bundle logic.**

## The requirement

In [the 3 November internal follow-up](../meetings/2026-11-03%20Follow-up%20Interno.md),
working out how the flow would choose a template, Aurel Mrruku ruled out the easy
routes:

> **Elena Spini:** _"c'è nel titolo, c'è proprio il nome del template"_
> **Aurel Mrruku:** _"No, non puoi fare sul testo libero."_ … _"quello sì, ma **come
> capisci che è un ordine plus o un ordine semplice?**"_

The answer:

> _"Dobbiamo dire che il bundle è un bundle plus, quindi **se un bundle ha un prodotto
> plus, allora è un bundle plus**."_

> _"**Lo metto in automatico, non dico manco di farlo.** Se aggiunge un prodotto plus
> diventa un bundle plus."_

🔑 **Deliberately not a client task.** Elena Spini suggested Fabrizio Paganelli could
set it when building the bundle; Aurel Mrruku chose to derive it instead, so it cannot
be forgotten or set wrong.

## ⚠ It reaches into existing code

> _"devo mettere anche mano su la [logica] del bundle"_

🔴 **That is the bundle assignment logic already live in production**, not new code
beside it. See [How bundleProductAssignment works](../How%20bundleProductAssignment%20works.md).

🟢 **The domain rule it rests on is firm**: there are no mixed bundles — _"in un bundle
c'è solo la P+ … oppure ci sono solo i corsi, non facciamo bundle misti"_ (2 November,
Fabrizio Paganelli), restated as **RF5** in the delivered analysis. So "contains a
Plus product" is unambiguous.

## Why it is open

1. 🔴 **Nothing is built**, and it is a prerequisite for choosing between the two
   templates of [OI-326](OI-326%20A%20second%20PDF%20template%20is%20needed%20for%20corsi%20and%20for%20Plus.md)
   and for creating the Plus Contract record of **RF7**.
2. 🔴 **It is absent from [the functional analysis](../The%20stage%20sale%20contract%20functional%20analysis.md)**
   the client received, which states RF7 as an outcome without saying how the order is
   classified.
3. 🔑 **It is inside the 6-7 day R0 estimate** along with the new template, the
   DocuSign rewiring and the signature status.
4. ⚠ **Where the flag lives is unstated** — a field on the bundle, on the order, or
   derived at runtime. Aurel Mrruku said only that it would be automatic.
5. ⚠ **The twelve bundle-only Plus codes carry a `Bundle` flag already**
   ([OI-48](OI-48%20Bundle-only%20article%20codes.md)); whether that flag is what the
   derivation should read was not discussed.
