---
id: OI-304
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-30
updated: 2026-10-30
depends_on: []
blocks: [go-live]
severity: gating
source: notes/meetings/2026-10-30 Connessione WooCommerce.md
---

# OI-304 - Contracts for WooCommerce stage sales are not generated

**Customers who buy during a live event order through WooCommerce, and no contract
is produced for them. The existing flows do not generate a paper contract for a
WooCommerce order, and what should be generated depends on what is in the bundle.
The question was too large for the call that raised it and has its own meeting on
2 November.**

## The gap

Fabrizio Paganelli, in [the 30 October WooCommerce call](../meetings/2026-10-30%20Connessione%20WooCommerce.md):
the **paper contract is not automatically generated** for orders placed by
customers buying at live events. Aurel Mrruku confirmed that **the current flows
provide no automatic paper-contract generation for WooCommerce orders at all**,
and that solving it needs a mechanism keyed on **the bundle content** and on **the
order having been sent to Mexal**.

🔑 **These are stage sales — _vendite da palco_.** The customer has already paid
when the order arrives, which is what forces the next decision.

## The decision taken: no signature before the order

> _"L'adozione dello standard per cui i contratti generati da ordini WooCommerce
> **non richiedono la firma digitale preventiva** all'invio dell'ordine, ma
> prevedono **un flag di stato e una reportistica dedicata** per sollecitarne la
> firma."_

Fabrizio Paganelli's ground: the contracts run to **about €20,000**, and customers
buy **on impulse during classroom courses**, so holding the WooCommerce order until
a signature arrives is impracticable. Aurel Mrruku agreed.

🔑 **Two mechanisms are therefore owed and neither exists**: a **status flag** for
whether the contract has been signed, and a **report** to chase the unsigned ones.
⚠ **Neither has a field name, an owner for the report, or a chasing cadence.**

🔑 **Send order, then contract.** Aurel Mrruku and Fabrizio Paganelli agreed the
contract goes to the customer **after** the order reaches Mexal, independently of
minor problems, because the stage customer has already paid.

## Why it is open

1. 🔴 **The generation logic is undefined.** It has to distinguish bundle types —
   annual courses against **Performance Plus** — and that is the whole subject of
   the deferred meeting.
2. ⚠ **A Performance Plus mechanic was named and not pursued.** Aurel Mrruku said
   that generating one line per tranche is **not native to standard bundles** and
   needs specific logic for Performance Plus and its decomposition into multiple
   lines. **Whether that logic already exists was not established** in the call.
3. 🔴 **Unsigned high-value contracts become a standing population at go-live.**
   The decision accepts orders without signatures; without the flag and the report,
   nothing tracks them. **€20,000 a contract.**
4. ⚠ **Paper and electronic are both in scope and not separated.** The next step is
   recorded as defining _"il flusso di generazione e invio dei contratti cartacei e
   informatici"_.
5. ⚠ **No register row covers contract generation for WooCommerce orders.**

## The meeting that owns it

**Monday 2 November 09:30–10:00 CET**, `[ROMI-PIENISSIMO] - Tema Contratti
WooCommerce` — Aurel Mrruku, Elena Spini, Fabrizio Paganelli,
`amministrazione@pienissimo.com` (Gmail `1a18d667b2ed2313`). Scope set by Aurel
Mrruku in Slack at 16:18:30 CET: _"tema contratti per gli ordini da woocomerce (
cntratti cartacei"_.

⚠ **It collides with a second 09:30 invite the same morning** —
`[ROMI-PIENISSIMO] - Allineamento` with Fabrizio Mastracci (Gmail
`1a18d64b1236ad5d`). Both were sent by Elena Spini within two minutes. **Nothing
says which Aurel Mrruku attends.**
