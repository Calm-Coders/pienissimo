---
id: OI-312
type: open-item
status: open
owner: Fabrizio Paganelli
with: Andrea
org: both
raised: 2026-11-03
updated: 2026-11-03
depends_on: []
blocks: [go-live]
severity: gating
source: notes/meetings/2026-11-03 Test e2e PROD.md
---

# OI-312 - Anticipay times out in production

**The Anticipay P.IVA call does not answer in the production org. It waits 120
seconds and times out. Anticipay had told ROMI in writing that production was ready.
The first end-to-end production test had to continue without it.**

## What happened

In [the 3 November e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md) Aurel
Mrruku created a test account in production and triggered the Anticipay lookup. It
returned nothing: _"non va. va in time out praticamente"_. The connector's wait is
**120 seconds**.

🔑 **Anticipay said production was fine.** Elena Spini re-read Andrea's mail live:
_"ha detto confermo, tutto ok, portate direttamente in produzione. Lui stesso non ci
aveva dato nient'altro."_ Fabrizio Paganelli's reading: _"si vede che hanno fatto
qualche cosa e si sono dimenticati."_

🔑 **The endpoints are Anticipay's to supply.** Aurel Mrruku corrected Elena Spini
explicitly: _"non è che diamo noi i puntamenti. Noi facciamo la chiamata verso di
loro. Sono loro che danno i puntamenti."_ So this is not a ROMI configuration item.

## Who owns it

**Fabrizio Paganelli phoned Andrea during the call.** Andrea would look at it
afterwards, not then: _"ci guardo io, dai, dopo, però non adesso"_. ⚠ **No deadline
was given and no update had arrived by the end of the day.**

## Why it matters now

1. 🔴 **It blocks the remaining production tests on any new account.** The decision on
   the call was to proceed with an existing good customer instead.
2. 🔑 **It is the long-standing question answered the wrong way.** _"Whether Anticipay
   answers in production"_ has been carried as unreachable for weeks. **It does
   not.**
3. 🔑 **It does not block an order.** By design a failure is not fatal — _"un errore
   di Anticipay non blocca l'invio"_ — so the go-live is not gated on it, but the
   data enrichment silently does not happen.
4. ⚠ **It interacts with the R0 contract flow.** [The functional analysis](../The%20stage%20sale%20contract%20functional%20analysis.md)
   records, as _"Dedotto, da confermare"_, that a failed P.IVA check still lets the
   order reach Mexal and the contract be generated. **With Anticipay timing out in
   production, that is the normal path, not the edge case.**

## 🔑 What Anticipay actually does, recorded for the first time

Aurel Mrruku, pressed by Elena Spini: it is **not a validation**. _"L'Anticipay non
ti fa un controllo, fa una chiamata e ha una risposta, prende il risultato della
risposta e lo mette su dei campi."_ A result comes back only for an **Italian** P.IVA
that Anticipay can find; for anything else _"fallisce sempre"_. It runs **only on an
account's first order**, and only when the account has no Mexal code and no
consolidated Anticipay flag.

⚠ **So a wrong-but-Italian P.IVA cannot be detected**, which is the limit case Elena
Spini raised and nobody answered: the order reaches Mexal and the contract goes out
with the wrong number. _"È un caso limite, però devono saperlo."_

⚠ **Aurel Mrruku speculated Pienissimo may already check Anticipay on the WooCommerce
side.** Not established.

## Related

- [The Anticipay middleware API contract](../The%20Anticipay%20middleware%20API%20contract.md)
