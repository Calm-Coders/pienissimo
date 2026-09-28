---
id: OI-144
type: open-item
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-21
updated: 2026-09-22
depends_on: [OI-143]
blocks: [go-live]
requirement: [ORD-02]
source: notes/meetings/2026-09-21 Interna Temi Mexal.md
resolution_source: notes/meetings/2026-09-22 Logiche Spacchettamento Righe.md
---

# OI-144 - Bundles must be split into order lines for Mexal

A direct consequence of
[OI-143](OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md),
established at
[the 21/09 Mexal internal](../meetings/2026-09-21%20Interna%20Temi%20Mexal.md).

## The problem

A bundle is one product that parents n products, and the standing ruling is that
it is **transmitted to Mexal as a single element — one order line**. But the
tranche due date lives **on the order line**. One line cannot carry n tranche
dates.

Aurel Mrruku: _"se mi fanno passare solo una riga, come cavolo farò io a passare
la data di scadenza a loro?"_ The same holds for Performance Plus: one product,
x instalments.

## What he decided to do

Split them. He had reached this over the weekend and opened the call with it:

> _"anche i bundle sono costretto a separarli, quindi devo cambiare un attimo il
> modo in cui si calcola la somma totale nei bundle"_

and confirmed the fallback during the call: _"se per i bundle per qualche motivo
vogliono poi mandare tutti gli item del bundle come singolo item, lo gestisco
anche in quel modo là."_

## Why it matters

- ⚠ **It contradicts the standing ruling** that a bundle reaches Mexal as one
  element. That ruling is in the record as the reason the bundle is modelled as a
  single sellable product.
- 🔴 **It changes how a bundle total is computed**, by his own statement. Nothing
  in the record describes the new calculation, and no commit yet implements it.
- ⚠ It interacts with the bundle-mix constraint built on 17/09
  ([OI-140](OI-140%20Three%20Opportunity%20record%20types.md)), which enforces
  one Bundle **or** Item products on a quote and never both — a rule about the
  quote, where this is a rule about the outbound order payload.
- 🔴 **Nobody outside ROMI has been asked.** Whether Mexal will accept n lines for
  what the catalogue calls one article, and what that does to the warehouse
  movements Fabrizio Paganelli cares about
  ([OI-155](OI-155%20San%20Marino%20revenue%20split%20and%20warehouse%20causale.md)),
  is unestablished. The 22/09 session with Mirko Merendi is where to ask.

## Open

- 🔴 Confirm with Mirko Merendi that n lines per bundle is acceptable on the Mexal
  side, and what it does to the accounting movements.
- 🔴 Record the new bundle-total calculation before it is built.
- ⚠ Reconcile with the single-element ruling, citing both dates.

## 🟢 RESOLVED 2026-09-22 — the client confirmed it, and it was never in doubt for them

At [Logiche Spacchettamento Righe](../meetings/2026-09-22%20Logiche%20Spacchettamento%20Righe.md)
(22/09 11:22 CEST), Fabrizio Paganelli demonstrated a bundle order on Mexal: articles
`A B C D E` as **separate lines**, each with its own due date, and
_"quando da qui passa di là, passa così."_ **Bundles already reach Mexal as their
component articles.** Aurel Mrruku confirmed the design intent in the same exchange —
_"quando facciamo passare l'ordine a Mexal, mandiamo questi n prodotti che compongono
il bundle, vero?"_ — and Fabrizio Paganelli: _"Sì."_

🟢 **And the bundle-total question is answered.** The total is spread over the
components **weighted by listino value and quantity**, with a **manual per-line
override**. Fabrizio Paganelli's own use case: zero a free event inside the bundle and
push the difference onto the other lines. He declined anything cleverer —
_"una volta che tu mi fai la regola che mi spalma il valore totale del bundle in modo
ponderato rispetto al valore di listino, io sono a posto. L'importante è che poi… sia
modificabile manualmente"_ — noting that bundles are built by administration
_"8-10 volte all'anno"_. Aurel Mrruku, who had feared a spreading algorithm:
_"per me è tutto chiaro."_

⚠ **So the "contradicts the standing ruling" concern above was a misreading of the
ruling**, not a real conflict: a bundle is one *sellable product* in Salesforce and
n *order lines* outbound. Both are true at once.

## What remains, and it is build work not design

- 🔴 **No `PricebookEntry` is created for a bundle product** — found at
  [the 17:00 pre-UAT session](../meetings/2026-09-22%20Test%20Interni%20Pre-UAT%20Parte%202.md);
  Aurel Mrruku: _"I have missed this one"_, and he will automate it. Without it a quote
  cannot price the bundle.
- 🔴 The bundle header must carry **`totale bundle` and `totale listino prodotti`**;
  the components carry prezzo listino, prezzo unitario and **prezzo manuale**; the
  parent price is hidden from the client.
- ⚠ A filter currently **prevents adding the same product twice** to a bundle, to be
  lifted — in practice a line is sometimes repeated at price zero.
- ⚠ Selecting a second bundle **silently replaces the first**.
- ⚠ **Mirko Merendi was not asked** whether n lines per bundle article disturbs the
  warehouse movements — the topic did not come up at
  [Test Mexal](../meetings/2026-09-22%20Test%20Mexal.md). It is adjacent to
  [OI-155](OI-155%20San%20Marino%20revenue%20split%20and%20warehouse%20causale.md),
  whose mechanism that session did name: contropartita di riga plus tipo merce.
