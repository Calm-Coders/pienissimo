---
id: decision-woocommerce-plus-orders-are-acceptances
type: decision
status: resolved
owner: Aurel Mrruku
with: Elena Spini, Fabrizio Mastracci
org: ROMI
raised: 2026-11-10
updated: 2026-11-12
depends_on: []
blocks: []
source: notes/meetings/2026-11-10 Follow-up Interno.md
---

# Decision - WooCommerce plus orders are acceptances

**Every `plus` order arriving from WooCommerce is treated as an acceptance, never
as a new sale, because they are stage orders. That flag is the switch that decides
whether the contract chain runs at all.**

## The mechanism it controls

On a `plus` opportunity the quote carries a choice:

| Value | Behaviour |
| --- | --- |
| `Plus di nuovo` | 🔴 **no PDF, no contract** — the chain does not run |
| `Plus accettazione` | 🟢 generates the PDF and runs the contract chain |

Aurel Mrruku, on the
[10/11 follow-up](../meetings/2026-11-10%20Follow-up%20Interno.md): _"plus di nuovo
non genera il PDF, non genera il contratto; plus accettazione lo genera, fa il
flusso."_

## The decision

> _"Quando ci arrivano gli ordini plus da W\[oo\]commerce c'e la categorizzazione
> plus rinnovo / plus accettazione. **Io gli ho detto in teoria sono tutti
> accettazioni, non sono nuovi perche sono ordini da palco.**"_ — Aurel Mrruku

Elena Spini confirmed: _"Si, mi torna … anche perche **il rinnovo poi lo gestisce
il tutor**."_

He had asked Fabrizio Mastracci first and was seeking Elena Spini's confirmation —
_"Volevo una conferma da parte tua"_ — so the decision is ROMI-internal.

## Status and caveats

- ⚠ **Internal, not confirmed by the client**, and not verified in the org by this
  run. It bears directly on the stage sale contract work, which is release R0 and
  already in development
  ([the decision](Decision%20-%20stage%20sale%20contracts%20are%20release%20R0%20of%20Fase%202.md),
  [the analysis](../The%20stage%20sale%20contract%20functional%20analysis.md)).
- 🔑 It sits beside, and must not be confused with,
  [Performance Plus Rinnovo bypasses conditions and signature](Decision%20-%20Performance%20Plus%20Rinnovo%20bypasses%20conditions%20and%20signature.md),
  which is about the renewal path inside Salesforce. This decision is about what
  the **WooCommerce payload's** plus categorisation maps to.
- See [the WooCommerce payload contract](../The%20WooCommerce%20payload%20contract.md).
